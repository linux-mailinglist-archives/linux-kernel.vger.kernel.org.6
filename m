Return-Path: <linux-kernel+bounces-397317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9322C9BDA5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C81282F92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707928DA1;
	Wed,  6 Nov 2024 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogNx1LKA"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AAC61FEB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853157; cv=none; b=JiNSVJ0rb51vnLzkzQMIcsJLJA7SsL0n66ocrOJUvYEutUrvXh/weaSQo3nkWK28mKlCiYwyI8DhuH8SbQNrMBHq5vFYyDKPGMavYCLENFvUSxqob+vuCWJd47L5P2bPfLjlZR5wrm1jiYYY5unSbl+ZvL1Tfga0EoxJrzqySbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853157; c=relaxed/simple;
	bh=W2MNS7vs8Wdqb5q6mm979sTO3PGe0U27MYkgdgZT9Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QShi5yppti/fOAxxDpnKmP6s0B3mqzj/cfiM+9O9xldStXaZ4w9raalj3/hPBvce5UBdunYMVWlMtgua9Wu2iyVaeIMB5wDBG84naz66exUshFZ9lTg+Ddw3zOpPDF3qCmd7HnfEHGcAZEO/SR5N35Co5jXU9M9w1d+SUo9zfa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ogNx1LKA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so51889375e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 16:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730853154; x=1731457954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgQmIWY1Y20zXq4aq/x6E7RoCbmNzYOzB+1w+5Cai0k=;
        b=ogNx1LKAx01eLG1aVoibjEiAK6VkjRNvvzmV/LUhiqjB3sTYH9e9a8dP/amdD7RHuO
         LGhJRY8OElJqxur6LLcPAE7iGQMGvX6wKttqbi1Z3srnLZ2rHWCCJ8vECFKQ5YuQbu5v
         0Q0Wwjgmh84/Wp3+bSSYJPBZDZkqhXU2oZgeMDzEDYK+lZw8gOwi6MrXOdW6R+1ZBvps
         qxR5Ir4Q5q6lnD2y0u9STHGEObhnh+sOi4xPnczKH4enk0Ai/m5YztddPVeIbxoAE3CT
         t0hAq4816N58tM3RyToQVxISq284g3DLiF9RYaGc8jjY0IxRHo1nrjV4/BUMNX9Rjh15
         /Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730853154; x=1731457954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgQmIWY1Y20zXq4aq/x6E7RoCbmNzYOzB+1w+5Cai0k=;
        b=u7WfAnE4SOLq7bHQbWA41IIuTiFVfZCMqY67aoHjO4jEfce5jd8ewTHfx6LDDzPcSj
         xYynSf0vDmy0pAq/xcQb/T1pDc1Cw/oD9E9kmBO2tQUC6WBUS9OmstPs2tVHi2iw3F8P
         VgrjMfePWXeJALxByvINC9jJnkDianB53vOlp1RXd5yu/97bIy5JhOsGxryPyYc1YfQZ
         14xqvLZTbGHIHFaoZWKjNkbovJcqM6gQf1suMbglNnAhIE9wOVIWmfT+tpxO/Tyi1aqF
         jjRk5RmqatPh7x6LLVAz3Xy7QQRcEtPE5xCeulnvM1zxaQL8vmv+UU39aVbSK0qf6ek5
         uAnw==
X-Gm-Message-State: AOJu0YybXWoLfvMXzgnrLVTtfLaq/IldPTsvKBgEfWPguyznXO96Eu0O
	BAiHxJlYQuZgG5u2b2Ocxs7XlpujBEJ8FSDlIAVEVFYpdnd0nBMzMas9qNgk86gkz5FK5JB+OC6
	2BAkuNeMhnEI+gHaGhLk1C0FyheLWhIKOXEY4
X-Google-Smtp-Source: AGHT+IGRX/BfDnE/ylrb2nu1HzcsSnkrmxoFVgn2PYUGFFm5Kq6UXrZ/5K54cVuz+foZxCgeQTkVL30IMYttPtUfOcA=
X-Received: by 2002:a5d:4045:0:b0:37d:3bad:a503 with SMTP id
 ffacd0b85a97d-380611e0f45mr25473953f8f.40.1730853154062; Tue, 05 Nov 2024
 16:32:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101211757.824743-1-ctshao@google.com> <20241101211757.824743-2-ctshao@google.com>
 <Zyli1TWn8ZaNWSxm@google.com>
In-Reply-To: <Zyli1TWn8ZaNWSxm@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 5 Nov 2024 16:32:22 -0800
Message-ID: <CAJpZYjVrTsuSwT-31hBYihzmK94j6BWGD4XxudTXMB0W+Hcb+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf: Reveal PMU type in fdinfo
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your review, Namhyung! Here is the link to patch v3:
https://lore.kernel.org/all/20241106003007.2112584-2-ctshao@google.com/

On Mon, Nov 4, 2024 at 4:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Nov 01, 2024 at 09:17:56PM +0000, Chun-Tse Shao wrote:
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
> > perf_event-attr.type:   0
>
> Maybe 'perf_event_attr' would be appropriate as it's the name of the
> struct.
>

Agree.

> > perf_event-attr.config: 0
> > perf_event-attr.config1:        0
> > perf_event-attr.config2:        0
> > perf_event-attr.config3:        0
>
> It's hard to pick which fields to show here but I'd say that those
> config[123] are not used frequently at least for regular events.
> Maybe just showing type and config is fine.
>

Agree, it should be fine to add more if needed.

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
>
> FYI usually the kernel changes are applied to a different tree than the
> tools.
>

Thanks for the heads up!

> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index cdd09769e6c56..c950b6fc92cda 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -55,6 +55,7 @@
> >  #include <linux/pgtable.h>
> >  #include <linux/buildid.h>
> >  #include <linux/task_work.h>
> > +#include <linux/seq_file.h>
> >
> >  #include "internal.h"
> >
> > @@ -6820,6 +6821,17 @@ static int perf_fasync(int fd, struct file *filp=
, int on)
> >       return 0;
> >  }
> >
> > +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> > +{
> > +     struct perf_event *event =3D f->private_data;
> > +
> > +     seq_printf(m, "perf_event-attr.type:\t%u\n", event->orig_type);
> > +     seq_printf(m, "perf_event-attr.config:\t%llu\n", event->attr.conf=
ig);
>
> I'm not sure if all archs are happy with treating it as %llu.
>

I think with type casting to `unsigned long long`, it will make it
print in `%llu` for all archs.


> Thanks,
> Namhyung
>
>
> > +     seq_printf(m, "perf_event-attr.config1:\t%llu\n", event->attr.con=
fig1);
> > +     seq_printf(m, "perf_event-attr.config2:\t%llu\n", event->attr.con=
fig2);
> > +     seq_printf(m, "perf_event-attr.config3:\t%llu\n", event->attr.con=
fig3);
> > +}
> > +
> >  static const struct file_operations perf_fops =3D {
> >       .release                =3D perf_release,
> >       .read                   =3D perf_read,
> > @@ -6828,6 +6840,7 @@ static const struct file_operations perf_fops =3D=
 {
> >       .compat_ioctl           =3D perf_compat_ioctl,
> >       .mmap                   =3D perf_mmap,
> >       .fasync                 =3D perf_fasync,
> > +     .show_fdinfo            =3D perf_show_fdinfo,
> >  };
> >
> >  /*
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >

