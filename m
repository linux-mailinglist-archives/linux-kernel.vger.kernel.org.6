Return-Path: <linux-kernel+bounces-173457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEC48C00A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184D4287DC6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D40126F02;
	Wed,  8 May 2024 15:08:41 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D786AF4
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180921; cv=none; b=fzSVHj7EStvsb9k8mHRy8o/eZOvEk5R/Jj2lA02WyzOhx+KOUFnlN0xmX0Se/1qemDQ5wzG7umTgVBqJ5Zn4TOarNds5CVG6DqMX859UWYJSCETt8rXsBPhmodsTtMPoDRfOoC37dAX6iZhHVT/gFge2ZTYK5nv6GQfbP4YhAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180921; c=relaxed/simple;
	bh=161ZuY3jnwSeQoNq2VqCX+V2ZPrIv4TSXdvXeRn4YvE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UiX91QTcOadvB5OUocn3F/vtKymNXGSXbWn4ziq/vfpTLjP9iISU+HQqkHnkKtsZfnmenud/z3jWdZVlSuLuGzA4s+XfJR6KbaqafXfYaM+KvEmFRFsU+SKkd8L/dzV1najFLRDXrDVBSTwDhNZQj+1fuEkYzfvkob4URbcvgDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36c8c30f0e6so32296925ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 08:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715180919; x=1715785719;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CKzmGEpM47UrDpXRyGdxNnm6GGo6oIhorDllVcQeEw=;
        b=gm42WsZMahnbPO//zcvGX2HH/0LJJ0RU4I8/5YU2njUSWr+2vf3RA5ElI1ZYyG2+/c
         4Puk/8HRyRxI8tYfFN+1qF+gw86HhAZ9IZh2kU9kGY6WSnL2NS2EwlRuj59NtUUj67In
         heO+kCMuLqN3NVKmsfFYkPHwbM25/05zzNkz26nfkRtIPfrEbHBLaPueK76GfBePxM+n
         EWuZTunQg8lfr8HfObuxVmyNLPpIV1LQO7wQrNVpC2ntsOmDekdAJahxZ/QZcr4r5PRL
         0MGF6gA8HH06o2IwI31J/h1V3JVNS+oCyexWgxa3sqssccKEW5lhsVwVwSF1mAIF3YvA
         FHNA==
X-Gm-Message-State: AOJu0YyWEUAy98zbrAl3DvjpaMlKuIKyQbmcQXBFZLNUunK45CHD4Zd5
	B2vgCMmb0JQ8hFnDPdIQ2aehXWlH04kxZVgXrGxluEOQRw1JRuKvrg3ls4NlZ4hCjSA4uCsFl//
	XD8qocma2Gv7qpquBATFv4poLf8G7aqdbvvf9qFZmsbSttb2yQI4nScw=
X-Google-Smtp-Source: AGHT+IFYjlVBIzh7QmewuXkJ5e0cgziLWNcZ1h/pJrDX0O/Sl9AVE8KYq/vRoZyRy4vQwJlAUZ31rqgPFh/sIwPtPyI90pa4tENt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e4:b0:36c:4a99:1f8f with SMTP id
 e9e14a558f8ab-36caed2d604mr1115905ab.4.1715180919213; Wed, 08 May 2024
 08:08:39 -0700 (PDT)
Date: Wed, 08 May 2024 08:08:39 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a631e0617f2ad33@google.com>
Subject: Re: [syzbot] [PATCH net v4] nfc: nci: Fix uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net v4] nfc: nci: Fix uninit-value in nci_rx_work
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git master

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index b133dc55304c..cd2d54168a8e 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1463,6 +1463,16 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
 				 ndev->ops->n_core_ops);
 }
 
+static bool nci_valid_size(struct sk_buff *skb, unsigned int header_size)
+{
+	if (skb->len < header_size ||
+	    !nci_plen(skb->data) ||
+	    skb->len < header_size + nci_plen(skb->data)) {
+		return false;
+	}
+	return true;
+}
+
 /* ---- NCI TX Data worker thread ---- */
 
 static void nci_tx_work(struct work_struct *work)
@@ -1516,23 +1526,34 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!nci_plen(skb->data)) {
+		if (!skb->len) {
 			kfree_skb(skb);
-			kcov_remote_stop();
-			break;
+			continue;
 		}
 
 		/* Process frame */
 		switch (nci_mt(skb->data)) {
 		case NCI_MT_RSP_PKT:
+			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE)) {
+				kfree_skb(skb);
+				break;
+			}
 			nci_rsp_packet(ndev, skb);
 			break;
 
 		case NCI_MT_NTF_PKT:
+			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE)) {
+				kfree_skb(skb);
+				break;
+			}
 			nci_ntf_packet(ndev, skb);
 			break;
 
 		case NCI_MT_DATA_PKT:
+			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE)) {
+				kfree_skb(skb);
+				break;
+			}
 			nci_rx_data_packet(ndev, skb);
 			break;
 


