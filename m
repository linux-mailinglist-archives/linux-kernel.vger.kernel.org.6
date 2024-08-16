Return-Path: <linux-kernel+bounces-288812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6652C953F09
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE188B24079
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812D42868D;
	Fri, 16 Aug 2024 01:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MS26H0sg"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28540855
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772673; cv=none; b=TVpZYcHLjjdq5PbL3lHuhB2+wsgJJsXm7zthMsAVQGO/7sL75CoZFaST5pU7GSppCR8ZYc2yY+mxn9staaqIrSSyJGXJmHoovjCu4W4TqB08ubV8FDq+hzS7eyZYimwFAxdt5dWoQVcwpPeVnW+a4rtD2GekZ7a/QIbn10n6LsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772673; c=relaxed/simple;
	bh=1dfiGJ4Qk7BRYdV4JK+x/5lvkLf/9dzCkNgb/+E6w8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=i4WQ8QXawz6F53/ss/2YfLtD4JpBNnForyXqphH70gazkLQiOGH5FhUVAGbqx47PdZcEk9CWgkKzZqrxcKUiIKKoXNifi6FdXwOgEm6DbVOCL5eE7Aif+daRQ4dB+dg/5717v/WUxmCgtsTWGrFz/Vb/o0SfpnKkaFkzqF4J420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MS26H0sg; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39d2a107aebso11585ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723772671; x=1724377471; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8twJfhd3sS2HobMeTQcR36OUJZaXUCElEDF81H5IZI0=;
        b=MS26H0sgE+NlgfWQOb8y0KFrA9PSbMn8xCMaRs7ta3PQOaDEOkg2XlTWKwj1EUzEKf
         gEYVSh/v8Mcm+RslwaoGFFgN5QtiPUA9S/CdPWV27qJv6F1Gx2zpiMPPL/J6woHCyV79
         yM9redX9EnVjVEkfzo03HkvybM7rpxAl6qhLLFghRw60YbvNqrmXVb0d3YwbblCx4zjs
         +5H9plPRN948xla46mFfz4HlYx2RWL8m/XMIXcvaeTVkgu4cOnhPhXOYRMEN9t6EXCo4
         Kcjta+klc/wgwXuABWCXy/sSXja7+I80sm5MkEESbO2nxU15f4ywL3E3tCYk6lNy52n3
         A0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723772671; x=1724377471;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8twJfhd3sS2HobMeTQcR36OUJZaXUCElEDF81H5IZI0=;
        b=omd4P08VSkk6s4EavgqEdFH5+UtAIBzBmNcTcPuDqVP2CyxyqPPOH3XFuaFMu4LPao
         S/LnuIu7ZTF7/Z4xbWETkQOcKrnrOqyxywhvD81zSX4B5j9kyPpBitJmlK/1dpyP2HBc
         oGMwx1b6P9YKxc2Lke52FwIfxauRfsAe3vs49luuLLq5jH9eUDfsyHSecj3s/GfAyXa4
         vcey6WX84bDfAl3j3SVsyo9kJ5pNrNOeu9Vm1fIKqWuS9xPh0k3TDnwBu3cE5BxbhKyT
         YBfC68gJQOiUjWxVZP+7wocSJ1si4uYrnUhfgh3MYSyHnbAFdDKINGDqMhQdC4tOUcmJ
         dFgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLhYRQl3srEHrbYfFQEJSTP51PYZCLaXm4uD5TuiLLKmCiM0ll3XpNBsUUeKd8tJMEC46nqOG7oxBItoyX6tB3PmniknR7TLds7p9F
X-Gm-Message-State: AOJu0Yx3pl8/a4mMC1ynxIAFjXGw2FLR3xboyD6hLL0ctIYpqsIxe5Xy
	KP20sY6OJpeMPNs5FIWZ6zzrFKRMdupfV7n4DoJTk9MzsvX/omNzR1cmxW8Y5culsqgGx39AZq9
	QJI7Td77x1q/HiGEW6gx9K8G90I7ZJjAv/nN3
X-Google-Smtp-Source: AGHT+IF+quMNdEKT8lYZYH4gRkbN45Ew4a7Q/13cilnxi7cwwZgdLrISpONk1culVBzv/V10IKuRkyamMvv98+s6Aq8=
X-Received: by 2002:a05:6e02:148c:b0:376:3026:9dfc with SMTP id
 e9e14a558f8ab-39d27a964a2mr1011235ab.24.1723772670803; Thu, 15 Aug 2024
 18:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813043439.933329-1-irogers@google.com>
In-Reply-To: <20240813043439.933329-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 Aug 2024 18:44:19 -0700
Message-ID: <CAP-5=fVvzthsR4G=aT8kTjR6c-xT=HAB9QhVdLR_Lo0LfMcTug@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf build-id: Align records to 8 rather than 64 bytes
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:34=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Events are 8-byte aligned in perf.data files, NAME_ALIGN is 64-bytes
> which is excessive given the alignment needs. Move the addition the
> sizeof so that the alignment considers that the rest of the event is
> 4-byte aligned.
>
> ```
> struct perf_record_header_build_id {
>         struct perf_event_header   header;               /*     0     8 *=
/
>         pid_t                      pid;                  /*     8     4 *=
/
>         union {
>                 __u8               build_id[24];         /*    12    24 *=
/
>                 struct {
>                         __u8       data[20];             /*    12    20 *=
/
>                         __u8       size;                 /*    32     1 *=
/
>                         __u8       reserved1__;          /*    33     1 *=
/
>                         __u16      reserved2__;          /*    34     2 *=
/
>                 };                                       /*    12    24 *=
/
>         };                                               /*    12    24 *=
/
>         char                       filename[];           /*    36     0 *=
/
>
>         /* size: 36, cachelines: 1, members: 4 */
>         /* last cacheline: 36 bytes */
> };
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/build-id.c         | 6 +++---
>  tools/perf/util/synthetic-events.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 83a1581e8cf1..8fea17d04468 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -309,8 +309,8 @@ static int write_buildid(const char *name, size_t nam=
e_len, struct build_id *bid
>         struct perf_record_header_build_id b;
>         size_t len;
>
> -       len =3D name_len + 1;
> -       len =3D PERF_ALIGN(len, NAME_ALIGN);
> +       len =3D sizeof(b) + name_len + 1;
> +       len =3D PERF_ALIGN(len, sizeof(u64));
>
>         memset(&b, 0, sizeof(b));
>         memcpy(&b.data, bid->data, bid->size);
> @@ -318,7 +318,7 @@ static int write_buildid(const char *name, size_t nam=
e_len, struct build_id *bid
>         misc |=3D PERF_RECORD_MISC_BUILD_ID_SIZE;
>         b.pid =3D pid;
>         b.header.misc =3D misc;
> -       b.header.size =3D sizeof(b) + len;
> +       b.header.size =3D len;
>
>         err =3D do_write(fd, &b, sizeof(b));
>         if (err < 0)
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 5498048f56ea..a52b85bcb6b6 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2236,14 +2236,14 @@ int perf_event__synthesize_build_id(struct perf_t=
ool *tool, struct dso *pos, u16
>
>         memset(&ev, 0, sizeof(ev));
>
> -       len =3D dso__long_name_len(pos) + 1;
> -       len =3D PERF_ALIGN(len, NAME_ALIGN);
> +       len =3D sizeof(ev.build_id) + dso__long_name_len(pos) + 1;
> +       len =3D PERF_ALIGN(len, sizeof(u64));
>         ev.build_id.size =3D min(dso__bid(pos)->size, sizeof(dso__bid(pos=
)->data));
>         memcpy(&ev.build_id.build_id, dso__bid(pos)->data, ev.build_id.si=
ze);
>         ev.build_id.header.type =3D PERF_RECORD_HEADER_BUILD_ID;
>         ev.build_id.header.misc =3D misc | PERF_RECORD_MISC_BUILD_ID_SIZE=
;
>         ev.build_id.pid =3D machine->pid;
> -       ev.build_id.header.size =3D sizeof(ev.build_id) + len;
> +       ev.build_id.header.size =3D len;
>         memcpy(&ev.build_id.filename, dso__long_name(pos), dso__long_name=
_len(pos));

So I think there is a bigger issue here and I'm working on a better
fix. The issue is that the synthesized build_id event doesn't have a
sample id inserted afterward (note, no adding of id_hdr_size above).
By over aligning the filename it is quite likely the sample id reading
is just reading zeros in particular for the time stamp. Not having a
sample id means the build_id events are unordered, this will break if
the data file has two dsos with the same filename but different build
ids - as happens when a file is replaced. The better fix is to 8 byte
align the event and insert a sample id.

Thanks,
Ian

>         return process(tool, &ev, NULL, machine);
> --
> 2.46.0.76.ge559c4bf1a-goog
>

