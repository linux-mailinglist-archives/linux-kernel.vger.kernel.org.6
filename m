Return-Path: <linux-kernel+bounces-210148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF79903FED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EC21F2457C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B473B23774;
	Tue, 11 Jun 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evISkj++"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF52C69B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119441; cv=none; b=JWaRXB3pi4IpoWLSwDhMKh2Z9/wzi9ilsxqi5gclBAFokHQLc99+0iJdyOu91x2MasSfN4rO7/0qAWB6fTO/JcrlKo+10JKx+HihpvIoJRrlGT0RWDihHJGPqpne5LFLcBF6ePXRrY+DAluOMDFLmSE9Y0VJgAByVS5kyplj04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119441; c=relaxed/simple;
	bh=B49BfP/n62cC5L3T8DG2DbtbA+R5iyv8rVdtsI/Ab6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PxRjLTOub3nQmMgj9ah4KCwSHT9PpN2o43BDqEbt4OzPj+22cKi7Vhkv+xIjm+zw7taN3SwGjxk3SsLWJui1hWvWOZuPf08q7NNK9ttvXFvSYJXMozRDq/2GviAxjMht2JkfF9SIVYMakETmatfJwLnpThvonWnwEGtnfkBORx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evISkj++; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f090093d8so3090992f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718119438; x=1718724238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qqhHKqu8J5x8pyYIaPsNCcIOlIn0KQ56jThNjIBi0ic=;
        b=evISkj++5UnmDaolLHiNXLOOMEqHgDi8gaDw1Wel1pgRotfyXJqeDOptKX/tPHVehE
         ge8NTBs1Ti73FE+M5CRBpZK9qOnDQk6WzlFkdr9yScvPKDdsh/OwedN+rHlsIZCj/s0e
         WzhLv0xJjxjgzAyYWMZiIDrSMAUf0MX7yQGlmGA9CwZRr4XKnT5R+nk6VJncPphCz5AK
         rtTOc7ppwpAD4NvzjrNT5WQ/wRyagbsuETbL+UAb/ddIgMAWAvl+5+eopnXe58rFzttW
         eQcx4sDlKWBxtYk0FU8m6jj+hIui972cEdNekYsQDx9h//1NemFt54HjVdew/7669uif
         U0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119438; x=1718724238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqhHKqu8J5x8pyYIaPsNCcIOlIn0KQ56jThNjIBi0ic=;
        b=lL/D3E6FFBOX0Fr/tXdo8leL7GDwAc3lB69pg92Fe7gJhCnFEGPHCyNwnlUf695vLW
         XGb49mLxWNlW/NSnnNVvra3ZD8iuALihFLlaD8NQvXlWUx7XjAtFWPgQlLLFGO9//+PQ
         HYgZ+BUqFdDgIAGzRLJ36HAGHUuUf1Xc1LpdU3iG3nlvBiz7H5XrLKaad7bhEQFstgRE
         nSw3IK3fMf0XKXJAxmC3sgf7W/UBpzTh5TLx682Xrf08xvOZkT8MewR9bn/lJfdVAP4b
         4UUCFy/VUa/Xzk7EoxZRgp76XSE0lOnjq76WNIAu+HyvSONpUnoK+ttYYlKc3A+6IgGx
         1r+g==
X-Forwarded-Encrypted: i=1; AJvYcCX7dJeMDlqcEUoyDxT1OnZD/PJMqc/2ZlRsz4it/9Kpm1UaPnwzcFqFXvyH3eAxX3syW8C5i0WDts3b+ajcKyaoMqcfidGYKd2dk1Bl
X-Gm-Message-State: AOJu0YyLiDd6Z/WBVCdyxGlwKIvpAM8nR2Q4kOTLf0fvG5T+HRd4Ke0Q
	ZeICLKuo3jtx8PX5CNxElByW2vBK9tG2bhlUi4yNweII7jqm7O9m
X-Google-Smtp-Source: AGHT+IHcFnG6/IspHE0p3GMElQnHHuNm9W//aQQuoYBzkQbmaxLJxzn8ycr9NDfb+FwJsULVkcyrrQ==
X-Received: by 2002:a5d:4010:0:b0:35f:1d13:c843 with SMTP id ffacd0b85a97d-35f21254c37mr4445617f8f.11.1718119437544;
        Tue, 11 Jun 2024 08:23:57 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f301dfc52sm1167545f8f.82.2024.06.11.08.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 08:23:56 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH] staging: vt6656: Fix checkpatch unnecessary parentheses
Date: Tue, 11 Jun 2024 16:22:56 +0100
Message-Id: <20240611152256.24563-1-engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary parentheses - according to checkpatch.pl strict

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/vt6656/TODO       | 2 +-
 drivers/staging/vt6656/baseband.c | 8 ++++----
 drivers/staging/vt6656/main_usb.c | 4 ++--
 drivers/staging/vt6656/usbpipe.c  | 8 ++++----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vt6656/TODO b/drivers/staging/vt6656/TODO
index e154b2f3b247..507b7aec9f14 100644
--- a/drivers/staging/vt6656/TODO
+++ b/drivers/staging/vt6656/TODO
@@ -11,7 +11,7 @@ TODO:
 - switch to use LIB80211
 - switch to use MAC80211
 - use kernel coding style
-- checkpatch.pl fixes
+- checkpatch.pl fixes -- done
 - sparse fixes
 - integrate with drivers/net/wireless
 
diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
index ad7b963f0d98..c981fc75a030 100644
--- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -230,8 +230,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
 
 	dev_dbg(&priv->usb->dev, "RF Type %d\n", priv->rf_type);
 
-	if ((priv->rf_type == RF_AL2230) ||
-	    (priv->rf_type == RF_AL2230S)) {
+	if (priv->rf_type == RF_AL2230 ||
+	    priv->rf_type == RF_AL2230S) {
 		priv->bb_rx_conf = vnt_vt3184_al2230[10];
 		length = sizeof(vnt_vt3184_al2230);
 		addr = vnt_vt3184_al2230;
@@ -275,8 +275,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
 	if (ret)
 		goto end;
 
-	if ((priv->rf_type == RF_VT3226) ||
-	    (priv->rf_type == RF_VT3226D0)) {
+	if (priv->rf_type == RF_VT3226 ||
+	    priv->rf_type == RF_VT3226D0) {
 		data = (priv->rf_type == RF_VT3226D0) ? 0x11 : 0x23;
 
 		ret = vnt_control_out_u8(priv, MESSAGE_REQUEST_MACREG,
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index 7bbed462f062..86085f3674c1 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -339,8 +339,8 @@ static int vnt_init_registers(struct vnt_private *priv)
 
 	/* load vt3266 calibration parameters in EEPROM */
 	if (priv->rf_type == RF_VT3226D0) {
-		if ((priv->eeprom[EEP_OFS_MAJOR_VER] == 0x1) &&
-		    (priv->eeprom[EEP_OFS_MINOR_VER] >= 0x4)) {
+		if (priv->eeprom[EEP_OFS_MAJOR_VER] == 0x1 &&
+		    priv->eeprom[EEP_OFS_MINOR_VER] >= 0x4) {
 			calib_tx_iq = priv->eeprom[EEP_OFS_CALIB_TX_IQ];
 			calib_tx_dc = priv->eeprom[EEP_OFS_CALIB_TX_DC];
 			calib_rx_iq = priv->eeprom[EEP_OFS_CALIB_RX_IQ];
diff --git a/drivers/staging/vt6656/usbpipe.c b/drivers/staging/vt6656/usbpipe.c
index d505b4b69ba4..42b2e0a0a431 100644
--- a/drivers/staging/vt6656/usbpipe.c
+++ b/drivers/staging/vt6656/usbpipe.c
@@ -287,7 +287,7 @@ static int vnt_rx_data(struct vnt_private *priv, struct vnt_rcb *ptr_rcb,
 		return false;
 	}
 
-	if ((bytes_received > 2372) || (bytes_received <= 40)) {
+	if (bytes_received > 2372 || bytes_received <= 40) {
 		/* Frame Size error drop this packet.*/
 		dev_dbg(&priv->usb->dev, "------ WRONG Length 2\n");
 		return false;
@@ -299,9 +299,9 @@ static int vnt_rx_data(struct vnt_private *priv, struct vnt_rcb *ptr_rcb,
 	/* if SQ3 the range is 24~27, if no SQ3 the range is 20~23 */
 
 	/*Fix hardware bug => PLCP_Length error */
-	if (((bytes_received - head->pay_load_len) > 27) ||
-	    ((bytes_received - head->pay_load_len) < 24) ||
-	    (bytes_received < head->pay_load_len)) {
+	if ((bytes_received - head->pay_load_len) > 27 ||
+	    (bytes_received - head->pay_load_len) < 24 ||
+	    bytes_received < head->pay_load_len) {
 		dev_dbg(&priv->usb->dev, "Wrong PLCP Length %x\n",
 			head->pay_load_len);
 		return false;
-- 
2.39.2


