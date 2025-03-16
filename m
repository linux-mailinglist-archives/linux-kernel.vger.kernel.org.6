Return-Path: <linux-kernel+bounces-563184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA5DA637F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A8F3ADA23
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2F91E1E1B;
	Sun, 16 Mar 2025 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="LdS/FM72";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VlnU/c45"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F0519F11F;
	Sun, 16 Mar 2025 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742166470; cv=none; b=KAzJHE+iO3ATKrfB4XdFR/UbYztWMGZmZM0RMqXzK108CTDHfaPZXvhflqgQ5E8YaRGx54skzb2PDgh3tGtS3wI/MUsJD4YjzmKAbYuIttuUOnaSLYMWtzA85vwYlHvlt6ToKE9I+q29gZdjXCT01UnVboSB59a5aJyunhMiWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742166470; c=relaxed/simple;
	bh=DPcp4gma1H5OBj+tYPGck3H4Vo4EpJNHz9faAlWZoo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3tXOsMwjbwh/dLFfgVTgsjRYcPKz1jQnQzdtfVWGqrZlGLK4A/Wzu4XyYalZeBYNrnI+axuDkpFekvixZ0ZFfmpk9bAqsRrPw/QB4FldsR+ig+Bpk3PCTNtJDqnZ9eZRPpEZgy2lQUMUskLralShN+FRQYmLF6FAva9xziOi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=LdS/FM72; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VlnU/c45; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A7BA1140120;
	Sun, 16 Mar 2025 19:07:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Sun, 16 Mar 2025 19:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1742166467; x=
	1742252867; bh=I3K6aSeQ1Zqsy/jvj7lz6b3ZWaQ4LfqC3auXDr51j9U=; b=L
	dS/FM72oNJ7UFKUdFnLt/Y9bRn9GyOEdumD+D7sNiQ00mxSsYnvtHGJgnvruNbvw
	U2TDQP4UA1+jI+nCyjEaaeJsOX+UQCPGblg4pY3HJ6OX4TchWt68R+ssN0x4bA6N
	jP+qlillf7OlNgmEbhutsR2XyNCMA1bizxOCBBSuma0Rkr2vRj+r8219q7Ymt+2Y
	yGN6sCDzLhhUkOzXC0yvK04FrgIXUHazZxt8OC8M27LTsm2oQDXvHJhfsQ8y5Prk
	GW12by9QyuP3PNTPvan3PLO3EfmIN5E6frMsjk7NdjK+t5MviIWB4DFFsA5ynmJj
	PoE/6syqkP7whOxDz5Q9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742166467; x=1742252867; bh=I
	3K6aSeQ1Zqsy/jvj7lz6b3ZWaQ4LfqC3auXDr51j9U=; b=VlnU/c45hYParCR2H
	Ot/sa6eNGZeKSkKu8tjnScvHp5oFTgZGc64nZ+sULQ0aFFWy/kfXFI8z1aIzFoCS
	rLBuea4FADcBgNCs+cgMf35h19GHWdqtWvrtFLPRkbm5rwHppLvlXvfA4rqX45Wk
	Lhtpeyd5xyDHkRpsc+mGVwa3nefzukaw70acxPlzDjJIVWN4BqT/vE6DwvXrGZPJ
	cGsA+QbtAVgKcEiSJSeG3HnOuLoR2v0bLGxE79j3wt3yVdxq9MgFtoW3tmdideLd
	9gNM351ERP4HaZk3tseRXtE24cbOvLqOoW1VH0uHNKhCiMEGadZZd/lZs9wXhFGM
	SJ+LQ==
X-ME-Sender: <xms:w1nXZ0hEYKydM7QRkROw-GttrZ6V12bEKOCQQDImFjETx_M8wE1Z2Q>
    <xme:w1nXZ9Deq4wUE3GmUvp4Dziz1eddwyE2GKt7DuRcs4EbpD5hukApkikEdA865v-HZ
    QCkoaHNNrwPk0yujTQ>
X-ME-Received: <xmr:w1nXZ8EWfQ4lxYm820bAd_LmO5lyb3VCtthZVi-nHYVBOXvWuLlbyQMFMxT5u_UkrNnY2dWpcXkZwd5oMw>
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
X-ME-Proxy: <xmx:w1nXZ1SCgyrwSqoHjl0t1tTVYSu9y5sBe2-6kaYxkUm15JFZpK_1Bg>
    <xmx:w1nXZxy6yXrxg9jVD9Wn8l4F0AuypcH5td4Zws6FLxS9tCh0sIT5LQ>
    <xmx:w1nXZz4C0N85oI2u0rXbKaoy2xFBysCph3hbN2WwFCAMfbj3kvZOwg>
    <xmx:w1nXZ-w5WnWxFkoHRXTSOUMAq1sn43CmQwdhQK-naxDWZnyCPsyT5A>
    <xmx:w1nXZ0qjB9maaGLEJaRaTf_s-XNwXyz6mwILsB5NchdIYsshIhfJleuq>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 19:07:44 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v7 4/8] platform/x86: asus-armoury: add apu-mem control support
Date: Mon, 17 Mar 2025 12:07:20 +1300
Message-ID: <20250316230724.100165-5-luke@ljones.dev>
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
index 449b2605b7e6..882376008093 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -389,6 +389,119 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj
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
@@ -409,6 +522,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
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
2.48.1


