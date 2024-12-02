Return-Path: <linux-kernel+bounces-426814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC669DF8E8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A75A162927
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 02:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B7022098;
	Mon,  2 Dec 2024 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TgFfQ18p"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1BE134A8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733106660; cv=none; b=CY2Gg4UpF/yHhyL4o64m0jlBJp+AbFb1tOEJzwVl6vNqQXur2+yBMH8Yj0Xc/W/hNiw5hGSXVFME+qe2IxyM0UzqWTgNy8wWAptjR8ctBZ4ZczsO6un0k+gTYMGCM8t5UkZbUMN2bXjOZc1lrCEgpjr+1bA+1NxggBMIKK9dgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733106660; c=relaxed/simple;
	bh=Zdq1ZwogLgVqgL+z9O7uP9pI89UJVYGAX8lIGuQkfMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2aNvwMzP6+E5J3Z2kKIRjOgdJzyfY9X+yjr/qADgu1uZXOS2PNniO1yqnqSnU2prwdubJmejgKqJ3KTK2eyA0KsPDOXf366iU1kOfumn1ks52NJL3PdHiTCuqn253dIgZ50pltD7J0/VrykWL5RxOhI8fhmYyzTq4jDTEuygdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TgFfQ18p; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ACC233F288
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 02:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733106648;
	bh=+jndlWKS4Xdsna9rr9EhkPhfFpnli2KtOvGE3QLRJWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=TgFfQ18pjSkaU67AOUn8XHIgvIgQ7fzxh2DmS/qZXOV1jhNVAVaeUTD0yPJ+/RkPL
	 J7ZlZBy4G3xAZL/NiM9NYPmQDIekWypfIMV6uRzk7JUtrRJlRYp5cq7Ao3MuFovfUp
	 Su5zIFNV5J9SUPkEagEkBrYmv6YGW9iF5vFZjxKb8MdToC0YZXiCDMTMjuQRP1DQ/4
	 PMdBufM0gQfbs/mcpqXVdVihaU13ZmiEBcxujW5R+2ri4qxOOtGPtJmuumWIPTqbrb
	 CqX6bwpvDl7Tx0ltzyjkZ5L8PMgATHUUTQvzmq7G2spPFLZIvKq+yQ+xvIL1J+1B2g
	 RJO6ySIwTtFBA==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7251d77ddb7so5058869b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 18:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733106647; x=1733711447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jndlWKS4Xdsna9rr9EhkPhfFpnli2KtOvGE3QLRJWI=;
        b=FFLYJcysOJklyxA45Mf7soug5Y4ccdU343ulntai727PawIlGC3H2B5em/WMywDer3
         oTEZt0Sw22guBIhBLtgrCYV56o+ymT+BCEthVjQQOK4NUfgTcfepn2SjQZoNe3+PtfuW
         f4C3D3MtA6WRYYFd5xfzXEBagjO9jwZRfmx6sOmbZm/30SC369eN/ADu5rJGUo3HAHth
         WunSGDt9nR7FPaABwrUCFL7zVw8i2rZnt+GOdAhb4uAxs+evpew5uOkPK+i/8ZIHAelI
         B0O9ZmBDeAI2hbODzWB0RthV/uUerkynmnQt3y674UPVLfklltEMCWoFYxwGrvL5UIFY
         a07g==
X-Forwarded-Encrypted: i=1; AJvYcCVuWlka7fSrJflq+C2TYDL8UGn8KCne3XXhUXxjJOwSNkb0KPymmZOjXYwnRsIlqiaAfi4wijPu0vSvR0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9+nnkzJ0O/briNaPOlVOxkxJQeM8voR0k6zaub61DIRQcCOC
	mQgL7/jr3AOcnOT8yKErW+1B0Uw8iNJmk1IYN9jLv7p+8AV9JhL5PZlJYMlhgAJCniqBEFYUkof
	u4cZJ4B6vaGIZ7z5LSgvPIlO2KufPE5tLzgRWSu0Qc5h7bHU9KmskOkk7ZR/Cx24CpLExcus98b
	snqw==
X-Gm-Gg: ASbGncuPEq+zVOdmH//a0qGu7oBivpXDnqLRqe+t475efOsqQzn6VEtgjrxqMWNix/p
	PTCkNP9l3WYrEPBspy8w3qjHb3HxYUQmquLAlycBXAGZWtQVLh4bhsevPr1Ct7GSFjGE7403Msy
	SA7u58qJ66nCufwzwmX70qT3BCWQY6p/xPUjGf3HruOW+qwfQD6U/eHieTX/NtgcI114iEoTj56
	Ozy6rt8cdjCCFwcl1qvfEfEdBGGwdQdZA23OGRfx2DQDQyO+shvS7TmR+Sk/bXUVqds0D9IvH3B
	ICQJccV+r+/5zu4SPx00LcAUpeycRwUyp69Vi7Z7l7U6SVWglrNS
X-Received: by 2002:a17:90b:3901:b0:2ee:cddd:2454 with SMTP id 98e67ed59e1d1-2eecddd2aa9mr3115186a91.15.1733106647176;
        Sun, 01 Dec 2024 18:30:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxhGl95AGvKcN10Yj/5OchnG6inZsxo8Gn1gyPKjD3kWjbNF/yMuICL635d2N3oZktOyD4Cg==
X-Received: by 2002:a17:90b:3901:b0:2ee:cddd:2454 with SMTP id 98e67ed59e1d1-2eecddd2aa9mr3115157a91.15.1733106646862;
        Sun, 01 Dec 2024 18:30:46 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee05324801sm6081821a91.1.2024.12.01.18.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 18:30:46 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de
Cc: quic_tjiang@quicinc.com,
	kuan-ying.lee@canonical.com,
	anthony.wong@canonical.com
Subject: [PATCH v2] Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()
Date: Mon,  2 Dec 2024 10:30:41 +0800
Message-ID: <20241202023041.492547-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WCN7851 (0489:e0f3) Bluetooth controller supports firmware crash dump
collection through devcoredump. During this process, the crash dump data
is queued to a dump queue as skb for further processing.

A NULL pointer dereference occurs in skb_dequeue() when processing the
dump queue due to improper return value handling:

[ 93.672166] Bluetooth: hci0: ACL memdump size(589824)

[ 93.672475] BUG: kernel NULL pointer dereference, address: 0000000000000008
[ 93.672517] Workqueue: hci0 hci_devcd_rx [bluetooth]
[ 93.672598] RIP: 0010:skb_dequeue+0x50/0x80

The issue stems from handle_dump_pkt_qca() returning the wrong value on
success. It currently returns the value from hci_devcd_init() (0 on 
success), but callers expect > 0 to indicate successful dump handling. 
This causes hci_recv_frame() to free the skb while it's still queued for 
dump processing, leading to the NULL pointer dereference when 
hci_devcd_rx() tries to dequeue it.

Fix this by:

1. Extracting dump packet detection into new is_dump_pkt_qca() function
2. Making handle_dump_pkt_qca() return 0 on success and negative errno
   on failure, consistent with other kernel interfaces

This prevents premature skb freeing by ensuring proper handling of
dump packets.

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
changes in v2: 
- Fix typo in the title
- Re-flow a line in the commit message to fit 72 characters
- Add a blank line before btusb_recv_acl_qca()

drivers/bluetooth/btusb.c | 76 ++++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..741be218610e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2930,22 +2930,16 @@ static void btusb_coredump_qca(struct hci_dev *hdev)
 		bt_dev_err(hdev, "%s: triggle crash failed (%d)", __func__, err);
 }
 
-/*
- * ==0: not a dump pkt.
- * < 0: fails to handle a dump pkt
- * > 0: otherwise.
- */
+/* Return: 0 on success, negative errno on failure. */
 static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	int ret = 1;
+	int ret = 0;
 	u8 pkt_type;
 	u8 *sk_ptr;
 	unsigned int sk_len;
 	u16 seqno;
 	u32 dump_size;
 
-	struct hci_event_hdr *event_hdr;
-	struct hci_acl_hdr *acl_hdr;
 	struct qca_dump_hdr *dump_hdr;
 	struct btusb_data *btdata = hci_get_drvdata(hdev);
 	struct usb_device *udev = btdata->udev;
@@ -2955,30 +2949,14 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	sk_len = skb->len;
 
 	if (pkt_type == HCI_ACLDATA_PKT) {
-		acl_hdr = hci_acl_hdr(skb);
-		if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
-			return 0;
 		sk_ptr += HCI_ACL_HDR_SIZE;
 		sk_len -= HCI_ACL_HDR_SIZE;
-		event_hdr = (struct hci_event_hdr *)sk_ptr;
-	} else {
-		event_hdr = hci_event_hdr(skb);
 	}
 
-	if ((event_hdr->evt != HCI_VENDOR_PKT)
-		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
-		return 0;
-
 	sk_ptr += HCI_EVENT_HDR_SIZE;
 	sk_len -= HCI_EVENT_HDR_SIZE;
 
 	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
-	if ((sk_len < offsetof(struct qca_dump_hdr, data))
-		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
-	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
-		return 0;
-
-	/*it is dump pkt now*/
 	seqno = le16_to_cpu(dump_hdr->seqno);
 	if (seqno == 0) {
 		set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
@@ -3052,17 +3030,59 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	return ret;
 }
 
+/* Return: true if packet is a dump packet, false otherwise. */
+static bool is_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	u8 pkt_type;
+	u8 *sk_ptr;
+	unsigned int sk_len;
+
+	struct hci_event_hdr *event_hdr;
+	struct hci_acl_hdr *acl_hdr;
+	struct qca_dump_hdr *dump_hdr;
+
+	pkt_type = hci_skb_pkt_type(skb);
+	sk_ptr = skb->data;
+	sk_len = skb->len;
+
+	if (pkt_type == HCI_ACLDATA_PKT) {
+		acl_hdr = hci_acl_hdr(skb);
+		if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
+			return false;
+		sk_ptr += HCI_ACL_HDR_SIZE;
+		sk_len -= HCI_ACL_HDR_SIZE;
+		event_hdr = (struct hci_event_hdr *)sk_ptr;
+	} else {
+		event_hdr = hci_event_hdr(skb);
+	}
+
+	if ((event_hdr->evt != HCI_VENDOR_PKT)
+		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
+		return false;
+
+	sk_ptr += HCI_EVENT_HDR_SIZE;
+	sk_len -= HCI_EVENT_HDR_SIZE;
+
+	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
+	if ((sk_len < offsetof(struct qca_dump_hdr, data))
+		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
+	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
+		return false;
+
+	return true;
+}
+
 static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (handle_dump_pkt_qca(hdev, skb))
-		return 0;
+	if (is_dump_pkt_qca(hdev, skb))
+		return handle_dump_pkt_qca(hdev, skb);
 	return hci_recv_frame(hdev, skb);
 }
 
 static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (handle_dump_pkt_qca(hdev, skb))
-		return 0;
+	if (is_dump_pkt_qca(hdev, skb))
+		return handle_dump_pkt_qca(hdev, skb);
 	return hci_recv_frame(hdev, skb);
 }
 
-- 
2.43.0


