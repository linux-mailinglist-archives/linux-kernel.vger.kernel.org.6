Return-Path: <linux-kernel+bounces-530178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CE2A4302E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3338188F293
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB04B206F22;
	Mon, 24 Feb 2025 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="iZ+fg2Aj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="joav2SEH"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC31F5FA;
	Mon, 24 Feb 2025 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436563; cv=none; b=u0N/JO78+QcqDWS2lrezcYHfb89S4xKuAl5yTLz2Flbr4lxjqLj2v3sRMxHVdshDlqhv8WYccHAAnulbQb8hSdS8m5ORLy64fzQsfP09r9n3FjcEEuO+2QCpLpccQ3lG+ZaDhA60sA4VEOkqrOLV3H/xu4/4h2mXZ8DIHOYEg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436563; c=relaxed/simple;
	bh=uA12i/Y9y+ltc6V9FdPhiBKqqi6WpuVhtuvjX3HFukc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dscLARxSQiqO0NLHXZAbH2ChPj10Ao4bWW65BOfGt1yUMzTtn5d4Q3//WqH7l2nH5UmKJdg2saM6ZdCnKYgnRhjBjvsG4U0Gr83Ez8wQ6MqGQ7qkuZmPbVHG7e5QbeCsUIfMQvIV8+yz3hVq1EnOZS1eqv7VU2CRaEcf1sxbZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=iZ+fg2Aj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=joav2SEH; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5342A2540182;
	Mon, 24 Feb 2025 17:35:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 24 Feb 2025 17:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1740436559; x=1740522959; bh=ioYEDzHrpz0PAuDFVSS3W
	+YD7T3n3gFKuDOGtGLUsQQ=; b=iZ+fg2AjQ3FOoPNkSvuUQCk/mP9yU4rDfH1hb
	G3B5aSQyVewHeRur0H1tc1Us+wtZ+aa5MvAKZAS+wAl8eP7m4YdxNc7rE+WSG//S
	Ns5Bs9Y5ELquyG2z3TAqSJU3FQtm8frHFqNqDG5AnFVkkOovDcGDUdpXWeEURiz2
	hhb0cIHVfnIhBxBWmDq5EZNanK+LCFIx/i9+Z91fpb9M5uQp892UHtAvjh3ZzOip
	Qm4htfPFnORjjLGJ5o67SQVlBtf3rpd0EvcfaNt3L57OPCQxOSXj0iu0rBNAf4m8
	XklSdvNPVx5MK/sU3wBHqgRi1SHJ9PwtfCf/gse4P1IicoucA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740436559; x=1740522959; bh=ioYEDzHrpz0PAuDFVSS3W+YD7T3n3gFKuDO
	GtGLUsQQ=; b=joav2SEHePT0qIcvmqDPkn8ZHS6FunH9Pp5jkiM3re+hyJfEEgw
	XQbtgBu8hGUzHiZJwvFaL62CUe2R3s7L4TneJu4yfqJDASdpg3hJaCNenVWuaDOB
	tXLqlQGnu9QKtm4qBCqSOFTOfsAj2StCV+Ki8KgXSkeb1yU0MAFDo7LozWZAumjv
	0PvZaJz+R/5bE7UIFoIlyM8CGLTLSBj6rUA6xFDqLIDBeaHTYQWS/udg6h+AaegT
	wGxV+T3xvrti8VJSn0IDd4KSsX2aUeTgYYWCduOx5Eg3hHHUCVpa6vAgYefGRV1G
	eWtZY5hJvJ0VFT5LphLvTLC1BJW6IznUmLQ==
X-ME-Sender: <xms:TvS8Zw8KimUFpwdQkHzRiUQZqoYdeahDoph_q3PO14_Wzpgufr9dKw>
    <xme:TvS8Z4vemdDX6rekZkhsVpaslhTXv-8I0KMukScX3jWdJmmoPwEjjgQH7ifd0uBQJ
    cs2Zni1Eqt0RpToWy8>
X-ME-Received: <xmr:TvS8Z2D7-LihsYbK-ahqhkwuYoK_KSy8OHZn6DXlBoYCAIezqKAQPtVSK9KIX4MQleXUlO69s3kUFdVrWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenuc
    ggtffrrghtthgvrhhnpedtkedtiedtteeuheeuteetffffgefgfefhiedtvdegieefjeeh
    leehffejgffgheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehplhgrthhfohhrmhdqughrihhvvghrqdigke
    eisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgvnhhtihhnrdgt
    hhgrrhihsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhh
    grthdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhi
    nhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:TvS8Zwe0PrWefyxNwOQHSPI0Xaaa0yuznjEQR-siSw8ubujlmlCO7w>
    <xmx:TvS8Z1O1KMbZirPVZVhHhoJ4gO65wZv7CuAZ2CqDYRDtlXO2M7zfUw>
    <xmx:TvS8Z6liqJWBATWNVLCMPFgXgyGJ_0nb4AF3O1VcmF9FoF3QABhvlQ>
    <xmx:TvS8Z3tpv_X1ftLn5aGfFhRcHRR_DhNm-cGaLZ7SmPoAXxUZs5LtUQ>
    <xmx:T_S8Z42WZYbifSfgvOtKYTm_hwyh7AD3GGnCvjQiO5w_gdTbpuLifFib>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 17:35:56 -0500 (EST)
From: Luke Jones <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: change quiet to low-power
Date: Tue, 25 Feb 2025 11:35:51 +1300
Message-ID: <20250224223551.16918-1-luke@ljones.dev>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Luke D. Jones" <luke@ljones.dev>

Change the profile name "quiet" to "low-power" to match the AMD name. The
primary reason for this is to match AMD naming for platform_profiles and
allow both to match. It does not affect Intel machines.

The quiet profile is essentially a low-power profile which tweaks
both TDP and fans - this applies to 80+ ASUS laptops.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index d22748f1e154..de19c3b3d8fb 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3945,7 +3945,7 @@ static int asus_wmi_platform_profile_get(struct device *dev,
 		*profile = PLATFORM_PROFILE_PERFORMANCE;
 		break;
 	case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
-		*profile = PLATFORM_PROFILE_QUIET;
+		*profile = PLATFORM_PROFILE_LOW_POWER;
 		break;
 	default:
 		return -EINVAL;
@@ -3969,7 +3969,7 @@ static int asus_wmi_platform_profile_set(struct device *dev,
 	case PLATFORM_PROFILE_BALANCED:
 		tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
 		break;
-	case PLATFORM_PROFILE_QUIET:
+	case PLATFORM_PROFILE_LOW_POWER:
 		tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
 		break;
 	default:
@@ -3982,7 +3982,7 @@ static int asus_wmi_platform_profile_set(struct device *dev,
 
 static int asus_wmi_platform_profile_probe(void *drvdata, unsigned long *choices)
 {
-	set_bit(PLATFORM_PROFILE_QUIET, choices);
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
 	set_bit(PLATFORM_PROFILE_BALANCED, choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 
-- 
2.48.1


