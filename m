Return-Path: <linux-kernel+bounces-443231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22069EE90E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22393285244
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53620217707;
	Thu, 12 Dec 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pkB/0c9m"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7C2153F0;
	Thu, 12 Dec 2024 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014260; cv=none; b=RA4xVUXbLI8NG/2gCaWFbheiq0TBO0iMW61lmtWGKXjXSjzLF9/V6OxXCee6GwGV44hiVDkOP7A4Y9arY8n0dP/5cSyXYqAL7w2rmPctiG6GrW8P/AFpbP/e1O9Ssp791LUByvf60YrmcIJ3xcxYB07T5kJMAuPlgX3/Pzc1TRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014260; c=relaxed/simple;
	bh=LHJDzE7VsITleXeKXDF07zRos+HxNWUg3BhTT9Y+fn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIRY6QG0VRP56px0/sm/wni9HNt3pPQ8WWao14ggn4BG31FaJUwjSifBvEe55hPs0m5ujZhg0f3KOw+3cve+NtQRphtTNj4/BBhaiJMfYHdnEkOST+/8VT/EvAD/HZGqjwJKdvdvhCuBd5PWeLdi5uovwPiwOzZM46Ngj9UQUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pkB/0c9m; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC5LAlp019383;
	Thu, 12 Dec 2024 08:37:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=PQJcLv+2aIpltGBm62hVDtzjutvtNT1lwPNCE8UZ1/4=; b=
	pkB/0c9mTNnBN2Fp33zxcPTa65C0JuC3jwDTASQxVBCQfj1v4gf1CYArlVyuMhE4
	0xFDTSVMFtv5Ed1neBSkBvUcWilEP4liPHQ8RVZDPdi0lQOdxkEjawI+2SRCsboH
	Zlkaf+xahIdszH/KSnaVxNdezJA3foUWYyuS9gI722JWIXlX8uuYFmmpUeCctHbS
	vKmXLO51Kux+JPoZvgDMRQdyXe3NfACo7h14njsXqWM0GFqo2gEu/Ax9uEa4Wjei
	Tf+/MOSHUH6t1pQWyOFaafKjtRpkgWkGjMqe256hUKlQs3zbC6nAfmBTOc/nIfKR
	8wwLddE9WjtMY5Ql3AMVtw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43cknkexdp-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 08:37:29 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 12 Dec
 2024 14:37:25 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 12 Dec 2024 14:37:25 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 238FA822544;
	Thu, 12 Dec 2024 14:37:25 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>
Subject: [PATCH 03/12] firmware: cs_dsp: Add mock wmfw file generator for KUnit testing
Date: Thu, 12 Dec 2024 14:37:16 +0000
Message-ID: <20241212143725.1381013-4-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: ELC7cu95fmtaIuU9K7r_edlBwZpKEeHC
X-Proofpoint-GUID: ELC7cu95fmtaIuU9K7r_edlBwZpKEeHC
X-Proofpoint-Spam-Reason: safe

Add a mock firmware file that emulates what the firmware build tools
would normally create. This will be used by KUnit tests to generate a
test wmfw file.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/test/Makefile         |   3 +-
 .../firmware/cirrus/test/cs_dsp_mock_wmfw.c   | 473 ++++++++++++++++++
 .../linux/firmware/cirrus/cs_dsp_test_utils.h |  33 ++
 3 files changed, 508 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c

diff --git a/drivers/firmware/cirrus/test/Makefile b/drivers/firmware/cirrus/test/Makefile
index 8d4f2eb7e5aa..a67010cb6d66 100644
--- a/drivers/firmware/cirrus/test/Makefile
+++ b/drivers/firmware/cirrus/test/Makefile
@@ -4,6 +4,7 @@
 cs_dsp_test_utils-objs :=	\
 		cs_dsp_mock_mem_maps.o \
 		cs_dsp_mock_regmap.o \
-		cs_dsp_mock_utils.o
+		cs_dsp_mock_utils.o \
+		cs_dsp_mock_wmfw.o
 
 obj-$(CONFIG_FW_CS_DSP_KUNIT_TEST_UTILS) += cs_dsp_test_utils.o
diff --git a/drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c b/drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c
new file mode 100644
index 000000000000..d3d84da239a3
--- /dev/null
+++ b/drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// wmfw file builder for cs_dsp KUnit tests.
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
+#define CS_DSP_MOCK_WMFW_BUF_SIZE	131072
+
+struct cs_dsp_mock_wmfw_builder {
+	struct cs_dsp_test *test_priv;
+	int format_version;
+	void *buf;
+	size_t buf_size_bytes;
+	void *write_p;
+	size_t bytes_used;
+
+	void *alg_data_header;
+	unsigned int num_coeffs;
+};
+
+struct wmfw_adsp2_halo_header {
+	struct wmfw_header header;
+	struct wmfw_adsp2_sizes sizes;
+	struct wmfw_footer footer;
+} __packed;
+
+struct wmfw_long_string {
+	__le16 len;
+	u8 data[] __nonstring __counted_by(len);
+} __packed;
+
+struct wmfw_short_string {
+	u8 len;
+	u8 data[] __nonstring __counted_by(len);
+} __packed;
+
+KUNIT_DEFINE_ACTION_WRAPPER(vfree_action_wrapper, vfree, void *)
+
+/**
+ * cs_dsp_mock_wmfw_format_version() - Return format version.
+ *
+ * @builder:	Pointer to struct cs_dsp_mock_wmfw_builder.
+ *
+ * Return: Format version.
+ */
+int cs_dsp_mock_wmfw_format_version(struct cs_dsp_mock_wmfw_builder *builder)
+{
+	return builder->format_version;
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_wmfw_format_version, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+/**
+ * cs_dsp_mock_wmfw_get_firmware() - Get struct firmware wrapper for data.
+ *
+ * @builder:	Pointer to struct cs_dsp_mock_wmfw_builder.
+ *
+ * Return: Pointer to a struct firmware wrapper for the data.
+ */
+struct firmware *cs_dsp_mock_wmfw_get_firmware(struct cs_dsp_mock_wmfw_builder *builder)
+{
+	struct firmware *fw;
+
+	if (!builder)
+		return NULL;
+
+	fw = kunit_kzalloc(builder->test_priv->test, sizeof(*fw), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(builder->test_priv->test, fw);
+
+	fw->data = builder->buf;
+	fw->size = builder->bytes_used;
+
+	return fw;
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_wmfw_get_firmware, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+/**
+ * cs_dsp_mock_wmfw_add_raw_block() - Add a block to the wmfw file.
+ *
+ * @builder:		Pointer to struct cs_dsp_mock_bin_builder.
+ * @block_type:		Block type.
+ * @offset:		Offset.
+ * @payload_data:	Pointer to buffer containing the payload data,
+ *			or NULL if no data.
+ * @payload_len_bytes:	Length of payload data in bytes, or zero.
+ */
+void cs_dsp_mock_wmfw_add_raw_block(struct cs_dsp_mock_wmfw_builder *builder,
+				    int block_type, unsigned int offset,
+				    const void *payload_data, size_t payload_len_bytes)
+{
+	struct wmfw_region *header = builder->write_p;
+	unsigned int bytes_needed = struct_size_t(struct wmfw_region, data, payload_len_bytes);
+
+	KUNIT_ASSERT_TRUE(builder->test_priv->test,
+			  (builder->write_p + bytes_needed) <
+			  (builder->buf + CS_DSP_MOCK_WMFW_BUF_SIZE));
+
+	header->offset = cpu_to_le32(offset | (block_type << 24));
+	header->len = cpu_to_le32(payload_len_bytes);
+	if (payload_len_bytes > 0)
+		memcpy(header->data, payload_data, payload_len_bytes);
+
+	builder->write_p += bytes_needed;
+	builder->bytes_used += bytes_needed;
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_wmfw_add_raw_block, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+/**
+ * cs_dsp_mock_wmfw_add_info() - Add an info block to the wmfw file.
+ *
+ * @builder:	Pointer to struct cs_dsp_mock_bin_builder.
+ * @info:	Pointer to info string to be copied into the file.
+ *
+ * The string will be padded to a length that is a multiple of 4 bytes.
+ */
+void cs_dsp_mock_wmfw_add_info(struct cs_dsp_mock_wmfw_builder *builder,
+			       const char *info)
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
+	cs_dsp_mock_wmfw_add_raw_block(builder, WMFW_INFO_TEXT, 0, info, info_len);
+	kunit_kfree(builder->test_priv->test, tmp);
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_wmfw_add_info, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+/**
+ * cs_dsp_mock_wmfw_add_data_block() - Add a data block to the wmfw file.
+ *
+ * @builder:		  Pointer to struct cs_dsp_mock_bin_builder.
+ * @mem_region:		  Memory region for the block.
+ * @mem_offset_dsp_words: Offset to start of destination in DSP words.
+ * @payload_data:	  Pointer to buffer containing the payload data.
+ * @payload_len_bytes:	  Length of payload data in bytes.
+ */
+void cs_dsp_mock_wmfw_add_data_block(struct cs_dsp_mock_wmfw_builder *builder,
+				     int mem_region, unsigned int mem_offset_dsp_words,
+				     const void *payload_data, size_t payload_len_bytes)
+{
+	/* Blob payload length must be a multiple of 4 */
+	KUNIT_ASSERT_EQ(builder->test_priv->test, payload_len_bytes % 4, 0);
+
+	cs_dsp_mock_wmfw_add_raw_block(builder, mem_region, mem_offset_dsp_words,
+				       payload_data, payload_len_bytes);
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_wmfw_add_data_block, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+void cs_dsp_mock_wmfw_start_alg_info_block(struct cs_dsp_mock_wmfw_builder *builder,
+					   unsigned int alg_id,
+					   const char *name,
+					   const char *description)
+{
+	struct wmfw_region *rgn = builder->write_p;
+	struct wmfw_adsp_alg_data *v1;
+	struct wmfw_short_string *shortstring;
+	struct wmfw_long_string *longstring;
+	size_t bytes_needed, name_len, description_len;
+	int offset;
+
+	/* Bytes needed for region header */
+	bytes_needed = offsetof(struct wmfw_region, data);
+
+	builder->alg_data_header = builder->write_p;
+	builder->num_coeffs = 0;
+
+	switch (builder->format_version) {
+	case 0:
+		KUNIT_FAIL(builder->test_priv->test, "wmfwV0 does not have alg blocks\n");
+		return;
+	case 1:
+		bytes_needed += offsetof(struct wmfw_adsp_alg_data, data);
+		KUNIT_ASSERT_TRUE(builder->test_priv->test,
+				  (builder->write_p + bytes_needed) <
+				  (builder->buf + CS_DSP_MOCK_WMFW_BUF_SIZE));
+
+		memset(builder->write_p, 0, bytes_needed);
+
+		/* Create region header */
+		rgn->offset = cpu_to_le32(WMFW_ALGORITHM_DATA << 24);
+
+		/* Create algorithm entry */
+		v1 = (struct wmfw_adsp_alg_data *)&rgn->data[0];
+		v1->id = cpu_to_le32(alg_id);
+		if (name)
+			strscpy(v1->name, name, sizeof(v1->name));
+
+		if (description)
+			strscpy(v1->descr, description, sizeof(v1->descr));
+		break;
+	default:
+		name_len = 0;
+		description_len = 0;
+
+		if (name)
+			name_len = strlen(name);
+
+		if (description)
+			description_len = strlen(description);
+
+		bytes_needed += sizeof(__le32); /* alg id */
+		bytes_needed += round_up(name_len + sizeof(u8), sizeof(__le32));
+		bytes_needed += round_up(description_len + sizeof(__le16), sizeof(__le32));
+		bytes_needed += sizeof(__le32); /* coeff count */
+
+		KUNIT_ASSERT_TRUE(builder->test_priv->test,
+				  (builder->write_p + bytes_needed) <
+				  (builder->buf + CS_DSP_MOCK_WMFW_BUF_SIZE));
+
+		memset(builder->write_p, 0, bytes_needed);
+
+		/* Create region header */
+		rgn->offset = cpu_to_le32(WMFW_ALGORITHM_DATA << 24);
+
+		/* Create algorithm entry */
+		*(__force __le32 *)&rgn->data[0] = cpu_to_le32(alg_id);
+
+		shortstring = (struct wmfw_short_string *)&rgn->data[4];
+		shortstring->len = name_len;
+
+		if (name_len)
+			memcpy(shortstring->data, name, name_len);
+
+		/* Round up to next __le32 */
+		offset = round_up(4 + struct_size_t(struct wmfw_short_string, data, name_len),
+				  sizeof(__le32));
+
+		longstring = (struct wmfw_long_string *)&rgn->data[offset];
+		longstring->len = cpu_to_le16(description_len);
+
+		if (description_len)
+			memcpy(longstring->data, description, description_len);
+		break;
+	}
+
+	builder->write_p += bytes_needed;
+	builder->bytes_used += bytes_needed;
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_wmfw_start_alg_info_block, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+void cs_dsp_mock_wmfw_add_coeff_desc(struct cs_dsp_mock_wmfw_builder *builder,
+				     const struct cs_dsp_mock_coeff_def *def)
+{
+	struct wmfw_adsp_coeff_data *v1;
+	struct wmfw_short_string *shortstring;
+	struct wmfw_long_string *longstring;
+	size_t bytes_needed, shortname_len, fullname_len, description_len;
+	__le32 *ple32;
+
+	KUNIT_ASSERT_NOT_NULL(builder->test_priv->test, builder->alg_data_header);
+
+	switch (builder->format_version) {
+	case 0:
+		return;
+	case 1:
+		bytes_needed = offsetof(struct wmfw_adsp_coeff_data, data);
+		KUNIT_ASSERT_TRUE(builder->test_priv->test,
+				  (builder->write_p + bytes_needed) <
+				  (builder->buf + CS_DSP_MOCK_WMFW_BUF_SIZE));
+
+		v1 = (struct wmfw_adsp_coeff_data *)builder->write_p;
+		memset(v1, 0, sizeof(*v1));
+		v1->hdr.offset = cpu_to_le16(def->offset_dsp_words);
+		v1->hdr.type = cpu_to_le16(def->mem_type);
+		v1->hdr.size = cpu_to_le32(bytes_needed - sizeof(v1->hdr));
+		v1->ctl_type = cpu_to_le16(def->type);
+		v1->flags = cpu_to_le16(def->flags);
+		v1->len = cpu_to_le32(def->length_bytes);
+
+		if (def->fullname)
+			strscpy(v1->name, def->fullname, sizeof(v1->name));
+
+		if (def->description)
+			strscpy(v1->descr, def->description, sizeof(v1->descr));
+		break;
+	default:
+		fullname_len = 0;
+		description_len = 0;
+		shortname_len = strlen(def->shortname);
+
+		if (def->fullname)
+			fullname_len = strlen(def->fullname);
+
+		if (def->description)
+			description_len = strlen(def->description);
+
+		bytes_needed = sizeof(__le32) * 2; /* type, offset and size */
+		bytes_needed += round_up(shortname_len + sizeof(u8), sizeof(__le32));
+		bytes_needed += round_up(fullname_len + sizeof(u8), sizeof(__le32));
+		bytes_needed += round_up(description_len + sizeof(__le16), sizeof(__le32));
+		bytes_needed += sizeof(__le32) * 2; /* flags, type and length */
+		KUNIT_ASSERT_TRUE(builder->test_priv->test,
+				  (builder->write_p + bytes_needed) <
+				  (builder->buf + CS_DSP_MOCK_WMFW_BUF_SIZE));
+
+		ple32 = (__force __le32 *)builder->write_p;
+		*ple32++ = cpu_to_le32(def->offset_dsp_words | (def->mem_type << 16));
+		*ple32++ = cpu_to_le32(bytes_needed - sizeof(__le32) - sizeof(__le32));
+
+		shortstring = (__force struct wmfw_short_string *)ple32;
+		shortstring->len = shortname_len;
+		memcpy(shortstring->data, def->shortname, shortname_len);
+
+		/* Round up to next __le32 multiple */
+		ple32 += round_up(struct_size_t(struct wmfw_short_string, data, shortname_len),
+				  sizeof(*ple32)) / sizeof(*ple32);
+
+		shortstring = (__force struct wmfw_short_string *)ple32;
+		shortstring->len = fullname_len;
+		memcpy(shortstring->data, def->fullname, fullname_len);
+
+		/* Round up to next __le32 multiple */
+		ple32 += round_up(struct_size_t(struct wmfw_short_string, data, fullname_len),
+				  sizeof(*ple32)) / sizeof(*ple32);
+
+		longstring = (__force struct wmfw_long_string *)ple32;
+		longstring->len = description_len;
+		memcpy(longstring->data, def->description, description_len);
+
+		/* Round up to next __le32 multiple */
+		ple32 += round_up(struct_size_t(struct wmfw_long_string, data, description_len),
+				  sizeof(*ple32)) / sizeof(*ple32);
+
+		*ple32++ = cpu_to_le32(def->type | (def->flags << 16));
+		*ple32 = cpu_to_le32(def->length_bytes);
+		break;
+	}
+
+	builder->write_p += bytes_needed;
+	builder->bytes_used += bytes_needed;
+	builder->num_coeffs++;
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_wmfw_add_coeff_desc, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+void cs_dsp_mock_wmfw_end_alg_info_block(struct cs_dsp_mock_wmfw_builder *builder)
+{
+	struct wmfw_region *rgn = builder->alg_data_header;
+	struct wmfw_adsp_alg_data *v1;
+	const struct wmfw_short_string *shortstring;
+	const struct wmfw_long_string *longstring;
+	size_t offset;
+
+	KUNIT_ASSERT_NOT_NULL(builder->test_priv->test, rgn);
+
+	/* Fill in data size */
+	rgn->len = cpu_to_le32((u8 *)builder->write_p - (u8 *)rgn->data);
+
+	/* Fill in coefficient count */
+	switch (builder->format_version) {
+	case 0:
+		return;
+	case 1:
+		v1 = (struct wmfw_adsp_alg_data *)&rgn->data[0];
+		v1->ncoeff = cpu_to_le32(builder->num_coeffs);
+		break;
+	default:
+		offset = 4; /* skip alg id */
+
+		/* Get name length and round up to __le32 multiple */
+		shortstring = (const struct wmfw_short_string *)&rgn->data[offset];
+		offset += round_up(struct_size_t(struct wmfw_short_string, data, shortstring->len),
+				   sizeof(__le32));
+
+		/* Get description length and round up to __le32 multiple */
+		longstring = (const struct wmfw_long_string *)&rgn->data[offset];
+		offset += round_up(struct_size_t(struct wmfw_long_string, data,
+				   le16_to_cpu(longstring->len)),
+				   sizeof(__le32));
+
+		*(__force __le32 *)&rgn->data[offset] = cpu_to_le32(builder->num_coeffs);
+		break;
+	}
+
+	builder->alg_data_header = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_wmfw_end_alg_info_block, "FW_CS_DSP_KUNIT_TEST_UTILS");
+
+static void cs_dsp_init_adsp2_halo_wmfw(struct cs_dsp_mock_wmfw_builder *builder)
+{
+	struct wmfw_adsp2_halo_header *hdr = builder->buf;
+	const struct cs_dsp *dsp = builder->test_priv->dsp;
+
+	memcpy(hdr->header.magic, "WMFW", sizeof(hdr->header.magic));
+	hdr->header.len = cpu_to_le32(sizeof(*hdr));
+	hdr->header.ver = builder->format_version;
+	hdr->header.core = dsp->type;
+	hdr->header.rev = cpu_to_le16(dsp->rev);
+
+	hdr->sizes.pm = cpu_to_le32(cs_dsp_mock_size_of_region(dsp, WMFW_ADSP2_PM));
+	hdr->sizes.xm = cpu_to_le32(cs_dsp_mock_size_of_region(dsp, WMFW_ADSP2_XM));
+	hdr->sizes.ym = cpu_to_le32(cs_dsp_mock_size_of_region(dsp, WMFW_ADSP2_YM));
+
+	switch (dsp->type) {
+	case WMFW_ADSP2:
+		hdr->sizes.zm = cpu_to_le32(cs_dsp_mock_size_of_region(dsp, WMFW_ADSP2_ZM));
+		break;
+	default:
+		break;
+	}
+
+	builder->write_p = &hdr[1];
+	builder->bytes_used += sizeof(*hdr);
+}
+
+/**
+ * cs_dsp_mock_wmfw_init() - Initialize a struct cs_dsp_mock_wmfw_builder.
+ *
+ * @priv:		Pointer to struct cs_dsp_test.
+ * @format_version:	Required wmfw format version.
+ *
+ * Return: Pointer to created struct cs_dsp_mock_wmfw_builder.
+ */
+struct cs_dsp_mock_wmfw_builder *cs_dsp_mock_wmfw_init(struct cs_dsp_test *priv,
+						       int format_version)
+{
+	struct cs_dsp_mock_wmfw_builder *builder;
+
+	/* If format version isn't given use the default for the target core */
+	if (format_version < 0) {
+		switch (priv->dsp->type) {
+		case WMFW_ADSP2:
+			format_version = 2;
+			break;
+		default:
+			format_version = 3;
+			break;
+		}
+	}
+
+	builder = kunit_kzalloc(priv->test, sizeof(*builder), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(priv->test, builder);
+
+	builder->test_priv = priv;
+	builder->format_version = format_version;
+
+	builder->buf = vmalloc(CS_DSP_MOCK_WMFW_BUF_SIZE);
+	KUNIT_ASSERT_NOT_NULL(priv->test, builder->buf);
+	kunit_add_action_or_reset(priv->test, vfree_action_wrapper, builder->buf);
+
+	builder->buf_size_bytes = CS_DSP_MOCK_WMFW_BUF_SIZE;
+
+	switch (priv->dsp->type) {
+	case WMFW_ADSP2:
+	case WMFW_HALO:
+		cs_dsp_init_adsp2_halo_wmfw(builder);
+		break;
+	default:
+		break;
+	}
+
+	return builder;
+}
+EXPORT_SYMBOL_NS_GPL(cs_dsp_mock_wmfw_init, "FW_CS_DSP_KUNIT_TEST_UTILS");
diff --git a/include/linux/firmware/cirrus/cs_dsp_test_utils.h b/include/linux/firmware/cirrus/cs_dsp_test_utils.h
index 899ae94198aa..fde7e95a33e9 100644
--- a/include/linux/firmware/cirrus/cs_dsp_test_utils.h
+++ b/include/linux/firmware/cirrus/cs_dsp_test_utils.h
@@ -53,6 +53,17 @@ struct cs_dsp_mock_alg_def {
 	unsigned int zm_size_words;
 };
 
+struct cs_dsp_mock_coeff_def {
+	const char *shortname;
+	const char *fullname;
+	const char *description;
+	u16 type;
+	u16 flags;
+	u16 mem_type;
+	unsigned int offset_dsp_words;
+	unsigned int length_bytes;
+};
+
 /**
  * struct cs_dsp_mock_xm_header - XM header builder
  *
@@ -66,6 +77,8 @@ struct cs_dsp_mock_xm_header {
 	size_t blob_size_bytes;
 };
 
+struct cs_dsp_mock_wmfw_builder;
+
 extern const unsigned int cs_dsp_mock_adsp2_32bit_sysbase;
 extern const unsigned int cs_dsp_mock_adsp2_16bit_sysbase;
 extern const unsigned int cs_dsp_mock_halo_core_base;
@@ -107,3 +120,23 @@ void cs_dsp_mock_regmap_drop_bytes(struct cs_dsp_test *priv,
 				   unsigned int first_reg, size_t num_bytes);
 void cs_dsp_mock_regmap_drop_system_regs(struct cs_dsp_test *priv);
 bool cs_dsp_mock_regmap_is_dirty(struct cs_dsp_test *priv, bool drop_system_regs);
+
+struct cs_dsp_mock_wmfw_builder *cs_dsp_mock_wmfw_init(struct cs_dsp_test *priv,
+						       int format_version);
+void cs_dsp_mock_wmfw_add_raw_block(struct cs_dsp_mock_wmfw_builder *builder,
+				    int mem_region, unsigned int mem_offset_dsp_words,
+				    const void *payload_data, size_t payload_len_bytes);
+void cs_dsp_mock_wmfw_add_info(struct cs_dsp_mock_wmfw_builder *builder,
+			       const char *info);
+void cs_dsp_mock_wmfw_add_data_block(struct cs_dsp_mock_wmfw_builder *builder,
+				     int mem_region, unsigned int mem_offset_dsp_words,
+				     const void *payload_data, size_t payload_len_bytes);
+void cs_dsp_mock_wmfw_start_alg_info_block(struct cs_dsp_mock_wmfw_builder *builder,
+					   unsigned int alg_id,
+					   const char *name,
+					   const char *description);
+void cs_dsp_mock_wmfw_add_coeff_desc(struct cs_dsp_mock_wmfw_builder *builder,
+				     const struct cs_dsp_mock_coeff_def *def);
+void cs_dsp_mock_wmfw_end_alg_info_block(struct cs_dsp_mock_wmfw_builder *builder);
+struct firmware *cs_dsp_mock_wmfw_get_firmware(struct cs_dsp_mock_wmfw_builder *builder);
+int cs_dsp_mock_wmfw_format_version(struct cs_dsp_mock_wmfw_builder *builder);
-- 
2.39.5


