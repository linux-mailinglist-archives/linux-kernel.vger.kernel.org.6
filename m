Return-Path: <linux-kernel+bounces-253352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F06BC931FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A06B21F73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30273136A;
	Tue, 16 Jul 2024 05:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="LJ/awl6t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gd/tw/12"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40AA208A7;
	Tue, 16 Jul 2024 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721107002; cv=none; b=Cr3Tv2R/Yc6Mpf4F18JDOFqO6LoWTO6VmOtrLN51N+ceYUzpSWv69JpALdRPzn//zKG3oDjXjK9RSZIe/6X0zZCo4N9aQ8l5PcsN210sSC9N+po6quf5qb8+QNIlYFknuotJ2h18S9yAvMJGnc8ZWPHFhgoTkKj57k97cnUHo8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721107002; c=relaxed/simple;
	bh=nC/h2xMiX3CFha2GYZsJAieR8SfXmVUnVvXGWcYouHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRdK1EVFeA241WuwLQvfzUs6LWTNEwyoLUH3CQ8k8AiWH3DRodWrPgUBSwVdTX9sJGRGY02rxRq4K3lblXiqZDkU3JJxGOL6isswM6smXZpI//Um4zkEBeXAOmDiHAbJfHhyvIeiOucRpmXhu6fP30X2oMEUgC4ZRoNOFSUAfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=LJ/awl6t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gd/tw/12; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F18441148192;
	Tue, 16 Jul 2024 01:16:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 16 Jul 2024 01:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1721106999; x=
	1721193399; bh=lpiCVQlWuNbZED/VpbfVDoYEkNiM6qsQnVKc2UR+Dac=; b=L
	J/awl6tuW8df7XFh62wxV28/HZEo/5Cz1sU/4w60nAR6pNzbD+7+ke3QANXf1WkH
	1Xf4dMALSH0M6IfIB8qNF1/0o7HeO5cLj/WpxPDTeoSb4BUwX6geKTF5nVOoxqyj
	QnTGA0TbdDEqobaGxd7CakSLTjafuSPekrGvhnadtOaMUfu5WPYR8sG1TusIpTYE
	ET3Rfh3sl+0j/5UZwbUuKWM7MKvNVy8ruKXyAcMOjmt3X0iy9qL1F3T41tdzi0A7
	JZvERIj76B4ugYYqBwF6XN31Sx0muwxDfnO1tuN4o28dMX7eDUywI9g8+PcJaMMs
	brmiBwz5pqIT/xn1HDvWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721106999; x=
	1721193399; bh=lpiCVQlWuNbZED/VpbfVDoYEkNiM6qsQnVKc2UR+Dac=; b=G
	d/tw/12Zg0LDwGJaYEm0WM04Cz2NUEwwympleb4TyJPtl23dFz7NvuoCj6vX6PbL
	1P0WbyVtwSNcKJEGCgBFVAW10SoQoeWAFMkuyyjgEVm+01ik79APLS4nXad2rttD
	HIFSjdYeoQ/8IoDAwzPcffpzi0JYl4a6o0TPnGEs5q4db4NvofOc5OWLsJS/6Mru
	6KBr8nDvnUq2NcJ9oVbRXx/OxS9DJ/GXhR/AwkWjgWL+V+LdRHyyEHJV3Vk+uRve
	sgBJ/Eg57cleud+o7+IUpYlfqxdfACDziNEAvMCtg+Gz4vXRKM/bM3F2G3CHlwqA
	XkOrEpUHVdG/KGvjgwSbw==
X-ME-Sender: <xms:NgKWZjkE3SPSaJu68sni8gAovRDYcUQRDrUGicAn3mzszN89so-Hyw>
    <xme:NgKWZm0eaHHeuIZ-3qpLLio0lnDSYur2uG1WArZjXrgkaPaFENmhZSIreizR8Im9K
    xXZsKHp8bhzxZ7dpNA>
X-ME-Received: <xmr:NgKWZpo6h17y5lkwTzcWr1akHtCywJ3zI-w1G7M8R9PL8mfS4xLIDaJZKTMR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeefgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:NgKWZrm7FZVmX-e-Y2kZePG39ATz10FXMCeJPzW3d_mfcirTY77x4w>
    <xmx:NgKWZh3ouLmbIj_CFgbHbIq_SVynNcWf6BLNnA3edsLSHOyz2DyLOw>
    <xmx:NgKWZqt-59UeD45PItqmXx51f6ZqzpRXCdBCzHhl6D8djmPhBgAVdg>
    <xmx:NgKWZlUioJGLA2QHov8zU_oso4Vo7Uc4-8k2nkc-sAG_zGcgkUFhHQ>
    <xmx:NwKWZrrpZ8q3cR3_OtsA6CF7RB-Kku7hwjvkKoEd56C8m-MmSe2SX1aI>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jul 2024 01:16:35 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	mario.limonciello@amd.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 4/5] platform/x86: asus-bios: add core count control
Date: Tue, 16 Jul 2024 17:16:11 +1200
Message-ID: <20240716051612.64842-5-luke@ljones.dev>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716051612.64842-1-luke@ljones.dev>
References: <20240716051612.64842-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement Intel core enablement under the asus-bioscfg module using the
fw_attributes class.

This allows users to enable or disable preformance or efficiency cores
depending on their requirements. After change a reboot is required.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-bioscfg.c        | 206 +++++++++++++++++++++
 drivers/platform/x86/asus-bioscfg.h        |  29 +++
 include/linux/platform_data/x86/asus-wmi.h |   4 +
 3 files changed, 239 insertions(+)

diff --git a/drivers/platform/x86/asus-bioscfg.c b/drivers/platform/x86/asus-bioscfg.c
index 57efe50e0d19..6d39e45591e8 100644
--- a/drivers/platform/x86/asus-bioscfg.c
+++ b/drivers/platform/x86/asus-bioscfg.c
@@ -41,6 +41,18 @@ MODULE_ALIAS("wmi:"ASUS_NB_WMI_EVENT_GUID);
 #define ASUS_MINI_LED_2024_STRONG	0x01
 #define ASUS_MINI_LED_2024_OFF		0x02
 
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
 #define PPT_CPU_LIMIT_MIN	5
 #define PPT_CPU_LIMIT_MAX	150
@@ -75,6 +87,10 @@ struct rog_tunables {
 	u32 nv_temp_default;
 	u32 nv_temp_max;
 	u32 nv_temp_target;
+
+	u32 min_perf_cores;
+	u32 max_perf_cores;
+	u32 max_power_cores;
 };
 
 static const struct class *fw_attr_class;
@@ -540,6 +556,191 @@ static ssize_t apu_mem_possible_values_show(struct kobject *kobj,
 }
 ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set the available system memory for the APU to use");
 
+static int asus_bios_set_max_cores(void)
+{
+	u32 cores;
+	int err;
+
+	asus_bios.rog_tunables->min_perf_cores = 4;
+	asus_bios.rog_tunables->max_perf_cores = 4;
+	asus_bios.rog_tunables->max_power_cores = 8;
+
+	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES_MAX, &cores);
+	if (err)
+		return err;
+
+	cores &= ~ASUS_WMI_DSTS_PRESENCE_BIT;
+	asus_bios.rog_tunables->max_power_cores = (cores & 0xff00) >> 8;
+	asus_bios.rog_tunables->max_perf_cores = cores & 0xff;
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
+			return sysfs_emit(buf, "%d\n", asus_bios.rog_tunables->max_perf_cores);
+		else
+			return sysfs_emit(buf, "%d\n", asus_bios.rog_tunables->max_power_cores);
+	case CPU_CORE_MIN:
+		if (core_type == CPU_CORE_PERF)
+			return sysfs_emit(buf, "%d\n", asus_bios.rog_tunables->min_perf_cores);
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
+		min = asus_bios.rog_tunables->min_perf_cores;
+		max = asus_bios.rog_tunables->max_perf_cores;
+	} else {
+		min = 0;
+		max = asus_bios.rog_tunables->max_power_cores;
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
+		pr_warn("Failed to set perfromance core count: %d\n", err);
+		return err;
+	}
+
+	if (result > 1) {
+		pr_warn("Failed to set performance core count (result): 0x%x\n", result);
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
+ATTR_GROUP_CORES_RW(cores_performance, "cores_performance", ASUS_WMI_DEVID_CORES,
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
+ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency", ASUS_WMI_DEVID_CORES,
+		"Set the max available efficiency cores");
+
 /* Simple attribute creation */
 ATTR_GROUP_ENUM_INT_RW(thermal_policy, "thermal_policy", ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
 		0, 3, "0;1;2", "Set the thermal profile: 0=normal, 1=performance, 2=quiet");
@@ -636,6 +837,11 @@ static int asus_fw_attr_add(void)
 	if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU_CONNECTED))
 		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &egpu_connected_attr_group);
 
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_CORES_MAX) && !asus_bios_set_max_cores()) {
+		sysfs_create_group(&asus_bios.fw_attr_kset->kobj, &cores_performance_attr_group);
+		sysfs_create_group(&asus_bios.fw_attr_kset->kobj, &cores_efficiency_attr_group);
+	}
+
 	if (asus_wmi_is_present(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
 		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &thermal_policy_attr_group);
 	if (asus_wmi_is_present(ASUS_WMI_DEVID_PPT_PL1_SPL))
diff --git a/drivers/platform/x86/asus-bioscfg.h b/drivers/platform/x86/asus-bioscfg.h
index 2da55a91ff0b..bae1976eda3f 100644
--- a/drivers/platform/x86/asus-bioscfg.h
+++ b/drivers/platform/x86/asus-bioscfg.h
@@ -244,6 +244,35 @@ static const struct attribute_group _attrname##_attr_group = {		\
 			.attrs = _attrname##_attrs			\
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
 /* ROG PPT attributes need a little different in setup */
 #define ATTR_GROUP_PPT_RW(_attrname, _fsname, _wmi, _default,	\
 			_min, _max, _incstep, _dispname)	\
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index e3d511918416..d8f713ed3ea3 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -128,6 +128,10 @@
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


