Return-Path: <linux-kernel+bounces-251399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED3B930469
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F77F1C22ECD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B42856477;
	Sat, 13 Jul 2024 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="kc0mpBhd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bsRddw7N"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9656E49649;
	Sat, 13 Jul 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720857602; cv=none; b=DGGmS8cUso9HcgJFt6cRFHcuXtI5NxZ6SDKW2YK+B4ChjmewCz2fcUzfghNTCUFqSBFF+9Qo9PjkcoxJKUE8VkHKaIOIv8M28S8Pfv+IhwmzFH3LSBNj/hmunb/m2ZC7p8KNIyjOnqJAqK6lR51LHrniCoIDsrt9fk5flhzAYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720857602; c=relaxed/simple;
	bh=A+UHp366gIVa2FazCrxKWQvKpSLLcVwnaGhWXwZGtFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsUSrnnCaHnjU4DMNQBMxsvIJqRAR4ySFG6zZhuEFVZbg38e2I7wCLDZSt0BqkBVt0QMkbCM1xBpRSZTEy3vjSiTOqFnyNzy8+HuJRw3GWIVjQVd/aNPhMEJnAAYw5uCX56Q/FttwZMtCSjeK3HT2j1PIwQNsfFi9KGBZ0pxtlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=kc0mpBhd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bsRddw7N; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8FE4B138882F;
	Sat, 13 Jul 2024 03:59:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 13 Jul 2024 03:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1720857599; x=
	1720943999; bh=6wVqcF+sq6nvP8sf0sSl8W+Zi+HYxu3wkUISmp2SegA=; b=k
	c0mpBhddanoFMwvoyLEPzUHC32U1l55zdypLjFRmdwj4/kXLGhADTcmPlGEInIXN
	gyIgKjJlSszeOqkpB/m6jkY4/SncjNvL/hegWKyZD3uX7hSThpteEAKqzpjxCMOx
	bCHz6GZlhN0n+l4HaOYtXPxsxIRx4vFDF9gOgkmgzmqiyzDZTBkJVLEPDr+nav9O
	a0Moe2i3qfmb23ZO9RTqvVPsKzSJ3yjlNU/DN+B4yvw0TMhiOXqNvcjqCJD8wE7n
	K9KtH3IwEQ2BJddnRfEOvxSjrS4qPUYdzZCnPDU7IIDlp7aSEzVN9Xk+8pM2VYuX
	6ZwwXGdCOf+5X9oSN10ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720857599; x=
	1720943999; bh=6wVqcF+sq6nvP8sf0sSl8W+Zi+HYxu3wkUISmp2SegA=; b=b
	sRddw7NprbZNoGhfIS1AgDdWLup+cg0IynCXDulroMqmC/dN/VwgpA5LdrcFMjBR
	YMAx8pjMrJeGJhQuhsFS+tX69+I9k4hf219sg9a8jMLCCldg0NVcRQGl1X22GClZ
	Y3ROKZ/Bkv1gA7DG210bZv5PsvM3txV/aO/EV9KzlMpr16yxFD9c2LubWtOkFk89
	H8LGxu5JqgVujIuRNyDNLh1CJgq6yXQ1VSQ9PkEoGtEJiOZK+44cPxoMfhYhhMgT
	5u2lC/zWb5sJ64sXAFzpZnBK4Wx0CBh4cF075dIFGgrdrkFYos5ReLUoTPk9ErFE
	grfankpn45sg/bVDtwGnQ==
X-ME-Sender: <xms:_jOSZpimJqmVh6vaG_OjXRgNpv-4trIEWWrcLo1MoN8G8SoOGuLoJQ>
    <xme:_jOSZuCaN2vNX0i6e7EmliMqKN9vQdgG_8VQfv_GG6lH46qX7Z-Z8m4L3284PYGz1
    FysKKJyMWvU00__ybU>
X-ME-Received: <xmr:_jOSZpGJspl5vWcgr-XHw1tDRdmMgoH54W85Abaejuz_bmsxvjdPB2r7199q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeejgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:_jOSZuRELK2jhbEt2AlsopoNL94cwoJMkFHejJy2XLOsvEF2-BEdgQ>
    <xmx:_jOSZmzxMfheNs1i6VcBU9GtQkfjTHhCoWnTvs6ljmo-ZkwenZ-gSQ>
    <xmx:_jOSZk5voUTGBKg4VbykfrPyylPUr8Chy5hCgUZiXZKmvmzre3_uDw>
    <xmx:_jOSZrwJQvXsboEAz9-3bc7ZAXN7TaEfO5a3AGEq3ZicSTs8APwzng>
    <xmx:_zOSZtrg6QjuGKTXnGBDJ8Sq1gXr3Di8510VGujoxm-LbTiJjix4YJeV>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Jul 2024 03:59:55 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/2] platform/x86: asus-wmi: don't fail if platform_profile already registered
Date: Sat, 13 Jul 2024 19:59:40 +1200
Message-ID: <20240713075940.80073-3-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713075940.80073-1-luke@ljones.dev>
References: <20240713075940.80073-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some newer laptops it appears that an AMD driver can register a
platform_profile handler. If this happens then the asus_wmi driver would
error with -EEXIST when trying to register its own handler leaving the
user with a possibly unusable system - this is especially true for
laptops with an MCU that emit a stream of HID packets, some of which can
be misinterpreted as shutdown signals.

We can safely continue loading the driver instead of bombing out.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 4c129881ce28..7d87ff68f418 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3836,8 +3836,13 @@ static int platform_profile_setup(struct asus_wmi *asus)
 		asus->platform_profile_handler.choices);
 
 	err = platform_profile_register(&asus->platform_profile_handler);
-	if (err)
+	if (err == -EEXIST) {
+		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
+		return 0;
+	} else if (err) {
+		pr_err("%s, failed at platform_profile_register: %d\n", __func__, err);
 		return err;
+	}
 
 	asus->platform_profile_support = true;
 	return 0;
@@ -4713,7 +4718,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 		throttle_thermal_policy_set_default(asus);
 
 	err = platform_profile_setup(asus);
-	if (err)
+	if (err && err != -EEXIST)
 		goto fail_platform_profile_setup;
 
 	err = asus_wmi_sysfs_init(asus->platform_device);
-- 
2.45.2


