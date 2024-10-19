Return-Path: <linux-kernel+bounces-372893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C86A9A4EE9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D374E2880C0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8455717B427;
	Sat, 19 Oct 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFArfZbb"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225122338
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349837; cv=none; b=FSR1I2rZHRWFfpMJb/9MA9kwsbZ7z/XrWoUX6xNjSq6fMptoopIUvoLm+ZWzUBE3q4Hs2BDp+lqYCUjmgldOn4j2weKGUDsBic9sorZZafHRoVVhB6l04cgMPYotAlfZ7mGRJrK4OS/mnYq4ue2bbRA81B7yCvFv7nnEwrSt27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349837; c=relaxed/simple;
	bh=he/SIVA0ihPkqxSBI8H4ckX72uEXrSuLf/drSPdsQLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMuWjzrKv5F1R4sp05W9ykl42jVrFHvZpSM+u048/KVJ2WJA4iuDFC22m4DvEixw2sqA0fKlsGEW+7Do/lxbvNeAC/xj5507+/SPhuDdra2KSFGAmkG3hw+UJZYmCqJ98qTU7JAzliLHZAx5Ycw9OxCc+FxKtDEo+kN4DkcDoRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFArfZbb; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so3390353e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729349834; x=1729954634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEVZQNtLXbr6VjdKHfnY+YaNjHdvT+6V0pligHDJFQY=;
        b=fFArfZbbQaGDia66Pm7zXRSejiwgd0Noi9MPn9BaGpEdhkRGbrmtv1jM1OmBLpYk63
         WKpGfRbJwx+gMvlPgSJ/9IBf2dxP3/k9kG6eQH7jHrdUw0SeFQF4MttNJPnTxRQdx/i4
         vQcYzp0XAZM1Sqa1JtQGxYgJT+movb+ld6MY/u/bGms1WbeHV+OK2xaCfYfaHu6+N6ew
         9M17iaf9EG+klS5RaczXlTkkQwZYgsjagruMAG2NlBc58QndKU6rbMDV/8eXF9869RSN
         B1hJp6Ib+uf5l7TrOvPVEdSZMU2sxgvLImR+eXMllAEESumEVP0u1emYX24oRg7Dk/4Z
         VtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729349834; x=1729954634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEVZQNtLXbr6VjdKHfnY+YaNjHdvT+6V0pligHDJFQY=;
        b=Ap4B5xWbaR56sJy+hwvulA4iDezvGERG+HmrEUWDaCJMt34JvM3TjCZL7HYKXHgz4h
         2MRRWbRaqG8Hbk9+BZXTPvdNaM4yhevzctZoymV265zwPHWKnFyJlmgo7HiPijyzkcQv
         u7X0AofDza152uXdg/S7L1pEV6Nnd4eGK6jqfbOsglQklLUOH/Dm6vl7Pnki/Hl1OGeu
         iA63ULDBkFA0vQvCR4wLtyyB//pwSsTQEf6oamMviizJXq44pFZCwi09BcVTUHmnWRJn
         N1+30gMGYrfW/GEleDkn8UiCcZ/6/F6/7PXSzO7YWmMS9M5yCmY20ds3KD/xNgcuZnc+
         Ilkw==
X-Forwarded-Encrypted: i=1; AJvYcCWUto3tC4yOWV5Z4i0raqi6Qm4SnI1tEcbMip8j9idYmCetDilssSeRif/S2BZ9GIle3lI5U7k6wXOwcWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7sLtSAgI/8eQ3G8q+18HdyBK8xX4QMSCnxH9OmFKvw2RvvUy
	/HworO0+Kf3z3p4FuWT/ALC6Clh4L/cGD+6w4QbI7e/qr0LKz2gyhtyc2Tgi02g=
X-Google-Smtp-Source: AGHT+IHRntnvw1lPh2mpFcX91NURazRLZTgtFyN/6fNXWiqSED9YBtLtatc9HIRvW0djazjQFp0f/A==
X-Received: by 2002:a05:6512:6cb:b0:539:f13c:e5ce with SMTP id 2adb3069b0e04-53a154c34bamr2847424e87.46.1729349833762;
        Sat, 19 Oct 2024 07:57:13 -0700 (PDT)
Received: from eriador.lan (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15214f1dsm551788e87.288.2024.10.19.07.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 07:57:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Stefan Agner <stefan@agner.ch>,
	Alison Wang <alison.wang@nxp.com>,
	David Airlie <airlied@gmail.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm: fsl-dcu: Use dev_err_probe
Date: Sat, 19 Oct 2024 17:57:06 +0300
Message-ID: <172934981948.2755496.15748235878067004017.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240926055552.1632448-1-alexander.stein@ew.tq-group.com>
References: <20240926055552.1632448-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 26 Sep 2024 07:55:50 +0200, Alexander Stein wrote:
> fsl_dcu_drm_modeset_init can return -EPROBE_DEFER, so use dev_err_probe
> to remove an invalid error message and add it to deferral description.
> 
> 

Applied to drm-misc-next, thanks!

[1/2] drm: fsl-dcu: Use dev_err_probe
      commit: 5b7abfb20ba15c0d6c52672874b99d9564ca876b
[2/2] drm: fsl-dcu: enable PIXCLK on LS1021A
      commit: ffcde9e44d3e18fde3d18bfff8d9318935413bfd

Best regards,
-- 
With best wishes
Dmitry


