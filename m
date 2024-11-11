Return-Path: <linux-kernel+bounces-404557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A60FB9C4511
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D66A1F25A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B551AAE24;
	Mon, 11 Nov 2024 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFNbg1tL"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19601AAE13;
	Mon, 11 Nov 2024 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350191; cv=none; b=Y0MKG3VnCM9FS9FJj9CKRCpyGK6Jscpr2oC2TJ/1oxARChtxuvY2RRlMwlBrDxLNJ7cRX1nvJOA6s/k3knBVl26Q85cJCOiNmrHVM/v1X9sfufAyCa4Nd4Bp+9sQ91+Db1qNRQloTO6xysewNf4xY4AYBqeBfFeDTeVLZQGVSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350191; c=relaxed/simple;
	bh=npFH5UHaCbdQUl4s0bE97PA9ZIxx3/oEitT9i+OrTQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmwqv3UZbudt2bO5kxitSVn8EQVUeqCEOZNBhJpTYmUhFlC1krHDj8DKF9vj4TgpHeUnXTL/rTTK6I0N/2get1KqxNbQCBrRsLlF9C3C+6SJXhlelIOaC2IFLMLZCeRGExfCp3wdw0RU3L/lZb2OYk1BQwmoh0l9yv7+1BCuCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFNbg1tL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca1b6a80aso51533165ad.2;
        Mon, 11 Nov 2024 10:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731350189; x=1731954989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH6jhSkN/16Cl04BKJOtxSm6lU3/J3emxmBivgKISP4=;
        b=QFNbg1tLlZnEz61vYwI6NNza2IpQslVdr5UBft8LlI2LmfzscvI9t5O9Sn6lI4IjR7
         0Z6YbaFV0PvxVmphZ7ppuY09sFzGcs02/uRbindELnBxU6gaiQqxp8uPTGcER3xEozeM
         awyQjc2wnl58rvtEp0A7v0yK3OWZoVKf7Qsq18Bd/BRjfBxeOlijPOM1ll8RqAzFa8oS
         4E+6WjcYreziV047VIQcEAi9zfLGoNrkCW6Ow2QUT/0mGOlcRkodINj0XgOWt8pgdqL+
         WhtN7WQv5lXe94DNCWiMA8mU3NU4gG8+FIfLys/lVtDaUF51JjQcjA7017hLdWydt4BJ
         J2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731350189; x=1731954989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HH6jhSkN/16Cl04BKJOtxSm6lU3/J3emxmBivgKISP4=;
        b=NYOeAgKRstNjcP8ohTypzzVlKmm/tcJBFW9VH3ICh0n6u0gkemS/TCYHq+EMGOgABV
         0jbjPAK3KumZ/3klJDX3vuvqgoKqTC4/L4vaW6M5nDCInFGvWyG4saq+AkY+T1MbiV4+
         akTKMWM+0m44mWRAwCfT1SOOJ5efMxrBZQ39UDy341IX7Tba9nsQiWeS4MSz8nw24Gte
         e4Ihwinsu6nD4dF/OfdDoDUCBFplt/ESJivu52Eg6s8PoX0IkwD6Z49M3UqtaJpm6YPA
         vKtR2cEZIGVKIXgvCNeHeng/vulBqWwWef5awRepQa1P+0BwdTH7ZRf3aAG8hDTYeDkQ
         lpfw==
X-Forwarded-Encrypted: i=1; AJvYcCVFNVGO5BZB7MU08I1Y/bLz1pNJWZGUq2VX0UHCiw+kFQyJNeb3S7aaNKixQVvC9WqOVwIgKsEbtPbX3cM=@vger.kernel.org, AJvYcCXQ67OQmIcAngTjmlRs1hELSL4krhkrmWlWx/q+7lAUgRfyWDAwAERkb7f2VvmWt4y2X2RHLEZwm/PbZq4/Jm90EJK9uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMmicjmuXOdvt9wkTPIi3OPFnbSdTmbf79Aca4nHnwFT9tadif
	4Hm6r7hybWNqQsQpZN/tXmO1ibli+4WqJAAJ2Gdwzr7wIB4otXGjszpa1YRW
X-Google-Smtp-Source: AGHT+IHcD9h4VAWGyFcZAZfLvrUFYyvbbkvRN7M10hgNdrzal9lhpFdUsKJkwuhabdt8p+CSwwp5Ww==
X-Received: by 2002:a17:902:eccf:b0:20c:e2ff:4a2e with SMTP id d9443c01a7336-21183d7cf32mr212791995ad.53.1731350189029;
        Mon, 11 Nov 2024 10:36:29 -0800 (PST)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde262sm79156765ad.68.2024.11.11.10.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:36:28 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: ilpo.jarvinen@linux.intel.com,
	w_armin@gmx.de,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH 4/5] alienware-wmi: create_thermal_profile no longer brute-forces IDs
Date: Mon, 11 Nov 2024 15:36:23 -0300
Message-ID: <20241111183623.14691-1-kuurtb@gmail.com>
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

WMAX_METHOD_THERMAL_INFORMATION has a *system description* operation
that outputs a buffer with the following structure:

out[0] -> Number of fans
out[1] -> Number of sensors
out[2] -> 0x00
out[3] -> Number of thermal modes

This is now used by create_thermal_profile to retrieve available thermal
codes instead of brute-forcing every ID.

Tested on an Alienware x15 R1. Verified by checking ACPI tables of
supported models.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 36d182f217e2..77465ed9b449 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -68,6 +68,7 @@ enum WMAX_CONTROL_STATES {
 };
 
 enum WMAX_THERMAL_INFORMATION_OPERATIONS {
+	WMAX_OPERATION_SYS_DESCRIPTION		= 0x02,
 	WMAX_OPERATION_LIST_IDS			= 0x03,
 	WMAX_OPERATION_CURRENT_PROFILE		= 0x0B,
 };
@@ -1110,13 +1111,22 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 static int create_thermal_profile(void)
 {
 	u32 out_data;
+	u8 sys_desc[4];
+	u32 first_mode;
 	enum wmax_thermal_mode mode;
 	enum platform_profile_option profile;
 	int ret;
 
-	for (u8 i = 0x2; i <= 0xD; i++) {
+	ret = wmax_thermal_information(WMAX_OPERATION_SYS_DESCRIPTION,
+				       0, (u32 *) &sys_desc);
+	if (ret < 0)
+		return ret;
+
+	first_mode = sys_desc[0] + sys_desc[1];
+
+	for (u32 i = 0; i < sys_desc[3]; i++) {
 		ret = wmax_thermal_information(WMAX_OPERATION_LIST_IDS,
-					       i, &out_data);
+					       i + first_mode, &out_data);
 
 		if (ret == -EIO)
 			return ret;
-- 
2.47.0


