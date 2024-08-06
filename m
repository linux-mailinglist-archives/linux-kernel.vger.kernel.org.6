Return-Path: <linux-kernel+bounces-275570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A22948754
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185AD1C21F8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B51803A;
	Tue,  6 Aug 2024 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="OkI1M9yv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="he96+D3o"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5624F2E64A;
	Tue,  6 Aug 2024 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910093; cv=none; b=ezIDUHp6Ii4Kptn8GU+Kk+oGvVnkjVv7CAli6+UtQqWmkSAjUO8j6yqpKYAxaAUrTWpmL9/5lKCn46H4tuUQ4t6dv7gFzzbiNOcg3JwGWZlHNz67/RFsP3fOqoxh1HmHHiW+xgDylbil78AHUMAQkQtNdTqh/RLmKFM9w30mLfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910093; c=relaxed/simple;
	bh=Yu7VkjGSRNITKTPdFuKK6Vgg5Y+JRTpvaRBfxtRtOb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzFM71L7fSyPFZphCMom4+ExDhHXnobxTDBmURtbRuk6C7LUkIMweYMl/R51vAp7D2WrW0CQRtCIz8Zo/H4TAawCtxFBOAgqmu2S70o9F/f7oiaECNiez3MnJy4UmiXxVJLApVahURENk0pEVeRW5MTntltWuexJxU11GSPFU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=OkI1M9yv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=he96+D3o; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 907C8138FC36;
	Mon,  5 Aug 2024 22:08:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 05 Aug 2024 22:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1722910089; x=
	1722996489; bh=bBBcdwHVV+yQ+/NshzuL8M0iUusohPSYHkdYcEH7wUE=; b=O
	kI1M9yvJDFGAOE7v5+5U08CJL64ax4OzYbOi5NTDxuBDL/IqbpChdBTFpIS2g1ac
	tKeFyvr/K9hI3qh0ud6qO4dyp9/Ccscs0IABZ/M+20RIpocUsoitNYBF2MU7VFv5
	G6FUkYpwtnVC688SYI749W+B3SdWazzVHuIyzymrwO4/i9NX0C/3Ce97RWnvl8+H
	n1+KkGPXwuuVdZaCCPVkXputXNbGhbyBuKgWwCSe6mMotqOnO55aBViuPBrMKD9F
	HRT0DCkSsD+HkNaE0xL+1OEx+bwdfZb/yi/SaMATlvE797aq3kThe7QdSIUyP5P5
	9QuWFDMImvsEmq8EEpIIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722910089; x=
	1722996489; bh=bBBcdwHVV+yQ+/NshzuL8M0iUusohPSYHkdYcEH7wUE=; b=h
	e96+D3o5+Svz+bb37jeE2jPgktk7OT9pXVHOBsVgRG056tBBqJlT7KwZSHxpH6mP
	Y4z15ZYRkVlOAMwHCCR3Mmom1ey9KUaf7e9hJlQAvR6mWTgoVxRgw1LiihOOmDDE
	3b5Lk/HDpF06DuXml3zbR+zDeqfzvBpiQJP0aYISvvj8n9qSg2RBGIcPHWGbPo48
	WtuwBC8X23fzaSEpaVwi4tlu6ivnmwMtqYMwunsv7PsT5m2g8F94SuhncmA4MhCG
	1z6LtR6Von4V9ErvygEcNpWY/7c23sCrVwjqstQ2cvYG5y6a+6wevB2kyPFWPheo
	55HUMyHyWzVdBsO7gEVaQ==
X-ME-Sender: <xms:iYWxZprM5c0ppdpWcTefQl7ag8MizQijDqrC1AAqlXHoBfV7Igvzwg>
    <xme:iYWxZrqVmJLKpQDn-wufkWtR_6PDAqFrR3khj3tUBxJ5GIwT7o78E1OiaGiGk6135
    YfUu7ql_d2_0kElusU>
X-ME-Received: <xmr:iYWxZmM0VcxXxVf90a1QTdcuEwkSj6eNVwMGH6CWpJ2qpur5kZLKxjgF7ZsP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprh
    gtphhtthhopedt
X-ME-Proxy: <xmx:iYWxZk6sf_chg0d7L-S-OMM2vdymETlCMGXP9ZDpQrnzmCpXaA5hHw>
    <xmx:iYWxZo41Vs5u6HoUkfv12R4SqnhdPmWn3c8GsCMcl3KKbWrg1pR8nA>
    <xmx:iYWxZsj9oFIaZyCIfxvMoIOYoprZVtMR0yN0vak8l4Euik_Yfa5pYQ>
    <xmx:iYWxZq5Pi6lHO9leM29SkMx59uDA6QJLGb4MqlwXdSM5vsvN5gmTWQ>
    <xmx:iYWxZiTMFtZzfK2jiqW42H_gtSc2aZOooQ16lj0dB4FBNdShF4O0jnbQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 22:08:06 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 4/6] platform/x86: asus-armoury: add apu-mem control support
Date: Tue,  6 Aug 2024 14:07:45 +1200
Message-ID: <20240806020747.365042-5-luke@ljones.dev>
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

Implement the APU memory size control under the asus-armoury module using
the fw_attributes class.

This allows the APU allocated memory size to be adjusted depending on
the users priority. A reboot is required after change.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-armoury.c        | 115 +++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |   1 +
 2 files changed, 116 insertions(+)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index 31dbdacd8978..412e75c652a4 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -462,6 +462,120 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj,
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
 ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL, cpu_default,
 		       cpu_min, cpu_max, 1, "Set the CPU slow package limit");
@@ -516,6 +630,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
 	{ &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
 	{ &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
+	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
 
 	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 3ce0c63be4c1..287206a03763 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -135,6 +135,7 @@
 
 #define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
 #define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
+#define ASUS_WMI_DEVID_APU_MEM		0x000600C1
 
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
-- 
2.45.2


