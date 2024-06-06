Return-Path: <linux-kernel+bounces-205146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04DA8FF806
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D344F1C242B0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2238C13E03C;
	Thu,  6 Jun 2024 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsT53hOn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666D73451
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715883; cv=none; b=DxUvgfI8CJbCWDCw/U7852vTuClVSYS/+Cs8pa+YvYU8D5o4g/sPxKaq7RlhMCh6v7NMMCboBd4miV+hb2LqHzPuBka7vnl2jqu7etg/hdXgyRK6Vz1k6OmVOrBMZmdZJec8cE8m+yeY02k3PeZYvhCwRkb4xZGs8+spwrI8IC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715883; c=relaxed/simple;
	bh=19XaacNp8Kcu5Ti2DS4m8MBq16yvs29OoTKcO5yHFZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ro0EXeTybfWDMpOJXYuoQoDpphgs5Hyglb1NZGRPQz/sFkqtZyVn7Lszc35oVVknp+7tTv9MO/9g/BSu0vB/BsKOYdba23O8bPGaZDkdHLccfS8Sk4o+vIaxB/s+coJfanQ12DA1wx5Iv6dOcFry3Ov/9Hwvy6naOozNqcxDPIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DsT53hOn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ee5f3123d8so28155ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 16:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717715881; x=1718320681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l8SdZWscT50XIJXXqQu2Ls5LcDQtk8S/Jn0vt/xS74=;
        b=DsT53hOnkDHKVm85WY+FXC1BWLs4SGxZHsdbGq8o+qsbdixiN/CdxZM9kbGq0v9JeU
         agmF+xPit7YMhDl+eWxdN9DAeyTTrz99P+oHve7muk8rsiJl4UmRQ+/1fcS13nMTKNm3
         RvoWT5pGb/t17ZJvvtnGow8PaYypMHSBFmlyPgfP1t/+6B+hcQrGIDnvnhwf16VXj9AQ
         KTajIs9f813hH+ftutYnwGMubsfcERbozB6UVhtsewLWCoEXG9T5aYXc9R3/qUsZzCm6
         sT9SRWYkK7ip0b8sGE9rqP1CdI1PwiHt8ewoc6JTLmrCLH9x2JaUjzmVCgLHxRmWn8du
         jR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715881; x=1718320681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l8SdZWscT50XIJXXqQu2Ls5LcDQtk8S/Jn0vt/xS74=;
        b=enrWCPcYWXiyHJy55stJLo1vplikA0Bq3Pz5K69ya43EsQjEnhE+3y/1q8J7aSEOcM
         CVZcemh9TUUgu/jKkZQwoM/CegL+pRCM1VqRTh/hEYAsLqdfMvOO66RrBDImND0V9dhW
         QsQ+B1IG5R7ZXwMv99aaWT5kTP4ouzDxo2roDY+NPoaLbYJUx+07sbYI52AoozumLfci
         r6ntPlwbw7vb0zrW0mL4UT4OQe7dIHaO0wezBduHsqyOHbP7onjXxWuGyGMDo/UT/ter
         8s0Pf+VTtkaLl8srL6xWuks33ZCG0eoygxm+BLAL8rJtY0dtDrO+9gn7qlbpOL6gPhJK
         asKg==
X-Forwarded-Encrypted: i=1; AJvYcCX6CywXAM5q0Pkry1QKYpolZ0eAMcHAlmPPz6JNwYwPz4s7TXtDcojTOWOAMZC2BRCRpIGdauFT2ejJpp2QwFguDq3/Vn/nNv9stsLq
X-Gm-Message-State: AOJu0YwVvnbwXpKx39hY3qmXFE07kvND5+SDzmAdlOBryMcIC6HsivpY
	X+UapOzcR43kUZc7zPZGGMj7MNcB75wxlNF3HwnJV9xPDSbjzhNy+Ll0Nmy5r4o9HkO/EOXo45R
	D9qfUqJPkHNZx5OeYKdluFnjXGmbkUpjt1ORz
X-Google-Smtp-Source: AGHT+IH/xutXin8rqxWXABdip1JdHkR2hPTycF2hrEcY74OusUk2w+OhuEuyNKB3wiyM50A4wOlHuBU9pnXbR9oSs0U=
X-Received: by 2002:a17:902:dac2:b0:1f6:7fce:5684 with SMTP id
 d9443c01a7336-1f6bd339c13mr4741225ad.3.1717715875849; Thu, 06 Jun 2024
 16:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23879991.0LEYPuXRzz@milian-workstation> <Zl8bhWfHSXxs35r2@x1>
 <Zl8g1LxRCYgTSxhy@x1> <CAP-5=fVJRr2Qgf88ugEJ2FGerzKNv_dD6XOT_dSuFyYp2ubwSw@mail.gmail.com>
 <Zl9ksOlHJHnKM70p@x1> <ZmI2Gumx5yUwyFsT@google.com>
In-Reply-To: <ZmI2Gumx5yUwyFsT@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Jun 2024 16:17:43 -0700
Message-ID: <CAP-5=fWD+PPCVCvyBFfd3vZzUajM0HAEWzJe8XmB9p_bfT4ATQ@mail.gmail.com>
Subject: Re: perf 6.9-1 (archlinux) crashes during recording of cycles + raw_syscalls
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, 
	linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Arnaldo Carvalho de Melo <acme@kenel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Tue, Jun 04, 2024 at 04:02:08PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Jun 04, 2024 at 11:48:09AM -0700, Ian Rogers wrote:
> > > On Tue, Jun 4, 2024 at 7:12=E2=80=AFAM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > > Can you please try with the attached and perhaps provide your Teste=
d-by?
> >
> > > > From ab355e2c6b4cf641a9fff7af38059cf69ac712d5 Mon Sep 17 00:00:00 2=
001
> > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > Date: Tue, 4 Jun 2024 11:00:22 -0300
> > > > Subject: [PATCH 1/1] Revert "perf record: Reduce memory for recordi=
ng
> > > >  PERF_RECORD_LOST_SAMPLES event"
> >
> > > > This reverts commit 7d1405c71df21f6c394b8a885aa8a133f749fa22.
> >
> > > I think we should try to fight back reverts when possible. Reverts ar=
e
> > > removing something somebody poured time and attention into. When a
> >
> > While in the development phase, yeah, but when we find a regression and
> > the revert makes it go away, that is the way to go.
> >
> > The person who poured time on the development gets notified and can
> > decide if/when to try again.
> >
> > Millian had to pour time to figure out why something stopped working,
> > was kind enough to provide the output from multiple tools to help in
> > fixing the problem and I had to do the bisect to figure out when the
> > problem happened and to check if reverting it we would have the tool
> > working again.
> >
> > If we try to fix this for v6.10 we may end up adding yet another bug, s=
o
> > the safe thing to do at this point is to do the revert.
> >
> > We can try improving this once again for v6.11.
>
> I think I found a couple of problems with this issue. :(
>
>  1. perf_session__set_id_hdr_size() uses the first evsel in the session
>     But I think it should pick the tracking event.  I guess we assume
>     all events have the same set of sample_type wrt the sample_id_all
>     but I'm not sure if it's correct.
>
>  2. With --call-graph dwarf, it seems to set unrelated sample type bits
>     in the attr like ADDR and DATA_SRC.
>
>  3. For tracepoint events, evsel__newtp_idx() sets a couple of sample
>     type regardless of the configuration.  This includes RAW, TIME and
>     CPU.  This one changes the format of the id headers.
>
>  4. PERF_RECORD_LOST_SAMPLES is for the sampling event, so it should
>     use the event's sample_type.  But the event parsing looks up the
>     event using evlist->is_pos which is set for the first event.
>
>  5. I think we can remove some sample type (i.e. TID and CPU) from the
>     tracking event in most cases.  ID(ENTIFIER) will be used for LOST_
>     SAMPLES and TIME is needed anyway.  TID is might be used for SWITCH
>     but others already contain necessary information in the type.  I
>     wish we could add id field to PERF_RECORD_LOST_SAMPLES and tid/pid
>     to PERF_RECORD_SWITCH.

Right, this is good. To clear up the immediate error we just need to
increase the memory allocation size by 48 bytes to account for the
sample ID being written. Here is a change doing that and removing the
memory allocation altogether:
```
diff --git a/tools/lib/perf/include/perf/event.h
b/tools/lib/perf/include/perf/event.h
index ae64090184d3..a2dfaff26fb7 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -77,6 +77,8 @@ struct perf_record_lost_samples {
       __u64                    lost;
};

+#define PERF_RECORD_MAX_LOST_SAMPLE_AND_ID_SIZE \
+       (sizeof(struct perf_record_lost_samples) + 6 * sizeof(__u64))
/*
 * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID | PERF_FORMAT=
_LOST
 */
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 66a3de8ac661..1615a1723fb9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1926,7 +1926,10 @@ static void __record__save_lost_samples(struct
record *rec, struct evsel *evs
el,
static void record__read_lost_samples(struct record *rec)
{
       struct perf_session *session =3D rec->session;
-       struct perf_record_lost_samples *lost =3D NULL;
+       union {
+               struct perf_record_lost_samples lost;
+               char
lost_and_sample_id[PERF_RECORD_MAX_LOST_SAMPLE_AND_ID_SIZE];
+       } lost;
       struct evsel *evsel;

       /* there was an error during record__open */
@@ -1951,20 +1954,13 @@ static void record__read_lost_samples(struct
record *rec)

                               if (perf_evsel__read(&evsel->core, x,
y, &count) < 0) {
                                       pr_debug("read LOST count failed\n")=
;
-                                       goto out;
+                                       return;
                               }

                               if (count.lost) {
-                                       if (!lost) {
-                                               lost =3D zalloc(sizeof(*los=
t) +
-
session->machines.host.id_hdr_size);
-                                               if (!lost) {
-
pr_debug("Memory allocation failed\n");
-                                                       return;
-                                               }
-                                               lost->header.type =3D
PERF_RECORD_LOST_SAMPLES;
-                                       }
-
__record__save_lost_samples(rec, evsel, lost,
+                                       memset(&lost, 0, sizeof(lost));
+                                       lost.lost.header.type =3D
PERF_RECORD_LOST_SAMPLES;
+
__record__save_lost_samples(rec, evsel, &lost.lost,
                                                                   x,
y, count.lost, 0);
                               }
                       }
@@ -1972,21 +1968,12 @@ static void record__read_lost_samples(struct
record *rec)

               lost_count =3D perf_bpf_filter__lost_count(evsel);
               if (lost_count) {
-                       if (!lost) {
-                               lost =3D zalloc(sizeof(*lost) +
-
session->machines.host.id_hdr_size);
-                               if (!lost) {
-                                       pr_debug("Memory allocation failed\=
n");
-                                       return;
-                               }
-                               lost->header.type =3D PERF_RECORD_LOST_SAMP=
LES;
-                       }
-                       __record__save_lost_samples(rec, evsel, lost,
0, 0, lost_count,
+                       memset(&lost, 0, sizeof(lost));
+                       lost.lost.header.type =3D PERF_RECORD_LOST_SAMPLES;
+                       __record__save_lost_samples(rec, evsel,
&lost.lost, 0, 0, lost_count,

PERF_RECORD_MISC_LOST_SAMPLES_BPF);
               }
       }
-out:
-       free(lost);
}

static volatile sig_atomic_t workload_exec_errno;
```

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > > regression has occurred then I think we should add the regression cas=
e
> > > as a test.
> >
> > Sure, I thought about that as well, will try and have one shell test
> > with that, referring to this case, for v6.11.
> >
> > - Arnaldo

