Return-Path: <linux-kernel+bounces-251489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4D6930572
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 13:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592D328351E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79313211A;
	Sat, 13 Jul 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UazBwRP/"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250284965F
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720871280; cv=none; b=phP1m21eODMj/kRJde44kWwwmcYWJkwl2z7pl7Vnr1X1MlGmkWv2bZdq2KNdV6Ttvb69DQpy1zU2LSUfDlHK75h+rFw5WD6N6ThXvckphg+DSO/lPxFMJWzyd1uIEFqwgS+fwBbtIoXUyOmhLA9XRPLrPbxHEccz/VG3Gw+yZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720871280; c=relaxed/simple;
	bh=5WvmWXDTlTqUEU/wCMOlpy5sr9n9SMsPEPPRJa1LetY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oA2BWW+i3Z5NG5YKxwwyJeLwAr8S/1orz+BRKI5EfRLzucnKQaqrW2MGlPeHpAsA9RvaR1bPF+LYOc2hjZtJ8z7DkgUeNbOYdkHFbs2Lf0pkHIx0/5k93MXwPCTmi5919SUALJv1m8dDObKDlT3OXUnrslmENPFMbV01nPRfS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UazBwRP/; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9ED743F63B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720871275;
	bh=Xeyb4xFbMHwVNWqXqt5P/olU71cDvQcbJ6W6oSqvzIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=UazBwRP/GTyJGXauw3ANMnfQwza7HgUm9PVKZMC9Ju3dcBb96qvagk9WoKn5mS+l1
	 cxjc8CkDT/B0If67jjjuFaX3NPx23I1B687D91OGL/pEGUbSeevrmy4O5ms2IThV+C
	 6dAuSqxwhZsVpJknNPFukGsFMqtJzj3gJttcQaVmFiOB5lE4djqQFd8Oa0ROaLsAhH
	 CQzhVkA22snZnoYZjN4jq8sI7imWjq//G31YLoyMEMUn1VWgEJHw13QxwgHfVx2lYQ
	 B3w7DQgqzsWWQcAFpuKT8xYFuJ6MlL632iPpb3PqXob24YqBkdJHOHtOgadPhQieQj
	 gLkppoCj+NpHw==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso1896171a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 04:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720871271; x=1721476071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xeyb4xFbMHwVNWqXqt5P/olU71cDvQcbJ6W6oSqvzIU=;
        b=leUg9oB0ezEiCYj3EIP8S8n7pJjVCCDMpn/RHr3uXuwzPRn1FMfg2Yj6MrM++01ny3
         hoXd/Oj64KG+fT/Ukbu1xshnfXyv9mBbI+tpxuGhsljL+Ra4NxFSUEtoRysA4hy1bfFM
         IOVOqButfGlM0mZTZPfwFQvhLkXniGASicZ83QOPhMc4DyB1UkqEHKWFnWS/ErjcVM16
         JVdK6zHVkqEOgjdYAc9+k8W5vGM9cQMTD+iRysHFHbaMvWKtmc8nUNgX6NziXT+8T5BZ
         G+aNrNMoPjJSNM62c/W0Ox3i9Jyty8A+tpm3hZHLdeG30vy/CW/6Ova2NbPj927jwak4
         XQwA==
X-Forwarded-Encrypted: i=1; AJvYcCWippbIufAVeNfsu3hhBe5b5lefkyIuO4w4El206o3T+7vIDGnHgiGJ0352O2Pg87ZAS/MqmQ+98qIa4vJRk5Z9WdzaM7/jKGw2OGH0
X-Gm-Message-State: AOJu0YyB+K7ePqzDp4JYOCRKWSJIZvLrpZ/Ut0iTz4Y40yDAto1pg5Td
	Mc1ZFF+E15UIAYRx3jC3IzGem0VlQDruCbpL1Xa/rkdQst1hDcmDznoZyy2oDKI2ZYmQUE5B3Iv
	rQRNJn15RMZl3x7dD+97vCHXyai99UWUv8vPIt57FfI6TZG07K/IeNCJGr6yNGQOig3gGwrC59N
	31e+QvNzAa6Q==
X-Received: by 2002:a05:6a21:6d96:b0:1c3:aec6:7663 with SMTP id adf61e73a8af0-1c3aec67f87mr10134563637.39.1720871270716;
        Sat, 13 Jul 2024 04:47:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJEqTBDsaW5/fz/vuPt5hrrgdyBom73QfckDVmukJFq+P58RO+em/bIhNecZyr9Lk5UNXvKg==
X-Received: by 2002:a05:6a21:6d96:b0:1c3:aec6:7663 with SMTP id adf61e73a8af0-1c3aec67f87mr10134555637.39.1720871270236;
        Sat, 13 Jul 2024 04:47:50 -0700 (PDT)
Received: from chengendu.. (2001-b011-381c-1f42-e6d2-b6a4-92e8-5a32.dynamic-ip6.hinet.net. [2001:b011:381c:1f42:e6d2:b6a4:92e8:5a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb9a364sm9230375ad.64.2024.07.13.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 04:47:49 -0700 (PDT)
From: Chengen Du <chengen.du@canonical.com>
To: willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kaber@trash.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengen Du <chengen.du@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH net v10] af_packet: Handle outgoing VLAN packets without hardware offloading
Date: Sat, 13 Jul 2024 19:47:35 +0800
Message-ID: <20240713114735.62360-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue initially stems from libpcap. The ethertype will be overwritten
as the VLAN TPID if the network interface lacks hardware VLAN offloading.
In the outbound packet path, if hardware VLAN offloading is unavailable,
the VLAN tag is inserted into the payload but then cleared from the sk_buff
struct. Consequently, this can lead to a false negative when checking for
the presence of a VLAN tag, causing the packet sniffing outcome to lack
VLAN tag information (i.e., TCI-TPID). As a result, the packet capturing
tool may be unable to parse packets as expected.

The TCI-TPID is missing because the prb_fill_vlan_info() function does not
modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
payload and not in the sk_buff struct. The skb_vlan_tag_present() function
only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
is stripped, preventing the packet capturing tool from determining the
correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
which means the packet capturing tool cannot parse the L3 header correctly.

Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@canonical.com/T/#u
Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 net/packet/af_packet.c | 86 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index ea3ebc160e25..4692a9ef110b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -538,6 +538,61 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
+{
+	u8 *skb_orig_data = skb->data;
+	int skb_orig_len = skb->len;
+	struct vlan_hdr vhdr, *vh;
+	unsigned int header_len;
+
+	if (!dev)
+		return 0;
+
+	/* In the SOCK_DGRAM scenario, skb data starts at the network
+	 * protocol, which is after the VLAN headers. The outer VLAN
+	 * header is at the hard_header_len offset in non-variable
+	 * length link layer headers. If it's a VLAN device, the
+	 * min_header_len should be used to exclude the VLAN header
+	 * size.
+	 */
+	if (dev->min_header_len == dev->hard_header_len)
+		header_len = dev->hard_header_len;
+	else if (is_vlan_dev(dev))
+		header_len = dev->min_header_len;
+	else
+		return 0;
+
+	skb_push(skb, skb->data - skb_mac_header(skb));
+	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
+	if (skb_orig_data != skb->data) {
+		skb->data = skb_orig_data;
+		skb->len = skb_orig_len;
+	}
+	if (unlikely(!vh))
+		return 0;
+
+	return ntohs(vh->h_vlan_TCI);
+}
+
+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
+{
+	__be16 proto = skb->protocol;
+
+	if (unlikely(eth_type_vlan(proto))) {
+		u8 *skb_orig_data = skb->data;
+		int skb_orig_len = skb->len;
+
+		skb_push(skb, skb->data - skb_mac_header(skb));
+		proto = __vlan_get_protocol(skb, proto, NULL);
+		if (skb_orig_data != skb->data) {
+			skb->data = skb_orig_data;
+			skb->len = skb_orig_len;
+		}
+	}
+
+	return proto;
+}
+
 static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
 	del_timer_sync(&pkc->retire_blk_timer);
@@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
 static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
 			struct tpacket3_hdr *ppd)
 {
+	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
+
 	if (skb_vlan_tag_present(pkc->skb)) {
 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
 		ppd->hv1.tp_vlan_tpid = 0;
@@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			h.h2->tp_vlan_tci = vlan_get_tci(skb, skb->dev);
+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			h.h2->tp_vlan_tci = 0;
 			h.h2->tp_vlan_tpid = 0;
@@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		vlan_get_protocol_dgram(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			vlan_get_protocol_dgram(skb) : skb->protocol;
 	}
 
 	sock_recv_cmsgs(msg, sk, skb);
@@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
+			struct net_device *dev;
+
+			rcu_read_lock();
+			dev = dev_get_by_index_rcu(sock_net(sk), sll->sll_ifindex);
+			if (dev) {
+				aux.tp_vlan_tci = vlan_get_tci(skb, dev);
+				aux.tp_vlan_tpid = ntohs(skb->protocol);
+				aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+			} else {
+				aux.tp_vlan_tci = 0;
+				aux.tp_vlan_tpid = 0;
+			}
+			rcu_read_unlock();
 		} else {
 			aux.tp_vlan_tci = 0;
 			aux.tp_vlan_tpid = 0;
-- 
2.43.0


