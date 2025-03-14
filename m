Return-Path: <linux-kernel+bounces-561364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525CAA6107D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1037B3B722A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7D41FECA6;
	Fri, 14 Mar 2025 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbXHHMr3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F81FE47C;
	Fri, 14 Mar 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953456; cv=none; b=JpWxNT93qfdvpCG11iYAJIPb1BCzs8+hzN6VllaVeGSyXZusIIsgFZ5ZqE5828SsugdcGAObuUziSrTeF7YUHII/CpCF25QK05CXRd3nJjlREq+wkuiWemlX6DHfyPNKVmRM8SgYzDfBHkaknvuDwNbenzWV+xTfi9I7M+Kzfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953456; c=relaxed/simple;
	bh=tm95Db5wRu54/eu5feiTmRw2Y+aSquDlagLA9PJrArk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltjBxr/DcR/mv+q3mO5PfocQ1MaXC47lIkVoxzHmGdVYSEDOdRW84FVNJYR3DtOS0g4QABllZOpBBb423LORhD2xyBhCBILhphJmzvAf0unAjX0g+jkfBq6w+cuTLyHOWXary80H0EJ+9rhfZz2scJA7BVc98zfrf9Xsl/9RR1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbXHHMr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C833C4CEE9;
	Fri, 14 Mar 2025 11:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741953456;
	bh=tm95Db5wRu54/eu5feiTmRw2Y+aSquDlagLA9PJrArk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbXHHMr3ylPhnAdhZLkg8ehTJuQ/UKZjVUzUzU4oUFAN37s+250Yl0zwJrpctse1h
	 6H5S2UMqLfY9E2Ap7hmCCHMLjRz4we6DC0QtMDzIgJW4YbCd24PyI8MXs0wFADtsQX
	 zq2m4s8I6b5p4YzrfPmIyDWwoLg+H7jyeqFR0xsCTypJVQcYzNVf3jF6MWIpxAS/WB
	 fYuw6XWOWmC1riT9ok9+51UukmoRmUXHwbDWSWi4JLrTx97emTpHyaLNdrfjIkw2Qd
	 4P/hwBriVGDdxdJK/F/u911rtDBwrqinN5E12qowth6GZML9svb3SrptnCNLqMP23a
	 rUZ/kaYpecypQ==
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
Subject: [RFC PATCH v1 2/3] x86/tdx: Make TDX metadata available on guest via SYSFS
Date: Fri, 14 Mar 2025 12:56:27 +0100
Message-ID: <0939e830f94003406dd3ac24126ed28c825c60cf.1741952958.git.legion@kernel.org>
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

Expose information about the TDX module to guest-side. TDX module
information (version, supported features, etc) is crucial for bug
reporting.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/Kconfig        |  1 +
 arch/x86/coco/tdx/tdx.c | 92 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 516f3539d0c7..60f482edb1af 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -906,6 +906,7 @@ config INTEL_TDX_GUEST
 	select X86_MEM_ENCRYPT
 	select X86_MCE
 	select UNACCEPTED_MEMORY
+	select SYS_HYPERVISOR
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 32809a06dab4..86108735aaf1 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
+#include <linux/kobject.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -1051,6 +1052,97 @@ static __init void tdx_announce(void)
 	tdx_dump_td_ctls(controls);
 }
 
+#ifdef CONFIG_SYSFS
+static u64 tdx_read_sys_metadata_field(u64 field_id, u64 *data)
+{
+	struct tdx_module_args args = {};
+	u64 ret;
+
+	/*
+	 * TDH.SYS.RD -- reads one global metadata field
+	 *  - RDX (in): the field to read
+	 *  - R8 (out): the field data
+	 */
+	args.rdx = field_id;
+	ret = __tdcall_ret(TDG_SYS_RD, &args);
+
+	if (ret) {
+		pr_err("failed reading TDX field %llx, return %llx\n", field_id, ret);
+		return ret;
+	}
+
+	*data = args.r8;
+
+	return 0;
+}
+
+#define TDX_SYSFS_ATTR(_field, _name, fmt)				\
+static ssize_t _name ## _show(						\
+	struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
+{									\
+	u64 value = 0;							\
+	tdx_read_sys_metadata_field(_field, &value);			\
+	return sprintf(buf, fmt, value);				\
+}									\
+static struct kobj_attribute _name ## _attr = __ATTR_RO(_name)
+
+TDX_SYSFS_ATTR(TDX_SYS_MINOR_FID, minor, "%lld\n");
+TDX_SYSFS_ATTR(TDX_SYS_MAJOR_FID, major, "%lld\n");
+TDX_SYSFS_ATTR(TDX_SYS_FEATURES0_FID, features0, "%llx\n");
+
+static struct attribute *version_attrs[] = {
+	&minor_attr.attr,
+	&major_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group version_attr_group = {
+	.name = "version",
+	.attrs = version_attrs,
+};
+
+static struct attribute *properties_attrs[] = {
+	&features0_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group properties_attr_group = {
+	.name = "properties",
+	.attrs = properties_attrs,
+};
+
+static int tdx_sysfs_init(void)
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
+			pr_err("sysfs exporting tdx module properties failed %d\n", ret);
+	}
+
+	if (ret)
+		kobject_put(tdx_kobj);
+
+	return ret;
+}
+
+arch_initcall(tdx_sysfs_init);
+#endif // CONFIG_SYSFS
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
-- 
2.48.1


