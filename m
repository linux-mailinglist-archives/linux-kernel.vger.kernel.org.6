Return-Path: <linux-kernel+bounces-384657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E10B9B2CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F311C21269
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFA21D54C1;
	Mon, 28 Oct 2024 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqe04dSJ"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220CE189F5C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730111272; cv=none; b=SSodUD4t15M6iar8dVMxlSxP0qpXzhyhk87O+/Cr4xRNwmz+PJ/dcqP/8UeboEzlRDf4TnNrJp6VFVsuHegayJXrctyoji8G6ize+e8UdLzoiBYw5zWz/HCo9bxCHD5AgkcI37zFyYS6pKx3s/LqWlfIJxdPZmGZEV+yDmHAFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730111272; c=relaxed/simple;
	bh=F0V3V0LcxCXGYV8fDcvvIAkVmPdH9FejZoN4859ONK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3HDwwgwG3N7cVfQj9kwg9QbNux7FX1qBw0RN6av0IjrxMct9w+0kE//1n2hYWZ3NueGVW2Iv58ME8VGDIFud2sNeCy64syElu8C6Uf17tH6ik1d3QAftLR4yFTxSNskT1Ha3Edy+oUdQmF/bJw/1kfAA7vzUrKeKFyaAIAbxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fqe04dSJ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e3c3da5bcdso39374867b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730111269; x=1730716069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1hKAuQ0xQZxoyb/tx5eu57U4G9jLofW7PwvgJ3ryko=;
        b=fqe04dSJV/m7v0dtRYi5ODIpflzBYSsdICxYZSuAkmCX9aKYqxLrcqbid1e9sWpRVw
         tMXCtDRTdSxOZdS3M5+11uevKszAfzc4YinL8w8tm0/DVJMu09SXYct4CB7WxLmx3EAV
         YR6iwdf2ZY4B2BpaayEpgkVdlGaaUMlNHsriJ3rX1tI76q0M/4+7bHUENXhCYBorJd8X
         xDd0m90XuO156CExX4Jgztq3dvyj2F5jRehfGbz90w4esJWRsH3Wwa2ByOW4QuR8je1U
         fVJHy/Kv664r3moTI+dIlNMX8lKd0g+O+Od86T01OBmcly+3z7YzDGWZjYJbW6u2TtFA
         sdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730111269; x=1730716069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1hKAuQ0xQZxoyb/tx5eu57U4G9jLofW7PwvgJ3ryko=;
        b=No5tgMX0aMiC/vWOaLYIRpbHRTkA9+/a5pZRtYEBEsRJPBOTuuvLat5JeXh1VX+hJ+
         Ngp3JTXgz1y3aAqkPzEXNyvgJriAecVbO5JSluJJwPtGkIFPwYXQePmwYO7o6HFaNXun
         +x33kFEkaXkXG30gLKXGbpo7a9q8iH0IrsUQriuL0PqTEE10rY/T6VdrIvKu5cWHUhVa
         W5p52CgNKpoL7TdLFNHLnkzz18NDsn1XPsxk2RkFdV+HZgE2ntV2I2vsw230Mf8Fbkut
         JFLWn9wbwnLQHgkYHGKKS8+eMiBmVoW2jwJBp1IXkurxBOsjV4bHHbjylfY+EC2ck4nO
         3oLw==
X-Forwarded-Encrypted: i=1; AJvYcCVUH4Zd+LFnPkPnoybOJ75CpiscfT3gAfmZlcZO9pgywroQPxoe0sz7/q3tKp7WDsXu9eyCTZNACsdKo2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrEP5aQMYIwt2XvK+BFOmE1mylNC1rdl7zxyGnRfYSYRnbEUpM
	utsNp4NV2klo1IzQvt8teayUZM6gfQpkwCIavwL0HUiSjuezqu4gulmWvz3PrFhL0x+tyFa7E1p
	1HxmUHVjbwlA+pdKSmzkpImY08r84IBi0s/amFw==
X-Google-Smtp-Source: AGHT+IGLe+4t7S9ZSveqwANNEzKdjUad0Z1HtQTFx3PEGKze+pVHMLOD52kyDgR3LowLm6wgDiAgoEwd56iMjidmX78=
X-Received: by 2002:a05:690c:48c1:b0:6dd:beee:9218 with SMTP id
 00721157ae682-6e9d8b1754amr70515197b3.30.1730111269077; Mon, 28 Oct 2024
 03:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027-stack-size-fix-v1-1-764e2e3566cb@quicinc.com>
 <j2qapo66f64y7ddqlu63dqvog2fdbhnaq3t24wp2srvdt4v7xl@fyqu4ry4wmts> <6fea85fc-ccdc-46ec-b612-3712e9431301@quicinc.com>
In-Reply-To: <6fea85fc-ccdc-46ec-b612-3712e9431301@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 28 Oct 2024 12:27:38 +0200
Message-ID: <CAA8EJpodjP3rY0Twe9sP37LWwk5ppP36dyLC9WKD6CTDOtmwzA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: Fix excessive stack usage
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 12:08, Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>
> On 10/28/2024 1:56 PM, Dmitry Baryshkov wrote:
> > On Sun, Oct 27, 2024 at 11:35:47PM +0530, Akhil P Oommen wrote:
> >> Clang-19 and above sometimes end up with multiple copies of the large
> >> a6xx_hfi_msg_bw_table structure on the stack. The problem is that
> >> a6xx_hfi_send_bw_table() calls a number of device specific functions to
> >> fill the structure, but these create another copy of the structure on
> >> the stack which gets copied to the first.
> >>
> >> If the functions get inlined, that busts the warning limit:
> >>
> >> drivers/gpu/drm/msm/adreno/a6xx_hfi.c:631:12: error: stack frame size (1032) exceeds limit (1024) in 'a6xx_hfi_send_bw_table' [-Werror,-Wframe-larger-than]
> >>
> >> Fix this by kmalloc-ating struct a6xx_hfi_msg_bw_table instead of using
> >> the stack. Also, use this opportunity to skip re-initializing this table
> >> to optimize gpu wake up latency.
> >>
> >> Cc: Arnd Bergmann <arnd@kernel.org>
> >>
> >> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
> >>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 34 ++++++++++++++++++++++------------
> >>  2 files changed, 23 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> >> index 94b6c5cab6f4..b4a79f88ccf4 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> >> @@ -99,6 +99,7 @@ struct a6xx_gmu {
> >>      struct completion pd_gate;
> >>
> >>      struct qmp *qmp;
> >> +    struct a6xx_hfi_msg_bw_table *bw_table;
> >>  };
> >>
> >>  static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> >> index cdb3f6e74d3e..55e51c81be1f 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> >> @@ -630,32 +630,42 @@ static void a6xx_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
> >>
> >>  static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
> >>  {
> >> -    struct a6xx_hfi_msg_bw_table msg = { 0 };
> >> +    struct a6xx_hfi_msg_bw_table *msg;
> >>      struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> >>      struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> >>
> >> +    if (gmu->bw_table)
> >> +            goto send;
> >> +
> >> +    msg = devm_kzalloc(gmu->dev, sizeof(*msg), GFP_KERNEL);
> >
> > Is it necessary after being sent? Isn't it better to just kzalloc() it
> > and then kfree() it at the end of the function?
>
> Keeping it around will help to cut down unnecessary work during
> subsequent gpu wake ups.

Then, I'd say, it is better to make it a part of the a6xx_gpu struct.


-- 
With best wishes
Dmitry

