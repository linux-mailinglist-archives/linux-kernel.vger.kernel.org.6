Return-Path: <linux-kernel+bounces-567389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01516A68562
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5463A189A0CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D20524EF89;
	Wed, 19 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="ZQfwHiqo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LK6anj9w"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06C32500AA;
	Wed, 19 Mar 2025 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367536; cv=none; b=IKbl91C/lq+G4G2sIt0tyHNWMDOq1Kv+GjOfBek13C9ngGv/cjdrPhZH7qcWoZlWNe6M/ymYDRo3hkybLnEVOXntFPqGoL5eKZPZBmoPsKbPjLZ8e0S3DYfOkrnQYaFRGu8T1wiCoYTAmystyHBAyqpt7WdeNxVOmhzW6rg6OTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367536; c=relaxed/simple;
	bh=aR2zYvaQXqpxOnyLEiuwxLAn413F0ZcUMOaeSNcsDWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPIOwrl+1WuHbkk0rxjrTXx2/6jykJ8EnvRxTodGzz+T0dxdp1IcqmtJC0yX70Gpw6jAhP0BqhkViME0GmEv7Uk+k9+VhszLSEOCnxj0u4yyHv7STqSA0LChX/HA/aljSm9MjxRYTXlUCXfTbGu7SfRYiENt9BTKs2PaEkUUD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=ZQfwHiqo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LK6anj9w; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5448225401E0;
	Wed, 19 Mar 2025 02:58:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 19 Mar 2025 02:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742367533; x=
	1742453933; bh=abevE0WblE7j91jRDtOReuTE06tVsYogaN7+ZpuJnzE=; b=Z
	QfwHiqoDTDKICiiFRsHih9wjE8nnxQZ20RJytQxse5pJmt+3sdFysygD6evfCVIF
	PksNQ51Zfg6hOVEC89eSRQ7Bz+p2vuNJ/MWqzANkxN0uty5CV41hHV1BgpkEiOlX
	qq4cMLLLxJWmmt9YlXqtB87kd9UHk9ij3rzzEeyu3ujFsXywngZ2I8oegMhMrfL1
	AUHRnjI8C6Fg4ONwYaryrJoAtHsM92RCs5brVWtVCoqIt91qTs9yFR+WvOzKggJk
	qJmqYFj8znxD5KtrXylzD9e5yvd3KKYas8e6KQ6AetTgFhH4Xqwc3+YIgYCwnm95
	o2azF2QxvQxnGXf8nXQLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742367533; x=1742453933; bh=a
	bevE0WblE7j91jRDtOReuTE06tVsYogaN7+ZpuJnzE=; b=LK6anj9wAHCZ4IwfO
	9KgpTS8EBGtIGCkrQqz+wdg1NlTubTqE3B6MLOy4VNPffsws2BEQGK1KuyfC86XN
	RP6z3FjClBNtUAoQL7Zwqn7NbL8d7J9ChIFOQS7KMlbjrMhjG5a6GON1ma2Tw7OS
	Vvq/tne+jFusP0rp+hg5ts6KGD7Zn69z8hfbGapXQRsACmBfnrroJi2Ra3gMCoLV
	7tQg/tk4VfvhRBouSLyfMWRHFxuZ6MmmZCOiWlCYaAfGmRmabr1cm5Gbt3CfuHKx
	0E/XqdLvifvzdOaomJoHPTX9Uv4wpBsZJjfEE0OMUjidHBE1lssHELVdcdBUeRDG
	1NuHg==
X-ME-Sender: <xms:LWvaZ3rqUnCoSOmxN4_w5NObYcD_85xFxMcJrLHg61rU5cpGD8wqDw>
    <xme:LWvaZxqOZY7-_5yZuoF_v9KV-1Q870oVbRoVit4DmaDyAPnUgvJalRCSxdTHSrkrb
    QQFuSPWP8j9wdm-96Y>
X-ME-Received: <xmr:LWvaZ0M1QWI9cVDpp9SiF0yVt3Zc5ucr6_aRjULD_JwqLO4NVVUvHEwPaWmuJV-Pwjjzo08MPff3JPXf9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvh
    eqnecuggftrfgrthhtvghrnhepueeuleeffeeihfelhffhheelfeffgeetuefhheevkeet
    uedugfetfeetlefhieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinh
    htvghlrdgtohhmpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekiees
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntg
    hivghllhhosegrmhgurdgtohhmpdhrtghpthhtoheplhhukhgvsehljhhonhgvshdruggv
    vh
X-ME-Proxy: <xmx:LWvaZ65LReS3T5xx3eKsQZDHglul2o7GX93vTjJNK58C617BPIpnMQ>
    <xmx:LWvaZ25RK1hZ3OwfDmfSWqCeB6UTY6c_gYG5a69aIxixFfznqsnKlw>
    <xmx:LWvaZygc6WuBQA2kGVZECNieEdgOR7OWAXYWu1yrSc7KSflRcT8FEQ>
    <xmx:LWvaZ45-CnmPorK9NeGnxMWMzh9k205V9gWBLu3_luG7YHfcadyySg>
    <xmx:LWvaZ4RNaJbNwRSMYAHm6uqf_RJn-kKZrfqN6xHhLzCpLu33tYO8k6Iu>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 02:58:49 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v8 3/8] platform/x86: asus-armoury: add panel_hd_mode attribute
Date: Wed, 19 Mar 2025 19:58:22 +1300
Message-ID: <20250319065827.53478-4-luke@ljones.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319065827.53478-1-luke@ljones.dev>
References: <20250319065827.53478-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Luke D. Jones" <luke@ljones.dev>

Add panel_hd_mode to toggle the panel mode between single and high
definition modes.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/asus-armoury.c        | 6 +++++-
 include/linux/platform_data/x86/asus-wmi.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index 12acd851e6b2..a299471d78d5 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -86,7 +86,8 @@ static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
 
 static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
 {
-	return !strcmp(attr->attr.name, "gpu_mux_mode");
+	return !strcmp(attr->attr.name, "gpu_mux_mode") ||
+	       !strcmp(attr->attr.name, "panel_hd_mode");
 }
 
 static int armoury_wmi_set_devstate(struct kobj_attribute *attr, u32 value, u32 wmi_dev)
@@ -397,6 +398,8 @@ ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_MCU_POWERSAVE,
 		   "Set MCU powersaving mode");
 ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
 		   "Set the panel refresh overdrive");
+ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_HD,
+		   "Set the panel HD mode to UHD<0> or FHD<1>");
 ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
 		   "Show the eGPU connection status");
 
@@ -410,6 +413,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
 	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
 	{ &panel_od_attr_group, ASUS_WMI_DEVID_PANEL_OD },
+	{ &panel_hd_mode_attr_group, ASUS_WMI_DEVID_PANEL_HD },
 };
 
 static int asus_fw_attr_add(void)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 4574e30c53fc..62a9adb1af2f 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -76,6 +76,7 @@
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
 
 /* Misc */
+#define ASUS_WMI_DEVID_PANEL_HD		0x0005001C
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
 #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
-- 
2.49.0


