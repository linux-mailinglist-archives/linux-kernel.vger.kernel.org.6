Return-Path: <linux-kernel+bounces-183067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFFD8C940F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 10:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813F51C20B93
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 08:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B025A2E417;
	Sun, 19 May 2024 08:39:16 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E573F2BB13
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716107956; cv=none; b=kTse29V92niXZDY27oLC9vH/3lYS4zHeZEKO/AyKjfly9GXd2UtgaSRYkOrwiHZsWo5FV+hB9Bq4Uno/agzjOSxW/hMsUpUV8u5VoVmvoPubxjcDZJ9H9dfV180yLUQxvdZYTfdSst70jEFiUxOs2OztE0E+cdJLoA5/ReRausw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716107956; c=relaxed/simple;
	bh=hpzq5r42ME4AyxFLMK0aaiwqfIz5rzH5uEep61kRo6U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZQJxNuyX/emzNSJshMTGsqBoOd+YKTRQ1+LCvqF002SnsXZfzA+5g38GxoO8iEF/cYrHOiVDO2V2/DbEYJblZw6k3JrAZfX9QP3rdzwKZJms7iTV2mPSWVX3qErHJvg1+i/+04NyByHZFoKTWbtTihykb3jSOPbtLC7UX1Nd2OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1d56d36b9so946074539f.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 01:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716107954; x=1716712754;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wr0q7h21Z/Jifhobxadt3b4P+1Vv9RaucjNjhlsR0tY=;
        b=CKe/9/o/hwxw3hY3EQClede/9eJayojuKgkH/g9cRWrMUuhTv+UPdX6G+GCAufijoQ
         Q/AJFCNh3HBkodXYsaoCvf+JMsuNvrpuVhMBEYiKPbJ8TxTyrzlGUDXNH1YX25S+BP47
         CRxBVTEvyMrWYl/9PMwCrWlE3QouTR4vqHSgdwvU9V6XkQKtLhhROpnxzvULYnx40Fnt
         7RnUeGjhniTi3tlNkwbPzH6S17VIzEoquzQEimmWY8DJ28odZPJqFQ8T6IlKanQQHvwQ
         Ct+8O2SUy8ZU73c4r17tKLdqAe8cBS6CfxgsFF1a9KF4SM8NvPwLoRrUxLXtv67mOvww
         VWDg==
X-Gm-Message-State: AOJu0Yzi7TMTffVicNnpsRhEgFocoEW21WG9yC8QkqgkD7FraeiBRmQe
	yDfIm6QXHDc7Ms6gfm5h2yCFrrinTeMVC9wZIH5lVkhdRVgjoK/XbgpAsus6+b1CRU+5zP5+KI0
	ug9wWPcqJRuqLlz47mzCTdi7SqsvZpCAg70HC64v/VfemHF/qlBDfW7Q=
X-Google-Smtp-Source: AGHT+IFCcDZGU94s4QN38TPphkMSme10Em/RfT6KGE3DI/NInV4+CthANpfJgLisbKg98od3AIkBdEBirgIDToGQqNAPuMmgno2m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b8d:b0:7da:b30e:df80 with SMTP id
 ca18e2360f4ac-7e1b500aed7mr135119639f.0.1716107954243; Sun, 19 May 2024
 01:39:14 -0700 (PDT)
Date: Sun, 19 May 2024 01:39:14 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000025c070618ca85e0@google.com>
Subject: Re: [syzbot] [PATCH net v5] nfc: nci: Fix uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net v5] nfc: nci: Fix uninit-value in nci_rx_work
Author: ryasuoka@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git 4db783d68b9b39a411a96096c10828ff5dfada7a

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


