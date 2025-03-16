Return-Path: <linux-kernel+bounces-563188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE14AA63800
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3063ADE08
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D501FAC5E;
	Sun, 16 Mar 2025 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="bAVbTFyS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f9JZbcia"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178281F4621;
	Sun, 16 Mar 2025 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742166483; cv=none; b=u102uHsvuzCz+BFwr/EJdvYsnZeR7lLiIzEWyrlnG4cmbL3k/K/hIoHetNQz+h7au2+ZwsnJWX5tF9TU1vMSEme9vnsYfvq1h256yWHHFWjFzYyZZAFK6k1qkU3WXDmjNafnn//LBKGortpbc4XVneKioCqiyuVVl6PrpVS2HBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742166483; c=relaxed/simple;
	bh=T3zHyRpnQkuklrDwADRbRsPwTeUl+rRDT/uC2+/js0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4UO8udUs/G615wgKR3fJvv+JzNkKw4RwcX8j+IyxrkQDaLkemummgvPAm+wrcylHc9qWqEUgKJyV2S+e0IRWieLy3i3lPlHXtjBY7bp/gLEy1uCV2qKG3iXnU1GkhnH6SiRX4wYmIQ2zLcBeTc4+vM4MKQGJb9+w8HX0Hmf6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=bAVbTFyS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f9JZbcia; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 01457254012D;
	Sun, 16 Mar 2025 19:07:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 16 Mar 2025 19:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1742166479; x=
	1742252879; bh=T1i2gx5VGhhH3xwtYDE40rmNDEw1Cuo4MaLBw25mF78=; b=b
	AVbTFyS70xY+vADJGJkHvKoSVL36qQkozneGjPBUqF28WzlxJDBBOLYwwMaJU7n2
	mEIQCbflUmnsVKQyDY9b6/3t+BKjCN1qVHcLeafVNKtzP1cHqBUko3hCCLKkA8TT
	gPFdVeq69JJZT0Tq2KJOF+uBuNNtWXmQlE0v3lM3Eomxr650+UpntbfOqmASCchh
	Yj9KdrMkrL52s1glzdOITCSaQYKtbiA3RlMj80yem1Ys54jmSMtDIZSC/MqH0TqY
	5309oTm4Xton1lScTO7IqV0M5z+fiuHWIt79i8M6v7dt9W3Qn7c/bwAOVXbM9N43
	ef3xdbY8dB+GX/+i/4b3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742166479; x=1742252879; bh=T
	1i2gx5VGhhH3xwtYDE40rmNDEw1Cuo4MaLBw25mF78=; b=f9JZbciaAIYchK6Ay
	gfMyqqBfC6SooA5d+2+3LUG9bpkzKnVlCLj70IjpWsw3Vff40dUn6C8fbVB2VRgH
	Hiq2PkNPNAHLgipqlC3ta/D5s5/30SRI2S2YdftEmJXAujLBxv0Kb5M/RSriaUZz
	KPYeDc2y6U+DUocn+aQLL1kWyqb6gHoDEytwQpSpw6cDYznZ4SxWtW+LHhQ3by+7
	FOPm/gBSw5t6/9UvzwpzguqMbpsoItyORP9CwpVpEi4hzM/cLDRjM58SV4yFvOUW
	I5JmeM5Ni/iDVCnY1gON0tTPEHb18lBG3vFBRQ/ONzEdcEbw4CX3pG9OtHu7Qj4u
	P1EVA==
X-ME-Sender: <xms:z1nXZ-xkKJ2CyvZsJtuAlBTRzP5S0wL9UxlXnEXi4l5u8yURsgqBOQ>
    <xme:z1nXZ6QcZS6gi7QET9GmFobGfi2eUE6otT5zz23ghKi4hP-ZvdeX4DW4CpOL_ue8X
    -1J1d54na7M2opIYqU>
X-ME-Received: <xmr:z1nXZwXiWC-_Xly48TyZ51lybaCn6n0z2lCXr5zfGtAxwwItnZsAYgeGsLGEiY48oHkO4g6vXNRHgr2etg>
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
X-ME-Proxy: <xmx:z1nXZ0gmaPvl1vZDBc8pHabvd0e8aWCO1WRwa_DQ-mbYzOPdp6BGpQ>
    <xmx:z1nXZwDBYJTCNC0d9WxtTay6URVNY5UuaoEmpA8cPDg169dvC81Gyw>
    <xmx:z1nXZ1LJfodGVs4l67sDSCBYyhwzOafmTke3jncBVxQzHXKi5uuf1w>
    <xmx:z1nXZ3D1EMAzqH8PKAQvrBr17On3WLDNSb6recKLqiTt1DkWegOLyg>
    <xmx:z1nXZ_5EYdfw5ohn5m-9222l1dhFXfUfbEfL4wxHyWZlTe2bY91HGTsU>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 19:07:57 -0400 (EDT)
From: Luke Jones <luke@ljones.dev>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v7 8/8] platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
Date: Mon, 17 Mar 2025 12:07:24 +1300
Message-ID: <20250316230724.100165-9-luke@ljones.dev>
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

Adds the ppt_* and nv_* tuning knobs that are available via WMI methods
and adds proper min/max levels plus defaults.

The min/max are defined by ASUS and typically gained by looking at what
they allow in the ASUS Armoury Crate application - ASUS does not share
the values outside of this. It could also be possible to gain the AMD
values by use of ryzenadj and testing for the minimum stable value.

The general rule of thumb for adding to the match table is that if the
model range has a single CPU used throughout, then the DMI match can
omit the last letter of the model number as this is the GPU model.

If a min or max value is not provided it is assumed that the particular
setting is not supported. for example ppt_pl2_sppt_min/max is not set.
If a <ppt_setting>_def is not set then the default is assumed to be
<ppt_setting>_max

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-armoury.c        |  217 +++-
 drivers/platform/x86/asus-armoury.h        | 1087 +++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |    3 +
 3 files changed, 1300 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index 591805f46725..5598da5295b8 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_data/x86/asus-wmi.h>
+#include <linux/power_supply.h>
 #include <linux/types.h>
 #include <linux/acpi.h>
 
@@ -67,11 +68,25 @@ struct cpu_cores {
 	u32 max_power_cores;
 };
 
+struct rog_tunables {
+	const struct power_data *tuning_limits;
+	u32 ppt_pl1_spl; // cpu
+	u32 ppt_pl2_sppt; // cpu
+	u32 ppt_pl3_fppt; // cpu
+	u32 ppt_apu_sppt; // plat
+	u32 ppt_platform_sppt; // plat
+
+	u32 nv_dynamic_boost;
+	u32 nv_temp_target;
+	u32 nv_tgp;
+};
+
 static struct asus_armoury_priv {
 	struct device *fw_attr_dev;
 	struct kset *fw_attr_kset;
 
 	struct cpu_cores *cpu_cores;
+	struct rog_tunables *rog_tunables;
 	u32 mini_led_dev_id;
 	u32 gpu_mux_dev_id;
 	/*
@@ -741,6 +756,26 @@ ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency",
 		    "Set the max available efficiency cores");
 
 /* Simple attribute creation */
+ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL,
+		       "Set the CPU slow package limit");
+ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, "ppt_pl2_sppt", ASUS_WMI_DEVID_PPT_PL2_SPPT,
+		       "Set the CPU fast package limit");
+ATTR_GROUP_ROG_TUNABLE(ppt_pl3_fppt, "ppt_pl3_fppt", ASUS_WMI_DEVID_PPT_FPPT,
+		       "Set the CPU fastest package limit");
+ATTR_GROUP_ROG_TUNABLE(ppt_apu_sppt, "ppt_apu_sppt", ASUS_WMI_DEVID_PPT_APU_SPPT,
+		       "Set the APU package limit");
+ATTR_GROUP_ROG_TUNABLE(ppt_platform_sppt, "ppt_platform_sppt", ASUS_WMI_DEVID_PPT_PLAT_SPPT,
+		       "Set the platform package limit");
+ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_DYN_BOOST,
+		       "Set the Nvidia dynamic boost limit");
+ATTR_GROUP_ROG_TUNABLE(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
+		       "Set the Nvidia max thermal limit");
+ATTR_GROUP_ROG_TUNABLE(nv_tgp, "dgpu_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP,
+		       "Set the additional TGP on top of the base TGP");
+ATTR_GROUP_INT_VALUE_ONLY_RO(nv_base_tgp, "nv_base_tgp", ASUS_WMI_DEVID_DGPU_BASE_TGP,
+			     "Read the base TGP value");
+
+
 ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
 		       "Show the current mode of charging");
 
@@ -767,6 +802,16 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
 	{ &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
 
+	{ &ppt_pl1_spl_attr_group, ASUS_WMI_DEVID_PPT_PL1_SPL },
+	{ &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_PPT_PL2_SPPT },
+	{ &ppt_pl3_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
+	{ &ppt_apu_sppt_attr_group, ASUS_WMI_DEVID_PPT_APU_SPPT },
+	{ &ppt_platform_sppt_attr_group, ASUS_WMI_DEVID_PPT_PLAT_SPPT },
+	{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
+	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
+	{ &nv_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
+	{ &nv_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
+
 	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
 	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
@@ -774,8 +819,64 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &panel_hd_mode_attr_group, ASUS_WMI_DEVID_PANEL_HD },
 };
 
+/**
+ * should_create_tunable_attr - Determines if a tunable attribute should be created
+ * @name: The name of the attribute
+ * @limits: Pointer to the power_limits structure containing limit values
+ *
+ * This function checks if a power-related tunable attribute should be created
+ * based on whether appropriate limit values are available. It also logs an error
+ * if the attribute should exist but is missing required limit values.
+ *
+ * Return: true if the attribute should be created, false otherwise
+ */
+static bool should_create_tunable_attr(const char *name,
+				       const struct power_limits *limits)
+{
+	bool is_tunable_attr = false;
+	bool has_limit = false;
+
+	if (!limits)
+		return false;
+
+	struct {
+		const char *attr_name;
+		u32 limit_value;
+	} limit_map[] = {
+		{ "ppt_pl1_spl", limits->ppt_pl1_spl_max },
+		{ "ppt_pl2_sppt", limits->ppt_pl2_sppt_max },
+		{ "ppt_pl3_fppt", limits->ppt_pl3_fppt_max },
+		{ "ppt_apu_sppt", limits->ppt_apu_sppt_max },
+		{ "ppt_platform_sppt", limits->ppt_platform_sppt_max },
+		{ "nv_dynamic_boost", limits->nv_dynamic_boost_max },
+		{ "nv_temp_target", limits->nv_temp_target_max },
+		{ "nv_base_tgp", limits->nv_tgp_max },
+		{ "dgpu_tgp", limits->nv_tgp_max },
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(limit_map); i++) {
+		if (!strcmp(name, limit_map[i].attr_name)) {
+			is_tunable_attr = true;
+			has_limit = limit_map[i].limit_value > 0;
+			break;
+		}
+	}
+
+	if (!is_tunable_attr)
+		return true;
+
+	if (!has_limit)
+		pr_err("Missing max value on %s for tunable: %s\n",
+		       dmi_get_system_info(DMI_BOARD_NAME), name);
+
+	return has_limit;
+}
+
 static int asus_fw_attr_add(void)
 {
+	const struct power_limits *limits;
+	bool should_create;
+	const char *name;
 	int err, i;
 
 	asus_armoury.fw_attr_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
@@ -832,12 +933,25 @@ static int asus_fw_attr_add(void)
 		if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
 			continue;
 
-		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
-					 armoury_attr_groups[i].attr_group);
-		if (err) {
-			pr_err("Failed to create sysfs-group for %s\n",
-			       armoury_attr_groups[i].attr_group->name);
-			goto err_remove_groups;
+		/* Always create by default, unless PPT is not present */
+		should_create = true;
+		name = armoury_attr_groups[i].attr_group->name;
+
+		/* Check if this is a power-related tunable requiring limits */
+		if (asus_armoury.rog_tunables && asus_armoury.rog_tunables->tuning_limits) {
+			limits = asus_armoury.rog_tunables->tuning_limits->ac_data;
+			should_create = should_create_tunable_attr(name, limits);
+		}
+
+		if (should_create) {
+			err = sysfs_create_group(
+				&asus_armoury.fw_attr_kset->kobj,
+				armoury_attr_groups[i].attr_group);
+			if (err) {
+				pr_err("Failed to create sysfs-group for %s\n",
+				       armoury_attr_groups[i].attr_group->name);
+				goto err_remove_groups;
+			}
 		}
 	}
 
@@ -866,6 +980,87 @@ static int asus_fw_attr_add(void)
 
 /* Init / exit ****************************************************************/
 
+/* Set up the min/max and defaults for ROG tunables */
+static bool init_rog_tunables(struct rog_tunables *rog)
+{
+	const struct dmi_system_id *dmi_id;
+	const struct power_data *power_data;
+	const struct power_limits *limits;
+
+	/* Match the system against the power_limits table */
+	dmi_id = dmi_first_match(power_limits);
+	if (!dmi_id) {
+		pr_warn("No matching power limits found for this system\n");
+		// rog->tuning_limits = &default_power_data;
+		rog->tuning_limits = NULL;
+		return false;
+	}
+
+	/* Get the power data for this system */
+	power_data = dmi_id->driver_data;
+	if (!power_data) {
+		pr_info("No power data available for this system\n");
+		return false;
+	}
+
+	/* Store the power limits for later use */
+	rog->tuning_limits = power_data;
+
+	if (power_supply_is_system_supplied()) {
+		limits = power_data->ac_data;
+		if (!limits) {
+			pr_warn("No AC power limits available\n");
+			return false;
+		}
+	} else {
+		limits = power_data->dc_data;
+		if (!limits) {
+			rog->ppt_pl1_spl = 0;
+			rog->ppt_pl2_sppt = 0;
+			rog->ppt_pl3_fppt = 0;
+			rog->ppt_apu_sppt = 0;
+			rog->ppt_platform_sppt = 0;
+			rog->nv_dynamic_boost = 0;
+			rog->nv_temp_target = 0;
+			rog->nv_tgp = 0;
+
+			pr_warn("No DC power limits available, initializing to 0\n");
+			return true;
+		}
+	}
+
+	/* Set initial values */
+	rog->ppt_pl1_spl = limits->ppt_pl1_spl_def ?
+			   limits->ppt_pl1_spl_def :
+			   limits->ppt_pl1_spl_max;
+
+	rog->ppt_pl2_sppt = limits->ppt_pl2_sppt_def ?
+			    limits->ppt_pl2_sppt_def :
+			    limits->ppt_pl2_sppt_max;
+
+	rog->ppt_pl3_fppt = limits->ppt_pl3_fppt_def ?
+			    limits->ppt_pl3_fppt_def :
+			    limits->ppt_pl3_fppt_max;
+
+	rog->ppt_apu_sppt = limits->ppt_apu_sppt_def ?
+			    limits->ppt_apu_sppt_def :
+			    limits->ppt_apu_sppt_max;
+
+	rog->ppt_platform_sppt = limits->ppt_platform_sppt_def ?
+				limits->ppt_platform_sppt_def :
+				limits->ppt_platform_sppt_max;
+
+	rog->nv_dynamic_boost = limits->nv_dynamic_boost_max;
+	rog->nv_temp_target = limits->nv_temp_target_max;
+	rog->nv_tgp = limits->nv_tgp_max;
+
+	pr_debug("Power limits initialized for %s (%s power)\n",
+		 dmi_id->matches[0].substr,
+		 power_supply_is_system_supplied() ? "AC" : "DC");
+
+	return true;
+}
+
 static int __init asus_fw_init(void)
 {
 	char *wmi_uid;
@@ -896,6 +1091,16 @@ static int __init asus_fw_init(void)
 		}
 	}
 
+	asus_armoury.rog_tunables = kzalloc(sizeof(struct rog_tunables), GFP_KERNEL);
+	if (!asus_armoury.rog_tunables)
+		return -ENOMEM;
+	/* Init logs warn/error and the driver should still be usable if init fails */
+	if (!init_rog_tunables(asus_armoury.rog_tunables)) {
+		kfree(asus_armoury.rog_tunables);
+		pr_err("Could not initialise PPT tunable control %d\n", err);
+	}
+
+	/* Must always be last step to ensure data is available */
 	err = asus_fw_attr_add();
 	if (err)
 		return err;
diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
index 584a75df113d..e61cf3fdb559 100644
--- a/drivers/platform/x86/asus-armoury.h
+++ b/drivers/platform/x86/asus-armoury.h
@@ -8,6 +8,7 @@
 #ifndef _ASUS_ARMOURY_H_
 #define _ASUS_ARMOURY_H_
 
+#include <linux/dmi.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
 
@@ -63,7 +64,6 @@
 	static struct kobj_attribute attr_##_attrname##_##_prop =		\
 		__ASUS_ATTR_RO(_attrname, _prop)
 
-
 #define __ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _dispname)\
 	WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);			\
 	static struct kobj_attribute attr_##_attrname##_current_value =		\
@@ -190,4 +190,1089 @@
 		.name = _fsname, .attrs = _attrname##_attrs		\
 	}
 
+#define ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname)	\
+	WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);			\
+	static struct kobj_attribute attr_##_attrname##_current_value =		\
+		__ASUS_ATTR_RO(_attrname, current_value);			\
+	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
+	static struct kobj_attribute attr_##_attrname##_type =			\
+		__ASUS_ATTR_RO_AS(type, int_type_show);				\
+	static struct attribute *_attrname##_attrs[] = {			\
+		&attr_##_attrname##_current_value.attr,				\
+		&attr_##_attrname##_display_name.attr,				\
+		&attr_##_attrname##_type.attr, NULL				\
+	};									\
+	static const struct attribute_group _attrname##_attr_group = {		\
+		.name = _fsname, .attrs = _attrname##_attrs			\
+	}
+
+/*
+ * ROG PPT attributes need a little different in setup as they
+ * require rog_tunables members.
+ */
+
+ #define __ROG_TUNABLE_SHOW(_prop, _attrname, _val)				\
+	static ssize_t _attrname##_##_prop##_show(				\
+		struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
+	{									\
+		const struct power_limits *limits;				\
+		limits = power_supply_is_system_supplied() ?			\
+			asus_armoury.rog_tunables->tuning_limits->ac_data :	\
+			asus_armoury.rog_tunables->tuning_limits->dc_data;	\
+		if (!limits)							\
+			return -ENODEV;						\
+		return sysfs_emit(buf, "%d\n", limits->_val);			\
+	}									\
+	static struct kobj_attribute attr_##_attrname##_##_prop =		\
+		__ASUS_ATTR_RO(_attrname, _prop)
+
+#define __ROG_TUNABLE_SHOW_DEFAULT(_attrname)					\
+	static ssize_t _attrname##_default_value_show(				\
+		struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
+	{									\
+		const struct power_limits *limits;				\
+		limits = power_supply_is_system_supplied() ?			\
+			asus_armoury.rog_tunables->tuning_limits->ac_data :	\
+			asus_armoury.rog_tunables->tuning_limits->dc_data;	\
+		if (!limits)							\
+			return -ENODEV;						\
+		return sysfs_emit(buf, "%d\n",					\
+				 limits->_attrname##_def ?			\
+				 limits->_attrname##_def :			\
+				 limits->_attrname##_max);			\
+	}									\
+	static struct kobj_attribute attr_##_attrname##_default_value =		\
+		__ASUS_ATTR_RO(_attrname, default_value)
+
+#define __ROG_TUNABLE_RW(_attr, _wmi)						\
+	static ssize_t _attr##_current_value_store(				\
+		struct kobject *kobj, struct kobj_attribute *attr,		\
+		const char *buf, size_t count)					\
+	{									\
+		const struct power_limits *limits;				\
+		limits = power_supply_is_system_supplied() ?			\
+			asus_armoury.rog_tunables->tuning_limits->ac_data :	\
+			asus_armoury.rog_tunables->tuning_limits->dc_data;	\
+		if (!limits)							\
+			return -ENODEV;						\
+		return attr_uint_store(kobj, attr, buf, count,			\
+				      limits->_attr##_min,			\
+				      limits->_attr##_max,			\
+				      &asus_armoury.rog_tunables->_attr,	\
+				      _wmi);					\
+	}									\
+	static ssize_t _attr##_current_value_show(				\
+		struct kobject *kobj, struct kobj_attribute *attr,		\
+		char *buf)							\
+	{									\
+		return sysfs_emit(buf, "%u\n",					\
+				  asus_armoury.rog_tunables->_attr);		\
+	}									\
+	static struct kobj_attribute attr_##_attr##_current_value =		\
+		__ASUS_ATTR_RW(_attr, current_value)
+
+#define ATTR_GROUP_ROG_TUNABLE(_attrname, _fsname, _wmi, _dispname)	\
+	__ROG_TUNABLE_RW(_attrname, _wmi);				\
+	__ROG_TUNABLE_SHOW_DEFAULT(_attrname);				\
+	__ROG_TUNABLE_SHOW(min_value, _attrname, _attrname##_min);	\
+	__ROG_TUNABLE_SHOW(max_value, _attrname, _attrname##_max);	\
+	__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", 1);	\
+	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
+	static struct kobj_attribute attr_##_attrname##_type =		\
+		__ASUS_ATTR_RO_AS(type, int_type_show);			\
+	static struct attribute *_attrname##_attrs[] = {		\
+		&attr_##_attrname##_current_value.attr,			\
+		&attr_##_attrname##_default_value.attr,			\
+		&attr_##_attrname##_min_value.attr,			\
+		&attr_##_attrname##_max_value.attr,			\
+		&attr_##_attrname##_scalar_increment.attr,		\
+		&attr_##_attrname##_display_name.attr,			\
+		&attr_##_attrname##_type.attr,				\
+		NULL							\
+	};								\
+	static const struct attribute_group _attrname##_attr_group = {	\
+		.name = _fsname, .attrs = _attrname##_attrs		\
+	}
+
+/* Default is always the maximum value unless *_def is specified */
+struct power_limits {
+	u8 ppt_pl1_spl_min;
+	u8 ppt_pl1_spl_def;
+	u8 ppt_pl1_spl_max;
+	u8 ppt_pl2_sppt_min;
+	u8 ppt_pl2_sppt_def;
+	u8 ppt_pl2_sppt_max;
+	u8 ppt_pl3_fppt_min;
+	u8 ppt_pl3_fppt_def;
+	u8 ppt_pl3_fppt_max;
+	u8 ppt_apu_sppt_min;
+	u8 ppt_apu_sppt_def;
+	u8 ppt_apu_sppt_max;
+	u8 ppt_platform_sppt_min;
+	u8 ppt_platform_sppt_def;
+	u8 ppt_platform_sppt_max;
+	/* Nvidia GPU specific, default is always max */
+	u8 nv_dynamic_boost_def; // unused. exists for macro
+	u8 nv_dynamic_boost_min;
+	u8 nv_dynamic_boost_max;
+	u8 nv_temp_target_def; // unused. exists for macro
+	u8 nv_temp_target_min;
+	u8 nv_temp_target_max;
+	u8 nv_tgp_def; // unused. exists for macro
+	u8 nv_tgp_min;
+	u8 nv_tgp_max;
+};
+
+struct power_data {
+		const struct power_limits *ac_data;
+		const struct power_limits *dc_data;
+		bool requires_fan_curve;
+};
+
+/*
+ * For each avilable attribute there must be a min and a max.
+ * _def is not required and will be assumed to be default == max if missing.
+ */
+static const struct dmi_system_id power_limits[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "FA401W"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 80,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_max = 80,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 80,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+				.nv_tgp_min = 55,
+				.nv_tgp_max = 75,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 30,
+				.ppt_pl2_sppt_min = 31,
+				.ppt_pl2_sppt_max = 44,
+				.ppt_pl3_fppt_min = 45,
+				.ppt_pl3_fppt_max = 65,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "FA507N"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 80,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_max = 80,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 80,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_def = 45,
+				.ppt_pl1_spl_max = 65,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_def = 54,
+				.ppt_pl2_sppt_max = 65,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 65,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "FA507R"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 80,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 80,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 80
+			},
+			.dc_data = NULL
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "FA507X"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 80,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_max = 80,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 80,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 20,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+				.nv_tgp_min = 55,
+				.nv_tgp_max = 85,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_def = 45,
+				.ppt_pl1_spl_max = 65,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_def = 54,
+				.ppt_pl2_sppt_max = 65,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 65,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "FA507Z"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 28,
+				.ppt_pl1_spl_max = 65,
+				.ppt_pl2_sppt_min = 28,
+				.ppt_pl2_sppt_max = 105,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 15,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+				.nv_tgp_min = 55,
+				.nv_tgp_max = 85,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 45,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_max = 60,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "FA607P"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 30,
+				.ppt_pl1_spl_def = 100,
+				.ppt_pl1_spl_max = 135,
+				.ppt_pl2_sppt_min = 30,
+				.ppt_pl2_sppt_def = 115,
+				.ppt_pl2_sppt_max = 135,
+				.ppt_pl3_fppt_min = 30,
+				.ppt_pl3_fppt_max = 135,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+				.nv_tgp_min = 55,
+				.nv_tgp_max = 115,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_def = 45,
+				.ppt_pl1_spl_max = 80,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_def = 60,
+				.ppt_pl2_sppt_max = 80,
+				.ppt_pl3_fppt_min = 25,
+				.ppt_pl3_fppt_max = 80,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "FA617NS"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_apu_sppt_min = 15,
+				.ppt_apu_sppt_max = 80,
+				.ppt_platform_sppt_min = 30,
+				.ppt_platform_sppt_max = 120
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_apu_sppt_min = 25,
+				.ppt_apu_sppt_max = 35,
+				.ppt_platform_sppt_min = 45,
+				.ppt_platform_sppt_max = 100
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "FA617NT"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_apu_sppt_min = 15,
+				.ppt_apu_sppt_max = 80,
+				.ppt_platform_sppt_min = 30,
+				.ppt_platform_sppt_max = 115
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_apu_sppt_min = 15,
+				.ppt_apu_sppt_max = 45,
+				.ppt_platform_sppt_min = 30,
+				.ppt_platform_sppt_max = 50
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "FA617XS"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_apu_sppt_min = 15,
+				.ppt_apu_sppt_max = 80,
+				.ppt_platform_sppt_min = 30,
+				.ppt_platform_sppt_max = 120,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_apu_sppt_min = 25,
+				.ppt_apu_sppt_max = 35,
+				.ppt_platform_sppt_min = 45,
+				.ppt_platform_sppt_max = 100,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "FX507Z"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 28,
+				.ppt_pl1_spl_max = 90,
+				.ppt_pl2_sppt_min = 28,
+				.ppt_pl2_sppt_max = 135,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 15,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 45,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_max = 60,
+			},
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GA401Q"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 80,
+				.ppt_pl2_sppt_min = 15,
+				.ppt_pl2_sppt_max = 80,
+			},
+			.dc_data = NULL
+		},
+	},
+	{
+		.matches = {
+			// This model is full AMD. No Nvidia dGPU.
+			DMI_MATCH(DMI_BOARD_NAME, "GA402R"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_apu_sppt_min = 15,
+				.ppt_apu_sppt_max = 80,
+				.ppt_platform_sppt_min = 30,
+				.ppt_platform_sppt_max = 115,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_apu_sppt_min = 25,
+				.ppt_apu_sppt_def = 30,
+				.ppt_apu_sppt_max = 45,
+				.ppt_platform_sppt_min = 40,
+				.ppt_platform_sppt_max = 60,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GA402X"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_def = 35,
+				.ppt_pl1_spl_max = 80,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_def = 65,
+				.ppt_pl2_sppt_max = 80,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 80,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 35,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 35,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 65,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GA403U"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 80,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 80,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 80,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+				.nv_tgp_min = 55,
+				.nv_tgp_max = 65,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 35,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 35,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 65,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GA503R"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_def = 35,
+				.ppt_pl1_spl_max = 80,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_def = 65,
+				.ppt_pl2_sppt_max = 80,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 80,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 20,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_def = 25,
+				.ppt_pl1_spl_max = 65,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_def = 54,
+				.ppt_pl2_sppt_max = 60,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 65
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GA605W"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 80,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_max = 80,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 80,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 20,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+				.nv_tgp_min = 55,
+				.nv_tgp_max = 85,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 35,
+				.ppt_pl2_sppt_min = 31,
+				.ppt_pl2_sppt_max = 44,
+				.ppt_pl3_fppt_min = 45,
+				.ppt_pl3_fppt_max = 65,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GU603Z"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 60,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 135,
+				/* Only allowed in AC mode */
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 20,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 40,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 40,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GU604V"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 65,
+				.ppt_pl1_spl_max = 120,
+				.ppt_pl2_sppt_min = 65,
+				.ppt_pl2_sppt_max = 150,
+				/* Only allowed in AC mode */
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 40,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_def = 40,
+				.ppt_pl2_sppt_max = 60,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GU605M"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 28,
+				.ppt_pl1_spl_max = 90,
+				.ppt_pl2_sppt_min = 28,
+				.ppt_pl2_sppt_max = 135,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 20,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 35,
+				.ppt_pl2_sppt_min = 38,
+				.ppt_pl2_sppt_max = 53,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GV301Q"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 45,
+				.ppt_pl2_sppt_min = 65,
+				.ppt_pl2_sppt_max = 80,
+			},
+			.dc_data = NULL
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GV301R"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 45,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 54,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 65,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 35,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 35,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 65,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GV601R"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_def = 35,
+				.ppt_pl1_spl_max = 90,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_def = 54,
+				.ppt_pl2_sppt_max = 100,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_def = 80,
+				.ppt_pl3_fppt_max = 125,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_def = 28,
+				.ppt_pl1_spl_max = 65,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_def = 54,
+				.ppt_pl2_sppt_def = 40,
+				.ppt_pl2_sppt_max = 60,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_def = 80,
+				.ppt_pl3_fppt_max = 65,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GV601V"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 28,
+				.ppt_pl1_spl_def = 100,
+				.ppt_pl1_spl_max = 110,
+				.ppt_pl2_sppt_min = 28,
+				.ppt_pl2_sppt_max = 135,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 20,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 40,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_def = 40,
+				.ppt_pl2_sppt_max = 60,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GX650P"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_def = 110,
+				.ppt_pl1_spl_max = 130,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_def = 125,
+				.ppt_pl2_sppt_max = 130,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_def = 125,
+				.ppt_pl3_fppt_max = 135,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_def = 25,
+				.ppt_pl1_spl_max = 65,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_def = 35,
+				.ppt_pl2_sppt_max = 65,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_def = 42,
+				.ppt_pl3_fppt_max = 65,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "G513I"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				/* Yes this laptop is very limited */
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 80,
+				.ppt_pl2_sppt_min = 15,
+				.ppt_pl2_sppt_max = 80,
+			},
+			.dc_data = NULL,
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "G513QM"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				/* Yes this laptop is very limited */
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 100,
+				.ppt_pl2_sppt_min = 15,
+				.ppt_pl2_sppt_max = 190,
+			},
+			.dc_data = NULL,
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "G513R"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 35,
+				.ppt_pl1_spl_max = 90,
+				.ppt_pl2_sppt_min = 54,
+				.ppt_pl2_sppt_max = 100,
+				.ppt_pl3_fppt_min = 54,
+				.ppt_pl3_fppt_max = 125,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 28,
+				.ppt_pl1_spl_max = 50,
+				.ppt_pl2_sppt_min = 28,
+				.ppt_pl2_sppt_max = 50,
+				.ppt_pl3_fppt_min = 28,
+				.ppt_pl3_fppt_max = 65,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "G614J"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 28,
+				.ppt_pl1_spl_max = 140,
+				.ppt_pl2_sppt_min = 28,
+				.ppt_pl2_sppt_max = 175,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 55,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 70,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "G634J"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 28,
+				.ppt_pl1_spl_max = 140,
+				.ppt_pl2_sppt_min = 28,
+				.ppt_pl2_sppt_max = 175,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 55,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 70,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "G733C"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 28,
+				.ppt_pl1_spl_max = 170,
+				.ppt_pl2_sppt_min = 28,
+				.ppt_pl2_sppt_max = 175,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 28,
+				.ppt_pl1_spl_max = 35,
+				.ppt_pl2_sppt_min = 28,
+				.ppt_pl2_sppt_max = 35,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "G733P"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 30,
+				.ppt_pl1_spl_def = 100,
+				.ppt_pl1_spl_max = 130,
+				.ppt_pl2_sppt_min = 65,
+				.ppt_pl2_sppt_def = 125,
+				.ppt_pl2_sppt_max = 130,
+				.ppt_pl3_fppt_min = 65,
+				.ppt_pl3_fppt_def = 125,
+				.ppt_pl3_fppt_max = 130,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 65,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 65,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 75,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "G814J"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 28,
+				.ppt_pl1_spl_max = 140,
+				.ppt_pl2_sppt_min = 28,
+				.ppt_pl2_sppt_max = 140,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 55,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 70,
+			},
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "G834J"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 28,
+				.ppt_pl1_spl_max = 140,
+				.ppt_pl2_sppt_min = 28,
+				.ppt_pl2_sppt_max = 175,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 25,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 55,
+				.ppt_pl2_sppt_min = 25,
+				.ppt_pl2_sppt_max = 70,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			},
+			.requires_fan_curve = true,
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "H7606W"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 15,
+				.ppt_pl1_spl_max = 80,
+				.ppt_pl2_sppt_min = 35,
+				.ppt_pl2_sppt_max = 80,
+				.ppt_pl3_fppt_min = 35,
+				.ppt_pl3_fppt_max = 80,
+				.nv_dynamic_boost_min = 5,
+				.nv_dynamic_boost_max = 20,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+				.nv_tgp_min = 55,
+				.nv_tgp_max = 85,
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 25,
+				.ppt_pl1_spl_max = 35,
+				.ppt_pl2_sppt_min = 31,
+				.ppt_pl2_sppt_max = 44,
+				.ppt_pl3_fppt_min = 45,
+				.ppt_pl3_fppt_max = 65,
+				.nv_temp_target_min = 75,
+				.nv_temp_target_max = 87,
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "RC71"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 7,
+				.ppt_pl1_spl_max = 30,
+				.ppt_pl2_sppt_min = 15,
+				.ppt_pl2_sppt_max = 43,
+				.ppt_pl3_fppt_min = 15,
+				.ppt_pl3_fppt_max = 53
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 7,
+				.ppt_pl1_spl_def = 15,
+				.ppt_pl1_spl_max = 25,
+				.ppt_pl2_sppt_min = 15,
+				.ppt_pl2_sppt_def = 20,
+				.ppt_pl2_sppt_max = 30,
+				.ppt_pl3_fppt_min = 15,
+				.ppt_pl3_fppt_def = 25,
+				.ppt_pl3_fppt_max = 35
+			}
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "RC72"),
+		},
+		.driver_data = &(struct power_data) {
+			.ac_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 7,
+				.ppt_pl1_spl_max = 30,
+				.ppt_pl2_sppt_min = 15,
+				.ppt_pl2_sppt_max = 43,
+				.ppt_pl3_fppt_min = 15,
+				.ppt_pl3_fppt_max = 53
+			},
+			.dc_data = &(struct power_limits) {
+				.ppt_pl1_spl_min = 7,
+				.ppt_pl1_spl_def = 17,
+				.ppt_pl1_spl_max = 25,
+				.ppt_pl2_sppt_min = 15,
+				.ppt_pl2_sppt_def = 24,
+				.ppt_pl2_sppt_max = 30,
+				.ppt_pl3_fppt_min = 15,
+				.ppt_pl3_fppt_def = 30,
+				.ppt_pl3_fppt_max = 35
+			}
+		},
+	},
+	{}
+};
+
 #endif /* _ASUS_ARMOURY_H_ */
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 92fea0710ada..bf53592e2a2f 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -145,6 +145,9 @@
 
 #define ASUS_WMI_DEVID_APU_MEM		0x000600C1
 
+#define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
+#define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
+
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
 #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026
-- 
2.48.1


