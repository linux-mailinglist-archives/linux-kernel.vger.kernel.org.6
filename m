Return-Path: <linux-kernel+bounces-201807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB3A8FC36D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197F1B22B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2262C3DABEC;
	Wed,  5 Jun 2024 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHcRfxUn"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6E21C183
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717568964; cv=none; b=HgHIMJov1mmmNsYm74EbtzowQ1ivB4YDxCJCc5IOG/c1rBnjZhCt7m+mzJgUhAo42Qr+bijbmh4/zSPEsD++WJE9+u11iVM+iQJ9cdAbZGPbawccTcAcJcXI8pLet3B3OpzFUq74OZWJ78diVTXX226pjK+Ok8LDJ8trujDrDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717568964; c=relaxed/simple;
	bh=8MKNSHs8EGOAIZ9jigkySNhXca9mZ6lM0o1BuxSWNBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dlp+NEiseUZe1O8oya6VIqitVo+/RzRa58RFPvQ0IIR1ATNr1d9TSgpiIGYd8If9PhMnS23DOWOlHHsxSE/vpkzeUZSaoEK59EJ8G+SPA6p4N1UN3IV7HH5jX5j4kFfDUDDMWOM1TDEJW7qVCUjqxecTc4wZhGVGHVeueHyoudI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FHcRfxUn; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b90038cf7so5341222e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 23:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717568960; x=1718173760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ/23iqkxXhCu+0zyqHfXdCfh5GsXoO3Ru5EztY6RCw=;
        b=FHcRfxUn+BpbyI6o91DoMiD9KAgc4o4f2dWNdUbU66wrMlsNzGUvmByNSWC13Yjvx7
         CVNNYJ5bTn8krmLAlvpv9i3EJBdTV03UapQj3N8HQNO/bKuIdbx9VxCGKbeTPYLa3Er4
         HhzYV1FSPpIXqjVqjtid54+gDXkQL4iQfvJfpokh3DgZ7meIfHf6pATYR+NyRsCtV4pK
         s7C+/b1oVZnyGn85LGVwLipCa1yaJnQtJSj1TlbIeYRkpvr12K4aaYGXIr68jbCsLA2s
         +wFGyCWpHOWAlaAtoxty/6gZ7f0p2gRTch2nES90HcQM7UL+4IBJOVn4vGjfbmBUaLCK
         oCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717568960; x=1718173760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ/23iqkxXhCu+0zyqHfXdCfh5GsXoO3Ru5EztY6RCw=;
        b=J61phzvbEh9YRJJuCKH7w/sxUP/SIc2ur2eAqV+A7anTFUBxpkYDP1vLzr+MX3n0kJ
         uIR73n2Csm78cBsWE0FgQ5GWwXiM82b7oupchxfmT30+1gbei2ChtHGk1S3i/tVoY562
         WkkdqVjSU91i5W/KdT5aTjg0easOiubuFyQbY5Oo2imCSTDD64AEGyrrGnVkAfhxYtlw
         tzzjhl2sQvquGDik4ljLu/WnLjK4v4BzWtA3o9fmAbrUXep13+EEU3+GqG1uK46UkFvH
         es0/k2VEtKwcxPL3GICZUscQLINI/kJwpXrDmvCaxSjnkZEU95oAnNVW8KH2VHib7j8y
         +fhw==
X-Forwarded-Encrypted: i=1; AJvYcCXlPsSlCCKid/2EGltUyygvThImdrkR+5qU8JbxrPU/XVNFpc2AlP92ytb4qoGXbR7LDY1rOb5/qnMbPtApwUumHK9Z57vbL097TKr2
X-Gm-Message-State: AOJu0YyveWtVbyRLiZvRPEl3vnSy3ta5vvkAuKWioVhxzRNrPbd4cgUM
	ex+nb5Sb19ET8opqsdibQK1tUYRanM9B7vYvnpO6lAfMadYkUZY9gKY2pt1qKdw=
X-Google-Smtp-Source: AGHT+IEMB9B/0I44cfP8n6kV1HLDOy5FxC94CDo+3545zQnZBjIiD9D2HCEXMElemi0yaQa7rQDptg==
X-Received: by 2002:a05:6512:3056:b0:52b:7945:a434 with SMTP id 2adb3069b0e04-52bab4bd908mr1013426e87.28.1717568960298;
        Tue, 04 Jun 2024 23:29:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b97a15436sm943344e87.96.2024.06.04.23.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 23:29:19 -0700 (PDT)
Date: Wed, 5 Jun 2024 09:29:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Connor Abbott <cwabbott0@gmail.com>, 
	dri-devel@lists.freedesktop.org, seanpaul@chromium.org, quic_jesszhan@quicinc.com, 
	Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/a6xx: use __unused__ to fix compiler warnings
 for gen7_* includes
Message-ID: <zgg52ydg2w4gxgmsfwte5houkns3rikdfz375oty6bappf5eud@gekg6ynavdpv>
References: <20240605003829.4120343-1-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605003829.4120343-1-quic_abhinavk@quicinc.com>

On Tue, Jun 04, 2024 at 05:38:28PM -0700, Abhinav Kumar wrote:
> GCC diagnostic pragma method throws below warnings in some of the versions
> 
> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:16:9: warning: unknown
> option after '#pragma GCC diagnostic' kind [-Wpragmas]
>   #pragma GCC diagnostic ignored "-Wunused-const-variable"
>           ^
> In file included from drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:18:0:
> drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h:924:19: warning:
> 'gen7_0_0_external_core_regs' defined but not used [-Wunused-variable]
>   static const u32 *gen7_0_0_external_core_regs[] = {
>                     ^
> In file included from drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:19:0:
> drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h:748:19: warning:
> 'gen7_2_0_external_core_regs' defined but not used [-Wunused-variable]
>   static const u32 *gen7_2_0_external_core_regs[] = {
>                     ^
> In file included from drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:20:0:
> drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h:1188:43: warning:
> 'gen7_9_0_sptp_clusters' defined but not used [-Wunused-variable]
>   static struct gen7_sptp_cluster_registers gen7_9_0_sptp_clusters[] = {
>                                             ^
> drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h:1438:19: warning:
> 'gen7_9_0_external_core_regs' defined but not used [-Wunused-variable]
>   static const u32 *gen7_9_0_external_core_regs[] = {
> 
> Remove GCC version dependency by using __unused__ for the unused gen7_* includes.
> 
> Changes in v2:
> 	- Fix the warnings in the commit text
> 	- Use __attribute((__unused__)) instead of local assignment
> 
> changes in v3:
> 	- drop the Link from the auto add
> 
> Fixes: 64d6255650d4 ("drm/msm: More fully implement devcoredump for a7xx")
> Suggested-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

