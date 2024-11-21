Return-Path: <linux-kernel+bounces-417481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE79D549D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC891F22E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA71CB9F4;
	Thu, 21 Nov 2024 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVR6EOEg"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3515098E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732223949; cv=none; b=ht7rGgxEe9SxVlJsm0mc57k5uDCsM8xhNnzc2AGr9apOsPRRafgFJE0uW6mcfNcKVcVXv7qYrKYuqvD4tmNsa6FmF1kF2R9epMYjrOp30lAbFH/lEB9Tev5mdsvCtSGzoNHlOJkmciayYAU6cnAjUxUyQqnnC8zGDsHdctZwPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732223949; c=relaxed/simple;
	bh=8lz2cEj5C1DwnLcZiEsku1DUpI7PthbBD35+zvvXCgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVqsRe74mFdWpRspOQO3fIhqT2SWFf3cIXVbwzF443nN+bls7Tkwn77LVuCgAdg/Jl3rN9BfiSMkBILAM7VGcRtFldZj43pMHOmRhayjACkYvS8jj4e3AGNXtEqmBkePJNP3E0d+ieXTIQUCAojkwFrGE7Z2u1rFat1GRr4Ia0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jVR6EOEg; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38231f84dccso972136f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732223946; x=1732828746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pX8XiRlPufvUoMxM7Ycxdc9sn9Rz/VdbbgNK2el4cX4=;
        b=jVR6EOEgv+c0M86upHz1qUDt9LCRyHTk4RuQx0H6rRnvrMj2IVVAS1Q7dlpU6G/+gp
         IPGqdTNmrDsR+zRWSVQ+UJBqSRdUG86rWqOowI4R7vDYkL+9GK1JpLE0U5Z4dpQHIY6l
         JuWKcY5TbVEbL0D0SdEtNM7indfKuh36NCYD451sqEVmNvuSihXRXsJNRS9QXpufo575
         3+CSVkG8s6kYN0ihsqfbDrIORobpVAgBm8VdjDbWV/9sz92ISR4+tySPR8GxIEDU2Day
         9QJ89yqsrtSCrQRE7v/Mwpek4gSPNibRCSPbruFM8BA5bZCpTRQ+lnL9//Nyr0hZEsF7
         H5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732223946; x=1732828746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pX8XiRlPufvUoMxM7Ycxdc9sn9Rz/VdbbgNK2el4cX4=;
        b=H16D9d2I7S+LqU/yyt5QJeebiGFouhHmf8PFgGgfOIM/54jMPWFE+RJ/sB575dUwrA
         38LWQL4YRzM9W+Xw/d843EPDRJ3UmI8JBycazpLr756ndw90r2Za7KzXuQfldEojqZhQ
         s37iqS3ONh0pth41scoeU1NS1qJ/9qY1UkvUKwhDXpjgrvJ51Ig1LG70Wn7WQmoXlz18
         MARgpl1EH7Uo8M/OrvXZVAu000lGdFLfZ1bORxoHznDFdtbUQjw154CHm54T+XqpHoAM
         VrTQ+kEnmGc5ClmfnZROGO7v9+EPpW+tUr12rWZ5fvgq3F70vgzWq59tHMRccV7ry5Ye
         zKGA==
X-Gm-Message-State: AOJu0Yz68WQ0Q1O2BilqaBAq/21SoSbqycLBHCzafbxuPgDCDhVksNTD
	0h+qGyTzyArdxZyoZJoWPED92/Gdpv6h1BM71AhIpToycfMOngTbrNsVQwuSJ3ZvzKweNrrbJ1y
	vdj2PHXKBWqEFn1yaU7vrQAdGCJA9Z4S4MXzfTY2KxQnIK9ANvSgT
X-Gm-Gg: ASbGncsT9DFpWk5VNhUUYpZxmRZTqBuzEARTVR5l5/wnFrb8LG/wKhaO4XUGtJsIejy
	mXOjg3JeKwnSuU8nAyjz26E5MHAQKPBFUS2/QA1h/YwwX4EXLDJKvsLCXIw==
X-Google-Smtp-Source: AGHT+IET7ArKCoKeGbFTTH20elE2gMMjwLV5I6kbsX+Bkm1lKqx9xUfkwH4I55PZwpmn2XHoSWKx/W+grWluAK6DwkQ=
X-Received: by 2002:a5d:5f47:0:b0:382:464e:1ab4 with SMTP id
 ffacd0b85a97d-38260b45526mr432608f8f.3.1732223945901; Thu, 21 Nov 2024
 13:19:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com> <20241106003007.2112584-2-ctshao@google.com>
 <CAP-5=fUc0YttVUMB9oAit3u5hzVGuK5rTLnP_dXD0kqt7QcO5g@mail.gmail.com> <CAJpZYjW0evv8SmPMwymjcFQExy+zVHe_6XW79bB_ErRXCwgzfA@mail.gmail.com>
In-Reply-To: <CAJpZYjW0evv8SmPMwymjcFQExy+zVHe_6XW79bB_ErRXCwgzfA@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 21 Nov 2024 13:18:54 -0800
Message-ID: <CAJpZYjUEn-Cr-YWfA68iN8jnR7BdSPhg3DxXsQq7OwA93bDpOg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf: Reveal PMU type in fdinfo
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, just a friendly ping for review, in case anyone missed this.

Thanks,
CT

On Thu, Nov 14, 2024 at 10:30=E2=80=AFAM Chun-Tse Shao <ctshao@google.com> =
wrote:
>
> Hi Ian,
>
> On Thu, Nov 14, 2024 at 7:49=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Tue, Nov 5, 2024 at 4:30=E2=80=AFPM Chun-Tse Shao <ctshao@google.com=
> wrote:
> > >
> > > It gives useful info on knowing which PMUs are reserved by this proce=
szs.
> > > Also add config which would be useful.
> > > Testing cycles:
> > >
> > >   $ ./perf stat -e cycles &
> > >   $ cat /proc/`pidof perf`/fdinfo/3
> > >   pos:    0
> > >   flags:  02000002
> > >   mnt_id: 16
> > >   ino:    3081
> > >   perf_event_attr.type:   0
> > >   perf_event_attr.config: 0
> > >
> > > Testing L1-dcache-load-misses:
> > >
> > >   $ ./perf stat -e L1-dcache-load-misses &
> > >   $ cat /proc/`pidof perf`/fdinfo/3
> > >   pos:    0
> > >   flags:  02000002
> > >   mnt_id: 16
> > >   ino:    1072
> > >   perf_event_attr.type:   3
> > >   perf_event_attr.config: 65536
> > >
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > > Change-Id: Ibea5618aaf00bae6f48a9b2a6e7798ab2b7f23ce
> > > ---
> > >  kernel/events/core.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index cdd09769e6c56..398cac8b208b9 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -55,6 +55,7 @@
> > >  #include <linux/pgtable.h>
> > >  #include <linux/buildid.h>
> > >  #include <linux/task_work.h>
> > > +#include <linux/seq_file.h>
> > >
> > >  #include "internal.h"
> > >
> > > @@ -6820,6 +6821,14 @@ static int perf_fasync(int fd, struct file *fi=
lp, int on)
> > >         return 0;
> > >  }
> > >
> > > +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> > > +{
> > > +       struct perf_event *event =3D f->private_data;
> > > +
> > > +       seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type=
);
> > > +       seq_printf(m, "perf_event_attr.config:\t%llu\n", (unsigned lo=
ng long)event->attr.config);
> >
> > nit: is the cast necessary? I don't see __u64 listed on:
> > https://www.kernel.org/doc/Documentation/printk-formats.txt
> > so I'm unsure.
> >
>
> In this case I think it is safer to cast it to `unsigned long long`,
> since I don't know if any architecture would have an exception on
> __u64.
>
> Thanks,
> CT
>
> > Thanks,
> > Ian
> >
> > > +}
> > > +
> > >  static const struct file_operations perf_fops =3D {
> > >         .release                =3D perf_release,
> > >         .read                   =3D perf_read,
> > > @@ -6828,6 +6837,7 @@ static const struct file_operations perf_fops =
=3D {
> > >         .compat_ioctl           =3D perf_compat_ioctl,
> > >         .mmap                   =3D perf_mmap,
> > >         .fasync                 =3D perf_fasync,
> > > +       .show_fdinfo            =3D perf_show_fdinfo,
> > >  };
> > >
> > >  /*
> > > --
> > > 2.47.0.199.ga7371fff76-goog
> > >

