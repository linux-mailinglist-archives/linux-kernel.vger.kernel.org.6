Return-Path: <linux-kernel+bounces-320019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6A897051B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11721F21F5F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA7B74068;
	Sun,  8 Sep 2024 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qe30FMro"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52449625
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725771475; cv=none; b=qZWeLAkig9F9IxKJ1PNKjuOcdYsYc5jVwNQAyYSEgBgvjULZSslmvDng8geUxBq+dVAQt2cICoXI1/e06wBZyC/2REUZ9NTQWY8Vm0cSz9MCGaU0AeWxL+GyMJm6C+7WQcvbw096Fr77mI4My8P/IxjHNKaPPRqBjJmAN2+Diss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725771475; c=relaxed/simple;
	bh=TTfU1gIn373WQAv+wSjs1LLHvBRpR9JaaQ4A3DvKcak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MndBmh3qPQYm6UWlp+HYd3rEC7zm3q6C6LpOmYk9rPe8vIaB0n4Rrg+E42cIsbGVEV/Zhmxj0dcMpmTAUmcgodLxL0S7wBiit0HKGUSYpYW44vqlfYGszF7nvKwcvCfCVq1fYWUN1iO9AFWPYlkocPIUyEJYOlSg4C6atzjNECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qe30FMro; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725771473; x=1757307473;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TTfU1gIn373WQAv+wSjs1LLHvBRpR9JaaQ4A3DvKcak=;
  b=Qe30FMro1OD7s4VEeZ4YEJ6ZqyIQZt2DZLJUcV5mebvObCz/DW3/uOER
   620oCHrsrcpnvGByDnD+1DhjUR/WLYLxvIl8M9qdLl7e/KkQBivPJ6PT0
   mN7ch8B4lBqm9TPivyNwrOOg+8C5HqPiSFZu0hbIOkAmhgXIo4n8iYQpR
   ZgHfYBiEBLUY8X3YwBHMMeebplBoR+ctydUN796sf/2qQPhbCkGY5UiKw
   nDBV3q2aZiN8cS7DKJU1RLnWZEBvD4ehMAQOneFI/+m8RA2br+d919lXP
   4+vvYhWCI09XmOEwsNy8/MUKg+/bOAIbKj8wHmeG5NSFpu5pYQmpwENEz
   g==;
X-CSE-ConnectionGUID: Sme3FyfkSNuIeEMj93Pchw==
X-CSE-MsgGUID: x5YujcNcQpWiPmbJ08EIsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="35152178"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="35152178"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 21:57:51 -0700
X-CSE-ConnectionGUID: 07id3TQkQD6aR7ZdNXOj0w==
X-CSE-MsgGUID: B/75QyiQSmya8HRsgEZMJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="70924663"
Received: from ibarbour-mobl.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.116.49])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 21:57:50 -0700
From: Cedric Xing <cedric.xing@intel.com>
Date: Sat, 07 Sep 2024 23:56:21 -0500
Subject: [PATCH RFC 3/3] tsm: Add TVM Measurement Sample Code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240907-tsm-rtmr-v1-3-12fc4d43d4e7@intel.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
In-Reply-To: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
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
    ├── full_report
    ├── report_digest
    ├── rtmr0
    │   ├── append_event
    │   ├── digest
    │   ├── event_log
    │   └── hash_algo
    ├── rtmr1
    │   ├── append_event
    │   ├── digest
    │   ├── event_log
    │   └── hash_algo
    ├── static_mr
    └── user_data

Among the MRs in this example:

- `static_mr` and `config_mr` are static MRs.
- `full_report` illustrates that a complete architecture-dependent attestation
  report structure (for instance, the `TDREPORT` structure in Intel TDX) can be
  presented as an MR.
- `user_data` represents the data provided by the software to be incorporated
  into the attestation report. Writing to this MR and then reading from
  `full_report` effectively triggers a request for an attestation report from
  the underlying CC hardware.
- `report_digest` serves as an example MR to demonstrate the use of the
  `TSM_MR_F_L` flag.
- `rtmr0` is an RTMR with `TSM_MR_F_W` **cleared**, preventing direct
  extensions; as a result, `rtmr0/digest` is read-only, and the sole method to
  extend this RTMR is by writing to `rtmr0/append_event`.
- `rtmr1` is an RTMR with `TSM_MR_F_W` **set**, permitting direct extensions;
  thus, `rtmr1/digest` is writable.

See comments in `samples/tsm/measurement-example.c` for more details.

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
 samples/Kconfig                   |   4 ++
 samples/Makefile                  |   1 +
 samples/tsm/Makefile              |   2 +
 samples/tsm/measurement-example.c | 116 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+)

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
index 000000000000..b10bda4ba1ee
--- /dev/null
+++ b/samples/tsm/measurement-example.c
@@ -0,0 +1,116 @@
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
+	.static_mr = "STATIC MR",
+	.config_mr = "CONFIG MR",
+};
+
+DEFINE_FREE(shash, struct crypto_shash *,
+	    if (!IS_ERR(_T)) crypto_free_shash(_T));
+
+static int _refresh_report(struct tsm_measurement_provider *pvd,
+			   const struct tsm_measurement_register *mr)
+{
+	pr_debug(KBUILD_MODNAME ": %s(%s,%s)\n", __func__, pvd->name,
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
+static int _extend_mr(struct tsm_measurement_provider *pvd,
+		      const struct tsm_measurement_register *mr, const u8 *data)
+{
+	SHASH_DESC_ON_STACK(desc, 0);
+	int rc;
+
+	pr_debug(KBUILD_MODNAME ": %s(%s,%s)\n", __func__, pvd->name,
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
+#define MR_(mr) #mr, &example_report.mr, sizeof(example_report.mr), TSM_MR_F_R
+static const struct tsm_measurement_register example_mrs[] = {
+	/* the entire report can be considered as a LIVE MR */
+	{ "full_report", &example_report, sizeof(example_report),
+	  TSM_MR_F_LIVE },
+	/* static MR, read-only */
+	{ MR_(static_mr) },
+	/* config MR, read-only */
+	{ MR_(config_mr) },
+	/* RTMR, direct extension prohibited */
+	{ MR_(rtmr0) | TSM_MR_F_RTMR, HASH_ALGO_SHA256 },
+	/* RTMR, direct extension allowed */
+	{ MR_(rtmr1) | TSM_MR_F_RTMR | TSM_MR_F_W, HASH_ALGO_SHA384 },
+	/* most CC archs allow including user data in attestation */
+	{ MR_(user_data) | TSM_MR_F_W },
+	/* LIVE MR example, usually doesn't exist in real CC arch */
+	{ MR_(report_digest) | TSM_MR_F_L },
+	/* terminating NULL entry */
+	{}
+};
+#undef MR_
+
+static struct tsm_measurement_provider example_measurement_provider = {
+	.name = "measurement-example",
+	.mrs = example_mrs,
+	.refresh = _refresh_report,
+	.extend = _extend_mr,
+};
+
+static int __init measurement_example_init(void)
+{
+	int rc = tsm_register_measurement_provider(
+		&example_measurement_provider);
+	pr_debug(KBUILD_MODNAME ": tsm_register_measurement_provider(%p)=%d\n",
+		 &example_measurement_provider, rc);
+	return rc;
+}
+
+static void __exit measurement_example_exit(void)
+{
+	int rc = tsm_unregister_measurement_provider(
+		&example_measurement_provider);
+	pr_debug(KBUILD_MODNAME
+		 ": tsm_unregister_measurement_provider(%p)=%d\n",
+		 &example_measurement_provider, rc);
+}
+
+module_init(measurement_example_init);
+module_exit(measurement_example_exit);
+
+MODULE_LICENSE("GPL");

-- 
2.43.0


