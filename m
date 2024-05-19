Return-Path: <linux-kernel+bounces-183025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282CE8C9372
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 07:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12EE2816B7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 05:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A7FE554;
	Sun, 19 May 2024 05:02:41 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEB946F
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 05:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716094961; cv=none; b=efnhudz+MJ6OXEAO04tJajBEFMaAebH6xhewO/bW0Xe7FlHsuCmfrS0nMUINq1jlE7fTZJDo4qZh8eqVe7oS9JXNYUJgxtw5CfB/ipFbC2KmXqEwEuT2rWLk55m6yGNgnJIZ+ATBm8mc3YIcsYJ2YcV0cgJANd7oFZPBDNf/nd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716094961; c=relaxed/simple;
	bh=QKgWZ9yK69dBMm4j06TKWvDSRDCE/4PFJH/hajzDA2M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eWAks6qSOxl5v56FrLoVNUD+evjBSg1IrnjUNQRijHikSnIgVkNfMpTmuTz1XakMbxd270zsKzTm5iyu+Wnw84dpEJJYX9lry78EN2t1GBRIuQSNltSml/lxhXEFC4a8FuBNQdwenr+rLqIEsNQ4D3LprvygUNxR/hYHStMuh+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1e05c39easo826933939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 22:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716094959; x=1716699759;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEkFLZ1iWs8m/wiswDRxxFaLsy90wywV2q0+A+M0caU=;
        b=ejldLUR1C07JLWJk4GPWKK3xWI/NMOdHBbI6JY6iJBgiicH9HoEX3DQRgTa5lgSgUp
         tSwelFMLifMr3sXWXj2jnHhOaEw7kEWoC5qz/e8MuAcBZDNiVrkqzoHpukG0tgiX+Yoc
         UD00AndQ7NBfqmzUBZ8QKhmgsdAZfqFmENGuI/lVklq0fqIwAMnzHFJPpKss/Xo1HFsq
         OS5oru/pSBT1fvleUDrB9DELcojt1/l1iJGmo0qUuinQmL7qPFHLRW2a50lAK1DlptHK
         kElpSoJlVLd60QrWxv8yY02q3M18RqcsBTXi5iHfx/0LSEmc3eugrlwGOSfaC9+FdKO8
         U/Tw==
X-Gm-Message-State: AOJu0Yzhj47Gbh0Y9XIiYl2FZcV9+2/o+oxCVyKRJpnbrXfUTVEv4hNg
	sfu5YULoq49SIX9Ard2O5BAefgN14n/ttjJA/aeSfArz4LlB+q5L3dU7otYPIZ7QDiGPUxVkKjO
	XcQkqfzMy0k+yVnFvaMAqvhRyljxChmFgn9/V1LrPH50veqknZZu7BRg=
X-Google-Smtp-Source: AGHT+IH8sI1070YVdmqWnJ1PaJiSNVPCnHp9nJRIhVTpKyduI5ZpH99Jx+ReI7uZTH25bypTfob73sclniFTYUkxH+31m0FtyqTd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3781:b0:488:96c4:9caf with SMTP id
 8926c6da1cb9f-4895a499857mr1851972173.6.1716094958994; Sat, 18 May 2024
 22:02:38 -0700 (PDT)
Date: Sat, 18 May 2024 22:02:38 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e9dff0618c77ee2@google.com>
Subject: Re: [syzbot] [PATCH net v5] nfc: nci: Fix uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net v5] nfc: nci: Fix uninit-value in nci_rx_work
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git master

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index b133dc55304c..7a9897fbf4f4 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1463,6 +1463,19 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
 				 ndev->ops->n_core_ops);
 }
 
+static bool nci_valid_size(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(NCI_CTRL_HDR_SIZE != NCI_DATA_HDR_SIZE);
+	unsigned int hdr_size = NCI_CTRL_HDR_SIZE;
+
+	if (skb->len < hdr_size ||
+	    !nci_plen(skb->data) ||
+	    skb->len < hdr_size + nci_plen(skb->data)) {
+		return false;
+	}
+	return true;
+}
+
 /* ---- NCI TX Data worker thread ---- */
 
 static void nci_tx_work(struct work_struct *work)
@@ -1516,7 +1529,7 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!nci_plen(skb->data)) {
+		if (!nci_valid_size(skb)) {
 			kfree_skb(skb);
 			kcov_remote_stop();
 			break;


