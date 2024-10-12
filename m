Return-Path: <linux-kernel+bounces-362015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DEF99AFF9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C621F22E8E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E79DDD2;
	Sat, 12 Oct 2024 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze9M/3Fk"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE78C13C;
	Sat, 12 Oct 2024 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728698545; cv=none; b=DlF9pfYp2G7zXgpolZjmYtJybI174hpHl6FUmgMgUeaLehVOrH93aBr+u2Ji8CmktVWPEQ8M0QeuX4iAN7nPULLAkGK7YiY4lKwx66h+MQLOxONcjy98AWnzlspWMLCtCW3DkMjSJrXM+Y12gUM64Ro8ZErBHmH97w8rYYx4s0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728698545; c=relaxed/simple;
	bh=QvqU/0s0+p7NCiBslJKW6/r/0xfhfdgPKOda1IKowok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivQh1Gq49SU/o9n9GCxFMkR3yWqwzwUa9RPZ62uSD3dkrz6qh45YJ25jnYXpypUjpSHKwoOoGKKj4CF4+nJBFonNQsXw3FFIOH4hYpEtZ7kKzx7fJci3MEu/3Soq67/P6GJ0lbpJEv7DqYN8gVUcd+sizoMd1KGuqQJeweg55+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze9M/3Fk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so2638273a12.0;
        Fri, 11 Oct 2024 19:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728698544; x=1729303344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVRKELwveqjnsA00akqlt37wgG9GG+cgl7++DvV05WU=;
        b=Ze9M/3FkFsNDJcxUEPla3GMvWevc5NiGyu+i4fl+DTTVANQ26d53IuK1/1NwYCCMMb
         FkX0G0N68h+a12DHMholDkQlrXM/g8BCQos+tjh+Ysp3GvC2Q3/WKOV3hoKVxJQd84sG
         T7FR2UvgksJNJ6dm8sijU60prF45tjfnKKyTJqZ5qidoqhw5tpUTaB9Sa+j2x0N3U+Kj
         wSrPj569BnmVFbhDLyeV8OcAdwU3vlcVwz5vZEWSOzWt0SsdmMuqrdY6VOruEFlf0E3N
         +k/nFYaLMsZhYrjrU2U2rKGp9Nf+A3BLg5dU5WbBIERbLWURC/JntavAxMXOOTLnE8kt
         c9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728698544; x=1729303344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVRKELwveqjnsA00akqlt37wgG9GG+cgl7++DvV05WU=;
        b=Be+TMLer9vr1uMkN88cbnpeiorvy3rwyb9GtMQljL2Rywd9KvWKNj2E5siw5MTD+vA
         335wOLnpCCKT5zm7VE4nGXi+SWDMYxYet5BYl65MaJK2DIFoBM7uMiRummkEd03xFKxs
         bqkaE/gYy3PJrIsWSYjxl5WyfLeLk6vdmX6VQn+RRJk28mLomAG8/ZbskbcG4VWGs/XM
         pNg4E1TjjzNOCXDtvOTOnu28DIpdxGbqTqFzi5qpg1vzljHG74MJkyGoWssdFgEWi3ty
         G+GvvkUNLF8VeoNRnAovT+PfmhaGCOybibIb1ZCzJho6ttGHXKrl0d8Y8J9JrN0+LciG
         JxtA==
X-Forwarded-Encrypted: i=1; AJvYcCUt7uhpwAwMUSbZptZFZKEhkfrdeYF3yP3m8WqbpzEmKjpmp7L4yGWmblv3mnFTOMW98cvT5nHWOX7BQtzOzFNexwgjnw==@vger.kernel.org, AJvYcCWeUUOByZEXRDD1TUE4aqncOX/dxGXnlwBiZvXCuYItB08SOthhcufYC8uFe92oO3/LH3lD45iTUdLBmiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6VKxaFimWpL0/NqXOrGfrU2CFTxj4/jkr2O27u/WsIHcRaoem
	uoT4SpfbSiRZg8+Sk0LijcvcDkyqxOwzjdJsOr66E751c86Ty2a7RQikI4qi
X-Google-Smtp-Source: AGHT+IHibgcahLPA7a8tFKlvj5+G20WvzV7fHlR4IR8gRLzfKbXNqt90qxtcuvUSU4de0EHe6DRj3A==
X-Received: by 2002:a05:6a21:e86:b0:1d7:e62:ea94 with SMTP id adf61e73a8af0-1d8bc85d4e3mr6735703637.14.1728698543645;
        Fri, 11 Oct 2024 19:02:23 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f5104sm3309373b3a.61.2024.10.11.19.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 19:02:22 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 2/4] alienware-wmi: alienware_wmax_command() is now input size agnostic
Date: Fri, 11 Oct 2024 23:01:51 -0300
Message-ID: <20241012020149.19700-3-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241012015849.19036-3-kuurtb@gmail.com>
References: <20241012015849.19036-3-kuurtb@gmail.com>
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


