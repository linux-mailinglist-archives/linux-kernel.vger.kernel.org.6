Return-Path: <linux-kernel+bounces-173467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AD38C00BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A1A1C2222B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE60126F0F;
	Wed,  8 May 2024 15:16:14 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5121A2C05
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181374; cv=none; b=scPzwZovXeCiNZonKEh11ao1JfnwxBPhocntXuk/EA8Ylw6qJ9Ci77korqXpPKe6EdY3gZK4ygs9gW51/Gdlb1zqDVNoGxl4aPVYmfM3FT09aHJE4iZFznPz7WlbkZgBjYlIrKV6jv6tYKN450sfDExwrPzUm274CaCxWxveAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181374; c=relaxed/simple;
	bh=SDEkX/7FIehgXht/piuMpV8rE/Un2CrlriQeS6ym12M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N2ab9CnFHNuFBlExc7zAzo3VitnA6dAizRVdujf4bZ9241VpbcnUqlM2C2rsBJ50nn9AoagrRSS+ZXFoGrDb5uSvFdJyx1YeTVAbdgWBzPqqn1+oT9Y3cUzG8naUGX9Do7QP2zZl7ATBdiUsBJ4FmWhizV/I96qDkIZEj1Ceat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da41da873bso651020839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 08:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715181372; x=1715786172;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVj+gVbgXZM6nZIWEcn7mM4B49NEdWTqZh3wTgaJrF8=;
        b=ZrPkb2H5Z7y+aATViuigeYgK0a9hxT6ArPiF58EZjMhfvQNoLrQL+/smp8J1dLIeIi
         cHel3NKVg6wTnbiewvrKkpYpwyYMNAImvl1aH3RuJcXmUMkkvuz+a4M6Mt7f2ZiFi80j
         EEkRhlioiF96qccz9fqOYxLgEpXL6TuQh3ouWOv+tOiAyheEGge7TXHVOIrMe0iLis/B
         kikyBn3xVTUf8m9ygVC0lYpB15vF5V+PN1yYVpnVQWMmLGdyue5lMptzEyIts4H1m+VD
         VNQElW/GX7j9kg5BaDV82t+mwnkq9ffruoL1usMAScvx+eaMFuE5rwerdt4X2LkdFgn4
         0XCA==
X-Gm-Message-State: AOJu0YwB92CxEtjTVBwZHAtbP82umy4G8J5ShjvHa53taWoDeL8/K5P7
	Sv9IJIsDDkAZAjFDTdn+6wSxlkIAGZA72uIAhMeuETqFzKQ6XtfFIZmpFqVUwqWWE/tySc/AGvx
	xJCnQuZRyXzht7K/VbGNbYewYPI84UNKBNFidTaVlFwd/PYNd3cfvKno=
X-Google-Smtp-Source: AGHT+IEf0UrDkOdjl1prdkMMdW8yNlz9ic6T0GyVf4rguyg1pKqOEiG12mK8wcw4t7eviIR85mbxB75vHRv+WRcDVcD+8e1CGZMr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641c:b0:7da:6916:b435 with SMTP id
 ca18e2360f4ac-7e18fbcd3eamr4375739f.0.1715181371844; Wed, 08 May 2024
 08:16:11 -0700 (PDT)
Date: Wed, 08 May 2024 08:16:11 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064fced0617f2c805@google.com>
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


