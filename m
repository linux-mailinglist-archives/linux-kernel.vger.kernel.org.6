Return-Path: <linux-kernel+bounces-183080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571C08C943B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5A3281709
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 09:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693EC282F0;
	Sun, 19 May 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULehZoeb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CE131A89
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716111817; cv=none; b=L8R/JkYYtG5Q4zJ6roCua5gHbs0IJ5qZCkmfSRoOfxa7pSYtkO7D/Huq4IPC+7jSlP8lVkU9R9PFbmPQRiLlk2f1OmlVSQb1rKl5zqo9F6AX4hxJ4cVWlmApDCmf6eo8lzNfMU3dO1yr2N8QwgsFfMaX3Tk6YwgLesRNSSwOyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716111817; c=relaxed/simple;
	bh=XVYZJf19fhwCKob2ZPTjv3MkpTN7Dd7FH6bhQyS3Dzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njtzwEmZZw2msiLZCymKwo0k9bJgd7TZhebKzGflOjvvmKbLLA8cNrWSSkXtI4SntBxYYi2cOL9RKNyzDdSlE3RiRUgs+/efLDihJCCcW6eIxAhHTLAb7OjyWXqsDXvgvaqrqAejl6eVX+/RGkdooJ+48FxmPptGB7wP1jReMHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULehZoeb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716111814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l+hPEPEJikrCYY8v7MJr/p3bxjRpLE6cykpaByeIXXA=;
	b=ULehZoeb6wbVFSj7snOVy69RNakb0ptHUmvGq6uke1dTS+YvztIuFPJRC97cYG7xon+K+R
	T9ehMMFn5wVUPqY8wysC7skaMwA+pvetrKXh4Bd7/JOO80dLwSeVhSn/Ib2zcgh7h0rqfm
	nlM9S8DFf4k1otgEzKj56n+/8UlzqoE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-XKsO8SAnPR6814YT8aF60Q-1; Sun, 19 May 2024 05:43:33 -0400
X-MC-Unique: XKsO8SAnPR6814YT8aF60Q-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5b51d5bdd80so170061eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 02:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716111812; x=1716716612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+hPEPEJikrCYY8v7MJr/p3bxjRpLE6cykpaByeIXXA=;
        b=ZTZS7KmSZQZ/L6sRFktSBeQsSUpzRjawwNguH1iGJkRft5AH8DgLJZqQJ7/ERMYQ/x
         pbauy4YL3t9IHPaz9fMF+VrvzGmj3Aqe8G/q7r9kGwlOauocWg4ldW46NhK8Iz7+kaCF
         5geYWobVmCHwuSMOK/3CAaCG+mN7OjQQ8j5qhksD8mSGb/Ih8V9jRlk7LDcyUzbgR+SK
         FUrENN1141ez6zikJcrDnwmE1a/EyfKH9NFFZeSY2BD4P4HfstS6t5rK4e42psQNreoW
         V4q2ypDMmJg6b3HN4jCg2BEO2DRGqeb4oA1oDQ4tbHtW9EYojYJXO+7KixKiodLzKF/N
         yTrw==
X-Forwarded-Encrypted: i=1; AJvYcCW3JKnk/NAVsmxq0odDJzc2ccByDOh+z7/nvEyaTp193oSumtICjWiRVnfiN6ApHLrSkZ2PUedAmwOKpvWxBUI6epv5AEUTUEnc2vwV
X-Gm-Message-State: AOJu0YwEKHfVST8Qy2XJGfYQB1CY1qwVxocpJMPvRxKQWjIm6dmovchR
	Kvlav6BA/zAW7hNbiH1u80352rQLpYQLeu/yQDPBGl7BNlMDs2kYNk87UspbsofVj+aeJ3cwCaj
	Oe90y1Dfbyc+JD+FoVWsEWlcHVF+3vFGXFJrlU3QCcgjAg1Cv7c2vlDRABSbFWw==
X-Received: by 2002:a05:6871:2117:b0:229:7d01:7e03 with SMTP id 586e51a60fabf-24172e1266amr33035214fac.43.1716111812108;
        Sun, 19 May 2024 02:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt1tMp7gyyVrNXvf2t4LAiDyJ1ABapt5/NoN/KBr74FpK9ackGjMs+w1p3k55TmmXjwAInhw==
X-Received: by 2002:a05:6871:2117:b0:229:7d01:7e03 with SMTP id 586e51a60fabf-24172e1266amr33035189fac.43.1716111811484;
        Sun, 19 May 2024 02:43:31 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2d767sm17355304b3a.186.2024.05.19.02.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 02:43:30 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syoshida@redhat.com,
	syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: [PATCH net v5] nfc: nci: Fix uninit-value in nci_rx_work
Date: Sun, 19 May 2024 18:43:03 +0900
Message-ID: <20240519094304.518279-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following uninit-value access issue [1]

nci_rx_work() parses received packet from ndev->rx_q. It should be
validated header size, payload size and total packet size before
processing the packet. If an invalid packet is detected, it should be
silently discarded.

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534 [1]
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
v5
- As Jakub pointed out, add BUILD_BUG_ON() and make the patch simpler.
  All validating packet size has been done in nci_valid_size() before
  switch statement.
- Also, v4 patch changed break to continue when the invalid packet is
  detected. Since it is unrelated to this patch, leave it in this patch.
  This fix was proposed in another patch.

v4
- v3 patch uses goto statement and it makes codes complicated. So this
  patch simply calls kfree_skb inside loop and remove goto statement.
- [2] inserted kcov_remote_stop() to fix kcov check. However, as we
  discuss about my v3 patch [3], it should not exit the for statement
  and should continue processing subsequent packets. This patch removes
  them and simply insert continue statement.

[2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=19e35f24750d

v3
https://lore.kernel.org/netdev/20240502082323.250739-1-ryasuoka@redhat.com/T/
- As Simon pointed out, the valid packets will reach invalid_pkt_free
and kfree_skb(skb) after being handled correctly in switch statement.
It can lead to double free issues, which is not intended. So this patch
uses "continue" instead of "break" in switch statement.

- In the current implementation, once zero payload size is detected, the
for statement exits. It should continue processing subsequent packets. 
So this patch just frees skb in invalid_pkt_free when the invalid 
packets are detected. [3]

v2
https://lore.kernel.org/lkml/20240428134525.GW516117@kernel.org/T/

- The v1 patch only checked whether skb->len is zero. This patch also
  checks header size, payload size and total packet size.


v1
https://lore.kernel.org/linux-kernel/CANn89iJrQevxPFLCj2P=U+XSisYD0jqrUQpa=zWMXTjj5+RriA@mail.gmail.com/T/


 net/nfc/nci/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

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
-- 
2.44.0


