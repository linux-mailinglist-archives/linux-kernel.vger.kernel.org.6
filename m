Return-Path: <linux-kernel+bounces-253350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84772931FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78B61C21885
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0491C286;
	Tue, 16 Jul 2024 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="ZNskx9A8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BXLM+s9l"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A25171B6;
	Tue, 16 Jul 2024 05:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721106994; cv=none; b=WUYhgOPKwy4krN+943R3PJFwSDav/UOf3HJ0rkVvX/i34I5lFci4he8TTz4wa0BnnmAKuMNvpLGgTZqmAhzms7EW6UPBV75jC+J4Uqeqktx8OojQGhgTtgXWdX2M52WOLSzOMpFP1R2jlZcxsEAIdm/gr5JESaNsP9A4V8OKMWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721106994; c=relaxed/simple;
	bh=kVBHoL0a1hn5tosJn62NP3TUtJzU1MATKYviN9QUuqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrM3Rvr1LGSGooifeAk7Agsxbfz641XoR7fL4K3HHEdMtNqAavmLpcWJbk1iGWSK4xFiaRf8UUGidQKjFuAEMEIzhceIRuvlPKjbjAQwaLILO+RxAvUq+5fFWGdT8WpgXlYh6OyexSyEXtls0H1Be1oiU9JFzpv+cadGXcTRDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=ZNskx9A8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BXLM+s9l; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 98CB81148192;
	Tue, 16 Jul 2024 01:16:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 16 Jul 2024 01:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1721106991; x=
	1721193391; bh=os4IplcbrDzZuEIlUycS4IwD7VzjoxuQbX4sX8i41T8=; b=Z
	Nskx9A8ZWiyJvv85PZe12Fc9QcQAcqaxwzF/UcLlZhzLXeZS6KLD71PofV4A3ojS
	gR1gzq2bPoh+kFSxYPUDQOunOsi2u9CVKD/wyre86dLe6FOXpv2ls4XpYG78lG5E
	ealVFJyu1eyYdP2vaaq1KCzS2OcMR2oKb6dRucv+IoWucFIYpzraVA8plkBu9lz3
	1SN8jqnp5w9u7KPBm8BKGo04o9TQWDb5a9C3gSLjsdv4VrDuT3e4GBbQK01tkm1m
	4SnXrQ7iMezSkWCe/NFOZ45BwUYP3n50dBUI4Y0c4jVQbQ6mROmtvNKZkvZMaTH7
	0LG9xp6XIC+IGaRwBWr6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721106991; x=
	1721193391; bh=os4IplcbrDzZuEIlUycS4IwD7VzjoxuQbX4sX8i41T8=; b=B
	XLM+s9lvNKwAdEYH3Rc2zt7ScjFyTP5At8W+3Hqdq5rXcuswwP97YkzxMjyF94pO
	kfP/m3hjit38S4y8+47vzvV+RgRLMOmuuiP9UjzNCqOX72XWxfbuRyoYPI9a4CuU
	r3fzggA3UOHFnDXvPZhdGFIOYvofONc5F0jXHLJQZCiZZ+8ubMrcynTsxpNaUKq4
	vIXa9v89BaMV6Ndc05StieA4mOZ/q3oNpvM9HVFBynzGoYQj8al+6a0y8yf9vCoZ
	cJRufyoOmv+3bK/3py8jFZxOnQ8dw2e4ov7euLCZUW5scVRIFTv9C2A0Kj10UpSl
	yAe8lWwEqKDt2ajaoz8qw==
X-ME-Sender: <xms:LgKWZrSukcUobEHCKHV2cVBvCxhFIgxpmSDgS3Llt09a4fXsEg8ykQ>
    <xme:LgKWZsw242-3neFHE_cUhGUuotz9fEjwJcxbzwVmtIEduY2lsyMa-mB21ybYDgto6
    HZogA7ijoIHp0txeQ0>
X-ME-Received: <xmr:LgKWZg31aSq01aPoAR7xffRi-kxP0T1vjmOoS-g6UIr37QdBxISwtuyHcYoG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeefgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:LgKWZrBwJrRj65eCqIuJNotrVxy5OYEb9JfxcMv0ys_otRrZzpxIOQ>
    <xmx:LgKWZkjfH_zJxukfr2uoi4ohYXiIFNnO4JBAE0q3r2YRqefjNc-m9g>
    <xmx:LgKWZvpdc8PqeSKwbhM25PzmnG6ISSD0RReXoM3BWFbreqdo81050Q>
    <xmx:LgKWZvgwo7-lta4j6bpinAGABbhLxvlf9Al2H28Uwe998iJaYAjX2Q>
    <xmx:LwKWZvUoWKIv_hcJlbJ18sjs5BVPTaGgHAfOBKz4rRhMdfs9qIY4Ee7R>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jul 2024 01:16:27 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	mario.limonciello@amd.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/5] platform/x86: asus-bioscfg: add dgpu tgp control
Date: Tue, 16 Jul 2024 17:16:09 +1200
Message-ID: <20240716051612.64842-3-luke@ljones.dev>
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

Implement the dgpu TGP control under the asus-bioscfg module using the
fw_attributes class.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-bioscfg.c        |  9 +++++++
 drivers/platform/x86/asus-bioscfg.h        | 30 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +++
 3 files changed, 42 insertions(+)

diff --git a/drivers/platform/x86/asus-bioscfg.c b/drivers/platform/x86/asus-bioscfg.c
index 0b34e727aab4..551b7dbd8fe7 100644
--- a/drivers/platform/x86/asus-bioscfg.c
+++ b/drivers/platform/x86/asus-bioscfg.c
@@ -52,6 +52,7 @@ MODULE_ALIAS("wmi:"ASUS_NB_WMI_EVENT_GUID);
 #define NVIDIA_BOOST_MAX	25
 #define NVIDIA_TEMP_MIN		75
 #define NVIDIA_TEMP_MAX		87
+#define NVIDIA_GPU_POWER_MAX	70
 
 /* Tunables provided by ASUS for gaming laptops */
 struct rog_tunables {
@@ -443,6 +444,10 @@ ATTR_GROUP_PPT_RW(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_DYN_BO
 		nv_boost_default, 5, nv_boost_max, 1, "Set the Nvidia dynamic boost limit");
 ATTR_GROUP_PPT_RW(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
 		nv_temp_default, 75, nv_temp_max, 1, "Set the Nvidia max thermal limit");
+ATTR_GROUP_INT_VALUE_ONLY_RO(dgpu_base_tgp, "dgpu_base_tgp", ASUS_WMI_DEVID_DGPU_BASE_TGP,
+		"Read the base TGP value")
+ATTR_GROUP_INT_RW(dgpu_tgp, "dgpu_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP,
+		70, 0, NVIDIA_GPU_POWER_MAX, 1, "Set the additional TGP on top of the base TGP");
 
 ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE,
 		"0;1;2", "Show the current mode of charging");
@@ -534,6 +539,10 @@ static int asus_fw_attr_add(void)
 		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &nv_dynamic_boost_attr_group);
 	if (asus_wmi_is_present(ASUS_WMI_DEVID_NV_THERM_TARGET))
 		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &nv_temp_target_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU_BASE_TGP))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &dgpu_base_tgp_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU_SET_TGP))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &dgpu_tgp_attr_group);
 
 	if (asus_wmi_is_present(ASUS_WMI_DEVID_CHARGE_MODE))
 		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &charge_mode_attr_group);
diff --git a/drivers/platform/x86/asus-bioscfg.h b/drivers/platform/x86/asus-bioscfg.h
index 403563c25f53..2da55a91ff0b 100644
--- a/drivers/platform/x86/asus-bioscfg.h
+++ b/drivers/platform/x86/asus-bioscfg.h
@@ -113,6 +113,22 @@ static ssize_t _attrname##_##_prop##_show(struct kobject *kobj,	\
 static struct kobj_attribute attr_##_attrname##_##_prop =	\
 	__ASUS_ATTR_RO(_attrname, _prop)
 
+/* Requires current_value show&|store */
+#define __ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname)	\
+__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
+static struct kobj_attribute attr_##_attrname##_type =			\
+			__ASUS_ATTR_RO_AS(type, int_type_show);		\
+static struct attribute *_attrname##_attrs[] = {			\
+				&attr_##_attrname##_current_value.attr,	\
+				&attr_##_attrname##_display_name.attr,	\
+				&attr_##_attrname##_type.attr,		\
+				NULL					\
+};									\
+static const struct attribute_group _attrname##_attr_group = {		\
+				.name = _fsname,			\
+				.attrs = _attrname##_attrs		\
+}
+
 /* Int style min/max range, base macro. Requires current_value show&|store */
 #define __ATTR_GROUP_INT(_attrname, _fsname, _default,		\
 				_min, _max, _incstep, _dispname)\
@@ -156,6 +172,20 @@ static const struct attribute_group _attrname##_attr_group = {		\
 		.attrs = _attrname##_attrs				\
 }
 
+#define ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname)	\
+do {										\
+	__ATTR_CURRENT_INT_RO(_attrname, _wmi);					\
+	__ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname);		\
+} while (0)
+
+#define ATTR_GROUP_INT_RW(_attrname, _fsname, _wmi, _default, _min,	\
+				_max, _incstep, _dispname)		\
+do {									\
+	__ATTR_CURRENT_INT_RW(_attrname, _min, _max, _wmi);		\
+	__ATTR_GROUP_INT(_attrname, _fsname, _default, _min, _max,	\
+				_incstep, _dispname);			\
+} while (0)
+
 #define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname)	\
 do {								\
 	__ATTR_CURRENT_INT_RO(_attrname, _wmi);			\
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 889336a932fb..c54264653d75 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -128,6 +128,9 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+#define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
+#define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
+
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
 #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026
-- 
2.45.2


