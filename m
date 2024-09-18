Return-Path: <linux-kernel+bounces-332516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D6C97BAB6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E561C21A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A7A1891BD;
	Wed, 18 Sep 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hSi2M9QR"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011417D8A2
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726654744; cv=none; b=HDVll6LD5XewNDS1SoWBNmfpk2C0GD6Z60uv42h0QoPzG75fQIFRQomd4coCOwjeS4n9Hjxr4fWZb5wpBNOzdzLhlJBf6sSGVZpVgYkbli4OiQICUCDRl81Ti8rBZmf9WSUABp58Ijpz+hSbXSiCHrdSAeWyvOiU55vFc+MQUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726654744; c=relaxed/simple;
	bh=x5+e2My5BaOPTgvmct8wXbL95aiKhPSe+IaPqvjgdVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oer6e9QuNucow9TJOeO7/FXRuRRj2e5kfTp4rT/RCSXViYy/h7yD1eQVN7V3Ef9Xu5hHpSKPpFJAGF4zu5M/ZMe2j2FPJQEuSa9nGb/W4omGTVCIZRIRO8FmJKmEB6IuTiLJDELebPzwd83CWGHOpYfUi/hBaWy+VnRJuRzxYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hSi2M9QR; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726654740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fyUBo72TgIvtSI2EW8Tbo6F1BzZphxvwxeH+Ee3WF98=;
	b=hSi2M9QReCJagBh+7SIts1zSjZpPlbxhx9lBEeUYTtaQ+fPrsTEP7FfTIQOMTMBO/UnQbb
	6lSEevSb7EC8w9Qkd/TyDYHC3ImN1H9rDZaN0dGauepTZgYDO01ZBpVbHtPVqLWovGvqfW
	h9eOIBrYJBFMqaYXA1cq25raQD2Oa48=
From: Dongsheng Yang <dongsheng.yang@linux.dev>
To: axboe@kernel.dk,
	dan.j.williams@intel.com,
	gregory.price@memverge.com,
	John@groves.net,
	Jonathan.Cameron@Huawei.com,
	bbhushan2@marvell.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH v2 4/8] cbd: introduce cbd_channel
Date: Wed, 18 Sep 2024 10:18:17 +0000
Message-Id: <20240918101821.681118-5-dongsheng.yang@linux.dev>
In-Reply-To: <20240918101821.681118-1-dongsheng.yang@linux.dev>
References: <20240918101821.681118-1-dongsheng.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The "cbd_channel" is the component responsible for the interaction
between the blkdev and the backend. It mainly provides the functions
"cbdc_copy_to_bio", "cbdc_copy_from_bio" and "cbd_channel_crc"

If the blkdev or backend is alive, that means there is active
user for this channel, then channel is alive.

Signed-off-by: Dongsheng Yang <dongsheng.yang@linux.dev>
---
 drivers/block/cbd/cbd_channel.c | 96 +++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 drivers/block/cbd/cbd_channel.c

diff --git a/drivers/block/cbd/cbd_channel.c b/drivers/block/cbd/cbd_channel.c
new file mode 100644
index 000000000000..6d3f77b9dc79
--- /dev/null
+++ b/drivers/block/cbd/cbd_channel.c
@@ -0,0 +1,96 @@
+#include "cbd_internal.h"
+
+static void channel_format(struct cbd_transport *cbdt, u32 id)
+{
+	struct cbd_channel_info *channel_info = cbdt_get_channel_info(cbdt, id);
+
+	cbdt_zero_range(cbdt, channel_info, CBDC_META_SIZE);
+}
+
+int cbd_get_empty_channel_id(struct cbd_transport *cbdt, u32 *id)
+{
+	int ret;
+
+	ret = cbdt_get_empty_segment_id(cbdt, id);
+	if (ret)
+		return ret;
+
+	channel_format(cbdt, *id);
+
+	return 0;
+}
+
+void cbdc_copy_to_bio(struct cbd_channel *channel,
+		u32 data_off, u32 data_len, struct bio *bio, u32 bio_off)
+{
+	cbds_copy_to_bio(&channel->segment, data_off, data_len, bio, bio_off);
+}
+
+void cbdc_copy_from_bio(struct cbd_channel *channel,
+		u32 data_off, u32 data_len, struct bio *bio, u32 bio_off)
+{
+	cbds_copy_from_bio(&channel->segment, data_off, data_len, bio, bio_off);
+}
+
+u32 cbd_channel_crc(struct cbd_channel *channel, u32 data_off, u32 data_len)
+{
+	return cbd_seg_crc(&channel->segment, data_off, data_len);
+}
+
+
+int cbdc_map_pages(struct cbd_channel *channel, struct cbd_backend_io *io)
+{
+	return cbds_map_pages(&channel->segment, io);
+}
+
+ssize_t cbd_channel_seg_detail_show(struct cbd_channel_info *channel_info, char *buf)
+{
+	return sprintf(buf, "channel backend id: %u\n"
+			"channel blkdev id: %u\n",
+			channel_info->backend_id,
+			channel_info->blkdev_id);
+}
+
+static void cbd_channel_seg_sanitize_pos(struct cbd_seg_pos *pos)
+{
+	struct cbd_segment *segment = pos->segment;
+
+	/* channel only use one segment as a ring */
+	while (pos->off >= segment->data_size)
+		pos->off -= segment->data_size;
+}
+
+static struct cbd_seg_ops cbd_channel_seg_ops = {
+	.sanitize_pos = cbd_channel_seg_sanitize_pos
+};
+
+void cbd_channel_init(struct cbd_channel *channel, struct cbd_transport *cbdt, u32 seg_id)
+{
+	struct cbd_channel_info *channel_info = cbdt_get_channel_info(cbdt, seg_id);
+	struct cbd_segment *segment = &channel->segment;
+	struct cbds_init_options seg_options;
+
+	seg_options.seg_id = seg_id;
+	seg_options.type = cbds_type_channel;
+	seg_options.data_off = CBDC_DATA_OFF;
+	seg_options.seg_ops = &cbd_channel_seg_ops;
+
+	cbd_segment_init(cbdt, segment, &seg_options);
+
+	channel->cbdt = cbdt;
+	channel->channel_info = channel_info;
+	channel->seg_id = seg_id;
+	channel->submr = (void *)channel_info + CBDC_SUBMR_OFF;
+	channel->compr = (void *)channel_info + CBDC_COMPR_OFF;
+	channel->submr_size = rounddown(CBDC_SUBMR_SIZE, sizeof(struct cbd_se));
+	channel->compr_size = rounddown(CBDC_COMPR_SIZE, sizeof(struct cbd_ce));
+	channel->data_size = CBDC_DATA_SIZE;
+
+	spin_lock_init(&channel->submr_lock);
+	spin_lock_init(&channel->compr_lock);
+}
+
+void cbd_channel_exit(struct cbd_channel *channel)
+{
+	cbd_segment_exit(&channel->segment);
+}
-- 
2.34.1


