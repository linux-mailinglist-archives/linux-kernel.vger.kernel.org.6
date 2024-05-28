Return-Path: <linux-kernel+bounces-191619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2963E8D1182
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F301B2279F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A513A8CB;
	Tue, 28 May 2024 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="h11d5Eop";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6tNPcWJ"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFEB38384;
	Tue, 28 May 2024 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860223; cv=none; b=TNmPDs5KcwKPV57JAZF1OPPjMdfA2V26ogpoor+598pbZG/Q7AX/HDRLJQ0nwZYGga+pk/2ZlNbWNjlm6ic/+GHGEpoyjxfjEK9NDbRUEDNMS+huU8nhL35yt8SaRYS86iMQbOfpbeVSBvK/kNOFqNJPYhzkEefvjqn9gmigkLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860223; c=relaxed/simple;
	bh=pnyI+9VMiEw1nDcnYNO2We4ATRr2OD2ScBuTROS++u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ir/SGLbrU6NTSin1nYyuBalW6771q7jxv8e8FXaKP7jiv1r/CNBxCLF9n7Zh6qKbRC2Eaf2NoqHn/Eqm+x14xX/eMRomJR3g+y+Jz4eZpjsyK7wvxnMp1FWMQGqK3T2ytGD7ZftvQikKqoe0XyjTihcOyiz/Xo4XjacPbBXQTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=h11d5Eop; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K6tNPcWJ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 43765138013A;
	Mon, 27 May 2024 21:37:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 27 May 2024 21:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1716860221; x=
	1716946621; bh=u5wq2d1siVqqrNhbDvRTA1dC/Z6z6yq6CB526Lgu2e0=; b=h
	11d5EopzWbohWYtyK5fve5fE8qdoyHP6jdjHju52mWa+mqby5b9IyG+TZsE71uAR
	6YSyJ1mrH4VjQdvCWXqmgxKZtFZdiHjYl466kqeAkH5sjmcplszbfb96+4pnZNwX
	XgzYhpbsQutoBQauKaj6mrk6gypQiuTWvJ7QmGpCiswg8olFVH+gLvWcUxktBhD7
	vjaR1qWVlOkucHZFFzsFjUypAavwT6kWoFl851lO/diYEjeOxfBiEVfPNR39qnuH
	2NxIooUCqQndkxTbQlo45V0PoW8of2fu3bcnKB7f+mnDDZPpvCL/wZJLYzFE+WD0
	EqlAxc1jes74020XYX6+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716860221; x=
	1716946621; bh=u5wq2d1siVqqrNhbDvRTA1dC/Z6z6yq6CB526Lgu2e0=; b=K
	6tNPcWJLhYGDVEkQ8qeuGKWP4R4w47KxJFSFe6NLl+zPWHaLzANf3zz1ywGsuA9Y
	l2vAIFqRY8VRjHiaSPDSQdYy2QlrsxSID086yMQBi62rcbmnZMj7XLZ5xc0WNJD2
	y1eCLE5GFf04SEdtB/jIr2ut+g9L3TUlnot4FglBMZksXfi4+TvbSW2sGLFuywqt
	adgJpuoxukhToG/I+6dvMjMvLbaJwX/e+PJwcqaKAe+m0X5t/lvp87adWPBuFokU
	ex5eCUk63h+dClGUxN5f7GMSQlnXDMBQ4HM2K8yY6Co6MgsbcjzQ+Cye5yeGSkoY
	40/nEqjpES7WnGH7cCFmw==
X-ME-Sender: <xms:PTVVZswWtpKAFj3qUsMqCZrQQsg2QtmkbauUAonE7vLcAUmaKDrGLA>
    <xme:PTVVZgQZCURuwHoUd5ivc5aqGqvSRitWLl4ovJ5uI6ic2icCNm17-8o_SsnWqE1YD
    iIzoLJGXj5wDrWqwdo>
X-ME-Received: <xmr:PTVVZuWWaaODhBJbxUAJZNkeESWxDVSoSeelHeg3BXGhR8giXDWMbW62nRpf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:PTVVZqhphmeG9MiwtQ68GrPXqNIaX0omvZfIzbasDhWdtNINDhjqlg>
    <xmx:PTVVZuCwSyraBGL6Jp9bBBD8vUH5sLkXiFfV_1JGK2hvUgheN4leXA>
    <xmx:PTVVZrIritLYDuolZU_e5VD9EH3uDDXc6BEplXA5OwOSzhuu-virgQ>
    <xmx:PTVVZlAYzN7UeqyJ2XUY4KwVtqf6hbYmTAOQLWy5Di4_hxG_7ddSeQ>
    <xmx:PTVVZl4q6txx_l_irX5YnPCxnjWKck5cPO43k9BVuIISSBPqcQCOdEcu>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 21:36:58 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 8/9] platform/x86: asus-wmi: add apu_mem setting
Date: Tue, 28 May 2024 13:36:25 +1200
Message-ID: <20240528013626.14066-9-luke@ljones.dev>
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

Exposes the APU memory setting available on a few ASUS models such as
the ROG Ally.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |   8 ++
 drivers/platform/x86/asus-wmi.c               | 109 ++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h    |   3 +
 3 files changed, 120 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index ac881e72e374..d221a3bc1a81 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -245,3 +245,11 @@ Description:
 		Show the maximum performance and efficiency core countin format
 		0x[E][P] where [E] is the efficiency core count, and [P] is
 		the perfromance core count.
+
+What:		/sys/devices/platform/<platform>/apu_mem
+Date:		Jun 2024
+KernelVersion:	6.11
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set the maximum available system memory for the APU.
+		  * Min=0, Max=8
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f62a36dfcd4b..4b5fbae8c563 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -855,6 +855,112 @@ static DEVICE_ATTR_RW(cores_enabled);
 WMI_SIMPLE_SHOW(cores_max, "0x%x\n", ASUS_WMI_DEVID_CORES_MAX);
 static DEVICE_ATTR_RO(cores_max);
 
+/* Device memory available to APU */
+
+static ssize_t apu_mem_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int err;
+	u32 mem;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_APU_MEM, &mem);
+	if (err < 0)
+		return err;
+
+	switch (mem) {
+	case 256:
+		mem = 0;
+		break;
+	case 258:
+		mem = 1;
+		break;
+	case 259:
+		mem = 2;
+		break;
+	case 260:
+		mem = 3;
+		break;
+	case 261:
+		mem = 4;
+		break;
+	case 262:
+		mem = 8;
+		break;
+	case 263:
+		mem = 5;
+		break;
+	case 264:
+		mem = 6;
+		break;
+	case 265:
+		mem = 7;
+		break;
+	default:
+		mem = 4;
+		break;
+	}
+
+	return sysfs_emit(buf, "%d\n", mem);
+}
+
+static ssize_t apu_mem_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+	int result, err;
+	u32 mem;
+
+	result = kstrtou32(buf, 10, &mem);
+	if (result)
+		return result;
+
+	switch (mem) {
+	case 0:
+		mem = 0;
+		break;
+	case 1:
+		mem = 258;
+		break;
+	case 2:
+		mem = 259;
+		break;
+	case 3:
+		mem = 260;
+		break;
+	case 4:
+		mem = 261;
+		break;
+	case 5:
+		mem = 263;
+		break;
+	case 6:
+		mem = 264;
+		break;
+	case 7:
+		mem = 265;
+		break;
+	case 8:
+		mem = 262;
+		break;
+	default:
+		return -EIO;
+	}
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_APU_MEM, mem, &result);
+	if (err) {
+		pr_warn("Failed to set apu_mem: %d\n", err);
+		return err;
+	}
+
+	pr_info("APU memory changed, reboot required\n");
+	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "apu_mem");
+
+	return count;
+}
+static DEVICE_ATTR_RW(apu_mem);
+
 /* Tablet mode ****************************************************************/
 
 static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
@@ -4100,6 +4206,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_panel_fhd.attr,
 	&dev_attr_cores_enabled.attr,
 	&dev_attr_cores_max.attr,
+	&dev_attr_apu_mem.attr,
 	&dev_attr_mini_led_mode.attr,
 	&dev_attr_available_mini_led_mode.attr,
 	NULL
@@ -4176,6 +4283,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_cores_enabled.attr
 		|| attr == &dev_attr_cores_max.attr)
 		ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CORES_SET);
+	else if (attr == &dev_attr_apu_mem.attr)
+		ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_APU_MEM);
 	else if (attr == &dev_attr_mini_led_mode.attr)
 		ok = asus->mini_led_dev_id != 0;
 	else if (attr == &dev_attr_available_mini_led_mode.attr)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 5a56e7e97785..efe608861e55 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -121,6 +121,9 @@
  /* Maximum Intel E-core and P-core availability */
 #define ASUS_WMI_DEVID_CORES_MAX	0x001200D3
 
+/* Set the memory available to the APU */
+#define ASUS_WMI_DEVID_APU_MEM		0x000600C1
+
 /* MCU powersave mode */
 #define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
 
-- 
2.45.1


