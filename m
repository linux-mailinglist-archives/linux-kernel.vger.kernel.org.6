Return-Path: <linux-kernel+bounces-432642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CEB9E4E12
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E370D188072B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2385C1B4135;
	Thu,  5 Dec 2024 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Idxzssr0"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566611B0F33
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383068; cv=none; b=q+4iKilFEXhUCKEl6a+5VW5kQJTmVSmEa6uAHhY+q4HEHZFg5me3BTq7y4MkIUkZ4MuWPeWrpPGBHcBm/b+Zi9D9g7VSeByQQ8G+rAnzzdB7m+CVaHgclv1xcV1axrUuJgE3kAX8/8l/OrcKJZZ4OLurE2BxRpAPPD3Wox28PHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383068; c=relaxed/simple;
	bh=DUk6KztYOuWCHkF2w3Ail7VTXEtKfUcqVezNhB/cCVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7KiFhSioKN8aD/avfD3d5sqVhURLIPzMKPqCZOUD+M7nEA0+4YKOouLjIpLEaypXjxnqEnbbwsHP+PpcSQ6DawaWTDrIHlIAu0qSHpmxbO+kxqvRfnTxKSu8JFKcQvvccX0dByUdjFZenxTrDf+9NCe7UGdxrTo5DfTPoX8aAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Idxzssr0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4CD043F851
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733383059;
	bh=veChOtHywlqJWRuy07dGfiMiZy6FsscGgp0bVfweBmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Idxzssr0tP3giLCBg5x6H9NiXbBHDHWrSpiquSth371BqdtF5u98js4pPYxLp/+0f
	 Do+xTUMpzD6sF8KlETTV49YYptgR2F5RU2fGZEufSHxvJNL55YU8Q0f4ik+vXQU2MX
	 uhigUr+VY6bK5Mw2ugg8G+WntJF5/sqk8Yr30v6ZmGgEIoWOzHrHjmO5plpi1/otd2
	 vIaB4o4KZgZ/BQznaHCVbrIq4rpdMymFbjZjjItrzjKzSXKN6eyP3FCpBqDU0bbBal
	 5lS8GCLe0qUBS0sBzMLb1W4oN2DYgIucHjUDQkRL8Wqx7kRTWnYtUoY+wHxUIojds1
	 Fbl7Ulz6J/nsA==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7fbd38074f4so296128a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383058; x=1733987858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veChOtHywlqJWRuy07dGfiMiZy6FsscGgp0bVfweBmw=;
        b=qU5VpuPmie7BK5YrmGqBe3y7NOfvNGHrWCUNrcEdmW1kHUunrhDuDoCOwLzqcO7CfF
         p5eiP+/+vhp93HMhrxy1zxxncserybsciIJgnpto2IfHiTQq0ngp6CREAVDcrW6sToiJ
         XLmWK3B16sBjFDZmFyEBHrNzprsPoWWYjisQ97HVIVPWIPrRusCmTLy9/XQfwfQ1mpb/
         OYGrO2e0eWPg0mZHIaK08jdbkKUNDJHrI3du0f+P1K0HLVkrLqTorZoyR6v8wSoiBkHj
         A8mxoRx8HkOgGJ05nZuLqiIXzpIGrAyOEx8DRvIxqGDGtes+E4/Fmb0HiyAze7HK9OdP
         TpcA==
X-Forwarded-Encrypted: i=1; AJvYcCUZpwNnm2/rwZIG4s94N4umryL37SXu2JAwkWADmk8XgVbxSjNxXyeChMlAtG62JmmlYO5kJR/H6q0/sKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlVzzYYUi9hdaab/pLBh4uNR8f4BgaBCXojqcKkthu+n0mRZ6/
	K7RAsdcn1pTOrCkn5AXXaAfgz8t8QbNFqR+7XHFkuoCYhEeB/pyeub3rWHT3BLKdKGaeTt2dvmz
	6wnevQ1BROCs9HYMCM8X9FAvUlSsfaWsTm7i41nLjUZmTPzEZ5tzEY+lRd2CVxJSup6V83G4jEk
	/2GA==
X-Gm-Gg: ASbGncsySphEYt4InZpF+G4IcAh3JB6v9/5PADO98YwJqtz2BJ1BojJredHMZm/HWsk
	9U7LmnWcvuv1uqzXf9FOh2kfb4pebXB/YINGLnEXRdxWNEHc68jAawuVhBzYEvAOGYVKolUhqPW
	wmadLr91lmMZg/SgT9apXd6QVZDhG4IvvZ91lN3/6jlcil47974MhO/7s/HVVjSTZMrIBg3h9ww
	hrU+48Y1Aicy6/JSZcxBsJY2MXutm6fBa6aaRiqh1ZNBE/xhijiccYO+Pm7mQaP7p3++amJmaa8
	NI9EuOiTs7+tnE7lnJk5aXx2/r+5uWyZQNY8GPrIWmQU6L3f1cZj
X-Received: by 2002:a05:6a21:330b:b0:1e0:d837:c929 with SMTP id adf61e73a8af0-1e16bdd32cemr11192494637.9.1733383057939;
        Wed, 04 Dec 2024 23:17:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgzsr7JcfsegoUdP6GY5G8iGsXuJUVNjVey+/PZYj54eOigRoJ8F45T7xC4maZMzZD7dP8lQ==
X-Received: by 2002:a05:6a21:330b:b0:1e0:d837:c929 with SMTP id adf61e73a8af0-1e16bdd32cemr11192479637.9.1733383057640;
        Wed, 04 Dec 2024 23:17:37 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156fb8fcsm573909a12.40.2024.12.04.23.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:17:37 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de
Cc: quic_tjiang@quicinc.com,
	kuan-ying.lee@canonical.com,
	anthony.wong@canonical.com
Subject: [PATCH v3 2/2] Bluetooth: btusb: Improve SKB safety in QCA dump packet handling
Date: Thu,  5 Dec 2024 15:17:27 +0800
Message-ID: <20241205071727.36710-3-en-wei.wu@canonical.com>
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

Replace direct buffer access and manual pointer arithmetic in QCA dump
packet handling with safer skb_pull_data() calls. This ensures proper
bounds checking when accessing packet headers and adds proper restoration
of SKB data pointer and length on error paths.

The changes include:
- Replacing manual pointer arithmetic with skb_pull_data() for 
  safer packet header access
- Adding SKB state restoration in error paths

This prevents potential buffer overflows and ensures SKB state remains
consistent even when packet validation fails.

Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/bluetooth/btusb.c | 95 +++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 54 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2bfb915062cf..cbeb1cec790a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2935,8 +2935,6 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	int ret = 0;
 	u8 pkt_type;
-	u8 *sk_ptr;
-	unsigned int sk_len;
 	u16 seqno;
 	u32 dump_size;
 
@@ -2945,18 +2943,8 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	struct usb_device *udev = btdata->udev;
 
 	pkt_type = hci_skb_pkt_type(skb);
-	sk_ptr = skb->data;
-	sk_len = skb->len;
+	dump_hdr = (struct qca_dump_hdr *)skb->data;
 
-	if (pkt_type == HCI_ACLDATA_PKT) {
-		sk_ptr += HCI_ACL_HDR_SIZE;
-		sk_len -= HCI_ACL_HDR_SIZE;
-	}
-
-	sk_ptr += HCI_EVENT_HDR_SIZE;
-	sk_len -= HCI_EVENT_HDR_SIZE;
-
-	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
 	seqno = le16_to_cpu(dump_hdr->seqno);
 	if (seqno == 0) {
 		set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
@@ -2976,16 +2964,15 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 
 		btdata->qca_dump.ram_dump_size = dump_size;
 		btdata->qca_dump.ram_dump_seqno = 0;
-		sk_ptr += offsetof(struct qca_dump_hdr, data0);
-		sk_len -= offsetof(struct qca_dump_hdr, data0);
+
+		skb_pull(skb, offsetof(struct qca_dump_hdr, data0));
 
 		usb_disable_autosuspend(udev);
 		bt_dev_info(hdev, "%s memdump size(%u)\n",
 			    (pkt_type == HCI_ACLDATA_PKT) ? "ACL" : "event",
 			    dump_size);
 	} else {
-		sk_ptr += offsetof(struct qca_dump_hdr, data);
-		sk_len -= offsetof(struct qca_dump_hdr, data);
+		skb_pull(skb, offsetof(struct qca_dump_hdr, data));
 	}
 
 	if (!btdata->qca_dump.ram_dump_size) {
@@ -3005,7 +2992,6 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 		return ret;
 	}
 
-	skb_pull(skb, skb->len - sk_len);
 	hci_devcd_append(hdev, skb);
 	btdata->qca_dump.ram_dump_seqno++;
 	if (seqno == QCA_LAST_SEQUENCE_NUM) {
@@ -3036,61 +3022,62 @@ static bool btqca_acl_pkt_is_dump(struct hci_dev *hdev, struct sk_buff *skb)
 	struct hci_event_hdr *event_hdr;
 	struct hci_acl_hdr *acl_hdr;
 	struct qca_dump_hdr *dump_hdr;
+	void *orig_data;
+	unsigned int orig_len;
 
-	sk_ptr = skb->data;
-	sk_len = skb->len;
+	orig_data = skb->data;
+	orig_len = skb->len;
 
-	acl_hdr = hci_acl_hdr(skb);
-	if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
-		return false;
-	sk_ptr += HCI_ACL_HDR_SIZE;
-	sk_len -= HCI_ACL_HDR_SIZE;
-	event_hdr = (struct hci_event_hdr *)sk_ptr;
-
-	if ((event_hdr->evt != HCI_VENDOR_PKT)
-		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
-		return false;
+	acl_hdr = skb_pull_data(skb, sizeof(*acl_hdr));
+	if (!acl_hdr || (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE))
+		goto restore_return;
 
-	sk_ptr += HCI_EVENT_HDR_SIZE;
-	sk_len -= HCI_EVENT_HDR_SIZE;
+	event_hdr = skb_pull_data(skb, sizeof(*event_hdr));
+	if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
+		goto restore_return;
 
-	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
-	if ((sk_len < offsetof(struct qca_dump_hdr, data))
-		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
-	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
-		return false;
+	dump_hdr = (struct qca_dump_hdr *)skb->data;
+	if ((skb->len < sizeof(*dump_hdr)) ||
+	   (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
+	   (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
+		goto restore_return;
 
 	return true;
+
+restore_return:
+	skb->data = orig_data;
+	skb->len = orig_len;
+	return false;
 }
 
 /* Return: true if the event packet is a dump packet, false otherwise. */
 static bool btqca_event_pkt_is_dump(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 *sk_ptr;
-	unsigned int sk_len;
-
 	struct hci_event_hdr *event_hdr;
 	struct qca_dump_hdr *dump_hdr;
+	void *orig_data;
+	unsigned int orig_len;
 
-	sk_ptr = skb->data;
-	sk_len = skb->len;
+	orig_data = skb->data;
+	orig_len = skb->len;
 
-	event_hdr = hci_event_hdr(skb);
+	event_hdr = skb_pull_data(skb, sizeof(*event_hdr));
+	if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
+		goto restore_return;
 
-	if ((event_hdr->evt != HCI_VENDOR_PKT)
-		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
-		return false;
+	dump_hdr = (struct qca_dump_hdr *)skb->data;
+	if ((skb->len < sizeof(*dump_hdr)) ||
+	   (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
+	   (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
+		goto restore_return;
 
-	sk_ptr += HCI_EVENT_HDR_SIZE;
-	sk_len -= HCI_EVENT_HDR_SIZE;
+	return true;
 
-	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
-	if ((sk_len < offsetof(struct qca_dump_hdr, data))
-		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
-	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
-		return false;
+restore_return:
+	skb->data = orig_data;
+	skb->len = orig_len;
+	return false;
 
-	return true;
 }
 
 static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
-- 
2.43.0


