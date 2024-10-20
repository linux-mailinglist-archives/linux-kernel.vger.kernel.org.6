Return-Path: <linux-kernel+bounces-373317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014B59A5535
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 18:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6083280847
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419D194088;
	Sun, 20 Oct 2024 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgemail.de header.i=@georgemail.de header.b="mrKaRIQg"
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFECC193409
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729441718; cv=none; b=om/aMD4YVnk5gGK8UgkhXzqU06N+phGARXPa44zDdMcO3rQukWzoKCTfYHJ3W8Suv6FxSxRVxsG8hFx2sqq9wCNQEd9MQkXbeHBpfOQNQ1imSI/hbJs6ceHHjqumIlq1A6fPR7zkW246FkkS2fjC4GTao8ACxqF3J7df6tZSBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729441718; c=relaxed/simple;
	bh=TBw5M6zt7QkRdaLixRKiko3mg/lCEVzINvmOf4XO7Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/03BPItxrtiWknwcqMjynystIIXM8vlY8oPzzA49DxYTnQuZwBYN5/bm2LzjA3X/fgUjABedVs7pQlSyZRDz9hXSLl3IBx9Cwn20PFePF+RVWPr1TiJqZiqY3pru71EPH4uNOMKjM79kRUrD2ZNODXrU6ZcSp6FSTs434Spx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=georgemail.de; spf=pass smtp.mailfrom=georgemail.de; dkim=pass (2048-bit key) header.d=georgemail.de header.i=@georgemail.de header.b=mrKaRIQg; arc=none smtp.client-ip=85.220.129.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=georgemail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=georgemail.de
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp5.goneo.de (Postfix) with ESMTPS id 3C47C240AF1;
	Sun, 20 Oct 2024 18:21:40 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 943282405E6;
	Sun, 20 Oct 2024 18:21:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgemail.de;
	s=DKIM001; t=1729441298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y55Sd+gBc2nDe3N03RuDk/A+AitDoePeBs7B6HuBeTc=;
	b=mrKaRIQgMHvQ6WcIFI6JKzdwpUFgUqPMpen+7Ra8f97Niidrbw2xnnF3ad1X1BIQcODwvG
	WjbP6iyCiNyaN9beKu3lC0D27+a6LxEVKT28JUNlVHmdn0DbwgzuOaRB0s6jTPiwPc4YzN
	2zMn5Agmza+BpPrKprvwl2neeQ56knM2EAm3NiCF5RPfAkDYrrSl01vQdsqQMA+4bXuUm6
	hhtbYg1QjDV1HGyVjLABYxcsABWzgH8le2DAYUKZlpeJrlADKY/RxVDU2DMJpGLRYu4iV1
	V8hp5DHVN/Q0Tawtn2IGUMK6xDMzwsaoc14A2J9r8bWXeDtKx/tjsCp9r2udJg==
Received: from couch-potassium.fritz.box (unknown [IPv6:2a02:8071:5250:1240:10b2:cb65:f97e:1905])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 801FC240370;
	Sun, 20 Oct 2024 18:21:37 +0200 (CEST)
From: "Leon M. Busch-George" <leon@georgemail.de>
To: "Nikolay Aleksandrov" <razor@blackwall.org>,
	linux-kernel@vger.kernel.org
Cc: bridge@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH] net: bridge: switchdev: Don't drop packets between ports with no hwdom
Date: Sun, 20 Oct 2024 18:20:14 +0200
Message-ID: <20241020162105.3217305-1-leon@georgemail.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: ef759b
X-Rspamd-UID: cd12de

From: "Leon M. Busch-George" <leon@georgemail.eu>

nbp_switchdev_allowed_egress uses hwdom to determine whether or not a
packet has already been forwarded to a hardware domain. For
net_bridge_ports that aren't set up to use forward offloading, hwdom is
set to 0. When both ingress and egress port have no hwdom,
'cb->src_hwdom != p->hwdom' indicates that the packet is already known in
the target domain - which it isn't - and the packet is wrongly dropped.

The error was found on a bridge containing a wifi device and a VLAN
tagging device (e.g. eth0.12). With VLAN filtering, this shouldn't happen.

This patch adds a check for p->hwdom != 0 before comparing hardware
domains to restore forwarding between ports with hwdom = 0.

fwd_hwdoms are only set for ports with offloading enabled, which also
implies a valid hwdom, so the check '!test_bit(p->hwdom, &cb->fwd_hwdoms)'
doesn't fail in this way (yet - fingers crossed..) and it is left in place.

Co-developed-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Leon M. Busch-George <leon@georgemail.eu>
---
 net/bridge/br_switchdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 7b41ee8740cb..29ff9af99276 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -67,7 +67,7 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 	struct br_input_skb_cb *cb = BR_INPUT_SKB_CB(skb);
 
 	return !test_bit(p->hwdom, &cb->fwd_hwdoms) &&
-		(!skb->offload_fwd_mark || cb->src_hwdom != p->hwdom);
+		(!skb->offload_fwd_mark || !p->hwdom || cb->src_hwdom != p->hwdom);
 }
 
 /* Flags that can be offloaded to hardware */
-- 
2.47.0


