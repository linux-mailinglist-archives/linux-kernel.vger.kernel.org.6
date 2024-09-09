Return-Path: <linux-kernel+bounces-322004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC3197229C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C90D1F242E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B396189F27;
	Mon,  9 Sep 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="0ZcH5B59"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2EC18C904
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725909990; cv=none; b=CYRrMMybxfzrezkoNof8tcWuVsS0UHgmtccG+OX2aBqGEDpcRzfk2ZOlWvQMZTMeRLke1g6AkSyyBjuGKrHNAi5E1b4SHnjxCu8NKlB7Ytpjl5I6F9M/+u128bfzx8fpFH0F93UC8yAjdBLCqijSUhKKZpYccnOtHXDvOp/poBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725909990; c=relaxed/simple;
	bh=ZYo+LLFFvN/QHtku8a6I+SUIoNEbcXm+Rw1zMFdWEcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXwvIPPTpv6TltqDohM+EveWHHzNOpbd2d5ZGSecGscCT++f/1a3VoyT7J0WcgN3D2pbt03qlLfzB0Y/mPN2vPS55Rr+ELrYm5YdTx9PuVoy3fB5bRnuIC+Hg1fFbeURXRaZFXps4LyFNYKQ770DnMS3jTMqvNI730ri7DtGlZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=0ZcH5B59; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725909983; bh=WUtNqV5Bor6zEzVia1V8H1hXPJSpLb+pccjKkjnBtXI=;
 b=0ZcH5B59Zrjo0DMYDQ8F/8jiNndciY5zoBQXymYmZPhGPNVb61JgePJt6Kz5vHwP+C8TjXHC2
 mDsIJ2bKqPJZqSZ86lKHQzthcCGUF2qas8nEVaVRDsQxphU7p1qrxiga5yZ5c52iZU7ZCzozKTF
 HDcQRQFtF1ibnWGBMV3jaLqgWXHMp4OC9pl7JHO24wxFB1+ujhLOeUcY/dfnt4QE7uGZyN/dNOJ
 ASmdq7d1R0vVdf3VfChvQrVaUJIjGAYtC6uWhgwkcM0fXYxfy1fhd/P32LUBnLX45EtrFChxwuk
 fph3NQ+drGbBGAUH10eRbDze4j8QjBOSslCZSaDD/IFQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Sebastian Fricke <sebastian.fricke@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alex Bee <knaerzche@gmail.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH v6 09/11] media: rkvdec: Add get_image_fmt ops
Date: Mon,  9 Sep 2024 19:25:07 +0000
Message-ID: <20240909192522.1076704-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909192522.1076704-1-jonas@kwiboo.se>
References: <20240909192522.1076704-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66df4bdec680cb8b7d2dc234

Add support for a get_image_fmt() ops that return the required image
format.

The CAPTURE format is reset when required image format changes and the
buffer queue is not busy.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Tested-by: Christopher Obbard <chris.obbard@collabora.com>
---
v6:
- No change

v5:
- Collect t-b tags

v4:
- Change fmt_opaque into an image format
- Split patch into two

v3:
- New patch
---
 drivers/staging/media/rkvdec/rkvdec.c | 49 +++++++++++++++++++++++++--
 drivers/staging/media/rkvdec/rkvdec.h |  2 ++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 467fc05b347a..8df49ee12820 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -111,15 +111,60 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
 	const struct rkvdec_coded_fmt_desc *desc = ctx->coded_fmt_desc;
+	struct v4l2_pix_format_mplane *pix_mp = &ctx->decoded_fmt.fmt.pix_mp;
+	enum rkvdec_image_fmt image_fmt;
+	struct vb2_queue *vq;
+	int ret;
+
+	if (desc->ops->try_ctrl) {
+		ret = desc->ops->try_ctrl(ctx, ctrl);
+		if (ret)
+			return ret;
+	}
+
+	if (!desc->ops->get_image_fmt)
+		return 0;
 
-	if (desc->ops->try_ctrl)
-		return desc->ops->try_ctrl(ctx, ctrl);
+	image_fmt = desc->ops->get_image_fmt(ctx, ctrl);
+	if (ctx->image_fmt == image_fmt)
+		return 0;
+
+	if (rkvdec_is_valid_fmt(ctx, pix_mp->pixelformat, image_fmt))
+		return 0;
+
+	/* format change not allowed when queue is busy */
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+			     V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+	if (vb2_is_busy(vq))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int rkvdec_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
+	const struct rkvdec_coded_fmt_desc *desc = ctx->coded_fmt_desc;
+	struct v4l2_pix_format_mplane *pix_mp = &ctx->decoded_fmt.fmt.pix_mp;
+	enum rkvdec_image_fmt image_fmt;
+
+	if (!desc->ops->get_image_fmt)
+		return 0;
+
+	image_fmt = desc->ops->get_image_fmt(ctx, ctrl);
+	if (ctx->image_fmt == image_fmt)
+		return 0;
+
+	ctx->image_fmt = image_fmt;
+	if (!rkvdec_is_valid_fmt(ctx, pix_mp->pixelformat, ctx->image_fmt))
+		rkvdec_reset_decoded_fmt(ctx);
 
 	return 0;
 }
 
 static const struct v4l2_ctrl_ops rkvdec_ctrl_ops = {
 	.try_ctrl = rkvdec_try_ctrl,
+	.s_ctrl = rkvdec_s_ctrl,
 };
 
 static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {
diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
index 6f8cf50c5d99..e466a2753ccf 100644
--- a/drivers/staging/media/rkvdec/rkvdec.h
+++ b/drivers/staging/media/rkvdec/rkvdec.h
@@ -73,6 +73,8 @@ struct rkvdec_coded_fmt_ops {
 		     struct vb2_v4l2_buffer *dst_buf,
 		     enum vb2_buffer_state result);
 	int (*try_ctrl)(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl);
+	enum rkvdec_image_fmt (*get_image_fmt)(struct rkvdec_ctx *ctx,
+					       struct v4l2_ctrl *ctrl);
 };
 
 enum rkvdec_image_fmt {
-- 
2.46.0


