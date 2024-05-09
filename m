Return-Path: <linux-kernel+bounces-174115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 302AF8C0A56
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5D3282653
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50633147C9F;
	Thu,  9 May 2024 04:08:01 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06AD26D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715227680; cv=none; b=f0yj8d7kohcHh83D08xq7QTA82Fkdl6kjNbU3Nxh4DOT8E3L9Mk6vesOkxgG3RkvGpBjYQdmbVwbLjl6+8izaG4+psA6WIqruIQPJo6j8Gs1YIk3SEYDD7FoCweTvrSLG1ndkGCYlV/nrh6kUN7VoIlnu/3qgeMsCXXCOJF3Ygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715227680; c=relaxed/simple;
	bh=sK7ZqVZ0WmnINWVkohi1gYJ4hOg8iPrUh76XEN7bZOA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f/OeVoYDSq88MuWI+++Bz9HknoRHvU00AaycDk00R6Sc5t5YgX5YTBSWZv+vT2WsAvU3Xu5PNGoo8FFRou/JmtPpljQZQecMza0Yzqden1Xg3OFXhr3TAZwgIbUBiNXuhJXtn13jUlUoat8kTzMYV1FU48VhYir+317dkEAJ1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e182885d98so42355839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 21:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715227679; x=1715832479;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qV8m368EfwLWYouVrPnNoYPwk1xOD88mW2b6+kNH4xA=;
        b=IVUyjMzmPozQiG4TKserHa0fYh+y9IKwlFa4AOCzlzEwstpafIk6D/un9t81xQvnEy
         21p1Sb6sy3HwoqVnnjtDN5ew+5We0gdeCrFZQIcyeUX2WRgVnRwLftLlPi1Z701rTnoD
         CkqYYAlTjDuk2zwNDEed+B7c+itpSAxS9QWzgofxf5+y01lmr3I8+Bec725+YV5jji4t
         q3dJBIZ2WW5vwr59WDakPkpZT7HyooqIpom1bHEMUDrtvYqCqPDhs7bsc0KZtlXScbDK
         nnHxnwYzZ/m6kX9giGiR4Hib34qhwdgmfgbD4OCORqYnRa+wz2laVrsvPWlFFf4Htgyv
         05Lw==
X-Gm-Message-State: AOJu0YxmjEhUxIt47mX6bZRYdMz4pkDitsI5qReFIwhAOrQnkOguJHNi
	KGzmq0LJmqPKKFU/XdXsdXc3N/yAspvPFp9J3K1/s9j0/o+4+FpqzF2PdNCWHpFTl/qZl52wuT5
	jU2H3hyaoOwuO5MCH4208VTIQzEFvRAmnOgvA3x6d62UKhRPyUVXF+9w=
X-Google-Smtp-Source: AGHT+IHzJMppdgO2HiPNkiF8NHxJxpRHMy4W04uU9TcaTRVxr/NqkZYzdVPhQV06EvcWhS4so5J4h80zWtflkMc2uWRAfJ/dmkQM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:891b:b0:488:59cc:eb4f with SMTP id
 8926c6da1cb9f-488fd823b53mr424998173.1.1715227678846; Wed, 08 May 2024
 21:07:58 -0700 (PDT)
Date: Wed, 08 May 2024 21:07:58 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081c37d0617fd9008@google.com>
Subject: Re: [syzbot] [PATCH net v4] nfc: nci: Fix uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net v4] nfc: nci: Fix uninit-value in nci_rx_work
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index b133dc55304c..0aaff30cb68f 100644
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
@@ -1516,24 +1526,32 @@ static void nci_rx_work(struct work_struct *work)
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
-			nci_rsp_packet(ndev, skb);
+			if (nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
+				nci_rsp_packet(ndev, skb);
+			else
+				kfree_skb(skb);
 			break;
 
 		case NCI_MT_NTF_PKT:
-			nci_ntf_packet(ndev, skb);
+			if (nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
+				nci_ntf_packet(ndev, skb);
+			else
+				kfree_skb(skb);
 			break;
 
 		case NCI_MT_DATA_PKT:
-			nci_rx_data_packet(ndev, skb);
+			if (nci_valid_size(skb, NCI_DATA_HDR_SIZE))
+				nci_rx_data_packet(ndev, skb);
+			else
+				kfree_skb(skb);
 			break;
 
 		default:


