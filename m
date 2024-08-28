Return-Path: <linux-kernel+bounces-304158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544D7961B38
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96BE1F2440B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456FA18E0E;
	Wed, 28 Aug 2024 00:59:18 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241B1799F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 00:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724806757; cv=none; b=PmUwgvym0K95g0ML42Qzekuh6DAuSlw2Ejylp4IhyaU0qfu5D2vvoS8x//dxvvOnVK/32iPyu9zBy6Tkll5IujHQZiFV8x1l+gaC7APauRgJrodrwqs/CghR02SkG4+G7G3tAw1TwKPykOrlfJra7TuEu4+Nd6mY+U0U6cej4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724806757; c=relaxed/simple;
	bh=1o0r7ejATkul3C7hADT3ZatthBW1OI71C4zY8O0SCTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+5CIvooW6ZDi+auJ9lRDHdCQ9vLCt8GW7NXnDH4zcouvYqSHS7s4R9FYsu9vTFazOSbS98olwgLqhkm/tXaOg9c3k+IkQTF29qogbFY7WoiC4r0MTLqQVTAgIueTbNDM4bYmTwPCX9Tn1OssxEi6vVMs2W1AFSfWxsqsqUIZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cd830e0711so81487a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724806755; x=1725411555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XG5JOqmbnyihRYmwQmKkVKBHVAamXjh98RgIHtDtvlo=;
        b=t12emkTuBt5ZHgHKd+tAD40aXTvZANgcD0tTo4f4suQ99ppU0MDDw5qaEw/9H9AF1j
         uuCzlhZQRJJiXRo2F8uBekAZcDHgIlLOHJHeJleX0ODq6nhVTnoTAu6E2deZpBi1d0vQ
         S/RBajPU62UsBK2UZ0pZvfdHis1gRQfZ8vsDlT5N8aCxJNrhBq4IIg7Z3LqUqLC9YEHZ
         ddKSW3i32UtvirqbWu5qDr24oNACuSfPXn7yaG3c9lMGc1CbGI7jzhMHDDPFA0KntS22
         lgREOkHanWmrijsw62NAtl9fL12zpywgK57OlYzvOvu/wQekWqOgW7rTqQ6EWpLThaYN
         rlJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXIHDRs12/HSblDV2LP0bDbzPduxNIvAQSu8qk928XrmGqUlYt26WDlva1XFBQEWcaFpT5szUv/487zuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGpiNhuDI3T9SsKI5zrtUI3fvI0/1tOG1Hwkg2Gwcbi24jeFxF
	0yPxTcjdJWfBcPkStp03mtTtrVq4lYBHe6ivaeQhcB33W8DmNMctOB/vI6JhKr1qM5cFuDMK7Tr
	FncqB6/r8s7EoGgcpX/EYL4UMAvw=
X-Google-Smtp-Source: AGHT+IFE94e80ft8fus3FbhOE3Kbywq6tPiAuG+LWZu7doHoCxk2l298vcW0160etiCy7tLRNkYjwhBSn4WKE+TnS4w=
X-Received: by 2002:a17:90a:f2cd:b0:2d3:c365:53b1 with SMTP id
 98e67ed59e1d1-2d843d3cedemr902382a91.6.1724806755186; Tue, 27 Aug 2024
 17:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822230816.564262-1-namhyung@kernel.org> <721f055b-d594-4b24-b9e4-6d56475927fd@amd.com>
In-Reply-To: <721f055b-d594-4b24-b9e4-6d56475927fd@amd.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 27 Aug 2024 17:59:03 -0700
Message-ID: <CAM9d7ciLHBD9=eepdbNDo8HRZYm-Wqg0M-Z_GsqMjPQmLt5Xfw@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf/x86: Relax privilege filter restriction on AMD IBS
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stephane Eranian <eranian@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ravi,

Thanks for your review!

On Mon, Aug 26, 2024 at 9:42=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> Hi Namhyung,
>
> On 23-Aug-24 4:38 AM, Namhyung Kim wrote:
> > While IBS is available for per-thread profiling, still regular users
> > cannot open an event due to the default paranoid setting (2) which
> > doesn't allow unprivileged users to get kernel samples.  That means
> > it needs to set exclude_kernel bit in the attribute but IBS driver
> > would reject it since it has PERF_PMU_CAP_NO_EXCLUDE.  This is not what
> > we want and I've been getting requests to fix this issue.
> >
> > This should be done in the hardware, but until we get the fix we may
> > allow exclude_{kernel,user} in the attribute and silently drop the
> > samples in the PMU IRQ handler.  It won't guarantee the sampling
> > frequency or even it'd miss some with fixed period too.  Not ideal,
> > but that'd still be helpful to regular users.
> >
> > I also think that it should be able to inform the number of dropped
> > samples to userspace so I've increased the lost_samples count.  This
> > can be read with the PERF_FORMAT_LOST (perf tools set it by default)
> > so I didn't emit the PERF_RECORD_LOST_SAMPLES for this.
>
> Samples are discarded not lost. Should we count them as lost?

Yeah, I'm asking for help on how to handle them properly.  We could:

1. ignore dropped samples
2. count them as lost
3. count them separately and emit a (new) record in the ring buffer
4. count them separately and let users can read(2) them with a new format
5. anything else?

>
> > I'm not sure if it's acceptable since it might be confusing to figure
> > out whether it's because of a lack of the ring buffer or it's dropped
> > due to privileges.  Or we can add a new record format for this.  Let me
> > know if you have a better idea.
> >
> > Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  arch/x86/events/amd/ibs.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> > index e91970b01d62..6f514072c440 100644
> > --- a/arch/x86/events/amd/ibs.c
> > +++ b/arch/x86/events/amd/ibs.c
> > @@ -290,6 +290,11 @@ static int perf_ibs_init(struct perf_event *event)
> >       if (has_branch_stack(event))
> >               return -EOPNOTSUPP;
> >
> > +     /* handle exclude_{user,kernel} in the IRQ handler */
> > +     if (event->attr.exclude_hv || event->attr.exclude_idle ||
> > +         event->attr.exclude_host || event->attr.exclude_guest)
> > +             return -EINVAL;
> > +
> >       ret =3D validate_group(event);
> >       if (ret)
> >               return ret;
> > @@ -667,7 +672,6 @@ static struct perf_ibs perf_ibs_fetch =3D {
> >               .start          =3D perf_ibs_start,
> >               .stop           =3D perf_ibs_stop,
> >               .read           =3D perf_ibs_read,
> > -             .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> >       },
> >       .msr                    =3D MSR_AMD64_IBSFETCHCTL,
> >       .config_mask            =3D IBS_FETCH_CONFIG_MASK,
> > @@ -691,7 +695,6 @@ static struct perf_ibs perf_ibs_op =3D {
> >               .start          =3D perf_ibs_start,
> >               .stop           =3D perf_ibs_stop,
> >               .read           =3D perf_ibs_read,
> > -             .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> >       },
> >       .msr                    =3D MSR_AMD64_IBSOPCTL,
> >       .config_mask            =3D IBS_OP_CONFIG_MASK,
> > @@ -1062,6 +1065,13 @@ static int perf_ibs_handle_irq(struct perf_ibs *=
perf_ibs, struct pt_regs *iregs)
> >       if (!perf_ibs_set_period(perf_ibs, hwc, &period))
> >               goto out;       /* no sw counter overflow */
> >
> > +     if ((event->attr.exclude_kernel && !user_mode(iregs)) ||
> > +         (event->attr.exclude_user && user_mode(iregs))) {
>
> Should we use kernel_ip() instead? That would be accurate since RIP is
> provided by IBS hw itself.
>
> user_mode() relies on CS which is captured at interrupt time, not at the
> sample capture time, and processor might have switched privilege mode by
> the time IBS interrupt arrives. We might need to fallback to user_mode()
> if ibs_op_data->op_rip_invalid is set.

Sure.  I'll update it in v2.

>
> Wondering, should perf_misc_flags() also switch to kernel_ip() ?

Probably.

Thanks,
Namhyung

>
> > +             throttle =3D perf_event_account_interrupt(event);
> > +             atomic64_inc(&event->lost_samples);
> > +             goto out;
> > +     }
> > +
> >       ibs_data.caps =3D ibs_caps;
> >       size =3D 1;
> >       offset =3D 1;
>
> Thanks,
> Ravi

