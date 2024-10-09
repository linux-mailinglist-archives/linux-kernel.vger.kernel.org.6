Return-Path: <linux-kernel+bounces-356470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5919C996193
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB071F22894
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CFA18801E;
	Wed,  9 Oct 2024 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONmeaXsI"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEDB187561
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460562; cv=none; b=SiB56ZKagBdBI6RekIxGSRETJ7CrYlfOrdMIzsF6VT12DEjO5TOddbQDomCZV9c6fuojmpi/dbNAVv6RnSriGz3+31h+fYZ0fBIRAQpBG0Fq9vwMcNfgrMhuJ+fMTOQYSi4zxrizUsSP+7M/syz6LWmPqNwuX5DP0NsnvYEtRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460562; c=relaxed/simple;
	bh=BES9Dtvu+CA2rScooy32VOOPWYbQJzdHB0CqcjuSaVQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fhM9+x+Ks5TS+4lPONyJzptfUfAO48cl1fwLHVYcSSS6/3KMMmEyuYVWUBW2iOff0PEoA3BBQVKIAtEFFdxK+X7541S7m7AccydGtETSX7GV7emsB3amnQ52cay+xefyjlcDhpSdxUpyTHp2UByB56/vNn73GAXweV4ssxrU5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ONmeaXsI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so66596015e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728460559; x=1729065359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3mGdhkESXbSGOutFwSjJARGpxBweZTtd236mLhsQ9g=;
        b=ONmeaXsIqCS7oWDBZ+nLKE1eoQcXGBf1Ep+X4abOuS6CYIUVgvt2iGVXw+T4WVczbZ
         1XN1EVEekaffdLeFyosJUEAL2wCmDTAb14vDGSTHSanTic53TpA7BVcHBTQEcNYw3f06
         jWaHrnXx6bIwYtTQT16pCdcbSPfaMjlmEjunPHBjPxmbwo3bVr7e2N7dwcoDPrIexSzY
         S8bPTO++XzFWiP4CVLmBEOrT60zhzj6cZPs6/VzU8HreYjnoWUS60kpCQElwDH3l8WdS
         mEHUgJ568vWKn5O15sbs4/k9aR8kIUtyGpY6G9DMjx0OIU3hhpOiHhvOUCKMuptSUDDF
         JZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460559; x=1729065359;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3mGdhkESXbSGOutFwSjJARGpxBweZTtd236mLhsQ9g=;
        b=wpsNXdpbGw8QLoazT8q05okSCBdNuJsZuOodn0d+AjywAYFqD7zRCVu6Pnhjg7B9/9
         /IocZfJ7L+gYukSh+B2AMv82y0JNtnCYJOMNLdKlk/eHLqtFCswCu7oEFcK1HHuQwqNV
         7krZKWk4kKOGOX911NOMxylS27aDLaEUbNF0ssxMIP0hM9ae29BVWvWdxNLQUJ15P3iO
         Fj1EemDVgIIbNCqBoHN4x50iIHdrLyJ9AizAUsg3Q3Fr4IeGMh59Ha+QVY0aNy00gunU
         NJ2zATdW2lDSPMwq5eJNlzB0FYg8Yy+M1HXZ2SBd8WGaf/fqSDEOyaJBCRso+hsE+0ki
         oYDg==
X-Forwarded-Encrypted: i=1; AJvYcCX+AkbKXBDjp6vj9Q+n97PzBZVG+fdKf+u8QldOVXmCtK+/IoNDqRe0nEk/VLslScxsE0DhTi5/z1nNvdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWEGS5hZujnNcemRlovxIC8aCpjaVj//N0WkYEr0FIapRJ1VXx
	iWYjMn4yVZg2/XIfMoB/XTpl0/IgB+MA0BWn+ea84/QpKzfxAD0Atjac12V+vRM=
X-Google-Smtp-Source: AGHT+IE3teKQjoC11XbHKw2dnXg8kunMSFpC6LsgSmK3CTM3I5DuVWJ55y7TScmZP6415W7EVrP1tQ==
X-Received: by 2002:a05:600c:1f0d:b0:42c:e0da:f15c with SMTP id 5b1f17b1804b1-430ccf511eemr9491165e9.20.1728460558648;
        Wed, 09 Oct 2024 00:55:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972fd9sm9660342f8f.104.2024.10.09.00.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:55:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de
In-Reply-To: <20240626-drm-panel-ili9881c-rotation-v1-0-e0ff54173e32@pengutronix.de>
References: <20240626-drm-panel-ili9881c-rotation-v1-0-e0ff54173e32@pengutronix.de>
Subject: =?utf-8?q?Re=3A_=5BPATCH_0/2=5D_drm/panel=3A_ilitek-ili9881c=3A_?=
 =?utf-8?q?Support_in-panel_180=C2=B0_rotation?=
Message-Id: <172846055704.3028267.5069542346452493531.b4-ty@linaro.org>
Date: Wed, 09 Oct 2024 09:55:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.1

Hi,

On Wed, 26 Jun 2024 16:40:37 +0200, Philipp Zabel wrote:
> The Ilitek IL9881C controller can rotate the image by 180°. This
> might be desirable on devices with their display mounted upside down,
> that don't have rotation capability in the SoC display controller.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] drm/panel: ilitek-ili9881c: Explicitly set address mode, allow 180° rotation
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b64e7d59ba75b1b080a65da20ffe0bae532854b5
[2/2] drm/panel: ilitek-ili9881c: Report subpixel order according to rotation
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/655b92ca60a2d3fac83e8974fd786da6aea7fca2

-- 
Neil


