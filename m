Return-Path: <linux-kernel+bounces-562430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30F4A62731
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 07:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A94516DBAF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 06:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB50619539F;
	Sat, 15 Mar 2025 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="d49fuP0c"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9A418FDAA
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742019801; cv=none; b=Qaop18kGMblJrwTOfHFgxPsRvn6IKUUXvY5O86z2i3j4rhDmSRo24CkPL81BTvUW1TrVrAyxvl8dZjxuP/v6WvwnssG4bzmGfUcCf+Q6AIsqta2I3WhmjXTHkTbtkYB3Foq8Hnc9b6R2OapkwIKnTL2jGiSzNBAo1Nhk8QVwxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742019801; c=relaxed/simple;
	bh=UhBM4pXTlWVL12L7lqL0+yBZvc2QuVzc9NuuMd1x+bU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ox58Nbj1s6kqOtLTHXDOhpdSqubfzK79jyj15xxD7YF1sV4+7zLPoev+3jxNN2L9T7obOCpZJPqftCnbem77SVUhKRj5W4s4dgqemmEIRnhrKJ3NJaIboTNz9OrP67aP6TaDuevlbinvbGfJDCHy2yi1c46HGspW8kpiJVL1QCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=d49fuP0c; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22409077c06so72098245ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 23:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1742019798; x=1742624598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0KszbQGYSFCwVUgrvxHeEGEUnJnSO7Z/8njq0GzUlMo=;
        b=d49fuP0cxjLOAacVpRk3LHSMwbit0ISU2US/HptD8YhrtZUbz71/nqt6Y7t1rV7log
         aFB42RNGx6JOyTrdYkzEiOJg8UtIZLbGsJbhpJo0VOh33BbRIHxKZ7I9Uqsmr0raA+Ep
         gAq63m2Gec9Czf5c0Mk/Bnq/JEwF5mifbo1wpssBbyCApr79Pbwq0AxDZPNmkrSVwXQS
         7H7R/og2O+pv5EpSUd5/ypb9MkaxEWnQDoV1sLhgPbypoAHzJKNp3ZoKPnas4Zv5+Vk7
         bNxQqCInPKSH2BVmIq++FYdSf/qRzwQ9PZSQ/CN8EwiTy0kbVt4rrnWsDGGAceZX2Pk8
         Q+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742019798; x=1742624598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KszbQGYSFCwVUgrvxHeEGEUnJnSO7Z/8njq0GzUlMo=;
        b=m+HdmTvdddxXrbRs3u8UVEoBLiNauYXAdKbV07kuukv42LFwPa4OlTbLRuHE8AZf/6
         bODlumxFYJAlQsHyUNesdrkP7mL6+//lJWR+f+yefVgFJXdCwL0k2p5r/hNTdKvePrOU
         Al+lVpc+kJX8uHoYxPUlSKRTGQzdI3G8zFgZPYelBw4iqBT3bRQlkv9Up75hkjQHKy+7
         78vRPDp8l3V/Y0gqgj4hymB1FSIbM5KT/zK7PkKYtZMKoi5e5R3kdNJ7VSo3RVIVhJO9
         CXaf0Kvfee8unYuQOXhg+a0cK2zOUtaGHZ69i8cGBeYkM89EhnNJzWck0NfEMr/s5/v9
         U4Bw==
X-Gm-Message-State: AOJu0Yw/LHotRV/63e1G0zEuvuypRgPXVWoSGdIjTHY432awuuFDgW6Y
	LlEO4GqN+5enLj8t+VUL6Ml/2nO7/d/wVoktfnbP5p/38OoUOEiOZFeG5UelV7WK2c4w/A3C7Zr
	AiMIkpO6z
X-Gm-Gg: ASbGnctlajjzgjyb6vCgwg5rmWwTpP9R+vUkATGW/7jBC7/h3ens637D4vS+LhuUtim
	ynFjdKlRsWs0yKZGvrRMsh+b4+YoGuTwTSOnrjCjtqKpoWr5NjTntKq/SnOV746TVnIEZzjMJ2M
	LJC2Kq4wm4QcjSts7IoHczgij7eWvhnhjOoQHC5RN6+4a1uFvT7N6MNzqh+hTIoLOjXuTJpQs+h
	/AEHFGEg41g572GxTuxrKxLLGVczP0wN3yHFubIIw8hIDOSmFLLQlRt+xZdJvcy74gn/PPrSlWZ
	sHTz/GBKrYMYiANPAUr6Kn4Mp0Jbf8a/qDnoWrUMf08ai4jK+C11hHE3va5V06aNWDn4WR/Me8T
	DbrQsoiQZvbzGOrUKs+0F
X-Google-Smtp-Source: AGHT+IGY+JD/8omgd5y0cv+isNKK+7SjEmHaBED8D/f2KvED9loo4lspOXbT86nTlHw856WYq5ydqg==
X-Received: by 2002:a17:902:ef4d:b0:223:8256:533d with SMTP id d9443c01a7336-225e0b1961fmr75841485ad.46.1742019798054;
        Fri, 14 Mar 2025 23:23:18 -0700 (PDT)
Received: from zhk-CBG100025892.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa6absm38405815ad.90.2025.03.14.23.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 23:23:17 -0700 (PDT)
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
To: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: benjamin.tissoires@redhat.com,
	bentiss@kernel.org,
	jikos@kernel.org,
	phoenixshen@chromium.org,
	lschyi@chromium.org,
	Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Subject: [PATCH V1 RESEND] HID: google: add whitebeard USB id
Date: Sat, 15 Mar 2025 14:23:05 +0800
Message-Id: <20250315062305.1606963-1-zhouhaikun5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 1 additional hammer-like device.

Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
---
 drivers/hid/hid-google-hammer.c | 2 ++
 drivers/hid/hid-ids.h           | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 0f292b5d3e26..c3bd9448ef56 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -576,6 +576,8 @@ static const struct hid_device_id hammer_devices[] = {
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WAND) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WHISKERS) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WHITEBEARD) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, hammer_devices);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 7e400624908e..981908a9e1dc 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -527,6 +527,7 @@
 #define USB_DEVICE_ID_GOOGLE_DON	0x5050
 #define USB_DEVICE_ID_GOOGLE_EEL	0x5057
 #define USB_DEVICE_ID_GOOGLE_JEWEL	0x5061
+#define USB_DEVICE_ID_GOOGLE_WHITEBEARD	0x5074
 #define USB_DEVICE_ID_GOOGLE_STADIA	0x9400
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
-- 
2.34.1


