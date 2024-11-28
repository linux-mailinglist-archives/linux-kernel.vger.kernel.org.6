Return-Path: <linux-kernel+bounces-424216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4088B9DB1B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E59B21CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAD785956;
	Thu, 28 Nov 2024 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rCmm1blC"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF75B81ACA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732763303; cv=none; b=PR5SNzIBO9GdpgO9nNE4jBSL7hW38+qCo7LmnfY4opQlCDItc8uI7kTfNGge6HBPgOLRld/QwwYEO9LCY8Siy5skN+FqtHYxRBIwDIvKz10WENlcrXCUXK1igK1GP5lcWzNwlXlv7BE4TIGUpW94Atwgo5yWeKqoDgryXyc/hvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732763303; c=relaxed/simple;
	bh=fb7jwHbD677k4r3rvO8ob67nTLFq8FEcQ33AYjPJ02Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zmp3MgOqXfGmc3DqLCC2Qg+8fkznabd4hzE3eYhJX1P87OiF0HUN3wJHBrrMpsQKUMuOrgiFiYtSsV0iQhW6LdA0NLM6v4VCcuZ02KrFJUJ46k+qZaQpipN1bdcAZPeF7O1sujVuL37BE7l5CjN/sbthYxr3GhoJqSVyklZY/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rCmm1blC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EC4993F215
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732763293;
	bh=hh3plfOOHgj+Vrrt6DJRbXu7daZvdrxRuUjcKWQCRaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=rCmm1blCgqqslvyF3AVTN5jNLJFEob7daXPkTFogEc2XK8EkXbZL0voU8jaws2z/m
	 mlTkNVT3nZ3tb5RZA09ptvWiwCtxJdj8aE0gB9tSpzeHRa6o2q86kfbF6GbBG2HqaX
	 LsA5EGA36SdhF1THGFfmezKuEZ95/N4vubbNmaHmKNCnM5jHXP9fUUJp9sdWvhXyIm
	 +oDFeL51CXTLpewMll2qnNwW5Rs1cy7gBZhIr7QhQP8esUOfkoYT+P0D8mIlrZoo4W
	 nlX5ifLsYf1+3OM1oHyTOD0QRBcrmO86+LfejmivQQPQIIJe9sTZr1qs9iEnk6u/4N
	 kmxbU/HHhuiIg==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7250da8a2a5so439212b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732763291; x=1733368091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hh3plfOOHgj+Vrrt6DJRbXu7daZvdrxRuUjcKWQCRaU=;
        b=f8eTkdO6os+tYJHygu7pmdiD39Mo166QjKZjnDVePgEDHQM/KAftXqCi7WkwfdpoI6
         4FJIQ3kPMX81J5L+I+0evuK83otSMkjai/77VbsTbGWb+TeVlNib+ujMywTvnRUyOykm
         8eblJ65niudFbzp5OEvlrrfdNDWvp9WlqsqIUgmxCtusC5CaNaxztGrVg3oPu5SGlQKv
         T38XPp/FFRJNRHepObqlOoPinWR6zBMPXHQSsEUbBLBjXbHFKkyOEuj8awnPTCd6xLzF
         158ze7gE9/Uv5Fc2HDbFma/hBXo+LYLcKsZGb28lfoNaC/MfvJ7eTCwZZNFO6/UxZiCl
         ao5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXslxtUq3eP28qNm8nT1PDrETLH/Z+8VJGZfTCSSCb6CDi0Flm2D4v2yaTY+yfw7wUC0aJmZxnaiuA5L/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+E6OrPfDERD6SqRkSItmbuERT9eQfr2CMl9xVSv3fzoMNtjx
	ES3+0NKhIoIEzr44BwNrk/qwtR1LAsIfkS3C20SeLosYv2f+4o2/3kn0yxwVCGFJBPNXt4EDJ+y
	btzPPg8vMTkIARA7ERJVv5O0G1HJyqxB1r467Ph6TBOr7f7mAjL6ITZmWbnOq1BbGCmcQHHR6yZ
	BqRw==
X-Gm-Gg: ASbGncso5nhKuUbNmA82naZYZ1HvrD/PSLj5mPpOX7hIFnrv0TbHcnuMM5At1vgob1Q
	Gl7sjPpTYd9a0vfa+mWg6G/JWszDUJ6S9W3rC6l1pMum46A1ly/PyXM2oMoybiLbOgf/TBzsckJ
	FcEQK/HEcHk2t2QNlxnVA4jvNv1ne2qmDk7uKd2/j6nPWKCgcDcXQjom22dxcZvo3bVgMAzD6/1
	1T9ydaQGUv1AoH6iHVyg8SKNENFSpMGwj/ti79UywIbplgHDaAgRPKpUKgrUHydOVPZC7Fo6KE+
	EEtiNxbURzZz8WC9Tf6Yw7SOmfqRukGR4md/V00hr7Zq7QFWvA/Z
X-Received: by 2002:a05:6a00:1390:b0:725:1d37:ebff with SMTP id d2e1a72fcca58-72530141196mr7108415b3a.22.1732763291472;
        Wed, 27 Nov 2024 19:08:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPP15aoGK8MXiLZNsBlnTwzjjA5FX64jlc3vWaIRjez0atSF0AcLEu2GUfnCjj92mBxogIaw==
X-Received: by 2002:a05:6a00:1390:b0:725:1d37:ebff with SMTP id d2e1a72fcca58-72530141196mr7108394b3a.22.1732763291104;
        Wed, 27 Nov 2024 19:08:11 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176150dsm357506b3a.23.2024.11.27.19.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 19:08:10 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anthony.wong@canonical.com,
	kuan-ying.lee@canonical.com
Subject: [PATCH] Bluetooth: btusb: avoid NULL pointer defereference in skb_dequeue()
Date: Thu, 28 Nov 2024 11:08:07 +0800
Message-ID: <20241128030807.270581-1-en-wei.wu@canonical.com>
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
success. It currently returns the value from hci_devcd_init() (0 on success),
but callers expect > 0 to indicate successful dump handling. This causes
hci_recv_frame() to free the skb while it's still queued for dump
processing, leading to the NULL pointer dereference when hci_devcd_rx()
tries to dequeue it.

Fix this by:

1. Extracting dump packet detection into new is_dump_pkt_qca() function
2. Making handle_dump_pkt_qca() return 0 on success and negative errno
   on failure, consistent with other kernel interfaces

This prevents premature skb freeing by ensuring proper handling of dump packets.

Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/bluetooth/btusb.c | 75 ++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..8926f8f60e5c 100644
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
@@ -3052,17 +3030,58 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
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


