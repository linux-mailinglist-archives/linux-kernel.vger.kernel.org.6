Return-Path: <linux-kernel+bounces-309945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112B3967247
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 16:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C333B283743
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF82C23776;
	Sat, 31 Aug 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdeOLmVf"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8146AD55
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725116384; cv=none; b=X4W7lXCSK+foAthkHHmydo1aEhQKhUcDIvrcACzuJp+yEbwNmgBPNUerAekFw7xgRGhb+Qh10ZapLqRKEbJxtsFVkwHSsGeGeHxw1KLRP4Qn2hce91On+hOYZGU69zfvXset4EPuWS5UXQCJgEJGrE6ed1UR/EEHbiquau8q+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725116384; c=relaxed/simple;
	bh=Pn8KwUv0DkKQ+7ZtjyoKep4bskoqW4L9AuBTQBa8zuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFhkQtXQr2CH4eSZf63/HzV8Ig9MQWQbPEHVbPQkNnJ4msXxikaNDcigdRtUqgDFZCzE101nmCwECXLWyOJnNMciVZrsXogCQHz/omogn8Lv0spxgqPAFj/GfhHBx32B1fhQ3m9vjjFq6A26ce9R+VB1DPDXaqlGi9IPzli7vEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdeOLmVf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2055a3f80a4so774045ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725116382; x=1725721182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyVG1AgOZE9WJVZe0FpJwMfaDm+MjzUmj8n+GYSoTc4=;
        b=jdeOLmVf35Z/LzkDdOZoOBaQSMUXZQ/fzimyEoE6YhJRzww7ScPU3UoAj9e2P1Al34
         2qVW3m0R0FaRXo55UwS7dM3UkGC5Rlggjo+kWrpIcg3q0QKZ/J9mZvKDMSoc3KeYdsZz
         evquPnZp9qvm0NmB+NOMiMSQnNfUGGVrBHnFR9KTsxvJL8sxHV6gRgsCDp8H/bW9JVuM
         XJ83AFXKaMF9XuDMtVpSQYlUJm8oF7PdnNGttBHgwwXL0Ejr8P3ct/+7Nu4hCwv8pyul
         p6KchqVwdGa4eXvCKVutUWzpnanboesVUa3AhIHWFJiy/BxcdQ1V9DUi6ELqbQYZd65V
         BvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725116382; x=1725721182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyVG1AgOZE9WJVZe0FpJwMfaDm+MjzUmj8n+GYSoTc4=;
        b=eZKrZBaS9vjgGbX6/q16LTDFthKb4d9p8y0hb6B6xMU84bvdzWsgVbFoYKRBUxUhHU
         lg+UWwop8VIid6XHZGPPGYRslHZXo4nA/aBOINYmp09uftjnCMlcWBKMCYRCAr1em62U
         xEkAHKvRDUInf1J7Esh0iAkuHiLtHndurbSeyDPc/pw/QwQbkqDKI/y64ABPGrJS2vD+
         +EjghXK62+Ft7o4eyVa0j4s4GG99gjIORCIIFLGjhwvQYG8I5QVT+mUxNWY1h96pmxZg
         XNIXQb6dnJ+d6QERzp/+RgOIXfBJVhmSbL5UZ/E2z1/MMH8chby8r9VCxNmJYGKhWgLt
         1ueA==
X-Gm-Message-State: AOJu0YxUOXnWRIlfPr5RvUqJF73pXzp8Yt9aoGJa5DsxmXG0lr14l0rj
	OWaX1pxWhX4Ip3R/FQJHjhcOpX4aJSzD4eoyaKMZC9HCvxsK7ltAecVhg7kH
X-Google-Smtp-Source: AGHT+IFFBXtR4oC1CxsZUzXfcNqZjWooOa3vPuKcBV2xy77m/B/eASaxdy4YIUPTCK7rRWJO6GOCQw==
X-Received: by 2002:a17:902:c94a:b0:202:3dcd:23ef with SMTP id d9443c01a7336-205447bc4c5mr20674015ad.61.1725116381799;
        Sat, 31 Aug 2024 07:59:41 -0700 (PDT)
Received: from fedora.. ([106.219.166.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205456242fesm12548175ad.53.2024.08.31.07.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 07:59:41 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: rtl8192e: Rename variable eRFPath
Date: Sat, 31 Aug 2024 20:29:32 +0530
Message-ID: <20240831145932.37744-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable eRFPath to erf_path to fix checkpatch
warning.

Issue reported in checkpatch:
-CHECK: Avoid CamelCase: <eRFPath>

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8190P_rtl8256.c   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 7061f1cf4d3a..256c19739ad1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -12,7 +12,7 @@
 void rtl92e_set_bandwidth(struct net_device *dev,
 			  enum ht_channel_width bandwidth)
 {
-	u8	eRFPath;
+	u8	erf_path;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	if (priv->card_8192_version != VERSION_8190_BD &&
@@ -21,22 +21,22 @@ void rtl92e_set_bandwidth(struct net_device *dev,
 		return;
 	}
 
-	for (eRFPath = 0; eRFPath < priv->num_total_rf_path; eRFPath++) {
+	for (erf_path = 0; erf_path < priv->num_total_rf_path; erf_path++) {
 		switch (bandwidth) {
 		case HT_CHANNEL_WIDTH_20:
-			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)eRFPath,
+			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)erf_path,
 					  0x0b, bMask12Bits, 0x100);
-			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)eRFPath,
+			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)erf_path,
 					  0x2c, bMask12Bits, 0x3d7);
-			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)eRFPath,
+			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)erf_path,
 					  0x0e, bMask12Bits, 0x021);
 			break;
 		case HT_CHANNEL_WIDTH_20_40:
-			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)eRFPath,
+			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)erf_path,
 					  0x0b, bMask12Bits, 0x300);
-			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)eRFPath,
+			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)erf_path,
 					  0x2c, bMask12Bits, 0x3ff);
-			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)eRFPath,
+			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)erf_path,
 					  0x0e, bMask12Bits, 0x0e1);
 			break;
 		default:
-- 
2.46.0


