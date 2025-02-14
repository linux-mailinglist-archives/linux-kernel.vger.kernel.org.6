Return-Path: <linux-kernel+bounces-515753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6A8A36893
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1571B1895B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DBD213227;
	Fri, 14 Feb 2025 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxcAraYI"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87520E6EE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572723; cv=none; b=V+yROP2s1IbebTB+1qFcjKlD9R5qre2MB7oGpFWf9K1Pp/E6H/qsxby7vdlUWrf8JZ0wdZAbvV3K2LmDMeNcBufTiPfz+ywOH1Xixo8BcrqDXqI1ZhdcWH7oxfOZyZecYlCQ/g98IlUvBlmbg8HzLz2soDoGll5CRQshc396Ao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572723; c=relaxed/simple;
	bh=C9A3LWRVVEvM4OBlqT9wYA0yWCdJj2Hpz7Z1pzmG8wU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LRvDKpxmKUN1/NXRqTVsT4SCm8/3hTRtF02RPnECmaD3Pp1bGv+iX4xVStAmP2IvDWKhpojjnPsJho3RNJQs8LrOWoLGROrL9oh/giS4dqPa6zP+IPm8kMDqFavvQqV64IJAjo3TqcN55inApIX3HPdEfpmK9boywML70HsPv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxcAraYI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22101839788so9659105ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739572720; x=1740177520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tUNETmfCcN16mATl/cudDdX8wxXBFFNsGuPJIeAzz7o=;
        b=sxcAraYIu8e44pbbpWvNWlVzGDnWXj9fvzGXJoI3ud6pQhIXCm3l1OyrxGN97VUurH
         j69o/zPBGz3+GMwqj26NfTzpsVEsCQj3/9gvxgptvmXPmbewn0l6AEoOwqyacqddFdRG
         KPT4uL+TfceQGU3IIRu2eWBlGcyMJkLz06GWFP8up+JJOBw18bcFs/D1Cs+WmyyzkrAl
         fusNzDskDpaR13JYdQDSCit5r/ltMjyhJdTsJxanznqxe9JbsZlM7H1nKOJB8QcZzo1j
         jEhvfjV4ytx485xPX6MnJVmLf3bjTGsuiKV4BN9V30ZvPMDLuhXIJG0tcglJJk5Q06AL
         4lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572720; x=1740177520;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUNETmfCcN16mATl/cudDdX8wxXBFFNsGuPJIeAzz7o=;
        b=rikuj5jmGpphl5KtBjMR2LBi+pzfQSwAVyA4iZ5qNKQUC23poND0GmVc2U76fCzVux
         LwFAZ9nrsrBTddtDtcYl38n4fUOcvFAVUw4iylL51goh9ju/yF+XMYXBJcViTrPVNWOr
         mcXGh6ciduowPXqDst7ZyBuNvKNFPY6UKhE5/BovABMV/lZLEPyn3h9iVU1AeiB9Y0I+
         58HGbWnXxrfzNA8xDiJ6vdVhED4yEIbFkKbvOjfgdhdimyz2AXLClvepLnJsqvSJ+v/V
         rQOaiPjcP2HpKxYvvuIi9WcBkcHca8ACJrTl8Tu+OJavNOgO1uQc749CiVJs5ZlIP9r1
         ujWw==
X-Forwarded-Encrypted: i=1; AJvYcCUGqPeWZlZmOqwogLZAjlzUXJUX6nevFE3ds7iV5Wa8Ozk52UtlOTlDxag4mmZGntTsAZGK6yT2nay+fvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfIpm3ZIN6yd8XzN3OxkFMWZQNRuI3MDdqwt1FRyzXjTu5C6Xt
	9+nQd0St+3PuUP7i+Qd8Nb0oRYTZEMLSUkXlLuIzvxmclEN2TkMKOvfWJ2ytgdveAvF+e0b6j/M
	2J570xQHF6w==
X-Google-Smtp-Source: AGHT+IGx5EUUJ6Z4zMDYclDQP+PzCMwRDfETHpFgm91+oQRalpeSgNTUDtjKw58EJXrDOCaT//TmCaudpiMQ9Q==
X-Received: from pfbdn12.prod.google.com ([2002:a05:6a00:498c:b0:730:92d9:52e3])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1583:b0:1ee:8a27:364c with SMTP id adf61e73a8af0-1ee8cbe7e09mr2160416637.34.1739572719877;
 Fri, 14 Feb 2025 14:38:39 -0800 (PST)
Date: Fri, 14 Feb 2025 14:38:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214223829.1195855-1-joshwash@google.com>
Subject: [PATCH] gve: set xdp redirect target only when it is available
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, stable@kernel.org, 
	Joshua Washington <joshwash@google.com>, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Shailend Chand <shailend@google.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

Before this patch the NETDEV_XDP_ACT_NDO_XMIT XDP feature flag is set by
default as part of driver initialization, and is never cleared. However,
this flag differs from others in that it is used as an indicator for
whether the driver is ready to perform the ndo_xdp_xmit operation as
part of an XDP_REDIRECT. Kernel helpers
xdp_features_(set|clear)_redirect_target exist to convey this meaning.

This patch ensures that the netdev is only reported as a redirect target
when XDP queues exist to forward traffic.

Fixes: 39a7f4aa3e4a ("gve: Add XDP REDIRECT support for GQI-QPL format")
Cc: stable@vger.kernel.org
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Jeroen de Borst <jeroendb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve.h      | 10 ++++++++++
 drivers/net/ethernet/google/gve/gve_main.c |  6 +++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 8167cc5fb0df..78d2a19593d1 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1116,6 +1116,16 @@ static inline u32 gve_xdp_tx_start_queue_id(struct gve_priv *priv)
 	return gve_xdp_tx_queue_id(priv, 0);
 }
 
+static inline bool gve_supports_xdp_xmit(struct gve_priv *priv)
+{
+	switch (priv->queue_format) {
+	case GVE_GQI_QPL_FORMAT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /* gqi napi handler defined in gve_main.c */
 int gve_napi_poll(struct napi_struct *napi, int budget);
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 533e659b15b3..92237fb0b60c 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1903,6 +1903,8 @@ static void gve_turndown(struct gve_priv *priv)
 	/* Stop tx queues */
 	netif_tx_disable(priv->dev);
 
+	xdp_features_clear_redirect_target(priv->dev);
+
 	gve_clear_napi_enabled(priv);
 	gve_clear_report_stats(priv);
 
@@ -1972,6 +1974,9 @@ static void gve_turnup(struct gve_priv *priv)
 		napi_schedule(&block->napi);
 	}
 
+	if (priv->num_xdp_queues && gve_supports_xdp_xmit(priv))
+		xdp_features_set_redirect_target(priv->dev, false);
+
 	gve_set_napi_enabled(priv);
 }
 
@@ -2246,7 +2251,6 @@ static void gve_set_netdev_xdp_features(struct gve_priv *priv)
 	if (priv->queue_format == GVE_GQI_QPL_FORMAT) {
 		xdp_features = NETDEV_XDP_ACT_BASIC;
 		xdp_features |= NETDEV_XDP_ACT_REDIRECT;
-		xdp_features |= NETDEV_XDP_ACT_NDO_XMIT;
 		xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
 	} else {
 		xdp_features = 0;
-- 
2.48.1.601.g30ceb7b040-goog


