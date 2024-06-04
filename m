Return-Path: <linux-kernel+bounces-201579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A238FC045
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0FB284E53
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1861914E2D5;
	Tue,  4 Jun 2024 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWAdxt1B"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7711014D449
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717545532; cv=none; b=GrmzQBZiURYyYl/mVVTX73jv3cTNNIhlx/wMv44Ytfy8O19euE8NK557K53onNl8IcCHn3vc0wzC9Jn6jaNLJplV2BNFcj1TGjd+b7lM0BfnSJG4qTspi5yqwlQbHd1VcHZTKfq2/HF1dxgpWZbvnkTh033gRM7fobswZV1anFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717545532; c=relaxed/simple;
	bh=5DYP5HfvT6avEgkh8azMkM/37TvT5NYeoXqF8n5mMds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Af+325SOQFJjXx6A4oR5Jn/slnazkA51LfKwZRiF0Ho8p6ViCU8up8BZP9pMu1uKqLobJ1717yobSwQM8kEayGbUvWPsHeTrC4w28LQglAyC+0sGexK3nd/k4/BqTuWInBiFVQP/2PBHNiFH0KvTqbGzGpunW/DL/uoU20LieVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWAdxt1B; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b91f655d1so358180e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717545528; x=1718150328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rp9nxGMclyuCeHHBHlnWIxO2+4DK9PTywFrhJz5uXfc=;
        b=IWAdxt1BGOZ+iHBDd9lLJizLF7Dcd/0sXvu9I4dxXK8oPxB6m9y+3JRyHVtBqXwPcr
         0bUV38p5EYt5tV3BDZpihABfVoqsz8o9vg9J62ZJLwdeRwJYGLQU+/udCTz5wFekA+Ju
         MGQWaUTLnn08CJ5k9u9svvr6r8cIGXbEu1LQaQedCGob23uVGKI8X7bHvxyf4RAt1s2S
         NXA06RNQpj0v7iPjlkriXzdF32Jb982Q+WARw/JfK6By58EaZpj4W3VqnwVDzvuzf9/H
         sBC1j9ilfS2aPYDrAlZ+p1m7F24udK7dbCNnHgvduLLLgCvzbE7e4nNxWprEbh9MGELY
         1wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717545528; x=1718150328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rp9nxGMclyuCeHHBHlnWIxO2+4DK9PTywFrhJz5uXfc=;
        b=v9QYaWEWXJ++Oq9sXBQoP1C3jgaznLX3m0i7N1aKEi9vLPQvKNW3yg5uXA1pz1ZC9D
         ubmYpV2Gen+etv9xOIP+68YVj9UZkWJbKyDyl9KcEtr2hhHpByZ6no/tC8BJgJiak6X0
         QUZ/SGY+vCLf5ApIP4Goz+WDlYXtyt0C5nwtKui31Th+StTtnmBCXao+4DbnTlxxBwgM
         2Cmv1eSad6zKNHb6XLCv2MOZWTjDgYCIAxOUcv7SdWGVk2qItd0boDNGLi1K8nJ1HSL+
         JqjokcQoEOlaA/BilMT+maN1IrfGQt17n9Z6rVJcxrw3FUCO8EXxbXbz1tznyhX/Zrfg
         aTiw==
X-Forwarded-Encrypted: i=1; AJvYcCVx5mDsG+h7vHqI7+qwcNp4z3ymTeR1bx9llf8ZgK2s+J+F/4kzfStQVFit4fcvjNFWYl8yL4JJnvtKQ374VO56dCCz3gZciE4dDXXG
X-Gm-Message-State: AOJu0Yw8Sz5dhOpNABUGOe8mtMtVNA7w5t1Hl0qsKwBoukkrjn6dxJAx
	VMqaGzlLO0GUvslvm2pLmZlP7jHEoyyx+dMy6mWOsrjF04GAuxmSmMbSL8fVeBw=
X-Google-Smtp-Source: AGHT+IGE5EAJbwmPWB5kOhL+AkptvaK72rTbxNWsv9SyRDnHh+4+XE5+D1sVii4uysOWoD6ZlewHtg==
X-Received: by 2002:a05:6512:3d9e:b0:520:359d:2145 with SMTP id 2adb3069b0e04-52bab1d6879mr307776e87.20.1717545528496;
        Tue, 04 Jun 2024 16:58:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d89ee8sm1624847e87.268.2024.06.04.16.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 16:58:48 -0700 (PDT)
Date: Wed, 5 Jun 2024 02:58:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Connor Abbott <cwabbott0@gmail.com>, 
	dri-devel@lists.freedesktop.org, seanpaul@chromium.org, quic_jesszhan@quicinc.com, 
	Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a6xx: use __always_unused to fix compiler
 warnings for gen7_* includes
Message-ID: <x42z2ykkpx7qkn2lr3y5sl3lm2m3fl2asy7qvswgemz5bpu62w@drh7b7wihrwg>
References: <20240604215105.4057278-1-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604215105.4057278-1-quic_abhinavk@quicinc.com>

On Tue, Jun 04, 2024 at 02:51:04PM -0700, Abhinav Kumar wrote:
> GCC diagnostic pragma method throws below warnings in some of the versions
> 
> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:16:9: warning: unknown option after '#pragma GCC diagnostic' kind [-Wpragmas]
>  #pragma GCC diagnostic ignored "-Wunused-const-variable"
>          ^
> In file included from drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:18:0:
> drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h:924:19: warning: 'gen7_0_0_external_core_regs__always_unused' defined but not used [-Wunused-variable]
>  static const u32 *gen7_0_0_external_core_regs__always_unused[] = {
>                    ^

I don't see this symbol in upstream.

> In file included from drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:19:0:
> drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h:748:19: warning: 'gen7_2_0_external_core_regs' defined but not used [-Wunused-variable]
>  static const u32 *gen7_2_0_external_core_regs[] = {
>                    ^
> In file included from drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:20:0:
> drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h:1188:43: warning: 'gen7_9_0_sptp_clusters' defined but not used [-Wunused-variable]
>  static struct gen7_sptp_cluster_registers gen7_9_0_sptp_clusters[] = {
>                                            ^
> drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h:1438:19: warning: 'gen7_9_0_external_core_regs' defined but not used [-Wunused-variable]
>  static const u32 *gen7_9_0_external_core_regs[] = {
> 
> Remove GCC dependency by using __always_unused for the unused gen7_* includes.
> 
> Fixes: 64d6255650d4 ("drm/msm: More fully implement devcoredump for a7xx")
> Suggested-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> index 0a7717a4fc2f..62ca0cf24005 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> @@ -8,19 +8,10 @@
>  #include "a6xx_gpu_state.h"
>  #include "a6xx_gmu.xml.h"
>  
> -/* Ignore diagnostics about register tables that we aren't using yet. We don't
> - * want to modify these headers too much from their original source.
> - */
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wunused-variable"
> -#pragma GCC diagnostic ignored "-Wunused-const-variable"
> -
>  #include "adreno_gen7_0_0_snapshot.h"
>  #include "adreno_gen7_2_0_snapshot.h"
>  #include "adreno_gen7_9_0_snapshot.h"
>  
> -#pragma GCC diagnostic pop
> -
>  struct a6xx_gpu_state_obj {
>  	const void *handle;
>  	u32 *data;
> @@ -1350,6 +1341,10 @@ static void a7xx_get_registers(struct msm_gpu *gpu,
>  	int index = 0;
>  	const u32 *pre_crashdumper_regs;
>  	const struct gen7_reg_list *reglist;
> +	__always_unused const u32 **external_core_regs7_0_0 = gen7_0_0_external_core_regs;
> +	__always_unused const u32 **external_core_regs_7_2_0 = gen7_2_0_external_core_regs;
> +	__always_unused const u32 **external_core_regs_7_9_0 = gen7_9_0_external_core_regs;
> +	__always_unused struct gen7_sptp_cluster_registers *sptp_gen7 = gen7_9_0_sptp_clusters;

Wouldn't it be easier to add something like the following to the
a6xx_gpu_state.c before including the headers:

static const unsigned int *gen7_0_0_external_core_regs[] __attribute((__unused__));
static const unsigned int *gen7_2_0_external_core_regs[] __attribute((__unused__));
static const unsigned int *gen7_9_0_external_core_regs[] __attribute((__unused__));

>  
>  	if (adreno_is_a730(adreno_gpu)) {
>  		reglist = gen7_0_0_reg_list;
> -- 
> 2.44.0
> 

-- 
With best wishes
Dmitry

