Return-Path: <linux-kernel+bounces-561363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340DBA6107A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA503BE1FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342B01FDA92;
	Fri, 14 Mar 2025 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra2ZarS5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE7E1FE456;
	Fri, 14 Mar 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953453; cv=none; b=pdgDKxLGA3IKo1VG30xkylhAexy8tPOTqqojomueu0tu2JQioRLLt9QW/C7dzXk6DKEnqwiNNT9ILURWqEgYCVXr18CK9KGttXSzbWurSsvexGTCULWPDa0XeRBOK5zLKwGDbSiGg78oQG/cGn1NENRYxPNXtgxMiDEiG+h7ULk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953453; c=relaxed/simple;
	bh=RnRA49pNN9qXz0tg17SfmvxsP35g4khWSbmKcWw7Y/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCzRdbxS9nyNxhPgo8sB01F7WSvK7tJX40Lz4T0Jh1zvWw3pS1zWNgacfqP9Mr3GqQdEQBCwF53HjXXZroa9O6wnu2wqLNPZ0kr8pj4Lzx2TY2aM2rObSQIZ5gyFzE4afM4tPsd7Ukal4R7oKhWCpsRUVeHiRg/Z5wsazYi6wpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra2ZarS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CD8C4CEEE;
	Fri, 14 Mar 2025 11:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741953452;
	bh=RnRA49pNN9qXz0tg17SfmvxsP35g4khWSbmKcWw7Y/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ra2ZarS5ZWDa9jg4LikRHKhCf9jAzaPkT3J1neaorZi02LyZGB8fWdwcad8nt/sh8
	 HXmbAkqpbE+CQWdnvcNRxJeibnK6fwr6YUmeieQBmykytum/59Xj2HlnL0gJ6hYnE5
	 IIr0LcyeOlh5e2ZV3BJ59CAO5ZXp006ug3QcGT5IVSPVmXdxe6C0q5j+1v8dIg0Vjn
	 AiAex3j85WKO/4TW5chpBodQ9wOelzqTKeiQ5mV3HKOyXMs/LzwJOTnw6pGSU2oo66
	 +2N18Q08VBQ85CsaLQZbmz6XGLyLZWFlaw/bpdoMNatxxY1/alHKmFvNQ1CiwGW/m5
	 eo0odSrcMA//g==
From: Alexey Gladkov <legion@kernel.org>
To: x86@kernel.org
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	Alexey Gladkov <alexey.gladkov@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Joerg Roedel <jroedel@suse.de>,
	Juergen Gross <jgross@suse.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Larry.Dewey@amd.com,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v1 1/3] x86/tdx: Make TDX metadata available via SYSFS
Date: Fri, 14 Mar 2025 12:56:26 +0100
Message-ID: <ddbf49381eb5d1779e218e022ffc144db5da003e.1741952958.git.legion@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741952958.git.legion@kernel.org>
References: <cover.1741952958.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

Expose the TDX module information to userspace. The version information
is valuable for debugging, as knowing the exact module version can help
reproduce TDX-related issues.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/Kconfig                  |  1 +
 arch/x86/include/asm/shared/tdx.h |  2 +
 arch/x86/include/asm/tdx.h        | 12 +++++
 arch/x86/virt/vmx/tdx/tdx.c       | 74 +++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118..516f3539d0c7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1986,6 +1986,7 @@ config INTEL_TDX_HOST
 	depends on CONTIG_ALLOC
 	depends on !KEXEC_CORE
 	depends on X86_MCE
+	select SYS_HYPERVISOR
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
 	  host and certain physical attacks.  This option enables necessary TDX
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 606d93a1cbac..92ee9dfb21e7 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -18,6 +18,8 @@
 #define TDG_MEM_PAGE_ACCEPT		6
 #define TDG_VM_RD			7
 #define TDG_VM_WR			8
+/* TDG_SYS_RD is available since TDX module version 1.5 and later. */
+#define TDG_SYS_RD			11
 
 /* TDX attributes */
 #define TDX_ATTR_DEBUG_BIT		0
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e6b003fe7f5e..95d748bc8464 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -31,6 +31,18 @@
 #define TDX_SUCCESS		0ULL
 #define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
 
+/*
+ * TDX metadata base field id, used by TDCALL TDG.SYS.RD
+ * See TDX ABI Spec Global Metadata Fields
+ */
+#define TDX_SYS_MINOR_FID		0x0800000100000003ULL
+#define TDX_SYS_MAJOR_FID		0x0800000100000004ULL
+#define TDX_SYS_UPDATE_FID		0x0800000100000005ULL
+#define TDX_SYS_INTERNAL_FID		0x0800000100000006ULL
+#define TDX_SYS_BUILD_DATE_FID		0x8800000200000001ULL
+#define TDX_SYS_BUILD_NUM_FID		0x8800000100000002ULL
+#define TDX_SYS_FEATURES0_FID		0x0A00000300000008ULL
+
 #ifndef __ASSEMBLY__
 
 #include <uapi/asm/mce.h>
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index f5e2a937c1e7..89378e2a1f66 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1869,3 +1869,77 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
 	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
 }
 EXPORT_SYMBOL_GPL(tdh_phymem_page_wbinvd_hkid);
+
+#ifdef CONFIG_SYSFS
+#define TDX_SYSFS_ATTR(_field, _name, fmt)				\
+static ssize_t _name ## _show(						\
+	struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
+{									\
+	u64 value = 0;							\
+	read_sys_metadata_field(_field, &value);			\
+	return sprintf(buf, fmt, value);				\
+}									\
+static struct kobj_attribute _name ## _attr = __ATTR_RO(_name)
+
+TDX_SYSFS_ATTR(TDX_SYS_MINOR_FID, minor, "%lld\n");
+TDX_SYSFS_ATTR(TDX_SYS_MAJOR_FID, major, "%lld\n");
+TDX_SYSFS_ATTR(TDX_SYS_UPDATE_FID, update, "%lld\n");
+TDX_SYSFS_ATTR(TDX_SYS_BUILD_NUM_FID, build_num, "%lld\n");
+TDX_SYSFS_ATTR(TDX_SYS_BUILD_DATE_FID, build_date, "%lld\n");
+TDX_SYSFS_ATTR(TDX_SYS_FEATURES0_FID, features0, "%llx\n");
+
+static struct attribute *version_attrs[] = {
+	&minor_attr.attr,
+	&major_attr.attr,
+	&update_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group version_attr_group = {
+	.name = "version",
+	.attrs = version_attrs,
+};
+
+static struct attribute *properties_attrs[] = {
+	&build_num_attr.attr,
+	&build_date_attr.attr,
+	&features0_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group properties_attr_group = {
+	.name = "properties",
+	.attrs = properties_attrs,
+};
+
+__init static int tdh_sysfs_init(void)
+{
+	struct kobject *tdx_kobj;
+	int ret;
+
+	if (!hypervisor_kobj)
+		return -ENOMEM;
+
+	tdx_kobj = kobject_create_and_add("tdx", hypervisor_kobj);
+
+	if (!tdx_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(tdx_kobj, &version_attr_group);
+	if (ret)
+		pr_err("sysfs exporting tdx module version failed %d\n", ret);
+
+	if (!ret) {
+		ret = sysfs_create_group(tdx_kobj, &properties_attr_group);
+		if (ret)
+			pr_err("sysfs exporting tdx module features failed %d\n", ret);
+	}
+
+	if (ret)
+		kobject_put(tdx_kobj);
+
+	return ret;
+}
+
+arch_initcall(tdh_sysfs_init);
+#endif // CONFIG_SYSFS
-- 
2.48.1


