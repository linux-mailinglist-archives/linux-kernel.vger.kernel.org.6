Return-Path: <linux-kernel+bounces-443228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55EA9EE90C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB41669BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D7221578F;
	Thu, 12 Dec 2024 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PPZcMvkP"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01216215762;
	Thu, 12 Dec 2024 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014254; cv=none; b=T0ZAIFDWfCmaE/xfAT4wRuvNaBiOmVhkJZzywSORIeij/Xa4VkzBQnNRoRZpYxoyILLKtxwlSV9lIkk+/Q+z/AAjLToHQypM14MnnCqOglz27tOit3wwZh4xkdYg6Zbq46Y8Wdvgy/ZkCbc+45uj0v5myrQk+65bOKNAEAdvLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014254; c=relaxed/simple;
	bh=feD3DXoCLdhT9lB45v2q/2BeksiMf8V67v1KVhlT4Jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fh/thaBtROAdgVVxciBOe29y9UmLGj5oGisF0ypVsFy8bZZur83uxLD/oi6YtWiCH5Pm7wz72HFLdBiQnn2929rFmCM+vAln+uob+W+s8xV7OmA3BPmtCQ6T5UZzz6MDMmTs4IcP1noJwQo0hqURl9Kx9eaXJQFOibHOJq2zPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PPZcMvkP; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC5o3e5029256;
	Thu, 12 Dec 2024 08:37:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=9zZHR7dj3VVLKAnugdz9NWglDgR4KcEzM0S+AzeIXEw=; b=
	PPZcMvkPXIxpW7AqxzbKcj8AhrnvRZQDpCjRU4NUPVoGaPb8n2pCp+C+8ndNN6XJ
	T2F0jnPeybnAoq4siObBanSZdO5wcZnKot13xTvBbBQ3TFqfRPQxZBvGQR7Ip+Co
	m77EKh9IFoGPKB+oowKX0qYKaQ7qduIFraZJIbKeuD4rnQa1aRM3/anx9HiO2hQC
	asMcGbMHDCsEs4qD7B4cywLJE5pSR2grMZgZIcD/QUAQPqpYtGXl+A8WHdYr+vqN
	HmEAcI9KqMdmPxSytt2C073WhstB8BDY7yuELPV2q+DYBdfcf4JxtEEB3oZw8Nhr
	fbMr/iACsNIchGABRIhWvQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43cknkexdq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 08:37:27 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 12 Dec
 2024 14:37:25 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 12 Dec 2024 14:37:25 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 262CD822545;
	Thu, 12 Dec 2024 14:37:25 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>
Subject: [PATCH 04/12] firmware: cs_dsp: Add mock bin file generator for KUnit testing
Date: Thu, 12 Dec 2024 14:37:17 +0000
Message-ID: <20241212143725.1381013-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212143725.1381013-1-rf@opensource.cirrus.com>
References: <20241212143725.1381013-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: n31hqlG--rp_Ps8ciQ5Dvt3oIVP8uOuz
X-Proofpoint-GUID: n31hqlG--rp_Ps8ciQ5Dvt3oIVP8uOuz
X-Proofpoint-Spam-Reason: safe

Add a mock firmware file that emulates what the firmware build tools
would normally create. This will be used by KUnit tests to generate a
test bin file.

The data payload in a bin is an opaque blob, so the mock bin only needs
to generate the appropriate file header and description block for each
payload blob.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/test/Makefile         |   1 +
 .../firmware/cirrus/test/cs_dsp_mock_bin.c    | 199 ++++++++++++++++++
 .../linux/firmware/cirrus/cs_dsp_test_utils.h |  18 ++
 3 files changed, 218 insertions(+)
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_mock_bin.c

diff --git a/drivers/firmware/cirrus/test/Makefile b/drivers/firmware/cirrus/test/Makefile
index a67010cb6d66..99aa120718f0 100644
--- a/drivers/firmware/cirrus/test/Makefile
+++ b/drivers/firmware/cirrus/test/Makefile
@@ -3,6 +3,7 @@
 
 cs_dsp_test_utils-objs :=	\
 		cs_dsp_mock_mem_maps.o \
+		cs_dsp_mock_bin.o \
 		cs_dsp_mock_regmap.o \
 		cs_dsp_mock_utils.o \
 		cs_dsp_mock_wmfw.o
diff --git a/drivers/firmware/cirrus/test/cs_dsp_mock_bin.c b/drivers/firmware/cirrus/test/cs_dsp_mock_bin.c
new file mode 100644
index 000000000000..1e271ccfd9b0
--- /dev/null
+++ b/drivers/firmware/cirrus/test/cs_dsp_mock_bin.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// bin file builder for cs_dsp KUnit tests.
+//
+// Copyright (C) 2024 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <kunit/resource.h>
+#include <kunit/test.h>
+#include <linux/firmware/cirrus/cs_dsp.h>
+#include <linux/firmware/cirrus/cs_dsp_test_utils.h>
+#include <linux/firmware/cirrus/wmfw.h>
+#include <linux/firmware.h>
+#include <linux/math.h>
+#include <linux/overflow.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
+
+/* Buffer large enough for bin file content */
+#define CS_DSP_MOCK_BIN_BUF_SIZE	32768
+
+KUNIT_DEFINE_ACTION_WRAPPER(vfree_action_wrapper, vfree, void *)
+
+struct cs_dsp_mock_bin_builder {
+	struct cs_dsp_test *test_priv;
+	void *buf;
+	void *write_p;
+	size_t bytes_used;
+};
+
+/**
+ * cs_dsp_mock_bin_get_firmware() - Get struct firmware wrapper for data.
+ *
+ * @builder:	Pointer to struct cs_dsp_mock_bin_builder.
+ *
+ * Return: Pointer to a struct firmware wrapper for the data.
+ */
+struct firmware *cs_dsp_mock_bin_get_firmware(struct cs_dsp_mock_bin_builder *builder)
+{
+	struct firmware *fw;
+
+	fw = kunit_kzalloc(builder->test_priv->test, sizeof(*fw), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(builder->test_priv->test, fw);
+
+	fw->data = builder->buf;
+	fw->size = builder->bytes_used;
+
+	return fw;
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_bin_get_firmware, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+/**
+ * cs_dsp_mock_bin_add_raw_block() - Add a data block to the bin file.
+ *
+ * @builder:		Pointer to struct cs_dsp_mock_bin_builder.
+ * @alg_ig:		Algorithm ID.
+ * @alg_ver:		Algorithm version.
+ * @type:		Type of the block.
+ * @offset:		Offset.
+ * @payload_data:	Pointer to buffer containing the payload data.
+ * @payload_len_bytes:	Length of payload data in bytes.
+ */
+void cs_dsp_mock_bin_add_raw_block(struct cs_dsp_mock_bin_builder *builder,
+				   unsigned int alg_id, unsigned int alg_ver,
+				   int type, unsigned int offset,
+				   const void *payload_data, size_t payload_len_bytes)
+{
+	struct wmfw_coeff_item *item;
+	size_t bytes_needed = struct_size_t(struct wmfw_coeff_item, data, payload_len_bytes);
+
+	KUNIT_ASSERT_TRUE(builder->test_priv->test,
+			  (builder->write_p + bytes_needed) <
+			  (builder->buf + CS_DSP_MOCK_BIN_BUF_SIZE));
+
+	item = builder->write_p;
+
+	item->offset = cpu_to_le16(offset);
+	item->type = cpu_to_le16(type);
+	item->id = cpu_to_le32(alg_id);
+	item->ver = cpu_to_le32(alg_ver << 8);
+	item->len = cpu_to_le32(payload_len_bytes);
+
+	if (payload_len_bytes)
+		memcpy(item->data, payload_data, payload_len_bytes);
+
+	builder->write_p += bytes_needed;
+	builder->bytes_used += bytes_needed;
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_bin_add_raw_block, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+static void cs_dsp_mock_bin_add_name_or_info(struct cs_dsp_mock_bin_builder *builder,
+					     const char *info, int type)
+{
+	size_t info_len = strlen(info);
+	char *tmp = NULL;
+
+	if (info_len % 4) {
+		/* Create a padded string with length a multiple of 4 */
+		info_len = round_up(info_len, 4);
+		tmp = kunit_kzalloc(builder->test_priv->test, info_len, GFP_KERNEL);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(builder->test_priv->test, tmp);
+		memcpy(tmp, info, info_len);
+		info = tmp;
+	}
+
+	cs_dsp_mock_bin_add_raw_block(builder, 0, 0, WMFW_INFO_TEXT, 0, info, info_len);
+	kunit_kfree(builder->test_priv->test, tmp);
+}
+
+/**
+ * cs_dsp_mock_bin_add_info() - Add an info block to the bin file.
+ *
+ * @builder:	Pointer to struct cs_dsp_mock_bin_builder.
+ * @info:	Pointer to info string to be copied into the file.
+ *
+ * The string will be padded to a length that is a multiple of 4 bytes.
+ */
+void cs_dsp_mock_bin_add_info(struct cs_dsp_mock_bin_builder *builder,
+			      const char *info)
+{
+	cs_dsp_mock_bin_add_name_or_info(builder, info, WMFW_INFO_TEXT);
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_bin_add_info, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+/**
+ * cs_dsp_mock_bin_add_name() - Add a name block to the bin file.
+ *
+ * @builder:	Pointer to struct cs_dsp_mock_bin_builder.
+ * @name:	Pointer to name string to be copied into the file.
+ */
+void cs_dsp_mock_bin_add_name(struct cs_dsp_mock_bin_builder *builder,
+			      const char *name)
+{
+	cs_dsp_mock_bin_add_name_or_info(builder, name, WMFW_NAME_TEXT);
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_bin_add_name, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+/**
+ * cs_dsp_mock_bin_add_patch() - Add a patch data block to the bin file.
+ *
+ * @builder:		Pointer to struct cs_dsp_mock_bin_builder.
+ * @alg_ig:		Algorithm ID for the patch.
+ * @alg_ver:		Algorithm version for the patch.
+ * @mem_region:		Memory region for the patch.
+ * @reg_addr_offset:	Offset to start of data in register addresses.
+ * @payload_data:	Pointer to buffer containing the payload data.
+ * @payload_len_bytes:	Length of payload data in bytes.
+ */
+void cs_dsp_mock_bin_add_patch(struct cs_dsp_mock_bin_builder *builder,
+			       unsigned int alg_id, unsigned int alg_ver,
+			       int mem_region, unsigned int reg_addr_offset,
+			       const void *payload_data, size_t payload_len_bytes)
+{
+	/* Payload length must be a multiple of 4 */
+	KUNIT_ASSERT_EQ(builder->test_priv->test, payload_len_bytes % 4, 0);
+
+	cs_dsp_mock_bin_add_raw_block(builder, alg_id, alg_ver,
+				      mem_region, reg_addr_offset,
+				      payload_data, payload_len_bytes);
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_bin_add_patch, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+/**
+ * cs_dsp_mock_bin_init() - Initialize a struct cs_dsp_mock_bin_builder.
+ *
+ * @priv:		Pointer to struct cs_dsp_test.
+ * @format_version:	Required bin format version.
+ * @fw_version:		Firmware version to put in bin file.
+ *
+ * Return: Pointer to created struct cs_dsp_mock_bin_builder.
+ */
+struct cs_dsp_mock_bin_builder *cs_dsp_mock_bin_init(struct cs_dsp_test *priv,
+						     int format_version,
+						     unsigned int fw_version)
+{
+	struct cs_dsp_mock_bin_builder *builder;
+	struct wmfw_coeff_hdr *hdr;
+
+	builder = kunit_kzalloc(priv->test, sizeof(*builder), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(priv->test, builder);
+	builder->test_priv = priv;
+
+	builder->buf = vmalloc(CS_DSP_MOCK_BIN_BUF_SIZE);
+	KUNIT_ASSERT_NOT_NULL(priv->test, builder->buf);
+	kunit_add_action_or_reset(priv->test, vfree_action_wrapper, builder->buf);
+
+	/* Create header */
+	hdr = builder->buf;
+	memcpy(hdr->magic, "WMDR", sizeof(hdr->magic));
+	hdr->len = cpu_to_le32(offsetof(struct wmfw_coeff_hdr, data));
+	hdr->ver = cpu_to_le32(fw_version | (format_version << 24));
+	hdr->core_ver = cpu_to_le32(((u32)priv->dsp->type << 24) | priv->dsp->rev);
+
+	builder->write_p = hdr->data;
+	builder->bytes_used = offsetof(struct wmfw_coeff_hdr, data);
+
+	return builder;
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_bin_init, "FW_CS_DSP_KUNIT_TEST_UTILS");
diff --git a/include/linux/firmware/cirrus/cs_dsp_test_utils.h b/include/linux/firmware/cirrus/cs_dsp_test_utils.h
index fde7e95a33e9..4f87a908ab4f 100644
--- a/include/linux/firmware/cirrus/cs_dsp_test_utils.h
+++ b/include/linux/firmware/cirrus/cs_dsp_test_utils.h
@@ -78,6 +78,7 @@ struct cs_dsp_mock_xm_header {
 };
 
 struct cs_dsp_mock_wmfw_builder;
+struct cs_dsp_mock_bin_builder;
 
 extern const unsigned int cs_dsp_mock_adsp2_32bit_sysbase;
 extern const unsigned int cs_dsp_mock_adsp2_16bit_sysbase;
@@ -121,6 +122,23 @@ void cs_dsp_mock_regmap_drop_bytes(struct cs_dsp_test *priv,
 void cs_dsp_mock_regmap_drop_system_regs(struct cs_dsp_test *priv);
 bool cs_dsp_mock_regmap_is_dirty(struct cs_dsp_test *priv, bool drop_system_regs);
 
+struct cs_dsp_mock_bin_builder *cs_dsp_mock_bin_init(struct cs_dsp_test *priv,
+						     int format_version,
+						     unsigned int fw_version);
+void cs_dsp_mock_bin_add_raw_block(struct cs_dsp_mock_bin_builder *builder,
+				   unsigned int alg_id, unsigned int alg_ver,
+				   int type, unsigned int offset,
+				   const void *payload_data, size_t payload_len_bytes);
+void cs_dsp_mock_bin_add_info(struct cs_dsp_mock_bin_builder *builder,
+			      const char *info);
+void cs_dsp_mock_bin_add_name(struct cs_dsp_mock_bin_builder *builder,
+			      const char *name);
+void cs_dsp_mock_bin_add_patch(struct cs_dsp_mock_bin_builder *builder,
+			       unsigned int alg_id, unsigned int alg_ver,
+			       int mem_region, unsigned int reg_addr_offset,
+			       const void *payload_data, size_t payload_len_bytes);
+struct firmware *cs_dsp_mock_bin_get_firmware(struct cs_dsp_mock_bin_builder *builder);
+
 struct cs_dsp_mock_wmfw_builder *cs_dsp_mock_wmfw_init(struct cs_dsp_test *priv,
 						       int format_version);
 void cs_dsp_mock_wmfw_add_raw_block(struct cs_dsp_mock_wmfw_builder *builder,
-- 
2.39.5


