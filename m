Return-Path: <linux-kernel+bounces-443150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A29F9EE7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D3D1886338
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8612144B1;
	Thu, 12 Dec 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b="DEk+h5/+"
Received: from 2.mo575.mail-out.ovh.net (2.mo575.mail-out.ovh.net [46.105.52.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070738460
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.52.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011040; cv=none; b=QDfH9SWWdc5d82Y3EJrXNzFQEYbb5S4yftOCzSPX0elBhBPsrG6joBQ8pyA7dQFBUZAXAyYVYxjEaN70u4c4BDf0+XqcfaiVY5YiOWYoru+NiUzZ9hFa/ztz9sRSpavhjsj7i0g1GWNRiPP/Dqcol9ZmAkq77ZWwI/Ug9c8ptgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011040; c=relaxed/simple;
	bh=cCnO9lMvYClnXbNTdv9uhm1EBzAoxrzvJXu1zPDgmnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkzS2aIc+trOm0tpjgSjI2I/ldeV20VJ9ec91l3Xe8A5Hplmwe6/Na/VF2JLQ2gVMqOIaGkLC5JvdOyCbcB8jZKskZa07mVTu8bmY5aMdT66//ct97fXAKt4gyCccuKhFsv0Dfg4GFtYMTM4+eF2p5FIpTlbIbZGmyjO2UAXbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com; spf=pass smtp.mailfrom=3mdeb.com; dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b=DEk+h5/+; arc=none smtp.client-ip=46.105.52.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3mdeb.com
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.139.217])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4Y8D4K5l6Zz1v23
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:29 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-ls6qj (unknown [10.110.118.225])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0A9151FEBE;
	Thu, 12 Dec 2024 13:35:28 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.114])
	by ghost-submission-5b5ff79f4f-ls6qj with ESMTPSA
	id pDB1NKDmWmdbAgAAKSKm4A
	(envelope-from <sergii.dmytruk@3mdeb.com>); Thu, 12 Dec 2024 13:35:28 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-114S008f7047d08-764b-4cd1-a42f-491ef01a7f8b,
                    B639BF7A6EC39DD0505FDBB1524E94DB3A46F08D) smtp.auth=sergii.dmytruk@3mdeb.com
X-OVh-ClientIp:176.111.183.174
From: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
To: linux-kernel@vger.kernel.org
Cc: trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 5/9] x86: Implement AMD support for Secure Launch
Date: Thu, 12 Dec 2024 15:35:03 +0200
Message-ID: <7621baab7c4c1727ffa030121ca7ee0c425b9fe8.1734008878.git.sergii.dmytruk@3mdeb.com>
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
X-Ovh-Tracer-Id: 16618564100968658076
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefuvghrghhiihcuffhmhihtrhhukhcuoehsvghrghhiihdrughmhihtrhhukhesfehmuggvsgdrtghomheqnecuggftrfgrthhtvghrnhepueduffejvdfgffetgeeikeetveeuteekfeehieelheettedvfeekffeutdetieehnecuffhomhgrihhnpehtrhhushhtvggutghomhhpuhhtihhnghhgrhhouhhprdhorhhgpdhinhhtvghlrdgtohhmpdhslhgpshhtuhgsrdhssgenucfkphepuddvjedrtddrtddruddpudejiedrudduuddrudekfedrudejgedpfeejrdehledrudegvddruddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepshgvrhhgihhirdgumhihthhruhhkseefmhguvggsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=khu2OB0AMuUERRKcVpCzCAys1SW6tXjPmH2I6nfIoQA=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1734010529; v=1;
 b=DEk+h5/+e3iBCzmypPQrKXOOzjPRte9i7bdgd6R9/e5joTjmrWeDvajkQj/SyzyzDpRDI8az
 EFEjLkFuix8VG9ilzl6x2BY2oy7YHCv0bJEgwQ3oEZeYn+BPbkQ4rX1XadCzA0I/DPBeyFFyUsw
 EPwCueJfdoiDs0Q9+3mv40o335bmdsK6P9VeqNS94DwAns4jMtDjbHXQso+P6h81SaEja49T57C
 V949zPuxYhzX/XhKnbFyyuX9Ai3q0clYyXc0MNcxR6bXP2tNj+lgsf42K0f/vHad/lqCYA6K+Te
 PY3FvMRCsnQYC3CQbC6plnwONWBAjSth7JUogjVgLJQ6w==

From: Michał Żygowski <michal.zygowski@3mdeb.com>

AMD SKINIT uses the same entry point as Intel TXT (sl_stub_entry). It
follows similar, but simpler path than TXT; there is no TXT heap and
APs are started by a standard INIT/SIPI/SIPI sequence.

Contrary to the TXT, SKINIT does not use code provided by a CPU vendor.
Instead it requires an intermediate loader (SKL), whose task is to set
up memory protection and set a proper CPU context before handling
control over to the kernel.

In order to simplify adding new entries and to minimize the number of
differences between AMD and Intel, the event logs have actually two
headers, both for TPM 1.2 and 2.0.

For TPM 1.2 this is TCG_PCClientSpecIDEventStruct [1] with Intel's own
TXT-specific header embedded inside its 'vendorInfo' field. The offset
to this field is added to the base address on AMD path, making the code
for adding new events the same for both vendors.

TPM 2.0 in TXT uses HEAP_EVENT_LOG_POINTER_ELEMENT2_1 structure, which
is normally constructed on the TXT stack [2]. For AMD, this structure is
put inside TCG_EfiSpecIdEvent [3], also in 'vendorInfo' field. The
actual offset to this field depends on the number of hash algorithms
supported by the event log.

Other changes:
 - update common code to handle reset on AMD as well
 - reserve memory region occupied by SKL (called SLB) and event log

[1] https://www.trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientImplementation_1-21_1_00.pdf
[2] http://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
[3] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientSpecPlat_TPM_2p0_1p04_pub.pdf

Signed-off-by: Michał Żygowski <michal.zygowski@3mdeb.com>
Signed-off-by: Krystian Hebel <krystian.hebel@3mdeb.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
---
 arch/x86/Kconfig                       |   9 +-
 arch/x86/boot/compressed/sl_main.c     | 285 ++++++++++++++++++++-----
 arch/x86/boot/compressed/sl_stub.S     |  41 +++-
 arch/x86/include/uapi/asm/setup_data.h |   3 +-
 arch/x86/kernel/slaunch.c              |  99 ++++++++-
 5 files changed, 362 insertions(+), 75 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 24df5f468fdc..2d22825673b7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2061,11 +2061,12 @@ config SECURE_LAUNCH
 	depends on X86_64 && X86_X2APIC && TCG_TPM && CRYPTO_LIB_SHA1 && CRYPTO_LIB_SHA256
 	help
 	   The Secure Launch feature allows a kernel to be loaded
-	   directly through an Intel TXT measured launch. Intel TXT
+	   directly through a dynamic launch. Intel TXT or AMD SKINIT
 	   establishes a Dynamic Root of Trust for Measurement (DRTM)
-	   where the CPU measures the kernel image. This feature then
-	   continues the measurement chain over kernel configuration
-	   information and init images.
+	   where the CPU or a Dynamic Configuration Environment (DCE)
+	   measures the kernel image. This feature then continues the
+	   measurement chain over kernel configuration information and
+	   init images.
 
 source "kernel/Kconfig.hz"
 
diff --git a/arch/x86/boot/compressed/sl_main.c b/arch/x86/boot/compressed/sl_main.c
index d2aae90eada6..a7a86278cd8f 100644
--- a/arch/x86/boot/compressed/sl_main.c
+++ b/arch/x86/boot/compressed/sl_main.c
@@ -13,6 +13,7 @@
 #include <asm/msr.h>
 #include <asm/mtrr.h>
 #include <asm/processor-flags.h>
+#include <asm/svm.h>
 #include <asm/asm-offsets.h>
 #include <asm/bootparam.h>
 #include <asm/bootparam_utils.h>
@@ -77,6 +78,14 @@ static void __noreturn sl_txt_reset(u64 error)
 	unreachable();
 }
 
+static void __noreturn sl_skinit_reset(void)
+{
+	/* AMD does not have a reset mechanism or an error register */
+	asm volatile ("ud2");
+
+	unreachable();
+}
+
 static u64 sl_rdmsr(u32 reg)
 {
 	u64 lo, hi;
@@ -86,25 +95,41 @@ static u64 sl_rdmsr(u32 reg)
 	return (hi << 32) | lo;
 }
 
-static struct slr_table *sl_locate_and_validate_slrt(void)
+static struct slr_table *sl_locate_and_validate_slrt(struct boot_params *bp)
 {
 	struct txt_os_mle_data *os_mle_data;
+	struct slr_entry_amd_info *amd_info;
+	struct setup_data *data;
 	struct slr_table *slrt;
 	void *txt_heap;
 
-	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
-	os_mle_data = txt_os_mle_data_start(txt_heap);
-
-	if (!os_mle_data->slrt)
-		sl_txt_reset(SL_ERROR_INVALID_SLRT);
+	if (sl_cpu_type & SL_CPU_AMD) {
+		slrt = NULL;
+		data = (struct setup_data *)bp->hdr.setup_data;
+		while (data) {
+			if (data->type == SETUP_SECURE_LAUNCH) {
+				amd_info =
+					(struct slr_entry_amd_info *)((u8 *)data -
+								      sizeof(struct slr_entry_hdr));
+				slrt = (struct slr_table *)amd_info->slrt_base;
+				break;
+			}
+			data = (struct setup_data *)data->next;
+		}
 
-	slrt = (struct slr_table *)os_mle_data->slrt;
+		if (!slrt || slrt->magic != SLR_TABLE_MAGIC ||
+		    slrt->architecture != SLR_AMD_SKINIT)
+			sl_skinit_reset();
+	} else {
+		txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
+		os_mle_data = txt_os_mle_data_start(txt_heap);
 
-	if (slrt->magic != SLR_TABLE_MAGIC)
-		sl_txt_reset(SL_ERROR_INVALID_SLRT);
+		slrt = (struct slr_table *)os_mle_data->slrt;
 
-	if (slrt->architecture != SLR_INTEL_TXT)
-		sl_txt_reset(SL_ERROR_INVALID_SLRT);
+		if (!slrt || slrt->magic != SLR_TABLE_MAGIC ||
+		    slrt->architecture != SLR_INTEL_TXT)
+			sl_txt_reset(SL_ERROR_INVALID_SLRT);
+	}
 
 	return slrt;
 }
@@ -185,6 +210,26 @@ static void sl_txt_validate_msrs(struct txt_os_mle_data *os_mle_data)
 		sl_txt_reset(SL_ERROR_MSR_INV_MISC_EN);
 }
 
+/*
+ * In order to simplify adding new entries and to minimize the number of
+ * differences between AMD and Intel, the event logs have actually two headers,
+ * both for TPM 1.2 and 2.0.
+ *
+ * For TPM 1.2 this is TCG_PCClientSpecIDEventStruct [1] with Intel's own
+ * TXT-specific header embedded inside its 'vendorInfo' field. The offset to
+ * this field is added to the base address in AMD path, making the code for
+ * adding new events the same for both vendors.
+ *
+ * TPM 2.0 in TXT uses HEAP_EVENT_LOG_POINTER_ELEMENT2_1 structure, which is
+ * normally constructed on the TXT stack [2]. For AMD, this structure is put
+ * inside TCG_EfiSpecIdEvent [3], also in 'vendorInfo' field. The actual offset
+ * to this field depends on number of hash algorithms supported by the event
+ * log.
+ *
+ * [1] https://www.trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientImplementation_1-21_1_00.pdf
+ * [2] http://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
+ * [3] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientSpecPlat_TPM_2p0_1p04_pub.pdf
+ */
 static void sl_find_drtm_event_log(struct slr_table *slrt)
 {
 	struct txt_os_sinit_data *os_sinit_data;
@@ -192,12 +237,36 @@ static void sl_find_drtm_event_log(struct slr_table *slrt)
 	void *txt_heap;
 
 	log_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
-	if (!log_info)
-		sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
+	if (!log_info) {
+		if (sl_cpu_type == SL_CPU_INTEL)
+			sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
+		else
+			sl_skinit_reset();
+	}
 
 	evtlog_base = (void *)log_info->addr;
 	evtlog_size = log_info->size;
 
+	if (sl_cpu_type == SL_CPU_AMD) {
+		/* Check if it is TPM 2.0 event log */
+		if (!memcmp(evtlog_base + sizeof(struct tcg_pcr_event),
+			    TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG))) {
+			log21_elem = evtlog_base + sizeof(struct tcg_pcr_event)
+				+ TCG_EfiSpecIdEvent_SIZE(
+				  TPM2_HASH_COUNT(evtlog_base
+					+ sizeof(struct tcg_pcr_event)));
+			tpm_log_ver = SL_TPM2_LOG;
+		} else {
+			evtlog_base += sizeof(struct tcg_pcr_event)
+				+ TCG_PCClientSpecIDEventStruct_SIZE;
+			evtlog_size -= sizeof(struct tcg_pcr_event)
+				+ TCG_PCClientSpecIDEventStruct_SIZE;
+		}
+
+		return;
+	}
+
+	/* Else it is Intel and TXT */
 	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
 
 	/*
@@ -221,7 +290,23 @@ static void sl_find_drtm_event_log(struct slr_table *slrt)
 		tpm_log_ver = SL_TPM2_LOG;
 }
 
-static void sl_validate_event_log_buffer(void)
+static bool sl_check_buffer_kernel_overlap(void *buffer_base, void *buffer_end,
+					   void *kernel_base, void *kernel_end,
+					   bool allow_inside)
+{
+	if (buffer_base >= kernel_end && buffer_end > kernel_end)
+		return false; /* above */
+
+	if (buffer_end <= kernel_base && buffer_base < kernel_base)
+		return false; /* below */
+
+	if (allow_inside && buffer_end <= kernel_end && buffer_base >= kernel_base)
+		return false; /* inside */
+
+	return true;
+}
+
+static void sl_txt_validate_event_log_buffer(void)
 {
 	struct txt_os_sinit_data *os_sinit_data;
 	void *txt_heap, *txt_end;
@@ -243,11 +328,9 @@ static void sl_validate_event_log_buffer(void)
 	 * This check is to ensure the event log buffer does not overlap with
 	 * the MLE image.
 	 */
-	if (evtlog_base >= mle_end && evtlog_end > mle_end)
-		goto pmr_check; /* above */
-
-	if (evtlog_end <= mle_base && evtlog_base < mle_base)
-		goto pmr_check; /* below */
+	if (!sl_check_buffer_kernel_overlap(evtlog_base, evtlog_end,
+					    mle_base, mle_end, false))
+		goto pmr_check;
 
 	sl_txt_reset(SL_ERROR_MLE_BUFFER_OVERLAP);
 
@@ -262,6 +345,38 @@ static void sl_validate_event_log_buffer(void)
 	sl_check_pmr_coverage(evtlog_base, evtlog_size, true);
 }
 
+static void sl_skinit_validate_buffers(struct slr_table *slrt, void *bootparams)
+{
+	void *evtlog_end, *kernel_start, *kernel_end;
+	struct slr_entry_dl_info *dl_info;
+
+	/* On AMD, all the buffers should be below 4Gb */
+	if ((u64)(evtlog_base + evtlog_size) > UINT_MAX)
+		sl_skinit_reset();
+
+	evtlog_end = evtlog_base + evtlog_size;
+
+	dl_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_DL_INFO);
+	if (!dl_info)
+		sl_skinit_reset();
+
+	kernel_start = (void *)dl_info->dlme_base;
+	kernel_end = (void *)(dl_info->dlme_base + dl_info->dlme_size);
+
+	/*
+	 * This check is to ensure the event log buffer and the bootparams do
+	 * overlap with the kernel image. Note on an EFI stub boot, the bootparams
+	 * will be fully inside the kernel image.
+	 */
+	if (sl_check_buffer_kernel_overlap(bootparams, bootparams + PAGE_SIZE,
+					   kernel_start, kernel_end, true))
+		sl_skinit_reset();
+
+	if (sl_check_buffer_kernel_overlap(evtlog_base, evtlog_end,
+					   kernel_start, kernel_end, false))
+		sl_skinit_reset();
+}
+
 static void sl_find_event_log_algorithms(void)
 {
 	struct tcg_efi_specid_event_head *efi_head =
@@ -269,8 +384,12 @@ static void sl_find_event_log_algorithms(void)
 					log21_elem->first_record_offset +
 					sizeof(struct tcg_pcr_event));
 
-	if (efi_head->num_algs == 0 || efi_head->num_algs > SL_TPM2_MAX_ALGS)
-		sl_txt_reset(SL_ERROR_TPM_NUMBER_ALGS);
+	if (efi_head->num_algs == 0 || efi_head->num_algs > SL_TPM2_MAX_ALGS) {
+		if (sl_cpu_type == SL_CPU_INTEL)
+			sl_txt_reset(SL_ERROR_TPM_NUMBER_ALGS);
+		else
+			sl_skinit_reset();
+	}
 
 	memcpy(&tpm_algs[0], &efi_head->digest_sizes[0],
 	       sizeof(struct tcg_efi_specid_event_algs) * efi_head->num_algs);
@@ -299,8 +418,12 @@ static void sl_tpm_log_event(u32 pcr, u32 event_type,
 
 	total_size = sizeof(*pcr_event) + event_size;
 
-	if (tpm_log_event(evtlog_base, evtlog_size, total_size, pcr_event))
-		sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
+	if (tpm_log_event(evtlog_base, evtlog_size, total_size, pcr_event)) {
+		if (sl_cpu_type == SL_CPU_INTEL)
+			sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
+		else
+			sl_skinit_reset();
+	}
 }
 
 static void sl_tpm2_log_event(u32 pcr, u32 event_type,
@@ -343,7 +466,10 @@ static void sl_tpm2_log_event(u32 pcr, u32 event_type,
 			total_size += SHA1_DIGEST_SIZE + sizeof(u16);
 			alg_ptr = (u16 *)((u8 *)alg_ptr + SHA1_DIGEST_SIZE + sizeof(u16));
 		} else {
-			sl_txt_reset(SL_ERROR_TPM_UNKNOWN_DIGEST);
+			if (sl_cpu_type == SL_CPU_INTEL)
+				sl_txt_reset(SL_ERROR_TPM_UNKNOWN_DIGEST);
+			else
+				sl_skinit_reset();
 		}
 
 		head->count++;
@@ -355,8 +481,12 @@ static void sl_tpm2_log_event(u32 pcr, u32 event_type,
 		memcpy((u8 *)event + sizeof(*event), event_data, event_size);
 	total_size += sizeof(*event) + event_size;
 
-	if (tpm2_log_event(log21_elem, evtlog_base, evtlog_size, total_size, &log_buf[0]))
-		sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
+	if (tpm2_log_event(log21_elem, evtlog_base, evtlog_size, total_size, &log_buf[0])) {
+		if (sl_cpu_type == SL_CPU_INTEL)
+			sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
+		else
+			sl_skinit_reset();
+	}
 }
 
 static void sl_tpm_extend_evtlog(u32 pcr, u32 type,
@@ -381,6 +511,13 @@ static struct setup_data *sl_handle_setup_data(struct setup_data *curr,
 
 	next = (struct setup_data *)(unsigned long)curr->next;
 
+	/*
+	 * If this is the Secure Launch setup_data, it is the AMD info in the
+	 * SLR table which is measured separately, skip it.
+	 */
+	if (curr->type == SETUP_SECURE_LAUNCH)
+		return next;
+
 	/* SETUP_INDIRECT instances have to be handled differently */
 	if (curr->type == SETUP_INDIRECT) {
 		ind = (struct setup_indirect *)((u8 *)curr + offsetof(struct setup_data, data));
@@ -421,23 +558,48 @@ static void sl_extend_setup_data(struct slr_policy_entry *entry)
 static void sl_extend_slrt(struct slr_policy_entry *entry)
 {
 	struct slr_table *slrt = (struct slr_table *)entry->entity;
-	struct slr_entry_intel_info *intel_info;
+	struct slr_entry_hdr *intel_info;
+	struct slr_entry_amd_info *amd_info;
+	struct slr_entry_amd_info amd_tmp;
 
 	/*
 	 * In revision one of the SLRT, the only table that needs to be
-	 * measured is the Intel info table. Everything else is meta-data,
-	 * addresses and sizes. Note the size of what to measure is not set.
-	 * The flag SLR_POLICY_IMPLICIT_SIZE leaves it to the measuring code
-	 * to sort out.
+	 * measured is the platform-specific info table. Everything else is
+	 * meta-data, addresses and sizes. Note the size of what to measure is
+	 * not set. The flag SLR_POLICY_IMPLICIT_SIZE leaves it to the measuring
+	 * code to sort out.
 	 */
 	if (slrt->revision == 1) {
-		intel_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
-		if (!intel_info)
-			sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
-
-		sl_tpm_extend_evtlog(entry->pcr, TXT_EVTYPE_SLAUNCH,
-				     (void *)entry->entity, sizeof(*intel_info),
-				     entry->evt_info);
+		if (sl_cpu_type == SL_CPU_INTEL) {
+			intel_info =
+				slr_next_entry_by_tag(slrt, NULL,
+						      SLR_ENTRY_INTEL_INFO);
+			if (!intel_info)
+				sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
+
+			sl_tpm_extend_evtlog(entry->pcr, TXT_EVTYPE_SLAUNCH,
+					     (void *)entry->entity,
+					     sizeof(*intel_info),
+					     entry->evt_info);
+		} else if (sl_cpu_type == SL_CPU_AMD) {
+			amd_info = slr_next_entry_by_tag(slrt, NULL,
+							 SLR_ENTRY_AMD_INFO);
+			if (!amd_info)
+				sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
+
+			/*
+			 * Make a temp copy and zero out address fields since
+			 * they should not be measured.
+			 */
+			amd_tmp = *amd_info;
+			amd_tmp.next = 0;
+			amd_tmp.boot_params_base = 0;
+			amd_tmp.slrt_base = 0;
+
+			sl_tpm_extend_evtlog(entry->pcr, TXT_EVTYPE_SLAUNCH,
+					     (void *)&amd_tmp, sizeof(amd_tmp),
+					     entry->evt_info);
+		}
 	}
 }
 
@@ -466,8 +628,12 @@ static void sl_process_extend_policy(struct slr_table *slrt)
 	u16 i;
 
 	policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
-	if (!policy)
-		sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
+	if (!policy) {
+		if (sl_cpu_type == SL_CPU_INTEL)
+			sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
+		else
+			sl_skinit_reset();
+	}
 
 	for (i = 0; i < policy->nr_entries; i++) {
 		switch (policy->policy_entries[i].entity_type) {
@@ -532,20 +698,29 @@ asmlinkage __visible void sl_main(void *bootparams)
 	bp->hdr.loadflags &= ~SLAUNCH_FLAG;
 
 	/*
-	 * Currently only Intel TXT is supported for Secure Launch. Testing
+	 * Intel TXT and AMD SKINIT are supported for Secure Launch. Testing
 	 * this value also indicates that the kernel was booted successfully
-	 * through the Secure Launch entry point and is in SMX mode.
+	 * through the Secure Launch entry point and is in SMX or SKINIT mode.
 	 */
-	if (!(sl_cpu_type & SL_CPU_INTEL))
+	if (!(sl_cpu_type & (SL_CPU_INTEL | SL_CPU_AMD)))
 		return;
 
-	slrt = sl_locate_and_validate_slrt();
+	slrt = sl_locate_and_validate_slrt(bp);
 
 	/* Locate the TPM event log. */
 	sl_find_drtm_event_log(slrt);
 
-	/* Validate the location of the event log buffer before using it */
-	sl_validate_event_log_buffer();
+	/*
+	 * On a TXT launch, validate the logging buffer for overlaps with the
+	 * MLE and proper PMR coverage before using it. On an SKINIT launch,
+	 * the boot params have to be used here to find the base and extent of
+	 * the launched kernel. These values can then be used to make sure the
+	 * boot params and logging buffer do not overlap the kernel.
+	 */
+	if (sl_cpu_type & SL_CPU_INTEL)
+		sl_txt_validate_event_log_buffer();
+	else
+		sl_skinit_validate_buffers(slrt, bootparams);
 
 	/*
 	 * Find the TPM hash algorithms used by the ACM and recorded in the
@@ -572,13 +747,15 @@ asmlinkage __visible void sl_main(void *bootparams)
 
 	sl_tpm_extend_evtlog(17, TXT_EVTYPE_SLAUNCH_END, NULL, 0, "");
 
-	/* No PMR check is needed, the TXT heap is covered by the DPR */
-	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
-	os_mle_data = txt_os_mle_data_start(txt_heap);
+	if (sl_cpu_type & SL_CPU_INTEL) {
+		/* No PMR check is needed, the TXT heap is covered by the DPR */
+		txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
+		os_mle_data = txt_os_mle_data_start(txt_heap);
 
-	/*
-	 * Now that the OS-MLE data is measured, ensure the MTRR and
-	 * misc enable MSRs are what we expect.
-	 */
-	sl_txt_validate_msrs(os_mle_data);
+		/*
+		 * Now that the OS-MLE data is measured, ensure the MTRR and
+		 * misc enable MSRs are what we expect.
+		 */
+		sl_txt_validate_msrs(os_mle_data);
+	}
 }
diff --git a/arch/x86/boot/compressed/sl_stub.S b/arch/x86/boot/compressed/sl_stub.S
index 92ca1f03c619..55039d401230 100644
--- a/arch/x86/boot/compressed/sl_stub.S
+++ b/arch/x86/boot/compressed/sl_stub.S
@@ -23,6 +23,9 @@
 /* CPUID: leaf 1, ECX, SMX feature bit */
 #define X86_FEATURE_BIT_SMX	(1 << 6)
 
+/* CPUID: leaf 0x80000001, ECX, SKINIT feature bit */
+#define X86_FEATURE_BIT_SKINIT	(1 << 12)
+
 #define IDT_VECTOR_LO_BITS	0
 #define IDT_VECTOR_HI_BITS	6
 
@@ -71,7 +74,11 @@ SYM_FUNC_START(sl_stub_entry)
 	 * On entry, %ebx has the entry abs offset to sl_stub_entry. The rva()
 	 * macro is used to generate relative references using %ebx as a base, as
 	 * to avoid absolute relocations, which would require fixups at runtime.
-	 * Only %cs and %ds segments are known good.
+	 * Only %cs and %ds segments are known good. On Intel, the ACM guarantees
+	 * this while on AMD the SKL (Secure Kernel Loader) likewise does.
+	 *
+	 * In addition, on Intel %ecx holds the MLE page directory pointer
+	 * table and on AMD %edx holds the physical base address of the SKL.
 	 */
 
 	/* Load GDT, set segment regs and lret to __SL32_CS */
@@ -98,6 +105,12 @@ SYM_FUNC_START(sl_stub_entry)
 	lret
 
 .Lsl_cs:
+	/*
+	 * For AMD, save SKL base before the CPUID instruction overwrites it.
+	 * Performs cast from u32 to 64b void* for simpler use later.
+	 */
+	movl	%edx, rva(sl_skl_base)(%ebx)
+
 	/* Save our base pointer reg and page table for MLE */
 	pushl	%ebx
 	pushl	%ecx
@@ -106,7 +119,7 @@ SYM_FUNC_START(sl_stub_entry)
 	movl	$1, %eax
 	cpuid
 	testl	$(X86_FEATURE_BIT_SMX), %ecx
-	jz	.Ldo_unknown_cpu
+	jz	.Ldo_amd /* maybe AMD/SKINIT? */
 
 	popl	%ecx
 	popl	%ebx
@@ -189,9 +202,21 @@ SYM_FUNC_START(sl_stub_entry)
 
 	jmp	.Lcpu_setup_done
 
-.Ldo_unknown_cpu:
-	/* Non-Intel CPUs are not yet supported */
-	ud2
+.Ldo_amd:
+	/* See if SKINIT feature is supported. */
+	movl	$0x80000001, %eax
+	cpuid
+	testl	$(X86_FEATURE_BIT_SKINIT), %ecx
+	jz	.Ldo_unknown_cpu
+
+	popl	%ecx
+	/* Base pointer reg saved in Intel check */
+	popl	%ebx
+
+	/* Know it is AMD */
+	movl	$(SL_CPU_AMD), rva(sl_cpu_type)(%ebx)
+
+	/* On AMD %esi is set up by the SKL, just go on */
 
 .Lcpu_setup_done:
 	/*
@@ -201,6 +226,10 @@ SYM_FUNC_START(sl_stub_entry)
 
 	/* Done, jump to normal 32b pm entry */
 	jmp	startup_32
+
+.Ldo_unknown_cpu:
+	/* Neither Intel nor AMD */
+	ud2
 SYM_FUNC_END(sl_stub_entry)
 
 SYM_FUNC_START(sl_find_mle_base)
@@ -717,6 +746,8 @@ SYM_DATA(sl_cpu_type, .long 0x00000000)
 
 SYM_DATA(sl_mle_start, .long 0x00000000)
 
+SYM_DATA(sl_skl_base, .quad 0x0000000000000000)
+
 SYM_DATA_LOCAL(sl_txt_spin_lock, .long 0x00000000)
 
 SYM_DATA_LOCAL(sl_txt_stack_index, .long 0x00000000)
diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
index b111b0c18544..ac2868ab68d7 100644
--- a/arch/x86/include/uapi/asm/setup_data.h
+++ b/arch/x86/include/uapi/asm/setup_data.h
@@ -13,7 +13,8 @@
 #define SETUP_CC_BLOB			7
 #define SETUP_IMA			8
 #define SETUP_RNG_SEED			9
-#define SETUP_ENUM_MAX			SETUP_RNG_SEED
+#define SETUP_SECURE_LAUNCH		10
+#define SETUP_ENUM_MAX			SETUP_SECURE_LAUNCH
 
 #define SETUP_INDIRECT			(1<<31)
 #define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index 7a8ecc8c08a8..ff05f032e44f 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -93,6 +93,20 @@ void __noreturn slaunch_txt_reset(void __iomem *txt,
 	unreachable();
 }
 
+/*
+ * SKINIT has no sticky register to set an error code or a DRTM reset
+ * facility. The best that can be done is to trace an error and trigger
+ * a system reset using the undefined instruction.
+ */
+void __noreturn slaunch_skinit_reset(const char *msg, u64 error)
+{
+	pr_err("%s - error: 0x%llx", msg, error);
+
+	asm volatile ("ud2");
+
+	unreachable();
+}
+
 /*
  * The TXT heap is too big to map all at once with early_ioremap
  * so it is done a table at a time.
@@ -217,7 +231,7 @@ static void __init slaunch_verify_pmrs(void __iomem *txt)
 		slaunch_txt_reset(txt, errmsg, err);
 }
 
-static void __init slaunch_txt_reserve_range(u64 base, u64 size)
+static void __init slaunch_reserve_range(u64 base, u64 size)
 {
 	int type;
 
@@ -255,15 +269,15 @@ static void __init slaunch_txt_reserve(void __iomem *txt)
 
 	base = TXT_PRIV_CONFIG_REGS_BASE;
 	size = TXT_PUB_CONFIG_REGS_BASE - TXT_PRIV_CONFIG_REGS_BASE;
-	slaunch_txt_reserve_range(base, size);
+	slaunch_reserve_range(base, size);
 
 	memcpy_fromio(&heap_base, txt + TXT_CR_HEAP_BASE, sizeof(heap_base));
 	memcpy_fromio(&heap_size, txt + TXT_CR_HEAP_SIZE, sizeof(heap_size));
-	slaunch_txt_reserve_range(heap_base, heap_size);
+	slaunch_reserve_range(heap_base, heap_size);
 
 	memcpy_fromio(&base, txt + TXT_CR_SINIT_BASE, sizeof(base));
 	memcpy_fromio(&size, txt + TXT_CR_SINIT_SIZE, sizeof(size));
-	slaunch_txt_reserve_range(base, size);
+	slaunch_reserve_range(base, size);
 
 	field_offset = offsetof(struct txt_sinit_mle_data,
 				sinit_vtd_dmar_table_size);
@@ -288,14 +302,14 @@ static void __init slaunch_txt_reserve(void __iomem *txt)
 	for (i = 0; i < mdrnum; i++, mdr++) {
 		/* Spec says some entries can have length 0, ignore them */
 		if (mdr->type > 0 && mdr->length > 0)
-			slaunch_txt_reserve_range(mdr->address, mdr->length);
+			slaunch_reserve_range(mdr->address, mdr->length);
 	}
 
 	txt_early_put_heap_table(mdrs, mdroffset + mdrslen - 8);
 
 nomdr:
-	slaunch_txt_reserve_range(ap_wake_info.ap_wake_block,
-				  ap_wake_info.ap_wake_block_size);
+	slaunch_reserve_range(ap_wake_info.ap_wake_block,
+			      ap_wake_info.ap_wake_block_size);
 
 	/*
 	 * Earlier checks ensured that the event log was properly situated
@@ -304,16 +318,16 @@ static void __init slaunch_txt_reserve(void __iomem *txt)
 	 * already reserved.
 	 */
 	if (evtlog_addr < heap_base || evtlog_addr > (heap_base + heap_size))
-		slaunch_txt_reserve_range(evtlog_addr, evtlog_size);
+		slaunch_reserve_range(evtlog_addr, evtlog_size);
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		base = e820_table->entries[i].addr;
 		size = e820_table->entries[i].size;
 		if (base >= vtd_pmr_lo_size && base < 0x100000000ULL)
-			slaunch_txt_reserve_range(base, size);
+			slaunch_reserve_range(base, size);
 		else if (base < vtd_pmr_lo_size && base + size > vtd_pmr_lo_size)
-			slaunch_txt_reserve_range(vtd_pmr_lo_size,
-						  base + size - vtd_pmr_lo_size);
+			slaunch_reserve_range(vtd_pmr_lo_size,
+					      base + size - vtd_pmr_lo_size);
 	}
 }
 
@@ -514,6 +528,67 @@ static void __init slaunch_setup_txt(void)
 	pr_info("Intel TXT setup complete\n");
 }
 
+static void slaunch_skinit_prepare(void)
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
+		data = (struct setup_data *)early_memremap(pa_data, sizeof(*data));
+		if (!data)
+			slaunch_skinit_reset("Error failed to early_memremap setup data\n",
+					     SL_ERROR_MAP_SETUP_DATA);
+
+		if (data->type == SETUP_SECURE_LAUNCH) {
+			early_memunmap(data, sizeof(*data));
+			amd_info = (struct slr_entry_amd_info *)
+				early_memremap(pa_data - sizeof(struct slr_entry_hdr),
+					       sizeof(*amd_info));
+			if (!amd_info)
+				slaunch_skinit_reset("Error failed to early_memremap AMD info\n",
+						     SL_ERROR_MAP_SETUP_DATA);
+			break;
+		}
+
+		pa_data = data->next;
+		early_memunmap(data, sizeof(*data));
+	}
+
+	if (!amd_info)
+		slaunch_skinit_reset("Error failed to find AMD info\n",
+				     SL_ERROR_MISSING_EVENT_LOG);
+
+	amd_info_temp = *amd_info;
+	early_memunmap(amd_info, sizeof(*amd_info));
+
+	slaunch_reserve_range(amd_info_temp.slrt_base, amd_info_temp.slrt_size);
+
+	/* Get the SLRT and remap it */
+	slrt = early_memremap(amd_info_temp.slrt_base, amd_info_temp.slrt_size);
+	if (!slrt)
+		slaunch_skinit_reset("Error failed to early_memremap SLR Table\n",
+				     SL_ERROR_SLRT_MAP);
+
+	log_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
+	if (!log_info)
+		slaunch_skinit_reset("Error failed to find event log info SLR Table\n",
+				     SL_ERROR_SLRT_MISSING_ENTRY);
+
+	slaunch_reserve_range(log_info->addr, log_info->size);
+
+	early_memunmap(slrt, amd_info_temp.slrt_size);
+
+	if (amd_info_temp.psp_version == 2 || amd_info_temp.psp_version == 3)
+		sl_flags |= SL_FLAG_SKINIT_PSP;
+}
+
 /*
  * AMD SKINIT specific late stub setup and validation called from within
  * x86 specific setup_arch().
@@ -530,6 +605,8 @@ static void __init slaunch_setup_skinit(void)
 	if (!(val & (1 << SVM_VM_CR_INIT_REDIRECTION)))
 		return;
 
+	slaunch_skinit_prepare();
+
 	/* Set flags on BSP so subsequent code knows it was a SKINIT launch */
 	sl_flags |= (SL_FLAG_ACTIVE|SL_FLAG_ARCH_SKINIT);
 	pr_info("AMD SKINIT setup complete\n");
-- 
2.47.1


