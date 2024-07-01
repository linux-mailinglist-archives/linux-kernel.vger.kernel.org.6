Return-Path: <linux-kernel+bounces-235783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA60291D999
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835F828480B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DF781AC6;
	Mon,  1 Jul 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NISqy9QV"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D241C72
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821018; cv=none; b=mk1OnhtBUmyB9xo85J8Nkjwe1dcHu4mNNbad+xa09J8KO1cD4/InwdqKiRSyUInDO1HvprjgFSiWmOWB7i8Ls5hvjcPz1k5eaAKsuixZ7x/SWDT2Yti2PWJKz8Kwur8M/85Obcm9oje2q1tJ+oZmLzI2D1fRH1Ig+Z5Hr1DQRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821018; c=relaxed/simple;
	bh=Shw1Th3WUaSnOFjbNI7at32oQOt0mlvfcwXzXPPaV4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIk+ryWdSZOks1bFgSJVKnCqX4U3ElLQ0Khp81936nsk+R7m+9UetZE4+eJMa1q1tPcODli+Si3DAZLICoBPXLkqEXKqayPOdTCRH7U+gGjSA4SoMlAkzplzw1b9nVrhz4cQ/skfQLKgmR5QJ9N/NLN3GWG1ODWE4x0nKmemPDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NISqy9QV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-362bc731810so2206677f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719821014; x=1720425814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b45V0iviWplF75Nx/Ur6UmqLyJXiIut90SMCIP5elJ0=;
        b=NISqy9QVHWhB8aLx/k+DBbYwRo9cFPYh5gMoysMiQoB7icmpCEKwnRFUJf+9GQtKZD
         K9zhYumI+kFHCwfchVnW1S2RzJ5jV+2C2wb6kfG4nO/X8tfLn/4sgPFmwj8857uicAIb
         HJsqXAJtTdnlg2ct2QYbOxKuh5MuIwCYAhZhZmzPgKx6OUa0NX2XvweDv626OmukZCQD
         i2vs4OrbfB7V9K/kcfZb+MI32ZMxzfcwjhmg442qagMXqLhN3Us5IMl7GhBSjJryR7YD
         HDIb2uogg7iU5pEzIjF05fK/ZoIhF6vukGFeubJhgRXCyijcJPrrQy7IP5Tpa0hCorJz
         Mixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719821014; x=1720425814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b45V0iviWplF75Nx/Ur6UmqLyJXiIut90SMCIP5elJ0=;
        b=omPpXPmAMK5g+Y0oGAY9NSciXmgk/aHug+TV8YZslSY7jkt12rkAC2xc/4SPPGgtbB
         TePQ7Rmg/EHtyeMPUz4p26RT74pAb0PGYVDCaqb3Gm+itF9Lx7Ox025cps4o4Dl18RNF
         nJ1BiBlFbMHAcJWUG5OstcA250jFBGYcqJSPYNAGFDdHT9NY9JIwUXAAXTB8aXiAk7Uv
         aeVOdevyUQl96AG/IYvFd4ooJqbDsV35BZl502tdlabSOeVAGilFhcN3xq0NMv8Etjhk
         XisKgaymNcZzHjP/WKP/bpYKr8E85gcjhpv/4kq8UYdQjlxCr5pDoyw79cjqanEb5YY2
         1CRA==
X-Forwarded-Encrypted: i=1; AJvYcCW25RRa8+Qkinmd0uSt/N6Hk2UraIqeO/Dp3rEMPudilYIWhgMPlZ+6QGqQeM87VrCJNBut32lLuZNZ3HeYbhxldLB4rL4mOZZOOqpj
X-Gm-Message-State: AOJu0Yx33HNAqiQcXPAWNWMCZyOq/iPBxPVQSp6P+oJdubsdIM9HoB5X
	0WVHFITlvTalgIk5MqaERpJRNmTiBgWNbefwS0AdoaH4eLCSXRW23MiNi1bXoXc=
X-Google-Smtp-Source: AGHT+IFfMJT7UhgMv/q10eZW7BhycbYE7gDH2aVKPe6CX2HpFuRwhkf+IuOfRfdxzGiyl5aDicMa3w==
X-Received: by 2002:adf:f18b:0:b0:361:dd0c:678 with SMTP id ffacd0b85a97d-367756bc471mr3480189f8f.36.1719821014086;
        Mon, 01 Jul 2024 01:03:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1c2d:13b2:676b:59c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba5asm9310049f8f.71.2024.07.01.01.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:03:33 -0700 (PDT)
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
Subject: [RESEND PATCH net v2] net: phy: aquantia: add missing include guards
Date: Mon,  1 Jul 2024 10:03:22 +0200
Message-ID: <20240701080322.9569-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The header is missing the include guards so add them.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Fixes: fb470f70fea7 ("net: phy: aquantia: add hwmon support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes since v1:
- rebased on top of net/main

 drivers/net/phy/aquantia/aquantia.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 1c19ae74ad2b..4830b25e6c7d 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -6,6 +6,9 @@
  * Author: Heiner Kallweit <hkallweit1@gmail.com>
  */
 
+#ifndef AQUANTIA_H
+#define AQUANTIA_H
+
 #include <linux/device.h>
 #include <linux/phy.h>
 
@@ -120,3 +123,5 @@ static inline int aqr_hwmon_probe(struct phy_device *phydev) { return 0; }
 #endif
 
 int aqr_firmware_load(struct phy_device *phydev);
+
+#endif /* AQUANTIA_H */
-- 
2.43.0


