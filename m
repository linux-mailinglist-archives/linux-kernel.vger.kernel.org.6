Return-Path: <linux-kernel+bounces-379246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA6E9ADBFB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4435283F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12F1779BB;
	Thu, 24 Oct 2024 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCm850ly"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41529176AA1;
	Thu, 24 Oct 2024 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750733; cv=none; b=mf3zNGEYHb5zhmm7jpJAATD05YqfjDoxW1RCJ2quDGKnkQFcv6lD5BuNbuPjEgg8T+9FLTQseiShPBPWRQZURkY/I169lUIf9E20rU+RP3YHLQlJ17W44G0S6byfFW0riogR04YOZHR7um48rX599y98s6GRuMoYCPg/fo2/g5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750733; c=relaxed/simple;
	bh=usNgQL4ZkUkzNrPidpdCo9BRtmHdYIoxyz0zObdrPmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcOpuoQtWQAsgy9iNcy2Rty8pZ3vILLVctLF3r+5SE1tgIwkc5IKFG6XRWgzMXpjGZf4bWukZ6qXtE5TeHwacPnvzC3ojNXh96rngBmG0E137NL8uKR/Aw3InVeuHTj8pT2TvYhuNZV8Bdan2j/KF2N77uO8TeYZNe7sVZDs9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCm850ly; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e60f6ea262so320524b6e.1;
        Wed, 23 Oct 2024 23:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729750730; x=1730355530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXLvDWajhhfj7ALGh86/2Bkae+YpKlHx6XOu5tC70cQ=;
        b=NCm850lyESxMnkikjVU8AoR/fOkutWU65qFuHibKhR1+JTuWOprYzqHc38SGnhpl00
         DdTNnOh7s2qcsCRvJXIxJ5KxKtiecOBud8eff7VfS1v7WkF97ibm8I0CIWmbzEqWkgHt
         01ZeQkfdPcwYkBaZBy5da9/4nPcNsCt1z9jZYNOggcsRp5VM0a2lN18cOCazEpuePtGU
         BLaMKYMoRTarMrt1lpuR+KZu+D321/6xjAJMAveoqkfim/AUvs+KqxCsqGOxrh6UI3Y3
         qKhBShhlyV7Phi2ecYKZg5y4x0G3ci57McNgqfGO1luEWUBHq9HnFoArT8nlRCOX7H6a
         fVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750730; x=1730355530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXLvDWajhhfj7ALGh86/2Bkae+YpKlHx6XOu5tC70cQ=;
        b=JBgc7m+QarRQbYSELMj6ue5iSu8m0SvQdk1KleUtN3TocAvtxkTTbqLHJqMTTzanV/
         zXEst8Wiz2vusp9z3PyxaKr4A20q8LhfaoJc7wSiICrQWt/t6Dtem47lCxJ3+vdFL54T
         W7ESSeBynBm/nxWaZSnRNYtEPINEljsahqyWWdx9Q3qwRDy0b7AydaYqsfS1ZhFfPTEq
         HeNUp4rHw6QL5yQpIz6S6AlKpb2+AkZHGzjgcHeZvMogrEAgP5R+W3zes+kOet2lnJub
         dOZic8xHSpdWZ9X4381OwhiDrx//ZBFR7HWRoZuDxEPRe8cdsyCrbeEPCtFe/JIDAU3Z
         ug0A==
X-Forwarded-Encrypted: i=1; AJvYcCUITdJ+mrdtUNfV/8H/EQny0FwzzcK17s5dKbCS56g7uriTh1I+txwwVdYsbWT8xielMtHyrh49qCDBog09s5MLLEvGCQ==@vger.kernel.org, AJvYcCXVEKO7hkm9/v4aajy8FAKAoWwjLIsJsVPBRlW4B75DwGyNcL1BkY79JObzF8ITQnFODeQ20WwqpJtj3v0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59BfD9SLNNetCv6TbcoVvg66xBhsu0B6KVmOGgfutlBlPlJrf
	RgFjCsbPNUcUL9HYdaoR8Wv6C6WHqoiZsvqyLf5kw6x70QVT1jlN
X-Google-Smtp-Source: AGHT+IGgrhR7ZboEsFpdmO7eYnKdZ4MxJ5sCJ2Es07RCtc+525nnSPVsAqhUc3l8bP1kqQITUMTjnA==
X-Received: by 2002:a05:6808:2e8f:b0:3e5:f2f4:9a73 with SMTP id 5614622812f47-3e62cbb9327mr1002024b6e.21.1729750730271;
        Wed, 23 Oct 2024 23:18:50 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab48f46sm7901662a12.41.2024.10.23.23.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 23:18:49 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v7 2/4] alienware-wmi: alienware_wmax_command() is now input size agnostic
Date: Thu, 24 Oct 2024 03:18:39 -0300
Message-ID: <20241024061838.34558-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024061547.33918-2-kuurtb@gmail.com>
References: <20241024061547.33918-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alienware_wmax_command() now takes void * and size_t instead of struct
wmax_basic_args to extend support to new WMAX methods. Also int *out_data
was changed to u32 *out_data, because new interface specifies u32 as output
parameter and all previous callers would pass u32 * regardless.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
v7:
 - Unchanged
v6:
 - Unchanged
---
 drivers/platform/x86/dell/alienware-wmi.c | 29 ++++++++++++-----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 16a3fe9ac..b27f3b64c 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -500,15 +500,15 @@ static void alienware_zone_exit(struct platform_device *dev)
 	kfree(zone_attrs);
 }
 
-static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
-					  u32 command, int *out_data)
+static acpi_status alienware_wmax_command(void *in_args, size_t in_size,
+					  u32 command, u32 *out_data)
 {
 	acpi_status status;
 	union acpi_object *obj;
 	struct acpi_buffer input;
 	struct acpi_buffer output;
 
-	input.length = sizeof(*in_args);
+	input.length = in_size;
 	input.pointer = in_args;
 	if (out_data) {
 		output.length = ACPI_ALLOCATE_BUFFER;
@@ -541,8 +541,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
 		.arg = 0,
 	};
 	status =
-	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
-				   &out_data);
+	    alienware_wmax_command(&in_args, sizeof(in_args),
+				   WMAX_METHOD_HDMI_CABLE, &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[unconnected] connected unknown\n");
@@ -562,8 +562,8 @@ static ssize_t show_hdmi_source(struct device *dev,
 		.arg = 0,
 	};
 	status =
-	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
-				   &out_data);
+	    alienware_wmax_command(&in_args, sizeof(in_args),
+				   WMAX_METHOD_HDMI_STATUS, &out_data);
 
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 1)
@@ -589,7 +589,8 @@ static ssize_t toggle_hdmi_source(struct device *dev,
 		args.arg = 3;
 	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
 
-	status = alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NULL);
+	status = alienware_wmax_command(&args, sizeof(args),
+					WMAX_METHOD_HDMI_SOURCE, NULL);
 
 	if (ACPI_FAILURE(status))
 		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
@@ -642,8 +643,8 @@ static ssize_t show_amplifier_status(struct device *dev,
 		.arg = 0,
 	};
 	status =
-	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
-				   &out_data);
+	    alienware_wmax_command(&in_args, sizeof(in_args),
+				   WMAX_METHOD_AMPLIFIER_CABLE, &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[unconnected] connected unknown\n");
@@ -694,8 +695,8 @@ static ssize_t show_deepsleep_status(struct device *dev,
 	struct wmax_basic_args in_args = {
 		.arg = 0,
 	};
-	status = alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STATUS,
-					&out_data);
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_DEEP_SLEEP_STATUS, &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
@@ -723,8 +724,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
 		args.arg = 2;
 	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, buf);
 
-	status = alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTROL,
-					NULL);
+	status = alienware_wmax_command(&args, sizeof(args),
+					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
 
 	if (ACPI_FAILURE(status))
 		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
-- 
2.47.0


