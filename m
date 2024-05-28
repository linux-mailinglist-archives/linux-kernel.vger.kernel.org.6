Return-Path: <linux-kernel+bounces-191618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A78D1180
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5855A1C2297C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626B37719;
	Tue, 28 May 2024 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Uz6yH8Ar";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1e7sOWx"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3AF2E639;
	Tue, 28 May 2024 01:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860220; cv=none; b=sVOQjt6tTSNiOjA/Qp9RsOCinBcrmeoCLwOQLfV6B8IF0oAyBHd5YUQcCVqcm+00cUEbogPs+gX3Mi6c9heU/E5eq1uYRDxPwuZC+SgjkfmSx2WI8F4Tt/LZKftbvDjSO+hcZJhkR4U3wKuErQMWQiOnAs2llNsG68kZVqha7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860220; c=relaxed/simple;
	bh=mU1fHPbcvCL79A8RD2hsHX8ghHV0CAXO5Lop4WuvoV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DauG43eMq7p4tSQJ43gYKpFkARMqlPMJv8RVLUCCAJ0MOyCY/6SEZdC6HKWipILSmoDmXNe9zYTPQLnJugPWniuaPN1JTSLnqhy2qA0LTpSavmbKiZmlqspxr8OS9f385XUP2BlQedMxkPXZOSGHhdOi8AtDe7B95+oj4r+FL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Uz6yH8Ar; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O1e7sOWx; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2FDFE11400FC;
	Mon, 27 May 2024 21:36:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 27 May 2024 21:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1716860218; x=
	1716946618; bh=LJxcABA35wyl1DVjJ0uvxKmcEBlfef0iX30/mEprlhM=; b=U
	z6yH8Argq9077FU2VllIpX01taHSLxljS9YkDHQT4FyfwSbXPJdwFdy7MiFI1/S6
	i1RLd2VD+IjKGi0vnJ4q3dV1SoarzPln0Ge6+7+AUcM/9Dj5mFI9hvny7s2Njc8f
	B8xqMA/7PVELmY9+epM1TqP1pCWFWkjydMmKQ3+uM/SeLRqWzln62cP2Ezz1RUe8
	SHP1w7bu0sLSslBDyEzt0/HgNB0nNjcuFIcSZboqeTJadGKv0KvUy0cNIQHEvUvy
	QZV0Pq/Vm7aSd8xNt+bze61Ix3TJbBSjVzAWPJ0bl+bd8DXWcccMnoiPm1g1A17T
	celugjL80dulkrtVmukZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716860218; x=
	1716946618; bh=LJxcABA35wyl1DVjJ0uvxKmcEBlfef0iX30/mEprlhM=; b=O
	1e7sOWxFFw2YNqu8qiLTvfZRe+ZVOrL4eoqMIyDfYg8uHnV20ypqCv7zA83RgOk2
	nBX4Sk8gdsBK3pJ6eMpIErks2Dt34+qxsfL6ohXxDM4huyFezhPadZqXwuYFJt6p
	7/YBu+xhRpcnsjP/Khp4oHez/sbpyL+xIpZ+vAieA2PyJuYGMq2Fm517d08oNn5Q
	JQAjvcZHpNzyjKTKqLt1gj3ahxoHbGr3Ve2UyB0U6x2mRYlFBW/2es2rLhNXBR5S
	ktzSpTK0PwdKrp2DyZ8gafkNwnvJWk8tgpuyRCgTUZ8+Xh96AN4Ovta1givOfaLj
	HUuqrfAYEcUzpw4o82yXw==
X-ME-Sender: <xms:OTVVZliPKxIH10vItgyUFYALxlg5lAf1L36F7TDzhg1qET32-fcIxA>
    <xme:OTVVZqA0a5x_Nex6PSMwqgB9o1Y84ptFKnxmbZU-SX6ZkZ0b1v2eGHFHb7tE-SnCh
    lLAEK2xVU54JhUzRhs>
X-ME-Received: <xmr:OTVVZlGAzSU2rnCYtL1HAeXvkdM5S2W_20zRa33PqRz360a3zWS1uR5wve3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:OjVVZqTUV4dbMw_-GxARTb9_-_qdYjbtBe-HySPkS4OBCtMYAo6hIA>
    <xmx:OjVVZiym5ASmWDzY5Ros3ci2DqqPZvy3a25KtQ0_wPFH3GHiBEQ9zg>
    <xmx:OjVVZg7lHFyaIM_WFwdP1voLqxQCR9HEA10nJEMfxHZqC-gz0zYhrQ>
    <xmx:OjVVZnysne3OWTQOCv8_JCaBdMu33lIZCTFy6dS9rnOzOHOzzGmKlg>
    <xmx:OjVVZppkDKITiwxjsrcZ1SaCaMpB3lW9hSauaeZieNesztZ9oodQpejw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 21:36:55 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 7/9] platform/x86: asus-wmi: add enable/disable CPU cores
Date: Tue, 28 May 2024 13:36:24 +1200
Message-ID: <20240528013626.14066-8-luke@ljones.dev>
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

Exposes the WMI functions for enable/disable of performance and
efficiency cores on some laptop models (largely Intel only).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       | 19 ++++++++
 drivers/platform/x86/asus-wmi.c               | 45 +++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |  5 +++
 3 files changed, 69 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 3b4eeea75b7b..ac881e72e374 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -226,3 +226,22 @@ Description:
 		Set panel to UHD or FHD mode
 			* 0 - UHD,
 			* 1 - FHD
+
+What:		/sys/devices/platform/<platform>/cores_enabled
+Date:		Jun 2024
+KernelVersion:	6.11
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Enable/disable efficiency and performance cores. The format is
+		0x[E][P] where [E] is the efficiency core count, and [P] is
+		the perfromance core count. If the core count is a single digit
+		it is preceded by a 0 such as 0x0406; E=4, P=6, 0x1006; E=10, P=6
+
+What:		/sys/devices/platform/<platform>/cores_max
+Date:		Jun 2024
+KernelVersion:	6.11
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Show the maximum performance and efficiency core countin format
+		0x[E][P] where [E] is the efficiency core count, and [P] is
+		the perfromance core count.
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 4b045f1828f1..f62a36dfcd4b 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -815,6 +815,46 @@ static ssize_t panel_fhd_store(struct device *dev,
 WMI_SIMPLE_SHOW(panel_fhd, "%d\n", ASUS_WMI_DEVID_PANEL_FHD);
 static DEVICE_ATTR_RW(panel_fhd);
 
+/* Efficiency and Performance core control **********************************/
+static ssize_t cores_enabled_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result, err;
+	u32 cores, max;
+
+	result = kstrtou32(buf, 16, &cores);
+	if (result)
+		return result;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_CORES_MAX, &max);
+	if (err < 0)
+		return err;
+
+	if (cores > max) {
+		pr_warn("Core count 0x%x exceeds max: 0x%x\n", cores, max);
+		return -EIO;
+	}
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CORES_SET, cores, &result);
+	if (err) {
+		pr_warn("Failed to set cores_enabled: %d\n", err);
+		return err;
+	}
+
+	pr_info("Enabled core count changed, reboot required\n");
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "cores_enabled");
+
+	return count;
+}
+
+WMI_SIMPLE_SHOW(cores_enabled, "0x%x\n", ASUS_WMI_DEVID_CORES_SET);
+static DEVICE_ATTR_RW(cores_enabled);
+
+WMI_SIMPLE_SHOW(cores_max, "0x%x\n", ASUS_WMI_DEVID_CORES_MAX);
+static DEVICE_ATTR_RO(cores_max);
+
 /* Tablet mode ****************************************************************/
 
 static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
@@ -4058,6 +4098,8 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_boot_sound.attr,
 	&dev_attr_panel_od.attr,
 	&dev_attr_panel_fhd.attr,
+	&dev_attr_cores_enabled.attr,
+	&dev_attr_cores_max.attr,
 	&dev_attr_mini_led_mode.attr,
 	&dev_attr_available_mini_led_mode.attr,
 	NULL
@@ -4131,6 +4173,9 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_PANEL_OD;
 	else if (attr == &dev_attr_panel_fhd.attr)
 		devid = ASUS_WMI_DEVID_PANEL_FHD;
+	else if (attr == &dev_attr_cores_enabled.attr
+		|| attr == &dev_attr_cores_max.attr)
+		ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CORES_SET);
 	else if (attr == &dev_attr_mini_led_mode.attr)
 		ok = asus->mini_led_dev_id != 0;
 	else if (attr == &dev_attr_available_mini_led_mode.attr)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 6c51d41ffc20..5a56e7e97785 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -116,6 +116,11 @@
 /* Charging mode - 1=Barrel, 2=USB */
 #define ASUS_WMI_DEVID_CHARGE_MODE	0x0012006C
 
+/* Intel E-core and P-core configuration in a format 0x0[E]0[P] */
+#define ASUS_WMI_DEVID_CORES_SET	0x001200D2
+ /* Maximum Intel E-core and P-core availability */
+#define ASUS_WMI_DEVID_CORES_MAX	0x001200D3
+
 /* MCU powersave mode */
 #define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
 
-- 
2.45.1


