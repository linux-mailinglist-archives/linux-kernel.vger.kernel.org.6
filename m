Return-Path: <linux-kernel+bounces-332481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8044497BA49
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFEAEB261CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE5718732F;
	Wed, 18 Sep 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="baSnv0UZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="efU4oCt+"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398917E00D;
	Wed, 18 Sep 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652595; cv=none; b=jkiBry3BAXkwcInfKZOyXyTryuYrUrIDkZp9AjH+LDjdbC7EuY+5z/OW/pE8WcvBzw1jt10pGpDems7es6ICdffPww6ewPWp61UF7r+Cfrt9YrmncCRSd65tDF7EtWFvUmbj5EzN7T1YF7qvBVYBf/2U+X5w1LoNpY/3wkb6EY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652595; c=relaxed/simple;
	bh=6FcN8yVxh1JABCb1bX3DgbBkyHCDjFrNP5Rg20anJjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfQBJn15j5Fv7PiiPY6uhb0tcF3mMxPQN1X8Fv+ANDVBuM+Toia1vkd4ixqQrDK2vHigYQpBr2TpHeM6/vRp4oWCLAQh0EkD7BTP3lD0q78rm5tjdeq40LjW7+Iv47366ggTCNVjnclAQztaZYqwkciKqFo50veRAnHW7U9znYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=baSnv0UZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=efU4oCt+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A8281380287;
	Wed, 18 Sep 2024 05:43:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 18 Sep 2024 05:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1726652592; x=
	1726738992; bh=MCXWMg3AniTIgg8n5sAZFI0xt0CFrvtZJijQH7DEbcI=; b=b
	aSnv0UZiPyYqb9g8/sQAvE5+xXW+TwdokpPd2xroWtAskBVPTz2NjGQCu51nbqIH
	k/N9BjjrkqB2s5GyOF3fMWMFc4vDpvjinRzQ3+eAtAy+D2m4XTed9W394AtGxcCx
	lvRTPFshp3vZ08mPKvMBjx665jbi6KmZu+gM4DmkSnp0/0ypNOc62UgBfXYo18oM
	FxxNidf28ECHameMQT6o2bos4lSdsyUq2m2V/6hXmeZcrb7UgOtkFZqRR9r3owEu
	h0uPiZfkRssuIoeAIFca5MN449g0REfN00fra/HEWh9egPcKdKgnVut0/ADUt1yi
	u/NNBUM8wD7NqhOksgB+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726652592; x=
	1726738992; bh=MCXWMg3AniTIgg8n5sAZFI0xt0CFrvtZJijQH7DEbcI=; b=e
	fU4oCt+m9otGfPAyZYkZWjfHeQyd0LE4SCPggTRCI2LDKQH7BKiaWDKEQGXj6RFG
	3/k9aJlIo636DaqY4MK1llkuOwluyBcTHH9EBwUApp3B+H+26bqAxqe4+ZUlbXiH
	iTfq4a9aZfcifFbbehoSIqkvoQKaBbtV9S9bWDIjz9IlVQEFSdrqHsyfR5ujZ0FB
	iyy7xQCcVHDX0FC2J6dwevroWAz/M0Q/L9AYy08IZM9YIZ4/6XSi/07MtlOfjV0Q
	on34FpZRHBb3+aiuHEPF4GoegG+hK6tRmRUhjEhPwVnSY7CbMqEvun01kWEFCuX5
	8KF7GNoHM2mAMNxnmuQyQ==
X-ME-Sender: <xms:sKDqZjcnFKLxtgflAsy1_JPKopgKDpOPEU2f4vpsk0YjLui74OIPLw>
    <xme:sKDqZpM4ej6QLucC9CnoenINzRRpPaMqSzcXEwkXKP2rS6fr6jJYpIRUZ4AaFJr2s
    Ei-mddSCDiY8NoBmv8>
X-ME-Received: <xmr:sKDqZsiAwgGTERSZf83OUB7oAIc3vJ4oN1h66J4x6isaMJeD-Qvnn93F7qjj2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgv
    shdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfe
    dugfetudeuheetjefhuefggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonh
    gvshdruggvvhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdp
    rhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdrtghomhdprhgtph
    htthhopehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:sKDqZk_xx-wvWajSOOCGrDjx3S495QF709ObZfOSQH6bL2TjUrNmCg>
    <xmx:sKDqZvt8Bqdb-3NKADAvazlrr6QcfiwhWggm8SfaEmzxWIyERuF5wQ>
    <xmx:sKDqZjFVV1RqDj8g4AN_PKn-jAa7KlUxYSKB93tkEeS0gFVVaw7MFA>
    <xmx:sKDqZmPdgtktfDAHcPuadMojc2aGWg9mQ1puVxE1fLvlpYovZNr47g>
    <xmx:sKDqZlXRNNHn56w1MjcNcN9CcswNYkdffBoK3K6SRLyL_k6XhbmYGI1c>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:43:09 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 4/5] platform/x86: asus-armoury: add core count control
Date: Wed, 18 Sep 2024 21:42:49 +1200
Message-ID: <20240918094250.82430-5-luke@ljones.dev>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240918094250.82430-1-luke@ljones.dev>
References: <20240918094250.82430-1-luke@ljones.dev>
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
 drivers/platform/x86/asus-armoury.c        | 219 +++++++++++++++++++++
 drivers/platform/x86/asus-armoury.h        |  28 +++
 include/linux/platform_data/x86/asus-wmi.h |   4 +
 3 files changed, 251 insertions(+)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index b276c42f98d8..c3193756eb08 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -40,6 +40,21 @@
 #define ASUS_MINI_LED_2024_STRONG 0x01
 #define ASUS_MINI_LED_2024_OFF 0x02
 
+#define ASUS_POWER_CORE_MASK GENMASK(15, 8)
+#define ASUS_PERF_CORE_MASK GENMASK(7, 0)
+
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
@@ -85,6 +100,13 @@ struct rog_tunables {
 	u32 dgpu_tgp_min;
 	u32 dgpu_tgp_max;
 	u32 dgpu_tgp;
+
+	u32 cur_perf_cores;
+	u32 min_perf_cores;
+	u32 max_perf_cores;
+	u32 cur_power_cores;
+	u32 min_power_cores;
+	u32 max_power_cores;
 };
 
 static const struct class *fw_attr_class;
@@ -143,6 +165,8 @@ static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
 static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
 {
 	return !strcmp(attr->attr.name, "gpu_mux_mode") ||
+	       !strcmp(attr->attr.name, "cores_performance") ||
+	       !strcmp(attr->attr.name, "cores_efficiency") ||
 	       !strcmp(attr->attr.name, "panel_hd_mode");
 }
 
@@ -569,6 +593,198 @@ static ssize_t apu_mem_possible_values_show(struct kobject *kobj, struct kobj_at
 }
 ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set the available system memory for the APU to use");
 
+static int init_max_cpu_cores(void)
+{
+	u32 cores;
+	int err;
+
+	asus_armoury.rog_tunables->min_perf_cores = 4;
+	asus_armoury.rog_tunables->max_perf_cores = 4;
+	asus_armoury.rog_tunables->cur_perf_cores = 4;
+	asus_armoury.rog_tunables->min_power_cores = 0;
+	asus_armoury.rog_tunables->max_power_cores = 8;
+	asus_armoury.rog_tunables->cur_power_cores = 8;
+
+	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES_MAX, &cores);
+	if (err)
+		return err;
+
+	cores &= ~ASUS_WMI_DSTS_PRESENCE_BIT;
+	asus_armoury.rog_tunables->max_power_cores = FIELD_GET(ASUS_POWER_CORE_MASK, cores);
+	asus_armoury.rog_tunables->max_perf_cores = FIELD_GET(ASUS_PERF_CORE_MASK, cores);
+
+	cores = 0;
+	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES, &cores);
+	if (err)
+		return err;
+
+	asus_armoury.rog_tunables->cur_perf_cores = FIELD_GET(ASUS_PERF_CORE_MASK, cores);
+	asus_armoury.rog_tunables->cur_power_cores = FIELD_GET(ASUS_POWER_CORE_MASK, cores);
+
+	return 0;
+}
+
+static ssize_t cores_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf,
+				enum cpu_core_type core_type, enum cpu_core_value core_value)
+{
+	u32 cores;
+
+	switch (core_value) {
+	case CPU_CORE_DEFAULT:
+	case CPU_CORE_MAX:
+		if (core_type == CPU_CORE_PERF)
+			return sysfs_emit(buf, "%d\n",
+					  asus_armoury.rog_tunables->max_perf_cores);
+		else
+			return sysfs_emit(buf, "%d\n",
+					  asus_armoury.rog_tunables->max_power_cores);
+	case CPU_CORE_MIN:
+		if (core_type == CPU_CORE_PERF)
+			return sysfs_emit(buf, "%d\n",
+					  asus_armoury.rog_tunables->min_perf_cores);
+		else
+			return sysfs_emit(buf, "%d\n",
+					  asus_armoury.rog_tunables->min_power_cores);
+	default:
+		break;
+	}
+
+	if (core_type == CPU_CORE_PERF)
+		cores = asus_armoury.rog_tunables->cur_perf_cores;
+	else
+		cores = asus_armoury.rog_tunables->cur_power_cores;
+
+	return sysfs_emit(buf, "%d\n", cores);
+}
+
+static ssize_t cores_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
+					 const char *buf, enum cpu_core_type core_type)
+{
+	int result, err;
+	u32 new_cores, perf_cores, powr_cores, out_val, min, max;
+
+	result = kstrtou32(buf, 10, &new_cores);
+	if (result)
+		return result;
+
+	if (core_type == CPU_CORE_PERF) {
+		perf_cores = new_cores;
+		powr_cores = out_val = asus_armoury.rog_tunables->cur_power_cores;
+		min = asus_armoury.rog_tunables->min_perf_cores;
+		max = asus_armoury.rog_tunables->max_perf_cores;
+	} else {
+		perf_cores = asus_armoury.rog_tunables->cur_perf_cores;
+		powr_cores = out_val = new_cores;
+		min = asus_armoury.rog_tunables->min_power_cores;
+		max = asus_armoury.rog_tunables->max_power_cores;
+	}
+
+	if (new_cores < min || new_cores > max)
+		return -EINVAL;
+
+	out_val = 0;
+	out_val |= FIELD_PREP(ASUS_PERF_CORE_MASK, perf_cores);
+	out_val |= FIELD_PREP(ASUS_POWER_CORE_MASK, powr_cores);
+
+	mutex_lock(&asus_armoury.mutex);
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CORES, out_val, &result);
+	mutex_unlock(&asus_armoury.mutex);
+
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
+						struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_MIN);
+}
+
+static ssize_t cores_performance_max_value_show(struct kobject *kobj,
+						struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_MAX);
+}
+
+static ssize_t cores_performance_default_value_show(struct kobject *kobj,
+						    struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_DEFAULT);
+}
+
+static ssize_t cores_performance_current_value_show(struct kobject *kobj,
+						    struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_CURRENT);
+}
+
+static ssize_t cores_performance_current_value_store(struct kobject *kobj,
+						     struct kobj_attribute *attr,
+						     const char *buf, size_t count)
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
+		    "Set the max available performance cores");
+
+static ssize_t cores_efficiency_min_value_show(struct kobject *kobj, struct kobj_attribute *attr,
+					       char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_MIN);
+}
+
+static ssize_t cores_efficiency_max_value_show(struct kobject *kobj, struct kobj_attribute *attr,
+					       char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_MAX);
+}
+
+static ssize_t cores_efficiency_default_value_show(struct kobject *kobj,
+						   struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_DEFAULT);
+}
+
+static ssize_t cores_efficiency_current_value_show(struct kobject *kobj,
+						   struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_CURRENT);
+}
+
+static ssize_t cores_efficiency_current_value_store(struct kobject *kobj,
+						    struct kobj_attribute *attr, const char *buf,
+						    size_t count)
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
+		    "Set the max available efficiency cores");
+
 /* Simple attribute creation */
 ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL, cpu_default,
 		       cpu_min, cpu_max, 1, "Set the CPU slow package limit");
@@ -625,6 +841,8 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
 	{ &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
 	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
+	{ &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
+	{ &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
 
 	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
@@ -807,6 +1025,7 @@ static int __init asus_fw_init(void)
 		return -ENOMEM;
 
 	init_rog_tunables(asus_armoury.rog_tunables);
+	init_max_cpu_cores();
 
 	err = asus_fw_attr_add();
 	if (err)
diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
index 95f4b6d8ab6b..9e61d5cbe0c7 100644
--- a/drivers/platform/x86/asus-armoury.h
+++ b/drivers/platform/x86/asus-armoury.h
@@ -165,6 +165,34 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
 		.name = _fsname, .attrs = _attrname##_attrs               \
 	}
 
+/* CPU core attributes need a little different in setup */
+#define ATTR_GROUP_CORES_RW(_attrname, _fsname, _dispname)              \
+	__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", 1);        \
+	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);    \
+	static struct kobj_attribute attr_##_attrname##_current_value = \
+		__ASUS_ATTR_RW(_attrname, current_value);               \
+	static struct kobj_attribute attr_##_attrname##_default_value = \
+		__ASUS_ATTR_RO(_attrname, default_value);               \
+	static struct kobj_attribute attr_##_attrname##_min_value =     \
+		__ASUS_ATTR_RO(_attrname, min_value);                   \
+	static struct kobj_attribute attr_##_attrname##_max_value =     \
+		__ASUS_ATTR_RO(_attrname, max_value);                   \
+	static struct kobj_attribute attr_##_attrname##_type =          \
+		__ASUS_ATTR_RO_AS(type, int_type_show);                 \
+	static struct attribute *_attrname##_attrs[] = {                \
+		&attr_##_attrname##_current_value.attr,                 \
+		&attr_##_attrname##_default_value.attr,                 \
+		&attr_##_attrname##_min_value.attr,                     \
+		&attr_##_attrname##_max_value.attr,                     \
+		&attr_##_attrname##_scalar_increment.attr,              \
+		&attr_##_attrname##_display_name.attr,                  \
+		&attr_##_attrname##_type.attr,                          \
+		NULL                                                    \
+	};                                                              \
+	static const struct attribute_group _attrname##_attr_group = {  \
+		.name = _fsname, .attrs = _attrname##_attrs             \
+	}
+
 /*
  * ROG PPT attributes need a little different in setup as they
  * require rog_tunables members.
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index e1aeafdf05d5..8964e601543a 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -134,6 +134,10 @@
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
2.46.1


