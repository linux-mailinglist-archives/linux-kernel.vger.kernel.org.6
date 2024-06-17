Return-Path: <linux-kernel+bounces-217214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3816690ACEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9951C21A86
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E6E194AD5;
	Mon, 17 Jun 2024 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TBCnj2GX"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612181946BF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623633; cv=none; b=qzX6MRGejV2b2wXwTyofn+O9LfIen46tmUC0vRawh1S4aTtKJKJCOvrmQL/w0mr3NZWV5pah/4N1iDgs/8+lD37obfUcgsKzhMG5k0IXpFhzWIHgg2P+YYErYXd3JYCbc7g/jTWCG8GNgWKJxDOcVaGuHh00K1PLTWAcSf+y4UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623633; c=relaxed/simple;
	bh=gU4V/39oQRqyqk7yaaHjOxpUqpLP9MLqVKlCi5owzD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMvtkHeVY5WZukOHZD7ChfWtu4LKb70B36URY5ar8HZPezOMLSdoYbE/lDrTCZyzyWIyzXKDc5zPvFNDwsTkwiygK638Q45mBn7qJfEZADvT79HtFTSbP5xtce4s1PKam8w4JjyjDBq6IVkaYy2ZWVxE1jGQBBnoTqfCLJOshuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TBCnj2GX; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso32557505e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718623628; x=1719228428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/lQRJSbio7FOsI8GI1wFStTLmt7h6P4h8uXrIA9ZCLY=;
        b=TBCnj2GX/AuRjIPdANjaC6FBr6m71Xvahdk2tCRezC/aLemprWqNnSLa+nC7WYg/Fd
         4i7iXZ2hisrsl/YGuGm0aEa3tOPoxeO2iXJgysV+kpUmi7EsSzoMW55R+cNif9CsbaQN
         cXDZTfQCP4IA47Sfz81vMTge5YqDiMaXmAOfbQwuPD1QlUWyZy5IZS3hDOUDOUa+jiib
         tiI0cE+mhrNLSgdmramW6q7yVM7LCpimj+AErouZWg8XXcpVxfoqqZGV5yZMi+mVeSXk
         f9PTnVxy6sqdV61jMEhMwD0Wp3MGfMsqxAoDdCJr1zoSYTAWERY6Bg7yYnmKKJO5C/M4
         Z0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718623628; x=1719228428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lQRJSbio7FOsI8GI1wFStTLmt7h6P4h8uXrIA9ZCLY=;
        b=fW+HCrBvUtcnPeUwemXy74YhL9CVlAuwRvQojVPfh6u+C+qH55/XcQJ3Fae/R8NCDE
         y6brh8jzBpDWFcoQBq+5TXRLvoYeKT0ziMrO0sxKaBYn3abJ1iZTXnVXPi/850sx/Bb3
         blngnWL4++p7/OkUN1q92XbkqM9+rX447BwkmulFQkEr5aodHBFSpsTJDKug89GOIS83
         KA6KXsHc18Ls8vXELr9Yc254hsI17eU4b/l+EXc8ErKa1SgWPIKn3wbsPByXwh9ufwEq
         7tCp5NwEjr7U4VdaH+ad0727s3IeDfmV2BtvYNZ7efnClM2g/yoeOkZGUpsdu347wefy
         i92g==
X-Forwarded-Encrypted: i=1; AJvYcCXEoCcR8PVu8wBbGHkVXuxRRH9G//8TQHj71zIHoF/JzOcMzsQp4EWswBUNxaay9vpy6g3n4gJMfajubl1/TtIufRfp+CT2YKwNbZGb
X-Gm-Message-State: AOJu0YwOEM+LK7SP1tbDZQoVXDwy14wnBwb3BSGkFXWvh9CwqqHXTsX/
	exMLcxzfYnFYbSR2E5gclayorH+9V91ew91yIMGAD4/Q4qN9Zihr0rwUIcvKz/A=
X-Google-Smtp-Source: AGHT+IG5OX+DrFu/LV+DTFv9I2/XiA1kp4E8HW14y2jNzM+cYid+bkI0aQx/thNdf89qiWJX4E74dQ==
X-Received: by 2002:a05:600c:19d3:b0:421:4b0a:5006 with SMTP id 5b1f17b1804b1-423035077a1mr105529965e9.7.1718623628389;
        Mon, 17 Jun 2024 04:27:08 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a633sm157318725e9.43.2024.06.17.04.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:27:07 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:27:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Chengen Du <chengen.du@canonical.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kaber@trash.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8] af_packet: Handle outgoing VLAN packets without
 hardware offloading
Message-ID: <ZnAdiDjI_unrELB8@nanopsycho.orion>
References: <20240617054514.127961-1-chengen.du@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617054514.127961-1-chengen.du@canonical.com>

Mon, Jun 17, 2024 at 07:45:14AM CEST, chengen.du@canonical.com wrote:
>The issue initially stems from libpcap. The ethertype will be overwritten
>as the VLAN TPID if the network interface lacks hardware VLAN offloading.
>In the outbound packet path, if hardware VLAN offloading is unavailable,
>the VLAN tag is inserted into the payload but then cleared from the sk_buff
>struct. Consequently, this can lead to a false negative when checking for
>the presence of a VLAN tag, causing the packet sniffing outcome to lack
>VLAN tag information (i.e., TCI-TPID). As a result, the packet capturing
>tool may be unable to parse packets as expected.
>
>The TCI-TPID is missing because the prb_fill_vlan_info() function does not
>modify the tp_vlan_tci/tp_vlan_tpid values, as the information is in the
>payload and not in the sk_buff struct. The skb_vlan_tag_present() function
>only checks vlan_all in the sk_buff struct. In cooked mode, the L2 header
>is stripped, preventing the packet capturing tool from determining the
>correct TCI-TPID value. Additionally, the protocol in SLL is incorrect,
>which means the packet capturing tool cannot parse the L3 header correctly.
>
>Link: https://github.com/the-tcpdump-group/libpcap/issues/1105
>Link: https://lore.kernel.org/netdev/20240520070348.26725-1-chengen.du@canonical.com/T/#u
>Fixes: 393e52e33c6c ("packet: deliver VLAN TCI to userspace")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chengen Du <chengen.du@canonical.com>
>---
> net/packet/af_packet.c | 86 +++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 84 insertions(+), 2 deletions(-)
>
>diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
>index ea3ebc160e25..84e8884a77e3 100644
>--- a/net/packet/af_packet.c
>+++ b/net/packet/af_packet.c
>@@ -538,6 +538,61 @@ static void *packet_current_frame(struct packet_sock *po,
> 	return packet_lookup_frame(po, rb, rb->head, status);
> }
> 
>+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
>+{
>+	struct vlan_hdr vhdr, *vh;
>+	u8 *skb_orig_data = skb->data;
>+	int skb_orig_len = skb->len;
>+	unsigned int header_len;
>+
>+	if (!dev)
>+		return 0;
>+
>+	/* In the SOCK_DGRAM scenario, skb data starts at the network
>+	 * protocol, which is after the VLAN headers. The outer VLAN
>+	 * header is at the hard_header_len offset in non-variable
>+	 * length link layer headers. If it's a VLAN device, the
>+	 * min_header_len should be used to exclude the VLAN header
>+	 * size.
>+	 */
>+	if (dev->min_header_len == dev->hard_header_len)
>+		header_len = dev->hard_header_len;
>+	else if (is_vlan_dev(dev))
>+		header_len = dev->min_header_len;
>+	else
>+		return 0;
>+
>+	skb_push(skb, skb->data - skb_mac_header(skb));
>+	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
>+	if (skb_orig_data != skb->data) {
>+		skb->data = skb_orig_data;
>+		skb->len = skb_orig_len;
>+	}
>+	if (unlikely(!vh))
>+		return 0;
>+
>+	return ntohs(vh->h_vlan_TCI);
>+}
>+
>+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
>+{
>+	__be16 proto = skb->protocol;
>+
>+	if (unlikely(eth_type_vlan(proto))) {
>+		u8 *skb_orig_data = skb->data;
>+		int skb_orig_len = skb->len;
>+
>+		skb_push(skb, skb->data - skb_mac_header(skb));
>+		proto = __vlan_get_protocol(skb, proto, NULL);
>+		if (skb_orig_data != skb->data) {
>+			skb->data = skb_orig_data;
>+			skb->len = skb_orig_len;
>+		}
>+	}
>+
>+	return proto;
>+}
>+
> static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> {
> 	del_timer_sync(&pkc->retire_blk_timer);
>@@ -1007,10 +1062,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
> static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
> 			struct tpacket3_hdr *ppd)
> {
>+	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
>+
> 	if (skb_vlan_tag_present(pkc->skb)) {
> 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
> 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
> 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>+	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
>+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
>+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
>+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> 	} else {
> 		ppd->hv1.tp_vlan_tci = 0;
> 		ppd->hv1.tp_vlan_tpid = 0;
>@@ -2428,6 +2489,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
> 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
> 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
> 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>+		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
>+			h.h2->tp_vlan_tci = vlan_get_tci(skb, skb->dev);
>+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
>+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> 		} else {
> 			h.h2->tp_vlan_tci = 0;
> 			h.h2->tp_vlan_tpid = 0;
>@@ -2457,7 +2522,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
> 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
> 	sll->sll_family = AF_PACKET;
> 	sll->sll_hatype = dev->type;
>-	sll->sll_protocol = skb->protocol;
>+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
>+		vlan_get_protocol_dgram(skb) : skb->protocol;
> 	sll->sll_pkttype = skb->pkt_type;
> 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
> 		sll->sll_ifindex = orig_dev->ifindex;
>@@ -3482,7 +3548,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 		/* Original length was stored in sockaddr_ll fields */
> 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
> 		sll->sll_family = AF_PACKET;
>-		sll->sll_protocol = skb->protocol;
>+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
>+			vlan_get_protocol_dgram(skb) : skb->protocol;
> 	}
> 
> 	sock_recv_cmsgs(msg, sk, skb);
>@@ -3539,6 +3606,21 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
> 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
> 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>+		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {

I don't understand why this would be needed here. We spent quite a bit
of efford in the past to make sure vlan header is always stripped.
Could you fix that in tx path to fulfill the expectation?




>+			struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
>+			struct net_device *dev;
>+
>+			rcu_read_lock();
>+			dev = dev_get_by_index_rcu(sock_net(sk), sll->sll_ifindex);
>+			if (dev) {
>+				aux.tp_vlan_tci = vlan_get_tci(skb, dev);
>+				aux.tp_vlan_tpid = ntohs(skb->protocol);
>+				aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
>+			} else {
>+				aux.tp_vlan_tci = 0;
>+				aux.tp_vlan_tpid = 0;
>+			}
>+			rcu_read_unlock();
> 		} else {
> 			aux.tp_vlan_tci = 0;
> 			aux.tp_vlan_tpid = 0;
>-- 
>2.43.0
>
>

