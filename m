Return-Path: <linux-kernel+bounces-180058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C72C38C6985
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0B01F2375C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A9015574C;
	Wed, 15 May 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iX1qzmVk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5CC62A02
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786315; cv=none; b=tT3NsosGqWtAmMOibpnNFVHKFMIkvh9mo0gftIad6QU6tveM+teWiF82FBBz/zMnQRoTiJ2gX+MFt/sRrUnPT9LxVlx0qy9D85KYj/vW/qOb/6vM+w5+lMYxmiEgYQoPlSH0X+73wI8PHAQV13qvZalVgdA/G5pesY2nRuwPlXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786315; c=relaxed/simple;
	bh=PO5Hrp3Nr6H/80MkjK7F9uae9kOvvMoIqj/65Dc2M7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uN6kJcX1p69iWpDr2kxPU9+7L/rGzUZqLrljV7kb9lG+xbGfN8UnApjjoIlAtbhUojHpMDPFRIIk+kNtJu/oLl2bkEHS3yc+QpieSlC5rgCHMc2MhYhttC0CGVdrPMoGtI+4TpEABmhUH/QZyY7SHVoncQI7pp0aPeyZEm3sObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iX1qzmVk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715786312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bSTKu6LYn+5Gisp7sWtG4MHxfLZbzeoOCn381GwpTG8=;
	b=iX1qzmVkGFiU0ohmpdYZy9B0NO7J2F/hsf26TbKl/BUYbP8NEHfBfTQ8JLM6CDy2qCekEa
	2QtJABPxK09mPIF08up+wg5PtDrEwN7PHItC6uJPo7r6oyItw5/TN9l+qfuCXsd7Q7BmK0
	ANmqYYv+DWTEMkILJG2xpcZUUxkiC80=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-0tca9lszP4OnZp2PHp6PTA-1; Wed, 15 May 2024 11:18:24 -0400
X-MC-Unique: 0tca9lszP4OnZp2PHp6PTA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1ec3c838579so70572445ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786302; x=1716391102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSTKu6LYn+5Gisp7sWtG4MHxfLZbzeoOCn381GwpTG8=;
        b=cnUm7yYwS3AJG0Ogb4Z9Xwc1Auk5DZ7rttJ7I/HtC8ScAX2/3oUbThccl6t50G7sjT
         uA0sCcSQirBBF1MF1pQ58U9wbHN9dCIdp1vnPQ8ZEbviBT10nt4meR19xCuQ++7bynqR
         oFfhnybzvNeUH7uxbwjSsbMcq9ROr3EL6TAvkCoaOR1HDaFS3ZCyQ22sjwciCRHXRuht
         ZOoQDk4PwpWMO/elHOWgQqElLvdCAJqLsKyEDPgotamnecxxHWD9uAxL3FWrZHBlHg8I
         cFaf5t1JnUeDdQ/hkbvzR6AEhpPmftLWmnVvdlc4VkeThbum+BussYN7t/z5i/1VNB2Y
         tdqg==
X-Forwarded-Encrypted: i=1; AJvYcCUIYFmd3By7M8t9m+3ONL55Ulv4pB67Xvx3jJ9frcVGL8jhX8FsfySGlvZA825v7eTiGVhi6yCRWj8PujmEdUNVNpy1VKqRJjS6dYoq
X-Gm-Message-State: AOJu0Yyq83DvKDZVUDWg2NVoJrnvsZtn1G3kvfaYtug8fSCWXMuXWH0y
	7i440WXxcO7qevivsfi0cy4EDMFi6/Kc07cHHsUMTy2jbYOmHyb2PqmDntWuA+02oQb0mrnf6bR
	0YBRAwBJOFEzAZSLuhpnwZ6mj81ccDT0Y40CQfxpA6qm0fzea++c7rMei/2HWHA==
X-Received: by 2002:a17:902:c40c:b0:1eb:1663:c7f7 with SMTP id d9443c01a7336-1ef44161405mr183201975ad.43.1715786302656;
        Wed, 15 May 2024 08:18:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxNuB9g/yxB7jNpObTwnphr3YV5yLb2dx2g9RP2qj+ZSAIMayXguP0kUjhfAI0s+ScUOrASA==
X-Received: by 2002:a17:902:c40c:b0:1eb:1663:c7f7 with SMTP id d9443c01a7336-1ef44161405mr183201675ad.43.1715786302246;
        Wed, 15 May 2024 08:18:22 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d168esm119731935ad.32.2024.05.15.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:18:21 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syoshida@redhat.com
Subject: [PATCH net] nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()
Date: Thu, 16 May 2024 00:17:07 +0900
Message-ID: <20240515151757.457353-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nci_rx_work() receives a zero-length payload packet, it should
discard the packet without exiting the loop. Instead, it should continue
processing subsequent packets.

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Closes: https://lore.kernel.org/lkml/20240428134525.GW516117@kernel.org/T/
Reported-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 net/nfc/nci/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index b133dc55304c..f2ae8b0d81b9 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1518,8 +1518,7 @@ static void nci_rx_work(struct work_struct *work)
 
 		if (!nci_plen(skb->data)) {
 			kfree_skb(skb);
-			kcov_remote_stop();
-			break;
+			continue;
 		}
 
 		/* Process frame */
-- 
2.44.0


