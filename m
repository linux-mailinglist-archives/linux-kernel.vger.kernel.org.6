Return-Path: <linux-kernel+bounces-331588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF397AE99
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4027D281CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886F216190B;
	Tue, 17 Sep 2024 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YUNYZJQO"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6F13E41D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568253; cv=none; b=cFwh2ZhioX7CP91eP8V6ZT5AuXiyxNgC5teHXCEAZYm5zwGgIR4XUx55pyCECPVY3wTOOOhjenzTcxIJK/V+0omH+UyeQNzH3JKEzyFaW6W1XMNR7qjMsHOQPTlOQeiETGHvwzFEcEyBlY8w2KzRHq10HKwoabZ2/ddqopl+49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568253; c=relaxed/simple;
	bh=kbf+zOsNjOEq7B4sJHKsqjpR2pz7N/XoWKyR+wXJAX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdiEeYcnvVsGV4XhRXxOKOjCVG5qbhuQe+SeFsrEzuYnTe/dfiHS/wyiQ6peXVsw6mTXR4eq001x+jqMCSKMEN1/4MzP/5VAMyrQ/btenMefZTS/p8rcGXE9IEBbFBZAejm/YHANuEQewNDbgOhCf+q20T3Aro8LUgaJ/5w6LIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YUNYZJQO; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so43984081fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726568250; x=1727173050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVLnMLjFrz6ou9PfQoYGXIryu59hUco41U3tuPx/LLw=;
        b=YUNYZJQOjyERwLPciw+3TyeFF5rhTFltbXdFb6wwB7M8Qp1Jw4vvjWg8j/i9dr454R
         IXmYTvagxPSXtHIhB8NbtwwHdnRQrSRqDp5aYQ1hC1xbfczK/orP+xc7R4X0vnd83hOx
         fC7bvfp2N6h3zL9OdAvhqPJIY6EAQAZI9ygrnEzJDZK9aOOXvRKNISs5NNmxK5IEgneS
         cJ9nF8YBHy3hsDcjPcPrrQYOOBYrfPJ7k4ocX1YUoR7o5zGg0jvG6UsVSW4uVw59VrEB
         9RIZvB4Jc4a9WDeOcnZgq2XUKmznXBw/cu45zo4i6cE5Mhm5LHgWXu02BRxco4eOZ+EA
         BpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726568250; x=1727173050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVLnMLjFrz6ou9PfQoYGXIryu59hUco41U3tuPx/LLw=;
        b=CFKPkCKm7sDJdOilNipzNVVguxjvyDIm9d1mhmKo28PnevCt+xidqGrWY+YSY1Ru+f
         hNEgcvhRKCRdHvr16PNMc6fsUrVz6hryHf6CqcqTn2BQWK0jrRXW6Hh6q9WZoE+CItUL
         nYye5LnF0ocp2RYg2fyaczO9ZUzv/qv+xTKAkJY6ZS/VHTyGYxwv5ZcU4J9+6m1iK7yR
         DS7EwYVebtk5MX12ks6XS4U7O2A0JkUFp7a2R4IF/FSb9DVMRwXrRu1hXq+3y8fAZI4r
         VL6ImdXuO9XCpoS05bOsqvJ8p7M0UeN50z9WW4vNFH40J86hIOVp2rdnd/4MERbIPYyC
         iP8w==
X-Forwarded-Encrypted: i=1; AJvYcCX43i8hn6kcVhtNg+MIz/qV2YHdN6N2rI5tCZhU2BEmOtBs+Yc16NRz98wP13ToV23Y9vSHHukafWhj5Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXB3bSTSHecCkANOVLqXozXocZj/eae+SNW6kzuszpOftPNEw
	ogiV9XGgTJhlcISWsnlfo8Qkjq9sT7vr1mOXTi0j4ANM70r50C/7FXhKxk/DcivEivOQ+XxNRRS
	JTXWWwyb0zCnUUVaHP03yFr0ZyaQYeYGAtAWXZw==
X-Google-Smtp-Source: AGHT+IF9VD1BSHsKa3GY7etZE0QC03O8KOjr9lp1a3oKYbAj+BV4Jp1HV0+HC4Jhfjdf0DlJNceM3Q2qsRxtnLk54MM=
X-Received: by 2002:a05:651c:2208:b0:2f6:5921:f35b with SMTP id
 38308e7fff4ca-2f791a0d2d0mr79852871fa.27.1726568250352; Tue, 17 Sep 2024
 03:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-tzmem-null-ptr-v2-0-7c61b1a1b463@linaro.org>
 <20240911-tzmem-null-ptr-v2-2-7c61b1a1b463@linaro.org> <ZuhgV1vicIFzPGI-@linaro.org>
In-Reply-To: <ZuhgV1vicIFzPGI-@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 17 Sep 2024 12:17:19 +0200
Message-ID: <CAMRc=MevCNHSs2jMbMXjoFYY7V8NqKha8jd3aDCgGNvuL3LwEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] firmware: qcom: scm: fall back to kcalloc() for no
 SCM device bound
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Andrew Halaney <ahalaney@redhat.com>, Elliot Berman <quic_eberman@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rudraksha Gupta <guptarud@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 6:44=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Wed, Sep 11, 2024 at 11:07:04AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Older platforms don't have an actual SCM device tied into the driver
> > model and so there's no struct device which to use with the TZ Mem API.
> > We need to fall-back to kcalloc() when allocating the buffer for
> > additional SMC arguments on such platforms which don't even probe the S=
CM
> > driver and never create the TZMem pool.
> >
> > Fixes: 449d0d84bcd8 ("firmware: qcom: scm: smc: switch to using the SCM=
 allocator")
> > Reported-by: Rudraksha Gupta <guptarud@gmail.com>
> > Closes: https://lore.kernel.org/lkml/692cfe9a-8c05-4ce4-813e-82b3f31001=
9a@gmail.com/
> > Tested-by: Rudraksha Gupta <guptarud@gmail.com>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/firmware/qcom/qcom_scm-smc.c | 28 ++++++++++++++++++++++++----
> >  1 file changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qc=
om/qcom_scm-smc.c
> > index 2b4c2826f572..88652c38c9a0 100644
> > --- a/drivers/firmware/qcom/qcom_scm-smc.c
> > +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> > [...]
> > @@ -173,9 +182,20 @@ int __scm_smc_call(struct device *dev, const struc=
t qcom_scm_desc *desc,
> >               smc.args[i + SCM_SMC_FIRST_REG_IDX] =3D desc->args[i];
> >
> >       if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
> > -             args_virt =3D qcom_tzmem_alloc(mempool,
> > -                                          SCM_SMC_N_EXT_ARGS * sizeof(=
u64),
> > -                                          flag);
> > +             /*
> > +              * Older platforms don't have an entry for SCM in device-=
tree
> > +              * and so no device is bound to the SCM driver. This mean=
s there
> > +              * is no struct device for the TZ Mem API. Fall back to
> > +              * kcalloc() on such platforms.
> > +              */
> > +             if (mempool)
> > +                     args_virt =3D qcom_tzmem_alloc(
> > +                                     mempool,
> > +                                     SCM_SMC_N_EXT_ARGS * sizeof(u64),
> > +                                     flag);
> > +             else
> > +                     args_virt =3D kcalloc(SCM_SMC_N_EXT_ARGS, sizeof(=
u64),
> > +                                         flag);
>
> I'm afraid this won't work. For kcalloc, we would need to flush the
> cache since it returns cached memory. In v6.10 this was done using the
> dma_map_single() call that you removed when moving to the tzmem
> allocator.
>

Indeed, I missed this but it's not very hard to re-add here.

> Actually, taking only the first patch in this series should be enough to
> fix the crash Rudraksha reported. None of the older platforms should
> ever reach into this if statement. I think the rough story is:
>
>  1. The crash Rudraksha reported happens in qcom_scm_set_cold_boot_addr()
>     during SMP CPU core boot-up. That code runs very early, AFAIK even
>     before the device model is initialized. There is no way to get
>     a device pointer at that point. Even if you add the scm node to DT.
>
>  2. AFAIK all the ARM32 platforms without PSCI support implement the
>     legacy calling convention (see qcom_scm-legacy.c). They will only
>     reach qcom_scm-smc.c once during convention detection (see
>     __get_convention()). This is a SCM call with just a single argument
>     that won't go inside the if (unlikely(arglen > SCM_SMC_N_REG_ARGS)).
>     And qcom_scm-legacy.c does not use the tzmem allocator (yet?).
>

No and I didn't plan to add it. Let me know if I should?

>  3. qcom_scm-legacy.c does use the device pointer for dma_map_single(),
>     so it already needs a scm node in the DT. I suspect MSM8960 does not
>     hit an error there only because it does not have enough functionality
>     enabled to actually reach a non-atomic SCM call. This means: Whoever
>     adds that functionality should also add the scm node in the DT.
>
> It would be good to add explicit checks for the device pointer where
> needed, instead of crashing. But other than that I think we should be
> good with just the first patch of this series?
>

Makes sense to me and with the Tested tag from Rudraksha I guess we
can drop this one.

Bart

