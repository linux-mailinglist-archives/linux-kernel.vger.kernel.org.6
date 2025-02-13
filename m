Return-Path: <linux-kernel+bounces-513483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C8DA34AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D982189974C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9413A28A2C5;
	Thu, 13 Feb 2025 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N728a3Y3"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EDF28A2BF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464933; cv=none; b=S+5DkUexGNqZmUrNTZY9t3iGxAPSAmbR6cJk0fwFlc9f9DSwc/j4QagSoeqb/lf9jUg1UeefksOa4Z0V1bRCuCU4ZbTzsZdLT+WdaSl7IvCcoeCJGF2Ta7Ptju35zz5HsBjRvwPNXCUb0nORSo+XvIym25I9o27BxTEV+jDEe0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464933; c=relaxed/simple;
	bh=NQGhOKxdr0VFUgwzEQPeEJr3Wopll3rPHlH9KoZwD78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTQpren8QbrGFgAzr1g+vtcXEpBYTOS0LTRk8Ds2f3irsYxtQPjGMt7LHHSNct7iBY7KKCIOUlG/rRkUUFak31uRus/Y1ilocdeAixONUW/+5djYsDXA+VD4ndP/HTy4ZxElFaVNL9Fxtn3awvNtNv0iZcqqiwI4g4r8UMKWHl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N728a3Y3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54508b026d1so898045e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464930; x=1740069730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RWxYWTxZAj0F+vDqmj/VMNxzXDPmkoI5uZXNhq06BA=;
        b=N728a3Y3iqiyKsZ4/85aF6f5Uxoga5Z4xt6jfpsPsQSrdTkiZWN3DT932ujiYK9cvO
         3tX1fN+ZxCKq7nMqUl7qyXSdOMU2ulE3uXybuio2EeZBjKsG6oejIjV4ks/eAmR35N2J
         uDMyRvAr1j63i2EX+lQaoNI6gMH2JUQ5uDP9DozoHFQ/pKg6QZtNuTKfTa+muolhSFvt
         EH1Q6TJJ9G8v5pt9qyww+75AYJWQFyopwjHpkMUXEFeTWvYKZMWr6F5a8tJsXGFY1nLv
         L3ipVYbyN9oBeJ95tXCLfCIfORsJ508pCtxlklsSZsN6jzlalegRcW+k/OERH5A6s5gG
         +7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464930; x=1740069730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RWxYWTxZAj0F+vDqmj/VMNxzXDPmkoI5uZXNhq06BA=;
        b=MzfAPh7FsqGgElFocXvCERAgj0S6gmpjcfsjfkam5TH0fwOnOa7lR/fNeJjYcMqLMB
         BuhVkD9n89TZau8L8mgrKKYYwvEE2lIAUqDF76CjyMfpcs8di9Z7J6QgSFK020pCnNFx
         tVAGy+TI8n09MskjppT5d1Fg0QZI6FZ1+3ZktREhn8syYhlMqG74PSUfsO1XeRTVKxTD
         5O+I+Wy2DgfMWVoXY14PubISqDZ0g71CcS/cKf1vD8nCFOq7eZcQwnxqJNpIq+2bcQlj
         s9Otx0v68MjcdvbtyVmHYLI87sNdnt3lJfqs8oUB2JsQGvri3R6hFykErnzW61WLmin1
         7Btw==
X-Forwarded-Encrypted: i=1; AJvYcCUdC3lIt7NlncRFtNYQknJQJTXiTNckvcxEQFb32fwR4D4DdlEohHTIRlBw243uq1FadHcddIw6hBCeDaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxllYJmhKchwZr/T+jGA7+Anri+GJv+Uw+36G3Tr2i+mJu6BN5F
	BPgu0oLujnfvDdo6BfpBIRhvvrqd75W/c2vV37vic8GHMTQ8B5Sw2oiwhEth+WI=
X-Gm-Gg: ASbGncuE8IcUVqWfZWfmk6ijDRExoB4vGSubslsYrULSJFGiCJzELff0GDGWv0JoHMb
	aEoTA9m2V6S8coXkNv59W0C1+7u0biR6JmK0oFtejD2gFtkcu8IHbLRAJmH6hXdussxNrJ+CoOM
	fBQXlvNcyWvOZuB0gHJXqiJibbpSMj5O5Xf7HAvI7SXFk4cLIJ8GBKuzB4E6b2ulsqJzyPWJgWm
	sU9oNK+SFLg2P9o/zFwQzKN7Suv7z8iikLMzQIfskzOLQ1tyyY/S5V+j9NtjzOM8IAp9z423Ut1
	dnwRBi+T5QuIPhcm8G+E5fySS8h8EfPCyHimpcm7fRiaJ6WWeRbTqN6Nk/Fbenlq/MBwMbc=
X-Google-Smtp-Source: AGHT+IEK8JK5DtZLaAkJMolAlSlboIjYitOyjK3vekr4hRL/4+W/nuknTnupS56IhVxnTVQaQLo3jw==
X-Received: by 2002:ac2:4e04:0:b0:542:2e09:639a with SMTP id 2adb3069b0e04-545180ea26dmr2471042e87.10.1739464929907;
        Thu, 13 Feb 2025 08:42:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f09d0d4sm218066e87.100.2025.02.13.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:42:08 -0800 (PST)
Date: Thu, 13 Feb 2025 18:42:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Jie Zhang <quic_jiezh@quicinc.com>
Subject: Re: [PATCH 0/5] EDITME: Support for Adreno 623 GPU
Message-ID: <wdeqpz7ckpzw5sx7pigcp7fjx7nf4irz23kvj6xwamv34vfyba@rwzavxd5o6o3>
References: <20250213-a623-gpu-support-v1-0-993c65c39fd2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-a623-gpu-support-v1-0-993c65c39fd2@quicinc.com>

On Thu, Feb 13, 2025 at 09:40:05PM +0530, Akhil P Oommen wrote:

Nit: subject needs to be fixed

> This series adds support for A623 GPU found in QCS8300 chipsets. This
> GPU IP is very similar to A621 GPU, except for the UBWC configuration
> and the GMU firmware.
> 
> Both DT patches are for Bjorn and rest of the patches for Rob Clark to
> pick up.
> 
> ---
> Jie Zhang (5):
>       drm/msm/a6xx: Fix gpucc register block for A621
>       drm/msm/a6xx: Add support for Adreno 623
>       dt-bindings: display/msm/gmu: Add Adreno 623 GMU
>       arm64: dts: qcom: qcs8300: Add gpu and gmu nodes
>       arm64: dts: qcom: qcs8300-ride: Enable Adreno 623 GPU
> 
>  .../devicetree/bindings/display/msm/gmu.yaml       |  1 +
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts          |  8 ++
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi              | 93 ++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 29 +++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  8 ++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        | 13 ++-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        | 17 ++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  5 ++
>  8 files changed, 171 insertions(+), 3 deletions(-)
> ---
> base-commit: 6a25088d268ce4c2163142ead7fe1975bb687cb7
> change-id: 20250213-a623-gpu-support-f6698603fb85
> prerequisite-change-id: 20250131-b4-branch-gfx-smmu-b03261963064:v5
> prerequisite-patch-id: f8fd1a2020c940e595e58a8bd3c55d00d3d87271
> prerequisite-patch-id: 08a0540f75b0f95fd2018b38c9ed5c6f96433b4d
> 
> Best regards,
> -- 
> Akhil P Oommen <quic_akhilpo@quicinc.com>
> 

-- 
With best wishes
Dmitry

