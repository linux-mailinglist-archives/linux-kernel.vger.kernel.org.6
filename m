Return-Path: <linux-kernel+bounces-248581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6869D92DF43
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F21E1F2333A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8D94F1F8;
	Thu, 11 Jul 2024 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="VJfX1Awu"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0B320312
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720674012; cv=none; b=EPxLhvPrwv7+Dj64r9wNMvbFXWjfG/bBELnbJr7wE4JdFl6mwKxUmLi1+VpZNVk3Es6KQ1ADR2+01SLUY9M64dv8Cp3g3+aVRhWfUkUMwSGInvT4NzTu2u2qQGucwZ0lbBuQMOSkoB43WrYe1J6xTIjBt0fyPOX5RHFrXiQQhFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720674012; c=relaxed/simple;
	bh=0j1hQ2vmfDpFBABfK0ocm0liUHRX0hPyVO6arXnqsV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RInvFDzFZJR163Zpp/Ac5sm9UXwHaxdTyAem6y99zUYcL/D+XTS385AB3ZO+cO3X43YzI9diniUly/ZflLAHTdAlnjNQ2u34kBe/Qad1E1LCby7DpgLnRgXxm9SOCZtdYtUYAkJ5abwl5cRk0P5giMo/cYWzjaERA5murFnYm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=VJfX1Awu; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D8CA02C0372;
	Thu, 11 Jul 2024 17:00:00 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1720674000;
	bh=pZveZXlJyMwauPW4aLQrWYnyZv6abHginb4De52CZ/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=VJfX1Awuompbdv/eOapKYF8x9Z359AycC8DLthgA6GBqAYkij2gVRpUHTiX+3ACeD
	 XTM26Aq8xrcAf4Sr4++zVtdSTxCQYVUYFzx1XiHV311UmDGKn4GLYky5G5Xe9oKVkJ
	 mS/cTIsX8Vn1pTX1p74QUTXvkY6AMpchN1rwqCpxz5gBCnSNYyAjngIYAJwoMPSIll
	 Gf51rjnEnTmopV3v8t7JDxkqm1keE2FkmHoM+CC7lGLe3WXjE/rM5/rzCu+ADd8XWU
	 DCiyjZMDe3EI0WeiiAJHcNCDGFi8zTucMMl9VPxvTKjUyJGtEt2L6VMU3OSTbQ26Oj
	 O9r67znmHxFYg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B668f66d00001>; Thu, 11 Jul 2024 17:00:00 +1200
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id A2B0C13ED5A;
	Thu, 11 Jul 2024 17:00:00 +1200 (NZST)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id 9CB8A3C0681; Thu, 11 Jul 2024 17:00:00 +1200 (NZST)
From: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
To: davem@davemloft.net
Cc: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: bridge: mst: Check vlan state for egress decision
Date: Thu, 11 Jul 2024 16:59:25 +1200
Message-ID: <20240711045926.756958-1-elliot.ayrey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=PIKs+uqC c=1 sm=1 tr=0 ts=668f66d0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=kEPFZq6BU9ta2gAs10EA:9 a=3ZKOabzyN94A:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

If a port is blocking in the common instance but forwarding in an MST
instance, traffic egressing the bridge will be dropped because the
state of the common instance is overriding that of the MST instance.

Fix this by skipping the port state check in MST mode to allow
checking the vlan state via br_allowed_egress(). This is similar to
what happens in br_handle_frame_finish() when checking ingress
traffic, which was introduced in the change below.

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode=
")
Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
---

v2:
  - Restructure the MST mode check to make it read better
v1: https://lore.kernel.org/all/20240705030041.1248472-1-elliot.ayrey@all=
iedtelesis.co.nz/

 net/bridge/br_forward.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index d97064d460dc..e63d6f6308f8 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -25,8 +25,8 @@ static inline int should_deliver(const struct net_bridg=
e_port *p,
=20
 	vg =3D nbp_vlan_group_rcu(p);
 	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev !=3D p->dev) &&
-		p->state =3D=3D BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
-		nbp_switchdev_allowed_egress(p, skb) &&
+		(br_mst_is_enabled(p->br) || state =3D=3D BR_STATE_FORWARDING) &&
+		br_allowed_egress(vg, skb) && nbp_switchdev_allowed_egress(p, skb) &&
 		!br_skb_isolated(p, skb);
 }
=20
--=20
2.45.2


