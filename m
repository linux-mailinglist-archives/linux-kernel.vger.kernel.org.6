Return-Path: <linux-kernel+bounces-534856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BCEA46BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B24818891FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739E9275619;
	Wed, 26 Feb 2025 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaIsSSl3"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659827560E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600309; cv=none; b=IZhJqeLG+8tWyP7LmCsuPp/EPqJF5YDNElOq82i4byVo7t4gIAy8cPTbi0GHrABCL5mJ+heVdwZB67J6mCL5gB1J9/LSLbkGx8vDJDmhlvVMEvRR5CaIVIICQ14npTFWeQfTBtJN5KtJ/0wNGMZqJofeF6Jm24qfZfl8fmV9+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600309; c=relaxed/simple;
	bh=twfyIxRXCcP9CSSd5DYleD8UHfGBrPiYjysUBNqlIq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzXbCHozKVrEsm2R2AbqwDwUWdIQXB6EjckkFGLaOwOSbwBgzPuu5OU5e1RinCln4Fgw0NeLx9UIJcRwACIgJQgXmu1AMqXsbP1Ajy7MRfH49nZSium3BxvCqIsLEUU6mkLENEjFN24f1NhT0wBo8YjWAcjB86ddvECsq8ftkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CaIsSSl3; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so125506276.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740600304; x=1741205104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPv+r7GhPbx1VaQ2InW7lfhD1lK4Sy04lJE5OPfnYWI=;
        b=CaIsSSl3fCoDAZvbGt2t+jFnwJTgqmOR+5ZQZInZEwE0iQHrbsVUOTTKD2DOo3Mcqz
         97xz3SMDsKcVN1l0eR9ats3gPxho6f0sTqKw37Hr3tMyRc1vlrG3eGk8iCR+o9V5oVB/
         5Sob6CXoVbymTlDx5RnL7Ekf0p5MjSeLvESdrkYK4tgCnGtgTVFmkp0ZTrcwmLXHSzRD
         bqpQ7y8QpLHSUSyjy1GGjOYA0iVQxlgDoC9YQx4epfk0sAexpSenvgiLkRCXDk5HbTsa
         gIHFsWiJCqqgAu0i6fkqr0QNwkZqLrslFnGuQnTd8xoAbbiWGP24wE6bX8CAI4+Ezcip
         YWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600304; x=1741205104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPv+r7GhPbx1VaQ2InW7lfhD1lK4Sy04lJE5OPfnYWI=;
        b=j75DdcKfw8paBOHrPvmZ3ir6151X0GaVHLW6Jb+JAdMTIhXXEj2y4CZJZflCZ7c4d5
         /NfJoayWmWCl2dQ92RhK8xln5T3qOYBOvWhDOFPxZbfICwawKfj6MBUC9JXj4tP5CE5z
         yQnewZZlX+BpzLAQktjl82gbKa9DbElF08BwJMfl+BsLHknqyY/I/OB9fowyN4lufWip
         /6sVjOuq5wENo4dKbD4ga5lPilfxUKmixcspqHHl9R6w8ENGv6LKDXEJ4Dq3grdUPsoa
         ZnNsL1zG8m0xnLzR0T9X+nT2YCk+zvLchvYXvCRG1dohsaVCB2C9zFEM0NS5QkmhgnH/
         49Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXgE/A0QJqZfe/KD3tieXjaDUz5peJn48P97cDBXbuIGgJNmI8gbN0XafZH9O/ndN4pR+/DBeWCkjwj9mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHTQ0BypOMumKsQ2u6IioRx3p8ip/KSQQIkfPCRYZ+wAnn2UR
	H1kKegRfpyJ1mWa985N1AL9V5i3SVzuOvQO4aT94t7fksthEgmglm747G1NLvOu47vboQwoFcE3
	OYEJJxYIlNauf+sIBoo799e6QFOtA8vWZqgFvG3LQ4kDaA6B0VGijZA==
X-Gm-Gg: ASbGncuZOZdzh6Hk3eNLeuFJY0WQgkEwKHLSkwGCnx4QzIC47Kvur3nBz/Akone69ZW
	TV9QZh4rtTL90OaU4tymACIYheVtJPb7YcxYCUau04AtDdkXM6FmmVraS0n4BsXSAJ3KpkTu9r5
	SPSnAfuXw=
X-Google-Smtp-Source: AGHT+IGrhGDuaVczvmVGPs/3EnnL3vBEhb3RmWE6mAJSOT2/qwJCzGmG98OHENlpFlh/BPTDvFyu3d2TdTE3L6ecI1M=
X-Received: by 2002:a05:6902:1882:b0:e5d:d340:b046 with SMTP id
 3f1490d57ef6-e608a80dd8bmr3667566276.31.1740600304404; Wed, 26 Feb 2025
 12:05:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-drm-dirty-modeset-v2-0-bbfd3a6cd1a4@linaro.org>
 <20250123-drm-dirty-modeset-v2-4-bbfd3a6cd1a4@linaro.org> <vn3f6jzx27twq7maamdmeqahvn4zzoxmdttkm7epg2qgn4ueov@hqzjzzzw3mog>
 <f9cbfa96-19c9-4187-a6fb-338296128c11@quicinc.com>
In-Reply-To: <f9cbfa96-19c9-4187-a6fb-338296128c11@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 26 Feb 2025 22:04:54 +0200
X-Gm-Features: AQ5f1JrjeueoLld3ByEUmdgq0pMBwdWmviUFLSqr9XQcrK4WXnUOkNSnAAeV5UA
Message-ID: <CAA8EJppOQidKsG-===qCHoSNTfuaLhh7Tb47Y46Un9UCfG0i6Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/msm/dpu: don't set crtc_state->mode_changed
 from atomic_check()
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Jeykumar Sankaran <jsanka@codeaurora.org>, 
	Jordan Crouse <jordan@cosmicpenguin.net>, Sravanthi Kollukuduru <skolluku@codeaurora.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Archit Taneja <architt@codeaurora.org>, Rajesh Yadav <ryadav@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	Simona Vetter <simona.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 20:36, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
>
>
> On 2/26/2025 3:55 AM, Dmitry Baryshkov wrote:
> > On Thu, Jan 23, 2025 at 02:43:36PM +0200, Dmitry Baryshkov wrote:
> >> The MSM driver uses drm_atomic_helper_check() which mandates that none
> >> of the atomic_check() callbacks toggles crtc_state->mode_changed.
> >> Perform corresponding check before calling the drm_atomic_helper_check()
> >> function.
> >>
> >> Fixes: 8b45a26f2ba9 ("drm/msm/dpu: reserve cdm blocks for writeback in case of YUV output")
> >> Reported-by: Simona Vetter <simona.vetter@ffwll.ch>
> >> Closes: https://lore.kernel.org/dri-devel/ZtW_S0j5AEr4g0QW@phenom.ffwll.local/
> >> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 32 +++++++++++++++++++++++++----
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  4 ++++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 26 +++++++++++++++++++++++
> >>   drivers/gpu/drm/msm/msm_atomic.c            | 13 +++++++++++-
> >>   drivers/gpu/drm/msm/msm_kms.h               |  7 +++++++
> >>   5 files changed, 77 insertions(+), 5 deletions(-)
> >>
> >
> > JFI, this patch generates following warnings, deferred now:
> >
> > 10:49:07.279: [  235.096198] WARNING: CPU: 1 PID: 515 at drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:459 dpu_kms_check_mode_changed+0xb0/0xbc
> > 10:49:07.279: [  235.107375] Modules linked in:
> > 10:49:07.279: [  235.110532] CPU: 1 UID: 0 PID: 515 Comm: kms_atomic_tran Tainted: G        W          6.14.0-rc4-gd229bc98da6b #1
> > 10:49:07.279: [  235.121069] Tainted: [W]=WARN
> > 10:49:07.279: [  235.124130] Hardware name: Google Lazor Limozeen without Touchscreen (rev5 - rev8) (DT)
> > 10:49:07.279: [  235.132356] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > 10:49:07.279: [  235.139513] pc : dpu_kms_check_mode_changed+0xb0/0xbc
> > 10:49:07.279: [  235.144712] lr : msm_atomic_check+0xc0/0xe0
> > 10:49:07.279: [  235.149023] sp : ffff8000843f3960
> > 10:49:07.279: [  235.150686] usb 1-1.1: new high-speed USB device number 100 using xhci-hcd
> > 10:49:07.279: [  235.152439] x29: ffff8000843f3960 x28: ffff65a18386d080 x27: ffff65a184826a80
> > 10:49:07.279: [  235.166848] x26: 0000000000000038 x25: 0000000000000008 x24: ffff65a1866fd580
> > 10:49:07.279: [  235.174188] x23: 0000000000000028 x22: 0000000000000028 x21: 0000000000000038
> > 10:49:07.279: [  235.181527] x20: ffff65a184826a80 x19: 0000000000000000 x18: 0000000000000000
> > 10:49:07.279: [  235.188866] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaab013dfeb8
> > 10:49:07.279: [  235.196215] x14: 00000000000c0000 x13: 0040a00000400800 x12: 0000000000000000
> > 10:49:07.279: [  235.203553] x11: 0000000000000050 x10: 0000000000000000 x9 : ffffbdf7fc448530
> > 10:49:07.279: [  235.210892] x8 : 00000000ffffffff x7 : ffff65a182610400 x6 : 0000000000000038
> > 10:49:07.279: [  235.218231] x5 : ffff65a18314b000 x4 : 0000000000000000 x3 : 0000000000000001
> > 10:49:07.279: [  235.225570] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff65a18ca7a600
> > 10:49:07.279: [  235.232910] Call trace:
> > 10:49:07.279: [  235.235440]  dpu_kms_check_mode_changed+0xb0/0xbc (P)
> > 10:49:07.279: [  235.240641]  msm_atomic_check+0xc0/0xe0
> > 10:49:07.279: [  235.244594]  drm_atomic_check_only+0x498/0x934
> > 10:49:07.279: [  235.249169]  drm_atomic_commit+0x48/0xc4
> > 10:49:07.279: [  235.253209]  drm_mode_atomic_ioctl+0xa98/0xd00
> > 10:49:07.279: [  235.257791]  drm_ioctl_kernel+0xbc/0x12c
> > 10:49:07.280: [  235.261832]  drm_ioctl+0x228/0x4e4
> > 10:49:07.280: [  235.265339]  __arm64_sys_ioctl+0xb4/0xec
> > 10:49:07.280: [  235.269381]  invoke_syscall+0x48/0x110
> > 10:49:07.280: [  235.273248]  el0_svc_common.constprop.0+0x40/0xe0
> > 10:49:07.280: [  235.278090]  do_el0_svc+0x1c/0x28
> > 10:49:07.280: [  235.281512]  el0_svc+0x48/0x110
> > 10:49:07.280: [  235.284753]  el0t_64_sync_handler+0x10c/0x138
> > 10:49:07.280: [  235.289234]  el0t_64_sync+0x198/0x19c
>
> Hey Dmitry,
>
> This warning is eventually dropped in the CRTC RM refactor (specifically
> [1]).
>
> Applying in this order might fix the warning:
>
> 1. CRTC RM refactor
> 2. This mode_changed() series
> 3. The rest of the CWB series
>
> This will cause some merge conflicts with the CRTC RM refactor though
> and you'll need to move the dpu_kms changes in [1] to this patch.
>
> What do you think?

I think I will make our life easier and just pick it up as a part of
the CWB series. As the warning is going to be removed by your patch I
can drop it while applying.

>
> Thanks,
>
> Jessica Zhang
>
> [1] https://patchwork.freedesktop.org/patch/637487/?series=144912&rev=1
>
> >
> >
> > --
> > With best wishes
> > Dmitry
>


-- 
With best wishes
Dmitry

