Return-Path: <linux-kernel+bounces-390964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E303E9B8097
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35442B21CED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB501BE239;
	Thu, 31 Oct 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luysiLRy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6141BCA01
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393452; cv=none; b=RVKbikRURPJI0JAE9DvnN1Gy+DeKCt7jgQ/RfuUgTWFCpG4nQJ/fWzptuZFmd1tezTHj5sICVFv90xGiTo2CtCnY7YZ5YPQrsjHt0Ia5fuu4aow6igJ6RluFJkZuh0BmdUA1d6NwEd6dzs9Ochr+ASMx5O/Apf9CJYb4F+Ik4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393452; c=relaxed/simple;
	bh=aTQwk6CzetaApV2M7XFjl8hY2E4XUJLOCoDr1Fq3U1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T10oip3b7280naIUuctvUrcKUx/k7EMNm9mdP+Cnp+mLeJ08W41AaZC6Ecdoukg1guWzBisebhl6sGLtiCojQNwDwzgU36JT41eJ8LP3Ydc2/WFdHlfTv+eS7HJJ95BC1TOn/wEXgUdqhBJUZdXyhoLRoka9ikkTa7tIlfHFHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luysiLRy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730393450; x=1761929450;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aTQwk6CzetaApV2M7XFjl8hY2E4XUJLOCoDr1Fq3U1I=;
  b=luysiLRyV7QCjYNIIeEO1x66dtiNFvrY64JbCIDfRj519XjY1iStHpru
   3pV8pyfmOkxWyaUYhGyjvJrbXSYbXOIlToddkWI/bXfOaVlTJ841Zso9U
   +8R0rC+gOKVPfjLDwGbqJ56WrFVfDYWQYxOU/QYUYJRDf7aYbI9Dtpgtv
   GLOLRqeiNRtFbDSamOaQVNr561h2zOtOR/nNlbT6ZgnjMVc8VpbMTjpv9
   bRMO0iPMYbQ2sBIxUM7hKYxCjVDmPKdqTlA9OzOggJ/lpvLKecDhVrp5L
   3dgaz/2qGzthwKoBamqxSoFG+RG8jJURjH7ArUB+183D73EH3JR00Xpcc
   w==;
X-CSE-ConnectionGUID: 081JTuvcRCmPiWjzVCvqJg==
X-CSE-MsgGUID: iyGOJuq2ToqjV6X7Dc8ZHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30312381"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30312381"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:50:49 -0700
X-CSE-ConnectionGUID: 9k0GyuM/QRW9jSXLyo8+hw==
X-CSE-MsgGUID: oTgm1bJiQterzk8Aw7WFOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82217192"
Received: from eschuber-mobl.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.125.64.58])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:50:47 -0700
From: Cedric Xing <cedric.xing@intel.com>
Date: Thu, 31 Oct 2024 11:50:41 -0500
Subject: [PATCH RFC v2 2/2] tsm: Add TVM Measurement Sample Code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241031-tsm-rtmr-v2-2-1a6762795911@intel.com>
References: <20241031-tsm-rtmr-v2-0-1a6762795911@intel.com>
In-Reply-To: <20241031-tsm-rtmr-v2-0-1a6762795911@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Samuel Ortiz <sameo@rivosinc.com>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 Dionna Amalie Glaze <dionnaglaze@google.com>, 
 Qinkun Bao <qinkun@google.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
X-Mailer: b4 0.13.0

This sample kernel module demonstrates how to make MRs accessible to user mode
through TSM.

Once loaded, this module registers a virtual measurement provider with the TSM
core and will result in the directory tree below.

/sys/kernel/tsm/
└── measurement-example
    ├── config_mr
    │   ├── digest
    │   └── hash_algo
    ├── full_report
    ├── report_digest
    │   ├── digest
    │   └── hash_algo
    ├── rtmr0
    │   ├── digest
    │   └── hash_algo
    ├── rtmr1
    │   ├── digest
    │   └── hash_algo
    ├── static_mr
    │   ├── digest
    │   └── hash_algo
    └── user_data
        ├── digest
        └── hash_algo

Among the MRs in this example:

- `static_mr` and `config_mr` are static MRs.
- `full_report` illustrates that a complete architecture-dependent attestation
  report structure (for instance, the `TDREPORT` structure in Intel TDX) can be
  presented as an MR. It also demonstrates exposing measurements in a file.
- `rtmr0` is an RTMR with `TSM_MR_F_W` **cleared**, preventing direct
  extensions; as a result, `rtmr0/digest` is read-only.
- `rtmr1` is an RTMR with `TSM_MR_F_W` **set**, permitting direct extensions;
  thus, `rtmr1/digest` is writable.
- `user_data` represents the data provided by the software to be incorporated
  into the attestation report. Writing to this MR and then reading from
  `full_report` effectively triggers a request for an attestation report from
  the underlying CC hardware.
- `report_digest` serves as an example MR to demonstrate the use of the
  `TSM_MR_F_L` flag.

See comments in `samples/tsm/measurement-example.c` for more details.

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 include/linux/tsm.h               |  63 ++++++++++++++++++++
 samples/Kconfig                   |   4 ++
 samples/Makefile                  |   1 +
 samples/tsm/Makefile              |   2 +
 samples/tsm/measurement-example.c | 117 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 187 insertions(+)

diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 11b0c525be30..291259fc85fc 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -5,6 +5,7 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
+#include <uapi/linux/hash_info.h>
 
 #define TSM_INBLOB_MAX 64
 #define TSM_OUTBLOB_MAX SZ_32K
@@ -109,4 +110,66 @@ struct tsm_ops {
 
 int tsm_register(const struct tsm_ops *ops, void *priv);
 int tsm_unregister(const struct tsm_ops *ops);
+
+/**
+ * struct tsm_measurement_register - describes an architectural measurement
+ *                                   register (MR)
+ * @mr_name: name of the MR
+ * @mr_value: buffer containing the current value of the MR
+ * @mr_size: size of the MR - typically the digest size of @mr_hash
+ * @mr_flags: bitwise OR of flags defined in enum tsm_measurement_register_flag
+ * @mr_hash: optional hash identifier defined in include/uapi/linux/hash_info.h
+ */
+struct tsm_measurement_register {
+	const char *mr_name;
+	void *mr_value;
+	u32 mr_size;
+	u32 mr_flags;
+	enum hash_algo mr_hash;
+};
+
+/**
+ * enum tsm_measurement_register_flag - properties of an MR
+ * @TSM_MR_F_X: this MR supports the extension semantics on write
+ * @TSM_MR_F_W: this MR is writable
+ * @TSM_MR_F_R: this MR is readable. This should typically be set
+ * @TSM_MR_F_L: this MR is live - writes to other MRs may change this MR
+ * @TSM_MR_F_F: present this MR as a file (instead of a directory)
+ * @TSM_MR_F_LIVE: shorthand for L (live) and R (readable)
+ * @TSM_MR_F_RTMR: shorthand for LIVE and X (extensible)
+ */
+enum tsm_measurement_register_flag {
+	TSM_MR_F_X = 1,
+	TSM_MR_F_W = 2,
+	TSM_MR_F_R = 4,
+	TSM_MR_F_L = 8,
+	TSM_MR_F_F = 16,
+	TSM_MR_F_LIVE = TSM_MR_F_L | TSM_MR_F_R,
+	TSM_MR_F_RTMR = TSM_MR_F_LIVE | TSM_MR_F_X,
+};
+
+#define TSM_MR_(mr, hash)                              \
+	.mr_name = #mr, .mr_size = hash##_DIGEST_SIZE, \
+	.mr_hash = HASH_ALGO_##hash, .mr_flags = TSM_MR_F_R
+
+/**
+ * struct tsm_measurement - define CC specific MRs and methods for updating
+ *                          them
+ * @name: name of the measurement provider
+ * @mrs: array of MR definitions ending with mr_name set to %NULL
+ * @refresh: invoked to update the specified MR
+ * @extend: invoked to extend the specified MR with mr_size bytes
+ */
+struct tsm_measurement {
+	const char *name;
+	const struct tsm_measurement_register *mrs;
+	int (*refresh)(struct tsm_measurement *,
+		       const struct tsm_measurement_register *);
+	int (*extend)(struct tsm_measurement *,
+		      const struct tsm_measurement_register *, const u8 *);
+};
+
+int tsm_register_measurement(struct tsm_measurement *);
+int tsm_unregister_measurement(struct tsm_measurement *);
+
 #endif /* __TSM_H */
diff --git a/samples/Kconfig b/samples/Kconfig
index b288d9991d27..8159d3ca6487 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -184,6 +184,10 @@ config SAMPLE_TIMER
 	bool "Timer sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
 
+config SAMPLE_TSM
+	tristate "TSM measurement sample"
+	depends on TSM_REPORTS
+
 config SAMPLE_UHID
 	bool "UHID sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index b85fa64390c5..891f5c12cd39 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
+obj-$(CONFIG_SAMPLE_TSM)		+= tsm/
diff --git a/samples/tsm/Makefile b/samples/tsm/Makefile
new file mode 100644
index 000000000000..3969a59221e9
--- /dev/null
+++ b/samples/tsm/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SAMPLE_TSM) += measurement-example.o
diff --git a/samples/tsm/measurement-example.c b/samples/tsm/measurement-example.c
new file mode 100644
index 000000000000..3abd67d3e569
--- /dev/null
+++ b/samples/tsm/measurement-example.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+#include <linux/module.h>
+#include <linux/tsm.h>
+#include <crypto/hash_info.h>
+#include <crypto/hash.h>
+
+struct __aligned(16)
+{
+	u8 static_mr[SHA384_DIGEST_SIZE];
+	u8 config_mr[SHA512_DIGEST_SIZE];
+	u8 rtmr0[SHA256_DIGEST_SIZE];
+	u8 rtmr1[SHA384_DIGEST_SIZE];
+	u8 user_data[SHA512_DIGEST_SIZE];
+	u8 report_digest[SHA512_DIGEST_SIZE];
+}
+example_report = {
+	.static_mr = "static_mr",
+	.config_mr = "config_mr",
+	.rtmr0 = "rtmr0",
+	.rtmr1 = "rtmr1",
+	.user_data = "user_data",
+};
+
+DEFINE_FREE(shash, struct crypto_shash *,
+	    if (!IS_ERR(_T)) crypto_free_shash(_T));
+
+static int _refresh_report(struct tsm_measurement *tmr,
+			   const struct tsm_measurement_register *mr)
+{
+	pr_debug(KBUILD_MODNAME ": %s(%s,%s)\n", __func__, tmr->name,
+		 mr->mr_name);
+	struct crypto_shash *tfm __free(shash) =
+		crypto_alloc_shash(hash_algo_name[HASH_ALGO_SHA512], 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+	return crypto_shash_tfm_digest(tfm, (u8 *)&example_report,
+				       offsetof(typeof(example_report),
+						report_digest),
+				       example_report.report_digest);
+}
+
+static int _extend_mr(struct tsm_measurement *tmr,
+		      const struct tsm_measurement_register *mr, const u8 *data)
+{
+	SHASH_DESC_ON_STACK(desc, 0);
+	int rc;
+
+	pr_debug(KBUILD_MODNAME ": %s(%s,%s)\n", __func__, tmr->name,
+		 mr->mr_name);
+
+	desc->tfm = crypto_alloc_shash(hash_algo_name[mr->mr_hash], 0, 0);
+	if (IS_ERR(desc->tfm))
+		return PTR_ERR(desc->tfm);
+
+	BUG_ON(crypto_shash_digestsize(desc->tfm) != mr->mr_size);
+
+	rc = crypto_shash_init(desc);
+	if (!rc)
+		rc = crypto_shash_update(desc, mr->mr_value, mr->mr_size);
+	if (!rc)
+		rc = crypto_shash_finup(desc, data, mr->mr_size, mr->mr_value);
+
+	crypto_free_shash(desc->tfm);
+	return rc;
+}
+
+#define MR_(mr, hash) .mr_value = &example_report.mr, TSM_MR_(mr, hash)
+static const struct tsm_measurement_register example_mrs[] = {
+	/* the entire report can be considered as a LIVE MR */
+	{ "full_report", &example_report, sizeof(example_report),
+	  TSM_MR_F_LIVE | TSM_MR_F_F },
+	/* static MR, read-only */
+	{ MR_(static_mr, SHA384) },
+	/* config MR, read-only */
+	{ MR_(config_mr, SHA512) },
+	/* RTMR, direct extension prohibited */
+	{ MR_(rtmr0, SHA256) | TSM_MR_F_RTMR },
+	/* RTMR, direct extension allowed */
+	{ MR_(rtmr1, SHA384) | TSM_MR_F_RTMR | TSM_MR_F_W },
+	/* most CC archs allow including user data in attestation */
+	{ MR_(user_data, SHA512) | TSM_MR_F_W },
+	/* LIVE MR example, usually doesn't exist in real CC arch */
+	{ MR_(report_digest, SHA512) | TSM_MR_F_L },
+	/* terminating NULL entry */
+	{}
+};
+#undef MR_
+
+static struct tsm_measurement example_measurement_provider = {
+	.name = "measurement-example",
+	.mrs = example_mrs,
+	.refresh = _refresh_report,
+	.extend = _extend_mr,
+};
+
+static int __init measurement_example_init(void)
+{
+	int rc = tsm_register_measurement(&example_measurement_provider);
+	pr_debug(KBUILD_MODNAME ": tsm_register_measurement(%p)=%d\n",
+		 &example_measurement_provider, rc);
+	return rc;
+}
+
+static void __exit measurement_example_exit(void)
+{
+	int rc = tsm_unregister_measurement(&example_measurement_provider);
+	pr_debug(KBUILD_MODNAME ": tsm_unregister_measurement(%p)=%d\n",
+		 &example_measurement_provider, rc);
+}
+
+module_init(measurement_example_init);
+module_exit(measurement_example_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Sample tsm_measurement implementation");

-- 
2.43.0


