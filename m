Return-Path: <linux-kernel+bounces-209035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38797902C25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D701F23264
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E50B15279A;
	Mon, 10 Jun 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RnzGjjpv"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371FB1514C0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060258; cv=none; b=VcKXfswjqRsl6eBQK75+iuniEqLUqxsVvzPkDGVyPQKHTAomqRowhD4ptUamrEcR2p7RF7EeLyWIjEnjffSzxt6LYHC/6343OQ+Xls128JQi4WP4TG1+A5DwKlgpLSqKJa7Achs9NhswJCW4sNvn0g9M+3gwgEYhTJz2GyulENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060258; c=relaxed/simple;
	bh=qT2UzxMxj27QF/RZZE1Vit0ZbGo8Ka2+OgpxCUL/9GY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p9qL+rrHdcL1mQV9P2s76mV0RRLGFAjkV5MKl8MroTEtpVNv+S3NEl1CLmoQHlKnN9xckYy4M6E4hzEXvXWy0GiVH6YVvQ2eBbI3eI1RT8quwqnYTIbU9mIZ+8idXYRgVTR4Wwy8u3dSMqZLRCsQwIgxvaGH1PPW0bplsU7U4tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RnzGjjpv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-705a047f983so794223b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718060256; x=1718665056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZbfKxx3z/c0BgKgu/7amabvTQUwHCZ/pP82fEJMD0M=;
        b=RnzGjjpvej7FnKn/koz4IbpX6fy4adpqg7npDAdOoFZOZ3Pq/N7opTFATzg8o/pjnS
         jXCXwnV7VjFiePMv5i4FzvuBWQvgpsMZaIfVdHTkVNhEqKjcQ4Uo1ZmBqpVeGMceohNu
         y6YVb57ZDYOPLTTbFJnH0XxHfBe8zsGArhuRDlriNVEVoqg9jMJRqo25yYOKx3hemWA5
         rJgPi1iFw+I4kgC2qGOkMnCSy0Li4nYEe5qPbcqhzFDYxNSKxAv+cy6MG9BYzZhP/bDZ
         6fXb7GRhFxUEp/fnpYU5pGrUjaXd4J7VUw4j+j2nKMOjqYIY7tw3lj98lMAfhlcAy8G7
         k6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060256; x=1718665056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZbfKxx3z/c0BgKgu/7amabvTQUwHCZ/pP82fEJMD0M=;
        b=dQ9d8y1BqhgTHoUl2bmRx2c73/wEP/btjAfaFAmYgyHWHOng4HqPVRtjwLNNiRR+MZ
         MhV1AAdPvFGyGzQU+ugkk7ZbtRvtJJsxiCPndP/tbBpqfIxcIirbUe4D3/RXgOWhmT+0
         nBzvp6yWQWxBM1cwszACxz6aTjqADYD6OtkfgJDkDJ5kEBEL+eUeOh4KTHyYJ6Yr2ra6
         cncJZABm1YBGtjPTHW7dqWiR9lhijtay54vpc9HLmwUYP0jxui1yhYYJxM97oprxBcCY
         oVWBbY0y3r90iJu3Lvp+dI0ydG3nmalSgo5xGYO+Pk/nHuo8wcL0eKB6muu2FYDkmqvF
         eZrA==
X-Forwarded-Encrypted: i=1; AJvYcCVXBFiLNwyTNzsjbzxSkUojAyGbrGmGvb2TAbpVFmWyVppykYsgrWwfw7P3lx6owYBvTSyCLSaOY2ToWm1xaSEFkvHMtyAzGYc0b3Mg
X-Gm-Message-State: AOJu0Yx/AU7pgI0kG3qoqhJWuH6U8aP4SAfLxloOMQMusBwLlqDI1aKX
	0fgYwQgJsJxSZ4NgAC8T//Du8J7wvSnuYTxcnM79VNbX2yiatb9j1ammbmYE5C9DWWCghAygreM
	Bu8WKR6/S3A==
X-Google-Smtp-Source: AGHT+IHxXPGcBQ8hDEwrw30irOlMrDH6SW5biFLz1h0dUC+fvkh9hNUsBuSSX4W/y8WlbY9mIjgZG5a5DpjHVw==
X-Received: from joshwash.sea.corp.google.com ([2620:15c:11c:202:b54a:8bd9:9bf9:ca9f])
 (user=joshwash job=sendgmr) by 2002:a05:6a00:1a86:b0:6ec:f5b8:58cc with SMTP
 id d2e1a72fcca58-7040c885704mr108018b3a.6.1718060256242; Mon, 10 Jun 2024
 15:57:36 -0700 (PDT)
Date: Mon, 10 Jun 2024 15:57:18 -0700
In-Reply-To: <20240607060958.2789886-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240607060958.2789886-1-joshwash@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240610225729.2985343-1-joshwash@google.com>
Subject: [PATCH net v3] gve: ignore nonrelevant GSO type bits when processing
 TSO headers
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, stable@kernel.org, 
	Joshua Washington <joshwash@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@google.com>, Andrei Vagin <avagin@gmail.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rushil Gupta <rushilg@google.com>, 
	Catherine Sullivan <csully@google.com>, Bailey Forrest <bcf@google.com>, 
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Acked-by: Andrei Vagin <avagin@gmail.com>

v2 - Remove unnecessary comments, remove line break between fixes tag
and signoffs.

v3 - Add back unrelated empty line removal.
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index fe1b26a4d736..0b3cca3fc792 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -555,28 +555,18 @@ static int gve_prep_tso(struct sk_buff *skb)
 	if (unlikely(skb_shinfo(skb)->gso_size < GVE_TX_MIN_TSO_MSS_DQO))
 		return -1;
 
+	if (!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)))
+		return -EINVAL;
+
 	/* Needed because we will modify header. */
 	err = skb_cow_head(skb, 0);
 	if (err < 0)
 		return err;
 
 	tcp = tcp_hdr(skb);
-
-	/* Remove payload length from checksum. */
 	paylen = skb->len - skb_transport_offset(skb);
-
-	switch (skb_shinfo(skb)->gso_type) {
-	case SKB_GSO_TCPV4:
-	case SKB_GSO_TCPV6:
-		csum_replace_by_diff(&tcp->check,
-				     (__force __wsum)htonl(paylen));
-
-		/* Compute length of segmentation header. */
-		header_len = skb_tcp_all_headers(skb);
-		break;
-	default:
-		return -EINVAL;
-	}
+	csum_replace_by_diff(&tcp->check, (__force __wsum)htonl(paylen));
+	header_len = skb_tcp_all_headers(skb);
 
 	if (unlikely(header_len > GVE_TX_MAX_HDR_SIZE_DQO))
 		return -EINVAL;
-- 
2.45.2.505.gda0bf45e8d-goog


