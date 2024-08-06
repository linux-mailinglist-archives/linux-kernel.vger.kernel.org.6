Return-Path: <linux-kernel+bounces-275571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6C948756
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C666E1C221B2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E23BBF0;
	Tue,  6 Aug 2024 02:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="h1bVHYs2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="luPL4pqc"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897C38397;
	Tue,  6 Aug 2024 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910095; cv=none; b=MMygdhJw8QCEdHpn6bW4K++9+O83c+63ljwxQI86I6zkThs78qGW5fYhWV8TOUctUbZz/fq0IQ4fzXnSZN1MuUC0ttYTohgTmNwlJ+jm9HjAinK9WzyrvExs3mYEAj3bmvCTLGNR86aDvgHBiGA1GdivOkUiyNenpkHTDFLSGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910095; c=relaxed/simple;
	bh=kMqzAKEsG0EZcapDDZVghw91lFSIJx5D0VOn5BZ22O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QamBwO+AOmt0ri1zJchG6giCOJXKMzKeGU6T4jXu1RSidZ5ROLMvtiCqclWWWWGMSirFlBrFuxW2YZgEOOzA8GLLjPEPEkdVHWgu+riowyi4Ysuaqw+VHXhQK2v4GZ5t4XcPS8frd8nq7T3FXvfPa45qT0NXrsDoslq2CxYYXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=h1bVHYs2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=luPL4pqc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id DAEAF1385A02;
	Mon,  5 Aug 2024 22:08:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 05 Aug 2024 22:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1722910092; x=
	1722996492; bh=nCg2zpOayykf84IC3wUZ76xe5f8FcKwty3iTfzp3zAc=; b=h
	1bVHYs2q61q0lkq139G0dlTBF7AghtdGv+ZPiVDyIF7zt93f1V9wN3V+l55IzDDw
	d+7kkjAlKs7JL8K5A+tArhmb5JHwKzwyBebi6zKHaymEJIrYg1DAUl4pVOQh8L8r
	tUrM7Hcjo69UKh3yj38XABkLwUnfxuY7Ve+oqp9lp4v1SkTFqOjSDPAzFN1lYc3w
	98OT1P586OCERujKuzvhG988HYhi57LObcyY7aEyqNhwgd8jNCu3vA7ux8yVQ23m
	NgbGbquQckpi7U1IuW2cNTPe7vRnqHD/eH+5uXmbnps2HRm1Gir0R1xZagto21k3
	Uh4szTF3dPZpxtogEH4NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722910092; x=
	1722996492; bh=nCg2zpOayykf84IC3wUZ76xe5f8FcKwty3iTfzp3zAc=; b=l
	uPL4pqcZPS9YWwRB+I4a7iMpkD5fL0Rjg8igwV+y6DMTpx6530Z+dkskAI4GG1+Z
	/sz+6jCO9Y/il1Jm2i3h+idz+O7mTxIQ1qf5v8WmcnEWwNMMW8STUYch2XkMQ1iZ
	LmvRlLU+IAyRHQOGUHdtFX2JYD/0b42Vo5Zb6dqlfu01slNe/7sYSZ4CPszc3HJ0
	d2vovgaLRk2HbMk/Z5vS1SkXH3tC9tq5NokaoyRQdg63FMSEvdJKdEN64KU1cuRY
	x6iONivTSx+I9GUQV9uG7E5zK6ShB2I6m1NwVDZ117HqZMkddaYQKVkJYpqVRNwB
	IH3Xy7uwdHyz35YgdNhGQ==
X-ME-Sender: <xms:jIWxZlSh01pTYvMD38vZfyvNpPgUtZtdep2qUsxiyYxGpwsQk4tHkQ>
    <xme:jIWxZuxEc6g6iz_PCq4zdXcND6uVy7oMax7Bleglji-zbm_qsrGc8_FdWmG30pkV2
    Z1q6uZW-c5Xa3nNroY>
X-ME-Received: <xmr:jIWxZq248HEqqc6_rZrV2qzwLsTb3Bxk8vGcxMdCG4ipFmEag1Qrv4FBU9z->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprh
    gtphhtthhopedt
X-ME-Proxy: <xmx:jIWxZtB7yVPt8hUXibc6EP_QKV5U0sMwOD1ZDrcYjU1EnlShu8EoUg>
    <xmx:jIWxZuhbCnI_exFwZWAbQOUlYs85N8CJX5wM3ngjXscLP983lQoZiA>
    <xmx:jIWxZhouwkcbgcedILxZYsAna8bydmilC8NpYusvZ_ino26T_7tiNA>
    <xmx:jIWxZpiOroE3eztn2ptpVjigA72DN9wDzJbnxjnZnQpKXUJ2yry91Q>
    <xmx:jIWxZgYkQU3SKaux9Y1Up-17kk1AOmHHo-0j1tI94L0sjxz-Bxvb0Vim>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 22:08:09 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 5/6] platform/x86: asus-armoury: add core count control
Date: Tue,  6 Aug 2024 14:07:46 +1200
Message-ID: <20240806020747.365042-6-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806020747.365042-1-luke@ljones.dev>
References: <20240806020747.365042-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement Intel core enablement under the asus-armoury module using the
fw_attributes class.

This allows users to enable or disable preformance or efficiency cores
depending on their requirements. After change a reboot is required.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-armoury.c        | 208 ++++++++++++++++++++-
 drivers/platform/x86/asus-armoury.h        |  29 +++
 include/linux/platform_data/x86/asus-wmi.h |   4 +
 3 files changed, 240 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index 412e75c652a4..592ebea35ad5 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -39,6 +39,18 @@
 #define ASUS_MINI_LED_2024_STRONG 0x01
 #define ASUS_MINI_LED_2024_OFF 0x02
 
+enum cpu_core_type {
+	CPU_CORE_PERF = 0,
+	CPU_CORE_POWER,
+};
+
+enum cpu_core_value {
+	CPU_CORE_DEFAULT = 0,
+	CPU_CORE_MIN,
+	CPU_CORE_MAX,
+	CPU_CORE_CURRENT,
+};
+
 /* Default limits for tunables available on ASUS ROG laptops */
 #define PPT_CPU_LIMIT_MIN 5
 #define PPT_CPU_LIMIT_MAX 150
@@ -84,6 +96,10 @@ struct rog_tunables {
 	u32 dgpu_tgp_min;
 	u32 dgpu_tgp_max;
 	u32 dgpu_tgp;
+
+	u32 min_perf_cores;
+	u32 max_perf_cores;
+	u32 max_power_cores;
 };
 
 static const struct class *fw_attr_class;
@@ -148,7 +164,9 @@ static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
 static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
 {
 	return !strcmp(attr->attr.name, "gpu_mux_mode") ||
-	       !strcmp(attr->attr.name, "panel_hd_mode");
+		!strcmp(attr->attr.name, "cores_performance") ||
+		!strcmp(attr->attr.name, "cores_efficiency") ||
+		!strcmp(attr->attr.name, "panel_hd_mode");
 }
 
 /**
@@ -576,6 +594,191 @@ static ssize_t apu_mem_possible_values_show(struct kobject *kobj,
 }
 ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set the available system memory for the APU to use");
 
+static int init_max_cpu_cores(void)
+{
+	u32 cores;
+	int err;
+
+	asus_armoury.rog_tunables->min_perf_cores = 4;
+	asus_armoury.rog_tunables->max_perf_cores = 4;
+	asus_armoury.rog_tunables->max_power_cores = 8;
+
+	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES_MAX, &cores);
+	if (err)
+		return err;
+
+	cores &= ~ASUS_WMI_DSTS_PRESENCE_BIT;
+	asus_armoury.rog_tunables->max_power_cores = (cores & 0xff00) >> 8;
+	asus_armoury.rog_tunables->max_perf_cores = cores & 0xff;
+
+	return 0;
+}
+
+static ssize_t cores_value_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf,
+					enum cpu_core_type core_type,
+					enum cpu_core_value core_value)
+{
+	u32 cores;
+	int err;
+
+	switch (core_value) {
+	case CPU_CORE_DEFAULT:
+	case CPU_CORE_MAX:
+		if (core_type == CPU_CORE_PERF)
+			return sysfs_emit(buf, "%d\n", asus_armoury.rog_tunables->max_perf_cores);
+		else
+			return sysfs_emit(buf, "%d\n", asus_armoury.rog_tunables->max_power_cores);
+	case CPU_CORE_MIN:
+		if (core_type == CPU_CORE_PERF)
+			return sysfs_emit(buf, "%d\n", asus_armoury.rog_tunables->min_perf_cores);
+		else
+			return sysfs_emit(buf, "%d\n", 0);
+	default:
+	break;
+	}
+
+	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES, &cores);
+	if (err)
+		return err;
+
+	cores &= ~ASUS_WMI_DSTS_PRESENCE_BIT;
+	if (core_type == CPU_CORE_PERF)
+		cores &= 0xff;
+	else
+		cores = (cores & 0xff00) >> 8;
+	return sysfs_emit(buf, "%d\n", cores);
+}
+
+static ssize_t cores_current_value_store(struct kobject *kobj,
+				struct kobj_attribute *attr, const char *buf,
+				enum cpu_core_type core_type)
+{
+	int result, err;
+	u32 cores, currentv, min, max;
+
+	result = kstrtou32(buf, 10, &cores);
+	if (result)
+		return result;
+
+	if (core_type == CPU_CORE_PERF) {
+		min = asus_armoury.rog_tunables->min_perf_cores;
+		max = asus_armoury.rog_tunables->max_perf_cores;
+	} else {
+		min = 0;
+		max = asus_armoury.rog_tunables->max_power_cores;
+	}
+	if (cores < min || cores > max)
+		return -EINVAL;
+
+	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES, &currentv);
+	if (err)
+		return err;
+
+	if (core_type == CPU_CORE_PERF)
+		cores |= (currentv & 0xff00);
+	else
+		cores |= currentv & 0xff;
+
+	if (cores == currentv)
+		return 0;
+
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CORES, cores, &result);
+	if (err) {
+		pr_warn("Failed to set CPU core count: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set CPU core count (result): 0x%x\n", result);
+		return -EIO;
+	}
+
+	pr_info("CPU core count changed, reboot required\n");
+	sysfs_notify(kobj, NULL, attr->attr.name);
+	asus_set_reboot_and_signal_event();
+
+	return 0;
+}
+
+static ssize_t cores_performance_min_value_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_MIN);
+}
+
+static ssize_t cores_performance_max_value_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_MAX);
+}
+
+static ssize_t cores_performance_default_value_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_DEFAULT);
+}
+
+static ssize_t cores_performance_current_value_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_CURRENT);
+}
+
+static ssize_t cores_performance_current_value_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	int err;
+
+	err = cores_current_value_store(kobj, attr, buf, CPU_CORE_PERF);
+	if (err)
+		return err;
+
+	return count;
+}
+ATTR_GROUP_CORES_RW(cores_performance, "cores_performance",
+		"Set the max available performance cores");
+
+static ssize_t cores_efficiency_min_value_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_MIN);
+}
+
+static ssize_t cores_efficiency_max_value_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_MAX);
+}
+
+static ssize_t cores_efficiency_default_value_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_DEFAULT);
+}
+
+static ssize_t cores_efficiency_current_value_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_CURRENT);
+}
+
+static ssize_t cores_efficiency_current_value_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	int err;
+
+	err = cores_current_value_store(kobj, attr, buf, CPU_CORE_POWER);
+	if (err)
+		return err;
+
+	return count;
+}
+ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency",
+		"Set the max available efficiency cores");
+
 /* Simple attribute creation */
 ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL, cpu_default,
 		       cpu_min, cpu_max, 1, "Set the CPU slow package limit");
@@ -631,6 +834,8 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
 	{ &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
 	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
+	{ &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
+	{ &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
 
 	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
@@ -811,6 +1016,7 @@ static int __init asus_fw_init(void)
 		return -ENOMEM;
 	}
 	init_rog_tunables(asus_armoury.rog_tunables);
+	init_max_cpu_cores();
 
 	err = asus_fw_attr_add();
 	mutex_unlock(&asus_armoury.mutex);
diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
index 96d991383b8a..da585a180125 100644
--- a/drivers/platform/x86/asus-armoury.h
+++ b/drivers/platform/x86/asus-armoury.h
@@ -154,6 +154,35 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
 		.name = _fsname, .attrs = _attrname##_attrs                                    \
 	}
 
+/* CPU core attributes need a little different in setup */
+#define ATTR_GROUP_CORES_RW(_attrname, _fsname, _dispname)	\
+__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", 1);	\
+__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
+static struct kobj_attribute attr_##_attrname##_current_value = \
+	__ASUS_ATTR_RW(_attrname, current_value);		\
+static struct kobj_attribute attr_##_attrname##_default_value = \
+	__ASUS_ATTR_RO(_attrname, default_value);		\
+static struct kobj_attribute attr_##_attrname##_min_value =	\
+	__ASUS_ATTR_RO(_attrname, min_value);			\
+static struct kobj_attribute attr_##_attrname##_max_value =	\
+	__ASUS_ATTR_RO(_attrname, max_value);			\
+static struct kobj_attribute attr_##_attrname##_type =		\
+	__ASUS_ATTR_RO_AS(type, int_type_show);			\
+static struct attribute *_attrname##_attrs[] = {		\
+		&attr_##_attrname##_current_value.attr,		\
+		&attr_##_attrname##_default_value.attr,		\
+		&attr_##_attrname##_min_value.attr,		\
+		&attr_##_attrname##_max_value.attr,		\
+		&attr_##_attrname##_scalar_increment.attr,	\
+		&attr_##_attrname##_display_name.attr,		\
+		&attr_##_attrname##_type.attr,			\
+		NULL						\
+};								\
+static const struct attribute_group _attrname##_attr_group = {	\
+		.name = _fsname,				\
+		.attrs = _attrname##_attrs			\
+}
+
 /*
  * ROG PPT attributes need a little different in setup as they
  * require rog_tunables members.
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 287206a03763..2e7509ab5be0 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -133,6 +133,10 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+/* Intel E-core and P-core configuration in a format 0x0[E]0[P] */
+#define ASUS_WMI_DEVID_CORES		0x001200D2
+ /* Maximum Intel E-core and P-core availability */
+#define ASUS_WMI_DEVID_CORES_MAX	0x001200D3
 #define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
 #define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
 #define ASUS_WMI_DEVID_APU_MEM		0x000600C1
-- 
2.45.2


