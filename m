Return-Path: <linux-kernel+bounces-387065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D29B4B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7471F242DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F818206949;
	Tue, 29 Oct 2024 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmZgoUFa"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C15205ADA;
	Tue, 29 Oct 2024 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210013; cv=none; b=jksKfEn8Bz2BSlpqn2wTW/nyFxVa6yHyuixCG6zMOm9m2W1nWw+LG5PPOQETOnyszwo/RfON/LwQ7yEMuVsw2cnIwxXAKupBvPSb2tbKh37pevOlQqKeuR3f+/VemxdRwxy6byAWUIZYKMs9pszuBTFX9CdKqALO7ZjMJSNimjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210013; c=relaxed/simple;
	bh=HckQNaErciVC/XlHXARi0fiJj5Dsyl+vD6K65Pk6HQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9F0j2iHpIuDqBfrD4aXJvCT5KHw2fE/89UqHYBWnCZgdGBaNgYTKm0hHNqgISBfgQNDsW3nJ9WyMdcnsLDYSQWdG7Vnw6hhXxDTDuWtQn39/IJJRnHgYgSNOQIGx2D7VVEq0w+tUHPjIIz0rrIwj1tJhxu5JP+uzIJ2/y4DfPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmZgoUFa; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c9978a221so59169855ad.1;
        Tue, 29 Oct 2024 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730210011; x=1730814811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNSFeD/t/ntM6BOi+/XDHht+2eKkJqLRcDdbGFWTCWI=;
        b=nmZgoUFaiM/1G1qWK9z0Y8h3y80+p9fWRHGy21kI0ff8qEohYoJgEYqPLfPeOnR/Cv
         uoIOGRG8woZSBsjsnfEzwuj2J5xsJuJFiFZPD5o6PXC1L8K8p3I6VFOR7SeX2tiGpESr
         OV4wtWby0TFx9DmLUaq0oXwnD6x2PQR3bV8n0HX2xh9DYRz4+hpGOmO+KIQ4CdVQ212R
         INHC4A6x73H9chi4tbXcbj9DNRwlkqBAgUtQDl5klUt1NetRsRzbdoHwcZx2woVTXrQ5
         xw2cXpDB3r+09AO0mNWM2ETLBL0cI2NQcITjxnvfzatugu60HdpSp14ZYegD3kxlrNyg
         9IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730210011; x=1730814811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNSFeD/t/ntM6BOi+/XDHht+2eKkJqLRcDdbGFWTCWI=;
        b=KQx2l96CdUTWN857UbwktITsJ1L/2FZ4/QpAI4rRKwB57u81Yyy4M+jvQrsktLyLFc
         eXcoQqi4rxg+d60bFzj86fiFzUUXAMVFnj/DUomhWjBeFlN6ftDnfgAKKUAjZdczl5TK
         5y0lDpxGZFa5PUDSUpP0Ec+nt8Xrxd4lcoAXKHM/gnO0eCZPiNNvrSBGtDmUk/eNUutO
         dmXUFYHym+zWkVDfADM9gJTGwT6v38zSKfXFjqlAS7h5HaVs6u3YwPvIZ2ypvD55z/pA
         8nkXgpmENBoyCjdx89JcvDxdPPMy8ar21Sxycj/6PQ15nxbUXDv00E0aWfNYMj7/PWxD
         f5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUwhd/x3oqvALwnt1OJ6Lfq0xY3x+sieJciz/nDcArYqV0YeAl0ZxobUZt1KRG+IIsN5GlZQ3fYGNKLnTRsyxLwlbpF5A==@vger.kernel.org, AJvYcCVF4mJ3i5u/Tflk7tCY3IKeBb88memfc376Uaf/ZUeyfvNT73xVKYGx7mRA8ofRVw919EJ8/tWq6VT9HrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0W4T8lRHAYQ+L+CE/V9bMJ7pbyT3BuayMBBr5qzQkCwxbATDk
	Sctdv1jmlYRyPg1DcqTeCIfGzTH/DTHUIY68gUVwpmDaacp+dJNd
X-Google-Smtp-Source: AGHT+IGTX1wj4tbpByyeAoE4mMxqeSV6U2+BIIIxQBvdmJukbrkZE0M8n8MHqZOrZx5l6XH9WNDKbQ==
X-Received: by 2002:a17:90a:38a3:b0:2e9:20d8:4147 with SMTP id 98e67ed59e1d1-2e920d84387mr2624618a91.33.1730210010811;
        Tue, 29 Oct 2024 06:53:30 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e36a2706sm9374114a91.28.2024.10.29.06.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:53:30 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v10 2/5] alienware-wmi: alienware_wmax_command() is now input size agnostic
Date: Tue, 29 Oct 2024 10:53:24 -0300
Message-ID: <20241029135325.5875-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029135107.5582-2-kuurtb@gmail.com>
References: <20241029135107.5582-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

alienware_wmax_command() now takes void * and size_t instead of struct
wmax_basic_args to extend support to new WMAX methods. Also int *out_data
was changed to u32 *out_data, because new interface specifies u32 as output
parameter and all previous callers would pass u32 * regardless.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v10:
 - Unchanged
v9:
 - Unchanged
v8:
 - Unchanged
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


