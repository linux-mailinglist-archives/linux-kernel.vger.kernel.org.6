Return-Path: <linux-kernel+bounces-191614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8F58D1179
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FDD7B21F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980D1B950;
	Tue, 28 May 2024 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="hkc7nM0k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aj+VUFvO"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A08718039;
	Tue, 28 May 2024 01:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860208; cv=none; b=VUoFJgMsFq4sKxVXRnbUGTM7WIMUum8fVtDKDmFjmiWat6Y6YI5wqdNWYiCxmY1eEbYL33gdwgjrO5FRe+N+zWbq4csRJ27aQf77NBwq1smH5fGwpBAOa68+UhjlI2pUUzS3xulLolomxoaIXIw8E9Tbq3Bj6qZVnzeuMDWa2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860208; c=relaxed/simple;
	bh=Q2rvBjS1MCxee3IOaolZ0vn8pemDfVifNXK1NpgBG0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it2zJ0pNwvf5D7z6AtyQwdADtSGQprJcCnnQeq7m6G7iMBBTHb1aRmvGNopFfdx8LERE42t8UPbpL8IGkK4aIxqJvfnEj784SFaU53FH2sEKcq36Dzqub64jchKlZitgoEz6UcYbLgC8kj9Cg45iu53pfDbxYGuNNysaHJEWIoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=hkc7nM0k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aj+VUFvO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9D515138013A;
	Mon, 27 May 2024 21:36:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 May 2024 21:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1716860205; x=
	1716946605; bh=7Aa3sTl039lcsHosnWGLerpiLs/DMEJf6PqKt2C8ti4=; b=h
	kc7nM0kAw98A+fqQIm9O0WKlXuj0rhymd4xO4s6XwqQvaC2kyYpKqYvaFiwwexm7
	OB6hkXJ4y4dK5bFee7wCXcyBeCt3pHE+O+sKUKEiXr4sGZmFD2gOKGh+vo6I8Fq2
	S4hq8BLdprd549mDM/MgV3uujZkf6acZXLIazV0eRWTyc88oeFkTVJpw/kkJz3SU
	ZbBlqZ2Ligwepo7Vm3bPQLmKemJQFE7sKhjk7TePlo+j5NrL0XlGuwZ7R2PPtJQD
	Z+8w6ZWZW0PbCjg5+zv5tSGJfVfjqpRBewyBy5HShy9JxkFh/Lu/UbXbAZCSBtF1
	GslQuR48yQ0JrRFR4iAsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716860205; x=
	1716946605; bh=7Aa3sTl039lcsHosnWGLerpiLs/DMEJf6PqKt2C8ti4=; b=A
	j+VUFvOpJ64mb//Viw777+kg/oBboIJcEi351npiPGG8Ac0/5bBw7iN6KVgPOt+P
	Vl92ToYghk1HV3wJPKoIZVPc4WWkha+vzy31mesPw29DOpDBwomUQ0T9YKcdxDmN
	RGh9w19YsR6QvNWPWDcoD+ZkxLpYbqDphfUAjved6hFJNsQpon4yFVJe8oLBSvo0
	MRZjM5Ylh0tfmiopKRCRbphBfXUX2IqoVMSReluqcvOyTl+f7mYsHClfRziuv6do
	OQi9NCJay26tpjyWHCTMNoIVZxFR8wEUtLNntc0rrgJFD9jhJlKVBgZveUgyzCBK
	DGZFvVxgLdf0hg8Q2uUYA==
X-ME-Sender: <xms:LTVVZtcZ7D0vsISh-_Zp0y2fK_b3rEoUI-4PiEhC3lmThfV4vbHR8g>
    <xme:LTVVZrNG6AjULNZaFwwzMz0KItHszrwHc3S4ZiGE268fV89-3swwI3T5WntCzNVgH
    vQWz75x8FY4Ls9F5wg>
X-ME-Received: <xmr:LTVVZmhEz9gcyd5MtMNp2eouHZzJHcawgcqNk17dNB2qEm0B26An76AnisqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:LTVVZm_8eAzYxohx550BlQhTAk1o9Ba-lHDT0iV7AFdoeiVLwluTmA>
    <xmx:LTVVZpv55jaa71UN2GNoI_NHWpgPmsztXdiVaVARNHynZd-0fvYMog>
    <xmx:LTVVZlElZOpedtxuc1Jo7EeQz2JQCs5nQKo6eZg-gybJ2UiGXIYJ2w>
    <xmx:LTVVZgM7dN0Cdxgg4XMiw_PYSx_GaC12zfOpzrhcWuVDlnFi9v2rKQ>
    <xmx:LTVVZnXyISrwfS06Vo5k9UZgYWBkfDx0hOTlDmDUC1dNpHhHWtMOpsbh>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 21:36:42 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 3/9] platform/x86: asus-wmi: add macros and expose min/max sysfs for ppt tunables
Date: Tue, 28 May 2024 13:36:20 +1200
Message-ID: <20240528013626.14066-4-luke@ljones.dev>
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

In most cases the safe min and max values of the various PPT tunables are
known for various ASUS ROG (and other) laptop models. We can match the
DMI string for these and expose min/max sysfs points, plus set some sane
default values.

As part of the addition of the min/max and defaults, to reduce the amount
of code copy/paste and introduce some sanity a group of macros were added
specific to the PPT and NV tunables. The code becomes much cleaner and
easier to read.

This makes the PPT functions much more usable and safe.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  23 +-
 drivers/platform/x86/asus-wmi.c               | 561 ++++++++----------
 2 files changed, 245 insertions(+), 339 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 28144371a0f1..984a04f32fd0 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -142,8 +142,8 @@ Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set the Package Power Target total of CPU: PL1 on Intel, SPL on AMD.
 		Shown on Intel+Nvidia or AMD+Nvidia based systems:
-
-			* min=5, max=250
+            * min/max varies, read *_min/*_max sysfs entries
+			* -1 resets to default
 
 What:		/sys/devices/platform/<platform>/ppt_pl2_sppt
 Date:		Jun 2023
@@ -152,8 +152,8 @@ Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set the Slow Package Power Tracking Limit of CPU: PL2 on Intel, SPPT,
 		on AMD. Shown on Intel+Nvidia or AMD+Nvidia based systems:
-
-			* min=5, max=250
+            * min/max varies, read *_min/*_max sysfs entries
+			* -1 resets to default
 
 What:		/sys/devices/platform/<platform>/ppt_fppt
 Date:		Jun 2023
@@ -161,7 +161,8 @@ KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set the Fast Package Power Tracking Limit of CPU. AMD+Nvidia only:
-			* min=5, max=250
+			* min/max varies, read *_min/*_max sysfs entries
+			* -1 resets to default
 
 What:		/sys/devices/platform/<platform>/ppt_apu_sppt
 Date:		Jun 2023
@@ -169,7 +170,8 @@ KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set the APU SPPT limit. Shown on full AMD systems only:
-			* min=5, max=130
+			* min/max varies, read *_min/*_max sysfs entries
+			* -1 resets to default
 
 What:		/sys/devices/platform/<platform>/ppt_platform_sppt
 Date:		Jun 2023
@@ -177,7 +179,8 @@ KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set the platform SPPT limit. Shown on full AMD systems only:
-			* min=5, max=130
+			* min/max varies, read *_min/*_max sysfs entries
+			* -1 resets to default
 
 What:		/sys/devices/platform/<platform>/nv_dynamic_boost
 Date:		Jun 2023
@@ -185,7 +188,8 @@ KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set the dynamic boost limit of the Nvidia dGPU:
-			* min=5, max=25
+			* min/max varies, read *_min/*_max sysfs entries
+			* -1 resets to default
 
 What:		/sys/devices/platform/<platform>/nv_temp_target
 Date:		Jun 2023
@@ -193,7 +197,8 @@ KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
 		Set the target temperature limit of the Nvidia dGPU:
-			* min=75, max=87
+			* min/max varies, read *_min/*_max sysfs entries
+			* -1 resets to default
 
 What:		/sys/devices/platform/<platform>/boot_sound
 Date:		Apr 2024
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 999cd658ec8b..d016acb23789 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -112,11 +112,13 @@ module_param(fnlock_default, bool, 0444);
 /* Mask to determine if setting temperature or percentage */
 #define FAN_CURVE_PWM_MASK		0x04
 
-/* Limits for tunables available on ASUS ROG laptops */
-#define PPT_TOTAL_MIN		5
-#define PPT_TOTAL_MAX		250
-#define PPT_CPU_MIN			5
-#define PPT_CPU_MAX			130
+/* Default limits for tunables available on ASUS ROG laptops */
+#define PPT_CPU_LIMIT_MIN	5
+#define PPT_CPU_LIMIT_MAX	150
+#define PPT_CPU_LIMIT_DEFAULT	80
+#define PPT_PLATFORM_MIN	5
+#define PPT_PLATFORM_MAX	100
+#define PPT_PLATFORM_DEFAULT	80
 #define NVIDIA_BOOST_MIN	5
 #define NVIDIA_BOOST_MAX	25
 #define NVIDIA_TEMP_MIN		75
@@ -219,6 +221,29 @@ struct fan_curve_data {
 	u8 percents[FAN_CURVE_POINTS];
 };
 
+/* Tunables provided by ASUS for gaming laptops */
+struct rog_tunables {
+	u32 cpu_default;
+	u32 cpu_max;
+
+	u32 platform_default;
+	u32 platform_max;
+
+	u32 ppt_pl1_spl; // total
+	u32 ppt_pl2_sppt; // total
+	u32 ppt_apu_sppt; // cpu
+	u32 ppt_platform_sppt; // cpu
+	u32 ppt_fppt; // total
+
+	u32 nv_boost_default;
+	u32 nv_boost_max;
+	u32 nv_dynamic_boost;
+
+	u32 nv_temp_default;
+	u32 nv_temp_max;
+	u32 nv_temp_target;
+};
+
 struct asus_wmi {
 	int dsts_id;
 	int spec;
@@ -273,14 +298,7 @@ struct asus_wmi {
 	bool dgpu_disable_available;
 	u32 gpu_mux_dev;
 
-	/* Tunables provided by ASUS for gaming laptops */
-	u32 ppt_pl2_sppt;
-	u32 ppt_pl1_spl;
-	u32 ppt_apu_sppt;
-	u32 ppt_platform_sppt;
-	u32 ppt_fppt;
-	u32 nv_dynamic_boost;
-	u32 nv_temp_target;
+	struct rog_tunables rog_tunables;
 
 	u32 kbd_rgb_dev;
 	bool kbd_rgb_state_available;
@@ -652,6 +670,98 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 	asus->inputdev = NULL;
 }
 
+/* Helper macros for generalised WMI calls */
+
+/* Generic store function for use with many ROG tunables */
+static ssize_t rog_tunable_store(struct asus_wmi *asus,
+				struct attribute *attr,
+				const char *buf, size_t count,
+				u32 min, u32 max, u32 defaultv,
+				u32 *store_value, u32 wmi_dev)
+{
+	int result, err, value;
+
+	result = kstrtoint(buf, 10, &value);
+	if (result)
+		return result;
+
+	if (value == -1 )
+		value = defaultv;
+	if (value < min || value > max)
+		return -EINVAL;
+
+	err = asus_wmi_set_devstate(wmi_dev, value, &result);
+	if (err) {
+		pr_err("Failed to set %s: %d\n", attr->name, err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_err("Failed to set %s (result): 0x%x\n", attr->name, result);
+		return -EIO;
+	}
+
+	if (store_value != NULL)
+		*store_value = value;
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, attr->name);
+
+	return count;
+}
+
+#define ROG_TUNABLE_STORE(_fname, _min, _max, _default, _wmi) \
+static ssize_t _fname##_store(struct device *dev, \
+	struct device_attribute *attr, const char *buf, size_t count) \
+{ \
+	struct asus_wmi *asus = dev_get_drvdata(dev); \
+	return rog_tunable_store(asus, &attr->attr, buf, count, \
+			_min, asus->rog_tunables._max, asus->rog_tunables._default, \
+			&asus->rog_tunables._fname, _wmi); \
+}
+
+#define ROG_TUNABLE_SHOW(_fname) \
+static ssize_t _fname##_show(struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	struct asus_wmi *asus = dev_get_drvdata(dev); \
+	return sysfs_emit(buf, "%u\n", asus->rog_tunables._fname); \
+}
+
+#define ROG_TUNABLE_MIN_SHOW(_fname, _minv) \
+static ssize_t _fname##_min_show(struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	return sysfs_emit(buf, "%u\n", _minv); \
+}
+
+#define ROG_TUNABLE_MAX_SHOW(_fname, _maxv) \
+static ssize_t _fname##_max_show(struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	struct asus_wmi *asus = dev_get_drvdata(dev); \
+	return sysfs_emit(buf, "%u\n", asus->rog_tunables._maxv); \
+}
+
+#define ROG_ATTR_RW(_fname, _minv, _maxv, _defaultv, _wmi) \
+ROG_TUNABLE_MIN_SHOW(_fname, _minv); \
+ROG_TUNABLE_MAX_SHOW(_fname, _maxv); \
+ROG_TUNABLE_STORE(_fname, _minv, _maxv, _defaultv, _wmi);\
+ROG_TUNABLE_SHOW(_fname); \
+static DEVICE_ATTR_RO(_fname##_min); \
+static DEVICE_ATTR_RO(_fname##_max); \
+static DEVICE_ATTR_RW(_fname)
+
+ROG_ATTR_RW(ppt_platform_sppt,
+	PPT_PLATFORM_MIN, platform_max, platform_default, ASUS_WMI_DEVID_PPT_PLAT_SPPT);
+ROG_ATTR_RW(ppt_pl2_sppt,
+	PPT_CPU_LIMIT_MIN, cpu_max, cpu_default, ASUS_WMI_DEVID_PPT_PL2_SPPT);
+ROG_ATTR_RW(ppt_apu_sppt,
+	PPT_PLATFORM_MIN, platform_max, platform_default, ASUS_WMI_DEVID_PPT_APU_SPPT);
+ROG_ATTR_RW(ppt_pl1_spl,
+	PPT_CPU_LIMIT_MIN, cpu_max, cpu_default, ASUS_WMI_DEVID_PPT_PL1_SPL);
+ROG_ATTR_RW(ppt_fppt,
+	PPT_CPU_LIMIT_MIN, cpu_max, cpu_default, ASUS_WMI_DEVID_PPT_FPPT);
+ROG_ATTR_RW(nv_dynamic_boost,
+	NVIDIA_BOOST_MIN, nv_boost_max, nv_boost_default, ASUS_WMI_DEVID_NV_DYN_BOOST);
+ROG_ATTR_RW(nv_temp_target,
+	NVIDIA_TEMP_MIN, nv_temp_max, nv_temp_default, ASUS_WMI_DEVID_NV_THERM_TARGET);
+
 /* Tablet mode ****************************************************************/
 
 static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
@@ -1018,306 +1128,6 @@ static const struct attribute_group *kbd_rgb_mode_groups[] = {
 	NULL,
 };
 
-/* Tunable: PPT: Intel=PL1, AMD=SPPT *****************************************/
-static ssize_t ppt_pl2_sppt_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result, err;
-	u32 value;
-
-	result = kstrtou32(buf, 10, &value);
-	if (result)
-		return result;
-
-	if (value < PPT_TOTAL_MIN || value > PPT_TOTAL_MAX)
-		return -EINVAL;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_PL2_SPPT, value, &result);
-	if (err) {
-		pr_warn("Failed to set ppt_pl2_sppt: %d\n", err);
-		return err;
-	}
-
-	if (result > 1) {
-		pr_warn("Failed to set ppt_pl2_sppt (result): 0x%x\n", result);
-		return -EIO;
-	}
-
-	asus->ppt_pl2_sppt = value;
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_pl2_sppt");
-
-	return count;
-}
-
-static ssize_t ppt_pl2_sppt_show(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%u\n", asus->ppt_pl2_sppt);
-}
-static DEVICE_ATTR_RW(ppt_pl2_sppt);
-
-/* Tunable: PPT, Intel=PL1, AMD=SPL ******************************************/
-static ssize_t ppt_pl1_spl_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result, err;
-	u32 value;
-
-	result = kstrtou32(buf, 10, &value);
-	if (result)
-		return result;
-
-	if (value < PPT_TOTAL_MIN || value > PPT_TOTAL_MAX)
-		return -EINVAL;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_PL1_SPL, value, &result);
-	if (err) {
-		pr_warn("Failed to set ppt_pl1_spl: %d\n", err);
-		return err;
-	}
-
-	if (result > 1) {
-		pr_warn("Failed to set ppt_pl1_spl (result): 0x%x\n", result);
-		return -EIO;
-	}
-
-	asus->ppt_pl1_spl = value;
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_pl1_spl");
-
-	return count;
-}
-static ssize_t ppt_pl1_spl_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%u\n", asus->ppt_pl1_spl);
-}
-static DEVICE_ATTR_RW(ppt_pl1_spl);
-
-/* Tunable: PPT APU FPPT ******************************************************/
-static ssize_t ppt_fppt_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result, err;
-	u32 value;
-
-	result = kstrtou32(buf, 10, &value);
-	if (result)
-		return result;
-
-	if (value < PPT_TOTAL_MIN || value > PPT_TOTAL_MAX)
-		return -EINVAL;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_FPPT, value, &result);
-	if (err) {
-		pr_warn("Failed to set ppt_fppt: %d\n", err);
-		return err;
-	}
-
-	if (result > 1) {
-		pr_warn("Failed to set ppt_fppt (result): 0x%x\n", result);
-		return -EIO;
-	}
-
-	asus->ppt_fppt = value;
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_fpu_sppt");
-
-	return count;
-}
-
-static ssize_t ppt_fppt_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%u\n", asus->ppt_fppt);
-}
-static DEVICE_ATTR_RW(ppt_fppt);
-
-/* Tunable: PPT APU SPPT *****************************************************/
-static ssize_t ppt_apu_sppt_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result, err;
-	u32 value;
-
-	result = kstrtou32(buf, 10, &value);
-	if (result)
-		return result;
-
-	if (value < PPT_CPU_MIN || value > PPT_CPU_MAX)
-		return -EINVAL;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_APU_SPPT, value, &result);
-	if (err) {
-		pr_warn("Failed to set ppt_apu_sppt: %d\n", err);
-		return err;
-	}
-
-	if (result > 1) {
-		pr_warn("Failed to set ppt_apu_sppt (result): 0x%x\n", result);
-		return -EIO;
-	}
-
-	asus->ppt_apu_sppt = value;
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_apu_sppt");
-
-	return count;
-}
-
-static ssize_t ppt_apu_sppt_show(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%u\n", asus->ppt_apu_sppt);
-}
-static DEVICE_ATTR_RW(ppt_apu_sppt);
-
-/* Tunable: PPT platform SPPT ************************************************/
-static ssize_t ppt_platform_sppt_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result, err;
-	u32 value;
-
-	result = kstrtou32(buf, 10, &value);
-	if (result)
-		return result;
-
-	if (value < PPT_CPU_MIN || value > PPT_CPU_MAX)
-		return -EINVAL;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PPT_PLAT_SPPT, value, &result);
-	if (err) {
-		pr_warn("Failed to set ppt_platform_sppt: %d\n", err);
-		return err;
-	}
-
-	if (result > 1) {
-		pr_warn("Failed to set ppt_platform_sppt (result): 0x%x\n", result);
-		return -EIO;
-	}
-
-	asus->ppt_platform_sppt = value;
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "ppt_platform_sppt");
-
-	return count;
-}
-
-static ssize_t ppt_platform_sppt_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%u\n", asus->ppt_platform_sppt);
-}
-static DEVICE_ATTR_RW(ppt_platform_sppt);
-
-/* Tunable: NVIDIA dynamic boost *********************************************/
-static ssize_t nv_dynamic_boost_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result, err;
-	u32 value;
-
-	result = kstrtou32(buf, 10, &value);
-	if (result)
-		return result;
-
-	if (value < NVIDIA_BOOST_MIN || value > NVIDIA_BOOST_MAX)
-		return -EINVAL;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_NV_DYN_BOOST, value, &result);
-	if (err) {
-		pr_warn("Failed to set nv_dynamic_boost: %d\n", err);
-		return err;
-	}
-
-	if (result > 1) {
-		pr_warn("Failed to set nv_dynamic_boost (result): 0x%x\n", result);
-		return -EIO;
-	}
-
-	asus->nv_dynamic_boost = value;
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "nv_dynamic_boost");
-
-	return count;
-}
-
-static ssize_t nv_dynamic_boost_show(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%u\n", asus->nv_dynamic_boost);
-}
-static DEVICE_ATTR_RW(nv_dynamic_boost);
-
-/* Tunable: NVIDIA temperature target ****************************************/
-static ssize_t nv_temp_target_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result, err;
-	u32 value;
-
-	result = kstrtou32(buf, 10, &value);
-	if (result)
-		return result;
-
-	if (value < NVIDIA_TEMP_MIN || value > NVIDIA_TEMP_MAX)
-		return -EINVAL;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_NV_THERM_TARGET, value, &result);
-	if (err) {
-		pr_warn("Failed to set nv_temp_target: %d\n", err);
-		return err;
-	}
-
-	if (result > 1) {
-		pr_warn("Failed to set nv_temp_target (result): 0x%x\n", result);
-		return -EIO;
-	}
-
-	asus->nv_temp_target = value;
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "nv_temp_target");
-
-	return count;
-}
-
-static ssize_t nv_temp_target_show(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
-	return sysfs_emit(buf, "%u\n", asus->nv_temp_target);
-}
-static DEVICE_ATTR_RW(nv_temp_target);
-
 /* Ally MCU Powersave ********************************************************/
 static ssize_t mcu_powersave_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -4367,13 +4177,27 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
 	&dev_attr_throttle_thermal_policy.attr,
-	&dev_attr_ppt_pl2_sppt.attr,
 	&dev_attr_ppt_pl1_spl.attr,
+	&dev_attr_ppt_pl1_spl_min.attr,
+	&dev_attr_ppt_pl1_spl_max.attr,
+	&dev_attr_ppt_pl2_sppt.attr,
+	&dev_attr_ppt_pl2_sppt_min.attr,
+	&dev_attr_ppt_pl2_sppt_max.attr,
 	&dev_attr_ppt_fppt.attr,
+	&dev_attr_ppt_fppt_min.attr,
+	&dev_attr_ppt_fppt_max.attr,
 	&dev_attr_ppt_apu_sppt.attr,
+	&dev_attr_ppt_apu_sppt_min.attr,
+	&dev_attr_ppt_apu_sppt_max.attr,
 	&dev_attr_ppt_platform_sppt.attr,
+	&dev_attr_ppt_platform_sppt_min.attr,
+	&dev_attr_ppt_platform_sppt_max.attr,
 	&dev_attr_nv_dynamic_boost.attr,
+	&dev_attr_nv_dynamic_boost_min.attr,
+	&dev_attr_nv_dynamic_boost_max.attr,
 	&dev_attr_nv_temp_target.attr,
+	&dev_attr_nv_temp_target_min.attr,
+	&dev_attr_nv_temp_target_max.attr,
 	&dev_attr_mcu_powersave.attr,
 	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
@@ -4414,19 +4238,33 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
 		ok = asus->throttle_thermal_policy_available;
-	else if (attr == &dev_attr_ppt_pl2_sppt.attr)
+	else if (attr == &dev_attr_ppt_pl2_sppt.attr
+		|| attr == &dev_attr_ppt_pl2_sppt_min.attr
+		|| attr == &dev_attr_ppt_pl2_sppt_max.attr)
 		devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
-	else if (attr == &dev_attr_ppt_pl1_spl.attr)
+	else if (attr == &dev_attr_ppt_pl1_spl.attr
+		|| attr == &dev_attr_ppt_pl1_spl_min.attr
+		|| attr == &dev_attr_ppt_pl1_spl_max.attr)
 		devid = ASUS_WMI_DEVID_PPT_PL1_SPL;
-	else if (attr == &dev_attr_ppt_fppt.attr)
+	else if (attr == &dev_attr_ppt_fppt.attr
+		|| attr == &dev_attr_ppt_fppt_min.attr
+		|| attr == &dev_attr_ppt_fppt_max.attr)
 		devid = ASUS_WMI_DEVID_PPT_FPPT;
-	else if (attr == &dev_attr_ppt_apu_sppt.attr)
+	else if (attr == &dev_attr_ppt_apu_sppt.attr
+		|| attr == &dev_attr_ppt_apu_sppt_min.attr
+		|| attr == &dev_attr_ppt_apu_sppt_max.attr)
 		devid = ASUS_WMI_DEVID_PPT_APU_SPPT;
-	else if (attr == &dev_attr_ppt_platform_sppt.attr)
+	else if (attr == &dev_attr_ppt_platform_sppt.attr
+		|| attr == &dev_attr_ppt_platform_sppt_min.attr
+		|| attr == &dev_attr_ppt_platform_sppt_max.attr)
 		devid = ASUS_WMI_DEVID_PPT_PLAT_SPPT;
-	else if (attr == &dev_attr_nv_dynamic_boost.attr)
+	else if (attr == &dev_attr_nv_dynamic_boost.attr
+		|| attr == &dev_attr_nv_dynamic_boost_min.attr
+		|| attr == &dev_attr_nv_dynamic_boost_max.attr)
 		devid = ASUS_WMI_DEVID_NV_DYN_BOOST;
-	else if (attr == &dev_attr_nv_temp_target.attr)
+	else if (attr == &dev_attr_nv_temp_target.attr
+		|| attr == &dev_attr_nv_temp_target_min.attr
+		|| attr == &dev_attr_nv_temp_target_max.attr)
 		devid = ASUS_WMI_DEVID_NV_THERM_TARGET;
 	else if (attr == &dev_attr_mcu_powersave.attr)
 		devid = ASUS_WMI_DEVID_MCU_POWERSAVE;
@@ -4652,6 +4490,77 @@ static void asus_wmi_debugfs_init(struct asus_wmi *asus)
 
 /* Init / exit ****************************************************************/
 
+/* Set up the min/max and defaults for ROG tunables */
+static void init_rog_tunables(struct asus_wmi *asus)
+{
+	const char *product;
+	u32 max_boost = NVIDIA_BOOST_MAX;
+	u32 cpu_default = PPT_CPU_LIMIT_DEFAULT;
+	u32 cpu_max = PPT_CPU_LIMIT_MAX;
+	u32 platform_default = PPT_PLATFORM_DEFAULT;
+	u32 platform_max = PPT_PLATFORM_MAX;
+
+	/*
+	 * ASUS product_name contains everything required, e.g,
+	 * "ROG Flow X16 GV601VV_GV601VV_00185149B"
+	 */
+	product = dmi_get_system_info(DMI_PRODUCT_NAME);
+
+	if (strstr(product, "GA402R")) {
+		cpu_default = 125;
+	} else if (strstr(product, "13QY")) {
+		cpu_max = 250;
+	} else if (strstr(product, "X13")) {
+		cpu_max = 75;
+		cpu_default = 50;
+	} else if (strstr(product, "RC71")) {
+		cpu_max = 50;
+		cpu_default = 30;
+	} else if (strstr(product, "G814")
+		|| strstr(product, "G614")
+		|| strstr(product, "G834")
+		|| strstr(product, "G634")) {
+		cpu_max = 175;
+	} else if (strstr(product, "GA402X")
+		|| strstr(product, "GA403")
+		|| strstr(product, "FA507N")
+		|| strstr(product, "FA507X")
+		|| strstr(product, "FA707N")
+		|| strstr(product, "FA707X")) {
+		cpu_max = 90;
+	}
+
+	if (strstr(product, "GZ301ZE"))
+		max_boost = 5;
+	else if (strstr(product, "FX507ZC4"))
+		max_boost = 15;
+	else if (strstr(product, "GU605"))
+		max_boost = 20;
+
+	/* ensure defaults for tunables */
+	asus->rog_tunables.cpu_default = cpu_default;
+	asus->rog_tunables.cpu_max = cpu_max;
+
+	asus->rog_tunables.platform_default = platform_default;
+	asus->rog_tunables.platform_max = platform_max;
+
+	asus->rog_tunables.ppt_pl1_spl = cpu_default;
+	asus->rog_tunables.ppt_pl2_sppt = cpu_default;
+	asus->rog_tunables.ppt_apu_sppt = cpu_default;
+
+	asus->rog_tunables.ppt_platform_sppt = platform_default;
+	asus->rog_tunables.ppt_fppt = platform_default;
+
+	asus->rog_tunables.nv_boost_default = NVIDIA_BOOST_MAX;
+	asus->rog_tunables.nv_boost_max = max_boost;
+	asus->rog_tunables.nv_dynamic_boost = NVIDIA_BOOST_MIN;
+
+	asus->rog_tunables.nv_temp_default = NVIDIA_TEMP_MAX;
+	asus->rog_tunables.nv_temp_max = NVIDIA_TEMP_MAX;
+	asus->rog_tunables.nv_temp_target = NVIDIA_TEMP_MIN;
+
+}
+
 static int asus_wmi_add(struct platform_device *pdev)
 {
 	struct platform_driver *pdrv = to_platform_driver(pdev->dev.driver);
@@ -4677,15 +4586,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_platform;
 
-	/* ensure defaults for tunables */
-	asus->ppt_pl2_sppt = 5;
-	asus->ppt_pl1_spl = 5;
-	asus->ppt_apu_sppt = 5;
-	asus->ppt_platform_sppt = 5;
-	asus->ppt_fppt = 5;
-	asus->nv_dynamic_boost = 5;
-	asus->nv_temp_target = 75;
-
+	init_rog_tunables(asus);
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
-- 
2.45.1


