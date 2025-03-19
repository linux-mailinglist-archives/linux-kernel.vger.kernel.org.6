Return-Path: <linux-kernel+bounces-567390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35425A6855C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BBE3BC533
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4F62505B6;
	Wed, 19 Mar 2025 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="QbPI83Xy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n94eIG2X"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C92505A8;
	Wed, 19 Mar 2025 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367541; cv=none; b=cPPqdLQOk/dbttreE/JykcZJDNYO93g4tr5Xn3oJAQj6YtI5u9PAx/dnQ5YlFJjWbFjw6i12Qoq9zPuUTt/tRJDX8dymSjKANwHvH4y/1JBI2w6F911/K0QFjHTrz0TwKtzn2VCyAruh6XqBYWhLHhJViht/9NkJaOk3/9c+6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367541; c=relaxed/simple;
	bh=yyY3gc7JgCt7aMbH/iNUReC/pPuPe9AIbIBnHJs5YB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYoHG/UmnWFSatN3fv0j23ivRJ8Hcq+9nv/3WI7AcKieYdNyrN+sTYgcQknezkgeJiwQHSgoEeCIr9BjOOTODKyXeXKna6Hd5f8TZSppkeL+fksgMWLH8FDEdCuGTe5bkv1Ld7/qDuzIaBg43gnCC6bn5dOnzIugu7cAy8RanyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=QbPI83Xy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n94eIG2X; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECD5C25401E0;
	Wed, 19 Mar 2025 02:58:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 19 Mar 2025 02:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742367537; x=
	1742453937; bh=baCv17+0ZyTTyukvf7OYqDT3Y/tUGEtctdVqmfaQK9o=; b=Q
	bPI83XyU5rxwb2DShhVU9GHISjTnZo/OlUMiqodJNyPeJG5vSI5vPGKAft8kuBC4
	EXYi1pB+qpMefpP/9FOVG+e4SGpMizNVMANqAOz504DFwrlDKqnq58iqf+A5tXgQ
	F3B5EQz06tr1kBwBQcT2ZcvibmCUAwdMddDqVq0YCfYPpoGPmqCPid92kWVSMUVs
	jRRvNArtaKmaiH2LruNvvfBoWdYcb814D30ajNIDNnn9fu00qJOEfYXjshjuBIrq
	XtWfuupFN7kfZuTsaVe5VKX0g0rPlZpJnTmK6yzmKeKr1bhuJR2YZh/0CrZf7gBF
	nTdktKQwpI/GlC/BB3whA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742367537; x=1742453937; bh=b
	aCv17+0ZyTTyukvf7OYqDT3Y/tUGEtctdVqmfaQK9o=; b=n94eIG2Xnj2p4vJQL
	+7+GSstXHGxxTEJl4QwjfXqTEzWLv8fUaI7hSoAPPmqzQYpXynZ56fvcmZxrN0vW
	xGSDMYgxyRJ6Crp2QIMRY4I3qodK7iXGJ8qhRL2TAhbgxaSqLPjG18k408khF3Oc
	gqvNI8quITbPasr69K1VsJZGWTinsL/fBxJfXN4ISMySEyX+IjISFzBghgG5BhWy
	u2dpBbmHO1I9UC2bgOtp4zbzWm/h46xxECiVBd3YxKoSsJ/VluNw+J4tlbFeUzfw
	peKwhKJFkR58elWhfJ4qoDCiR67+ZSOY6Xdqa6IwW/ZcMrAiom5cMUTyMyYhJnR9
	lvTcg==
X-ME-Sender: <xms:MWvaZ9uhNevWJMsmR50LcMZEy6yiLRWv5ufPOkDHvj1grRnb5TyDvQ>
    <xme:MWvaZ2fIGr15qMQmHbeE4jvSjccTjrDDRpVrgKsEHbx9UqVwuQGd_-_pTPtrtfzGQ
    OSfnixz04TOyJtCy-s>
X-ME-Received: <xmr:MWvaZww2yJzjQjjGMT7Br3R14kSc622xdLMJ_P7XEQmfnH3akw0YPbKZa5s_vWGqrC9wp_lAB62MsTJp_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegieejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:MWvaZ0M3wSFQL8Vb-BH7dG1KxCrgE2LaofPjWiZQH0N1i5fptHqZAQ>
    <xmx:MWvaZ9998j4qbYd1dNCEy-ShIx6ZgUoy6hdrYvOqHktKG1D0zgl7xg>
    <xmx:MWvaZ0WO0JZw0Pzqzhu0udWkfGYw81qwA7PevaKxCCjoYSFIy8Cetg>
    <xmx:MWvaZ-ci2AbTZVKwv0fHRVw2gqauetS2Ca1545RIIyh003rMGoktUA>
    <xmx:MWvaZwl1ISuL3CP6fyo7XVcUhKsyxz51U9JCArxjwcD3scQu_ikzqRIV>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 02:58:53 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v8 4/8] platform/x86: asus-armoury: add apu-mem control support
Date: Wed, 19 Mar 2025 19:58:23 +1300
Message-ID: <20250319065827.53478-5-luke@ljones.dev>
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

Implement the APU memory size control under the asus-armoury module using
the fw_attributes class.

This allows the APU allocated memory size to be adjusted depending on
the users priority. A reboot is required after change.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/asus-armoury.c        | 114 +++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 116 insertions(+)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index a299471d78d5..b1d6b0c41669 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -388,6 +388,119 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj
 WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
 ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
 
+/* Device memory available to APU */
+
+static ssize_t apu_mem_current_value_show(struct kobject *kobj, struct kobj_attribute *attr,
+					  char *buf)
+{
+	int err;
+	u32 mem;
+
+	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_APU_MEM, &mem);
+	if (err)
+		return err;
+
+	switch (mem) {
+	case 0x100:
+		mem = 0;
+		break;
+	case 0x102:
+		mem = 1;
+		break;
+	case 0x103:
+		mem = 2;
+		break;
+	case 0x104:
+		mem = 3;
+		break;
+	case 0x105:
+		mem = 4;
+		break;
+	case 0x106:
+		/* This is out of order and looks wrong but is correct */
+		mem = 8;
+		break;
+	case 0x107:
+		mem = 5;
+		break;
+	case 0x108:
+		mem = 6;
+		break;
+	case 0x109:
+		mem = 7;
+		break;
+	default:
+		mem = 4;
+		break;
+	}
+
+	return sysfs_emit(buf, "%u\n", mem);
+}
+
+static ssize_t apu_mem_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	int result, err;
+	u32 requested, mem;
+
+	result = kstrtou32(buf, 10, &requested);
+	if (result)
+		return result;
+
+	switch (requested) {
+	case 0:
+		mem = 0x000;
+		break;
+	case 1:
+		mem = 0x102;
+		break;
+	case 2:
+		mem = 0x103;
+		break;
+	case 3:
+		mem = 0x104;
+		break;
+	case 4:
+		mem = 0x105;
+		break;
+	case 5:
+		mem = 0x107;
+		break;
+	case 6:
+		mem = 0x108;
+		break;
+	case 7:
+		mem = 0x109;
+		break;
+	case 8:
+		/* This is out of order and looks wrong but is correct */
+		mem = 0x106;
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
+	pr_info("APU memory changed to %uGB, reboot required\n", requested);
+	sysfs_notify(kobj, NULL, attr->attr.name);
+
+	asus_set_reboot_and_signal_event();
+
+	return count;
+}
+
+static ssize_t apu_mem_possible_values_show(struct kobject *kobj, struct kobj_attribute *attr,
+					    char *buf)
+{
+	return sysfs_emit(buf, "0;1;2;3;4;5;6;7;8\n");
+}
+ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set available system RAM (in GB) for the APU to use");
+
 /* Simple attribute creation */
 ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
 		       "Show the current mode of charging");
@@ -408,6 +521,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
 	{ &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
 	{ &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
+	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
 
 	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 62a9adb1af2f..f3494a9efea7 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -137,6 +137,8 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+#define ASUS_WMI_DEVID_APU_MEM		0x000600C1
+
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
 #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026
-- 
2.49.0


