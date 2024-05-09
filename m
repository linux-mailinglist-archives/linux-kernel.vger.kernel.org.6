Return-Path: <linux-kernel+bounces-173985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545888C08AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FED4280F42
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C6C39AD5;
	Thu,  9 May 2024 00:49:15 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460328F0
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 00:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715215755; cv=none; b=GDF7w6upEsC+jRRGKwwne3lofcFR0CpIYpAqVj6IZwyIoZ8y4B4gvLAmHYEhD8RKbWekGqoCVcWd+tFxQB2dJUK/K+IoAXz3uihxHwz/oqiJtgSSoxHtaiN/Ds37jzqTrlbCkqOsoWzSQdc1j80GIT8e8HMTrwh0qj5P2RfHh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715215755; c=relaxed/simple;
	bh=afglxfB7pGJJpOuhjdrzRpvXJZCoGV3mJKUu9ihGsVk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ohH4AHDAcE0cadDJQgY/XJmzEHUvrgGQQ8J6B6coQxwSqb9T99tDgTvFFtYHx4SRwtw6Vr6DpRdWQDchJm2uUGf9V3Xl3C1eOpsWVdyS5p2BVaKea3O/EV7RyCy5LHnJLqo6S7Nf2NCFkduRB1mekuIq98BYrCjR/5oNWJ216fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c80caae04so3897165ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715215753; x=1715820553;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5mXcQtpX5qQs5eG1YlbtP7SP0g+Uhqe3hNAyO46pEk=;
        b=u40hPB7ZzdiIAZj4okjImn9dAJjX+xDRLSzMDoUnrnYCvwY8xcxo8eghU9LeoO0Amm
         nGIkxJbhvDbMYT0zjZoPHXlZXrYGNdWqwZXKPmPW14NyH1bZOXxHTL70192HGunXRMgF
         qvhmegKcvewHkVIDk1H4ZNFyNAQ/tTH5v0VIf0RDmic7hvMBKoBScGeTrVKppe6trMru
         zMrGR1tipBfg2yQDM5hSgHdOFRrys0rBmMpgk3RsePht+zoXemZD9M8xOTWLpzVNXKr5
         smczpZmfL1UmSyLGFtzBbtIifhYY7mO0YnyrFTAajIfjfXYgylSDjyl5UWrBJqyK2IrL
         mH8A==
X-Gm-Message-State: AOJu0Yxb+zg3M0cPyE63Ie1bU8vr60QAkQ004GYdBIi+hquM0yOb6WwC
	yD3Ej5wsiSbEnEVYIDFb1kjznVk/UIq8RyRbc2E2qcpxVzNWsVl5BHBh9/qSkUINLTOqZsY3pOe
	vSS4oV4hbF7vX4tES8drcluDJJWsVip5rmdNYKiulel3iCti75Do6gkE=
X-Google-Smtp-Source: AGHT+IE9Tz3tmYeOFZuHEuYoee0L8ulXDR7l0oJxY1CIbr1XxuapLGpZEvgnFe29s4lU2nlkbVf9/tAFXYKqfJpkhmI9gGnwV2rS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0a:b0:36a:20a2:e47b with SMTP id
 e9e14a558f8ab-36caed57701mr2436695ab.6.1715215753130; Wed, 08 May 2024
 17:49:13 -0700 (PDT)
Date: Wed, 08 May 2024 17:49:13 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adc2580617fac927@google.com>
Subject: Re: [syzbot] [PATCH net v4] nfc: nci: Fix uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

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


