Return-Path: <linux-kernel+bounces-272819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3C1946197
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26E11F238D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5819F182C34;
	Fri,  2 Aug 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YsyPVWpq"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4E1A34BF;
	Fri,  2 Aug 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615029; cv=none; b=tFgOL8edXeF3AaTTj1c5FmZ38qLdxcnKajLz6pXMla1iAWt1NbSynY9O5VlY4t0GJDg3UJP/WR27em3BlsYzSeK2kctuHZwW1+VgxnzoT92CBh0yIdS5LHv+agGTFdNLlquJSsueQW29OxOanlT2X3myXKdbao/hoQPEXU/Wbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615029; c=relaxed/simple;
	bh=q8A02mYUwb/X8GpcGBJ8thGH1yUZumvQaljj3kCV8H8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qd9su3WtUvB3lDrW5AaJZzO+ybQ/poy0hhZRHpZnmMV6n71ZldFiQAuX7WINTb8IgRqs30M24AXQcJUY/1mOXfSf0FSRxRY0f22jv15bfaYrm7R70mgO/w72G+THewK0lw9PWRUZP965YjjcciBjdYhdrkkk/+D8UnihM3JOvxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YsyPVWpq; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24A921C0005;
	Fri,  2 Aug 2024 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722615025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IEb2zGDVt4EUtiH92gTMMSiFfEKeaYcnoGkpJ2OoCQ=;
	b=YsyPVWpqkrkHozlTtg8pZb8ZhqYC5sPZ/mh+Oyl8Tqc5favnm+zL0xXxUeQcuik76IMKzi
	p/o1nhc5gYVVMFZJQkyfh5OqLn8p0RZDr9enMfW0EYvinUCwOWwoLJHE7En0fzFRFbzo1d
	05mEkecm6mD9OO4XT2E8IS9ciqLfptxQchJSCyc12HjLIxeWmPJn+FlXpEbQebBSls0WNQ
	FJlQcEFcjkD12TWBFV54hgwsfX5Mch1ZU5ZsB5zP8+FG8zz9tZaGTXnyCamPILQFBL/xXX
	C0gjNxJUI5m/ujSGnGE6kZs1lO/YtR2O+d4nZ5ry9M8hVG9UOV8L17nnYWrLZw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 02 Aug 2024 18:10:00 +0200
Subject: [PATCH v9 15/17] drm/vkms: Create KUnit tests for YUV conversions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-yuv-v9-15-08a706669e16@bootlin.com>
References: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
In-Reply-To: <20240802-yuv-v9-0-08a706669e16@bootlin.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 rdunlap@infradead.org, arthurgrillo@riseup.net, 
 pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13688;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=eng82wogpkespuvZHAHqbRQLSUOoDA4V6ReLel6/gEI=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmrQTb61Iiueyvtr//yfF5NSL+M1QxJEbjs7B+t
 SQZWZ/n7ViJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZq0E2wAKCRAgrS7GWxAs
 4hEnD/93hj+dTE9ned2blTwDf7jVderzQ/hcf+FUW+jl+HX/ReWggdaevBkmh7VJH3J8VOhx3y8
 WHD64m1sofa7gnvZS5SxJF8JCXVO2I6K/TxYjFt1PJYmsTbsHVhl9qLoxIfeHvbF/4bUOU7ekb/
 9rfnnjO8AR2ayRhSFnpBb8FiYhf9POe6y3S94WkgjT3CXEeJ5W3Nq7BFKurGlFiZBtjYTTEk1GE
 NhcO5XP60znrax79MO1ZdOftCDZavT0giExpGpNvANYrlQVq9IOH32axX2K/CByFsxReNUsshry
 YVswwnctdvBN3CnThcvwTJLzwLxorPvZuGrWOXmT9XVeKeUOTgZMq7eej3gVJeFBA0wd80V1j6Y
 a7NrSSsC7vMTkqH9OV9PidcrbYZre25u0YghHmTWUcZWHZ2O89InZWSXv/ZT0kQz2+gI81LEz8S
 92Bch+DPWgzW/zx1kq71YpsItkUnvnqTMKiE2SZHchC3/9IUW4oNTgcQyc1HnSh9iIS5VkFhvnn
 VlBfSyhY4FP/wfXS+635/tyNJQ41gjJ7ZkuruuOQF41r+DH71YWIdbkeOGwl+Cfk4XkR1C+S4k0
 RtJ9KlQT+MSrJL4XMqcvR8jIbQeOyFnLoMoDKZ7XD2DdfPc0QGi9hbGnutuo8aX4JBT7lEVhLTO
 ujGIGNl4QUT0H7Q==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

From: Arthur Grillo <arthurgrillo@riseup.net>

Create KUnit tests to test the conversion between YUV and RGB. Test each
conversion and range combination with some common colors.

The code used to compute the expected result can be found in comment.

[Louis Chauvet:
- fix minor formating issues (whitespace, double line)
- change expected alpha from 0x0000 to 0xffff
- adapt to the new get_conversion_matrix usage
- apply the changes from Arthur
- move struct pixel_yuv_u8 to the test itself]

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/Kconfig                  |  15 ++
 drivers/gpu/drm/vkms/Makefile                 |   1 +
 drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
 drivers/gpu/drm/vkms/tests/Makefile           |   3 +
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 230 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_formats.c           |   7 +-
 drivers/gpu/drm/vkms/vkms_formats.h           |   5 +
 7 files changed, 263 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/Kconfig b/drivers/gpu/drm/vkms/Kconfig
index b9ecdebecb0b..5b6efabdbb17 100644
--- a/drivers/gpu/drm/vkms/Kconfig
+++ b/drivers/gpu/drm/vkms/Kconfig
@@ -13,3 +13,18 @@ config DRM_VKMS
 	  a VKMS.
 
 	  If M is selected the module will be called vkms.
+
+config DRM_VKMS_KUNIT_TESTS
+	tristate "KUnit tests for VKMS." if !KUNIT_ALL_TESTS
+	depends on DRM_VKMS && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds unit tests for VKMS. This option is not useful for
+	  distributions or general kernels, but only for kernel
+	  developers working on VKMS.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in
+	  Documentation/dev-tools/kunit/.
+
+	  If in doubt, say "N".
diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
index 1b28a6a32948..8d3e46dde635 100644
--- a/drivers/gpu/drm/vkms/Makefile
+++ b/drivers/gpu/drm/vkms/Makefile
@@ -9,3 +9,4 @@ vkms-y := \
 	vkms_writeback.o
 
 obj-$(CONFIG_DRM_VKMS) += vkms.o
+obj-$(CONFIG_DRM_VKMS_KUNIT_TESTS) += tests/
diff --git a/drivers/gpu/drm/vkms/tests/.kunitconfig b/drivers/gpu/drm/vkms/tests/.kunitconfig
new file mode 100644
index 000000000000..70e378228cbd
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/.kunitconfig
@@ -0,0 +1,4 @@
+CONFIG_KUNIT=y
+CONFIG_DRM=y
+CONFIG_DRM_VKMS=y
+CONFIG_DRM_VKMS_KUNIT_TESTS=y
diff --git a/drivers/gpu/drm/vkms/tests/Makefile b/drivers/gpu/drm/vkms/tests/Makefile
new file mode 100644
index 000000000000..2d1df668569e
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_DRM_VKMS_KUNIT_TESTS) += vkms_format_test.o
diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
new file mode 100644
index 000000000000..c7c556b4fd98
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <kunit/test.h>
+
+#include <drm/drm_fixed.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_print.h>
+
+#include "../../drm_crtc_internal.h"
+
+#include "../vkms_drv.h"
+#include "../vkms_formats.h"
+
+#define TEST_BUFF_SIZE 50
+
+struct pixel_yuv_u8 {
+	u8 y, u, v;
+};
+
+struct yuv_u8_to_argb_u16_case {
+	enum drm_color_encoding encoding;
+	enum drm_color_range range;
+	size_t n_colors;
+	struct format_pair {
+		char *name;
+		struct pixel_yuv_u8 yuv;
+		struct pixel_argb_u16 argb;
+	} colors[TEST_BUFF_SIZE];
+};
+
+/*
+ * The YUV color representation were acquired via the colour python framework.
+ * Below are the function calls used for generating each case.
+ *
+ * For more information got to the docs:
+ * https://colour.readthedocs.io/en/master/generated/colour.RGB_to_YCbCr.html
+ */
+static struct yuv_u8_to_argb_u16_case yuv_u8_to_argb_u16_cases[] = {
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = False,
+	 *                     out_int = True)
+	 */
+	{
+		.encoding = DRM_COLOR_YCBCR_BT601,
+		.range = DRM_COLOR_YCBCR_FULL_RANGE,
+		.n_colors = 6,
+		.colors = {
+			{ "white", { 0xff, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x80, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x00, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x4c, 0x55, 0xff }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0x96, 0x2c, 0x15 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x1d, 0xff, 0x6b }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+		},
+	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = True,
+	 *                     out_int = True)
+	 */
+	{
+		.encoding = DRM_COLOR_YCBCR_BT601,
+		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
+		.n_colors = 6,
+		.colors = {
+			{ "white", { 0xeb, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x7e, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x10, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x51, 0x5a, 0xf0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0x91, 0x36, 0x22 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x29, 0xf0, 0x6e }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+		},
+	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = False,
+	 *                     out_int = True)
+	 */
+	{
+		.encoding = DRM_COLOR_YCBCR_BT709,
+		.range = DRM_COLOR_YCBCR_FULL_RANGE,
+		.n_colors = 4,
+		.colors = {
+			{ "white", { 0xff, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x80, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x00, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x36, 0x63, 0xff }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0xb6, 0x1e, 0x0c }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x12, 0xff, 0x74 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+		},
+	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
+	 *                     in_bits = 16,
+	 *                     int_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = True,
+	 *                     out_int = True)
+	 */
+	{
+		.encoding = DRM_COLOR_YCBCR_BT709,
+		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
+		.n_colors = 4,
+		.colors = {
+			{ "white", { 0xeb, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x7e, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x10, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x3f, 0x66, 0xf0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0xad, 0x2a, 0x1a }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x20, 0xf0, 0x76 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+		},
+	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = False,
+	 *                     out_int = True)
+	 */
+	{
+		.encoding = DRM_COLOR_YCBCR_BT2020,
+		.range = DRM_COLOR_YCBCR_FULL_RANGE,
+		.n_colors = 4,
+		.colors = {
+			{ "white", { 0xff, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x80, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x00, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x43, 0x5c, 0xff }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0xad, 0x24, 0x0b }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x0f, 0xff, 0x76 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+		},
+	},
+	/*
+	 * colour.RGB_to_YCbCr(<rgb color in 16 bit form>,
+	 *                     K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
+	 *                     in_bits = 16,
+	 *                     in_legal = False,
+	 *                     in_int = True,
+	 *                     out_bits = 8,
+	 *                     out_legal = True,
+	 *                     out_int = True)
+	 */
+	{
+		.encoding = DRM_COLOR_YCBCR_BT2020,
+		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
+		.n_colors = 4,
+		.colors = {
+			{ "white", { 0xeb, 0x80, 0x80 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
+			{ "gray",  { 0x7e, 0x80, 0x80 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
+			{ "black", { 0x10, 0x80, 0x80 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
+			{ "red",   { 0x4a, 0x61, 0xf0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
+			{ "green", { 0xa4, 0x2f, 0x19 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
+			{ "blue",  { 0x1d, 0xf0, 0x77 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
+		},
+	},
+};
+
+static void vkms_format_test_yuv_u8_to_argb_u16(struct kunit *test)
+{
+	const struct yuv_u8_to_argb_u16_case *param = test->param_value;
+	struct pixel_argb_u16 argb;
+
+	for (size_t i = 0; i < param->n_colors; i++) {
+		const struct format_pair *color = &param->colors[i];
+
+		struct conversion_matrix *matrix = get_conversion_matrix_to_argb_u16
+			(DRM_FORMAT_NV12, param->encoding, param->range);
+
+		argb = argb_u16_from_yuv888(color->yuv.y, color->yuv.u, color->yuv.v, matrix);
+
+		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.a, color->argb.a), 257,
+				    "On the A channel of the color %s expected 0x%04x, got 0x%04x",
+				    color->name, color->argb.a, argb.a);
+		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.r, color->argb.r), 257,
+				    "On the R channel of the color %s expected 0x%04x, got 0x%04x",
+				    color->name, color->argb.r, argb.r);
+		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.g, color->argb.g), 257,
+				    "On the G channel of the color %s expected 0x%04x, got 0x%04x",
+				    color->name, color->argb.g, argb.g);
+		KUNIT_EXPECT_LE_MSG(test, abs_diff(argb.b, color->argb.b), 257,
+				    "On the B channel of the color %s expected 0x%04x, got 0x%04x",
+				    color->name, color->argb.b, argb.b);
+	}
+}
+
+static void vkms_format_test_yuv_u8_to_argb_u16_case_desc(struct yuv_u8_to_argb_u16_case *t,
+							  char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s - %s",
+		 drm_get_color_encoding_name(t->encoding), drm_get_color_range_name(t->range));
+}
+
+KUNIT_ARRAY_PARAM(yuv_u8_to_argb_u16, yuv_u8_to_argb_u16_cases,
+		  vkms_format_test_yuv_u8_to_argb_u16_case_desc
+);
+
+static struct kunit_case vkms_format_test_cases[] = {
+	KUNIT_CASE_PARAM(vkms_format_test_yuv_u8_to_argb_u16, yuv_u8_to_argb_u16_gen_params),
+	{}
+};
+
+static struct kunit_suite vkms_format_test_suite = {
+	.name = "vkms-format",
+	.test_cases = vkms_format_test_cases,
+};
+
+kunit_test_suite(vkms_format_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index c985259633e3..199298a365eb 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -7,6 +7,8 @@
 #include <drm/drm_rect.h>
 #include <drm/drm_fixed.h>
 
+#include <kunit/visibility.h>
+
 #include "vkms_formats.h"
 
 /**
@@ -244,8 +246,8 @@ static struct pixel_argb_u16 argb_u16_from_RGB565(const __le16 *pixel)
 	return out_pixel;
 }
 
-static struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
-						  const struct conversion_matrix *matrix)
+VISIBLE_IF_KUNIT struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
+							   const struct conversion_matrix *matrix)
 {
 	u16 r, g, b;
 	s64 fp_y, fp_channel_1, fp_channel_2;
@@ -275,6 +277,7 @@ static struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel
 
 	return argb_u16_from_u16161616(0xffff, r, g, b);
 }
+EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv888);
 
 /*
  * The following functions are read_line function for each pixel format supported by VKMS.
diff --git a/drivers/gpu/drm/vkms/vkms_formats.h b/drivers/gpu/drm/vkms/vkms_formats.h
index d583855cb320..b4fe62ab9c65 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.h
+++ b/drivers/gpu/drm/vkms/vkms_formats.h
@@ -13,4 +13,9 @@ void get_conversion_matrix_to_argb_u16(u32 format, enum drm_color_encoding encod
 				       enum drm_color_range range,
 				       struct conversion_matrix *matrix);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 channel_1, u8 channel_2,
+					   const struct conversion_matrix *matrix);
+#endif
+
 #endif /* _VKMS_FORMATS_H_ */

-- 
2.44.2


