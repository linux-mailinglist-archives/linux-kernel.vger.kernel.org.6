Return-Path: <linux-kernel+bounces-240008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606DD9267DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7AB1C20FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF2188CB4;
	Wed,  3 Jul 2024 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KI/TRkAz"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235001862B1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030310; cv=none; b=N/BUUEIPyHNuXps3QNbaLLUN0eqOhHIKTUvW62R4pFXTX7vkcna9MLRqgy4yLzpcSMl0JK99HvfJfuH3SzT3NwnIYM+7lhu63kLhEEzYyWDdyvxAwkLiSz7ddF3H88X2cgIX4AHEjda2uvB4tozDlw+K8gDXpx4cfERzPS8QLYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030310; c=relaxed/simple;
	bh=qT/I0vbZRGDpE8yP1ELoiUDNULDJ0duW33V+A0EfTRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHUe45a9RHuGGMJUOALiA6fDOXsbiHrog2EmZeT90EYHxvaLUq3PHCdWOcH2Yrjb0f6YTN2qvrO1t6SnUKz3pBcr0UCqR9GgKMFjVZkGZLdBIGa/wQUWoSJ/IuqzJS+ceJV99MTzwxD6YGu0LR/JBBFzuWi2OixyDACN6YCzd+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KI/TRkAz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42567ddf099so39943495e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720030307; x=1720635107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9Md/Ifap9fn0ZqaVx/ir7biX84P7JSuDDxVoVQn/Dg=;
        b=KI/TRkAz3bD58fQgVzqUsT/3DFp6QeARBtOyC0gjyp90jXKFC5Q5mBUpvTltpiv9hJ
         GRnMhl/H2RxM1PjcDjG78En1ie1vrzXxR0I8/W33gcMr/hQEpU0I2duEmhTfi5z+EcOz
         keT+E1TYWY9jhATl4WKWVssfoEDKSHtahciPg3bnj2PwamKXb1dP6AXXFDyKfDDjEq2f
         UTL5pakxqRQr51uLK/R3OkM924E2YcXSLqrH7xtByEwik2Z20PWVScI+EsbP9L6TAwML
         9sddvDvvOxog4NTJp0Zyyt3+75hghmHn3nS+dW6gFpiAc9/2xexEwWtlBEFd7voBynVm
         6tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030307; x=1720635107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9Md/Ifap9fn0ZqaVx/ir7biX84P7JSuDDxVoVQn/Dg=;
        b=b80zI1lzeCGZyhc16x9ZtBSNF4AD6RuSX8I3YpApt5zsCnoziPV9Xh7MHdDfFAhnSN
         jEh3Vtz0mScLnW/Vvn9FqfKDqzkxP3atF0HViYvfH/gBOcOWZSLpx2GuuX0oH1Rw07Bd
         3cHt0t6eXnz2EdAA4f/pPH7maB3i0UR7+FN3VvepPfSCFC6RF2Q5v9yfCZhzEeWerDN1
         bfGuZhCDGvWazqMmMwohlOtIZ3xLciWHzZHM7QA93hcb8VM4lLgnsKAD9QChq7m7g89Z
         MG4FSeSBk36SessPu85wpr3MEeNmFnRaXOKS3SU3s+fF9RTzonOVVpkZiz8O3fXhgXM9
         UcOg==
X-Forwarded-Encrypted: i=1; AJvYcCVDWT7VimsKwvMLxbinjL/PAgPiVJf/Zr1d5N79Mvf2CF2ZIAV4G3LdtP0rAN9dRkhNRSuf1r0bgWhVHIV5hj6+k5BylzVwaRtcoCKV
X-Gm-Message-State: AOJu0YxTRr36g4KbYFSoP1d7IAg/E+jXfQ1edZVxKGj/wQ/R3MMM7Kd4
	izTInVvM1HpQ13eLCEpr6pt6qmfBuYxtDE9UlepknTHhhddZhyrqlALLqjkxTb4=
X-Google-Smtp-Source: AGHT+IErpOTH5np4WNdFL0dt39n7/w2pRaPdii3nhm8qc2dmFYkgcWXsp23yHtXNUTE0DONLhMPEsw==
X-Received: by 2002:a05:600c:19cb:b0:424:bb93:7aad with SMTP id 5b1f17b1804b1-42579fd1d64mr98083665e9.0.1720030307575;
        Wed, 03 Jul 2024 11:11:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm255295965e9.9.2024.07.03.11.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:11:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v3 2/4] net: phy: aquantia: wait for FW reset before checking the vendor ID
Date: Wed,  3 Jul 2024 20:11:29 +0200
Message-ID: <20240703181132.28374-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703181132.28374-1-brgl@bgdev.pl>
References: <20240703181132.28374-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Checking the firmware register before it complete the boot process makes
no sense, it will report 0 even if FW is available from internal memory.
Always wait for FW to boot before continuing or we'll unnecessarily try
to load it from nvmem/filesystem and fail.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/phy/aquantia/aquantia_firmware.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index 0c9640ef153b..524627a36c6f 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -353,6 +353,10 @@ int aqr_firmware_load(struct phy_device *phydev)
 {
 	int ret;
 
+	ret = aqr_wait_reset_complete(phydev);
+	if (ret)
+		return ret;
+
 	/* Check if the firmware is not already loaded by pooling
 	 * the current version returned by the PHY. If 0 is returned,
 	 * no firmware is loaded.
-- 
2.43.0


