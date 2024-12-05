Return-Path: <linux-kernel+bounces-432641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E1B9E4E10
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE85168415
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187061B21A9;
	Thu,  5 Dec 2024 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KlyrK9XI"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF2F2391AB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383067; cv=none; b=U6SkYLH0kycdeCiUyV3Zd8uXhDOpguLasDMsQKANuEf2LNrIJL2U4LgEtTKilb9rlbN5mBXzNshgBejPk6EfPK6D4UUr3fr4MwmKDACRU/A7+9uLK9HuIg/5hPdXeTvhlk4ro5zkj3rDAr8JI0mO9WtA2d36VGGXMH2wOwS3iNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383067; c=relaxed/simple;
	bh=tCAmYwcPUUuakZw/lHI+qHX63POcQUnz7J3kWSWQjRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpsOe6UGrwOP654Wi6fcgXdg1q1zQZpNNTmzic/0lyOBdXySi3/7JtF1YLiKh1JawP20VEgOMBMqDUwphMns3HbVAay3iX768xhrzmLF/S4nqc4D8L2iy7x3KP39MaYMeX3ozLPchr+L99UMre7gHoq06hV6+p6BQesJY8XQcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KlyrK9XI; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 272FA3FDB1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733383057;
	bh=uafyawx0PXFiUu2BYekHpyweJ4XNWrmQFuMU5DXhLa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=KlyrK9XI1n9/TbdXtrrbizxUonwc5sUDl8rRSqn6O6y33+SklOJ39yH8K0NxKYmK9
	 TxuYwH3SHRuiITKP9Gr9tRO1eDmKGq+UqJJsHtrVni2DFNAxLGPYm2eq3sI07pm5ZH
	 Xr9CHPlDPcB6oB+PBxRDSPlP2cZMPDakt5LdjqiQVIS5gnDIZlm+Tf6nMM7DZf4IdF
	 J0M+pjjbFFpiu+LKZCz+Lfizm5V5r2coWbdB2N7ooBnd4QGusDi4+7qK0ikOrjubbS
	 tSHIqI3F7nIuzNEp85RjNezN4ETVsOWB3N9SBUGwwweux7R8D/lMhwk1YMLAp2RZeh
	 waXA2GX1Nte1A==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5f07a5621b7so539711eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:17:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383055; x=1733987855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uafyawx0PXFiUu2BYekHpyweJ4XNWrmQFuMU5DXhLa0=;
        b=qWTqvLfIHc8/uZdsOwD9bZ0a/sH56/3yjfTIcSr6SkyZAFo8dFUPYlxYixdE7jHOZK
         5CQS2BigVqyeRDFCmqM+ployvU02PCUz4SU2jH2/hSNtnaspriwq4sD8f7UU7eKRWq3n
         kwtXyRkt+wtc3We0tP+Ch4/wp+PNnYOpD6+ID8+O1NUWHKuQaTEKypalLM+nH9CYRZK4
         ovJ2sEcxyQbBALlrRf2iKzQxXGY5y6i9soa8H8svecb8ZFWTapdX6j8FITzAJp1PtIKz
         Woy30tM+8aK7aPt3t7fZPnwrKYfmb4RXRIjlZcPOleKfepFwjwIsLc+fN+2akQCsI/7k
         25Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUrqnTeCduA4ub5JClBDuclrDKcJqABvZ6I+8pTvtZvR+ASDBswjk5f0FpsNuymbh0UpKUCaRSuNG42Tf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUrOcfiwMdo1GBcoJKNjAocHzqw74QSDywanP+71NDfkP5X9Lb
	eM43DkYdYzmHXWvo3wgCu1ic4HQ/fen/KZBYVSt/+UM8hwqy9CORxRTQIrjPxB+sWE27KDx+VGl
	X3g5rtqRiy0axfmeZy8tYJuUW9TUqP72uxuBE2iuoSaSh9ND1lNQuFF1so1f5D+Amm6G29iNPdq
	+g4A==
X-Gm-Gg: ASbGnctbzoXHHPUInHj2um2vQsoyHxYSknpPqUBQrPuM7w7Y7HUr08QqKoGxfPugLAZ
	fjdx5EN3Nj0hgeBbgu6ZV/gn59mjTN1WFmIUJHXX0JwTSHWW33cJ5CjYdGlsp8mnQLHJjidfcnI
	9hPlmYg6mhbt3IUH0oNuIiYrZJRyPjPAQqTHPtuQOVaW8QvdWa9i96WuS1/SvIlvOvICGOp9R6m
	J3uLJWAH0thafp23AKKhXLclUfRLl/lWLvYd/Q5XpPf8WEeHHPQDpeaW2vg1oqDd2vHMApCX/Km
	xyUCN9+qhFRy3Bx4QAMh1vwgqfge6EdsODtsC8pjGyhUYBNVW7nq
X-Received: by 2002:a05:6830:264e:b0:71d:5983:8827 with SMTP id 46e09a7af769-71dad6d3bb3mr10216250a34.19.1733383055608;
        Wed, 04 Dec 2024 23:17:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCd0BmpC+PZMTubC54bMDVhvpw3j3A3q/DZBKccq+qL7noJolQS2hLkQ9G0hYcYL2yXgJzxw==
X-Received: by 2002:a05:6830:264e:b0:71d:5983:8827 with SMTP id 46e09a7af769-71dad6d3bb3mr10216240a34.19.1733383055300;
        Wed, 04 Dec 2024 23:17:35 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156fb8fcsm573909a12.40.2024.12.04.23.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:17:34 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de
Cc: quic_tjiang@quicinc.com,
	kuan-ying.lee@canonical.com,
	anthony.wong@canonical.com
Subject: [PATCH v3 1/2] Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()
Date: Thu,  5 Dec 2024 15:17:26 +0800
Message-ID: <20241205071727.36710-2-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205071727.36710-1-en-wei.wu@canonical.com>
References: <20241205071727.36710-1-en-wei.wu@canonical.com>
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
success. It currently returns the value from hci_devcd_init() 
(0 on success), but callers expect > 0 to indicate successful 
dump handling. This causes hci_recv_frame() to free the skb while 
it's still queued for dump processing, leading to the NULL pointer 
dereference when hci_devcd_rx() tries to dequeue it.

Fix this by:

1. Making handle_dump_pkt_qca() return 0 on success and negative errno
   on failure, consistent with other kernel interfaces
2. Splitting dump packet detection into separate ACL and event functions
   for better code organization and maintainability

This prevents premature skb freeing by ensuring proper handling 
of dump packets.

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/bluetooth/btusb.c | 97 ++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..2bfb915062cf 100644
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
@@ -3052,17 +3030,80 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	return ret;
 }
 
+/* Return: true if the ACL packet is a dump packet, false otherwise. */
+static bool btqca_acl_pkt_is_dump(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_event_hdr *event_hdr;
+	struct hci_acl_hdr *acl_hdr;
+	struct qca_dump_hdr *dump_hdr;
+
+	sk_ptr = skb->data;
+	sk_len = skb->len;
+
+	acl_hdr = hci_acl_hdr(skb);
+	if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
+		return false;
+	sk_ptr += HCI_ACL_HDR_SIZE;
+	sk_len -= HCI_ACL_HDR_SIZE;
+	event_hdr = (struct hci_event_hdr *)sk_ptr;
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
+/* Return: true if the event packet is a dump packet, false otherwise. */
+static bool btqca_event_pkt_is_dump(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	u8 *sk_ptr;
+	unsigned int sk_len;
+
+	struct hci_event_hdr *event_hdr;
+	struct qca_dump_hdr *dump_hdr;
+
+	sk_ptr = skb->data;
+	sk_len = skb->len;
+
+	event_hdr = hci_event_hdr(skb);
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
+	if (btqca_acl_pkt_is_dump(hdev, skb))
+		return handle_dump_pkt_qca(hdev, skb);
 	return hci_recv_frame(hdev, skb);
 }
 
 static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (handle_dump_pkt_qca(hdev, skb))
-		return 0;
+	if (btqca_event_pkt_is_dump(hdev, skb))
+		return handle_dump_pkt_qca(hdev, skb);
 	return hci_recv_frame(hdev, skb);
 }
 
-- 
2.43.0


