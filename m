Return-Path: <linux-kernel+bounces-184098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705F78CA296
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24DCB22266
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6B8138496;
	Mon, 20 May 2024 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="H/XQlQ8U"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4CDE552
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232191; cv=none; b=o2ERzdjHYQnCylCufFz3FwfhAxLYrwKn3DBaiYENQK+CZfnoN0ZrkWQHStUQDKdMLnibplNvLBsE96ONI0OUJ+wU44DVeP08e2y7n3BbG/ETZyxaGpp7d8W1Y+qTmASchIEHtiKRiZ0B2OKw7J23ZeCppw54xyuPHOe6fihA/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232191; c=relaxed/simple;
	bh=RFucRZVB2b79ftg7v7SXtwcVJIdleSVk5br/SotgogM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qKUZ80KGDKFQtPwC772N8Wy9TzdZQTlXEEg9OzVb8f80X2tETXnAsfc3SxiLWJxBwqqx2c0yi3jzU3V31H0o2nTyPrhGED3rkFgDFvJLKoiqj1xR/9VN3ozlou3lzP+wQHOfyAkssdOZStgn32IEKzEun6sK+vRmqwpAejYCWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=H/XQlQ8U; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KBhg8x032700;
	Mon, 20 May 2024 18:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=zoS0sr6JM2PIVecEiJNHlY75llQlYfv3A2SsNH8FUVI=;
 b=H/XQlQ8UHvkY02FYQa5o0LvmvnyO9VSTOQfZAOs897DZki8HOjr5G5EioEw/SyUecJYr
 tMJbCRC6Mby9J8Q1vSCR8/s4M4ODR6xG/HWoC7JIIPkuciQ0t772Yp6M1rtnaQch0a39
 3HOH+WzWvVor3icaFXPhH5mQEbQx4Fq4GmfOdgaUpqOxHXWI1zhDohgc2Sb+RXAIs+Zm
 cxlrlFnUvL2G6bNYWglfIP0r0my4L6/VG/FllVNpN66XwhUvlcq3eUYzsab7iqEFDNj8
 3hzET2ZE+5n8nPkfRPsQbAPHLllzGqnn/G4O2iIv+W+l0u/pV8thUMDcAwGUIx+HgFd1 eQ== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3y85vx3bce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 18:36:41 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 87016805EB5;
	Mon, 20 May 2024 18:36:39 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 6B0CB80E710;
	Mon, 20 May 2024 18:36:37 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id AD446300009B5; Mon, 20 May 2024 13:36:33 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 1/3] x86/kexec: Add EFI config table identity mapping for kexec kernel
Date: Mon, 20 May 2024 13:36:31 -0500
Message-Id: <20240520183633.1457687-2-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240520183633.1457687-1-steve.wahl@hpe.com>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3Y20lcDBObhdOi5eJeK6zNtXUHZ6EvQ1
X-Proofpoint-ORIG-GUID: 3Y20lcDBObhdOi5eJeK6zNtXUHZ6EvQ1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200149

From: Tao Liu <ltao@redhat.com>

A kexec kernel boot failure is sometimes observed on AMD CPUs due to
unmapped EFI config table.  This is seen when "nogbpages" is on the
kernel command line, and has been observed as a full BIOS reboot
rather than a successful kexec.

Currently EFI system table is identity-mapped for the kexec kernel, but EFI
config table is not mapped explicitly:

    commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI
                          tables to the ident map")

The following 2 commits caused the EFI config table to be accessed
when enabling SEV at kernel startup.

    commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
                          earlier during boot")
    commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
                          detection/setup")

This may result in a page fault due to EFI config table's unmapped
address. Since the page fault occurs before the new kernel establishes
its own identity map and page fault routines, it is unrecoverable and
kexec fails.

The issue doesn't appear on all systems, because the pages used by
kexec to create the identity map are usually large 1GB pages that, by
luck, end up including the needed address space when other nearby
areas are explicitly mapped.

However if nogbpages is set, the reduced page size (2 MB) used to
create the identity map means it's less likely that the EFI config
table's address space ends up mapped by mapping requests for nearby
areas.

Therefore, explicitly include the EFI config table in the kexec
identity map.

Signed-off-by: Tao Liu <ltao@redhat.com>
Tested-by: Pavin Joseph <me@pavinjoseph.com>
Tested-by: Sarah Brofeldt <srhb@dbc.dk>
Tested-by: Eric Hagberg <ehagberg@gmail.com>
---
 arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

I (Steve Wahl) modified the above commit message, but did not modify
the code.  I am not clear if that requires additional Co-developed-by:
and Signed-off-by: lines.  If so, copy them from here:

Co-developed-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b180d8e497c3..d89942307659 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/efi.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -83,10 +84,12 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 #endif
 
 static int
-map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
+map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 {
 #ifdef CONFIG_EFI
 	unsigned long mstart, mend;
+	void *kaddr;
+	int ret;
 
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
@@ -102,6 +105,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 	if (!mstart)
 		return 0;
 
+	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
+	if (ret)
+		return ret;
+
+	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
+	if (!kaddr) {
+		pr_err("Could not map UEFI system table\n");
+		return -ENOMEM;
+	}
+
+	mstart = efi_config_table;
+
+	if (efi_enabled(EFI_64BIT)) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
+	}
+
+	memunmap(kaddr);
+
 	return kernel_ident_mapping_init(info, level4p, mstart, mend);
 #endif
 	return 0;
@@ -241,10 +268,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	}
 
 	/*
-	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
-	 * not covered by pfn_mapped.
+	 * Prepare EFI systab, config table and ACPI tables for kexec kernel
+	 * since they are not covered by pfn_mapped.
 	 */
-	result = map_efi_systab(&info, level4p);
+	result = map_efi_tables(&info, level4p);
 	if (result)
 		return result;
 
-- 
2.26.2


