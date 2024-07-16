Return-Path: <linux-kernel+bounces-253351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861B7931FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B65B21BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BDB1CD2D;
	Tue, 16 Jul 2024 05:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="q2Yq/Y0A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ebqTNwm/"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544621C694;
	Tue, 16 Jul 2024 05:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721106998; cv=none; b=mP9GLeMownvgb9v6Y3pI11OUYdLOmMNG9RJW06Rg7/xouxYcy9i71ASvYoOMq3l5nCDXOpdgRC3Lr6vbFU0DaW98cXkHK4c99+ji1VLmmXYhimTVKVYXkudy5LzqigUsueLuXaHZT4mTXqieDQmT6R1gdmtlre4vXYx0Y5hZoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721106998; c=relaxed/simple;
	bh=VSgKYAE0b5yms5EGLGnPhL7ZES3hs3rQUDedqEW2lGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrJOIYHIPfP2IrikenjRkaWmBpBjn6lZzXUsLj2ob9aWRCLeVHvPdz2KX36o5ALQ3nkuinl/uS6eJzw3Hl3MuLkSs9ZXZkZplc/n//zgNjIweziVuIkv69fCOxkU9sz+S7TPNm+Hw1hjgU98vN8m1M1y2clm4k45pVzwdJxAfxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=q2Yq/Y0A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ebqTNwm/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 74FBB1148222;
	Tue, 16 Jul 2024 01:16:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 16 Jul 2024 01:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1721106995; x=
	1721193395; bh=Vrpk0WmUrdl0T9kANZl3yc/HjsbcL1tlW2FMax2gsZw=; b=q
	2Yq/Y0APQsUSwBbECmtadPphq5SHQ31ASBaYKoEL4uI9xYcysxOm1t75loHYzhaA
	5ehdwhRCDVXQXkPuGtMkbyD9ch0Kl4XTGuLSMMAKVVe6P44oklHfDszzhgEsiS4P
	sRNTeOQyA9qW3bPjU+u/GP2eGrZga7Jf5GoEUeNCfBGFA6dGsLmusxUKdu0EkjUJ
	srLqj52c2YnE3N+Bc0Lh5FuLiBW//xw0IEA6L3CvDuO0UNUCYmwYajPI+wHTdvby
	gxuDw4E3HCuUIPfudFpGgp3QRcAeICETVX5JyI3zs5bccj4u00jbTvw1lP9oL+3x
	EjpCGaxZOxXhSIxxbbwBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721106995; x=
	1721193395; bh=Vrpk0WmUrdl0T9kANZl3yc/HjsbcL1tlW2FMax2gsZw=; b=e
	bqTNwm/DVc/D0yjXdRZddwzxslUwQ8EpgSXTwRUv0zjGF9XBiLYTE8LOtWBtMvyg
	78pFf19FBBwdsR3w3PrhK9Wn0SNw3D5wolkLsRTIs24CrONvB5J+FJCkTRyDRIyR
	kqNfjWbfGHy1sGwszza8EsVrGv4wPgtenkx49v13QutkZZB5gZbWoshUaBjWWUzQ
	oIlu6kO8SFcZdK/vMzGWZApUMqlaCc9gmeeAmf2WhHJ6J5fGKV+qafpz/wSNyC7Y
	eLuCVET0NLtPoShBrULTnfg8rOgraMcom7UCFnwg/tLwIvqGoz8wMql6Ty4ZdolN
	4f6vzMfpMl1PbQ1xRF7ZQ==
X-ME-Sender: <xms:MwKWZkjsjMZC72olb-ITvPOdqK5-5bliHguIvfSs-MdjBEvv35KLVg>
    <xme:MwKWZtBmn7DvBA-b6OyoyUIdWZH_nXHG2qBaQO2MVsoLqhJIjahB-lh8kwyBSVbCW
    F2Fa_cScQvcT7lxqs0>
X-ME-Received: <xmr:MwKWZsH-XYk5dkru-B0ut8yVT67TxNwSvVKW153uwgUR0kTzql8t211VEMrJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeefgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:MwKWZlRKtmwHz70_0KkQYatc5qM-nmx0NSCSmJQNh4vuAv6qejVEnQ>
    <xmx:MwKWZhziGKo8YQS0jk8hkulNTwb3JqZ0LlqKGI5YXORC9P9GPLEKCQ>
    <xmx:MwKWZj4KdAJLJoVhLuziHYUZRgvrmF4WqVtlYVPht_Kqg7xfVZ85Xw>
    <xmx:MwKWZuyhYfR-m55fTBJt6W0KVE_4T5hmIbdw56O83eGuE6nN0WlL2Q>
    <xmx:MwKWZonzrT87vXnRhR4R6kxIpyihXt4-3LtcIFOhcsJ4P_VGu7gMK46j>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jul 2024 01:16:31 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	mario.limonciello@amd.com,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 3/5] platform/x86: asus-bioscfg: add apu-mem control support
Date: Tue, 16 Jul 2024 17:16:10 +1200
Message-ID: <20240716051612.64842-4-luke@ljones.dev>
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

Implement the APU memory size control under the asus-bioscfg module using
the fw_attributes class.

This allows the APU allocated memory size to be adjusted depending on
the users priority. A reboot is required after change.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-bioscfg.c        | 116 +++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |   1 +
 2 files changed, 117 insertions(+)

diff --git a/drivers/platform/x86/asus-bioscfg.c b/drivers/platform/x86/asus-bioscfg.c
index 551b7dbd8fe7..57efe50e0d19 100644
--- a/drivers/platform/x86/asus-bioscfg.c
+++ b/drivers/platform/x86/asus-bioscfg.c
@@ -426,6 +426,120 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj,
 WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
 ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
 
+/* Device memory available to APU */
+
+static ssize_t apu_mem_current_value_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	int err;
+	u32 mem;
+
+	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_APU_MEM, &mem);
+	if (err)
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
+		/* This is out of order and looks wrong but is correct */
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
+static ssize_t apu_mem_current_value_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
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
+		/* This is outof order and looks wrong but is correct */
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
+	pr_info("APU memory changed to %dGB, reboot required\n", requested);
+	sysfs_notify(kobj, NULL, attr->attr.name);
+
+	asus_set_reboot_and_signal_event();
+
+	return count;
+}
+
+static ssize_t apu_mem_possible_values_show(struct kobject *kobj,
+					struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0;1;2;3;4;5;6;7;8\n");
+}
+ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set the available system memory for the APU to use");
+
 /* Simple attribute creation */
 ATTR_GROUP_ENUM_INT_RW(thermal_policy, "thermal_policy", ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
 		0, 3, "0;1;2", "Set the thermal profile: 0=normal, 1=performance, 2=quiet");
@@ -543,6 +657,8 @@ static int asus_fw_attr_add(void)
 		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &dgpu_base_tgp_attr_group);
 	if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU_SET_TGP))
 		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &dgpu_tgp_attr_group);
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_APU_MEM))
+		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &apu_mem_attr_group);
 
 	if (asus_wmi_is_present(ASUS_WMI_DEVID_CHARGE_MODE))
 		sysfs_create_group(&asus_bioscfg.fw_attr_kset->kobj, &charge_mode_attr_group);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index c54264653d75..e3d511918416 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -130,6 +130,7 @@
 
 #define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
 #define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
+#define ASUS_WMI_DEVID_APU_MEM		0x000600C1
 
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
-- 
2.45.2


