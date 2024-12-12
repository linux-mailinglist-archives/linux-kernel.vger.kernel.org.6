Return-Path: <linux-kernel+bounces-443156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359EF9EE812
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5B5164187
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1482135B8;
	Thu, 12 Dec 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b="bTXjFNYi"
Received: from 9.mo576.mail-out.ovh.net (9.mo576.mail-out.ovh.net [46.105.56.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6B748D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.56.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011612; cv=none; b=aA2kgW78mqPsRg7rUNrjZqGO50rMEj1Z/EVF4f9zwBhTjxASTxTs9PW3zTFRwbHl7Jv/vnRg1mrkXXDWqyxCt5/+LUG7/3aelJKiqaRaVZlYIDla6UlLlpUGJu2y6mtng/gEvlNq3H7Dd+GxH0VBgB2XIviH2VwKATv+DwkqI5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011612; c=relaxed/simple;
	bh=1G2mtL02KUbGHH9ay/jOX9OfIw+Z2yy9HuJiwxSEs/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub8Ms5B5ipYLglPR82QUroURvtlm0mUoekbE7tKUFlY94ezKBgI16vmXeLf+u7FIV6YcjRV+CtqH4I61bn0kI779QylwduqO1NnAVANI5p3b2HQj4cVjqI0vKCNG3ULlmqjoXprIl0r4h3PpjK0ZVRfzPKlWoGmSDO+LlR1gfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com; spf=pass smtp.mailfrom=3mdeb.com; dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b=bTXjFNYi; arc=none smtp.client-ip=46.105.56.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3mdeb.com
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.2.118])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4Y8D4V4Sxsz25HD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:38 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-79qrm (unknown [10.111.182.135])
	by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 8F8311FE86;
	Thu, 12 Dec 2024 13:35:37 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.99])
	by ghost-submission-5b5ff79f4f-79qrm with ESMTPSA
	id Pg5uEanmWmfX+gAATbHdbw
	(envelope-from <sergii.dmytruk@3mdeb.com>); Thu, 12 Dec 2024 13:35:37 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-99G003f5c78bee-7e33-41a5-98a2-9511c4648276,
                    B639BF7A6EC39DD0505FDBB1524E94DB3A46F08D) smtp.auth=sergii.dmytruk@3mdeb.com
X-OVh-ClientIp:176.111.183.174
From: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
To: linux-kernel@vger.kernel.org
Cc: trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 7/9] x86/slmodule: Support AMD SKINIT
Date: Thu, 12 Dec 2024 15:35:05 +0200
Message-ID: <c6e6a2fbb38a12792fd5fd1b1bef9f47f6de5b46.1734008878.git.sergii.dmytruk@3mdeb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
References: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16621097375510738076
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgvrhhgihhiucffmhihthhruhhkuceoshgvrhhgihhirdgumhihthhruhhkseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpefhheefheduieelieekfffgfffgfedutdevleevvdfhfffgledvgfdtuddtheefieenucfkphepuddvjedrtddrtddruddpudejiedrudduuddrudekfedrudejgedpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehsvghrghhiihdrughmhihtrhhukhesfehmuggvsgdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=WscS++gTG5tR066MMBqGaj3HnvUFVC8E7T23uGPENpw=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1734010538; v=1;
 b=bTXjFNYi/0ZNzRcb8+EJf4pITjlMl7xQHe+gwJRIMfh5gAgKgHdyN8GjVV/nko4SYoMmwOyZ
 L8/92Yz4WM/7sEWOdpqqHR1aj0TklPHOHNVNOVAEjHkXKMO7RhDJAaCsGg5cLANErpihJZJb6rT
 nzyHEYdI0LDp5NXvMghKSHV5LuVjX4FtgpYqXDm0dw4S861jxcOKZoiklozLyW0M4QLOnPejpoP
 1q+bmzDOJmGVIsk1yPApea11dD+nPDNDTD4+7c85/onQP496Lm9eKnFz3OVQVDmdwyr993JZTmw
 +v8QmJG835eyR0POt+GwBNpZtSRevrUUIIWk4kAKykz4A==

From: Ross Philipson <ross.philipson@oracle.com>

Some of the changes are related to generalization: common macro for
resetting the platform. The rest are:
 - SKINIT-specific way of getting to SLRT
 - handling of TPM log which has TXT-specific header embedded as vendor
   data of a TCG-compliant one

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
---
 arch/x86/kernel/slmodule.c | 158 ++++++++++++++++++++++++++++++-------
 1 file changed, 131 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
index 6f85c43c4d3e..9d5c23c185fb 100644
--- a/arch/x86/kernel/slmodule.c
+++ b/arch/x86/kernel/slmodule.c
@@ -18,12 +18,21 @@
 #include <linux/security.h>
 #include <linux/memblock.h>
 #include <linux/tpm.h>
+#include <asm/setup.h>
 #include <asm/segment.h>
 #include <asm/sections.h>
 #include <crypto/sha2.h>
 #include <linux/slr_table.h>
 #include <linux/slaunch.h>
 
+#define slaunch_reset(t, m, e)					\
+	do {							\
+		if (t)						\
+			slaunch_txt_reset(t, m, e);		\
+		else						\
+			slaunch_skinit_reset(m, e);		\
+	} while (0)
+
 /*
  * The macro DECLARE_TXT_PUB_READ_U is used to read values from the TXT
  * public registers as unsigned values.
@@ -83,6 +92,7 @@ struct memfile {
 
 static struct memfile sl_evtlog = {"eventlog", NULL, 0};
 static void *txt_heap;
+static void *skinit_evtlog;
 static struct txt_heap_event_log_pointer2_1_element *evtlog21;
 static DEFINE_MUTEX(sl_evt_log_mutex);
 
@@ -238,12 +248,19 @@ static void slaunch_teardown_securityfs(void)
 			memunmap(txt_heap);
 			txt_heap = NULL;
 		}
+	} else if (slaunch_get_flags() & SL_FLAG_ARCH_SKINIT) {
+		if (skinit_evtlog) {
+			memunmap(skinit_evtlog);
+			skinit_evtlog = NULL;
+		}
+		sl_evtlog.addr = NULL;
+		sl_evtlog.size = 0;
 	}
 
 	securityfs_remove(slaunch_dir);
 }
 
-static void slaunch_intel_evtlog(void __iomem *txt)
+static void slaunch_txt_evtlog(void __iomem *txt)
 {
 	struct slr_entry_log_info *log_info;
 	struct txt_os_mle_data *params;
@@ -308,6 +325,85 @@ static void slaunch_intel_evtlog(void __iomem *txt)
 				  SL_ERROR_TPM_INVALID_LOG20);
 }
 
+static void slaunch_skinit_evtlog(void)
+{
+	struct slr_entry_amd_info amd_info_temp;
+	struct slr_entry_amd_info *amd_info;
+	struct slr_entry_log_info *log_info;
+	struct setup_data *data;
+	struct slr_table *slrt;
+	u64 pa_data;
+
+	pa_data = (u64)boot_params.hdr.setup_data;
+	amd_info = NULL;
+
+	while (pa_data) {
+		data = (struct setup_data *)memremap(pa_data, sizeof(*data), MEMREMAP_WB);
+		if (!data)
+			slaunch_skinit_reset("Error failed to memremap setup data\n",
+					     SL_ERROR_MAP_SETUP_DATA);
+
+		if (data->type == SETUP_SECURE_LAUNCH) {
+			memunmap(data);
+			amd_info = (struct slr_entry_amd_info *)
+				memremap(pa_data - sizeof(struct slr_entry_hdr),
+					 sizeof(*amd_info), MEMREMAP_WB);
+			if (!amd_info)
+				slaunch_skinit_reset("Error failed to memremap AMD info\n",
+						     SL_ERROR_MAP_SETUP_DATA);
+			break;
+		}
+
+		pa_data = data->next;
+		memunmap(data);
+	}
+
+	if (!amd_info)
+		slaunch_skinit_reset("Error failed to find AMD info\n", SL_ERROR_MISSING_EVENT_LOG);
+
+	amd_info_temp = *amd_info;
+	memunmap(amd_info);
+
+	/* Get the SLRT and remap it */
+	slrt = memremap(amd_info_temp.slrt_base, amd_info_temp.slrt_size, MEMREMAP_WB);
+	if (!slrt)
+		slaunch_skinit_reset("Error failed to memremap SLR Table\n", SL_ERROR_SLRT_MAP);
+
+	log_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
+	if (!log_info)
+		slaunch_skinit_reset("Error failed to find event log info SLR Table\n",
+				     SL_ERROR_SLRT_MISSING_ENTRY);
+
+	/* Finally map the actual event log and find the proper offsets */
+	skinit_evtlog = memremap(log_info->addr, log_info->size, MEMREMAP_WB);
+	if (!skinit_evtlog)
+		slaunch_skinit_reset("Error failed to memremap TPM event log\n",
+				     SL_ERROR_EVENTLOG_MAP);
+
+	sl_evtlog.size = log_info->size;
+	sl_evtlog.addr = skinit_evtlog;
+
+	memunmap(slrt);
+
+	/*
+	 * See the comment for the following function concerning the
+	 * logic used here:
+	 * arch/x86/boot/compressed/sl_main.c:sl_find_event_log()
+	 */
+	if (!memcmp(skinit_evtlog + sizeof(struct tcg_pcr_event),
+		    TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG))) {
+		evtlog21 = skinit_evtlog + sizeof(struct tcg_pcr_event)
+			+ TCG_EfiSpecIdEvent_SIZE(
+			  TPM2_HASH_COUNT(skinit_evtlog
+				+ sizeof(struct tcg_pcr_event)));
+	} else {
+		sl_evtlog.addr += sizeof(struct tcg_pcr_event)
+			+ TCG_PCClientSpecIDEventStruct_SIZE;
+		sl_evtlog.size -= sizeof(struct tcg_pcr_event)
+			+ TCG_PCClientSpecIDEventStruct_SIZE;
+	}
+}
+
 static void slaunch_tpm2_extend_event(struct tpm_chip *tpm, void __iomem *txt,
 				      struct tcg_pcr_event2_head *event)
 {
@@ -320,8 +416,7 @@ static void slaunch_tpm2_extend_event(struct tpm_chip *tpm, void __iomem *txt,
 	digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests),
 			  GFP_KERNEL);
 	if (!digests)
-		slaunch_txt_reset(txt, "Failed to allocate array of digests\n",
-				  SL_ERROR_GENERIC);
+		slaunch_reset(txt, "Failed to allocate array of digests\n", SL_ERROR_GENERIC);
 
 	for (i = 0; i < tpm->nr_allocated_banks; i++)
 		digests[i].alg_id = tpm->allocated_banks[i].alg_id;
@@ -356,8 +451,7 @@ static void slaunch_tpm2_extend_event(struct tpm_chip *tpm, void __iomem *txt,
 	ret = tpm_pcr_extend(tpm, event->pcr_idx, digests);
 	if (ret) {
 		pr_err("Error extending TPM20 PCR, result: %d\n", ret);
-		slaunch_txt_reset(txt, "Failed to extend TPM20 PCR\n",
-				  SL_ERROR_TPM_EXTEND);
+		slaunch_reset(txt, "Failed to extend TPM20 PCR\n", SL_ERROR_TPM_EXTEND);
 	}
 
 	kfree(digests);
@@ -379,8 +473,8 @@ static void slaunch_tpm2_extend(struct tpm_chip *tpm, void __iomem *txt)
 	while ((void  *)event < sl_evtlog.addr + evtlog21->next_record_offset) {
 		size = __calc_tpm2_event_size(event, event_header, false);
 		if (!size)
-			slaunch_txt_reset(txt, "TPM20 invalid event in event log\n",
-					  SL_ERROR_TPM_INVALID_EVENT);
+			slaunch_reset(txt, "TPM20 invalid event in event log\n",
+				      SL_ERROR_TPM_INVALID_EVENT);
 
 		/*
 		 * Marker events indicate where the Secure Launch early stub
@@ -402,8 +496,8 @@ static void slaunch_tpm2_extend(struct tpm_chip *tpm, void __iomem *txt)
 	}
 
 	if (!start || !end)
-		slaunch_txt_reset(txt, "Missing start or end events for extending TPM20 PCRs\n",
-				  SL_ERROR_TPM_EXTEND);
+		slaunch_reset(txt, "Missing start or end events for extending TPM20 PCRs\n",
+			      SL_ERROR_TPM_EXTEND);
 }
 
 static void slaunch_tpm_extend(struct tpm_chip *tpm, void __iomem *txt)
@@ -442,8 +536,8 @@ static void slaunch_tpm_extend(struct tpm_chip *tpm, void __iomem *txt)
 			ret = tpm_pcr_extend(tpm, event->pcr_idx, &digest);
 			if (ret) {
 				pr_err("Error extending TPM12 PCR, result: %d\n", ret);
-				slaunch_txt_reset(txt, "Failed to extend TPM12 PCR\n",
-						  SL_ERROR_TPM_EXTEND);
+				slaunch_reset(txt, "Failed to extend TPM12 PCR\n",
+					      SL_ERROR_TPM_EXTEND);
 			}
 		}
 
@@ -452,8 +546,8 @@ static void slaunch_tpm_extend(struct tpm_chip *tpm, void __iomem *txt)
 	}
 
 	if (!start || !end)
-		slaunch_txt_reset(txt, "Missing start or end events for extending TPM12 PCRs\n",
-				  SL_ERROR_TPM_EXTEND);
+		slaunch_reset(txt, "Missing start or end events for extending TPM12 PCRs\n",
+			      SL_ERROR_TPM_EXTEND);
 }
 
 static void slaunch_pcr_extend(void __iomem *txt)
@@ -462,12 +556,10 @@ static void slaunch_pcr_extend(void __iomem *txt)
 
 	tpm = tpm_default_chip();
 	if (!tpm)
-		slaunch_txt_reset(txt, "Could not get default TPM chip\n",
-				  SL_ERROR_TPM_INIT);
+		slaunch_reset(txt, "Could not get default TPM chip\n", SL_ERROR_TPM_INIT);
 
 	if (!tpm_chip_set_default_locality(tpm, 2))
-		slaunch_txt_reset(txt, "Could not set TPM chip locality 2\n",
-				  SL_ERROR_TPM_INIT);
+		slaunch_reset(txt, "Could not set TPM chip locality 2\n", SL_ERROR_TPM_INIT);
 
 	if (evtlog21)
 		slaunch_tpm2_extend(tpm, txt);
@@ -482,19 +574,31 @@ static int __init slaunch_module_init(void)
 	void __iomem *txt;
 
 	/* Check to see if Secure Launch happened */
-	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
-	    (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
+	if (!(slaunch_get_flags() & SL_FLAG_ACTIVE))
 		return 0;
 
-	txt = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
-		      PAGE_SIZE);
-	if (!txt)
-		panic("Error ioremap of TXT priv registers\n");
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		txt = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			      PAGE_SIZE);
+		if (!txt)
+			panic("Error ioremap of TXT priv registers\n");
+
+		slaunch_txt_evtlog(txt);
+
+		slaunch_pcr_extend(txt);
+
+		iounmap(txt);
+
+		pr_info("TXT Secure Launch module setup\n");
+	} else if (slaunch_get_flags() & SL_FLAG_ARCH_SKINIT) {
+		slaunch_skinit_evtlog();
+
+		slaunch_pcr_extend(NULL);
+
+		pr_info("SKINIT Secure Launch module setup\n");
+	} else
+		panic("Secure Launch unknown architecture\n");
 
-	/* Only Intel TXT is supported at this point */
-	slaunch_intel_evtlog(txt);
-	slaunch_pcr_extend(txt);
-	iounmap(txt);
 
 	return slaunch_expose_securityfs();
 }
-- 
2.47.1


