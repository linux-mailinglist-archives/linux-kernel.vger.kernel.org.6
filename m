Return-Path: <linux-kernel+bounces-183445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C9E8C9922
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536D81F2156A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACF517BAF;
	Mon, 20 May 2024 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PbVD4VkL"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1629D18EA1
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716189000; cv=none; b=coQ/PHe3/uVhatEzsZbYIHhBulYQ438+JHudCjetZvgscMWGQzZc+r5Gg/eZ+64nA7X7D7WSkLfHHltT9HNspVX3/YY8SNMmdlE9NKdgL4JfgdEol+VYzrQ34O/b7b6lZHwHLE2xMsvxoDB0hjvv6KSL3bG8TszsRroprYTNte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716189000; c=relaxed/simple;
	bh=DWl8vgttx0y94Ansyt6GBs5OvLyB7TljJs47io3/TZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rs0WnUdbv41v7GnL1/pqzjW2bDEvYd13cI3Tnnzj/WJQVCd38X3lkdXLKKBNhN/5zOBRwLWo1SviZk0lnYDYt0qPVK8GsMO/fk/e+oK2n9R6DPE2bS4aQYUcMJ9kxK5RE6C+82mGiCHTHLFgyWJ4jqVUrGIvhBJSP9oMr5/5ugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PbVD4VkL; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EBD003F331
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716188636;
	bh=BFUGexLuO075Vn4TwjD0eI7xgrFNdKP3Yd5kw3jHcLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=PbVD4VkLezrRmzhH/vXZ9Y34yLvssG5dVUXVh1B/CLko7v5c9w/U6mp7hPHGLLSLu
	 8ZbhPLw+/5soqtKMS6QOyYIScynYv/HBm7CWf8c4Ju/k2Nowz5cRKqjJcQB32rc7ng
	 6sYc4pP/OIXtraRo6+R4pAffNcHSJilGHRQqmVSh2GzW4K7Rf2FogAjh71Ce5ZqKlJ
	 SH8ECtYdcktIgBldJ/vGK50sA7WNrYxpv6UN+IH7Irn4F5hgfq5i6dc9okcL9B/Ab+
	 LNwWSvsvdVZ7CZt+QQZvTwkJn3xJrQsE3GcEzyGfRJNADdnXd1XW0/C6o9pZbNROVH
	 OL7TgvwuwVfRA==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6f6985cf246so1209626b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 00:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716188635; x=1716793435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFUGexLuO075Vn4TwjD0eI7xgrFNdKP3Yd5kw3jHcLA=;
        b=Gu+x5FTAIf3DD/JZS/YXixu/3K4zUTnjbTHJ0+avC4355sEmqbEPRdDLNcthFXaBKf
         6b2CqyLVGEJnPaSrR/BFMMwFWerZ+QtZsUUHZMZS0v1i+3a3O5cPISh/5r5aB/ZiiE2e
         iU9imWyBX1a/wiuLn4mglINssELWN5wBPsXVTGlPv9LHuQ917D9pgEzcbsqzLfv5+gM+
         n9JBod10Wd7tYsjo4DD9+4iwjhfN+twksE2/xYNsjoyJexqMEqdLLxqPKRk/IbvTb5mm
         Uz79MUtldfH4vqXluXZHiMpR5kgpQAgrk56BAczzlNEGS8XrRpekC0uQt0QwM0J17aCd
         q//A==
X-Forwarded-Encrypted: i=1; AJvYcCXWKQVL0SjruyT8Ks4C8/53eFx4NCcFM0seGIiqLSDqEpKQ0xnWr3zsUXiGz664kK0SWiZprKUhHpQKkY1mE8+IItyKmm1sIwuM6Kkp
X-Gm-Message-State: AOJu0YyI1Urh4MoVuIkbeFpiGP+sMJnMkSV8/ruKhy0aH74ekCH1MOO9
	oiZphXEcAWvl0GyEfOflzUby554bWeSrInp4dpXFaH7NS//OGELFMai00w77cnPzrJcaYbDiDCR
	mxckPVvGvRIFzh0UzBiFDW0AZBeYctRpvbu5SpZln8un9bQ21lvcL6+U6lRVvpo7pGfY72yi/a7
	nIxw==
X-Received: by 2002:a05:6a20:ce43:b0:1af:cc75:3f79 with SMTP id adf61e73a8af0-1afde234e96mr27897872637.55.1716188635459;
        Mon, 20 May 2024 00:03:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiuH8ECoxsXXBHCIVNZqb1hJCS/B2V+RQsbdxDB7CMxW1pz6aZLZyopAHes2u0T+Odb+5SXQ==
X-Received: by 2002:a05:6a20:ce43:b0:1af:cc75:3f79 with SMTP id adf61e73a8af0-1afde234e96mr27897855637.55.1716188635076;
        Mon, 20 May 2024 00:03:55 -0700 (PDT)
Received: from chengendu.. (111-248-138-2.dynamic-ip.hinet.net. [111.248.138.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-65bc5dd2a84sm6320994a12.85.2024.05.20.00.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 00:03:54 -0700 (PDT)
From: Chengen Du <chengen.du@canonical.com>
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengen Du <chengen.du@canonical.com>
Subject: [PATCH] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Mon, 20 May 2024 15:03:48 +0800
Message-Id: <20240520070348.26725-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the outbound packet path, if hardware VLAN offloading is unavailable,
the VLAN tag is inserted into the payload but then cleared from the
metadata. Consequently, this could lead to a false negative result when
checking for the presence of a VLAN tag using skb_vlan_tag_present(),
causing the packet sniffing outcome to lack VLAN tag information. As a
result, the packet capturing tool may be unable to parse packets as
expected.

Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 net/packet/af_packet.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ea3ebc160e25..73e9acb1875b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1010,12 +1010,15 @@ static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
 	if (skb_vlan_tag_present(pkc->skb)) {
 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
-		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+	} else if (eth_type_vlan(pkc->skb->protocol)) {
+		ppd->hv1.tp_vlan_tci = ntohs(vlan_eth_hdr(pkc->skb)->h_vlan_TCI);
+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
 		ppd->hv1.tp_vlan_tpid = 0;
-		ppd->tp_status = TP_STATUS_AVAILABLE;
 	}
+	ppd->tp_status = (ppd->hv1.tp_vlan_tci || ppd->hv1.tp_vlan_tpid) ?
+		TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID : TP_STATUS_AVAILABLE;
 }
 
 static void prb_run_all_ft_ops(struct tpacket_kbdq_core *pkc,
@@ -2427,11 +2430,15 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		if (skb_vlan_tag_present(skb)) {
 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
-			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (eth_type_vlan(skb->protocol)) {
+			h.h2->tp_vlan_tci = ntohs(vlan_eth_hdr(skb)->h_vlan_TCI);
+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
 		} else {
 			h.h2->tp_vlan_tci = 0;
 			h.h2->tp_vlan_tpid = 0;
 		}
+		if (h.h2->tp_vlan_tci || h.h2->tp_vlan_tpid)
+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		memset(h.h2->tp_padding, 0, sizeof(h.h2->tp_padding));
 		hdrlen = sizeof(*h.h2);
 		break;
@@ -2457,7 +2464,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = eth_type_vlan(skb->protocol) ?
+		vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3482,7 +3490,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = eth_type_vlan(skb->protocol) ?
+			vlan_eth_hdr(skb)->h_vlan_encapsulated_proto : skb->protocol;
 	}
 
 	sock_recv_cmsgs(msg, sk, skb);
@@ -3538,11 +3547,15 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		if (skb_vlan_tag_present(skb)) {
 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
-			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (eth_type_vlan(skb->protocol)) {
+			aux.tp_vlan_tci = ntohs(vlan_eth_hdr(skb)->h_vlan_TCI);
+			aux.tp_vlan_tpid = ntohs(skb->protocol);
 		} else {
 			aux.tp_vlan_tci = 0;
 			aux.tp_vlan_tpid = 0;
 		}
+		if (aux.tp_vlan_tci || aux.tp_vlan_tpid)
+			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		put_cmsg(msg, SOL_PACKET, PACKET_AUXDATA, sizeof(aux), &aux);
 	}
 
-- 
2.40.1


