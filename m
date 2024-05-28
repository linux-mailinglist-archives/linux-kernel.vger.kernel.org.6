Return-Path: <linux-kernel+bounces-191615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3218D117A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637BDB21FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398C1BDD3;
	Tue, 28 May 2024 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="BkS7uFZ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WN12QDGw"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD3EEDB;
	Tue, 28 May 2024 01:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860211; cv=none; b=ATgJ7I5XaAQrZtXzgYtANTFRWjuH6mFiiWIK33dxznu9gY0T/7L7z42u2WBln3uJC7tuTs6O58NLs/Nhu7ljQ5jSq3ooQRTBZ2huuJmE6LLlV08bliRJk9sigo2J/171yQ2kE3OlIyvCjxPdo/FuIXC08VG6d0ilgYWkCEJyn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860211; c=relaxed/simple;
	bh=THpXRT3p/0C4OrepJEXq/5KRR9Y10IEXpmUMdwr0zeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMA/+1haE8vw5mGAa5M4LvoMxFvcfuG07OFozWH5Ce9tZMjaTv+ltnUYyLz7n04jLQC6/bQ2aLUx3moknNz25vpH5XM7sbsZVxpEcvRqNjFn8he9oQPUOLYq1wfPTtXzIlyxJiV3Z4dJaeCx2SPN0F3BTgDvKjgjamiWfLmVGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=BkS7uFZ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WN12QDGw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id BC584138013D;
	Mon, 27 May 2024 21:36:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 27 May 2024 21:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1716860208; x=
	1716946608; bh=1y5ZIKidcSJ1U8GECBO90D6MU52bNNu/qP9jzcpqqYw=; b=B
	kS7uFZ1iUJMkv1500v7ZpHoA2u9Fmw9+A9GDNL4+Nx5Wv31Od7rr5rnz/cdSIWtg
	kjdPfphYcdvWkPNFbnWVTVOVPfyn01GMJ8Mc9a4iTmmojXRjiMvG4H3WLlYnws0W
	1CIjhs5O61wtNRbCskeMpdjYePr30cvDu0yNKXtigWDM2vjO2oNU+KwDYluRqNRJ
	SO0E4+ydCYkpeaDvBjnXZUMu3/8TuIFu7/REU7LfWoYfMvQwU72pOyDC1z1bk9h0
	qVLlXkim6gCFddyVBRgTrul+iEY4Slzo/JybnvfgOBxL5lEEUCam+JfA2ir4c2ox
	XCyHuMc/lDgYpOHgavndA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716860208; x=
	1716946608; bh=1y5ZIKidcSJ1U8GECBO90D6MU52bNNu/qP9jzcpqqYw=; b=W
	N12QDGwO6IEtfEHx76CwupHnm5gqyReJxRohyc7e10bfFrczar71LPQlFTWJh8ca
	lmWTlIyV5JfZ24T8cR4Hkjmq0hBaCXbqDP46/EmYdraiGb4kgJs1oiOd4dFejpUs
	bN192GCO7Y+hOqQNhnSCOstqqWAUQgoy8pNbD/OfbWvNXcibXvp/j0PbceD7wJcJ
	M1smHbRTZJW17QUb1Bl2QT195pgGmfLDYKXZw6THKTRubmZjscSr0bpdKS+VQ7XG
	w53YInotILCH9fmIfufhe8w/wwpsPOYMhBfA3RewtbNJtEk4iO++0wkmq51RXLXI
	kAaD0A0WBbTwoz+aQWnmg==
X-ME-Sender: <xms:MDVVZl1H0KTM2IzNurti8ZBPO5thxGKKAbkt8T2ua5l589GMuaTjNA>
    <xme:MDVVZsEMfgQ7jgwLsJYn4SRQkIlLLNBs1avnyni8UGpc2aRXw57GPOP4HDkLYVe30
    9C-ujy2ym9MMqqFHGY>
X-ME-Received: <xmr:MDVVZl4sbUDyG6gpl6YYOSlw7L-DUUFaC2O5uETs_CGBV7tO0g5_U8zRtTDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:MDVVZi3E4zOeW1B9DIbt4k05W7ZY4MJ7ai_ONaAsz9h3NYBjRf09LQ>
    <xmx:MDVVZoG5-tVEHppOuySbYN1Tm7nh3xCuft8LY5mtggi6o1x9eFLBKQ>
    <xmx:MDVVZj9-PcBqvJsJn4Em6C1OyBy9-5QflVeY0WjOkBqZliI5o6EinA>
    <xmx:MDVVZlnsTJBP9JkzyRj7sioiAtk0_LX0SVsUQHkOk2_chWKBgVvvVA>
    <xmx:MDVVZtONbLmXJwxCSUAMBrvyEwMi3LspuCpAWorAJ-JDDfJG4o5Te1gL>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 21:36:45 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 4/9] platform/x86: asus-wmi: reduce code duplication with macros
Date: Tue, 28 May 2024 13:36:21 +1200
Message-ID: <20240528013626.14066-5-luke@ljones.dev>
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

Over time many default patterns have emerged while adding functionality.
This patch consolidates those patterns in to a few macros to remove a lot
of copy/paste, and make it easier to add more of the same style of
features in the future.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 215 ++++++--------------------------
 1 file changed, 38 insertions(+), 177 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index d016acb23789..5c03e28ff252 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -676,7 +676,7 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 static ssize_t rog_tunable_store(struct asus_wmi *asus,
 				struct attribute *attr,
 				const char *buf, size_t count,
-				u32 min, u32 max, u32 defaultv,
+				u32 min, u32 max, int defaultv,
 				u32 *store_value, u32 wmi_dev)
 {
 	int result, err, value;
@@ -685,7 +685,7 @@ static ssize_t rog_tunable_store(struct asus_wmi *asus,
 	if (result)
 		return result;
 
-	if (value == -1 )
+	if (value == -1 && defaultv != -1)
 		value = defaultv;
 	if (value < min || value > max)
 		return -EINVAL;
@@ -708,6 +708,36 @@ static ssize_t rog_tunable_store(struct asus_wmi *asus,
 	return count;
 }
 
+#define WMI_SIMPLE_STORE(_fname, _min, _max, _wmi) \
+static ssize_t _fname##_store(struct device *dev, \
+	struct device_attribute *attr, const char *buf, size_t count) \
+{ \
+	struct asus_wmi *asus = dev_get_drvdata(dev); \
+	return rog_tunable_store(asus, &attr->attr, buf, count, \
+				_min, _max, -1, NULL, _wmi); \
+}
+
+#define WMI_SIMPLE_SHOW(_fname, _fmt, _wmi) \
+static ssize_t _fname##_show(struct device *dev, \
+	struct device_attribute *attr, char *buf) \
+{ \
+	struct asus_wmi *asus = dev_get_drvdata(dev); \
+	u32 result; \
+	asus_wmi_get_devstate(asus, _wmi, &result); \
+	if (result < 0) \
+		return result; \
+	return sysfs_emit(buf, _fmt, result & ~ASUS_WMI_DSTS_PRESENCE_BIT); \
+}
+
+#define WMI_ATTR_SIMPLE_RW(_fname, _minv, _maxv, _wmi) \
+WMI_SIMPLE_STORE(_fname, _minv, _maxv, _wmi); \
+WMI_SIMPLE_SHOW(_fname, "%d\n", _wmi); \
+static DEVICE_ATTR_RW(_fname)
+
+#define WMI_ATTR_SIMPLE_RO(_fname, _wmi) \
+WMI_SIMPLE_SHOW(_fname, "%d\n", _wmi); \
+static DEVICE_ATTR_RO(_fname)
+
 #define ROG_TUNABLE_STORE(_fname, _min, _max, _default, _wmi) \
 static ssize_t _fname##_store(struct device *dev, \
 	struct device_attribute *attr, const char *buf, size_t count) \
@@ -761,6 +791,12 @@ ROG_ATTR_RW(nv_dynamic_boost,
 	NVIDIA_BOOST_MIN, nv_boost_max, nv_boost_default, ASUS_WMI_DEVID_NV_DYN_BOOST);
 ROG_ATTR_RW(nv_temp_target,
 	NVIDIA_TEMP_MIN, nv_temp_max, nv_temp_default, ASUS_WMI_DEVID_NV_THERM_TARGET);
+/* Ally MCU Powersave */
+WMI_ATTR_SIMPLE_RW(mcu_powersave, 0, 1, ASUS_WMI_DEVID_MCU_POWERSAVE);
+WMI_ATTR_SIMPLE_RO(egpu_connected, ASUS_WMI_DEVID_EGPU_CONNECTED);
+WMI_ATTR_SIMPLE_RW(panel_od, 0, 1, ASUS_WMI_DEVID_PANEL_OD);
+WMI_ATTR_SIMPLE_RW(boot_sound, 0, 1, ASUS_WMI_DEVID_BOOT_SOUND);
+WMI_ATTR_SIMPLE_RO(charge_mode, ASUS_WMI_DEVID_CHARGE_MODE);
 
 /* Tablet mode ****************************************************************/
 
@@ -776,22 +812,6 @@ static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
 		asus_wmi_tablet_sw_report(asus, result);
 }
 
-/* Charging mode, 1=Barrel, 2=USB ******************************************/
-static ssize_t charge_mode_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result, value;
-
-	result = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_CHARGE_MODE, &value);
-	if (result < 0)
-		return result;
-
-	return sysfs_emit(buf, "%d\n", value & 0xff);
-}
-
-static DEVICE_ATTR_RO(charge_mode);
-
 /* dGPU ********************************************************************/
 static ssize_t dgpu_disable_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -925,22 +945,6 @@ static ssize_t egpu_enable_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(egpu_enable);
 
-/* Is eGPU connected? *********************************************************/
-static ssize_t egpu_connected_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result;
-
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
-	if (result < 0)
-		return result;
-
-	return sysfs_emit(buf, "%d\n", result);
-}
-
-static DEVICE_ATTR_RO(egpu_connected);
-
 /* gpu mux switch *************************************************************/
 static ssize_t gpu_mux_mode_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
@@ -1128,53 +1132,6 @@ static const struct attribute_group *kbd_rgb_mode_groups[] = {
 	NULL,
 };
 
-/* Ally MCU Powersave ********************************************************/
-static ssize_t mcu_powersave_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result;
-
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MCU_POWERSAVE);
-	if (result < 0)
-		return result;
-
-	return sysfs_emit(buf, "%d\n", result);
-}
-
-static ssize_t mcu_powersave_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	int result, err;
-	u32 enable;
-
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
-	result = kstrtou32(buf, 10, &enable);
-	if (result)
-		return result;
-
-	if (enable > 1)
-		return -EINVAL;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, enable, &result);
-	if (err) {
-		pr_warn("Failed to set MCU powersave: %d\n", err);
-		return err;
-	}
-
-	if (result > 1) {
-		pr_warn("Failed to set MCU powersave (result): 0x%x\n", result);
-		return -EIO;
-	}
-
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "mcu_powersave");
-
-	return count;
-}
-static DEVICE_ATTR_RW(mcu_powersave);
-
 /* Battery ********************************************************************/
 
 /* The battery maximum charging percentage */
@@ -2002,102 +1959,6 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
 	return result;
 }
 
-/* Panel Overdrive ************************************************************/
-static ssize_t panel_od_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result;
-
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_PANEL_OD);
-	if (result < 0)
-		return result;
-
-	return sysfs_emit(buf, "%d\n", result);
-}
-
-static ssize_t panel_od_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	int result, err;
-	u32 overdrive;
-
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
-	result = kstrtou32(buf, 10, &overdrive);
-	if (result)
-		return result;
-
-	if (overdrive > 1)
-		return -EINVAL;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_PANEL_OD, overdrive, &result);
-
-	if (err) {
-		pr_warn("Failed to set panel overdrive: %d\n", err);
-		return err;
-	}
-
-	if (result > 1) {
-		pr_warn("Failed to set panel overdrive (result): 0x%x\n", result);
-		return -EIO;
-	}
-
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "panel_od");
-
-	return count;
-}
-static DEVICE_ATTR_RW(panel_od);
-
-/* Bootup sound ***************************************************************/
-
-static ssize_t boot_sound_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result;
-
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_BOOT_SOUND);
-	if (result < 0)
-		return result;
-
-	return sysfs_emit(buf, "%d\n", result);
-}
-
-static ssize_t boot_sound_store(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *buf, size_t count)
-{
-	int result, err;
-	u32 snd;
-
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-
-	result = kstrtou32(buf, 10, &snd);
-	if (result)
-		return result;
-
-	if (snd > 1)
-		return -EINVAL;
-
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BOOT_SOUND, snd, &result);
-	if (err) {
-		pr_warn("Failed to set boot sound: %d\n", err);
-		return err;
-	}
-
-	if (result > 1) {
-		pr_warn("Failed to set panel boot sound (result): 0x%x\n", result);
-		return -EIO;
-	}
-
-	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "boot_sound");
-
-	return count;
-}
-static DEVICE_ATTR_RW(boot_sound);
-
 /* Mini-LED mode **************************************************************/
 static ssize_t mini_led_mode_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
-- 
2.45.1


