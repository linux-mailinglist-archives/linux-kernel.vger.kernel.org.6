Return-Path: <linux-kernel+bounces-173986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C7D8C08AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C85E8B20DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4555039FEF;
	Thu,  9 May 2024 00:51:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E1B2F24
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215886; cv=none; b=oDocrpsA/8Yua6r4zmJ54PC5o7ubGZaHewAtDYzhQ0+O/Prz0YIfGbu8hCLbWBctOYAW6F6tgOKaYmz1n3ikoljTLlDlPBIft/40lpibaNEd8sLWFYCjSg9P0wIBKzowiMqr7kXp+sKVrmf0pW7Cff/ilC28KckNZdfAyg8ehOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215886; c=relaxed/simple;
	bh=qRkK7Tvrj1s8/V0L04G+qYHYdAmqYRY9POTQ/ztx/Pk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SIDVS3mReS5m3O68DQYRaU+ftcyep0KvA+lhoY69uG3vusrvVilBCqucbzpblJM4F1jxgTK63fM9K97zNqGcB1Vlc1tr2HEwlWHbSgT7wRlCqry+JqxZMC1iJ7e+70tXTaFA+OPeIvh54wcuyBT3dKImGQ5d841czCY27N00o3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e182885d98so28741739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715215884; x=1715820684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGtpb4OiNNKPToNsQ0m2agbiDfrD+sjWiV+nl5Y6Rq0=;
        b=mvCIgEyXWrJuAhdKdknidNYOPExXl5t4vx+6sM2IWRL4J57BXzwmx7RWtiV6ALi+x1
         7/vPN2AQ+0zIhIIIgVUTMua80yhuRN/DtDqb0k/sGxyD4b3D+LH37pqEEzjxar4oou0i
         K+lJtYNewW561mfMzFPyP7vF2CfdWoUPMxFwKeFBHbFOBslX890lc65byTDJOIFu9TZX
         SWMohnU0mxNWhv7R1c0tUeVU+sit3xVrATsQ9zp0g6+nQ1oZMnMoxoil/zfN0JyjnUUq
         EQM6iX4s/E/30YIwPT0ywa32fXk2ewqKr0HxKL1z+0UIaX7O7nnAgx6qRvnUcvMD4mlI
         iOPQ==
X-Gm-Message-State: AOJu0YxqUVEdGOALguMM+Dr7BnVzGmNNXzsLvcTKucxHT57y+JgpNSZQ
	hGz2TuE2kGtlM4pOq/OkLXBCLqaQ+q9dCZ+ouay9PKnJbY3t8J0JGIVFZg4J/pMDlGlodsd4HeI
	8kpzMckaBmEh4KlQB0G6AsLvgWeb1z0n6nBWkOgiK6EwArY4VCx90ALg=
X-Google-Smtp-Source: AGHT+IElfsjjwmTmhml1f7CpT7VbTgv6BmIWsSssenkwe8tk6SswIUa7fO7wDp/NytvEZSkMPJqKSSS1nP76GrZV7l92sfKVuVUH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1616:b0:488:b879:a392 with SMTP id
 8926c6da1cb9f-488fdebebcfmr241051173.6.1715215884620; Wed, 08 May 2024
 17:51:24 -0700 (PDT)
Date: Wed, 08 May 2024 17:51:24 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000842de00617fad11e@google.com>
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
 


