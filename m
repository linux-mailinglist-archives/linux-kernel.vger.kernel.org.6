Return-Path: <linux-kernel+bounces-223611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FA8911587
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48D11C229C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B88014D45A;
	Thu, 20 Jun 2024 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EFUa91pQ"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296F143873
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921959; cv=none; b=AF5uvlXnf0txShKE/YiPsXPMF1YhY2VPWbSi9dVl3KxRGdFIzL2NbFJnDludJGQIWjVJsPD+aPT3WSytwpC2o40zfVKqU9P1iMZlG0d8DCIT9b2ETiTTvJHgiy50cWh1Q6x+m56UYh/PDCk80gkqH9AqSJ3W3vrux7sm8D8emHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921959; c=relaxed/simple;
	bh=5J3U+2tXyIkdzHN6Xl/FaBxF32TrMa5RnMJ5U+eZdNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NB+YqQcCGsQZBotly+1v/XZ21+q7BrEEvrwj6Wr0Bx9w8sjdCv4YpVLQO2S3bX2qsjmutfOhmBSVazDjzjcLvtabl5B6Sn4MIBp2oOX4X3sBpn9Ztrp96IAnmc9R3DJViUmrqjakXOoBo9sx6yJ11fPB5yq1WSVtO+ojdxZRUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EFUa91pQ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4405c2263eeso6037281cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921956; x=1719526756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4K1BN+SPtXdd3ql7WAzKbubsDUROfUSXcn2h8iFQhw=;
        b=EFUa91pQMLekj8R45UBktScdzaoX/+rW7Cwj1mf3FKuy2kJbfTYCw4pJGpSXy2SICx
         goC8iWI1op4/8Qfem5UgBph7ZMgaS5QV5opoHbxWBFLPxvY0e3BkIYuMDHRCr4zn+YvF
         UBNyEXn8cfHY/OglVQgt1glVyNmxltuHH1ln81hvDAg/dAD93Fdbj7W0FC5bkYY27VfD
         eLA6zTDIQuqLncAQYqM3Nep34MasM7+kYlguzgf3hS/ZcpHKYw27V6Xf/vAYnA0YOskQ
         0clV0xpm7YgaQJDNv+Asr5WilRon88H4rKytJqLi5+BBABjr+HyNY+r6OZD4XCPd/a1X
         BtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921956; x=1719526756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4K1BN+SPtXdd3ql7WAzKbubsDUROfUSXcn2h8iFQhw=;
        b=KdsKra1+d0B1ieMlYdbGpmlN/RUWLQtHHSn21opzXTl56503fU2BspNltlB3Tmezmq
         2/2EL2q+pUx5l1JSZdakMwoCTZuT70SCA0tw3xf4uLA9diOA2iW1+rgc/Mzo92Yffgwm
         TGYudrxj6A2spZUi0LGVWk7sjPPkZo/LKAjv7WQIl9a0s/nDrP67l4myg8WmIyDJCjJM
         ru5+Lnqcz7DSIDFQYKpHjZiU0TDwGCB5idQSTIoUql7N0ZlCq/U0Ktleid0D5DS4LTcJ
         XhQy9Edvxvumnv3pLvi5q4fO/mlyv7Y4cAJcd7OvSw3heS+yB6kfFuBQ9LqEV9GAOZ9/
         6a+A==
X-Forwarded-Encrypted: i=1; AJvYcCVO91HLSF5pdgqKJauQX4J3Hqk9Jb94c9qr/iJyijZ3QV/+r/nNEGi+7aKCGS+4x8o9q5JODlq+p4uAvVx9cKQ1GSnqw9X8W+fbb11I
X-Gm-Message-State: AOJu0Yw/KwUHAV0keBBoAMO03SEqITzMo3rJQHk9/Bw3LQPEPcpuadft
	mUIZ/e38L8yH0ydgMmSd3KjgxIFV9ODdsIFlukAgPNiNEkaBSM9ARuo9fcVDWpE=
X-Google-Smtp-Source: AGHT+IH/QkmWwQA9hpRMOy20IKpIVcI8ok6r3p/vf6l/W9sSsgCcJ0RyunGU/cUVp/0nDeJFWt/+YA==
X-Received: by 2002:a05:622a:110e:b0:444:a0df:3115 with SMTP id d75a77b69052e-444a79dacc6mr68195771cf.31.1718921956175;
        Thu, 20 Jun 2024 15:19:16 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2c3c334sm1844221cf.60.2024.06.20.15.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:15 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:13 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 2/9] xdp: add XDP_FLAGS_GRO_DISABLED flag
Message-ID: <39f5cbdfaa67e3319bce64ee8e4e5585b9e0c11e.1718919473.git.yan@cloudflare.com>
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

Allow XDP program to set XDP_FLAGS_GRO_DISABLED flag in xdp_buff and
xdp_frame, and disable GRO when building an sk_buff if this flag is set.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 include/net/xdp.h | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index e6770dd40c91..cc3bce8817b0 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -75,6 +75,7 @@ enum xdp_buff_flags {
 	XDP_FLAGS_FRAGS_PF_MEMALLOC	= BIT(1), /* xdp paged memory is under
 						   * pressure
 						   */
+	XDP_FLAGS_GRO_DISABLED          = BIT(2), /* GRO disabled */
 };
 
 struct xdp_buff {
@@ -113,12 +114,35 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static __always_inline void xdp_buff_disable_gro(struct xdp_buff *xdp)
+{
+	xdp->flags |= XDP_FLAGS_GRO_DISABLED;
+}
+
+static __always_inline bool xdp_buff_gro_disabled(struct xdp_buff *xdp)
+{
+	return !!(xdp->flags & XDP_FLAGS_GRO_DISABLED);
+}
+
+static __always_inline void
+xdp_buff_fixup_skb_offloading(struct xdp_buff *xdp, struct sk_buff *skb)
+{
+	if (xdp_buff_gro_disabled(xdp))
+		skb_disable_gro(skb);
+}
+
+static __always_inline void
+xdp_init_buff_minimal(struct xdp_buff *xdp)
+{
+	xdp->flags = 0;
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
 	xdp->frame_sz = frame_sz;
 	xdp->rxq = rxq;
-	xdp->flags = 0;
+	xdp_init_buff_minimal(xdp);
 }
 
 static __always_inline void
@@ -187,6 +211,18 @@ static __always_inline bool xdp_frame_is_frag_pfmemalloc(struct xdp_frame *frame
 	return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
 }
 
+static __always_inline bool xdp_frame_gro_disabled(struct xdp_frame *frame)
+{
+	return !!(frame->flags & XDP_FLAGS_GRO_DISABLED);
+}
+
+static __always_inline void
+xdp_frame_fixup_skb_offloading(struct xdp_frame *frame, struct sk_buff *skb)
+{
+	if (xdp_frame_gro_disabled(frame))
+		skb_disable_gro(skb);
+}
+
 #define XDP_BULK_QUEUE_SIZE	16
 struct xdp_frame_bulk {
 	int count;
-- 
2.30.2



