Return-Path: <linux-kernel+bounces-168568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF238BBA43
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1BEB219CD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 09:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E891B812;
	Sat,  4 May 2024 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GREEPBvf"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41617BD2;
	Sat,  4 May 2024 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714814738; cv=none; b=GdbeWr8yYFY2zCgp24ALtelkiIjyyZgyjlkRM9/MV2yW6QZuARW7R3/Oq5lJTrvq2rnTOmJLvbZRkzYviE8n/EVPbJli8YZ+lTIyfbOR67ayiyiAoqBKDdTWZAYr3mqU+3CfvOqelmmFaiOya1os6KsDmJrrQMfxp2vIreqr1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714814738; c=relaxed/simple;
	bh=SBV0YTIGf4QZN2NAEEyjUbqt6W8cHbST+VRb3fNAfIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kM4QW5QYNcOLGVdxv0Ve720wqJs6shmVDxzwdVc2V2uCB74dvZgq/+H/8mqT+cgK67R7kb8mTENYstVLr8gVMneWk7h9m0vxoPOG8v8exgstWE6HtR2b92rL80JlbXQtyDXwoueYniAVGEO5vWY5jYcm9C5432VNO4KYs4APsVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GREEPBvf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so7159081fa.2;
        Sat, 04 May 2024 02:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714814734; x=1715419534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xuv0N0keGYPC/4l/S7SLIx1PoiOhwO//3OuTJ4xJaxo=;
        b=GREEPBvfxfcyhwdgxQYzsrXlJoBu8ieKTSIzNUckxtm45V+6ZR9RoZhBFjx+amKLka
         NHv6Ndw4aHmVU1fL/fjZfQQMPe6/N0YKxa0wa0BEXokFHdlQ6tewJIxWMPYk8cActvzH
         HqUE0xpYqjWg98aLzcJFcDkaHSa9vbkSoiQ++qC3R8R7tMNTiDJOH1yLVM4ZugV7lkgC
         EyOQ9IQ4lLlkSioSVxSuDxPqTGBksmkbtl70vNLtPHfD07DYgEkEsvW8a5GTohZGAlIa
         hA9KLuFeG7lMIalZKhVxRUGDA8/yFAZaV+gm+QGb48S19Ny6PBXmghBW/a6NjK1ae50/
         Bukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714814734; x=1715419534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xuv0N0keGYPC/4l/S7SLIx1PoiOhwO//3OuTJ4xJaxo=;
        b=PyscEPlP8Dip3oNw7GFtOBP6Q76ZNQMFuFo+M5lc7fGa2uJYaSdj9rIjZCq9BjjMra
         ttzK1829yJgYw+yma7B/zwYz9+OZc3rtRZ441San3uEtHJ8jB/2LWDiZnqbbw5ZtQ7vv
         pwLiR3TYJ3b5ocG+l6N5mRY0o6HArifFItNu/ucAtIUExn4GBc1X/Svj2OO6zvXXo63K
         949AEIiIdVfAOCT/34oPTZweegEbNJnv5hDCkx8wRnu/ZU/dohtPrsxOQYJtTtk+cSSO
         4i+XJmh+0Zedw26dyP7IPH3NwSlIRDOxV4DVVYEAJd2Gj9KMDje03RQBfeCBjTtAEBou
         bquQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz7/U+yYISyyCsKyYWUXU2KxcdYnO1N1Ocat8tkj1/Waf+jDrjdmKpJ7zceRWO5c71Vxv7yay/fJWrA2CaFIJ9SkDBkQiNmSm10WFr
X-Gm-Message-State: AOJu0YzfBQ8GWDkfkAwtB8LYUkzbjKLo/tie8jc5kG1yboBUA4eYe1D+
	Taec4qDZGubbQuCTktZxAffcoTJRc7uKim5kZvNGHmha8Ep0hQX57Bv1yTx7X8c=
X-Google-Smtp-Source: AGHT+IH2XmqD0F04kkHlKF1h2w9FzRp+AlxlQ2eIArh/KXWOpF6s1B/oqchYzq8O9Ze9BZ9y4tAEmg==
X-Received: by 2002:a2e:a406:0:b0:2e1:9c57:195a with SMTP id p6-20020a2ea406000000b002e19c57195amr4507372ljn.32.1714814734198;
        Sat, 04 May 2024 02:25:34 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id ce3-20020a170906b24300b00a587831c09fsm2740231ejb.186.2024.05.04.02.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 02:25:33 -0700 (PDT)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Jonas Malaco <jonas@protocubo.io>,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Marius Zachmann <mail@mariuszachmann.de>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (corsair-cpro) Use complete_all() instead of complete() in ccp_raw_event()
Date: Sat,  4 May 2024 11:25:02 +0200
Message-ID: <20240504092504.24158-3-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504092504.24158-1-savicaleksa83@gmail.com>
References: <20240504092504.24158-1-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ccp_raw_event(), the ccp->wait_input_report completion is
completed once. Since we're waiting for exactly one report in
send_usb_cmd(), use complete_all() instead of complete()
to mark the completion as spent.

Fixes: 40c3a4454225 ("hwmon: add Corsair Commander Pro driver")
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/corsair-cpro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index 8d85f66f8143..6ab4d2478b1f 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -140,7 +140,7 @@ static int ccp_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		return 0;
 
 	memcpy(ccp->buffer, data, min(IN_BUFFER_SIZE, size));
-	complete(&ccp->wait_input_report);
+	complete_all(&ccp->wait_input_report);
 
 	return 0;
 }
-- 
2.44.0


