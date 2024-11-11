Return-Path: <linux-kernel+bounces-404554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA949C4553
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5464DB251B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8511AA7BA;
	Mon, 11 Nov 2024 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLLkgw8+"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C221A256F;
	Mon, 11 Nov 2024 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350160; cv=none; b=PGfWB+pYKFd0MYxuQtlxSa5caIstKUvuRUHyZtYCR9mP83ptA+CGIc5P5FZ6sQ+tPl/2+M9mTX5rwd33BVw4XLEWFnMyl4nhi1fXq2KQHR6ZQ2NmUyRrIH1Y4KzRMEuZAQ9MjNxfBHOb1DOU4xZBmF4BeyB/IGrA1hWgrnhBgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350160; c=relaxed/simple;
	bh=uVnSBa6MPZa4wpsyJv9t4bQvwFnuLkX2JkCiZXDD3Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xew5r1w/bijoSeqQ52p2gwWRUH85aKgATcCOx0eREjpPTAI/YBPuz7fgJmsU0sXIXezG9u0w5D3Yhbo/RWFZ+sBY4GzcyVf6kWqiw7F/7cdDLoqggWM7pVGqF1azJH8XFHTVog31Ictf3htBDYmS2WioaLrGeId8SwD5Ll2VhFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLLkgw8+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-720e94d36c8so4976238b3a.1;
        Mon, 11 Nov 2024 10:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731350158; x=1731954958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrlF2QlkqvavRaB0bhBayO6wL9geqfEeiXA9NsnbbN4=;
        b=cLLkgw8+oHrhfsBrZiRNhy7L1xMeYD9Tin4Ckw8I/KGXZOY+MLISbzQkd8UI/i0YZB
         6Js1hQ7bhypTQ3RZmW7og21b1hRpPvcLipTUbKKg+l7GCareiHNbRKWtapplbR1hS+co
         4qZkUC9iWsJGXJYHBmz4H5E738Xy4AsC9RptwRnIoWqRZFqL0PX6QEWFbK3upDq2CMXf
         ZUoba1HEFBIjV7pDEZR0jkdW5Qi2aDhdS2UUpNlAQWbD5inJ20Hcf1r6Z6/D3rZk3f+6
         QKnsSgwWHHr+csebPhLZoKEEyNT7OWslthF0qZeyFVZ+x59tq7x4i16hGfl3stB/PxAU
         txdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731350158; x=1731954958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrlF2QlkqvavRaB0bhBayO6wL9geqfEeiXA9NsnbbN4=;
        b=VnwPI6N6MC5a+soy2sjNXe0m2c2cFjQKDYtm7l0snlltvhet/szJE8MvPLsb0HXwhH
         4ju/YLSYOqL5cfZidJ2SB/W9bFYwDuOJSlwFGFTB+ISa7NyCircv9I7IEVKbABcM4D2h
         1uk2I1DGF4VO97OvqayJXMuXmZEmDkk9XqxC3MtlEOSpgfHfSkPcJaxdfaO7FmJlz/eo
         GDA1es/F0aQvlgI6SUuQ9ygJvmYaP+dOQsPCHfeGAzw/sfCP6J6JfBGcQamYOl3JVAzy
         rJrOFVgn2zTegJkG0gxYSaz8kPxyN1CEVtixZB1jUj4xDibXRMCmDtuAgkwOHAUprbOB
         xvGg==
X-Forwarded-Encrypted: i=1; AJvYcCUDQFhSHzypJk6RSUl4/VWX96UlYmI0d3KbRm1XUPPOfyXoJ6Mi4b9utLcVvfN2jlOJulx9bBjVKZGvxnM=@vger.kernel.org, AJvYcCXSRCXY9/C5azSHMQBr+GRJ8Ty9ihYgAnoQEa/vi6bc2jYun1meIToAHIwN3z2RIC3Mef/A3RfBvEqboHXVrbmGXJSz9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9JEuQVomSsVSfVcJphLQMo/L2n6KWHlNR/H/j83iW1Vhvdgo
	a/VKAIjSYn3Bq9FtihFhdIGhtphL+01WOwTox4mBbsL9uRwkbeZR6UOcyA9U
X-Google-Smtp-Source: AGHT+IEV8akVw3PnQgIm9B3KPwlRTcK3Lpdc+GHqupHLhwXliAnZslzKHxx66jWPMsNaowBQMvj8nw==
X-Received: by 2002:a05:6a20:3944:b0:1d9:19bc:9085 with SMTP id adf61e73a8af0-1dc234afb33mr21248096637.14.1731350158318;
        Mon, 11 Nov 2024 10:35:58 -0800 (PST)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a57210sm9737603b3a.186.2024.11.11.10.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:35:58 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: ilpo.jarvinen@linux.intel.com,
	w_armin@gmx.de,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH 2/5] alienware-wmi: extends the list of supported models
Date: Mon, 11 Nov 2024 15:35:46 -0300
Message-ID: <20241111183546.14617-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111183308.14081-3-kuurtb@gmail.com>
References: <20241111183308.14081-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds thermal + gmode quirk to:
 - Dell G15 5510
 - Dell G15 5511
 - Dell G15 5515
 - Dell G3 3500
 - Dell G3 3590
 - Dell G5 5500

Adds thermal quirk to:
 - Alienware m18 R2
 - Alienware m17 R5 AMD

Support for these models was manually verified by reading their
respective ACPI tables.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 81 +++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index bcc80ca8861c..d1e72915ed4d 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -188,6 +188,15 @@ static struct quirk_entry quirk_asm201 = {
 	.gmode = false,
 };
 
+static struct quirk_entry quirk_g_series = {
+	.num_zones = 2,
+	.hdmi_mux = 0,
+	.amplifier = 0,
+	.deepslp = 0,
+	.thermal = true,
+	.gmode = true,
+};
+
 static struct quirk_entry quirk_x_series = {
 	.num_zones = 2,
 	.hdmi_mux = 0,
@@ -231,6 +240,24 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_asm201,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Alienware m17 R5",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m17 R5 AMD"),
+		},
+		.driver_data = &quirk_x_series,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Alienware m18 R2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m18 R2"),
+		},
+		.driver_data = &quirk_x_series,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Alienware x15 R1",
@@ -267,6 +294,60 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_x51_r3,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Dell Inc. G15 5510",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5510"),
+		},
+		.driver_data = &quirk_g_series,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Dell Inc. G15 5511",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5511"),
+		},
+		.driver_data = &quirk_g_series,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Dell Inc. G15 5515",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5515"),
+		},
+		.driver_data = &quirk_g_series,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Dell Inc. G3 3500",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G3 3500"),
+		},
+		.driver_data = &quirk_g_series,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Dell Inc. G3 3590",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G3 3590"),
+		},
+		.driver_data = &quirk_g_series,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Dell Inc. G5 5500",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G5 5500"),
+		},
+		.driver_data = &quirk_g_series,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Dell Inc. Inspiron 5675",
-- 
2.47.0


