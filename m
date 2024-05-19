Return-Path: <linux-kernel+bounces-183033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E29C28C9394
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 08:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA24B20E9C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 06:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735EE1429B;
	Sun, 19 May 2024 06:42:43 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49167E6
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716100963; cv=none; b=K5YUE4DGwszm04q0BLIGHWf2kgPvoeWOCo7SdjJfpgxOKvBxbdi43tSoXhRb+OXOmpR5IZqWbhdaXnvLxmThL7m4pjUMy/jhMhtFr1Ks7rZEj2pz31+padsJzkYQQNbKNXW04tKoY7sZzh84GGczrbniWlNLJXjuIZ3siQmWt2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716100963; c=relaxed/simple;
	bh=2UM1c3sXK2XwhI/6fSG6/UBmeY3QmsTXzr0nIROZv9o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R+ahwmiTDVfEIK3NPAa0GnZVpwJpRiEBr/BWjxfogJTMqN2N6rOeZAUo3huoCPLzm7CZTtT+gD0/YRCJ96pjqEGdOcpHRtyo12+VbmIV2+rNz8LUm3HN+CuQbJjPH6kjtAQJfW0F7774a8YEggHz57v7YXRQppJfJwwTW7fLsWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1db7e5386so938120039f.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 23:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716100961; x=1716705761;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAzKo3T0h4+pZUoaWcUZc5crg03UaV5atVfyoaGPzL4=;
        b=uDoeqjlK9PxZJqVywEYBknHjoB3RQUJg9Kgyeuqttt0gnrA1w3gN++sWwGg+U9Uo9R
         wxpv7tTDtvVbcQ6JYnZwD750KVjD17Gv5SyMmtdCFhqgryGwKElRlDSJ0H5EjtkWRxYt
         yP60wd06dBchfjuRDmfCXzcDBucmmSVGe/BEfX6qX+7AK94khi8IQsBwTr6CU5bERRNN
         RUzQHvIqYDf2an4O7vt8LxYmvUtZ09DT7G4PKV8mS2EftuNuhjJ/oL2hLJCLhds8kNza
         lZ1/FBT5c5S8a/Ro+VDiWStfAt5H5x2AG2ubAn+4mZkKQIcF0pliZ7gSSQ66Py59PWUF
         xLbQ==
X-Gm-Message-State: AOJu0Yzn+d5y9wpMry4saCtv69ZDj/a4jRcGuWI4c0dP5L0/ztMMcQUE
	fwnIIdnd5tFyt7XGlweJX9PP0hQJyMTuffzRahKLeOcc+0iPHqTk4xswZHrzmz2KdduA/fu5wYG
	sEB7OnEV9m7icjkO2rYfAg1SJdzmeyseXfIGgYJC8NQx7Gyxh0Rqu3Q0=
X-Google-Smtp-Source: AGHT+IHMXuOHFvf+d0o3D/UmknUeGwUtrKA9k/yu9bSyfatGU5yFZgCKQzrXeF8g7MENi+/sUGl2vODTwNAAdnV41ca+0qIAE1BR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:7101:b0:488:77ea:f194 with SMTP id
 8926c6da1cb9f-4895903263emr1831762173.5.1716100961068; Sat, 18 May 2024
 23:42:41 -0700 (PDT)
Date: Sat, 18 May 2024 23:42:41 -0700
In-Reply-To: <00000000000003b4af060de27f6b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ef6010618c8e4bb@google.com>
Subject: Re: [syzbot] [PATCH net v5] nfc: nci: Fix uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net v5] nfc: nci: Fix uninit-value in nci_rx_work
Author: ryasuoka@redhat.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main

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


