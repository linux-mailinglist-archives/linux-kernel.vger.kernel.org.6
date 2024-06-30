Return-Path: <linux-kernel+bounces-235400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA1391D49C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E3D1C20C3F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CB9154BFE;
	Sun, 30 Jun 2024 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ypXXEvTv"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0277152E05
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786782; cv=none; b=agWma5l2PxKc4i6XlfGHILtOsK7DrsRp+ep1+vKp3fioMM6ocd7X7krpDXGkYI1mRgoUdvqMFEWjs92WmvOs+T8mqMTruN0/KygqIh8baMRQw72UxW8AtOG3G6tjqqJ0hFRWt6pTIeVqLdW3nWW/btnBrOMyC2Mmwwu8pmgP8vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786782; c=relaxed/simple;
	bh=kRpExk4x9tfl9h4cWwV0YGuS1KGOXqj2NqEFnkOTHJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1Fl3UdUvd5J4cBKKy/bxovOuylEkhWx8jaxQaQRcPfh9OTFiVYYXKXy94ttjJISSwN7O0inhofsYK3P2RlMH+rG65sMb9u4U3K/9px9fkf/Fg5ecMdi9hckbKbfjM6mSQ59SH/8Gr0hFGlLQuVjyNygMi6RqR0RYIzcT1v3OSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ypXXEvTv; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3ph3HTxzll9fS;
	Sun, 30 Jun 2024 22:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786776; x=1722378777; bh=V2NX3
	eyWGWMhNoxe/EKRPRkGq3N4wz7FavNMU1tftA0=; b=ypXXEvTv1RAb/kXTebCYX
	cM/PrTLuB5DCvqo4C5aE96IDpUWHzNYpnyBj2nBCKJndu2/dmUVwGXbL/YJBOp2S
	l1hgkVD/XpHwBxJoHH+rU0hQOsKKuWIsyKP8gsRvtvnxdcr4ux8uzW0TjVULs/UY
	ZIkzNjaao03zwGs1Co2dPA3pVpXKvHD1o34kIf7f//m0Yz6LtsIQ6H2bKXkP5qPO
	4EWOUBpUb7xpm6WuAD51FDY3caCFr/VXjrQdIv2N2Et8XdZsE1m9+6tMOjNluOou
	HVwQdaYpZCd+tVEtMb+N2Zo4DNnN+0nzMWgViih/6jbMMDSwtCELBWAOvs701Wuc
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3KvzqA691eiw; Sun, 30 Jun 2024 22:32:56 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3pX6BKfzll9fK;
	Sun, 30 Jun 2024 22:32:52 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 51/53] mac802154: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:27:09 -0700
Message-ID: <20240630222904.627462-52-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240630222904.627462-1-bvanassche@acm.org>
References: <20240630222904.627462-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pass a format string to create*_workqueue2() instead of formatting the
workqueue name before create*_workqueue() is called.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 net/mac802154/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 9ab7396668d2..9da6b21eb3b5 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -193,19 +193,18 @@ static void ieee802154_setup_wpan_phy_pib(struct wp=
an_phy *wpan_phy)
 int ieee802154_register_hw(struct ieee802154_hw *hw)
 {
 	struct ieee802154_local *local =3D hw_to_local(hw);
-	char mac_wq_name[IFNAMSIZ + 10] =3D {};
 	struct net_device *dev;
 	int rc =3D -ENOSYS;
=20
 	local->workqueue =3D
-		create_singlethread_workqueue(wpan_phy_name(local->phy));
+		create_singlethread_workqueue2("%s", wpan_phy_name(local->phy));
 	if (!local->workqueue) {
 		rc =3D -ENOMEM;
 		goto out;
 	}
=20
-	snprintf(mac_wq_name, IFNAMSIZ + 10, "%s-mac-cmds", wpan_phy_name(local=
->phy));
-	local->mac_wq =3D	create_singlethread_workqueue(mac_wq_name);
+	local->mac_wq =3D create_singlethread_workqueue2(
+		"%s-mac-cmds", wpan_phy_name(local->phy));
 	if (!local->mac_wq) {
 		rc =3D -ENOMEM;
 		goto out_wq;

