Return-Path: <linux-kernel+bounces-220113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC3390DCD1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD94285D98
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C69D16EB5C;
	Tue, 18 Jun 2024 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="v4Epk34V"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA48181CF8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740070; cv=none; b=pI6yH2urWrg9yXKsSUHPoIcWiWUCHp3v2TaclI3v0wJiVcQjFtqn9IxsWrB5ul8U1fCJtgQmX2xUE0INLv6k37ffIimsKHVPU6v5IZViY/wvliGnJV9YsfDOAoccTsR2D9yfHSO8BLMeo6A8A+DmZDSa3KWi0b767j9tRg4u26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740070; c=relaxed/simple;
	bh=1e3kZ1puCIL8CyI4i0fGlSKE4dknU895shMD9hJApwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vx2U6dBFueDKd8oqNXXUNZqk6lEYOJT/Cu3KLpbQibx2GGW9+okztVsPMYkuzI16Mjl3oSf7k+wrYSSEsmb1zP5cK0vK0oOzvP8QMnF3BgCBtWhfOtITfIYCfFojcoM+MIQWcGy9ngTo0FaqDOj8lj0lXZ/F2BePRbVWKM6mtfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=v4Epk34V; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718740053; bh=IsCrJeIVgqZQ0uPS4re4coKeRrjUqPudPG7JrJTjDNM=;
 b=v4Epk34Vs1PPeN2oMrpkyEtTjxjKR2VGNq7PwU4R5xFAwlMnpj5UxiOm7QesS+Z0CQTtJNimX
 zPCBm5OFXgugdwjqaz8taBbmRY0DQrJrLe1yx0NWhPuRo3s2vGbeHrJKU7XLnmNMkvsNP3ZMmB5
 NqanWpyrLZ8KiB6maOgJMGqC39xiST/Rx81V72ERLIftB81Pax1Zyv6YUR3VmxRU4veaOlDtylD
 YVA7lQUcQm1KNsWxltxYiIkOdwb3CxXyDeKRafoOYtk5HJbT1JHfFqeY60PASy1tajxX8H4ZOQ/
 EfwODraRGbXgNYCgO8GNAlbcbvjYZxx0HqQnhBxpZeaw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: Alex Bee <knaerzche@gmail.com>, Nicolas Dufresne
 <nicolas.dufresne@collabora.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Sebastian Fricke
 <sebastian.fricke@collabora.com>, Christopher Obbard
 <chris.obbard@collabora.com>, Detlev Casanova
 <detlev.casanova@collabora.com>, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v5 08/10] media: rkvdec: Add image format concept
Date: Tue, 18 Jun 2024 19:46:32 +0000
Message-ID: <20240618194647.742037-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618194647.742037-1-jonas@kwiboo.se>
References: <20240618194647.742037-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6671e45164ade33c9005a001

Add an enum rkvdec_image_fmt used to signal an image format, e.g.
4:2:0 8-bit, 4:2:0 10-bit or any.

Tag each supported CAPUTRE format with an image format and use this tag
to filter out unsupported CAPTURE formats.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Christopher Obbard <chris.obbard@collabora.com>
---
v5:
- Collect t-b tags

v4:
- Change fmt_opaque into an image format
- Split patch into two

v3:
- New patch

 drivers/staging/media/rkvdec/rkvdec.c | 45 ++++++++++++++++++++-------
 drivers/staging/media/rkvdec/rkvdec.h | 13 +++++++-
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index efbf9aa578ae..d8fb2d935ffc 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -27,26 +27,42 @@
 #include "rkvdec.h"
 #include "rkvdec-regs.h"
 
-static u32 rkvdec_enum_decoded_fmt(struct rkvdec_ctx *ctx, int index)
+static inline bool rkvdec_image_fmt_match(enum rkvdec_image_fmt fmt1,
+					  enum rkvdec_image_fmt fmt2)
+{
+	return fmt1 == fmt2 || fmt2 == RKVDEC_IMG_FMT_ANY ||
+	       fmt1 == RKVDEC_IMG_FMT_ANY;
+}
+
+static u32 rkvdec_enum_decoded_fmt(struct rkvdec_ctx *ctx, int index,
+				   enum rkvdec_image_fmt image_fmt)
 {
 	const struct rkvdec_coded_fmt_desc *desc = ctx->coded_fmt_desc;
+	unsigned int i, j;
 
 	if (WARN_ON(!desc))
 		return 0;
 
-	if (index >= desc->num_decoded_fmts)
-		return 0;
+	for (i = 0, j = 0; i < desc->num_decoded_fmts; i++) {
+		if (rkvdec_image_fmt_match(desc->decoded_fmts[i].image_fmt,
+					   image_fmt) &&
+		    index == j++)
+			return desc->decoded_fmts[i].fourcc;
+	}
 
-	return desc->decoded_fmts[index];
+	return 0;
 }
 
-static bool rkvdec_is_valid_fmt(struct rkvdec_ctx *ctx, u32 fourcc)
+static bool rkvdec_is_valid_fmt(struct rkvdec_ctx *ctx, u32 fourcc,
+				enum rkvdec_image_fmt image_fmt)
 {
 	const struct rkvdec_coded_fmt_desc *desc = ctx->coded_fmt_desc;
 	unsigned int i;
 
 	for (i = 0; i < desc->num_decoded_fmts; i++) {
-		if (desc->decoded_fmts[i] == fourcc)
+		if (rkvdec_image_fmt_match(desc->decoded_fmts[i].image_fmt,
+					   image_fmt) &&
+		    desc->decoded_fmts[i].fourcc == fourcc)
 			return true;
 	}
 
@@ -80,7 +96,7 @@ static void rkvdec_reset_decoded_fmt(struct rkvdec_ctx *ctx)
 	struct v4l2_format *f = &ctx->decoded_fmt;
 	u32 fourcc;
 
-	fourcc = rkvdec_enum_decoded_fmt(ctx, 0);
+	fourcc = rkvdec_enum_decoded_fmt(ctx, 0, ctx->image_fmt);
 	rkvdec_reset_fmt(ctx, f, fourcc);
 	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
 	f->fmt.pix_mp.width = ctx->coded_fmt.fmt.pix_mp.width;
@@ -149,8 +165,11 @@ static const struct rkvdec_ctrls rkvdec_h264_ctrls = {
 	.num_ctrls = ARRAY_SIZE(rkvdec_h264_ctrl_descs),
 };
 
-static const u32 rkvdec_h264_vp9_decoded_fmts[] = {
-	V4L2_PIX_FMT_NV12,
+static const struct rkvdec_decoded_fmt_desc rkvdec_h264_vp9_decoded_fmts[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_NV12,
+		.image_fmt = RKVDEC_IMG_FMT_420_8BIT,
+	},
 };
 
 static const struct rkvdec_ctrl_desc rkvdec_vp9_ctrl_descs[] = {
@@ -282,8 +301,9 @@ static int rkvdec_try_capture_fmt(struct file *file, void *priv,
 	if (WARN_ON(!coded_desc))
 		return -EINVAL;
 
-	if (!rkvdec_is_valid_fmt(ctx, pix_mp->pixelformat))
-		pix_mp->pixelformat = rkvdec_enum_decoded_fmt(ctx, 0);
+	if (!rkvdec_is_valid_fmt(ctx, pix_mp->pixelformat, ctx->image_fmt))
+		pix_mp->pixelformat = rkvdec_enum_decoded_fmt(ctx, 0,
+							      ctx->image_fmt);
 
 	/* Always apply the frmsize constraint of the coded end. */
 	pix_mp->width = max(pix_mp->width, ctx->coded_fmt.fmt.pix_mp.width);
@@ -400,6 +420,7 @@ static int rkvdec_s_output_fmt(struct file *file, void *priv,
 	 *
 	 * Note that this will propagates any size changes to the decoded format.
 	 */
+	ctx->image_fmt = RKVDEC_IMG_FMT_ANY;
 	rkvdec_reset_decoded_fmt(ctx);
 
 	/* Propagate colorspace information to capture. */
@@ -449,7 +470,7 @@ static int rkvdec_enum_capture_fmt(struct file *file, void *priv,
 	struct rkvdec_ctx *ctx = fh_to_rkvdec_ctx(priv);
 	u32 fourcc;
 
-	fourcc = rkvdec_enum_decoded_fmt(ctx, f->index);
+	fourcc = rkvdec_enum_decoded_fmt(ctx, f->index, ctx->image_fmt);
 	if (!fourcc)
 		return -EINVAL;
 
diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
index 633335ebb9c4..6f8cf50c5d99 100644
--- a/drivers/staging/media/rkvdec/rkvdec.h
+++ b/drivers/staging/media/rkvdec/rkvdec.h
@@ -75,13 +75,23 @@ struct rkvdec_coded_fmt_ops {
 	int (*try_ctrl)(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl);
 };
 
+enum rkvdec_image_fmt {
+	RKVDEC_IMG_FMT_ANY = 0,
+	RKVDEC_IMG_FMT_420_8BIT,
+};
+
+struct rkvdec_decoded_fmt_desc {
+	u32 fourcc;
+	enum rkvdec_image_fmt image_fmt;
+};
+
 struct rkvdec_coded_fmt_desc {
 	u32 fourcc;
 	struct v4l2_frmsize_stepwise frmsize;
 	const struct rkvdec_ctrls *ctrls;
 	const struct rkvdec_coded_fmt_ops *ops;
 	unsigned int num_decoded_fmts;
-	const u32 *decoded_fmts;
+	const struct rkvdec_decoded_fmt_desc *decoded_fmts;
 	u32 subsystem_flags;
 };
 
@@ -104,6 +114,7 @@ struct rkvdec_ctx {
 	const struct rkvdec_coded_fmt_desc *coded_fmt_desc;
 	struct v4l2_ctrl_handler ctrl_hdl;
 	struct rkvdec_dev *dev;
+	enum rkvdec_image_fmt image_fmt;
 	void *priv;
 };
 
-- 
2.45.2


