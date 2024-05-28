Return-Path: <linux-kernel+bounces-191617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB478D117E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995AEB224CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6679F29D06;
	Tue, 28 May 2024 01:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="cHIueFw4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WjrlEKKt"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD31322313;
	Tue, 28 May 2024 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860217; cv=none; b=tzBJOL3RsQ2nEPMD10IhsQ0LxPY5nkgkJ2nkmbRaRYc0Hety5qg8LfnlPUyImwIJA/xQHD5pJi+VJFypSwUVyqy6eqzxc7z4/+i3hFR4mNQfOnjLui2fXYzo0p/soExh5uRFvCMBqaYyeSJStcXXdn6tpVJJbmtSYzesjiPZBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860217; c=relaxed/simple;
	bh=zOvd3Ay0azx5vH/QyN7mBktkv8CR/XnOIiqvECdvHVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haSzOqB5fOlfBT8+6x8CRZk8CMvqWlPegld8yBNsLAs3WoLs9LMpLyrzz9FNk2ENh5TDwAZCXBbd9wEVEcEV/5QvMsOv0/ZCbcZoYuryig8ekM8kmhnCX855ikgP6Ke89jtH/iPQla1bzRRlGjJxAsXYFdyR8tkire63eVOEq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=cHIueFw4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WjrlEKKt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id F3102138013D;
	Mon, 27 May 2024 21:36:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 27 May 2024 21:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1716860214; x=
	1716946614; bh=kwPWX6tvrCbhVRU7E4dBQZXhLYs4bJ8/JTWq8BfSECA=; b=c
	HIueFw4tmcsP3Unsn1qs9wdhUSV69yCh9YBw8NqYP+icm9Yx4vVBvAXWagQygkfN
	jbOqddgkWK59L2J5t2+R0do8+6wUt/XvsCC234S7fY8fHXB16EAENqgBRiRFju9a
	PvVtapmZNIDlQZvKBEMbtXrdC5+RlIsJL5BIeGiHjJuklCw277cnwvXq0dQkVcJ9
	p+JoFOJ0nwdB+OMX6JG6CtZdNN7vdJyyhcIo9vLZj4KnsgbA+7PVBwzerWOu/Wm8
	9QtWIbIvRRm0PJmwkl/2n74Ayor7snAcg25KlqEWGb6l7RUhBvIRj1wl9VyZgXJu
	u6SyI3jRA9z7Ejd/1AJdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716860214; x=
	1716946614; bh=kwPWX6tvrCbhVRU7E4dBQZXhLYs4bJ8/JTWq8BfSECA=; b=W
	jrlEKKtC1XHKgRdNBCrRRMX4Nj1ycxd1U7NMrXHdLFGsIUuD+bIpAzGJkUeoJWkn
	7kix+L/AIUl2iSpMksXSkvjc3BfG/TEPsKRZlojKCklqxFb7wFOZ/P9mHBvPZxW0
	R8u5K1QxxCVBEhc/Rj1Jzv+dGj6hM8gLjWN3HY+BgW39CLamFghtgaa+CXRsLTdm
	tq4uXM82jdry8+nFXt1W0/QZDnS3GiYas61YqmqXWQMB3846H2s5nonpcVDchqXH
	3cmawF/jrkhs5wxL5rD0h7efYJaJMFRpAhAPYuD4PRbTGN8ni15LjJH1S1A5IJN1
	UsHA1YeP9ctV+hM0mpScQ==
X-ME-Sender: <xms:NjVVZmG1cmqKiBBINSQ-fJF6ixjEb3Zj-KP5R-C14wzUGNRBIYi6AQ>
    <xme:NjVVZnV8Lv198h4lEwq9g1DLtgzNlzS2EMS75CAVlnUk8VPWAWIKkaJWFA2k5auCi
    ipeQqe-9ibkdiqrCUU>
X-ME-Received: <xmr:NjVVZgJ02LnQOzI9yE9_uHt6n2HKx9SE8niU1WrktKQj9iaIs15lVEOeTjTK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepvden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:NjVVZgGdHoxZpP-nl1UQrP3gdi9JPJWQFE6Dfhi00xlxr3oEWf2d1w>
    <xmx:NjVVZsWDRwFbs9kyYf_2bFVGdcOsyUp9lcGjC8Cd8cTNT1JdxEeu6g>
    <xmx:NjVVZjO1WJz_rLCXYkswR09poD-QG06XKg9wlC2kbZjUMWt6A2QgTA>
    <xmx:NjVVZj2KMvyx4vCvir5tF1oJ3ZT57CPA4aavuPUq5hNacekJc71AZQ>
    <xmx:NjVVZmdOPDvGXWO7iF6U82_rdkTa66658RnRH30BjX5RE5BBmK0WMdlB>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 21:36:52 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 6/9] platform/x86: asus-wmi: add panel-fhd functionality
Date: Tue, 28 May 2024 13:36:23 +1200
Message-ID: <20240528013626.14066-7-luke@ljones.dev>
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

Exposes the FHD panel toggle avavilable on new ASUS Duo laptops.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  9 +++++++++
 drivers/platform/x86/asus-wmi.c               | 20 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  1 +
 3 files changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 984a04f32fd0..3b4eeea75b7b 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -217,3 +217,12 @@ Description:
 		Set if the MCU can go in to low-power mode on system sleep
 			* 0 - False,
 			* 1 - True
+
+What:		/sys/devices/platform/<platform>/panel_fhd
+Date:		Apr 2024
+KernelVersion:	6.11
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set panel to UHD or FHD mode
+			* 0 - UHD,
+			* 1 - FHD
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 260548aa6a42..4b045f1828f1 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -798,6 +798,23 @@ WMI_ATTR_SIMPLE_RW(panel_od, 0, 1, ASUS_WMI_DEVID_PANEL_OD);
 WMI_ATTR_SIMPLE_RW(boot_sound, 0, 1, ASUS_WMI_DEVID_BOOT_SOUND);
 WMI_ATTR_SIMPLE_RO(charge_mode, ASUS_WMI_DEVID_CHARGE_MODE);
 
+static ssize_t panel_fhd_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int err;
+
+	err = rog_tunable_store(asus, &attr->attr, buf, count,
+				0, 1, -1, NULL, ASUS_WMI_DEVID_PANEL_FHD);
+	if (err < 0)
+		return err;
+
+	pr_info("Panel UHD/FHD display mode changed, reboot required\n");
+	return count;
+}
+WMI_SIMPLE_SHOW(panel_fhd, "%d\n", ASUS_WMI_DEVID_PANEL_FHD);
+static DEVICE_ATTR_RW(panel_fhd);
+
 /* Tablet mode ****************************************************************/
 
 static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
@@ -4040,6 +4057,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_mcu_powersave.attr,
 	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
+	&dev_attr_panel_fhd.attr,
 	&dev_attr_mini_led_mode.attr,
 	&dev_attr_available_mini_led_mode.attr,
 	NULL
@@ -4111,6 +4129,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_BOOT_SOUND;
 	else if (attr == &dev_attr_panel_od.attr)
 		devid = ASUS_WMI_DEVID_PANEL_OD;
+	else if (attr == &dev_attr_panel_fhd.attr)
+		devid = ASUS_WMI_DEVID_PANEL_FHD;
 	else if (attr == &dev_attr_mini_led_mode.attr)
 		ok = asus->mini_led_dev_id != 0;
 	else if (attr == &dev_attr_available_mini_led_mode.attr)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 79a50102440d..6c51d41ffc20 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -72,6 +72,7 @@
 #define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
 #define ASUS_WMI_DEVID_MINI_LED_MODE	0x0005001E
 #define ASUS_WMI_DEVID_MINI_LED_MODE2	0x0005002E
+#define ASUS_WMI_DEVID_PANEL_FHD	0x0005001C
 
 /* Storage */
 #define ASUS_WMI_DEVID_CARDREADER	0x00080013
-- 
2.45.1


