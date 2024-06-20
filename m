Return-Path: <linux-kernel+bounces-223614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF8D91158F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9381C22CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58C655880;
	Thu, 20 Jun 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BKkMeEDe"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325C1527BB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921968; cv=none; b=qpvaANjJUlbWoMwch3N0M8KYjzyMHUOM2cxKehbk3aRKxnIoix4Ug7ZgGxikvTLuTQMKVyeb/yUSZAn5O+ean34+/fKssveDsVex/FgBWjOMSteXV4COqfto9ZdTySHzWypTfMeZ8IOMSUnNeTD5VMvKMWPltRwB2ONRtBZD7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921968; c=relaxed/simple;
	bh=F57HceSCarSUFFP4CorQ7f5+Hq22MkL63tl52DzITRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLo68XbPAYAfSAH2VJymkGydg5z9gBgH8Ir7XOnPEg2GqS6HYhjk7HZGkEwAyGYlqqfNDDCCjmJTdEc5QHfCstZfKwhKpxhlSsV/PoBQrQxNTRZeyZedh0aWBU63e3jTL15tijcd7bXPgecDUKLbE4rAtTon1HJ3QsHUc0owexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BKkMeEDe; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-797a8cfc4ecso87729785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921965; x=1719526765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOnJGiRbyO/FJXIIwBJKoyy1x0jsuLmmE0P/5OKn6WU=;
        b=BKkMeEDe7+4ayjUJrfnivzyhNx+umSzTdrk3ImQu+QVT4HrhuFKv4PUjgZJaLZjV2V
         JTE9hQUdz3McVLjtB/WNfSon7c65gxdYZCUtjgsIlzAO9CjOLLbfMQyMBQm9XsU9cdzX
         5jyq9WcLRfGDdtOvFzXddrNNHYI6l1GkuTQp/ol6L8Hicv73Bh2pgCnQbU9CK2pxq6de
         Ny5BFoPf1epzyBvB6jyZF+i7niXBGl6RNgZnKKGV8wsEm+rXczaWFGffmiZesG5kS37Z
         QkzihWbu14QgW6smkCBy8SsAwDH+lS9x6mOjYYE3ncqdNKTjBdz0b7/ofoTxxvxBKOHW
         JklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921965; x=1719526765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOnJGiRbyO/FJXIIwBJKoyy1x0jsuLmmE0P/5OKn6WU=;
        b=N/v/KIYMjdykCkWB8U1KA14FN1wJNyd5/1pEVI0r8Z7uIxV53u0HgzDrjk+xmKLF2k
         LHaqxwL5lox1ipDsCHGvt0c5CmqB/1yc2KzQ373LP8fKt8JCDiDD1tBbC0CnajAALxZs
         qDTvRhj9cLsdg9Miu9ncUOOGVVAoUaLOBjQ6Q/hwJP3cetWHR+aOPBcHXww5Xzz9d8gD
         zhN7PQRVTPPQBM3ottSS6BowP1duo9eYYKGLpF4O2hdtudvxhKZbKeVy+i2hwqmhr8Wf
         lLQrKYsMvvC/EGyK6X9UScoKkY67+xWUUpmDEWzRo6/grWCHz9J5PNFgw7n5wu2aI7YP
         NASw==
X-Forwarded-Encrypted: i=1; AJvYcCVy9zd/Jo5D+HQwKGyMx0FHqHqqdOh3c89xeod1OYRLA3/HSxxWBLCxGlW1l4Y0VNPHNNQOSGk6MPGDxc2VBnbApU4n2ycyCQWYE6By
X-Gm-Message-State: AOJu0YwsiYs4DgzJsrhJjXX982EgOicz6ijzzid9Hso9szRvCVvwL38z
	ZXPx0IvzORqoTSTeDpunVX82sm3BY3WiljHvaSqF96omrGR/esCip/Eui0s2HTM=
X-Google-Smtp-Source: AGHT+IF9DmzujCRKuDPqvcTpHJ5tK40LwVxagHzuDnQcW/zjLbmWI370fRf/NDqGQdzoIWlhSdGjVw==
X-Received: by 2002:a0c:db83:0:b0:6b0:4542:e42e with SMTP id 6a1803df08f44-6b501e3f5a3mr78560556d6.28.1718921965457;
        Thu, 20 Jun 2024 15:19:25 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed7ed94sm813456d6.73.2024.06.20.15.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:24 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:22 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC net-next 5/9] ice: apply XDP offloading fixup when building skb
Message-ID: <a9eba425bfd3bfac7e7be38fe86ad5dbff3ae01f.1718919473.git.yan@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718919473.git.yan@cloudflare.com>

Add a common point to transfer offloading info from XDP context to skb.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 6 +++++-
 include/net/xdp_sock_drv.h                | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8bb743f78fcb..a247306837ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1222,6 +1222,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 			hard_start = page_address(rx_buf->page) + rx_buf->page_offset -
 				     offset;
+			xdp_init_buff_minimal(xdp);
 			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
 #if (PAGE_SIZE > 4096)
 			/* At larger PAGE_SIZE, frame_sz depend on len size */
@@ -1287,6 +1288,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 		/* populate checksum, VLAN, and protocol */
 		ice_process_skb_fields(rx_ring, rx_desc, skb);
+		xdp_buff_fixup_skb_offloading(xdp, skb);
 
 		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
 		/* send completed skb up the stack */
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index a65955eb23c0..367658acaab8 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -845,8 +845,10 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	xdp_ring = rx_ring->xdp_ring;
 
-	if (ntc != rx_ring->first_desc)
+	if (ntc != rx_ring->first_desc) {
 		first = *ice_xdp_buf(rx_ring, rx_ring->first_desc);
+		xdp_init_buff_minimal(first);
+	}
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
 		union ice_32b_rx_flex_desc *rx_desc;
@@ -920,6 +922,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 			break;
 		}
 
+		xdp = first;
 		first = NULL;
 		rx_ring->first_desc = ntc;
 
@@ -934,6 +937,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 		vlan_tci = ice_get_vlan_tci(rx_desc);
 
 		ice_process_skb_fields(rx_ring, rx_desc, skb);
+		xdp_buff_fixup_skb_offloading(xdp, skb);
 		ice_receive_skb(rx_ring, skb, vlan_tci);
 	}
 
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 0a5dca2b2b3f..02243dc064c2 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -181,7 +181,7 @@ static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
 	xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
 	xdp->data_meta = xdp->data;
 	xdp->data_end = xdp->data + size;
-	xdp->flags = 0;
+	xdp_init_buff_minimal(xdp);
 }
 
 static inline dma_addr_t xsk_buff_raw_get_dma(struct xsk_buff_pool *pool,
-- 
2.30.2



