Return-Path: <linux-kernel+bounces-535583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 161CAA474CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B08188F7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2E1D4356;
	Thu, 27 Feb 2025 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qgZEgt/J"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD822CBD7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631076; cv=none; b=AmqAwU6vTNIUZsHiel+XjuQIE0yXVgKPc4R/fuJ+rf4pAEtiDcgNlCpBDav62GXF6esEQsXlqYfga1xiSkIwstN8LYNapmFI8h9uSnTcKH0LGqGvla+S5TSx0BWBm0B3t6ZMojYMTNoIuBRUR0s6Tj95yyOAXTwpGCHtAI/CnOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631076; c=relaxed/simple;
	bh=QRZLpSNEAnOL32FL8Ctxebt8/NOfyWU/ufQwSk6Z5Zc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKx2cAok9lLH3pCom4YVnz1BP0bsfjkoPbyICE3SvdvkrlTQ6KDABK1iEisuBkJ7y6PCAtdIWHy2wV0OzJ1Opd9p4SAp3y/SdpiAjkxS6BxhNbeFC8fYh4Oh0L9DMj1Dk10+q69u0SIMXObK+8b2K9bv/LxoVoUlb/1fxy68AoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qgZEgt/J; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-546210287c1so457752e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631073; x=1741235873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQXAVAgDJ6BKpu5knilW0G0eInEdBbGOYFBZny+389w=;
        b=qgZEgt/J2Awrp4I+uZ4PUSUrJDpYGkW6rmmmtZUrmSK7Ba7ZBCpwNM3cdEGQw75Af0
         kl+MXYh3F9F5J9CGO26jpxCqiG3IkOF8kfgBbX+D9kiYvOU734KgeC5UPT17M0YaijaH
         D/fsp9EczZwuJKMQdqaoSscwV/ClDfTMrFKyg5pmRerfVrFzKh4RPeNFzJ2w4m2AP/bQ
         0bNND+eJhuyRrQBDSw68tG76Q6iSVnXe//gq8+RKX7wrrrM7JQz9NZe4Xj/K7KJV8zqX
         TRpZjw7g7/gu36wWmU51K5uyfb9eWv9cS1KFYWEORN7JzsXYGrFIdy6SksLDmnp36m+m
         W9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631073; x=1741235873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQXAVAgDJ6BKpu5knilW0G0eInEdBbGOYFBZny+389w=;
        b=NNZ0i64S/G3aY/d2wR0Q38AgjL/CpkKxpbVP0KkI44L0TDy39Pl5aGqEoDpMSY4hxI
         xAaiqMDCXJ4uu93KZkEZmymovDe/6uu3RRlDl3mcS24KKgw+F9ZVVYrNUke+7nxVhZSP
         MLFLzizm3bQHWyEw9ucclwzsMPnwzXQQEFTxiEfa66alMaQndlp5Icpv8+DlEBBOofNL
         O3I4AIY00ZW/vCRecvtKtgUDk8GU378oLLFm8nbANg6p6Y67oN1LiVU65Jw/Igk3vFY0
         fHu8++NIJxmeDV1vGLAr87dTg46E7del69p4yjPwrsVhH8Oxf7BRb7rb+FWy3F7wnMkQ
         m/ew==
X-Forwarded-Encrypted: i=1; AJvYcCWlyIuzl0mgRC0De7fopS0CDprXTEKxugWy6aI+L9zLeiZ0vp4oMJHKeaylh/kFLHMrXNTDqed67Suqdm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4bAKNnwHLz0yNHjh7CSnVPZfZQL5YoMuaZWi86jUfzpXNA+u
	e9RyMryPNrPBhyBMviR55kQONfQ6tAMS9A5HjcyNEGTQS77uLRpv+vaWts4givc=
X-Gm-Gg: ASbGncs6FjjifsBdCwQ1cnxsYKBNitpI2pXvcQI8Hp+4q1XUtI9BQZi78E/mg1yt8jL
	OqqtJtMg/s0ogtNxybTCOkqy8ZjDvc8pavWiMsXcq7PctphjPGMWrOMRGEW2omBxJ9WPRz1WVJ6
	WGVvkPP6myiqrkpXmzg5zzTuhxALx+kxfVD0Ok+CKeBTMmGzC6/99rStIUly47JkqPG5BJc9Kq6
	/W3zZ08LtIK958keQG3Q4i2ouDvBDwprXkXs9WxVYoK5l/x2+d89BgyHy9bGPS6xWX/sIhZja9o
	PfAn/A943Fa9NrZO6dxoLUqZRwgHG4ps8a2ZCg6mnw==
X-Google-Smtp-Source: AGHT+IE/BaugbmI5byqUClykJvO63QUq6xSxLwwkVKoSd9babs5cKTzcwdFko7WC+SL5Xw2OEWmMdQ==
X-Received: by 2002:a05:6512:31c9:b0:545:981:1bc4 with SMTP id 2adb3069b0e04-548392598d7mr10071939e87.38.1740631072721;
        Wed, 26 Feb 2025 20:37:52 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:37:51 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RFC] drm/msm/dsi/phy: Program clock inverters in correct register
Date: Thu, 27 Feb 2025 06:37:28 +0200
Message-Id: <174063096232.3733075.4572201293177555361.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129115504.40080-1-krzysztof.kozlowski@linaro.org>
References: <20250129115504.40080-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 29 Jan 2025 12:55:04 +0100, Krzysztof Kozlowski wrote:
> Since SM8250 all downstream sources program clock inverters in
> PLL_CLOCK_INVERTERS_1 register and leave the PLL_CLOCK_INVERTERS as
> reset value (0x0).  The most recent Hardware Programming Guide for 3 nm,
> 4 nm, 5 nm and 7 nm PHYs also mention PLL_CLOCK_INVERTERS_1.
> 
> 

Applied, thanks!

[1/1] drm/msm/dsi/phy: Program clock inverters in correct register
      https://gitlab.freedesktop.org/lumag/msm/-/commit/baf490728777

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

