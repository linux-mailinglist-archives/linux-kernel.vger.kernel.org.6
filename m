Return-Path: <linux-kernel+bounces-535576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF38A474B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BFC16FBE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8942121D5A3;
	Thu, 27 Feb 2025 04:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XONjX9Od"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E1D21C9FA
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631064; cv=none; b=ZS7j4tRdul803OSz3yY+G00rOdlbU/DnMZj//CZAKivs2zlh4kx4NjQGagak1GskYJSMHFoXplV/R4m5XAozqmkKFO4/5UUbfrV+1tJfBpQ3xmrE4LCFgdAo6jg9g5DKVF/ErbE4E8fS8+bBuysrmrkqmK40qcw9nmLIDImQVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631064; c=relaxed/simple;
	bh=5S/D15mlBm5rVEaGgheBTXf1FTPfbkRnfOmUMhCyPoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUstglpG+iEKT6yBPj3wN/wn5fUohJha36h5SOplZ4s2uPzwLc5jOSTshhNONL09rJsLHwQTfCiJ8PdLxhLVkSZjvRAAFuqUdPQ0iBTodeQl6sEyxKLRe4CULgVc67MpVqzulFXdThzH1Svg7Zn176zTC557Jp0Qa0NWMuOgqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XONjX9Od; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso530668e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631061; x=1741235861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLdVuzI2TCYgAh/XWLKAjlWKrpOk/yX1LLIu0K4lYkg=;
        b=XONjX9OdHR7hLBVuxrdiGctVnmhmU9xLpk3Oi1Lfr6gLk7o9OErcZzehFejXSah63P
         9YzA7WBvkf9eXvM6rF/KgLITDY9MA4LlCZUlCdQgW0TYVJJ6+XtrRmZylDrW9bAv4USm
         0nIIAumQkhkLocKhoYlR6vI9LzJjmiDdsXUtVNI817MDwmAdz8imxHheBJiou/jh7fvp
         gx8xzwH+vlyUjhQlrcFh0XSufv2umpKvvRdJNtjdQ+eGbniNJRHKFTc6GZRIWSlGy6zp
         40TThxKCGxn1iIVf7ba+oSu2kRF7g8aONmJAlHuTI3xXPVMe6rffrEgqo5xTHsjPwCn5
         F6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631061; x=1741235861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLdVuzI2TCYgAh/XWLKAjlWKrpOk/yX1LLIu0K4lYkg=;
        b=S5tg2xu4UbTHi4HQnidH9Xs2lhu8mh42c97Sr3r/6omqdp8p132ohkJD3lyK9mTzKg
         2TIE4ceZ3La4Q8s1J+x+o7OE3Fm4Ss2VORbUQuPWPt8JeMSA9vBzHjNeHV8dy81kHdnZ
         h3yDtjyNM5hcWSUjipNxY2Fc4kVN0UVFt1XhR1US0FEF/hIsNxN2jwyDcmY84vIc2uTy
         cus6yGIdm5VuEIqmuF/mdmig4EQ0YOuQ4cwCqxg41idPNKFgrhfCzdI/aCGWHE5Vape7
         3Mopfb/JE47RaQosK4KxZDGCs5EBj32aAIT4FoW/osrs9K8vOKvt89CT79dNWT5psCWR
         TqvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhLBjlojeDRNzp/4HoEYp+EfdeLzcZHhTozajDlOfkhkNHnlTe0Q/FdksvCUGg3YNgCQaTzwRX5qDYX20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoZI+0MT+Vdv/RC+GJtxp2VZxsLFI+TS+h21AG8p+taayndbor
	SlmNR3xJWmy95DkM875yS8ykCcQpbqmrduo6SMtFq2DSOxGefqBXVgUbvXAG9n0=
X-Gm-Gg: ASbGncvjP8qNMcM/OoRcHz8rGmFOPPvEVgYJVnXkYdZEvE15TjTcUzz1spgZJutc70E
	9EEGX8mhiNmFaqGrGuhKbaqDolAeSLvVAhCspajpXyD4gQ8YhlGjpxpCySa0VSEFxo1Fz8NJ43B
	DtiA7W+DFIqxUN4jVJODu+O8anFlFabnn68hrncHdtcXBFoO3BeXWktSWPFVFhiDNsOlyyZbm3j
	GGeZkCzoNk4ojr5pOYqoIhRLpkIJc/+J379H+iuh68VbnA5Xp9bRcFDJA1aDspiUzerfkIcpBKx
	+X8o1vNY61tB9WEaeDIa1WXHFsPuwQAXlq8khYI5Qg==
X-Google-Smtp-Source: AGHT+IGacFctMBxLdHDN1tWIihRZ45naAvEO/U64ZOz8X8unMaO6oCxI4XQ+wFwgv3egNhj+8j8tPA==
X-Received: by 2002:a05:6512:10d4:b0:545:ae6:d740 with SMTP id 2adb3069b0e04-54838f4c919mr10727963e87.41.1740631061326;
        Wed, 26 Feb 2025 20:37:41 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:37:40 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Chandan Uddaraju <chandanu@codeaurora.org>,
	Jeykumar Sankaran <jsanka@codeaurora.org>,
	Jordan Crouse <jordan@cosmicpenguin.net>,
	Sravanthi Kollukuduru <skolluku@codeaurora.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Archit Taneja <architt@codeaurora.org>,
	Rajesh Yadav <ryadav@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v2 0/4] drm/msm/dpu: follow rules for drm_atomic_helper_check_modeset()
Date: Thu, 27 Feb 2025 06:37:23 +0200
Message-Id: <174063096234.3733075.6920964252450515341.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250123-drm-dirty-modeset-v2-0-bbfd3a6cd1a4@linaro.org>
References: <20250123-drm-dirty-modeset-v2-0-bbfd3a6cd1a4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 23 Jan 2025 14:43:32 +0200, Dmitry Baryshkov wrote:
> As pointed out by Simona, the drm_atomic_helper_check_modeset() and
> drm_atomic_helper_check() require the former function is rerun if the
> driver's callbacks modify crtc_state->mode_changed. MSM is one of the
> drivers which failed to follow this requirement.
> 
> Rework the MSM / DPU driver to follow the requirements of the
> drm_atomic_helper_check_modeset() helper function.
> 
> [...]

Applied, thanks!

[1/4] drm/msm/dpu: don't use active in atomic_check()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/25b4614843bc
[2/4] drm/msm/dpu: move needs_cdm setting to dpu_encoder_get_topology()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/7d39f5bb82c0
[3/4] drm/msm/dpu: simplify dpu_encoder_get_topology() interface
      https://gitlab.freedesktop.org/lumag/msm/-/commit/41921f231abf

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

