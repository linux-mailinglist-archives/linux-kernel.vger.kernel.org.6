Return-Path: <linux-kernel+bounces-566301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2BA67630
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9350219C1601
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D265820DD7D;
	Tue, 18 Mar 2025 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNNVxtvX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D620E312
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307156; cv=none; b=pcSb49m8YnAL1XWRdtniK86wACJ+PEpO4MFvFIYt8HrYuchePcw50SWjarbQ5MgjqJi5YJQOqrSvOWP+X0qxGyP3VTny0A/ae61/xxf2nZbMWYV3lCHS8i7XwxTaMtzfP2fUzwUZhDi1RsMKrwAXItU+euSPG2namBTAxVWqihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307156; c=relaxed/simple;
	bh=GifJrWuPVJozp4n+UdUp77Wx5+cTafBy0Gd/TOq8So8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFSQ652IV+RLe1v+qp8J9lfmI/wVRTjc35fkbOJWguu8y8mIK5IRz8NXIJeIMPjIh+6Se85ndmhtn4lcyK8o1u1+HT9IbiH0s/d9akmvn75DWZPn0C7B4tnI7lZwNO8X2nJLR/yNt4xuxh9sDG9dsGrht0/Gfqj8kbroiZQ9SHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNNVxtvX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742307149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmuvixtjXrHwSsLuKUsySwx5J9oRsTZ4y25whh4BLkw=;
	b=VNNVxtvXwcSTP2ElwxYmBsbz7x6Vg7P9nm4qydAdlhQ2SEHmNiRHaw+Opgx4fCNhd3rOtg
	dsudTHMulCMwvrJqQ1VOBB0sG0nPEsVj92D+s4lE8Vs570Jw9RPbG8ya4SskmVLz1KzOxr
	al6X8oSPYji09G1j+Onjq+cBXXWbbJk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-oZPdWGulMa6CA4FM_5wGEQ-1; Tue,
 18 Mar 2025 10:12:23 -0400
X-MC-Unique: oZPdWGulMa6CA4FM_5wGEQ-1
X-Mimecast-MFC-AGG-ID: oZPdWGulMa6CA4FM_5wGEQ_1742307142
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED80F180025C;
	Tue, 18 Mar 2025 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.44.34.223])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE68B18001F6;
	Tue, 18 Mar 2025 14:12:18 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Wentong Wu <wentong.wu@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mei: vsc: Use struct vsc_tp_packet as vsc-tp tx_buf and rx_buf type
Date: Tue, 18 Mar 2025 15:12:03 +0100
Message-ID: <20250318141203.94342-3-hdegoede@redhat.com>
In-Reply-To: <20250318141203.94342-1-hdegoede@redhat.com>
References: <20250318141203.94342-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

vsc_tp.tx_buf and vsc_tp.rx_buf point to a struct vsc_tp_packet, use
the correct type instead of "void *" and use sizeof(*ptr) when allocating
memory for these buffers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/misc/mei/vsc-tp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index fa553d4914b6..da26a080916c 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -71,8 +71,8 @@ struct vsc_tp {
 	u32 seq;
 
 	/* command buffer */
-	void *tx_buf;
-	void *rx_buf;
+	struct vsc_tp_packet *tx_buf;
+	struct vsc_tp_packet *rx_buf;
 
 	atomic_t assert_cnt;
 	wait_queue_head_t xfer_wait;
@@ -164,7 +164,7 @@ static int vsc_tp_xfer_helper(struct vsc_tp *tp, struct vsc_tp_packet *pkt,
 {
 	int ret, offset = 0, cpy_len, src_len, dst_len = sizeof(struct vsc_tp_packet_hdr);
 	int next_xfer_len = VSC_TP_PACKET_SIZE(pkt) + VSC_TP_XFER_TIMEOUT_BYTES;
-	u8 *src, *crc_src, *rx_buf = tp->rx_buf;
+	u8 *src, *crc_src, *rx_buf = (u8 *)tp->rx_buf;
 	int count_down = VSC_TP_MAX_XFER_COUNT;
 	u32 recv_crc = 0, crc = ~0;
 	struct vsc_tp_packet_hdr ack;
@@ -324,7 +324,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 	guard(mutex)(&tp->mutex);
 
 	/* rom xfer is big endian */
-	cpu_to_be32_array(tp->tx_buf, obuf, words);
+	cpu_to_be32_array((u32 *)tp->tx_buf, obuf, words);
 
 	ret = read_poll_timeout(gpiod_get_value_cansleep, ret,
 				!ret, VSC_TP_ROM_XFER_POLL_DELAY_US,
@@ -340,7 +340,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 		return ret;
 
 	if (ibuf)
-		be32_to_cpu_array(ibuf, tp->rx_buf, words);
+		be32_to_cpu_array(ibuf, (u32 *)tp->rx_buf, words);
 
 	return ret;
 }
@@ -494,11 +494,11 @@ static int vsc_tp_probe(struct spi_device *spi)
 	if (!tp)
 		return -ENOMEM;
 
-	tp->tx_buf = devm_kzalloc(dev, VSC_TP_MAX_XFER_SIZE, GFP_KERNEL);
+	tp->tx_buf = devm_kzalloc(dev, sizeof(*tp->tx_buf), GFP_KERNEL);
 	if (!tp->tx_buf)
 		return -ENOMEM;
 
-	tp->rx_buf = devm_kzalloc(dev, VSC_TP_MAX_XFER_SIZE, GFP_KERNEL);
+	tp->rx_buf = devm_kzalloc(dev, sizeof(*tp->rx_buf), GFP_KERNEL);
 	if (!tp->rx_buf)
 		return -ENOMEM;
 
-- 
2.48.1


