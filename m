Return-Path: <linux-kernel+bounces-523793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E96E6A3DB53
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3AC17AC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9895156C69;
	Thu, 20 Feb 2025 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aBb4mWv+"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E8E1EEE9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058285; cv=none; b=NBP2J4f3Xvl5p6AkVKYm0BYeWs1kr3BKS5OTw9Ir2Y3CRnexBHtwmoDI1+DKT5YV9kkAP0kP7vfO0C8E/QdzvTTRrkvwFoL0jwA0yTEMMDOCncFdt7l4haguojIHsS6b6XSp8N747bJYn1RAjybVOwLesC0RWaYLJcvarcp5WVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058285; c=relaxed/simple;
	bh=OsHb5G0+2rMCZGg2S0+42ZupXEzWYeN/txSWTxscXrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ecv3+ZRD+SO/HJg8NSlYB77tkjCI2J7Ng4Ked+joLl4Y2j2Gvmry0re2nbNOVDQswmetXsIGF1VBH6klPwkvFUAfOvD8/6qC07BLR7uULHhJS1sfPyjBqnTQoutl+SRLS4jpJuhpzGf7MEOkqoZfyEsMo9ytAfbaBy9JKQGuR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aBb4mWv+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439946a49e1so5898815e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740058280; x=1740663080; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfFNcyRJeXHST09oQCOS8V/CvYNh9zyz+0qrUq7HqK0=;
        b=aBb4mWv+cW6xOkk++Q/E81celon8VGvuLI2BQM6/22dPTcXz+f9AIisgyPreHRXJCZ
         8YOXd4EHQXHCKnnhtRltQBGSilE5jFNavGoRDlDqb5tBP/QavBxJfKMb7dYpv2Sj3TLR
         v+fm5iNEXyruSUrGwIaygvTvRE8/dBPo5qbwZSk5Z01reAkFvHiGnTD2b1SNy1I46lmw
         6xMqOl4hoTO67BMA7OQNlIzPnBI4lUeTb+kDfLayvgitzr2JmfEB8Q60QxtbztEJ5w+u
         RYcPAu77HIezbCetQkJjyQiPZuCqoFV5WQwAJHJz+RiLyhWwt6ZFJrBbvUATq2GNyi4a
         wrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740058280; x=1740663080;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfFNcyRJeXHST09oQCOS8V/CvYNh9zyz+0qrUq7HqK0=;
        b=KY2CyGQFc8llyLWHHs+Uznz+DLclNJWC5COiclyWYjQTvNtMkmZnTss8EH+9FiH7kh
         0FtaRDgWFkwPiqpoy0NH03rHPQC5NbdbNoBbxBfwA4D7ceS372eJnb0CcyqpnO1FhiAX
         ETxvSDR+Fav2SvsIqxm5dEfl2I0fZm5KS5lZImFH451ChOacRAMVik6uKf0S3oDb6iEN
         QZ0tVR4fWzWLDqodgn16WS9jlVfVzurJioyu0cKf50Oi9zpNofB7o/pTEcMTMAC8Ezq/
         +a67dB58cyBiOW4X00QJtU2zbnu0RM6wn153jLcYpIAXIoJw8rDR7Rop7/uE+d3y/DAE
         TfSA==
X-Forwarded-Encrypted: i=1; AJvYcCVlD+goO6BqJLcZf4UkP9MPN8bfxTpcUrcu8OajmJh/La2nxzQ3YmMHhWU1Rbzb7FnS2baPQ89XsFzkV+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMCTrCfB3QXcwFP+2goSc1fP3koycH2oSV9SBbfGPjQg0oD7g
	tDxp/ev6FYjT31iTIxbNLk2Qn/uLrfKM1vZVPK1D9tUhyW62fX6w4vL3raD1Lr20egZD9k9UrM7
	J
X-Gm-Gg: ASbGncsEd1A9X434x0pNsJ+NazOB05QjTnZiOL4vTTkJqqoICoRR71q2QteJ1QZhsQw
	dChW+JQs3gx8TPQYh38VfxolTKLOoWNFo81l1b/rLY0dqfU7VJSo6MAkL2BXANUEdLIuFpw0hNT
	o1MmjlzFDoixnsaZ4sk+XbgeVcrRfsQGcr/g2X2Z36UzeH2uJ1FFKRtz1CrQQCebtx3f4wvSSeR
	hIuyD757LY7aCL62+bmbfOMeRkFHpIxCMsxHBsOQZ0apzTJJ8zZRBL3E+lQo08ypDIXTS1kL4jh
	ldXMdCRvBJFn9xZBG1A=
X-Google-Smtp-Source: AGHT+IGIKJFwwjyzaNa7wDD90Jw72yRRqFrFSUBS40JKnJJhsaVDxE8tbUlYfhfiI5/ZtsFFu7lyEQ==
X-Received: by 2002:a05:600c:19ce:b0:439:873a:111b with SMTP id 5b1f17b1804b1-43999da6f3emr77412745e9.12.1740058280223;
        Thu, 20 Feb 2025 05:31:20 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:4c32:9600:f4cc:3400])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa7f3sm246757115e9.29.2025.02.20.05.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 05:31:19 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 20 Feb 2025 14:31:17 +0100
Subject: [PATCH v2] firmware: config: ti-sci: Default set to ARCH_K3 for
 the ti sci driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-ti-firmware-v2-1-ff26883c6ce9@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKQut2cC/23Myw6CMBCF4Vchs7aGFpuiK9/DsJiWqUwil0wJS
 gjvbmXt8j/J+TZIJEwJbsUGQgsnHocc5lRA6HB4kuI2N5jS2NLoWs2sIkv/RiGlvQsuXmpLFiE
 /JqHIn0N7NLk7TvMo64Ev+rf+dxattHJoKsQQ/bWt7h7XF3uhcxh7aPZ9/wJ2lXe4qQAAAA==
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1

With ARCH_K3=y we cannot enable TI_SCI_PROTOCOL=m because
ARCH_K3 selects TI_SCI_PROTOCOL.

Modify the logic to enable TI_SCI_PROTOCOL by default when ARCH_K3=y
allowing us to submit a future patch to remove select on ARCH_K3 without
breaking existing users.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Link to comment done on last serie [1] we come back on first version of
series[2] to not use imply but set deps on ARCH_K3 in driver directly.
An other patch will be sent to update Kconfig.platform when this patch
is merged.

[1] https://lore.kernel.org/all/20250123-timodulemailboxsci-v4-1-b1a31b56f162@baylibre.com/
[2] https://lore.kernel.org/all/20221122202245.449198-4-nfrayer@baylibre.com/
---
Changes in v2:
- Update commit message.
- Link to v1: https://lore.kernel.org/r/20250218-ti-firmware-v1-1-7a23aacfb9d3@baylibre.com
---
 drivers/firmware/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 9f35f69e0f9e..109abe063093 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -215,6 +215,7 @@ config SYSFB_SIMPLEFB
 config TI_SCI_PROTOCOL
 	tristate "TI System Control Interface (TISCI) Message Protocol"
 	depends on TI_MESSAGE_MANAGER
+	default ARCH_K3
 	help
 	  TI System Control Interface (TISCI) Message Protocol is used to manage
 	  compute systems such as ARM, DSP etc with the system controller in

---
base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
change-id: 20250218-ti-firmware-1b7c7f485e5a

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


