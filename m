Return-Path: <linux-kernel+bounces-275569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAEB948751
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9354284BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495AF29408;
	Tue,  6 Aug 2024 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="arwVxI6I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NgwEacaz"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603A3DF71;
	Tue,  6 Aug 2024 02:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910089; cv=none; b=R6QN38yB29KQRxm6qqDmCzaRcntyXPVeAkFlN1ZzAdzL7rPUoS51ViYKJNlc+ay5WYT8tCniU5o/NgmokRID5VXEoM3El/Ss/kEKzk4OZC96WWUjgDVLpSHxVVgRar+1OXSSVMHoeqxrT71P8QHtkd4k9aXmz7rWLXtexlJ/fYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910089; c=relaxed/simple;
	bh=uIB7/4OHAyBmfrbfmDDv3Vz80yUdMDj/O/p26M7mm3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qr+VOclbPgHt74KeHNB5l5oSvRLpm7Kvl9V0nOHx5Ww/wXW5vFj9dC6+putAJ8mMO9zWGFPSKo0t1GuBDbV5UlFywkpUoGhqTwkWPXAZ7tYMz0HyIUMLGN30IuI8hVdL0GNO0E9zO4vbWdT8UCOgObG+SzXPuCe7URyyxNj6z8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=arwVxI6I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NgwEacaz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 78A89138FC29;
	Mon,  5 Aug 2024 22:08:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 22:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1722910086; x=
	1722996486; bh=mGAnkWQ+s4jKoLerEH+XWqyzB+onfTH+kswNnPYw2NI=; b=a
	rwVxI6IAr5pGosyeZ0mtmpXd3PC+Xi7inR9DhEJN80LbpM+6EWXuTs6L89kxDuHc
	YTeF11rTH9f+4DWrzig9NhQ3hVAVSS+TtLRbNJSiI9h1Reanf2jtKDeowJ6ObuxL
	YW+sT8GtQCA3EccPq5eu5AZ16V58vlO47i68AtUirqaszghErWjgsVlO9P+V2otB
	87d2KGkKqyDM69JHUX8f8/alU97pbOknmK62iHbXdDKxpr/Z0l+ZUn5ijErL/zcu
	8gh9UKFJPB/1k0ubJ7IVKPRCNcq734xq886uF9TxYn3lHUGqnwAzupjPtTEZ8ms1
	VZxf0oQoD5R0VPZ+kkxrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722910086; x=
	1722996486; bh=mGAnkWQ+s4jKoLerEH+XWqyzB+onfTH+kswNnPYw2NI=; b=N
	gwEacazxcsomefO2b0McFUlpY3qKPN8WMILvDKLVjbz/pTYk5N07nD3C05pRZBC/
	5o8MGTDV4Sbo9fAJDCeHd3nEKPWj5KImnGBsJDlgRs6pKrMaioFh8duCqV8qr+7F
	wIcsai3DOwOI2nB90Nf5Y0ozuiPlzg7hftQUTjvmfmZBM9cpcJXZ4hXMNWRF9a3a
	SX+gxg7CHjOFk/1JdnolqnbKp00WR5il4zbBxV0KNh15QPQxpD2l1zppwHwzLyUb
	OqQYVZXMbgFWpuQGxEcJJCAtauJ5U4YbIFtXnGqu4OMSWifbJJdVIImiwKcuY/hU
	+R7J4mdgCYft4HGzCR9JA==
X-ME-Sender: <xms:hoWxZk-812Ek6YlUpyet8V0xLp9IQmM3zwLp6NIYmpC4eLi6HyrrAg>
    <xme:hoWxZstD1N6-cb1l7GPktyX_K5yTX7s5IVkYzbl87rZWlpq4QQPxUz5cm6NxLUfl4
    dC8PyOuNSJlP08Vq7I>
X-ME-Received: <xmr:hoWxZqCXzRWZ_oPmzgrBGXfmKHYG3bzm-2Db0UqKTNmohjYJAInH_I_ev5Pd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprh
    gtphhtthhopedt
X-ME-Proxy: <xmx:hoWxZke7JsvE9RKmPxTitBt0D25tJjSrbg79vq3peK2r1zAnppIunw>
    <xmx:hoWxZpNLd79PkwL-wAAQm1qEW3x6P8VoWv_Hu26cyEMGWKzS1JUpvg>
    <xmx:hoWxZunbG1qcrTA2v-bSul01BwlYZKOKQTw51j8pdYBsPS63zhpFIQ>
    <xmx:hoWxZruJ2aAZKmVY7Z3b5HYPr81yYm7RbJVntM_fzHxkzbshSeLpvw>
    <xmx:hoWxZs35stMNCEfgV0oJ8KkIuIjjNxoTwpQkdk_zkhrJ0LxlS90S16V4>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 22:08:03 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 3/6] platform/x86: asus-armoury: add dgpu tgp control
Date: Tue,  6 Aug 2024 14:07:44 +1200
Message-ID: <20240806020747.365042-4-luke@ljones.dev>
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

Implement the dgpu TGP control under the asus-armoury module using the
fw_attributes class.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-armoury.c        | 20 ++++++++++++++++++++
 drivers/platform/x86/asus-armoury.h        | 17 +++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +++
 3 files changed, 40 insertions(+)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index bb049ead00f9..31dbdacd8978 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -50,6 +50,9 @@
 #define NVIDIA_BOOST_MAX 25
 #define NVIDIA_TEMP_MIN 75
 #define NVIDIA_TEMP_MAX 87
+#define NVIDIA_POWER_MIN 0
+#define NVIDIA_POWER_MAX 70
+#define NVIDIA_POWER_DEFAULT 70
 
 /* Tunables provided by ASUS for gaming laptops */
 struct rog_tunables {
@@ -76,6 +79,11 @@ struct rog_tunables {
 	u32 nv_temp_min;
 	u32 nv_temp_max;
 	u32 nv_temp_target;
+
+	u32 dgpu_tgp_default;
+	u32 dgpu_tgp_min;
+	u32 dgpu_tgp_max;
+	u32 dgpu_tgp;
 };
 
 static const struct class *fw_attr_class;
@@ -474,6 +482,11 @@ ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_D
 ATTR_GROUP_ROG_TUNABLE(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
 		       nv_temp_default, nv_boost_min, nv_temp_max, 1,
 		       "Set the Nvidia max thermal limit");
+ATTR_GROUP_INT_VALUE_ONLY_RO(dgpu_base_tgp, "dgpu_base_tgp", ASUS_WMI_DEVID_DGPU_BASE_TGP,
+			     "Read the base TGP value");
+ATTR_GROUP_ROG_TUNABLE(dgpu_tgp, "dgpu_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP, dgpu_tgp_default,
+		       dgpu_tgp_min, dgpu_tgp_max, 1,
+		       "Set the additional TGP on top of the base TGP");
 
 ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
 		       "Show the current mode of charging");
@@ -501,6 +514,8 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &ppt_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
 	{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
 	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
+	{ &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
+	{ &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
 
 	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
@@ -660,6 +675,11 @@ static void init_rog_tunables(struct rog_tunables *rog)
 	rog->nv_temp_max = NVIDIA_TEMP_MIN;
 	rog->nv_temp_max = NVIDIA_TEMP_MAX;
 	rog->nv_temp_target = NVIDIA_TEMP_MIN;
+
+	rog->dgpu_tgp_default = NVIDIA_POWER_DEFAULT;
+	rog->dgpu_tgp_min = NVIDIA_POWER_MIN;
+	rog->dgpu_tgp_max = NVIDIA_POWER_MAX;
+	rog->dgpu_tgp = NVIDIA_POWER_MAX;
 }
 
 static int __init asus_fw_init(void)
diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
index 146170f91e69..96d991383b8a 100644
--- a/drivers/platform/x86/asus-armoury.h
+++ b/drivers/platform/x86/asus-armoury.h
@@ -83,6 +83,19 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
 	static struct kobj_attribute attr_##_attrname##_##_prop =                         \
 		__ASUS_ATTR_RO(_attrname, _prop)
 
+/* Requires current_value show&|store */
+#define __ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname)                             \
+	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);                           \
+	static struct kobj_attribute attr_##_attrname##_type =                                 \
+		__ASUS_ATTR_RO_AS(type, int_type_show);                                        \
+	static struct attribute *_attrname##_attrs[] = {                                       \
+		&attr_##_attrname##_current_value.attr, &attr_##_attrname##_display_name.attr, \
+		&attr_##_attrname##_type.attr, NULL                                            \
+	};                                                                                     \
+	static const struct attribute_group _attrname##_attr_group = {                         \
+		.name = _fsname, .attrs = _attrname##_attrs                                    \
+	}
+
 /* Boolean style enumeration, base macro. Requires adding show/store */
 #define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)                            \
 	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);                           \
@@ -97,6 +110,10 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
 		.name = _fsname, .attrs = _attrname##_attrs                                    \
 	}
 
+#define ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname) \
+	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                           \
+	__ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname)
+
 #define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname) \
 	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                 \
 	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index c164e656ae0b..3ce0c63be4c1 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -133,6 +133,9 @@
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


