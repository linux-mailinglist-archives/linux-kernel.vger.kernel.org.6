Return-Path: <linux-kernel+bounces-416516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E019D463D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB356B21FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810E1C4A00;
	Thu, 21 Nov 2024 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b="s3gAA+A4"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C61AA79C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732159591; cv=none; b=H8Ha7qQKpQp3/PDFuCDQ+pjzfpUOuHuGk0k8O1kzp+iO40PT2lBZJVYF7J17Q77eLMGVk9PiBIpZS2wV4f6HtLvXT5lPTlHVCrS/KJAcbmxJ9lvyIVw7M7sxl+DaJYCHjfifQmJGJ2YNwpdkXRtycMf8gzGo0U0M3CnunxU593g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732159591; c=relaxed/simple;
	bh=+yrXz1GUE/K8Q0yIBcZRoRs9PBSEq/KPwLXawJfzQv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=roEhbbelMQdCzUdDMXl8xlyp2roc+BjSe2X9ilYD8VfCnb1JcDwkr5upVFJSxeCFLhObfOkr6A588bdAmB90X3pvy6Kt6LLbO2xLIl6srS4wTuxJZvwW10mI6CAS6+/nWzjbe97m+ibS3HxvZxQmTVHHfWljyICOnedQv3LoaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com; dkim=pass (2048-bit key) header.d=pegatron-corp-partner-google-com.20230601.gappssmtp.com header.i=@pegatron-corp-partner-google-com.20230601.gappssmtp.com header.b=s3gAA+A4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pegatron.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pegatron.corp-partner.google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21116b187c4so3094995ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pegatron-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1732159589; x=1732764389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3DXCzvlHaqVZPzF4W8+SDq0brlSGTZ+umxFqyKFRaM=;
        b=s3gAA+A4tCuI00MbzAPw+UM4G0EARXAVGuYYH4OKX8D1rTI5ZlaaqxXLXtzi+LDXID
         hX3PRFKIS+p+wHwnvUK1nCRaJN+AQCetRBLaH4M8U1JN+agJmeRM9W91hEGuwlC1Bpwm
         /QBEzaK+qLpWLHdvq1iKmADDn81DZ0U6zHK2PXw0IIS5BaZ+CjIT91AEWUAwq/T6YVYR
         22g8FS7l6dtQZIGT8D/Ze451oAfBm2EtrINvOcWZ+LAROrMmeqiu2ETUhO5IEziT7tz8
         xe1yNYrDll78N9wmVKRSPQdbJS5SiA4aJYrLEmWO2H/MamcQHIzR8Mb8cn2M0jjvswfZ
         TN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732159589; x=1732764389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3DXCzvlHaqVZPzF4W8+SDq0brlSGTZ+umxFqyKFRaM=;
        b=DhH3AGNB/yvaGUqx9FucP74q/5pWYoe18c30GTd8QNb+KqCCzGEZw47SRU5Oj0kWp3
         emjbcNEsJ3VRCVV403OwysP/IQQIMKX6cj4gzxamkJyQjzvgSv18EvaxwpwbvKi5v6R5
         JKy0qyWJ+EcNKYidVN6S7lCpgn02YmYKuyNYV+yilCyMHbdta+uOzlVSQoPtta1eSedT
         VMBPu30UPyY446UucQtoA1YW7NywoNe8N7ujGRVo62hNJxU7vMCmlc21yiX1LdaUPa8M
         W0xiRi5PHNTxabUUd9bOkNBWLdSa1Hqjeos0Tg3tcRfOyO40fBdyC7yDZTpAs9ZorN1R
         lkrg==
X-Gm-Message-State: AOJu0Yx7OTj33i4p+pJSAz+Ph7pP5dDx4h/MNydZvLIIij3urLgngZLD
	k5irz7LRo49daKgYHBTEGZpkfbOQm2L0y4YytAO844mzdOibxrrQgWPkIaiLBgTClEF2xF2qZmh
	m/68=
X-Google-Smtp-Source: AGHT+IE+GU8hUp6sU5Rde19QhG8YVVMxW3u3rjxitAg/gdg70CKNHCkYbIqJhdRoHkf8cxEJ+3qS6g==
X-Received: by 2002:a17:902:e550:b0:20c:9ec9:9a77 with SMTP id d9443c01a7336-2126a4750abmr59716745ad.37.1732159589226;
        Wed, 20 Nov 2024 19:26:29 -0800 (PST)
Received: from nakula-G7-7590.. (114-136-149-11.emome-ip.hinet.net. [114.136.149.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212883fe3acsm3077415ad.260.2024.11.20.19.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 19:26:28 -0800 (PST)
From: Herbert Wu <herbert1_wu@pegatron.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: geoffrey_chien@pegatron.corp-partner.google.com,
	hsinyi@chromium.org,
	shawnku@chromium.org,
	Herbert Wu <herbert1_wu@pegatron.corp-partner.google.com>
Subject: [PATCH] arm64: dts: mt8186: Add mt8186-skitty
Date: Thu, 21 Nov 2024 11:26:19 +0800
Message-Id: <20241121032619.16525-1-herbert1_wu@pegatron.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Skitty initial device tree.

Signed-off-by: Herbert Wu <herbert1_wu@pegatron.corp-partner.google.com>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Geoffrey Chien <geoffrey_chien@pegatron.corp-partner.google.com>
Reviewed-by: Shawn Ku <shawnku@chromium.org>
Commit-Queue: Shawn Ku <shawnku@chromium.org>
Tested-by: Geoffrey Chien <geoffrey_chien@pegatron.corp-partner.google.com>
---
 arch/arm64/boot/dts/mediatek/Makefile                |  1 +
 .../boot/dts/mediatek/mt8186-corsola-skitty.dts      | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 8fd7b2bb7a15..39372a275911 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -59,6 +59,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393216.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393217.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393218.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196608.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-skitty.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131073.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dts
new file mode 100644
index 000000000000..44cff44c12f4
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2024 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8186-corsola-krabby.dtsi"
+
+/ {
+	model = "Google Skitty board";
+	compatible = "google,skitty", "google,corsola", "mediatek,mt8186";
+};
-- 
2.34.1


