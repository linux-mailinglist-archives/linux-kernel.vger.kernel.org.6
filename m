Return-Path: <linux-kernel+bounces-232171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE791A467
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269061C20F18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDCD14532B;
	Thu, 27 Jun 2024 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1gUPtnZU"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A113C667
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719485945; cv=none; b=kyLQ+qZGX81CONZ6ku0Kg9bg15Oo4J+fpi5nU9C2awGz1Mx/CXXHn0KHq6LvEmh2PiUJs9vqOEAFor2UICyrXxoWMiUY4Y5XaZI9SdFp+a6+qbBrTTkUJx1AZsC60lSIDU6nWSGNsozm5zGKBCUoAz/aQjXDoJ/Nm1XRrtCJTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719485945; c=relaxed/simple;
	bh=z57g3uCdvjXuRj49fNkurZjircHT6W0I1kG0XtfOLUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhYklLdFA/AroVMwXctXyuxvXXvJ9XhsNv9yI44ZO+HA97n6+vVPoV2OuWenKYX6vUTIbBDRisQPop7LYlXpdQPJSo6qyO+qiDw1yJFJWzWfxCD9dGZ3bZ73cT4t1N7y3TPWiR26YIv08pc1l/Q+iFfsLP81T3TVLcbj2nU4JNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1gUPtnZU; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe785b234so85702251fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719485940; x=1720090740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xZV0c9kgiqV8gG3kEpoX0nM65939kr+amcfqyF8vm9s=;
        b=1gUPtnZUKXMT3HWJJWbDGlxdx/+iiCwHRMwC4O7pWuSI8GvD2VmXp2LvXVAydQvTw/
         LB96yhNu76oyLDEL+FyHBMehzj2TN6nWihoLKLR0gixc99H1VtLmBgn4Et/apdRSnI1I
         4/j2CdOg1ASrtdi+chjVbhgaTPn3TOX0z3589Qi5x1GSirkDT54Qdb2imvldPiOLrluy
         wYtpChWuCrsvkcBUwXBSAgrGTnaFIy1v5AWYQqQa4L9BAAx+8up5LRVMv0GdrgotWzj0
         OL5qzjj5s+3oNznB92S6nmHgYC6PN1bVg2S+FUqJQLCShsgudD5bGOFBhP1GPvQwCeqk
         c8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719485940; x=1720090740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZV0c9kgiqV8gG3kEpoX0nM65939kr+amcfqyF8vm9s=;
        b=s+JNAywVdG0NP95GFMBkVU9MsLnyJfTmX+yeQdUBVKWNekyaHjENjHEqhp8Z16alL1
         CanogYJI4//gJsPytaj9YANOcuGyXKmhpdWzpw/Flf503r1dFsliaBE3H/ly/h2LMi/M
         FROjoJve2QHgQKno8EzJedREl52/ZcoHhKLCXX7JcZ8b4ELy0TovocLHzTZWqJc0gzY1
         jeGHNN11bur/gBqq8O3vcs/5UZHIVobvLtyeF69gNrs8VVTyGTrm7euE9CfewyfUzlih
         X0cbjaJqoMs4RHv+P7tARShy5yALQUiCLZV+zN87dMCRBbMyZs8ntA1lH0uK4c1KkfFr
         2g5A==
X-Forwarded-Encrypted: i=1; AJvYcCXhryGxDBLnn+aaTwTjvaARbHUKzKY3FHVA8rUKcBfqMpUFzSBFMcqA8CG0vqS/txl58zWjhYXqeAdUD6RtcxjNlpveOlIYV1c24Szh
X-Gm-Message-State: AOJu0YzjJNeYfZJTItQBmmtkSCfYnQ+cCAVj0AJH9i1/zXcTyot9+ify
	Z7vbmJaxAGHx8qTJMwVnF3h85oHZs6z5mmRp5ZSaca7o/ThUYcMjbkeA15S4J4E=
X-Google-Smtp-Source: AGHT+IHKnaB1GKK958LRMoxlWlJjZVfp/KDChOu1D0p1jZTWC7mugwsykvQ9bMn2+NsTJbJLR8HYXQ==
X-Received: by 2002:a2e:9001:0:b0:2ec:56ce:d51f with SMTP id 38308e7fff4ca-2ec5931d31emr96371381fa.20.1719485939978;
        Thu, 27 Jun 2024 03:58:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8246828sm61612895e9.5.2024.06.27.03.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:58:59 -0700 (PDT)
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
Subject: [RESEND PATCH net] net: phy: aquantia: add missing include guards
Date: Thu, 27 Jun 2024 12:58:45 +0200
Message-ID: <20240627105846.22951-1-brgl@bgdev.pl>
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
Added the Fixes: tag and resending separately as a backportable fix.

 drivers/net/phy/aquantia/aquantia.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index c0e1fd9d7152..b8502793962e 100644
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
 
@@ -198,3 +201,5 @@ int aqr_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
 int aqr_phy_led_active_low_set(struct phy_device *phydev, int index, bool enable);
 int aqr_phy_led_polarity_set(struct phy_device *phydev, int index,
 			     unsigned long modes);
+
+#endif /* AQUANTIA_H */
-- 
2.43.0


