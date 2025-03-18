Return-Path: <linux-kernel+bounces-566299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDC6A67609
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4CF1670C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC3120D519;
	Tue, 18 Mar 2025 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1hXJ9f2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24920DD66
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307146; cv=none; b=gLPkBXH6a4j6qpuf+bQTDx2dIAjjdkVmPpZmECVmml66FZKNczvzbo4GqysaltCDELWE+kJk1Q4oPGC4UoEOyk0Xf+JYDoB2Zpyrdd0CF3eOXfH4is1DstY9XEWSg5sR/FUogWqfwYuQiEEUFUNMvZwvqhoUwDEyCb/Pu6zZkQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307146; c=relaxed/simple;
	bh=Pj3Gsb3J5K7ZnWgFb8ao+Ke3XNZlewIDhLds9XnICfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjcXWyQGRQxIpcO8P2gDGSvtA4jRZ1voq9hVwlOE/7LcSKmhI1lklDheKlUID2PL4RohOHU6rrRbmC1lXgauWnkEyvjy+Ho5+2n/GHhM1Jxe5bgv7wQtBYm0sHkhHqY1wEh1cLhz2RbqplkOcBo9goe7Wxpwo9e6tOsuWVEIWkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1hXJ9f2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742307143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+FTvVk7+dqWugexVpdVFmTnscNlvCQwjnVz1qXGJZ8Y=;
	b=Q1hXJ9f2IqpUrE57bv0uyWkXUHv6VYbK7pfTnTL6wmEetCOCYBzFZue36svaN332KHfqLB
	Ti+7DQGhy7KodtgiSNB7i3WmJ+1n414oYz/HHKLFNQIucBPithvs04sr0EIqmiOA9T7y1z
	f7/naUKqE1szgRaG4C+iUYJF6ptkDPQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-WqBdGoKrMsKDjNJhrmKXIg-1; Tue,
 18 Mar 2025 10:12:20 -0400
X-MC-Unique: WqBdGoKrMsKDjNJhrmKXIg-1
X-Mimecast-MFC-AGG-ID: WqBdGoKrMsKDjNJhrmKXIg_1742307138
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D93DF180025F;
	Tue, 18 Mar 2025 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.44.34.223])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25CBF1828A93;
	Tue, 18 Mar 2025 14:12:13 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Wentong Wu <wentong.wu@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH 1/2] mei: vsc: Fix fortify-panic caused by invalid counted_by() use
Date: Tue, 18 Mar 2025 15:12:02 +0100
Message-ID: <20250318141203.94342-2-hdegoede@redhat.com>
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

gcc 15 honors the __counted_by(len) attribute on vsc_tp_packet.buf[]
and the vsc-tp.c code is using this in a wrong way. len does not contain
the available size in the buffer, it contains the actual packet length
*without* the crc. So as soon as vsc_tp_xfer() tries to add the crc to
buf[] the fortify-panic handler gets triggered:

[   80.842193] memcpy: detected buffer overflow: 4 byte write of buffer size 0
[   80.842243] WARNING: CPU: 4 PID: 272 at lib/string_helpers.c:1032 __fortify_report+0x45/0x50
...
[   80.843175]  __fortify_panic+0x9/0xb
[   80.843186]  vsc_tp_xfer.cold+0x67/0x67 [mei_vsc_hw]
[   80.843210]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
[   80.843229]  ? lockdep_hardirqs_on+0x7c/0x110
[   80.843250]  mei_vsc_hw_start+0x98/0x120 [mei_vsc]
[   80.843270]  mei_reset+0x11d/0x420 [mei]

The easiest fix would be to just drop the counted-by but with the exception
of the ack buffer in vsc_tp_xfer_helper() which only contains enough room
for the packet-header, all other uses of vsc_tp_packet always use a buffer
of VSC_TP_MAX_XFER_SIZE bytes for the packet.

Instead of just dropping the counted-by, split the vsc_tp_packet struct
definition into a header and a full-packet definition and use a fixed
size buf[] in the packet definition, this way fortify-source buffer
overrun checking still works when enabled.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/misc/mei/vsc-tp.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 7be1649b1972..fa553d4914b6 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -36,20 +36,24 @@
 #define VSC_TP_XFER_TIMEOUT_BYTES		700
 #define VSC_TP_PACKET_PADDING_SIZE		1
 #define VSC_TP_PACKET_SIZE(pkt) \
-	(sizeof(struct vsc_tp_packet) + le16_to_cpu((pkt)->len) + VSC_TP_CRC_SIZE)
+	(sizeof(struct vsc_tp_packet_hdr) + le16_to_cpu((pkt)->hdr.len) + VSC_TP_CRC_SIZE)
 #define VSC_TP_MAX_PACKET_SIZE \
-	(sizeof(struct vsc_tp_packet) + VSC_TP_MAX_MSG_SIZE + VSC_TP_CRC_SIZE)
+	(sizeof(struct vsc_tp_packet_hdr) + VSC_TP_MAX_MSG_SIZE + VSC_TP_CRC_SIZE)
 #define VSC_TP_MAX_XFER_SIZE \
 	(VSC_TP_MAX_PACKET_SIZE + VSC_TP_XFER_TIMEOUT_BYTES)
 #define VSC_TP_NEXT_XFER_LEN(len, offset) \
-	(len + sizeof(struct vsc_tp_packet) + VSC_TP_CRC_SIZE - offset + VSC_TP_PACKET_PADDING_SIZE)
+	(len + sizeof(struct vsc_tp_packet_hdr) + VSC_TP_CRC_SIZE - offset + VSC_TP_PACKET_PADDING_SIZE)
 
-struct vsc_tp_packet {
+struct vsc_tp_packet_hdr {
 	__u8 sync;
 	__u8 cmd;
 	__le16 len;
 	__le32 seq;
-	__u8 buf[] __counted_by(len);
+};
+
+struct vsc_tp_packet {
+	struct vsc_tp_packet_hdr hdr;
+	__u8 buf[VSC_TP_MAX_XFER_SIZE - sizeof(struct vsc_tp_packet_hdr)];
 };
 
 struct vsc_tp {
@@ -158,12 +162,12 @@ static int vsc_tp_dev_xfer(struct vsc_tp *tp, void *obuf, void *ibuf, size_t len
 static int vsc_tp_xfer_helper(struct vsc_tp *tp, struct vsc_tp_packet *pkt,
 			      void *ibuf, u16 ilen)
 {
-	int ret, offset = 0, cpy_len, src_len, dst_len = sizeof(struct vsc_tp_packet);
+	int ret, offset = 0, cpy_len, src_len, dst_len = sizeof(struct vsc_tp_packet_hdr);
 	int next_xfer_len = VSC_TP_PACKET_SIZE(pkt) + VSC_TP_XFER_TIMEOUT_BYTES;
 	u8 *src, *crc_src, *rx_buf = tp->rx_buf;
 	int count_down = VSC_TP_MAX_XFER_COUNT;
 	u32 recv_crc = 0, crc = ~0;
-	struct vsc_tp_packet ack;
+	struct vsc_tp_packet_hdr ack;
 	u8 *dst = (u8 *)&ack;
 	bool synced = false;
 
@@ -280,10 +284,10 @@ int vsc_tp_xfer(struct vsc_tp *tp, u8 cmd, const void *obuf, size_t olen,
 
 	guard(mutex)(&tp->mutex);
 
-	pkt->sync = VSC_TP_PACKET_SYNC;
-	pkt->cmd = cmd;
-	pkt->len = cpu_to_le16(olen);
-	pkt->seq = cpu_to_le32(++tp->seq);
+	pkt->hdr.sync = VSC_TP_PACKET_SYNC;
+	pkt->hdr.cmd = cmd;
+	pkt->hdr.len = cpu_to_le16(olen);
+	pkt->hdr.seq = cpu_to_le32(++tp->seq);
 	memcpy(pkt->buf, obuf, olen);
 
 	crc = ~crc32(~0, (u8 *)pkt, sizeof(pkt) + olen);
-- 
2.48.1


