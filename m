Return-Path: <linux-kernel+bounces-232218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7509691A552
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF7C1F24F40
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E701915666D;
	Thu, 27 Jun 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Q8n0qOnU"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05414F110
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487833; cv=none; b=etrmCM3gjOl8LBo3yrMlyxd8x7WlvgK8t5gW5InuvNmGDVkntPYogx0YhQ1kAyvoGhKb1FcNwbfePR+7RGrQyMUvfpZlQ+6U8XxSfX3ye90huyb7WeZ04evqcBUVVaLex66snrWtiGHjKqTi6dFuq457oRdjdddB+2kgDyw/+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487833; c=relaxed/simple;
	bh=qT/I0vbZRGDpE8yP1ELoiUDNULDJ0duW33V+A0EfTRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcG1+m53B9tRCNcSlfu2pKSuqeO0Be9hUnoYcAOyTe50fMv+Ps7jO09JWJ72sCrbn4EnavVALrYIeTbmpQlKtD7VwdoDnC4Q/sJIvYVbL3u7tV941VikpjGeVqVyHTwdSSQYyKxlfTEOIlavMsIFDtRVzRa6yRW0A83P5DMj+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Q8n0qOnU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-366df217347so4554091f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719487829; x=1720092629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9Md/Ifap9fn0ZqaVx/ir7biX84P7JSuDDxVoVQn/Dg=;
        b=Q8n0qOnUBq9zJJWxJLsFTL8v5H7teQ9On6bxDJyP0jsB6I6mB75nXCNLLKnSoqyYem
         E9W6QZ+JOZ09VPyTutcSLARe4Vv/+ZldjLhJZSKOuN5VPQMsFq8uuwhx0uj37T3koeOm
         WmJrNzsniWv8nfu8cwjZBtsd2iwPuDBK/fdMotY1Qh/eyvLn7VwbGRF4KBDWXaerNf1V
         P9y/klJ/J5RF7f+YH9JGGf3+ZSMfjLJOZUG2qL/VwnSaHbpioes4EuOOROvsqWurLAvZ
         BtWhzgOOQleLdtaBIEE3qMAR0/hk6Zf+b5o8e6mHVaEHcr3Bh5X1NxIBGrEffzTi0QIt
         ZPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719487829; x=1720092629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9Md/Ifap9fn0ZqaVx/ir7biX84P7JSuDDxVoVQn/Dg=;
        b=iPsf5CiUcxw9BItMRv6+xXzUikRfDIpv9k+R4D0g2f/1pTW6EcQc7pnzTH2gK/gpBd
         aaouGjBDZDoJ1VfFznYzaZvlSFdYAwwAbdlhWX1lEi890PcMRcbVGWv+rmE2GxTMmQF9
         8uYHRStq0JobXJROD0cc2N8LsiW4fuftyIBkd9468p6MSnLekcM03gan7Yq+T5BSfjlm
         hD2dzv82kMvWoH+BKD5ne4tmwohaLbQwQpvYEaBK9aSOozVkG/s8nK5IzwuJ22VVZMDM
         ljufHzYeIpEcwU6UCNotrLGYwwHZa9roV1ehUE+wmFKo1kga61uTMw4vgPd+hxC79cLV
         /39Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGIkA1nunR9mZMywDCXnCf/3yt4+uM6NCJvvHKPsDEHK525G63+6jeKPnBhK5JVHHPeTfvV/Hgx/2PNq2Bv9RXQgYOwBI0jZdYQnDY
X-Gm-Message-State: AOJu0Yxj2JO2jaJbzDUCsQpezsTTIin79PAL02qZcQd7gIdvqau8qd81
	ST6pAdejwkUePwwCwNolHxNYrfIk/w+75az3fPIsTU34wg7FstyxIFIhYuwySGI=
X-Google-Smtp-Source: AGHT+IE3DkKA/w8nX9UijesIIy/Krp9fMCKxcp6E1gIBE/pfr/ALQIhI6+lVmY51WFB5RS6DUQEf8w==
X-Received: by 2002:a5d:518c:0:b0:362:3b56:dbda with SMTP id ffacd0b85a97d-366e9463e46mr8283279f8f.9.1719487829229;
        Thu, 27 Jun 2024 04:30:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36743699ae0sm1504111f8f.66.2024.06.27.04.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:30:28 -0700 (PDT)
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
Subject: [PATCH v2 net-next 2/3] net: phy: aquantia: wait for FW reset before checking the vendor ID
Date: Thu, 27 Jun 2024 13:30:16 +0200
Message-ID: <20240627113018.25083-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113018.25083-1-brgl@bgdev.pl>
References: <20240627113018.25083-1-brgl@bgdev.pl>
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


