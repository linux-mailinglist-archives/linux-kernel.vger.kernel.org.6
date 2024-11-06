Return-Path: <linux-kernel+bounces-399065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE059BFA77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403F21F22B9B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8620E01D;
	Wed,  6 Nov 2024 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpugjt5V"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6306620D4FE;
	Wed,  6 Nov 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937142; cv=none; b=Kqtj+/yMDFvSrRagdZjMU8+IUwNL0KBFxqAOVGMLoJzncYYgD8PpE7nagwYW9mwZsq5iavF7cDh7ZUK+haWn4RD2oPGbtTE2zZFHDAdOpgG2yl2uSWwuNA+Ez0h1aB30S69anGefVAfLKQX626EldI524BwC2ok3SYpf6IdgCWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937142; c=relaxed/simple;
	bh=Y1qQw4FYOeQlsbYrvpZWQ8Dw59H+2DFmX490k1WVDLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k6dyHfE6XEIx27m0nFs12NwT7/0/4ZGTsTYhiRwJIdivylUszj3oxc+ThJvjI21PG1FolhdEmHP22CzWj5l00CoQLuRqJGMa2UrRRf2zI4Epus85lxsI/z8EKmB8bHM48v3nkzCFpVGcmHB2v3BT5SkFwX9urgRB77M+/PxQIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cpugjt5V; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso318704a12.0;
        Wed, 06 Nov 2024 15:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730937141; x=1731541941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BZoQBXfahC5oBSPPmFRFV/8BoW/kEtqQMgBRoBlf8qA=;
        b=Cpugjt5VzAN/v7/to8uvPBmhzpIdttKyKgXwRDjST73nYk1Wc8Lv4VJwZpGdqAXi82
         j9p+GnHGXI2NyeofR8T88t0NrRFlkOjDrxRImD0EGLPTmxHLTLmR5VF9nB5g95tLLczX
         L7/qVruJjDCcY12XbPX9oI2EP6q67B3IVjLxv9lV2eP44GdyTGBAoSxxNvPSwAOj60dr
         3CwKlW2iZeDnjg539ry/gFoJeX3ZlCPOjEdaCJW5nRWJjGjVnaBqotTA2U9qdWSos/Zc
         eqcK68kBk6P0NEhf1z79oub2FB/6sZ6efH2u/s4t2p9Bs+kIx2UoV9TSDAscSh2y9+1e
         gdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730937141; x=1731541941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZoQBXfahC5oBSPPmFRFV/8BoW/kEtqQMgBRoBlf8qA=;
        b=dDjwWfKfjq0d9iBpNakhKxokMbQ5Za6jYjprKa9EdPESzn0LQ1PZMpa9LSX3iU3mew
         EwcHsDGGHjpWhqgvXU1fmHFctmlDNwdzATebWQpiKyF1dk1tohSE4AfzBfFSeIB7ogFC
         b1YD8lXt6BfBHKMFDtL8AXgI1n8uc90R+ezJoyizMpQIo6PLEaixvBEYbZnguJrMP8EV
         RfSys80M5FOm62HdmuEnzQSowcV8xSs1OJbbFdAbzddGraEmmAJ+vceNWjsRPfXrd1PS
         1vk5hlpEtLpP/kvHQNFO8K4qCjI61SMXQ/X/5gm8O6o8xvcKmU4VihUZtGdXL3c0uVrF
         kMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLjqQF6HbJb5udZuN0fDXF/p0DD4fw/y0rFnN6Smrql4a2POPNUsjrDrCtToWannXU9rfYr4Mm6yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfswwNIMeQjZ8RGeFQ6uhmBfnFWE1RBv2OZsBvGri5T9rVPFQL
	2KYQoWZ9mpXheAbrDCBBT7FzjAiOAjTSAB2ifKwPYUEuTbpAjD7c
X-Google-Smtp-Source: AGHT+IEaWT2x2dkg8hWnsbNNHdlIEVlmXRlcTy4iqlOjzVVEHmONb9iRe1bPNQFrAFanCQABHTAY7w==
X-Received: by 2002:a05:6a20:7346:b0:1d2:eaea:39d7 with SMTP id adf61e73a8af0-1dc105f22cbmr1976871637.9.1730937140712;
        Wed, 06 Nov 2024 15:52:20 -0800 (PST)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:c934:17a7:b0a5:6e02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a57105sm115903b3a.192.2024.11.06.15.52.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Nov 2024 15:52:20 -0800 (PST)
From: anish kumar <yesanishhere@gmail.com>
To: corbet@lwn.net,
	broonie@kernel.org,
	dlechner@baylibre.com,
	u.kleine-koenig@pengutronix.de,
	Jonathan.Cameron@huawei.com,
	pstanner@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH 1/2] Documentation: devres: add missing mailbox helpers
Date: Wed,  6 Nov 2024 15:52:16 -0800
Message-Id: <20241106235217.94718-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mailbox api's were missing from the devres documentation.
This patch adds them.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 Documentation/driver-api/driver-model/devres.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 5f2ee8d717b1..8350a098f81f 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -346,6 +346,10 @@ LED
   devm_led_trigger_register()
   devm_of_led_get()
 
+MAILBOX
+  devm_mbox_controller_register()
+  devm_mbox_controller_unregister()
+
 MDIO
   devm_mdiobus_alloc()
   devm_mdiobus_alloc_size()
-- 
2.39.3 (Apple Git-146)


