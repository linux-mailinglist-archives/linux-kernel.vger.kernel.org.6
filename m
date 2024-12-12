Return-Path: <linux-kernel+bounces-443133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729AC9EE7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDF11888A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7311E213E84;
	Thu, 12 Dec 2024 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b="ZsKYJSJV"
Received: from 14.mo561.mail-out.ovh.net (14.mo561.mail-out.ovh.net [188.165.43.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86F215712
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.43.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010537; cv=none; b=gJNQHunA08n5ed+DGqEWPhOLrB3O98jW5C6obhrcEdJT2iksOL5pD9bOFydVb9NI3PH6/lB9jpzJ5kQzCZtJkBAQEPnQZOLy2CfkF2UVEsmLceX/stWsdgmh3HS+PltdrIg0p51z5G7jWVmJGptikpwX0jQJDuuwxYj6Sdp10ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010537; c=relaxed/simple;
	bh=R4TblVdLpntYw4pZ88SsnXF8n3LaONv9u4QZ5EKW9d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keG5TZTWZgjKd0J095Kh5gzhZG7leQaXsLOTJmPTcHx+eVelY2tCsOJpUGbWiGT2wmtr0ulvvoW/soyC28x6F7jOsFwdtR9aehVQzb0kTEZ3x8AOW8U9FMi64hgmZyP8uTAbz5JCt1TOIC8APBtI6Y7J15QS5gjoojkxCHMrOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com; spf=pass smtp.mailfrom=3mdeb.com; dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b=ZsKYJSJV; arc=none smtp.client-ip=188.165.43.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3mdeb.com
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.17.189])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4Y8D4B5Jrnz1Wyf
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:22 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-2d6tl (unknown [10.110.178.220])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3B7D51FEA0;
	Thu, 12 Dec 2024 13:35:22 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.104])
	by ghost-submission-5b5ff79f4f-2d6tl with ESMTPSA
	id jYCEBJrmWmcgLAAA6aQmxA
	(envelope-from <sergii.dmytruk@3mdeb.com>); Thu, 12 Dec 2024 13:35:22 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-104R00554316059-f351-4581-b18f-328d7779cbcb,
                    B639BF7A6EC39DD0505FDBB1524E94DB3A46F08D) smtp.auth=sergii.dmytruk@3mdeb.com
X-OVh-ClientIp:176.111.183.174
From: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
To: linux-kernel@vger.kernel.org
Cc: trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 3/9] x86: Secure Launch main header file AMD support
Date: Thu, 12 Dec 2024 15:35:01 +0200
Message-ID: <4744b385110be8932f37471731ab4eec234311c4.1734008878.git.sergii.dmytruk@3mdeb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
References: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16616593778357679260
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefuvghrghhiihcuffhmhihtrhhukhcuoehsvghrghhiihdrughmhihtrhhukhesfehmuggvsgdrtghomheqnecuggftrfgrthhtvghrnhepgeekffeiiedtveekhfdugeffveeigefgleegvdeghefftdetheefueeliedukedvnecukfhppeduvdejrddtrddtrddupddujeeirdduuddurddukeefrddujeegpdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehsvghrghhiihdrughmhihtrhhukhesfehmuggvsgdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiudgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=gq9b4X2yMxYbiisoLiz6N0vq+L8rmZ38DNFKS8g7bmQ=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1734010522; v=1;
 b=ZsKYJSJV0fcGRDuAxzKQqLDQdcLVO+U+29EP8Vc3PBWtwh82NdfyMY7atSCKD9RHVeQfe6Cq
 /0IRh028WYQHqgGL69gqREFszVI4U/Cjwn6stZU12nlr8J5NC+SiNvNAjQEeYqLucIuT/7xz6lh
 y9bASe79z7qCm1kQ+jJWeVRZSLu+D1I+FZa6Ok5ZVPmfgjT2KDLZB69H90sTJRmyvRoPxac4g0D
 VOxygFyJdTxLe8FuTgg/7e+PF8Kb5NUjy5sHuBbfurUPkiMFh32fY2Zb0uY7bDQOuL3E7cj5Pmq
 DR6K+m4zcgDPExWhQbmewxt0zK8szIk93Xf85bz4bHYKw==

From: Ross Philipson <ross.philipson@oracle.com>

Add additional Secure Launch definitions and declarations for AMD/SKINIT
support.

Use a single implementation of slaunch_is_txt_launch(),
slaunch_get_flags() returns to 0 if Secure Launch support isn't enabled.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Michał Żygowski <michal.zygowski@3mdeb.com>
Signed-off-by: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
---
 include/linux/slaunch.h | 81 +++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 11 deletions(-)

diff --git a/include/linux/slaunch.h b/include/linux/slaunch.h
index efb1235b3e1b..ab01fb6aee15 100644
--- a/include/linux/slaunch.h
+++ b/include/linux/slaunch.h
@@ -14,11 +14,14 @@
  */
 #define SL_FLAG_ACTIVE		0x00000001
 #define SL_FLAG_ARCH_TXT	0x00000002
+#define SL_FLAG_ARCH_SKINIT	0x00000004
+#define SL_FLAG_SKINIT_PSP	0x00000008
 
 /*
  * Secure Launch CPU Type
  */
 #define SL_CPU_INTEL	1
+#define SL_CPU_AMD	2
 
 #define __SL32_CS	0x0008
 #define __SL32_DS	0x0010
@@ -146,6 +149,8 @@
 #define SL_ERROR_INVALID_SLRT		0xc0008022
 #define SL_ERROR_SLRT_MISSING_ENTRY	0xc0008023
 #define SL_ERROR_SLRT_MAP		0xc0008024
+#define SL_ERROR_MISSING_EVENT_LOG	0xc0008025
+#define SL_ERROR_MAP_SETUP_DATA		0xc0008026
 
 /*
  * Secure Launch Defined Limits
@@ -326,9 +331,25 @@ struct smx_rlp_mle_join {
 	u32 rlp_entry_point; /* phys addr */
 } __packed;
 
+/* The TCG original Spec ID structure defined for TPM 1.2 */
+#define TCG_SPECID_SIG00 "Spec ID Event00"
+
+struct tpm_tcg_specid_event_head {
+	char signature[16];
+	u32  platform_class;
+	u8   spec_ver_minor;
+	u8   spec_ver_major;
+	u8   errata;
+	u8   uintn_size;	/* reserved (must be 0) for 1.21 */
+	u8   vendor_info_size;
+	/* vendor_info[]; */
+} __packed;
+
 /*
- * TPM event log structures defined in both the TXT specification and
- * the TCG documentation.
+ * TPM event log structures defined by the TXT specification derived
+ * from the TCG documentation. For TXT this is setup as the conainter
+ * header. On AMD this header is embedded in to vendor information
+ * after the TCG spec ID header.
  */
 #define TPM_EVTLOG_SIGNATURE "TXT Event Container"
 
@@ -345,6 +366,25 @@ struct tpm_event_log_header {
 	/* PCREvents[] */
 } __packed;
 
+/* TPM Event Log Size Macros */
+#define TCG_PCClientSpecIDEventStruct_SIZE			\
+		(sizeof(struct tpm_tcg_specid_event_head))
+#define TCG_EfiSpecIdEvent_SIZE(n) \
+		((n) * sizeof(struct tcg_efi_specid_event_algs)	\
+		 + sizeof(struct tcg_efi_specid_event_head)	\
+		 + sizeof(u8) /* vendorInfoSize */)
+#define TPM2_HASH_COUNT(base) (*((u32 *)(base)			\
+		+ (offsetof(struct tcg_efi_specid_event_head, num_algs) >> 2)))
+
+/* AMD Specific Structures and Definitions */
+struct sl_header {
+	u16 skl_entry_point;
+	u16 length;
+	u8 reserved[62];
+	u16 skl_info_offset;
+	u16 bootloader_data_offset;
+} __packed;
+
 /*
  * Functions to extract data from the Intel TXT Heap Memory. The layout
  * of the heap is as follows:
@@ -501,16 +541,14 @@ void slaunch_fixup_jump_vector(void);
 u32 slaunch_get_flags(void);
 struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
 struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar);
+void slaunch_cpu_setup_skinit(void);
+void __noreturn slaunch_skinit_reset(const char *msg, u64 error);
 void __noreturn slaunch_txt_reset(void __iomem *txt,
 					 const char *msg, u64 error);
 void slaunch_finalize(int do_sexit);
-
-static inline bool slaunch_is_txt_launch(void)
-{
-	u32 mask =  SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
-
-	return (slaunch_get_flags() & mask) == mask;
-}
+bool slaunch_psp_tmr_release(void);
+void slaunch_psp_setup(void);
+void slaunch_psp_finalize(void);
 
 #else
 
@@ -518,6 +556,10 @@ static inline void slaunch_setup_txt(void)
 {
 }
 
+static inline void slaunch_cpu_setup_skinit(void)
+{
+}
+
 static inline void slaunch_fixup_jump_vector(void)
 {
 }
@@ -534,14 +576,31 @@ static inline struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table
 
 static inline void slaunch_finalize(int do_sexit)
 {
+	(void)do_sexit;
 }
 
+#endif /* !IS_ENABLED(CONFIG_SECURE_LAUNCH) */
+
 static inline bool slaunch_is_txt_launch(void)
 {
-	return false;
+	u32 mask = SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
+
+	return (slaunch_get_flags() & mask) == mask;
 }
 
-#endif /* !IS_ENABLED(CONFIG_SECURE_LAUNCH) */
+static inline bool slaunch_is_skinit_launch(void)
+{
+	u32 mask = SL_FLAG_ACTIVE | SL_FLAG_ARCH_SKINIT;
+
+	return (slaunch_get_flags() & mask) == mask;
+}
+
+static inline bool slaunch_is_skinit_psp(void)
+{
+	u32 mask = SL_FLAG_ACTIVE | SL_FLAG_ARCH_SKINIT | SL_FLAG_SKINIT_PSP;
+
+	return (slaunch_get_flags() & mask) == mask;
+}
 
 #endif /* !__ASSEMBLY */
 
-- 
2.47.1


