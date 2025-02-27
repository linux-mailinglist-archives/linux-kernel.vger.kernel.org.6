Return-Path: <linux-kernel+bounces-535313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC51AA47139
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93A1188579F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1041D1EB5EE;
	Thu, 27 Feb 2025 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HrUXedkq"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754161E5218
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619392; cv=none; b=rcmLDLkpD6Gbtfit4rp+zs+usK8lLoHOIYYyfQ/CP1aAnLYuLCjt+zBdCS2gbw5nmRt04wKxbeEUyZTqn/HShsAuI1hoXQEmh90sWXTO3y8HGrN12meDNsV9bP0jYQvS4XX0upXC1wzc6h7+i26YczZ8mFQC3zPntuXLeM7+Ess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619392; c=relaxed/simple;
	bh=JA7masIb+fyQcs/Z0y1gbGLPicAtIT3ViR4aoSMjtXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f4o/LHfeRE6HHhcAzSojaDy/rlbZAY1GY0Dlog9ZgWp4xHFl0Cm9fwmjvTpE9eSyuC9WaENQFXM9BwycDbcm6fPKOfTrikVpdNU1bYnFzcLdJFrbUsbcmb2jTRe524II8Ku7JTm8EUgzBrkR3HosXHed3D+FjsylWc45H1+l6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HrUXedkq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439a331d981so3644115e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619387; x=1741224187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMNJiu3Lg627dyePrVylvpX/tk8XNSi9bzrWTv7Zr2g=;
        b=HrUXedkqibXL2QcBS9o8V0X07xj5/cGswmD8wcr6XWE0PV/WJgqTVJxL20MnROcbTM
         b81EUsBiwEf1K8syp3ecj25aTX30hs0HHZJ8OdUh/i6Cv0L2kRxVXL0URWxvuuFB59Lv
         NxoXbTCasvJM28QUX0QdjOJbbhy+hqO+vElMaUoC/8XvfxT8x792aSB/SRWyOgtl7wbn
         rDyMagDjRctSmKN2/hTof8CJlxgXd6SHyclTV91lYaWMP93s79bNS1XNUk5vOtSbJYrD
         Z08I8Fu4y8TJvr+omfY2AsxUhO9UYG2rF+hyKba4DHm4Srpo9QKRn9R9/2lGxIi9h1l/
         lKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619387; x=1741224187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMNJiu3Lg627dyePrVylvpX/tk8XNSi9bzrWTv7Zr2g=;
        b=GHmjqFTV6C4vgA0MAZqlLOI6YHRIzc/T67SkZpCKDPUptn7dlKmDDi2Y4HKk2tph/0
         fS1dVpx6vaDyTZgjpau+iFRVY42DPwGoYNTRSjCB4KV1WQcapRGXEQeQJ/FfK9HcvI3N
         SOPK3DW1vGfYC2tlXvHyZyR7bIEYBoo9okoUQYdeorSs5/JbbMEIdjKTLtwhFKfMShnA
         6gtdsFyRGDdqwoOGsSDtaqGRkhjKc49fbdfC7PRBCsRJhwNeE8PF4zdAe83zWpXjv78V
         gI7FfOO4hCu7E9EcqtMgqVb0QugNhPQNbJx1/CEA678yYZxXzErXqtTwFN4cViLGoKTR
         Q/og==
X-Forwarded-Encrypted: i=1; AJvYcCUAceFq3x//YOr4NAujNqG0LjxHPFu0l2BOIBy6/sVYjS3dP1z6HSCe7+NMAK8j5WLQvSNe9j0HZr+Ko08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQeHaUPsMLxytqiy0HsDHFVJQBeGcR1EFyO8pUmB+QU537l11
	GCTULwCxJhEqTpso03sgUZFZ6lhJbTtapKEnolM2YSOxD4JIUVIqR/1kP76lIcS0iIlCoMfGwL1
	0
X-Gm-Gg: ASbGncueluMFUtDoQWWw4e2J6KCGPSLmNwgoBDXChCfORhsS15rKUea8tY49QOoYVcu
	VqCvPE6Nt3YexxzV6HsFltXlG39cJViY8VYWgBEcrY8Qu0eqjVM0YFHmjX+uD1tIMXl7eU1U8bP
	nEhRaaiIUJzOVlryxlaXHK9Oi9mvan5PkHNY4dHKpRI6OtvCtSvDuwL4v9qIl5B7Dxd5wwJT55b
	lYsLrRTkPjVsrGTsED7zW7OyAfoIYCe9ribxBKU9Zsxnwd3OKz7gM9LaMDqWM8jydU9UjkzI/Xz
	TNEGH0Q4dRqbRNGPA2znIyeiFbvNoW5HhqvACA==
X-Google-Smtp-Source: AGHT+IHbituMJs3rWfj8UVNf8ic9Oyz4eGoJgyJUmucaf6WbuSO33oox4PlIFWu+TXXxyg8QKwaFBQ==
X-Received: by 2002:a05:600c:3ca3:b0:439:6a7b:7697 with SMTP id 5b1f17b1804b1-43ab8fe183fmr54568035e9.14.1740619387375;
        Wed, 26 Feb 2025 17:23:07 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:23:06 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:43 +0100
Subject: [PATCH net-next v20 18/25] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-18-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2830; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=JA7masIb+fyQcs/Z0y1gbGLPicAtIT3ViR4aoSMjtXI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75hcisvqzn3UoVZSgYaxLRA6UQy8GGmElNPn
 kzJUW2THpqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++YQAKCRALcOU6oDjV
 h/fjCACL64BMaoFluD7BHFJUw6XwGNM+33rLusIfvoJ+Dwnd4uZNQC9E8S3JeRqc0dIceB/h2+r
 pu++E7+PwsOA22DHQTtMh8cr8uuGeAcU4LQv19Oa0oIslFlo+WMFvWJzy0ZghrnmyWe8MGrsQN+
 r2vrtKHLOs40wdK7VW/gRo9UY1beFRsIIcAjNnTWLbpDSwUrsfSVGeP1+l3l53YutjNSERSDu1c
 4/8EZbSfQyTJxSrz1RiidWSBCJGA7llsR8WAX1AzKPnmWU+FXF1v4RmOrTrtuc+7s/6Ta1yntDJ
 69GAf+Cv+DOXAISew8DZlaxvNX6lZSLPdwTY4eKhmXBbcssR
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

In case of UDP links, the local endpoint used to communicate with a
given peer may change without a connection restart.

Add support for learning the new address in case of change.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 98c43509a4c9161db65a4bc876940bce33290fd3..cf32f3a354c10a71c23c7261aee5a2f98ecb6cc1 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -522,6 +522,51 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	llist_add(&peer->release_entry, release_list);
 }
 
+/**
+ * ovpn_peer_update_local_endpoint - update local endpoint for peer
+ * @peer: peer to update the endpoint for
+ * @skb: incoming packet to retrieve the destination address (local) from
+ */
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb)
+{
+	struct ovpn_bind *bind;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind))
+		goto unlock;
+
+	spin_lock_bh(&peer->lock);
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv4.s_addr,
+					    &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+		}
+		break;
+	case htons(ETH_P_IPV6):
+		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
+					      &ipv6_hdr(skb)->daddr))) {
+			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv6,
+					    &ipv6_hdr(skb)->daddr);
+			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
+		}
+		break;
+	default:
+		break;
+	}
+	spin_unlock_bh(&peer->lock);
+
+unlock:
+	rcu_read_unlock();
+}
+
 /**
  * ovpn_peer_get_by_dst - Lookup peer to send skb to
  * @ovpn: the private data representing the current VPN session
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index c8e9218b1f1a096c3307ab6c687dd6836adf9741..6e60a0d1023b3289be4fb618e3bac24bad7b32b6 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -153,4 +153,7 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.3


