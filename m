Return-Path: <linux-kernel+bounces-332480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C5697BA47
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9079E2812D2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B211217A590;
	Wed, 18 Sep 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="nF4odvE/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RcWF3SNq"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B93217C98E;
	Wed, 18 Sep 2024 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652591; cv=none; b=D8383pbQsRvvqO8xNNY4CIdMago6y4HCwssm8f3+r2QqChJnUtBAhNZZjGC88JrOO8n9JSqmTjYoYpT3J3wp9vZRBtB3lTkkLfpl0GPFVQvQXUZYLByzFiBqcdu1zciRQoC3PaD9NODhCzyg2+GpOm5scdkiW0Ut1gxSAJy9vh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652591; c=relaxed/simple;
	bh=VT0m3eezUzU3V7rdY+HP3wIE3SdQ5Sy6YbXy9rUCsnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zj3SVENBcvTFFnbEowSaXKNfHyaCSNXgl4G12FIHNfHXkr+mWl/AX/9Yz3d4hm8rG850gMRfZEZlRd1DnNLHTa2IjKU6zKDT0GkaFyAKX1itUG6jgrd9JsIhbrH0DtmPUP5uE8G2hcQNlpudQVDjhPptxMWB1QhsR8k9CDe6aek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=nF4odvE/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RcWF3SNq; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 24033138028A;
	Wed, 18 Sep 2024 05:43:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 18 Sep 2024 05:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1726652589; x=
	1726738989; bh=XSqhaZRrF8nlqBRi3tnBg7UAs2mSNp3R+3DJs/HPZyw=; b=n
	F4odvE/XxXgZE4IBKrRlz5ks0LWcwaIasqT0o4LVBi9PRviI3n/P/Ei3VeQKPe67
	lH/0b9R6I235AGBMtnTn5wUBizywbgBAKSxjN39j1XdRl10IUBO7SP2vOc1zzuud
	YACW0Gz+/0yLUWs6Ls1pCU15vj9DEpH6E5CBrhRuraC3RQs0+nBB5TRYcyUu0cvJ
	GqBEr2V7/PmqW1v8u4xt1VMKvv+JUc/ol63ANOXnxMslvc4TzfPTKK2bW2Od2ISu
	z/+DOleM9ZNu0wO9gNFztVsE2ozx96cK2/SJzx786Jwetm2u56S9JoKWAqo+xMcV
	rv9rw1xHB1Ebg7MiL72Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726652589; x=
	1726738989; bh=XSqhaZRrF8nlqBRi3tnBg7UAs2mSNp3R+3DJs/HPZyw=; b=R
	cWF3SNqLMO3xQEh01d2NaleA6LL0ZMlvbuobXKhOaCrBSPoYrc3Bo3tOK5kYTRbk
	wA6e72d3PxFrtnJvZQ20+lb7G0p6MpL1LCdwT2OPvmYxeWOd9LmJPVfS5sZTaWX1
	vFHzFBUfejwLhaVYR0cGXO0vPUtqww6pKampyMZ9kmCpQ9W5U/PF5cDtkafWxRtX
	ZGGBbhfsV6e+3XusFEuM9kEpmAf4lwbXNUhseRLiLlgD8cZbedjy0+mh5SbLU43h
	VqB+zqxPM8WGtBua4FyTFnbrcY3Af+Z/rygFX55BpkaxZnepo1rH0jJORmEv56xP
	ipJBcwwUXSrSCDMc2rxyw==
X-ME-Sender: <xms:rKDqZsNXe0nU873ImLCEmutj-RmfppDc8OaIoiQNUKi7W5UjlGcI8g>
    <xme:rKDqZi-sF2QrK97TQzPcAWsKbQqPDMpR1gwxHZdP2eYfiXhTA7DBpJvCNVaN36aWa
    60QoseTvjFJbIYXF60>
X-ME-Received: <xmr:rKDqZjTieldSB41V5OAjGqVSZe2TdJmCLVxb_VCsqecBrbkL9h7cTR01ZR-lWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgv
    shdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfe
    dugfetudeuheetjefhuefggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonh
    gvshdruggvvhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdp
    rhgtphhtthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdrtghomhdprhgtph
    htthhopehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:rKDqZkt0YItAasUrJkr91VLaCizteyZw2XWvCEJcg71RwWJHiN214g>
    <xmx:rKDqZkeq9HsHOQFDNaLuyauqx0z-Swq24rDWDeKkDx9BHQEFYFeAPA>
    <xmx:rKDqZo3mgqRkVGExBBg0SfJgEmxmgp3uS-wM86YuM7pJZsPZ2dMPAw>
    <xmx:rKDqZo9peOkA46YcCh3ISEBrj91w5_fR67G0Neg_mcOYIahpSIBYsA>
    <xmx:raDqZpGj8t2nzVGZSt2N18uXnFhXa8Or-QxbiDeid9Uy1An5zsN0igXU>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:43:06 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 3/5] platform/x86: asus-armoury: add apu-mem control support
Date: Wed, 18 Sep 2024 21:42:48 +1200
Message-ID: <20240918094250.82430-4-luke@ljones.dev>
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

Implement the APU memory size control under the asus-armoury module using
the fw_attributes class.

This allows the APU allocated memory size to be adjusted depending on
the users priority. A reboot is required after change.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-armoury.c        | 114 +++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |   1 +
 2 files changed, 115 insertions(+)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index 176ab5f105dd..b276c42f98d8 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -456,6 +456,119 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj
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
+		/* This is out of order and looks wrong but is correct */
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
+ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set the available system memory for the APU to use");
+
 /* Simple attribute creation */
 ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL, cpu_default,
 		       cpu_min, cpu_max, 1, "Set the CPU slow package limit");
@@ -511,6 +624,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
 	{ &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
 	{ &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
+	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
 
 	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 86629e621c61..e1aeafdf05d5 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -136,6 +136,7 @@
 
 #define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
 #define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
+#define ASUS_WMI_DEVID_APU_MEM		0x000600C1
 
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
-- 
2.46.1


