Return-Path: <linux-kernel+bounces-535585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E19A474D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B68E57A67D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60A22DF9F;
	Thu, 27 Feb 2025 04:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z49xeXAw"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160BD22D4ED
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631078; cv=none; b=n8mZsjMH2K9r7JD38hCoiKX5q+0YFXuSV76N5eL4Qv5i0U1yf0j7aGRu9JVOGWQB7wNFpYhx/ykI/oLwIvuVQV0rpA7OscoTHjHehCMik1h4n62665YgRQRQZVsGiirEnf6ILsRLPY6+IkKA2LVifXbkpXxF4PYAYGBD5HYOOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631078; c=relaxed/simple;
	bh=3zyLLsNGRo/NqxJBZh+XUixvV4IVu35ZfNffeLgMl5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUW/GRC95+9YUw/DpfCm+3unjmrRyJA+pCD2bLQ2/WzhdDByP+BW3D/8zveLDNToHOqu84kjxjzvnNzejaZKPt7UfcjuHLiSoR5h5jqCTcocPE4XJO8WfNI9C5gRs+B44drqdngMoVOUIULA2DUr0WVf/NgxxFRLoshWHTCxNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z49xeXAw; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so6447611fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631075; x=1741235875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6XslM7pJXykrnKKkRhn2NSz+JQLPJqLzjVxpIMfxMM=;
        b=z49xeXAw6ZvAzmo9xOklNM0NR68KG2z2RmMmF+fr6YEq10iwkPAOPGYw9qXejZC0LI
         1MjzxA9y2vuDaaxywLe59DcJsR4HiGU73ip+H7WvXyo4xr9BDnDztvFQoCCmuo972B3D
         jk3AvLQZkQ5rvd05prAkCIVveE1xrjTmupgfBmhc5JUl7LuTctVQQUhPynXSa8ftKkR3
         fzEVziH+9Hu8x9k/8BuXScVyCD0yTy5gC9R2r1gN9DAw1Ju1UWDZ2HOSTKrwmgi0fGhO
         k0m6+KOS+D64okD0l9qqMlLcpH6zO+pCILRagsQqtlxmXs0FdtezZ5hVJojvOLxgK9oV
         Kwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631075; x=1741235875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6XslM7pJXykrnKKkRhn2NSz+JQLPJqLzjVxpIMfxMM=;
        b=P1wiNevOejmIKXPZrztgPv3F9mNWrBLKm8QikOobBLuDtHw/+yTYwT2OCuNa6WstjS
         dUHhAA/MWgKRvW8ewEkR3Nip8lyP6tSfijBvnJTNA57DSaS+YQeoblNZ6BJAPMG6DfuS
         +QMH5N5cVG98tCoIYgeI1tDWPNTmeiqTIllc1UCW+SRN5RHSdbC2/P8076nRGMAkkeNr
         vYyTHNRnedotFPtXCjLuc43ZUAyrZCpXcj8QdGDtnk1YoOTDfikw9xaz29gDS5z5Ps7Q
         bAFKAh/6c9LOcmV+LuLr1NVsqNlSMxiDrzgr4wX67Oc+3ZNVPMS61EGvAesRJBMf48NL
         yGBw==
X-Forwarded-Encrypted: i=1; AJvYcCWNnRDyYElbiTU4LcEjWP9SEHuSGvjfa7bTeJvmCXNANcqPbHculA4B2/GMzkfb5gKuRrwIuU4mxHZVouQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNVWkPxtpofqkWFb1f9hvFuyAnt51Ic5RocjeFq0e1SPxWTEpV
	i04bP2O6tNsrOPq3QDrLmnsjdTzOnqsJBXxxHlUuoubkY/LbAztZKQWOonmcLlE=
X-Gm-Gg: ASbGncsxFkB1AiYwfX3Nv3Gl/12FJO3TE7dXC2LbHk9Eh+j+dV0dylDxy1Udj0EztV0
	GfJvlKdDbcIZLJtx69h69Fyx5HO40oKSwd+E3P1cskMwuqDCevgPG79VvGa0xKP4DOARumtjSFa
	Lj4y7DlFRfJCCZg+o0Yvnw7mKOIsaqfgVo7g41BWvXePmcFHx0xwvavqP1Va1+PAwcQBllKuWvl
	aTRotke2VSRxPfgAXbNLHDgE2tINk+UJoA101TVuahSLzY+hS81zsXsf9vI/xjZz/SA04OoCLUV
	XLZ8fmu34yT+5LcRSmu+cHy2OJ4SXMXwY8q6gb1hrg==
X-Google-Smtp-Source: AGHT+IG/y3BiL2mYCdzvxaR3HQ4vcwVJ7Z9hxPTuLMNoKwnf+P+hPCClI8k7cx+mmtTgSswFFHqxIA==
X-Received: by 2002:a05:6512:39c9:b0:545:fad:a747 with SMTP id 2adb3069b0e04-5493c56f259mr3879927e87.5.1740631075092;
        Wed, 26 Feb 2025 20:37:55 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:37:53 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] drm/msm/dsi: Minor cleanups
Date: Thu, 27 Feb 2025 06:37:29 +0200
Message-Id: <174063096231.3733075.12973526206464749561.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
References: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 14 Feb 2025 14:17:43 +0100, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Patch #2: Update commit msg
> - Tags
> - Link to v1: https://lore.kernel.org/r/20250106-drm-msm-cleanups-v1-0-271ff1c00795@linaro.org
> 
> Few minor improvements/cleanups why browsing the code.
> 
> [...]

Applied, thanks!

[1/4] drm/msm/dsi: Drop redundant NULL-ifying of clocks on error paths
      https://gitlab.freedesktop.org/lumag/msm/-/commit/709cc0620107
[2/4] drm/msm/dsi: Simplify with dev_err_probe()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d5bc3c3389d7
[3/4] drm/msm/dsi: Minor whitespace and style cleanup
      https://gitlab.freedesktop.org/lumag/msm/-/commit/cce156257ed3
[4/4] drm/msm/dsi: Drop unnecessary -ENOMEM message
      https://gitlab.freedesktop.org/lumag/msm/-/commit/b39e7014ed31

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

