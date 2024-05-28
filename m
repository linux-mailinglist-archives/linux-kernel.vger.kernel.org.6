Return-Path: <linux-kernel+bounces-191620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6DA8D1184
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B15B22AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2858405F8;
	Tue, 28 May 2024 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="CMOEec67";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JD2WTgaR"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8523AC16;
	Tue, 28 May 2024 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860226; cv=none; b=cS7TcyBfbeks+IPMDU1X9XySIJz/OAiPbpB/169chOkaPobsXrqHE0ooKzHRUlJLe7eeWtee+V0xr5nW6kgPnLul6EBdMTOSFE2EzWR3pSRu/B5Kd2U+Lmma+uwinjChzi2dM0AFohKkfu2NniZjbAVeCsx3q5QDvFTk5y/T/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860226; c=relaxed/simple;
	bh=aIav+5EECdqbJcYjdH5A+4TUj/fYjbell3xkt46zAls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWsHyv9FKLhz7CsmbNXTZaWd6KgKtHCCQnrqKw3IkgW3enhE2UtaAXE80b4FF0RgZ3x11KMN6WVS6lIy9b5pi0AslK46COI+AK5tSgBUkZL3JSbK4MD4YoaJlHZincG6wodxnJH+lzYUhCI6PuSISB10lYHpWkOLV4xVGvbG5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=CMOEec67; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JD2WTgaR; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8F0B51380142;
	Mon, 27 May 2024 21:37:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 27 May 2024 21:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1716860224; x=
	1716946624; bh=oUbMKxb/AnzUhw3GvwikoRj656Q1cIKAuZQGKv+i05A=; b=C
	MOEec67Cywe9myr1q0v3AhliuPSqC3/HcbZzcCBthK/vUxcUPZKn1HxPv134QkyB
	U2uCoaV4CXFo0sqUWsvIHRFvecsCrLncBjbtzDRUZDs6xr8u0EiGIovja1Or6RIl
	U6UjLHlpDkM2WmmS0f7yITJaIDzrFRWeo9ssiP2zEfb6YuaZKM4rZkDSiOKx0fbA
	G+B0Ff2gllI8coFUEOPcX4VlYcGu9f+dpyU+5arXyqmev4z/dBrqR9ITSrGoEG0K
	Xp0ANRYFZiPHPlCZce+esI8OrziLxTNCI3CipMM+6oA8DLuWpsKOgwjdTFcY5fX0
	V6XJDJ2QLW9Yh3fgxHPEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716860224; x=
	1716946624; bh=oUbMKxb/AnzUhw3GvwikoRj656Q1cIKAuZQGKv+i05A=; b=J
	D2WTgaRELGS+RFOX6D/oY41aMTL7Jad52P2wJdGsRLn6dEHjqQ31l3Z3E2Z+JWU5
	cJwYbUAbWDzeYLgfPkC4IXObC1100vJyztmMFhE0Dur6A5iI/f1Tdz0BTqvkawWk
	QMcvljOn32e25Y4y0TTJ35r2PX/VjFwETpxyj1EE0pWtgr/mP7F40zyZoKY6/Tw6
	WIr80INf3Cii0KcUfsroMQlFc9doT4bBFIhnJHoCB4GA74hxK+js0hAxavturfYD
	DFOV2PvBv5KOA5g1wlc/1z+j8BDDhj+tCAGY4J7M4PXQC6FjvcTknYs2L0h+iUzb
	pgxN8469U+vZ7bl0pi2NA==
X-ME-Sender: <xms:QDVVZjNggA0afjrWUo6uVxAzKVemPEcTy7rf5eCJiQyiLFOc7mr92g>
    <xme:QDVVZt_jEEc1CdyAHfgq5N6mlQEwEwWQbBQ8pWO7keLgMMqHhLixWKbdXPscqoDnc
    209jjUHp-jeDmWkms0>
X-ME-Received: <xmr:QDVVZiS439lzAfW-fpdh06NDWwmkm7f7oxNT7JQvIC-pMGHe-bf3dV00dO8v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:QDVVZnsrxQGBNoPhEvga8LUyiTRYsnA8aFgDSbIY0ub8gGdfry4trg>
    <xmx:QDVVZrfJq-FQyr3O7ScWKUcHjokz6xewKYklV1uvSKbMNLZu-ffpYA>
    <xmx:QDVVZj3p-ZSPZHcyA1FeauOfTm3Kb5zRj_jNI7oupxWJijlJJtLXmA>
    <xmx:QDVVZn-uzlJJs0Jg1kYsfuihNDTyrpqOd0AngZFgWFFY8cYHS4J-aQ>
    <xmx:QDVVZsGzkO6vbamNEstTBbbn5tRu4eXLySkQki2OSyjsDi7w-048aIwP>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 21:37:01 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 9/9] platform/x86: asus-wmi: add setting dGPU TGP
Date: Tue, 28 May 2024 13:36:26 +1200
Message-ID: <20240528013626.14066-10-luke@ljones.dev>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528013626.14066-1-luke@ljones.dev>
References: <20240528013626.14066-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dGPU TGP can be set on a few ROG laptops. This gnerally needs some
extra userspace inference to find the base and limit:

- Find max-tgp from nvidia-smi
- Find max-boost from nv_dynamic_boost_max (asus_wmi)
- (max-tgp - max-boost - initial TGP) = base TGP
- (max-tgp - max-boost - base TGP) = max additional TGP

On some laptops the dgpu_base_tgp may return 0, in which case the base
TGP must be derived as above.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       | 19 +++++++++++++++++++
 drivers/platform/x86/asus-wmi.c               |  9 +++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index d221a3bc1a81..46df3452c9da 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -253,3 +253,22 @@ Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set the maximum available system memory for the APU.
 		  * Min=0, Max=8
+
+What:		/sys/devices/platform/<platform>/dgpu_tgp
+Date:		Jun 2024
+KernelVersion:	6.11
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Read and set the extra TGP applied to the dGPU. This is applied on
+		top of the dgpu_base_tgp.
+
+		If the dGPU maximum power including boost is 175 then we can calculate:
+		175 - 25 (dynamic boost) - 70 (initial dgpu_tgp) = 80 (dgpu_base_tgp).
+		For NVIDIA dGPU the max power can be found with nvidia-smi.
+
+What:		/sys/devices/platform/<platform>/dgpu_base_tgp
+Date:		Jun 2024
+KernelVersion:	6.11
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Read the absolute base TGP of the dGPU.
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 4b5fbae8c563..4d291429e7a1 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -123,6 +123,7 @@ module_param(fnlock_default, bool, 0444);
 #define NVIDIA_BOOST_MAX	25
 #define NVIDIA_TEMP_MIN		75
 #define NVIDIA_TEMP_MAX		87
+#define NVIDIA_GPU_POWER_MAX	70
 
 #define ASUS_SCREENPAD_BRIGHT_MIN 20
 #define ASUS_SCREENPAD_BRIGHT_MAX 255
@@ -797,6 +798,8 @@ WMI_ATTR_SIMPLE_RO(egpu_connected, ASUS_WMI_DEVID_EGPU_CONNECTED);
 WMI_ATTR_SIMPLE_RW(panel_od, 0, 1, ASUS_WMI_DEVID_PANEL_OD);
 WMI_ATTR_SIMPLE_RW(boot_sound, 0, 1, ASUS_WMI_DEVID_BOOT_SOUND);
 WMI_ATTR_SIMPLE_RO(charge_mode, ASUS_WMI_DEVID_CHARGE_MODE);
+WMI_ATTR_SIMPLE_RO(dgpu_base_tgp, ASUS_WMI_DEVID_DGPU_BASE_TGP);
+WMI_ATTR_SIMPLE_RW(dgpu_tgp, 0, NVIDIA_GPU_POWER_MAX, ASUS_WMI_DEVID_DGPU_SET_TGP);
 
 static ssize_t panel_fhd_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
@@ -4204,6 +4207,8 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_panel_fhd.attr,
+	&dev_attr_dgpu_base_tgp.attr,
+	&dev_attr_dgpu_tgp.attr,
 	&dev_attr_cores_enabled.attr,
 	&dev_attr_cores_max.attr,
 	&dev_attr_apu_mem.attr,
@@ -4280,6 +4285,10 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_PANEL_OD;
 	else if (attr == &dev_attr_panel_fhd.attr)
 		devid = ASUS_WMI_DEVID_PANEL_FHD;
+	else if (attr == &dev_attr_dgpu_base_tgp.attr)
+		devid = ASUS_WMI_DEVID_DGPU_BASE_TGP;
+	else if (attr == &dev_attr_dgpu_tgp.attr)
+		ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU_SET_TGP);
 	else if (attr == &dev_attr_cores_enabled.attr
 		|| attr == &dev_attr_cores_max.attr)
 		ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CORES_SET);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index efe608861e55..71833bd60f27 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -135,6 +135,9 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+#define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
+#define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
+
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
 #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026
-- 
2.45.1


