Return-Path: <linux-kernel+bounces-443234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E08E9EE914
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C9D169203
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFAE221DBA;
	Thu, 12 Dec 2024 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Bse7L2xU"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E7821C195;
	Thu, 12 Dec 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014267; cv=none; b=cQkxpIl9tTqojmbBTC1QsT8ibjka9HKflmvq/2ro4QpvCUOyZgnM4fTCPMTiYnKjspyMDlW4BvYfF6VR4/gxzFTCbVATTP6pi6LecUuS0ch9nGyy6CEV++NiWS2iX1/sofKybAb4Ic7075vjTmN2Oq2rT+g/xYw9ADEn6PE5yXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014267; c=relaxed/simple;
	bh=TUHI8UfRUUe4uiedfd4V+zgbDyfl6249NQW0F79X0Tc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZBkYyjLJeYoeyogUcopl/VV9U1cw8jWFpMNel9hfs+d470dRNsq+w8hQ7vVS/t/O668a85vEYMsMeNSJ4umuKOveRuLa2wd/niQGiLanUNUgR8e5XQYGjBW/VFyASieBoMUBT0fG88O8m0Q70sN/6E+7aNPj/GUUEVDB8ydsng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Bse7L2xU; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC5LAls019383;
	Thu, 12 Dec 2024 08:37:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=meZ7+f+LKayyrMAypHUI4aKok7zjkd1wOaFYccjRdGs=; b=
	Bse7L2xUwqLTbuS9yj9GzawTs1HQq+1GBRwljPr2kQYEHyZgFqdEC5z2MqQLB7RW
	KbmkL+mD6rBAqWZvNS2314f/ciPt1z782yI4tpHVNkbR5vSt2+8jE3sJdYqOmaWJ
	XJAOudEfZN5fTEkbephxqjHppI4c6i0V52OUK/JCfawjDfTw0L46I4lFV7JYDkRS
	Gt6sjzSC8bmIDHtRLhUNll5/W9Ives9rP3gmIPa31/bPRG66Nyy1+4qVYmku1dSe
	vGsI2x79M8ux0Z82DK+2ndzv4LzsnZWAXVl+5YedcFQXHlmAwNRN4CmSk7cRQgg4
	eFoP4ikoVy+R9MZuXRmzjg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43cknkexdp-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 08:37:31 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 12 Dec
 2024 14:37:25 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 12 Dec 2024 14:37:25 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 498D682254D;
	Thu, 12 Dec 2024 14:37:25 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>
Subject: [PATCH 12/12] firmware: cs_dsp: Add KUnit testing of client callbacks
Date: Thu, 12 Dec 2024 14:37:25 +0000
Message-ID: <20241212143725.1381013-13-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: BXsAQeiVDeUUCB8woxKfZ_VyyT1H9i4-
X-Proofpoint-GUID: BXsAQeiVDeUUCB8woxKfZ_VyyT1H9i4-
X-Proofpoint-Spam-Reason: safe

Test that the cs_dsp_client_ops callbacks are called when expected.

pre_run, post_run - when cs_dsp_run() is called.
pre_stop, post_stop - when cs_dsp_stop() is called
control_add - when a WMFW is loaded
control_remove - when cs_dsp_remove() is called

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/test/Makefile         |   1 +
 .../cirrus/test/cs_dsp_test_callbacks.c       | 688 ++++++++++++++++++
 2 files changed, 689 insertions(+)
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_test_callbacks.c

diff --git a/drivers/firmware/cirrus/test/Makefile b/drivers/firmware/cirrus/test/Makefile
index 63247c6f5111..7a24a6079ddc 100644
--- a/drivers/firmware/cirrus/test/Makefile
+++ b/drivers/firmware/cirrus/test/Makefile
@@ -11,6 +11,7 @@ cs_dsp_test_utils-objs :=	\
 cs_dsp_test-objs :=	\
 		cs_dsp_test_bin.o \
 		cs_dsp_test_bin_error.o \
+		cs_dsp_test_callbacks.o \
 		cs_dsp_test_control_parse.o \
 		cs_dsp_test_control_cache.o \
 		cs_dsp_test_control_rw.o \
diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_callbacks.c b/drivers/firmware/cirrus/test/cs_dsp_test_callbacks.c
new file mode 100644
index 000000000000..8a9b66a3b7d3
--- /dev/null
+++ b/drivers/firmware/cirrus/test/cs_dsp_test_callbacks.c
@@ -0,0 +1,688 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// KUnit tests for cs_dsp.
+//
+// Copyright (C) 2024 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+//
+
+#include <kunit/device.h>
+#include <kunit/resource.h>
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+#include <linux/build_bug.h>
+#include <linux/firmware/cirrus/cs_dsp.h>
+#include <linux/firmware/cirrus/cs_dsp_test_utils.h>
+#include <linux/firmware/cirrus/wmfw.h>
+#include <linux/random.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+#include <linux/vmalloc.h>
+
+#define ADSP2_LOCK_REGION_CTRL               0x7A
+#define ADSP2_WDT_TIMEOUT_STS_MASK           0x2000
+
+KUNIT_DEFINE_ACTION_WRAPPER(_put_device_wrapper, put_device, struct device *)
+KUNIT_DEFINE_ACTION_WRAPPER(_cs_dsp_remove_wrapper, cs_dsp_remove, struct cs_dsp *)
+
+struct cs_dsp_test_local {
+	struct cs_dsp_mock_wmfw_builder *wmfw_builder;
+
+	int num_control_add;
+	int num_control_remove;
+	int num_pre_run;
+	int num_post_run;
+	int num_pre_stop;
+	int num_post_stop;
+	int num_watchdog_expired;
+
+	struct cs_dsp_coeff_ctl *passed_ctl[16];
+	struct cs_dsp *passed_dsp;
+};
+
+struct cs_dsp_callbacks_test_param {
+	const struct cs_dsp_client_ops *ops;
+	const char *case_name;
+};
+
+static const struct cs_dsp_mock_alg_def cs_dsp_callbacks_test_mock_algs[] = {
+	{
+		.id = 0xfafa,
+		.ver = 0x100000,
+		.xm_size_words = 164,
+		.ym_size_words = 164,
+		.zm_size_words = 164,
+	},
+};
+
+static const struct cs_dsp_mock_coeff_def mock_coeff_template = {
+	.shortname = "Dummy Coeff",
+	.type = WMFW_CTL_TYPE_BYTES,
+	.mem_type = WMFW_ADSP2_YM,
+	.flags = WMFW_CTL_FLAG_VOLATILE,
+	.length_bytes = 4,
+};
+
+static int cs_dsp_test_control_add_callback(struct cs_dsp_coeff_ctl *ctl)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+
+	local->passed_ctl[local->num_control_add] = ctl;
+	local->num_control_add++;
+
+	return 0;
+}
+
+static void cs_dsp_test_control_remove_callback(struct cs_dsp_coeff_ctl *ctl)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+
+	local->passed_ctl[local->num_control_remove] = ctl;
+	local->num_control_remove++;
+}
+
+static int cs_dsp_test_pre_run_callback(struct cs_dsp *dsp)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+
+	local->passed_dsp = dsp;
+	local->num_pre_run++;
+
+	return 0;
+}
+
+static int cs_dsp_test_post_run_callback(struct cs_dsp *dsp)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+
+	local->passed_dsp = dsp;
+	local->num_post_run++;
+
+	return 0;
+}
+
+static void cs_dsp_test_pre_stop_callback(struct cs_dsp *dsp)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+
+	local->passed_dsp = dsp;
+	local->num_pre_stop++;
+}
+
+static void cs_dsp_test_post_stop_callback(struct cs_dsp *dsp)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+
+	local->passed_dsp = dsp;
+	local->num_post_stop++;
+}
+
+static void cs_dsp_test_watchdog_expired_callback(struct cs_dsp *dsp)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+
+	local->passed_dsp = dsp;
+	local->num_watchdog_expired++;
+}
+
+static const struct cs_dsp_client_ops cs_dsp_callback_test_client_ops = {
+	.control_add = cs_dsp_test_control_add_callback,
+	.control_remove = cs_dsp_test_control_remove_callback,
+	.pre_run = cs_dsp_test_pre_run_callback,
+	.post_run = cs_dsp_test_post_run_callback,
+	.pre_stop = cs_dsp_test_pre_stop_callback,
+	.post_stop = cs_dsp_test_post_stop_callback,
+	.watchdog_expired = cs_dsp_test_watchdog_expired_callback,
+};
+
+static const struct cs_dsp_client_ops cs_dsp_callback_test_empty_client_ops = {
+	/* No entries */
+};
+
+static void cs_dsp_test_run_stop_callbacks(struct kunit *test)
+{
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+	struct firmware *wmfw;
+
+	wmfw = cs_dsp_mock_wmfw_get_firmware(local->wmfw_builder);
+
+	KUNIT_EXPECT_EQ(test,
+			cs_dsp_power_up(priv->dsp, wmfw, "wmfw", NULL, NULL, "misc"),
+			0);
+
+	KUNIT_EXPECT_EQ(test, cs_dsp_run(priv->dsp), 0);
+	KUNIT_EXPECT_EQ(test, local->num_pre_run, 1);
+	KUNIT_EXPECT_EQ(test, local->num_post_run, 1);
+	KUNIT_EXPECT_EQ(test, local->num_pre_stop, 0);
+	KUNIT_EXPECT_EQ(test, local->num_post_stop, 0);
+	KUNIT_EXPECT_PTR_EQ(test, local->passed_dsp, priv->dsp);
+	local->passed_dsp = NULL;
+
+	cs_dsp_stop(priv->dsp);
+	KUNIT_EXPECT_EQ(test, local->num_pre_run, 1);
+	KUNIT_EXPECT_EQ(test, local->num_post_run, 1);
+	KUNIT_EXPECT_EQ(test, local->num_pre_stop, 1);
+	KUNIT_EXPECT_EQ(test, local->num_post_stop, 1);
+	KUNIT_EXPECT_PTR_EQ(test, local->passed_dsp, priv->dsp);
+	local->passed_dsp = NULL;
+
+	KUNIT_EXPECT_EQ(test, cs_dsp_run(priv->dsp), 0);
+	KUNIT_EXPECT_EQ(test, local->num_pre_run, 2);
+	KUNIT_EXPECT_EQ(test, local->num_post_run, 2);
+	KUNIT_EXPECT_EQ(test, local->num_pre_stop, 1);
+	KUNIT_EXPECT_EQ(test, local->num_post_stop, 1);
+	KUNIT_EXPECT_PTR_EQ(test, local->passed_dsp, priv->dsp);
+	local->passed_dsp = NULL;
+
+	cs_dsp_stop(priv->dsp);
+	KUNIT_EXPECT_EQ(test, local->num_pre_run, 2);
+	KUNIT_EXPECT_EQ(test, local->num_post_run, 2);
+	KUNIT_EXPECT_EQ(test, local->num_pre_stop, 2);
+	KUNIT_EXPECT_EQ(test, local->num_post_stop, 2);
+	KUNIT_EXPECT_PTR_EQ(test, local->passed_dsp, priv->dsp);
+	local->passed_dsp = NULL;
+}
+
+static void cs_dsp_test_ctl_v1_callbacks(struct kunit *test)
+{
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+	struct cs_dsp_mock_coeff_def def = mock_coeff_template;
+	struct cs_dsp_coeff_ctl *ctl;
+	struct firmware *wmfw;
+	int i;
+
+	/* Add a control for each memory */
+	cs_dsp_mock_wmfw_start_alg_info_block(local->wmfw_builder,
+					      cs_dsp_callbacks_test_mock_algs[0].id,
+					      "dummyalg", NULL);
+	def.shortname = "zm";
+	def.mem_type = WMFW_ADSP2_ZM;
+	cs_dsp_mock_wmfw_add_coeff_desc(local->wmfw_builder, &def);
+
+	def.shortname = "ym";
+	def.mem_type = WMFW_ADSP2_YM;
+	cs_dsp_mock_wmfw_add_coeff_desc(local->wmfw_builder, &def);
+
+	def.shortname = "xm";
+	def.mem_type = WMFW_ADSP2_XM;
+	cs_dsp_mock_wmfw_add_coeff_desc(local->wmfw_builder, &def);
+
+	cs_dsp_mock_wmfw_end_alg_info_block(local->wmfw_builder);
+
+	wmfw = cs_dsp_mock_wmfw_get_firmware(local->wmfw_builder);
+	KUNIT_EXPECT_EQ(test,
+			cs_dsp_power_up(priv->dsp, wmfw, "wmfw", NULL, NULL, "misc"),
+			0);
+
+	/* There should have been an add callback for each control */
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&priv->dsp->ctl_list), 3);
+	KUNIT_EXPECT_EQ(test, local->num_control_add, 3);
+	KUNIT_EXPECT_EQ(test, local->num_control_remove, 0);
+
+	i = 0;
+	list_for_each_entry_reverse(ctl, &priv->dsp->ctl_list, list)
+		KUNIT_EXPECT_PTR_EQ(test, local->passed_ctl[i++], ctl);
+
+	/*
+	 * Call cs_dsp_remove() and there should be a remove callback
+	 * for each control
+	 */
+	memset(local->passed_ctl, 0, sizeof(local->passed_ctl));
+	cs_dsp_remove(priv->dsp);
+
+	/* Prevent double cleanup */
+	kunit_remove_action(priv->test, _cs_dsp_remove_wrapper, priv->dsp);
+
+	KUNIT_EXPECT_EQ(test, local->num_control_add, 3);
+	KUNIT_EXPECT_EQ(test, local->num_control_remove, 3);
+
+	i = 0;
+	list_for_each_entry_reverse(ctl, &priv->dsp->ctl_list, list)
+		KUNIT_EXPECT_PTR_EQ(test, local->passed_ctl[i++], ctl);
+}
+
+static void cs_dsp_test_ctl_v2_callbacks(struct kunit *test)
+{
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+	struct cs_dsp_mock_coeff_def def = mock_coeff_template;
+	struct cs_dsp_coeff_ctl *ctl;
+	struct firmware *wmfw;
+	char name[2] = { };
+	int i;
+
+	/* Add some controls */
+	def.shortname = name;
+	cs_dsp_mock_wmfw_start_alg_info_block(local->wmfw_builder,
+					      cs_dsp_callbacks_test_mock_algs[0].id,
+					      "dummyalg", NULL);
+	for (i = 0; i < ARRAY_SIZE(local->passed_ctl); ++i) {
+		name[0] = 'A' + i;
+		def.offset_dsp_words = i;
+		cs_dsp_mock_wmfw_add_coeff_desc(local->wmfw_builder, &def);
+	}
+	cs_dsp_mock_wmfw_end_alg_info_block(local->wmfw_builder);
+
+	wmfw = cs_dsp_mock_wmfw_get_firmware(local->wmfw_builder);
+	KUNIT_EXPECT_EQ(test,
+			cs_dsp_power_up(priv->dsp, wmfw, "wmfw", NULL, NULL, "misc"),
+			0);
+
+	/* There should have been an add callback for each control */
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&priv->dsp->ctl_list),
+			ARRAY_SIZE(local->passed_ctl));
+	KUNIT_EXPECT_EQ(test, local->num_control_add, ARRAY_SIZE(local->passed_ctl));
+	KUNIT_EXPECT_EQ(test, local->num_control_remove, 0);
+
+	i = 0;
+	list_for_each_entry_reverse(ctl, &priv->dsp->ctl_list, list)
+		KUNIT_EXPECT_PTR_EQ(test, local->passed_ctl[i++], ctl);
+
+	/*
+	 * Call cs_dsp_remove() and there should be a remove callback
+	 * for each control
+	 */
+	memset(local->passed_ctl, 0, sizeof(local->passed_ctl));
+	cs_dsp_remove(priv->dsp);
+
+	/* Prevent double cleanup */
+	kunit_remove_action(priv->test, _cs_dsp_remove_wrapper, priv->dsp);
+
+	KUNIT_EXPECT_EQ(test, local->num_control_add, ARRAY_SIZE(local->passed_ctl));
+	KUNIT_EXPECT_EQ(test, local->num_control_remove, ARRAY_SIZE(local->passed_ctl));
+
+	i = 0;
+	list_for_each_entry_reverse(ctl, &priv->dsp->ctl_list, list)
+		KUNIT_EXPECT_PTR_EQ(test, local->passed_ctl[i++], ctl);
+}
+
+static void cs_dsp_test_no_callbacks(struct kunit *test)
+{
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+	struct cs_dsp_mock_coeff_def def = mock_coeff_template;
+	struct firmware *wmfw;
+
+	/* Add a controls */
+	def.shortname = "A";
+	cs_dsp_mock_wmfw_start_alg_info_block(local->wmfw_builder,
+					      cs_dsp_callbacks_test_mock_algs[0].id,
+					      "dummyalg", NULL);
+	cs_dsp_mock_wmfw_add_coeff_desc(local->wmfw_builder, &def);
+	cs_dsp_mock_wmfw_end_alg_info_block(local->wmfw_builder);
+
+	wmfw = cs_dsp_mock_wmfw_get_firmware(local->wmfw_builder);
+
+	/* Run a sequence of ops that would invoke callbacks */
+	KUNIT_EXPECT_EQ(test,
+			cs_dsp_power_up(priv->dsp, wmfw, "wmfw", NULL, NULL, "misc"),
+			0);
+	KUNIT_EXPECT_EQ(test, cs_dsp_run(priv->dsp), 0);
+	cs_dsp_stop(priv->dsp);
+	cs_dsp_remove(priv->dsp);
+
+	/* Prevent double cleanup */
+	kunit_remove_action(priv->test, _cs_dsp_remove_wrapper, priv->dsp);
+
+	/* Something went very wrong if any of our callbacks were called */
+	KUNIT_EXPECT_EQ(test, local->num_control_add, 0);
+	KUNIT_EXPECT_EQ(test, local->num_control_remove, 0);
+	KUNIT_EXPECT_EQ(test, local->num_pre_run, 0);
+	KUNIT_EXPECT_EQ(test, local->num_post_run, 0);
+	KUNIT_EXPECT_EQ(test, local->num_pre_stop, 0);
+	KUNIT_EXPECT_EQ(test, local->num_post_stop, 0);
+}
+
+static void cs_dsp_test_adsp2v2_watchdog_callback(struct kunit *test)
+{
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+	struct firmware *wmfw;
+
+	wmfw = cs_dsp_mock_wmfw_get_firmware(local->wmfw_builder);
+
+	KUNIT_EXPECT_EQ(test,
+			cs_dsp_power_up(priv->dsp, wmfw, "wmfw", NULL, NULL, "misc"),
+			0);
+
+	KUNIT_EXPECT_EQ(test, cs_dsp_run(priv->dsp), 0);
+
+	/* Set the watchdog timeout bit */
+	regmap_write(priv->dsp->regmap, priv->dsp->base + ADSP2_LOCK_REGION_CTRL,
+		     ADSP2_WDT_TIMEOUT_STS_MASK);
+
+	/* Notify an interrupt and the watchdog callback should be called */
+	cs_dsp_adsp2_bus_error(priv->dsp);
+	KUNIT_EXPECT_EQ(test, local->num_watchdog_expired, 1);
+	KUNIT_EXPECT_PTR_EQ(test, local->passed_dsp, priv->dsp);
+}
+
+static void cs_dsp_test_adsp2v2_watchdog_no_callbacks(struct kunit *test)
+{
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+	struct firmware *wmfw;
+
+	wmfw = cs_dsp_mock_wmfw_get_firmware(local->wmfw_builder);
+	KUNIT_EXPECT_EQ(test,
+			cs_dsp_power_up(priv->dsp, wmfw, "wmfw", NULL, NULL, "misc"),
+			0);
+	KUNIT_EXPECT_EQ(test, cs_dsp_run(priv->dsp), 0);
+
+	/* Set the watchdog timeout bit */
+	regmap_write(priv->dsp->regmap, priv->dsp->base + ADSP2_LOCK_REGION_CTRL,
+		     ADSP2_WDT_TIMEOUT_STS_MASK);
+
+	/* Notify an interrupt, which will look for a watchdog callback */
+	cs_dsp_adsp2_bus_error(priv->dsp);
+	KUNIT_EXPECT_EQ(test, local->num_watchdog_expired, 0);
+}
+
+static void cs_dsp_test_halo_watchdog_callback(struct kunit *test)
+{
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+	struct firmware *wmfw;
+
+	wmfw = cs_dsp_mock_wmfw_get_firmware(local->wmfw_builder);
+
+	KUNIT_EXPECT_EQ(test,
+			cs_dsp_power_up(priv->dsp, wmfw, "wmfw", NULL, NULL, "misc"),
+			0);
+
+	KUNIT_EXPECT_EQ(test, cs_dsp_run(priv->dsp), 0);
+
+	/* Notify an interrupt and the watchdog callback should be called */
+	cs_dsp_halo_wdt_expire(priv->dsp);
+	KUNIT_EXPECT_EQ(test, local->num_watchdog_expired, 1);
+	KUNIT_EXPECT_PTR_EQ(test, local->passed_dsp, priv->dsp);
+}
+
+static void cs_dsp_test_halo_watchdog_no_callbacks(struct kunit *test)
+{
+	struct cs_dsp_test *priv = test->priv;
+	struct cs_dsp_test_local *local = priv->local;
+	struct firmware *wmfw;
+
+	wmfw = cs_dsp_mock_wmfw_get_firmware(local->wmfw_builder);
+	KUNIT_EXPECT_EQ(test,
+			cs_dsp_power_up(priv->dsp, wmfw, "wmfw", NULL, NULL, "misc"),
+			0);
+	KUNIT_EXPECT_EQ(test, cs_dsp_run(priv->dsp), 0);
+
+	/* Notify an interrupt, which will look for a watchdog callback */
+	cs_dsp_halo_wdt_expire(priv->dsp);
+	KUNIT_EXPECT_EQ(test, local->num_watchdog_expired, 0);
+}
+
+static int cs_dsp_callbacks_test_common_init(struct kunit *test, struct cs_dsp *dsp,
+					     int wmfw_version)
+{
+	const struct cs_dsp_callbacks_test_param *param = test->param_value;
+	struct cs_dsp_test *priv;
+	struct cs_dsp_test_local *local;
+	struct device *test_dev;
+	struct cs_dsp_mock_xm_header *xm_header;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	local = kunit_kzalloc(test, sizeof(struct cs_dsp_test_local), GFP_KERNEL);
+	if (!local)
+		return -ENOMEM;
+
+	priv->test = test;
+	priv->dsp = dsp;
+	test->priv = priv;
+	priv->local = local;
+
+	/* Create dummy struct device */
+	test_dev = kunit_device_register(test, "cs_dsp_test_drv");
+	if (IS_ERR(test_dev))
+		return PTR_ERR(test_dev);
+
+	dsp->dev = get_device(test_dev);
+	if (!dsp->dev)
+		return -ENODEV;
+
+	ret = kunit_add_action_or_reset(test, _put_device_wrapper, dsp->dev);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dsp->dev, priv);
+
+	/* Allocate regmap */
+	ret = cs_dsp_mock_regmap_init(priv);
+	if (ret)
+		return ret;
+
+	/*
+	 * There must always be a XM header with at least 1 algorithm,
+	 * so create a dummy one and pre-populate XM so the wmfw doesn't
+	 * have to contain an XM blob.
+	 */
+	xm_header = cs_dsp_create_mock_xm_header(priv,
+						 cs_dsp_callbacks_test_mock_algs,
+						 ARRAY_SIZE(cs_dsp_callbacks_test_mock_algs));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, xm_header);
+	cs_dsp_mock_xm_header_write_to_regmap(xm_header);
+
+	local->wmfw_builder = cs_dsp_mock_wmfw_init(priv, wmfw_version);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, local->wmfw_builder);
+
+	/* Add dummy XM header payload to wmfw */
+	cs_dsp_mock_wmfw_add_data_block(local->wmfw_builder,
+					WMFW_ADSP2_XM, 0,
+					xm_header->blob_data,
+					xm_header->blob_size_bytes);
+
+	/* Init cs_dsp */
+	dsp->client_ops = param->ops;
+
+	switch (dsp->type) {
+	case WMFW_ADSP2:
+		ret = cs_dsp_adsp2_init(dsp);
+		break;
+	case WMFW_HALO:
+		ret = cs_dsp_halo_init(dsp);
+		break;
+	default:
+		KUNIT_FAIL(test, "Untested DSP type %d\n", dsp->type);
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	/* Automatically call cs_dsp_remove() when test case ends */
+	return kunit_add_action_or_reset(priv->test, _cs_dsp_remove_wrapper, dsp);
+}
+
+static int cs_dsp_callbacks_test_halo_init(struct kunit *test)
+{
+	struct cs_dsp *dsp;
+
+	/* Fill in cs_dsp and initialize */
+	dsp = kunit_kzalloc(test, sizeof(*dsp), GFP_KERNEL);
+	if (!dsp)
+		return -ENOMEM;
+
+	dsp->num = 1;
+	dsp->type = WMFW_HALO;
+	dsp->mem = cs_dsp_mock_halo_dsp1_regions;
+	dsp->num_mems = cs_dsp_mock_count_regions(cs_dsp_mock_halo_dsp1_region_sizes);
+	dsp->base = cs_dsp_mock_halo_core_base;
+	dsp->base_sysinfo = cs_dsp_mock_halo_sysinfo_base;
+
+	return cs_dsp_callbacks_test_common_init(test, dsp, 3);
+}
+
+static int cs_dsp_callbacks_test_adsp2_32bit_init(struct kunit *test, int rev)
+{
+	struct cs_dsp *dsp;
+
+	/* Fill in cs_dsp and initialize */
+	dsp = kunit_kzalloc(test, sizeof(*dsp), GFP_KERNEL);
+	if (!dsp)
+		return -ENOMEM;
+
+	dsp->num = 1;
+	dsp->type = WMFW_ADSP2;
+	dsp->rev = rev;
+	dsp->mem = cs_dsp_mock_adsp2_32bit_dsp1_regions;
+	dsp->num_mems = cs_dsp_mock_count_regions(cs_dsp_mock_adsp2_32bit_dsp1_region_sizes);
+	dsp->base = cs_dsp_mock_adsp2_32bit_sysbase;
+
+	return cs_dsp_callbacks_test_common_init(test, dsp, 2);
+}
+
+static int cs_dsp_callbacks_test_adsp2v2_32bit_init(struct kunit *test)
+{
+	return cs_dsp_callbacks_test_adsp2_32bit_init(test, 2);
+}
+
+static int cs_dsp_callbacks_test_adsp2v1_32bit_init(struct kunit *test)
+{
+	return cs_dsp_callbacks_test_adsp2_32bit_init(test, 1);
+}
+
+static int cs_dsp_callbacks_test_adsp2_16bit_init(struct kunit *test)
+{
+	struct cs_dsp *dsp;
+
+	/* Fill in cs_dsp and initialize */
+	dsp = kunit_kzalloc(test, sizeof(*dsp), GFP_KERNEL);
+	if (!dsp)
+		return -ENOMEM;
+
+	dsp->num = 1;
+	dsp->type = WMFW_ADSP2;
+	dsp->rev = 0;
+	dsp->mem = cs_dsp_mock_adsp2_16bit_dsp1_regions;
+	dsp->num_mems = cs_dsp_mock_count_regions(cs_dsp_mock_adsp2_16bit_dsp1_region_sizes);
+	dsp->base = cs_dsp_mock_adsp2_16bit_sysbase;
+
+	return cs_dsp_callbacks_test_common_init(test, dsp, 1);
+}
+
+static void cs_dsp_callbacks_param_desc(const struct cs_dsp_callbacks_test_param *param,
+					char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s", param->case_name);
+}
+
+/* Parameterize on different client callback ops tables */
+static const struct cs_dsp_callbacks_test_param cs_dsp_callbacks_ops_cases[] = {
+	{ .ops =  &cs_dsp_callback_test_client_ops, .case_name = "all ops" },
+};
+
+KUNIT_ARRAY_PARAM(cs_dsp_callbacks_ops,
+		  cs_dsp_callbacks_ops_cases,
+		  cs_dsp_callbacks_param_desc);
+
+static const struct cs_dsp_callbacks_test_param cs_dsp_no_callbacks_cases[] = {
+	{ .ops =  &cs_dsp_callback_test_empty_client_ops, .case_name = "empty ops" },
+};
+
+KUNIT_ARRAY_PARAM(cs_dsp_no_callbacks,
+		  cs_dsp_no_callbacks_cases,
+		  cs_dsp_callbacks_param_desc);
+
+static struct kunit_case cs_dsp_callbacks_adsp2_wmfwv1_test_cases[] = {
+	KUNIT_CASE_PARAM(cs_dsp_test_run_stop_callbacks, cs_dsp_callbacks_ops_gen_params),
+	KUNIT_CASE_PARAM(cs_dsp_test_ctl_v1_callbacks, cs_dsp_callbacks_ops_gen_params),
+	KUNIT_CASE_PARAM(cs_dsp_test_no_callbacks, cs_dsp_no_callbacks_gen_params),
+
+	{ } /* terminator */
+};
+
+static struct kunit_case cs_dsp_callbacks_adsp2_wmfwv2_test_cases[] = {
+	KUNIT_CASE_PARAM(cs_dsp_test_run_stop_callbacks, cs_dsp_callbacks_ops_gen_params),
+	KUNIT_CASE_PARAM(cs_dsp_test_ctl_v2_callbacks, cs_dsp_callbacks_ops_gen_params),
+	KUNIT_CASE_PARAM(cs_dsp_test_no_callbacks, cs_dsp_no_callbacks_gen_params),
+
+	{ } /* terminator */
+};
+
+static struct kunit_case cs_dsp_callbacks_halo_test_cases[] = {
+	KUNIT_CASE_PARAM(cs_dsp_test_run_stop_callbacks, cs_dsp_callbacks_ops_gen_params),
+	KUNIT_CASE_PARAM(cs_dsp_test_ctl_v2_callbacks, cs_dsp_callbacks_ops_gen_params),
+	KUNIT_CASE_PARAM(cs_dsp_test_no_callbacks, cs_dsp_no_callbacks_gen_params),
+
+	{ } /* terminator */
+};
+
+static struct kunit_case cs_dsp_watchdog_adsp2v2_test_cases[] = {
+	KUNIT_CASE_PARAM(cs_dsp_test_adsp2v2_watchdog_callback, cs_dsp_callbacks_ops_gen_params),
+	KUNIT_CASE_PARAM(cs_dsp_test_adsp2v2_watchdog_no_callbacks, cs_dsp_no_callbacks_gen_params),
+
+	{ } /* terminator */
+};
+
+static struct kunit_case cs_dsp_watchdog_halo_test_cases[] = {
+	KUNIT_CASE_PARAM(cs_dsp_test_halo_watchdog_callback, cs_dsp_callbacks_ops_gen_params),
+	KUNIT_CASE_PARAM(cs_dsp_test_halo_watchdog_no_callbacks, cs_dsp_no_callbacks_gen_params),
+
+	{ } /* terminator */
+};
+
+static struct kunit_suite cs_dsp_callbacks_test_halo = {
+	.name = "cs_dsp_callbacks_halo",
+	.init = cs_dsp_callbacks_test_halo_init,
+	.test_cases = cs_dsp_callbacks_halo_test_cases,
+};
+
+static struct kunit_suite cs_dsp_callbacks_test_adsp2v2_32bit = {
+	.name = "cs_dsp_callbacks_adsp2v2_32bit_wmfwv2",
+	.init = cs_dsp_callbacks_test_adsp2v2_32bit_init,
+	.test_cases = cs_dsp_callbacks_adsp2_wmfwv2_test_cases,
+};
+
+static struct kunit_suite cs_dsp_callbacks_test_adsp2v1_32bit = {
+	.name = "cs_dsp_callbacks_adsp2v1_32bit_wmfwv2",
+	.init = cs_dsp_callbacks_test_adsp2v1_32bit_init,
+	.test_cases = cs_dsp_callbacks_adsp2_wmfwv2_test_cases,
+};
+
+static struct kunit_suite cs_dsp_callbacks_test_adsp2_16bit = {
+	.name = "cs_dsp_callbacks_adsp2_16bit_wmfwv1",
+	.init = cs_dsp_callbacks_test_adsp2_16bit_init,
+	.test_cases = cs_dsp_callbacks_adsp2_wmfwv1_test_cases,
+};
+
+static struct kunit_suite cs_dsp_watchdog_test_adsp2v2_32bit = {
+	.name = "cs_dsp_watchdog_adsp2v2_32bit",
+	.init = cs_dsp_callbacks_test_adsp2v2_32bit_init,
+	.test_cases = cs_dsp_watchdog_adsp2v2_test_cases,
+};
+
+static struct kunit_suite cs_dsp_watchdog_test_halo_32bit = {
+	.name = "cs_dsp_watchdog_halo",
+	.init = cs_dsp_callbacks_test_halo_init,
+	.test_cases = cs_dsp_watchdog_halo_test_cases,
+};
+
+kunit_test_suites(&cs_dsp_callbacks_test_halo,
+		  &cs_dsp_callbacks_test_adsp2v2_32bit,
+		  &cs_dsp_callbacks_test_adsp2v1_32bit,
+		  &cs_dsp_callbacks_test_adsp2_16bit,
+		  &cs_dsp_watchdog_test_adsp2v2_32bit,
+		  &cs_dsp_watchdog_test_halo_32bit);
-- 
2.39.5


