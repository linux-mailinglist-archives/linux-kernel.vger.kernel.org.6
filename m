Return-Path: <linux-kernel+bounces-528131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7ABA413F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DE81894B59
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D13F1A265E;
	Mon, 24 Feb 2025 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNxRa3o3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C71F60A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367319; cv=none; b=eWOqgeozaZAw7gUhsvWB/dAX7mol9RnpctxhIroB3WykvDEROAeq7+X5UD1wJxLHv0J6U2iNNwy1IWwxEbbriKLCtRQ2wp30nlwimNWL5QkzprSqsLjU/WWHRHC0l12IXixAWY55UEKobFiDSf6UQnM1KkFOE8rRQUGR4cnW6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367319; c=relaxed/simple;
	bh=GiULTZ2ipk+wIUbKL/FpRBpeW8mvkTFvKGmACFzv7hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ucWkGXUixdTAVWBWQx4khJ9i1mFtLH5mMC3VSx2v+pGpuLuhbPro2CqB/hJZRntrM2Gcy7R/1oHEpoK+UKYqC39fo8Nv2GWjXPtarL4zqJYIHOb6Edv2v9GPCF22MoISA3yOtCqF7S5ksEDI/glXHJPGRbVV9T9hG7T0AusQL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNxRa3o3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740367317; x=1771903317;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GiULTZ2ipk+wIUbKL/FpRBpeW8mvkTFvKGmACFzv7hI=;
  b=UNxRa3o3LR275L3Zr0rb855DVgiT6D8JBMCgmqF1ggHEzva5AHmc8bfF
   ePmytQeEMqakWvmnA2In+DuYDvTIVrvRCcbjeNjU+Usljbly4rKyzF5jK
   e1oxcgFWCqeGm8+9T5cqfp38nPAzlBnBiaLnaGeARcrfmQlI9RgR9uD8E
   e616fTkPq8mp+NoQXrZYL7ZW9HZDZJC93ywrCOO7P2mBcBetjEv8BoOzj
   LpweVffm8yEC/id1J80eB3n6ZK9ZVSwefpuoWjl7zzQ7aquopnubdR0Br
   PKf4IeDBBAls6HMnq8H6AgOCzp0BLuc3ReKY/wRvELm92D8YezjzV8MOR
   g==;
X-CSE-ConnectionGUID: YW+kXZPiTnixN0jksf+fPg==
X-CSE-MsgGUID: xrg2+Ca8Q0OCDS2SCbOC7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="28706874"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="28706874"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 19:21:56 -0800
X-CSE-ConnectionGUID: RDRNehVqQZ6Gak3lT0KySw==
X-CSE-MsgGUID: HbGLO86BTV2ZKeoSFt+WEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116441902"
Received: from shanagud-mobl.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.117.251])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 19:21:15 -0800
From: Cedric Xing <cedric.xing@intel.com>
Date: Sun, 23 Feb 2025 21:20:13 -0600
Subject: [PATCH v2 2/4] tsm: Add TSM measurement sample code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250223-tdx-rtmr-v2-2-f2d85b0a5f94@intel.com>
References: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
In-Reply-To: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 Dionna Amalie Glaze <dionnaglaze@google.com>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Dan Middleton <dan.middleton@linux.intel.com>, 
 Mikko Ylinen <mikko.ylinen@linux.intel.com>, 
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: b4 0.13.0

This sample kernel module demonstrates how to make MRs accessible to user
mode through TSM.

Once loaded, this module registers a virtual measurement provider with the
TSM core and will result in the directory tree below.

/sys/kernel/tsm/
└── tsm_mr_sample
    ├── config_mr
    │   └── sha512
    │       └── digest
    ├── report_digest
    │   └── sha512
    │       └── digest
    ├── rtmr0
    │   └── sha256
    │       └── digest
    ├── rtmr1
    │   └── sha384
    │       └── digest
    ├── rtmr_crypto_agile
    │   ├── sha256
    │   │   └── digest
    │   └── sha384
    │       └── digest
    └── static_mr
        └── sha384
            └── digest

Among the MRs in this example:

- `static_mr` and `config_mr` are *Readonly* (static) MRs.
- `rtmr0` is an RTMR with `TSM_MR_F_W` **cleared**, preventing direct
  extensions; as a result, the attribute rtmr0/sha256/digest is read-only.
- `rtmr1` is an RTMR with `TSM_MR_F_W` **set**, permitting direct
  extensions; thus, the attribute rtmr1/sha384/digest is writable.
- `rtmr_crypto_agile` demonstrates a "single" MR that supports multiple
  hash algorithms. Each supported algorithm has a corresponding digest,
  usually referred to as a "bank" in TCG terminology. In this specific
  sample, the 2 banks are aliased to `rtmr0` and `rtmr1`, respectively.
- `report_digest` contains the digest of the internal report structure
  living in this sample module's memory. It is to demonstrate the use of
  the `TSM_MR_F_L` flag. Its value changes each time an RTMR is extended.

More details are available in samples/tsm/tsm_mr_sample.c.

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 MAINTAINERS                 |   1 +
 samples/Kconfig             |  13 ++++++
 samples/Makefile            |   1 +
 samples/tsm/Makefile        |   2 +
 samples/tsm/tsm_mr_sample.c | 107 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5eef4c7234c..1d4232f5269e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24106,6 +24106,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/configfs-tsm
 F:	drivers/virt/coco/tsm*.c
 F:	include/linux/tsm.h
+F:	samples/tsm/*
 
 TRUSTED SERVICES TEE DRIVER
 M:	Balint Dobszay <balint.dobszay@arm.com>
diff --git a/samples/Kconfig b/samples/Kconfig
index 820e00b2ed68..0b4592581648 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -184,6 +184,19 @@ config SAMPLE_TIMER
 	bool "Timer sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
 
+config SAMPLE_TSM_MR
+	tristate "TSM measurement sample"
+	depends on TSM_REPORTS
+	help
+	  Build a sample module that emulates MRs (Measurement Registers) and
+	  exposes them to user mode applications through the TSM sysfs
+	  interface (/sys/kernel/tsm/tsm_mr_sample/).
+
+	  The module name will be tsm-mr-sample when built as a module.
+
+	  Note: TSM_MR_MAXBANKS must be at least 2 for this sample to work
+	  properly.
+
 config SAMPLE_UHID
 	bool "UHID sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index f24cd0d72dd0..c4b6dcc81df6 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
 obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
 obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
+obj-$(CONFIG_SAMPLE_TSM_MR)		+= tsm/
diff --git a/samples/tsm/Makefile b/samples/tsm/Makefile
new file mode 100644
index 000000000000..587c3947b3a7
--- /dev/null
+++ b/samples/tsm/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SAMPLE_TSM_MR) += tsm_mr_sample.o
diff --git a/samples/tsm/tsm_mr_sample.c b/samples/tsm/tsm_mr_sample.c
new file mode 100644
index 000000000000..4c2c6cde36e1
--- /dev/null
+++ b/samples/tsm/tsm_mr_sample.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+
+#define DEBUG
+#define pr_fmt(x) KBUILD_MODNAME ": " x
+
+#include <linux/module.h>
+#include <linux/tsm.h>
+#include <crypto/hash_info.h>
+#include <crypto/hash.h>
+
+struct {
+	u8 static_mr[SHA384_DIGEST_SIZE];
+	u8 config_mr[SHA512_DIGEST_SIZE];
+	u8 rtmr0[SHA256_DIGEST_SIZE];
+	u8 rtmr1[SHA384_DIGEST_SIZE];
+	u8 user_data[SHA512_DIGEST_SIZE];
+	u8 report_digest[SHA512_DIGEST_SIZE];
+} sample_report = {
+	.static_mr = "static_mr",
+	.config_mr = "config_mr",
+	.rtmr0 = "rtmr0",
+	.rtmr1 = "rtmr1",
+	.user_data = "user_data",
+};
+
+DEFINE_FREE(shash, struct crypto_shash *, if (!IS_ERR(_T)) crypto_free_shash(_T));
+
+static int sample_report_refresh(struct tsm_measurement *tmr,
+				 const struct tsm_measurement_register *mr)
+{
+	pr_debug("%s(%s,%s) is called\n", __func__, tmr->name, mr ? mr->mr_name : "<nil>");
+	struct crypto_shash *tfm __free(shash) =
+		crypto_alloc_shash(hash_algo_name[HASH_ALGO_SHA512], 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+	return crypto_shash_tfm_digest(tfm, (u8 *)&sample_report,
+				       offsetof(typeof(sample_report), report_digest),
+				       sample_report.report_digest);
+}
+
+static int sample_report_extend_mr(struct tsm_measurement *tmr,
+				   const struct tsm_measurement_register *mr, const u8 *data)
+{
+	SHASH_DESC_ON_STACK(desc, 0);
+	int rc;
+
+	pr_debug("%s(%s,%s) is called\n", __func__, tmr->name, mr->mr_name);
+
+	desc->tfm = crypto_alloc_shash(hash_algo_name[mr->mr_hash], 0, 0);
+	if (IS_ERR(desc->tfm))
+		return PTR_ERR(desc->tfm);
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
+#define MR_(mr, hash) .mr_value = &sample_report.mr, TSM_MR_(mr, hash)
+static const struct tsm_measurement_register sample_mrs[] = {
+	/* static MR, read-only */
+	{ MR_(static_mr, SHA384) },
+	/* config MR, read-only */
+	{ MR_(config_mr, SHA512) },
+	/* RTMR, direct extension prohibited */
+	{ MR_(rtmr0, SHA256) | TSM_MR_F_RTMR },
+	/* RTMR, direct extension allowed */
+	{ MR_(rtmr1, SHA384) | TSM_MR_F_RTMR | TSM_MR_F_W },
+	/* RTMR, crypto agile, alaised to rtmr0 and rtmr1, respectively */
+	{ .mr_value = &sample_report.rtmr0,
+	  TSM_MR_(rtmr_crypto_agile, SHA256) | TSM_MR_F_RTMR | TSM_MR_F_W },
+	{ .mr_value = &sample_report.rtmr1,
+	  TSM_MR_(rtmr_crypto_agile, SHA384) | TSM_MR_F_RTMR | TSM_MR_F_W },
+	/* most CC archs allow including user data in attestation */
+	{ MR_(report_digest, SHA512) | TSM_MR_F_L },
+	/* terminating NULL entry */
+	{}
+};
+#undef MR_
+
+static struct tsm_measurement sample_mr_provider = {
+	.name = KBUILD_MODNAME,
+	.mrs = sample_mrs,
+	.refresh = sample_report_refresh,
+	.extend = sample_report_extend_mr,
+};
+
+static int __init tsm_mr_sample_init(void)
+{
+	return tsm_register_measurement(&sample_mr_provider);
+}
+
+static void __exit tsm_mr_sample_exit(void)
+{
+	tsm_unregister_measurement(&sample_mr_provider);
+}
+
+module_init(tsm_mr_sample_init);
+module_exit(tsm_mr_sample_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Sample tsm_measurement implementation");

-- 
2.43.0


