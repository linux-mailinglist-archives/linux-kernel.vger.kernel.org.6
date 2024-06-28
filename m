Return-Path: <linux-kernel+bounces-233541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D1291B90F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2A91F2264C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D10143C43;
	Fri, 28 Jun 2024 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eYCTCnEW"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B705D558B9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561310; cv=none; b=D56WZ4bM4fD1on8K807CYZi+uWpT+T5xHl7baMCvIzYewTC4u0dWNhL3EPWYn6vCD0O9jVW7dhSrkl7AlkxYdmiueTQBRyQe0/a8ldD2a4TK3auyX/9MMIDBqGT9ID4XncKlKUk9NjWyNXmRb+yH+E3a/CpZkyAwXusSeygmAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561310; c=relaxed/simple;
	bh=Shw1Th3WUaSnOFjbNI7at32oQOt0mlvfcwXzXPPaV4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ME49rFpA8YVDYV5PebCE2OU9lL+O1sfeDJz2g3MaGK5XMjAJ2PzZBnuGEUnLNBhnH27glxgUj4M8V652BvgMt78Xa8IhSAz+OLdbTCc20AOC943aAnIL6buvp71hnkCLMjNQ2cSOPDXbHTssLu2r4dVXsJI8cawVEMSRoTh2qwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eYCTCnEW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42564316479so2438405e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719561306; x=1720166106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b45V0iviWplF75Nx/Ur6UmqLyJXiIut90SMCIP5elJ0=;
        b=eYCTCnEW9krb5wwOB49xOqR70pINeYP8nForsejSWndxMk1O6a8RZU4piolXLK5jfd
         GDx6VtwFTDSXSArEqzVAmZ64K3HLhmBfAU905ndu0fVNjqzbozc3+lZbml+Ts5Mio/51
         PYVDVYAk3FkR1nFIcGKrmqikub0CAIoFaygvjf8Lcxv1/vz3chUTLznd6jVbHcOZBT2O
         2JlirM1AZXsatCosZWCNfyiMkDEyrHqK3pW/zx9ieFkQsBOmoXfoh8qsdc0FSSkMXGUV
         UbEqTRor0nteBH6ZgLbE3R80BFF9H8HZiktwTnPscrInKanxWmc6QXdjYZ4urYlu+/Wq
         5mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719561306; x=1720166106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b45V0iviWplF75Nx/Ur6UmqLyJXiIut90SMCIP5elJ0=;
        b=DgzxBSfjg1220xG7tNnk9JZUOAAHtvQYnd6DCwhgABSeT3JPDUGXyfy+hN2e+5lI0K
         TrQW+6sUGlMvjgWks+n1aUAwlvUDOwzJgNHtGjD2MOnQGLVH3YDhDWVoItSRaGHVNiOp
         +K0EWrAwC9jwUMVeaUKa8AwE3qwx/OrnTCeE61ZuvrKMR5azuoS4xtx23BiVrssColto
         IdoLM4Dk8/7jIdRvI5kLAj0YjPdMVUuNKUrkCRaiDqyEYtCwyb4r6JBhusjIkA5EaSXn
         BKTszJ3eTEy9/I15tW0q0yRrY2PJULvd706wkFr/ZMl5M8PLsWqI/RFKt8AxcerFlcRD
         LeDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVOn6EXRaLH5rKOZR6YStj6ihjD7aa54M1AnuK4bAy2RBQPuf7+EVbJxZJKWH03s/LtaGPoOEAKYTAWO0hwhojrkK4TA+nVKDGK4iC
X-Gm-Message-State: AOJu0YwOllWvf3T7NnIkwa8MgfnZBa5CaCLKyY5r9cHPj84Gsgx00PRv
	tWHoj1Pn9gyNaUuTepYfMbm56lxm/VhPGy400g/uHzAiTE/yCVvKdlw7bw8hQTs=
X-Google-Smtp-Source: AGHT+IGiifCBBUGGMqQmM14rawGqq2VVjYx/n1+aIjV9UA+xWr/8uLSHD6yzpx9zOlGgXbQYK2R+4A==
X-Received: by 2002:a05:600c:4fd2:b0:424:a7e7:e443 with SMTP id 5b1f17b1804b1-424a7e7e493mr65717695e9.12.1719561305874;
        Fri, 28 Jun 2024 00:55:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:cb0e:590a:642a:e1f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b068e93sm23041705e9.24.2024.06.28.00.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 00:55:05 -0700 (PDT)
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
Subject: [PATCH v2] net: phy: aquantia: add missing include guards
Date: Fri, 28 Jun 2024 09:55:01 +0200
Message-ID: <20240628075501.19090-1-brgl@bgdev.pl>
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


