Return-Path: <linux-kernel+bounces-184100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6408CA298
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F5F283A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6161384A8;
	Mon, 20 May 2024 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="NB2nmjEI"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0946AE552
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232417; cv=none; b=UHos+OdNDoAVJlHh/Gfolk1t0TaioB0na1SajxQiThcMlUnnWbJ4oJp1TsSsAO3SlWhxJ0Z1hVZ3eOHzzTGJ7J3cPxDxhauvTYxA39TTTs7DhEQKTHephVaarZnSlZBKdiTa2VZnLZ1+LHOrsgEB9uIYgpGhleiIIgDo/TqS1/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232417; c=relaxed/simple;
	bh=BAeLUJ3nqsO8dJX0BxxVNPUiiLjJK0aAAQw4lrODvI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DOPnraIGRRR00sQ0mk9LWUSNrvwQzBROPt9BeHlUbauvAQFGhkW0E8ZbGnsQxbxbi4/uhP3ZusG5r0KG/UwJGu7Iza2cdqUBEa29sgQDP7XESx5TMBAtu+h/lZpKEwaJWYEvbKacVZac4cp9ps2W23vsU6QId47mvIZYjTaY3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=NB2nmjEI; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KISQSj009531;
	Mon, 20 May 2024 18:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=gAeKZTtAY9OBlRuNw6pwsX4ALpDGRNYLZRYeGk5XNeI=;
 b=NB2nmjEIeK2oi4Me2MgeATfD3JcZ5YEE4vZIQyN1PUYr4I/aQ150iu3X6FMWuyBN1inr
 DW9SgIOG5YDL7pvFtbRkzwXpuRj8UV/0+68XjhsQESjcssTlPxE7nvDBv4wpCvnYamvW
 3e+saFHWKZzQ5o1IZstwBqHi/mymac2wZZo83mz+j1NjBM209MJJjfw6Do2qZhHrpEpZ
 /QK2uPr0w1EoYq0xo9sTOYJiko0o9xv8iNvN+53aZ9Mytc016gv0Qlvv2Vxd9EQ52bRK
 hI1BxxC97OrsRDZsBVE/QqjfP4SA0ZXEBqafAJy1KDlvwd+04ZDg/czhi8miuLFC4BIh rg== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3y8btrg23c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 18:36:41 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 7B5A08005D2;
	Mon, 20 May 2024 18:36:39 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 6AFAC80502B;
	Mon, 20 May 2024 18:36:37 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id AE9F130000BA2; Mon, 20 May 2024 13:36:33 -0500 (CDT)
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
Subject: [PATCH 2/3] x86/kexec: Add EFI Confidential Computing blob to kexec identity mapping.
Date: Mon, 20 May 2024 13:36:32 -0500
Message-Id: <20240520183633.1457687-3-steve.wahl@hpe.com>
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
X-Proofpoint-ORIG-GUID: aO2MSBNr8QnlwANVQUbhEPErA966XHQ9
X-Proofpoint-GUID: aO2MSBNr8QnlwANVQUbhEPErA966XHQ9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200149

Like the EFI config table itself, the Confidential Computing blob entry
in that table, if it exists, is referenced by the kexec kernel before
it establishes its own identity map.

This could potentially cause a kexec failure if the CC blob is not
located close to other identity map areas.  Such a failure is more
likely with the nogbpages command line option.

So, explicitly add the CC blob to the kexec identity map.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Tested-by: Pavin Joseph <me@pavinjoseph.com>
Tested-by: Sarah Brofeldt <srhb@dbc.dk>
Tested-by: Eric Hagberg <ehagberg@gmail.com>
---
 arch/x86/kernel/machine_kexec_64.c | 47 +++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index d89942307659..bb68d86ecafe 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -29,6 +29,7 @@
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
 #include <asm/efi.h>
+#include <asm/sev.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -90,6 +91,7 @@ map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 	unsigned long mstart, mend;
 	void *kaddr;
 	int ret;
+	unsigned int cfg_tbl_len;
 
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
@@ -120,16 +122,59 @@ map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
 	if (efi_enabled(EFI_64BIT)) {
 		efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
 
+		cfg_tbl_len = stbl->nr_tables;
 		mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
 	} else {
 		efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
 
+		cfg_tbl_len = stbl->nr_tables;
 		mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
 	}
 
 	memunmap(kaddr);
 
-	return kernel_ident_mapping_init(info, level4p, mstart, mend);
+	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
+	if (ret)
+		return ret;
+
+	/*
+	 * CC blob is referenced in kernel startup before the new
+	 * kernel creates it's own identity map, so make sure it's
+	 * included in the kexec identity map.
+	 */
+	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
+	if (!kaddr) {
+		pr_err("Could not map UEFI config table\n");
+		return -ENOMEM;
+	}
+
+	mstart = 0;
+	if (efi_enabled(EFI_64BIT)) {
+		efi_config_table_64_t *ctbl = (void *) kaddr;
+		int i;
+
+		for (i = 0; i < cfg_tbl_len; i++) {
+			if (!efi_guidcmp(EFI_CC_BLOB_GUID, ctbl[i].guid)) {
+				mstart = ctbl[i].table;
+				mend = mstart + sizeof(struct cc_blob_sev_info);
+				break;
+			}
+		}
+	} else {
+		efi_config_table_32_t *ctbl = (void *) kaddr;
+		int i;
+
+		for (i = 0; i < cfg_tbl_len; i++) {
+			if (!efi_guidcmp(EFI_CC_BLOB_GUID, ctbl[i].guid)) {
+				mstart = ctbl[i].table;
+				mend = mstart + sizeof(struct cc_blob_sev_info);
+				break;
+			}
+		}
+	}
+	memunmap(kaddr);
+	if (mstart)
+		return kernel_ident_mapping_init(info, level4p, mstart, mend);
 #endif
 	return 0;
 }
-- 
2.26.2


