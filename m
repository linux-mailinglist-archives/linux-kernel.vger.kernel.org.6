Return-Path: <linux-kernel+bounces-563183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A43A637F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFC316D476
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223C21E1DF0;
	Sun, 16 Mar 2025 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="VyyyRA5d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bdiNXqVm"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910841DDC1A;
	Sun, 16 Mar 2025 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742166468; cv=none; b=UNe0s5wupUhUOeQXTbnbzHrIrltn/1EAAoYikTpfl77BftSNptEYoo1F8udG8COar+p9Qk8J4LupPwsWp650866xtRU+V7TaLq+kIhiIu982NW3kOuwaDX1GHvrOsFRw03ZRsf7QnQjBPQ+0ZzSPtiS6Dhx0wpq1+VXGtbIz/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742166468; c=relaxed/simple;
	bh=46WnLkXBCC8Q4qk/P/AsPz+rSo/E7tQn0RARj7ZttOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlhTY3Ua35z0m7qSrLENo/ZDS5rsE8xexV6+p/IzgDcz3fF1CcosAe+ZH44xTRlKdQqeT0ty0/eFjZFq9ys6jWoPbvJ1I6oEaTX8gxwO2FZBgtd12XdI2JjFcHHoSuBpNj0B5gto86ulsjBVlNO2NHM3GMlriPxRGhJ373/gI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=VyyyRA5d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bdiNXqVm; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 6A8CC114012A;
	Sun, 16 Mar 2025 19:07:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 16 Mar 2025 19:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1742166464; x=
	1742252864; bh=vGeBk46c9FNFYWuKCM05ZhwpfTPJVFkWFqmzYRnfcCA=; b=V
	yyyRA5daeHGLFbp31HoFKfugHO0MqjGiNT7N1xII0zgiAi3kn0VrtfA1r9O2D5lT
	qyhTtGqGHBnfU8/fNps0MnmzqRVyoSkccu660jyQsDuvpMh0LDAdTYobci7Rn4lo
	bUufiV0svsp13kgmepPzyrAvb5SIQZubrFqACb4i9cx6afKfcrirSRZB9ztzfBXu
	EOsg1z9AwpCxAlRR+y1IbpMPWAZiKdQy+udvT4U48XoJRQxuYdaWNANbYg37nvp4
	cJy0xnQDa5WBvMC80pMkTG27Dy31PPStx/2vGkylSZT9/7SyHyraJRcrmwTCCzjA
	aCyq512MXMeDJZY/JPOGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742166464; x=1742252864; bh=v
	GeBk46c9FNFYWuKCM05ZhwpfTPJVFkWFqmzYRnfcCA=; b=bdiNXqVmKpmiQAMoG
	xSoT9lCnaH3wL6Ertxkkg54thmhaYSY0Jl+lqR0dSf9CgbYhRq/B0TQ2DBVklv8s
	nVDrG6tmA6+jYUo3dd/NDxD7TkGqNeQIzQUxcE1ahD7MAVfhLV04ifajSQh79F2U
	449rFfZ9zRJlUuSD4fUyoKcSAPbdlvAKY11HKxnjNbd5TO/s7GBkUIvnzNjKpngO
	6ES+r1VATOmVk4rA0SsGEqq16VEZX3U+xpr4yLRoYmGjJeJtk9vxqAJx+qBTL1f0
	chEo6uleKBgmXiSUjO/IkHanH6JVNHNz7ifuH1akzHO8o7DJnpnYYi9XgteZM8x7
	V8PyA==
X-ME-Sender: <xms:wFnXZxKWprM-xt5i2iyqcAwtJnOgFG1DGkpFhs6wuOzj8Yr4XfIBXg>
    <xme:wFnXZ9ItUGW-_OyPCbtntpPRLCEZ5AvlZGjIVxZQiubu0ng9O2NN42CgTEJFjnzL_
    FiEVxAX6mqoqoFpXfI>
X-ME-Received: <xmr:wFnXZ5uGRn0ziNZGv2axH7k3o5OLtqlLWSU1xBpvAUICdnoAG-uP94z3K7sexqtXn4peR_cUa0JXLe3n-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeejkeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:wFnXZyb-vXnUMzAX-065orcy1MTQ3l8MvjQ6xs5tARuPQJsyInptZQ>
    <xmx:wFnXZ4YehwONAsVVlcJ3womcMeE4wdjV_cn051tEnNOFDc5oM9uqAA>
    <xmx:wFnXZ2D_Yr59KLfrKFxsM7GzkPyyPiJv-DYrxnu9ikgRoOPgmmAdxg>
    <xmx:wFnXZ2aNtCDMadBdnsZtGc9ydUdSiFKxz6dq9gb_8Fd69fBkc4DXkw>
    <xmx:wFnXZ3z2w42v45MXjx1HBBZuQbLixibglMGcIi2T6eEDpsLqP_is1P01>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 19:07:41 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v7 3/8] platform/x86: asus-armoury: add panel_hd_mode attribute
Date: Mon, 17 Mar 2025 12:07:19 +1300
Message-ID: <20250316230724.100165-4-luke@ljones.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316230724.100165-1-luke@ljones.dev>
References: <20250316230724.100165-1-luke@ljones.dev>
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
index 46102cd0c00d..449b2605b7e6 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -87,7 +87,8 @@ static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
 
 static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
 {
-	return !strcmp(attr->attr.name, "gpu_mux_mode");
+	return !strcmp(attr->attr.name, "gpu_mux_mode") ||
+	       !strcmp(attr->attr.name, "panel_hd_mode");
 }
 
 static int armoury_wmi_set_devstate(struct kobj_attribute *attr, u32 value, u32 wmi_dev)
@@ -398,6 +399,8 @@ ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_MCU_POWERSAVE,
 		   "Set MCU powersaving mode");
 ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
 		   "Set the panel refresh overdrive");
+ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_HD,
+		   "Set the panel HD mode to UHD<0> or FHD<1>");
 ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
 		   "Show the eGPU connection status");
 
@@ -411,6 +414,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
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
2.48.1


