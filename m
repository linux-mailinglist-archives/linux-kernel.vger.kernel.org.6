Return-Path: <linux-kernel+bounces-241897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0E9280D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17DE9B23E23
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA07D5FEE5;
	Fri,  5 Jul 2024 03:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="f+0magwH"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB726AD3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148453; cv=none; b=DtmjTtY6wyV9kkpzBJzbv7S8swxlcKGpzZew5cps6eqDWi148YJshLFEFrCM413sWlbW0nSeiTSI1mS60EKXjo7Jgz5Y9GUkFqFs6Ms4PAXYpAfJLYvgFfZL7Fawvvk+DCdWSGo7zpe0dYowLevEm0tF0bIonxT+PSZsisjtmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148453; c=relaxed/simple;
	bh=JiJY+j6TyfBV9LR9ycgqUi+s3rgLJnFnQqqJZj6khuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6oBWvwC0ewcUjh2md+lMIC43KIrWfa/9NBi9YG3Bv9QJouMJq+UJugCphPSEj6De1gbg6NjVR2ckMezjtN+XtI/wyRnje2BAdFyT2jWIrkkcI+QBglaCk1Zk35FyIekkCHWyMoCqPB/1wgWE0JLmXYGb3Vd3ZHk6+H5eg1tqoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=f+0magwH; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4CCCD2C01D5;
	Fri,  5 Jul 2024 15:00:49 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1720148449;
	bh=zJySgUg5KnNtBOK7uwX7TCw7Zzzq8wJpmdXhs5nEk7I=;
	h=From:To:Cc:Subject:Date:From;
	b=f+0magwHpL2OOLtrVrykxqerhRCQYet1UYpaJElC/3DEQG4WQGgpACml20paHoggc
	 Dg4HEMN2UlB2wom/Ttt2rfs9VsmWcRYjLanEriHJ8+d+2Nm/6cKJ9iveEOoH06Z5Zf
	 PTiTy1bTqxdss9DATnbRX3LqNLXVv3FekWjjDGBd5M4KtMhMUd0MDinHex3lrgX/Cr
	 /2wxHnH0wSKLtUeSHr60xQO805UWuJbgqOtiXB0HE7tGg/7ShNRAAbeQcuo9+AnlOn
	 mfK8VSeOl9ULl5hyoKdOUf3IBGCuTRMdXqNDc+pvNyU2uZjtQPa+06bx1eL2Q9SjXn
	 2qk7Kz5J8iPPw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B668761e10000>; Fri, 05 Jul 2024 15:00:49 +1200
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id 18FC013ED5B;
	Fri,  5 Jul 2024 15:00:49 +1200 (NZST)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id 136623C0681; Fri,  5 Jul 2024 15:00:49 +1200 (NZST)
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
Subject: [PATCH net] net: bridge: mst: Check vlan state for egress decision
Date: Fri,  5 Jul 2024 15:00:40 +1200
Message-ID: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=668761e1 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=4kmOji7k6h8A:10 a=JXkHKJOXY2Ndxws4tuMA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

If a port is blocking in the common instance but forwarding in an MST
instance, traffic egressing the bridge will be dropped because the
state of the common instance is overriding that of the MST instance.

Fix this by temporarily forcing the port state to forwarding when in
MST mode to allow checking the vlan state via br_allowed_egress().
This is similar to what happens in br_handle_frame_finish() when
checking ingress traffic, which was introduced in the change below.

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode=
")
Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
---
 net/bridge/br_forward.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index d97064d460dc..911b37a38a32 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -22,10 +22,16 @@ static inline int should_deliver(const struct net_bri=
dge_port *p,
 				 const struct sk_buff *skb)
 {
 	struct net_bridge_vlan_group *vg;
+	u8 state;
+
+	if (br_mst_is_enabled(p->br))
+		state =3D BR_STATE_FORWARDING;
+	else
+		state =3D p->state;
=20
 	vg =3D nbp_vlan_group_rcu(p);
 	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev !=3D p->dev) &&
-		p->state =3D=3D BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
+		state =3D=3D BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
 		nbp_switchdev_allowed_egress(p, skb) &&
 		!br_skb_isolated(p, skb);
 }

