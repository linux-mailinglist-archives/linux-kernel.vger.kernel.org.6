Return-Path: <linux-kernel+bounces-392961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E749B9A24
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F38C281994
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B04C1E32CC;
	Fri,  1 Nov 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzUub9pI"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F61D271A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496256; cv=none; b=FBWXCsnm3NZ1r4eMjFXaQY53Za1MLfsyM2kqF94O8pcrNJkNlFWZNnK25z9+QmZMhbPlRH4Gd9g7s0qSoAyHkp8sFVA7ASSbrC+PuJUhvqAyv5dG8CnXi42tW17gGZiWfmlFDQYUbzrvxao9bJrNJqG0Ak7j22Mwlp0Qg8U2upw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496256; c=relaxed/simple;
	bh=1xIA+BlfuPXS5MNT2eekQt6nrdzAAQ8mMRTUpRP5tjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTRcIHN4btIvOvnK6A9zhBDLsGQZUKjIvRztWYnv/Psyw1U4s32oLO1QVsOTQt9dy2TBeFoQYatB7SyrxwDWRg0kFwHF1xpYju0u4ptPifozkSsukLzzOUhzCozrX09QIAu84EfkHr3UreEGy4n/sqx1fGoJwUC99nftl9yEChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzUub9pI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so1802204f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730496252; x=1731101052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGNhWT/+3jcQzIMLrDioD/wPUZ00FjT48riH/ahhZjc=;
        b=YzUub9pIlf4omjO4Dhb61A0wiiiVJ1Hgyw2sdKPlJxv5TG739pmcskXQYNLwcH1EKq
         85jhHdpHTuxPmW7U4Yvobq8/cAl7LuDT5KQplMjjOnTdxS3GLBhi/nA0PfoIlrhTWVuq
         l6L/UIbndugYuy93VLIhZ42G6wMvyUC5Hqu1JiWFaCNJsJICitWHnG2PYK/VRHPolesO
         XhHA0BNYJFte8uzyGgCZl0XtTm0DIdbfow9WHKeuY+rMDr7ENwjBF9k7woGxeGGcZXaJ
         76J0QeZwPB4fB3MAOBj+O1Jct5rg0YmzBhECfnjYksI4Yhtms0gTMejeN+4IIPuM5H0S
         GciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730496252; x=1731101052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGNhWT/+3jcQzIMLrDioD/wPUZ00FjT48riH/ahhZjc=;
        b=c3ebCuB4PrNhzYaa//3nDQfkkrVma/kaE4fInq/P6LSfcp79vSSCIkxFJctgd5BHjm
         EgesheqdqUdxhHroUwAJPKuM1hSofKOV3PA43CKcvZkw++RRUAbTKKfv7wD4o1r6rXeb
         tlJJJkjJcY+D+926MruLpERpTk4lBvGx4UaWwP+mrvs6j1OmvBr4Sa0dpXL2rvZ5Senx
         y4RWPjmBwIeOz0yyOta/gVwXcef/eCInCAlxjJxzV0SGVo6yg0eXxAEJJa5OtpvscACi
         VB3RgD4wulAHWcRIwFTuM8MH3vfJnyGNhdWcUnbl8Ieb4BEWrHRqMtfNQAN8gZubsWHb
         PPZw==
X-Gm-Message-State: AOJu0YzkGYPmJGyGrXW+JB85i2HenDhJj/lQkymZfAJEzirz9Ay5jNeX
	NRnEN83Ts3CascsyFkXdzlz+T5KLwrhgdZTllBFzz560Ms4+RUhrqkMCpIgRYmSQzBKbZGuj8Vx
	9TrjiSbFe4gb1cS7WAB8EU5XEi5oL4gtcgKof
X-Google-Smtp-Source: AGHT+IEnx1Glirk4swuvBjeKq5AcoRfj7PZEF2jLHYe380MDSfmIfvkIOxb3aj4c5MAOHxwK/ltfektbCrRcmVHOfkk=
X-Received: by 2002:a5d:64a7:0:b0:37c:cfdc:19ba with SMTP id
 ffacd0b85a97d-381c7a6bc70mr4115646f8f.28.1730496252214; Fri, 01 Nov 2024
 14:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031223948.4179222-1-ctshao@google.com> <20241031223948.4179222-2-ctshao@google.com>
 <CAP-5=fVaD8GLhMmM=d4DqHnT24ZDHPAWU56mzSF5OXY=pTO3UA@mail.gmail.com>
In-Reply-To: <CAP-5=fVaD8GLhMmM=d4DqHnT24ZDHPAWU56mzSF5OXY=pTO3UA@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 1 Nov 2024 14:24:00 -0700
Message-ID: <CAJpZYjULGa80tC6LBGZyXfUNk3yG5tyieegvheMg6N13QhoHCQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf: Reveal PMU type in fdinfo
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your review! Here is the link to the v2 patch with
fixes: https://lore.kernel.org/all/20241101211757.824743-2-ctshao@google.co=
m/

On Fri, Nov 1, 2024 at 9:02=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Thu, Oct 31, 2024 at 3:39=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > It gives useful info on knowing which PMUs are reserved by this process=
.
> > Also add extra attributes which would be useful.
> >
> > ```
> > Testing cycles
> > $ ./perf stat -e cycles &
> > $ cat /proc/`pidof perf`/fdinfo/3
> > pos:    0
> > flags:  02000002
> > mnt_id: 16
> > ino:    3081
> > perf_event-orig_type:   0
>
> nit: I think this should be:
> perf_event-type:   0
> this output was from an earlier version.

Thank you for the correction!

>
> > perf_event-attr.config1:        0
> > perf_event-attr.config2:        0
> > perf_event-attr.config3:        0
> >
> > Testing L1-dcache-load-misses//
> > $ ./perf stat -e L1-dcache-load-misses &
> > $ cat /proc/`pidof perf`/fdinfo/3
> > pos:    0
> > flags:  02000002
> > mnt_id: 16
> > ino:    1072
> > perf_event-attr.type:   3
> > perf_event-attr.config: 65536
> > perf_event-attr.config1:        0
> > perf_event-attr.config2:        0
> > perf_event-attr.config3:        0
> > ```
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  kernel/events/core.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index cdd09769e6c56..e0891c376fd9d 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -8,6 +8,7 @@
> >   *  Copyright  =C2=A9  2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.=
com>
> >   */
> >
> > +#include "linux/seq_file.h"
>
> nit: I think you should use angle < > rather than quotes on the
> include for consistency.

Fixed.

>
> Thanks,
> Ian
>
> >  #include <linux/fs.h>
> >  #include <linux/mm.h>
> >  #include <linux/cpu.h>
> > @@ -6820,6 +6821,17 @@ static int perf_fasync(int fd, struct file *filp=
, int on)
> >         return 0;
> >  }
> >
> > +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> > +{
> > +       struct perf_event *event =3D f->private_data;
> > +
> > +       seq_printf(m, "perf_event-attr.type:\t%u\n", event->orig_type);
> > +       seq_printf(m, "perf_event-attr.config:\t%llu\n", event->attr.co=
nfig);
> > +       seq_printf(m, "perf_event-attr.config1:\t%llu\n", event->attr.c=
onfig1);
> > +       seq_printf(m, "perf_event-attr.config2:\t%llu\n", event->attr.c=
onfig2);
> > +       seq_printf(m, "perf_event-attr.config3:\t%llu\n", event->attr.c=
onfig3);
> > +}
> > +
> >  static const struct file_operations perf_fops =3D {
> >         .release                =3D perf_release,
> >         .read                   =3D perf_read,
> > @@ -6828,6 +6840,7 @@ static const struct file_operations perf_fops =3D=
 {
> >         .compat_ioctl           =3D perf_compat_ioctl,
> >         .mmap                   =3D perf_mmap,
> >         .fasync                 =3D perf_fasync,
> > +       .show_fdinfo            =3D perf_show_fdinfo,
> >  };
> >
> >  /*
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >

