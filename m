Return-Path: <linux-kernel+bounces-432439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571119E4B45
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A92167454
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDA0F513;
	Thu,  5 Dec 2024 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfrKmPVY"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1D210E9;
	Thu,  5 Dec 2024 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359143; cv=none; b=cfhvmL/K3pbLhDQNYWtB8MLj22PKwJpics1EBWsbZvBfye6FSIk36TibXaSOI9ISbgINxd0f0hWJ7YMy2WsNWmJWLq2gVvG2U0P8u50ZWHGExX0S4cFNTLEJWYT0Rzs9EaMy2+HI9AtQ/kWQiQx+0OxepS8ZtGgINDITcBnPgiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359143; c=relaxed/simple;
	bh=I5yT5GXn4XWD061Xb2RH/thnz8ewCQmNGoquSyoEgk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGA3cGhZERBy0ioeUxY02YVg18iMyWCzpZkPn28A1L2saTsxtaAlDzjQJmuLYklO2Tq4+zM5qNRJ1BayhFDASxYCadP1B6cFOxB22BUVcpWIzRRVE0gRfUjpSZ1+MORqRqkXmU53O6h4FSIrFXEYpjNIC/f+EEPsfK+9ttStFis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfrKmPVY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215936688aeso2809455ad.1;
        Wed, 04 Dec 2024 16:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359141; x=1733963941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5r0gHAwegXuzSmSEhFIyVewwYq6F+Oy8I87chR6WA6Q=;
        b=bfrKmPVYq/F77lDEMfTct9lswd8t8+uosWkF8etawTu4LAm9GLRZwXQiBShA1p605h
         NxcKZQ7s4rm1rlizDHnqhnMi0HH7dzy+6UdFWFFXzKQ++rTbMRFtNvySsvNnICJHgsnJ
         QGgPD6npB9WnHl5L+Qo/J4e5oPZxhQygSzhsRevmPiMwjotDuQ4vNZrn2vy+0xZdn967
         G59LdJiSsqrezQE+9VkAbkSscq4DEPMtSGOmqgzpZBCyqINc+AoCh64ynvud8xj3YTcr
         Oqb1MvovyvPQtlQKay/YQ6PpwmbtvkZ8NffSgnupfmS5qLSRqRbqSysmGkOQ5WjTkXCL
         o9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359141; x=1733963941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5r0gHAwegXuzSmSEhFIyVewwYq6F+Oy8I87chR6WA6Q=;
        b=WtnpqYKCQCmFuhma68DiP5WPdPUCMiBIcqL/eKoKrN5rTH5EgUbObZ/OToZHX+TUb2
         9vTXYloi/JFYMQkxxCsL0uGfVtTlGg1dTcE/Fs56/4f7MPad4/RT06nJuzFeBSOmezRM
         GlgyzHGDZMuCEZxZQITxXwcMX1MVKZFbHnfNVjYnZ0G1SJCvplIyVltUaps0CzV6NPiE
         SK/Hno0RvdSjXN6U0N3SCx0tfzJZ9/6/2LjfFhgymzO7qLCBaiHvOqx7gQfxkM7JAjyc
         pjjhhy6NRIGq1wa8hbmxgF/DadNbh2ROB1NxFZiH4YDsKqjjTbrd5UP/OtEWVwJ03KSf
         6kJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVuu6DU69z3l0FM/0UzpFeGlLNKoGEDSEa2f+hmxgbxt15zxX2YyF1/s6qwOGnY9TJB/d8wl6so5oTlxI=@vger.kernel.org, AJvYcCVPvXs1QyPyArvRFV7kwogmT1aV5lsTh8Edihy8sfwji1kwxSy6GMs99kAfe7LxpcMCWSV92iZDxqzEwlQUiUb1sqpmLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyedEejDo/o82P/o9gnvMeUYoSY7c4HEz9lbNMgyrHtFAtT52t8
	UN9ekhdAbZsT0i7CYQhddBZGXOQaCYr5nyYiye8oFShDtIV9zlFY
X-Gm-Gg: ASbGncsM+OQn4BDeN8Nlt5vYl3UPkKuvPCCTbIREp+lmcU/3bLLe374/2T3fWxh79DA
	eXerSh0cMsN/aOhzYYKhtF8gnuiTOmgRtApyp/lrNL66j1gAdUuA6JhBNrKihdaGtHZ+93HBO36
	JMHp1wAJKCUvg+SX7p753zuE7BqD9j/qz+BhoQg11ZuvkiFsw+jnFtUvQQGJmSBZkSUxeVo+aal
	Ejt0NrmLC6Si/WYpT9Iy3ERAlEH1QOJlWywivJBDNBrXgCEranGiEe9REGgQ7LTPqlyVv9v8Miv
	tMLriLzjmD2sBstSVsE=
X-Google-Smtp-Source: AGHT+IE2Z+B1Krso6luH/4yPviboZj8IyJo+B/qcwzXb5cbk6ZRxRibM3UAtpOStFwEEtdmotg2skw==
X-Received: by 2002:a17:903:188:b0:215:b9a7:5274 with SMTP id d9443c01a7336-215d0050befmr100072295ad.26.1733359141346;
        Wed, 04 Dec 2024 16:39:01 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f68c2asm1265395ad.283.2024.12.04.16.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:39:01 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 02/21] alienware-wmi: Move Lighting Control State
Date: Wed,  4 Dec 2024 21:38:36 -0300
Message-ID: <20241205003835.2184510-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205002733.2183537-3-kuurtb@gmail.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Place Lighting Control State logic next to other attributes of the same
sysfs group.

While at it, rename:

store_control_state()	-> lighting_control_state_store()
show_control_state()	-> lighting_control_state_show()

And use DEVICE_ATTR_RW() instead of DEVICE_ATTR().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 73 ++++++++++++-----------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index b3a73fc43b3c..b1ac0e393180 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -545,6 +545,44 @@ static ssize_t zone_set(struct device *dev, struct device_attribute *attr,
 	return ret ? ret : count;
 }
 
+/*
+ * Lighting control state device attribute (Global)
+ */
+static ssize_t lighting_control_state_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	if (lighting_control_state == LEGACY_BOOTING)
+		return sysfs_emit(buf, "[booting] running suspend\n");
+	else if (lighting_control_state == LEGACY_SUSPEND)
+		return sysfs_emit(buf, "booting running [suspend]\n");
+	return sysfs_emit(buf, "booting [running] suspend\n");
+}
+
+static ssize_t lighting_control_state_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	u8 val;
+
+	if (strcmp(buf, "booting\n") == 0)
+		val = LEGACY_BOOTING;
+	else if (strcmp(buf, "suspend\n") == 0)
+		val = LEGACY_SUSPEND;
+	else if (interface == LEGACY)
+		val = LEGACY_RUNNING;
+	else
+		val = WMAX_RUNNING;
+
+	lighting_control_state = val;
+	pr_debug("alienware-wmi: updated control state to %d\n",
+		 lighting_control_state);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(lighting_control_state);
+
 /*
  * LED Brightness (Global)
  */
@@ -589,41 +627,6 @@ static struct led_classdev global_led = {
 	.name = "alienware::global_brightness",
 };
 
-/*
- * Lighting control state device attribute (Global)
- */
-static ssize_t show_control_state(struct device *dev,
-				  struct device_attribute *attr, char *buf)
-{
-	if (lighting_control_state == LEGACY_BOOTING)
-		return sysfs_emit(buf, "[booting] running suspend\n");
-	else if (lighting_control_state == LEGACY_SUSPEND)
-		return sysfs_emit(buf, "booting running [suspend]\n");
-	return sysfs_emit(buf, "booting [running] suspend\n");
-}
-
-static ssize_t store_control_state(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
-{
-	long unsigned int val;
-	if (strcmp(buf, "booting\n") == 0)
-		val = LEGACY_BOOTING;
-	else if (strcmp(buf, "suspend\n") == 0)
-		val = LEGACY_SUSPEND;
-	else if (interface == LEGACY)
-		val = LEGACY_RUNNING;
-	else
-		val = WMAX_RUNNING;
-	lighting_control_state = val;
-	pr_debug("alienware-wmi: updated control state to %d\n",
-		 lighting_control_state);
-	return count;
-}
-
-static DEVICE_ATTR(lighting_control_state, 0644, show_control_state,
-		   store_control_state);
-
 static int alienware_zone_init(struct platform_device *dev)
 {
 	u8 zone;
-- 
2.47.1


