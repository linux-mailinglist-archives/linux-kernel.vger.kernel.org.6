Return-Path: <linux-kernel+bounces-190154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A898CFA50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06FB1F21825
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ED62E403;
	Mon, 27 May 2024 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="H4R2DvoY"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C814A90
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795914; cv=none; b=C55h/AKNL94WCP11wNzGNiRRBL7GOKMKnai2GDTyRgUKUmX0FYiXE599r0QEaICnGMNdwPDu3CtmoQgpgUfmFZEbCOUp5FZ4Gq5/9Y19lzjAvgJHMQwZ6c2ql5BO3w+Eg6V8oCeluEShKHdFskAN883qHZWpS+vRz3zfFubnJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795914; c=relaxed/simple;
	bh=vkv5hq6lsxJi0KlXu4VtTvGXpDP8px3EhRFjgy+7uqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZtobdSUUawcqt9/y6Q6beF6/Isr+eu5KB1IaBGccZk8v+9P0nsYXhWyibU7aENoOqys1gRYvuIY6wliubMo2WilPd2zYSb/8klsMgxqOH2Ng8gWXeNAZz7nteiEqakwp0ruoZkBTpmCQBP6GhM9amP7Rno2Obn6UJm3aqP9se2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=H4R2DvoY; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 64AC341203
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716795909;
	bh=NKJlqXXBWxTZdncrTmUweWa85elS5Yd/G+CtJGHvhOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=H4R2DvoYnrmRs6R3BkCftlfTB9oOMtdfztdHo3LW9pfsE9UI86AvmpEj/3/Y1hgb5
	 RYcMYeStaclDhUBMpIXGEx53Icr7miApI64u/vS4+xpIgbqskw7AuoS1J5vdNuRx/I
	 GXcvU2kZzIe3NBvMJFYr0RzatKrzsVl/jbAulzSu0+wPj596AC5UKJmXkmv+gJkxQw
	 Msgfwo0+YJl5i/3IC0oOPeDlAom7VOSswkkp3/PM61LodehcIIVUK8VQSRkUZzIdRB
	 oxTqvNXlHXvy23MXyhLhG3ND4mS8fjCwcavENcpaiaLXjtbmwntKtoR8nm7hKYqQDC
	 Jb1NcGJikWeqQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1f44b70822eso22299455ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716795908; x=1717400708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKJlqXXBWxTZdncrTmUweWa85elS5Yd/G+CtJGHvhOY=;
        b=YecagfIxwhdVBdQyN4TuSP7d3RSuR0OBtnZf6biSiHw1Z/3kRpGylyAV2iWXsoHHpc
         dzlyvJl9d9sKBsJX84gUrkleiQU3kgvUPIdYDY1/pMy7WghzyP7BAnzFrz5uQoukXY9b
         T2UCB0zeB3o6NIjn8gulFPngSg6JRjCKVEQ0m2WkKggF1AiMX7b06csmZVyJ37YSb6UT
         pICEoyOG1GYQo+UIuXCscAWwl7OqpYijJdh8Bz83LWLxe5Kofyr214TgGQhv1JZR43Nv
         iD+4DGGcE6nr0CEZtFMj7wBj74bpWAH9pJ+CHnhQT2XrLznLKdeWygOt6h2GiMvxbD9Y
         7hHg==
X-Forwarded-Encrypted: i=1; AJvYcCXJQUVP7xc0stHR4uytEMuKXmNhEYKoheP6mkbTHt9b5N6uF+SSSg1QPynkQPQcOaa2xzcFb8gMBSiHrOjUJ8HsDDApRhWpBKNYTlvk
X-Gm-Message-State: AOJu0Yx0qWqKPOUee2cFTC+jOuKE8NUfz2mpPRfAb8xIIFsG3GG7tfe6
	dMusBqf5T2pnlR+m0JqllEOgSMbqNgD9GXAt62LpJHjSNtOVq4uClgGZ3W/mUmoRnPsr3Qt9b/J
	f9nfRedRj7BHC8uaYqnVAxHb3R6GPZRPHQEz4ldXt3XVN2R/zIWToCgjGgA1MGK3ThGGP3b+LDR
	QsAw==
X-Received: by 2002:a17:903:32c2:b0:1e2:9aa7:fd21 with SMTP id d9443c01a7336-1f4497db381mr84970105ad.54.1716795907691;
        Mon, 27 May 2024 00:45:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFubTHVSQn/kO3LglR8Ud8SJ6R07rDQ7c+0cFnGPKehvgk91gfVJ0j9e6cIAYJu8GB82vzCWw==
X-Received: by 2002:a17:903:32c2:b0:1e2:9aa7:fd21 with SMTP id d9443c01a7336-1f4497db381mr84969955ad.54.1716795907341;
        Mon, 27 May 2024 00:45:07 -0700 (PDT)
Received: from chengendu.. (36-227-176-221.dynamic-ip.hinet.net. [36.227.176.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f479010035sm29573505ad.82.2024.05.27.00.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:45:07 -0700 (PDT)
From: Chengen Du <chengen.du@canonical.com>
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	loke.chetan@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengen Du <chengen.du@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Mon, 27 May 2024 15:44:56 +0800
Message-Id: <20240527074456.9310-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue initially stems from libpcap [1]. In the outbound packet path,
if hardware VLAN offloading is unavailable, the VLAN tag is inserted into
the payload but then cleared from the sk_buff struct. Consequently, this
can lead to a false negative when checking for the presence of a VLAN tag,
causing the packet sniffing outcome to lack VLAN tag information (i.e.,
TCI-TPID). As a result, the packet capturing tool may be unable to parse
packets as expected.

The TCI-TPID is missing because the prb_fill_vlan_info() function does not
modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
payload and not in the sk_buff struct. The skb_vlan_tag_present() function
only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
is stripped, preventing the packet capturing tool from determining the
correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
which means the packet capturing tool cannot parse the L3 header correctly.

[1] https://github.com/the-tcpdump-group/libpcap/issues/1105

Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")
Cc: stable@vger.kernel.org
Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 net/packet/af_packet.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ea3ebc160e25..82b36e90d73b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1011,6 +1011,10 @@ static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+	} else if (eth_type_vlan(pkc->skb->protocol)) {
+		ppd->hv1.tp_vlan_tci = ntohs(vlan_eth_hdr(pkc->skb)->h_vlan_TCI);
+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
 		ppd->hv1.tp_vlan_tpid = 0;
@@ -2428,6 +2432,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (eth_type_vlan(skb->protocol)) {
+			h.h2->tp_vlan_tci = ntohs(vlan_eth_hdr(skb)->h_vlan_TCI);
+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			h.h2->tp_vlan_tci = 0;
 			h.h2->tp_vlan_tpid = 0;
@@ -2457,7 +2465,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (skb->protocol == htons(ETH_P_8021Q)) ?
+		vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3482,7 +3491,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (skb->protocol == htons(ETH_P_8021Q)) ?
+			vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->protocol;
 	}
 
 	sock_recv_cmsgs(msg, sk, skb);
@@ -3539,6 +3549,10 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (eth_type_vlan(skb->protocol)) {
+			aux.tp_vlan_tci = ntohs(vlan_eth_hdr(skb)->h_vlan_TCI);
+			aux.tp_vlan_tpid = ntohs(skb->protocol);
+			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			aux.tp_vlan_tci = 0;
 			aux.tp_vlan_tpid = 0;
-- 
2.40.1


