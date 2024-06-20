Return-Path: <linux-kernel+bounces-223610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 226D2911584
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468E01C22CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FD2143742;
	Thu, 20 Jun 2024 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XRsIm6Xs"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BA913E022
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921956; cv=none; b=sv2UG0UdPXyYT2zjPJ9m9mVIbCigGnYYct3qJnsoLfgV17CJ25E5Un2H69VIAxmsKgY3GEfA/dkRTeEaOfH83YyzMeJ5D8CDyJD9QhnGmAIUc9QW0rlPIZzrbRm3HHjzRfBHZnOOudSujxC41JFtSBd1pYIZKGUV+0v7zeVHSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921956; c=relaxed/simple;
	bh=pHtp0uDmiO5wfmdzU4s/C08CnF5M0OpaIo5ctXGQv8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DR0+XmUNbenCMgvLUSEGOC4J1aTsolNROIHXL9tMfzg7sshYgAaeGM+rQ7ztbIEkfyk6F1O8+Jl+IBm2zS+EumD99afXw26GfkZxPZHhM1wWFB26U4eJmEH1lucq/JSEu3SH1yy728sAARM3D2QIqlkSlZZ7OVj3vLNxrMUJ6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XRsIm6Xs; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5100040bdso6900616d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921953; x=1719526753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vglLIcmqkxz9MKZSitoSYTZWttEKNgPr+WI84+LeUZI=;
        b=XRsIm6Xsv3Zj1Pbacr6FN7Dgm4G6ld4o9nCkBVLeY9TFzcRGT4P3H2tUCHogztmCOi
         IL66xY5ji2VeX+6CUQ9GWSZB1GMAvPD8tVdOJts9T2OIjyDDqnC2vNc7yWhgTltsIV4L
         WTkjjQXQCO33TnccciNhaJfPAK+fYMLjB5iBLlEJgQXoeM1D/mOlw1srf99Dk8BqLJqx
         v+uW2rlYD6i2qfpa+yIrLIZYcCq1wduFR04QJ9DrZCB6paLlOi/0WkMKkJ2Uhn51avul
         uizcKvjcg23BvEFP/2aem2cMrvzhpnbLt02fZ17ChIvqQXdSu1wfMdVI8nxPCQ+2PtzK
         vRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921953; x=1719526753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vglLIcmqkxz9MKZSitoSYTZWttEKNgPr+WI84+LeUZI=;
        b=Y8nv4Dv9qyQyt4nx32X7Rq88r+4bQv7GuKfc7pyH17sLJA3Hqw121xTP1RYlAGlmgL
         Xx4G22sMS2Clj4lPBYmuTcvspoFTeuo/kmFC6YxK6fplSTPYap6G1gH/WRc68RiZTjs2
         Oo5YKy37dYpCHZATP8h+dH9U17wuN+Wbqiz8AcCqM+FKjjm6j1Q9Qa76nXb/poT8NFBY
         0uAda8A/FGYiZWjtthvNLOoR8A7P3qHqF+K1jB4HVa4PIQ7st7R6kN1RQuqM2a9bW3I0
         Wp3OfEPghFlMKivqVG8VP2k+9wlOedKqCuWhqFfHwJmx3kHfwwViSkO/p9xjB4ecYdjL
         9n4A==
X-Forwarded-Encrypted: i=1; AJvYcCXsJIMX9yiGnMwCCukTxm8f4ptsS1PpJYBWR4QAoaweNlc5xHYHBJcruwJpztcYFMFwPkng5HsLRYTY0KtzmP5qVWYNap8vE2Io0Uhm
X-Gm-Message-State: AOJu0YzhnuAFyLb86ngCxkK9hDZ+BD8l/ONLOtSQHlzYnD5H7TfAqVKY
	baVMI/1WD8gNLD3pW82ucaenFDXgSor3c8x49TgxuaNMSdOKP1RQO+dhKBdSFnM=
X-Google-Smtp-Source: AGHT+IEVgAA7E+oyYVF7rzTogs/p51VHdVu9fF5exJ0i6vUUWb2pWCPpmU7B1QKXSrEbD2j41c1bAQ==
X-Received: by 2002:a05:6214:a68:b0:6b2:e201:a366 with SMTP id 6a1803df08f44-6b501e63d52mr73822526d6.39.1718921953538;
        Thu, 20 Jun 2024 15:19:13 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef30dadsm806786d6.77.2024.06.20.15.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:12 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:10 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Mina Almasry <almasrymina@google.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Antoine Tenart <atenart@kernel.org>, Yan Zhai <yan@cloudflare.com>,
	Felix Fietkau <nbd@nbd.name>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC net-next 1/9] skb: introduce gro_disabled bit
Message-ID: <b8c183a24285c2ab30c51622f4f9eff8f7a4752f.1718919473.git.yan@cloudflare.com>
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

Software GRO is currently controlled by a single switch, i.e.

  ethtool -K dev gro on|off

However, this is not always desired. When GRO is enabled, even if the
kernel cannot GRO certain traffic, it has to run through the GRO receive
handlers with no benefit.

There are also scenarios that turning off GRO is a requirement. For
example, our production environment has a scenario that a TC egress hook
may add multiple encapsulation headers to forwarded skbs for load
balancing and isolation purpose. The encapsulation is implemented via
BPF. But the problem arises then: there is no way to properly offload a
double-encapsulated packet, since skb only has network_header and
inner_network_header to track one layer of encapsulation, but not two.
On the other hand, not all the traffic through this device needs double
encapsulation. But we have to turn off GRO completely for any ingress
device as a result.

Introduce a bit on skb so that GRO engine can be notified to skip GRO on
this skb, rather than having to be 0-or-1 for all traffic.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 include/linux/netdevice.h |  9 +++++++--
 include/linux/skbuff.h    | 10 ++++++++++
 net/Kconfig               | 10 ++++++++++
 net/core/gro.c            |  2 +-
 net/core/gro_cells.c      |  2 +-
 net/core/skbuff.c         |  4 ++++
 6 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c83b390191d4..2ca0870b1221 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2415,11 +2415,16 @@ struct net_device {
 	((dev)->devlink_port = (port));				\
 })
 
-static inline bool netif_elide_gro(const struct net_device *dev)
+static inline bool netif_elide_gro(const struct sk_buff *skb)
 {
-	if (!(dev->features & NETIF_F_GRO) || dev->xdp_prog)
+	if (!(skb->dev->features & NETIF_F_GRO) || skb->dev->xdp_prog)
 		return true;
+
+#ifdef CONFIG_SKB_GRO_CONTROL
+	return skb->gro_disabled;
+#else
 	return false;
+#endif
 }
 
 #define	NETDEV_ALIGN		32
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f4cda3fbdb75..48b10ece95b5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1008,6 +1008,9 @@ struct sk_buff {
 #if IS_ENABLED(CONFIG_IP_SCTP)
 	__u8			csum_not_inet:1;
 #endif
+#ifdef CONFIG_SKB_GRO_CONTROL
+	__u8			gro_disabled:1;
+#endif
 
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
@@ -1215,6 +1218,13 @@ static inline bool skb_wifi_acked_valid(const struct sk_buff *skb)
 #endif
 }
 
+static inline void skb_disable_gro(struct sk_buff *skb)
+{
+#ifdef CONFIG_SKB_GRO_CONTROL
+	skb->gro_disabled = 1;
+#endif
+}
+
 /**
  * skb_unref - decrement the skb's reference count
  * @skb: buffer
diff --git a/net/Kconfig b/net/Kconfig
index 9fe65fa26e48..47d1ee92df15 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -289,6 +289,16 @@ config MAX_SKB_FRAGS
 	  and in drivers using build_skb().
 	  If unsure, say 17.
 
+config SKB_GRO_CONTROL
+	bool "allow disable GRO on per-packet basis"
+	default y
+	help
+	  By default GRO can only be enabled or disabled per network device.
+	  This can be cumbersome for certain scenarios.
+	  Toggling this option will allow disabling GRO for selected packets,
+	  e.g. by XDP programs, so that it is more flexibile.
+	  Extra overhead should be minimal.
+
 config RPS
 	bool "Receive packet steering"
 	depends on SMP && SYSFS
diff --git a/net/core/gro.c b/net/core/gro.c
index b3b43de1a650..46232a0d1983 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -476,7 +476,7 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 	enum gro_result ret;
 	int same_flow;
 
-	if (netif_elide_gro(skb->dev))
+	if (netif_elide_gro(skb))
 		goto normal;
 
 	gro_list_prepare(&gro_list->list, skb);
diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index ff8e5b64bf6b..1bf15783300f 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -20,7 +20,7 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 	if (unlikely(!(dev->flags & IFF_UP)))
 		goto drop;
 
-	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
+	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(skb)) {
 		res = netif_rx(skb);
 		goto unlock;
 	}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2315c088e91d..82bd297921c1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6030,6 +6030,10 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 	ipvs_reset(skb);
 	skb->mark = 0;
 	skb_clear_tstamp(skb);
+#ifdef CONFIG_SKB_GRO_CONTROL
+	/* hand back GRO control to next netns */
+	skb->gro_disabled = 0;
+#endif
 }
 EXPORT_SYMBOL_GPL(skb_scrub_packet);
 
-- 
2.30.2



