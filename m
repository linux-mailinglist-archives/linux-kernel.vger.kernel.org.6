Return-Path: <linux-kernel+bounces-204939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DDA8FF538
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD72BB23844
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89616A33A;
	Thu,  6 Jun 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3eYCuddc"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46F40BF2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717701728; cv=none; b=AI5uAN0+y6v9fjwKimH4Z2m+bwUnfiNoelQGC6har2d9G1Des+EUlHg5N8Al9ZDzKmdJuo0PU6k/fJTVhxOOqPjya4E6BXfts2CDQEL3lYZWSJz6fQt9pEiY0IU2hb4oSUMZvuJAUIKfOD/ccUivLi+4vI7T71Gusu9dDrF/Swk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717701728; c=relaxed/simple;
	bh=gfQl4iN5p0vTLqnzXDdwviLUj4ZcpSShuq2uZnXjqpo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Vh4DgsFRpD6BjT6eA0d09thQepaIEEjEsrhztxEqeHWYWql0RJMeNgwhecvPwwtKlae1WOrieSHrR6X3AoT3C5AYLfBPDhyBE8VVuMe0Ak9qAqqU8mvo29uOcQ4tpxCIeaqjl9cvilcaSr7ZpAsSPwI+qtTum2ZsO6cRctsFMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3eYCuddc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70258f8869cso1151475b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 12:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717701724; x=1718306524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2zlF4vUNG0tjOvsh4f17nUjCy+nmWVHulyjswEmhwgg=;
        b=3eYCuddcfklIVw8hFL/qOv4CNjn6Wwb+PcovTlbYawOZod45H3CnTQykIZiEuXd9VQ
         OPeQa8IspMEXh/3uFw0W5GyWRJpfLVax5gBe/kJ6xQMtjI1n0Yi/ISaF7tGf2myi8bWx
         Oz32XIkPNgJmgdr18qxIrheyDsYznUfLo6i0g8qIc8jaQQu29ZR3EbfoLEfjxdyNHIaF
         JlMIMWAh79dDnBtR2oBcARzSxV5Bw9eS+Ex4GdeAj2HtNYTZrV2knFBHUzOUptnV2lq0
         0k7J12SG20HsEUFh3ou74AnyQa2RlY1jtdvjiA79S0gv9Sq+PY5klgYqLjosvwu3Y73R
         9UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717701724; x=1718306524;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zlF4vUNG0tjOvsh4f17nUjCy+nmWVHulyjswEmhwgg=;
        b=KJGpINgy48J/kAi2LGjSEZx7vPJo1oOrpdm/RTWVRNub/LQgLwD7rkRrY20RiilPyX
         TVjqN742bg/lDAzThnHg2f+NSZA7S4iqr/yt3evsW4YAe8R4R+gEKuBV62lPiIYmzkmw
         iPPG4Yu2MAKX+XG+RWKw1K/HTzGjrrA32QJz6Khe4bQCmTg3fpdZAEiCWwRlbt7pZSNE
         qB6aLUXn+4barRC2y9quyfr4GvQBNu1Lszxvu0SrvSXD7cL3nwVN3+Q4ZdJ8Zyjgck1T
         6QpY5EW01wxE/K/ndR/vFgKIkyL/p2T3JWehnvlohZNBrxyzl8R46AKsmKKTkNga4W+m
         7I9w==
X-Forwarded-Encrypted: i=1; AJvYcCUMe3Z7d2j47pi9nXubYotuNwBDduHllTKZigU41rxhJM8qmKpN/MOFq5lOOeOcMHEIKE+TZMKlogMyGns/eLS5rSVTQZdMjnJMLWR6
X-Gm-Message-State: AOJu0YzSaiZdOS6I4JGSYZFwDJhcy9pUdkpC8UXyej78qYR2NS8ljvx+
	I+oU1p397dzKDqm0VAA6WMTv7oaHeICFe+0YPJqzuZeBuIQhLGBKTtg/607eiueiLDyT/c2vvTF
	/G/Vvd/Sphw==
X-Google-Smtp-Source: AGHT+IGefI9HK2+XI32+s+pf/HmQ/QeEgQPPMDQL1Z77AQq1mpTS4/DnqJ3S4W35NTL3YDeTT7APZhqb7mO45g==
X-Received: from joshwash.sea.corp.google.com ([2620:15c:11c:202:a3cf:7d53:6a60:be07])
 (user=joshwash job=sendgmr) by 2002:aa7:8881:0:b0:702:1a16:bc59 with SMTP id
 d2e1a72fcca58-7040c677855mr1070b3a.2.1717701724347; Thu, 06 Jun 2024 12:22:04
 -0700 (PDT)
Date: Thu,  6 Jun 2024 12:21:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240606192139.1872461-1-joshwash@google.com>
Subject: [PATCH net] gve: ignore nonrelevant GSO type bits when processing TSO headers
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, stable@kernel.org, 
	Joshua Washington <joshwash@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Eric Dumazet <edumazet@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Rushil Gupta <rushilg@google.com>, Catherine Sullivan <csully@google.com>, Bailey Forrest <bcf@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

TSO currently fails when the skb's gso_type field has more than one bit
set.

TSO packets can be passed from userspace using PF_PACKET, TUNTAP and a
few others, using virtio_net_hdr (e.g., PACKET_VNET_HDR). This includes
virtualization, such as QEMU, a real use-case.

The gso_type and gso_size fields as passed from userspace in
virtio_net_hdr are not trusted blindly by the kernel. It adds gso_type
|= SKB_GSO_DODGY to force the packet to enter the software GSO stack
for verification.

This issue might similarly come up when the CWR bit is set in the TCP
header for congestion control, causing the SKB_GSO_TCP_ECN gso_type bit
to be set.

Fixes: a57e5de476be ("gve: DQO: Add TX path")

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index fe1b26a4d736..04cb43a97c96 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -555,6 +555,10 @@ static int gve_prep_tso(struct sk_buff *skb)
 	if (unlikely(skb_shinfo(skb)->gso_size < GVE_TX_MIN_TSO_MSS_DQO))
 		return -1;
 
+	/* We only deal with TCP at this point. */
+	if (!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)))
+		return -EINVAL;
+
 	/* Needed because we will modify header. */
 	err = skb_cow_head(skb, 0);
 	if (err < 0)
@@ -565,18 +569,10 @@ static int gve_prep_tso(struct sk_buff *skb)
 	/* Remove payload length from checksum. */
 	paylen = skb->len - skb_transport_offset(skb);
 
-	switch (skb_shinfo(skb)->gso_type) {
-	case SKB_GSO_TCPV4:
-	case SKB_GSO_TCPV6:
-		csum_replace_by_diff(&tcp->check,
-				     (__force __wsum)htonl(paylen));
+	csum_replace_by_diff(&tcp->check, (__force __wsum)htonl(paylen));
 
-		/* Compute length of segmentation header. */
-		header_len = skb_tcp_all_headers(skb);
-		break;
-	default:
-		return -EINVAL;
-	}
+	/* Compute length of segmentation header. */
+	header_len = skb_tcp_all_headers(skb);
 
 	if (unlikely(header_len > GVE_TX_MAX_HDR_SIZE_DQO))
 		return -EINVAL;
-- 
2.45.1.288.g0e0cd299f1-goog


