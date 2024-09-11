Return-Path: <linux-kernel+bounces-325702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A0975D62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCC01F23413
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBF418452A;
	Wed, 11 Sep 2024 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f58XoQLz"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE315442D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095082; cv=none; b=tZhMasDxpVhZJgyLCVtHUS8xoU+ouZ4E4MschcCDv4oyREPtPW3qhVxkCQ0qajp7XhuO+FfiE3RdtPYwFSxwaIyE9itwdPHnuYUOX17lum2RqXOIqB006LuHrbeqO39sOsz+uob2zcr+I/2vT4yhUyOz2MX2yvq/I9RZLp5Kz3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095082; c=relaxed/simple;
	bh=LoZ/6l/OePObrWvPZtqCKPDi1DlnpVl+K3kJjHA/ZS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrcYLHn6yF2nMZi77dRTvQQZcB0+alY2NNvbxhGsgutah50ZEGtjFQvnGG2YinjqhqGH1ih4x2scmwIDCNOR71TeNMw+Ljg6M/VpXRgCd4CGQpf6NOXqudE5rIokTCgeRFbK7LMlfWwvMyqmS+pVORdb/1788KNomZ1JIcqPwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f58XoQLz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6b47ff8a59aso3414787b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726095080; x=1726699880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWlJy1K4aSkz2+ycv9qwV6qJvspOU9Aj+Uv9U+ZlG2A=;
        b=f58XoQLzvoRF1Axjy5bn+KGy7HRpqlqVYgzwHQbGk7SGtJcfL94pzJ3fx6J91E0EJd
         rgx4/MGeRYf7unFWaTvzeeQfYNbYTMSTsdbbPbCb00WMyL5jroGxCa9iY30Mf6uXHi31
         Y5YS9CibUo6bNdjomlZ6xAlELO4sPPk75bU5zw+cLrkjql8lyb3HWP631ypSkrlMeDp1
         7cZY7rKbAVVaF0M7MLBu1frbJmyz8DDhSgQFbvAay0gxoMQlMTyiMjnYpdHr5MemiOFo
         CJCk8/hRRm+yImDQ+5nvE3UdVHePlz2StrNvHDEjYSK8u6es2apnREfkLNzPfqXgykUI
         ZSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726095080; x=1726699880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWlJy1K4aSkz2+ycv9qwV6qJvspOU9Aj+Uv9U+ZlG2A=;
        b=Fck9X1dkj68duVFpkz5vMHp8TZg5wlyUS2NCrD8ZX+NNSaOcjrYvsRGr88vWjFWruG
         zJ9w0NqVAgUub56rwOKx0xjoFugfknpcaymbeX6hUCBSwKQAHL7GUjocK/T4xoiUaMLo
         7evHq2vkrQ68ZLtsiIlc3p7UPKX0XQdYgqnaMfUkGwiCIGEUktAzCmYd+CCeyUQdvTdy
         ymMP7hMRX9+CA0CGzgaCM29FCYs9q4p4dT35Qp4sezka6HAencYDcNjws3d5CZUaL26F
         uK4Gmq1vh8wgdM8odyDrsXYIcBrpRioV/0NKnbv/IHpsd8yYonVSgFLOaOdIQIFVToIY
         0kyw==
X-Gm-Message-State: AOJu0Yx9AYlIbWJGjQB+dI5H5n11JT/hOetTVwLhu1O0xumXV9kkF90r
	iJBrO6sQRTFH+2NYsIWvyMt9lZeajNTEGgd9YhuWWYNh7Pyf/Jh1d9YfVQ==
X-Google-Smtp-Source: AGHT+IE6oD00ocG14sSiq8nYZPZXA6F9QrKdjDBFgkxy6ZO+kwZV3M4TzRKIDS7cXuKboQp8FnYJTQ==
X-Received: by 2002:a05:690c:d17:b0:6ad:219a:b67c with SMTP id 00721157ae682-6dbb6bbd2demr11603897b3.46.1726095079658;
        Wed, 11 Sep 2024 15:51:19 -0700 (PDT)
Received: from kendra-linux.. ([64.234.79.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db96429132sm8539927b3.8.2024.09.11.15.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 15:51:19 -0700 (PDT)
From: kendra.j.moore3443@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Kendra Moore <kendra.j.moore3443@gmail.com>
Subject: [PATCH] Fix typos in extcon-max77693.c
Date: Wed, 11 Sep 2024 18:50:23 -0400
Message-ID: <20240911225023.99295-1-kendra.j.moore3443@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kendra Moore <kendra.j.moore3443@gmail.com>

This patch corrects five typos found in comments in this file.
The patch does not change any coding functionality.

Signed-off-by: Kendra Moore <kendra.j.moore3443@gmail.com>
---
 drivers/extcon/extcon-max77693.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 2c567e0b7b7f..5a741c37a6ee 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -2,7 +2,7 @@
 //
 // extcon-max77693.c - MAX77693 extcon driver to support MAX77693 MUIC
 //
-// Copyright (C) 2012 Samsung Electrnoics
+// Copyright (C) 2012 Samsung Electronics
 // Chanwoo Choi <cw00.choi@samsung.com>
 
 #include <linux/devm-helpers.h>
@@ -250,7 +250,7 @@ static int max77693_muic_set_debounce_time(struct max77693_muic_info *info,
  * @value: the path according to attached cable
  * @attached: the state of cable (true:attached, false:detached)
  *
- * The max77693 MUIC device share outside H/W line among a varity of cables
+ * The max77693 MUIC device share outside H/W line among a variety of cables
  * so, this function set internal path of H/W line according to the type of
  * attached cable.
  */
@@ -689,7 +689,7 @@ static int max77693_muic_adc_handler(struct max77693_muic_info *info)
 		 *
 		 * The MAX77693 MUIC device can detect total 34 cable type
 		 * except of charger cable and MUIC device didn't define
-		 * specfic role of cable in the range of from 0x01 to 0x12
+		 * specific role of cable in the range of from 0x01 to 0x12
 		 * of ADC value. So, can use/define cable with no role according
 		 * to schema of hardware board.
 		 */
@@ -708,7 +708,7 @@ static int max77693_muic_adc_handler(struct max77693_muic_info *info)
 		 *
 		 * The MAX77693 MUIC device can detect total 34 cable type
 		 * except of charger cable and MUIC device didn't define
-		 * specfic role of cable in the range of from 0x01 to 0x12
+		 * specific role of cable in the range of from 0x01 to 0x12
 		 * of ADC value. So, can use/define cable with no role according
 		 * to schema of hardware board.
 		 */
@@ -878,7 +878,7 @@ static int max77693_muic_chg_handler(struct max77693_muic_info *info)
 			 *    MHL/Dock-Audio.
 			 * - 'MAX77693_MUIC_IRQ_INT2_CHGTYP' for detecting
 			 *    USB/TA cable connected to MHL or Dock-Audio.
-			 * Always, happen eariler MAX77693_MUIC_IRQ_INT1_ADC
+			 * Always, happen earlier MAX77693_MUIC_IRQ_INT1_ADC
 			 * irq than MAX77693_MUIC_IRQ_INT2_CHGTYP irq.
 			 *
 			 * If user attach MHL (with USB/TA cable and immediately
-- 
2.43.0


