Return-Path: <linux-kernel+bounces-235376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB4E91D484
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FDE280C8E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019C82C6C;
	Sun, 30 Jun 2024 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4JTnp7S+"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC68B77119
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786697; cv=none; b=d+kAYbPpO6KUc1Zqy1BLNFdRpd8EKHCkUoIY0vqaK7wtVBfkCxdJYbXLuuG+wDCdzOLPejuFTFuD9C0L/IXKaUfp3sAKR2vBkd393laVjJzw8MZ79EJeo0lCZu48QtYKw7uzeanVKlViJM2lgZ0phtAPgC7GTD72kvteob9eSsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786697; c=relaxed/simple;
	bh=sseUiLZK/N4q/5qO3KNtZ4/zk1cOl00Je1urN7IkxDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INJEgKjnMhH2U92G335m3TU0UNJetQV0tHukD6U1MD/DtxiyBm5L9ATj892CfENBSugW+2fvvC2WGsiosRKMv3iCzajtQw38P7OvwDa3zYScDt/eeZgLZ3taGgk6KEZQSanmBHT2IN/tCBscfHnj92uQ+RXMipRkIcHt7gcQFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4JTnp7S+; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3n33LpBzll9fK;
	Sun, 30 Jun 2024 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786687; x=1722378688; bh=4+aOU
	U1zXC88UJoE1RhEv3Xrpk0BEo8AeM2KkPBQNYQ=; b=4JTnp7S+GbvveyWkUReqx
	tgb2/CzrdHfpxqMvThy06uAI35tQQDnGTpFPYh2wW/MxZEUzs2rgAy7Ib3tciooz
	W9wUP/GLNMB+o9vQhiJefhpkOjxKg/pPioLc+1TBZKLWfYqLOV1X/JEzoX4fSqu7
	ZFtZfMfbP/qf7qA6vnvgJw/bMMrUTjXcD8TINFeMlbudMOViwTmQp2LJKotrnHBC
	bWqsku77f090sEUvRHdgVERZ45LvC9wczG2nUmCnQIeJ2wBdVbmgmaqYaQcmPln3
	x2aSOzjl/NLXOWSIJ9xYlmP/WuGUza/hZoWlE6/SZ8WjbI7t6bvHN9Ptr0zEi96I
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uyP6BCb9ZMyF; Sun, 30 Jun 2024 22:31:27 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3mp2TYLzll9fB;
	Sun, 30 Jun 2024 22:31:22 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"justinstitt@google.com" <justinstitt@google.com>,
	Wei Fang <wei.fang@nxp.com>,
	Kees Cook <kees@kernel.org>,
	Louis Peens <louis.peens@corigine.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 27/53] net: sparx5: Simplify the create*_workqueue() calls
Date: Sun, 30 Jun 2024 15:26:45 -0700
Message-ID: <20240630222904.627462-28-bvanassche@acm.org>
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
 drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c | 6 ++----
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c    | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/dri=
vers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index a06dc5a9b355..e15736831747 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -1231,7 +1231,6 @@ const struct ethtool_ops sparx5_ethtool_ops =3D {
=20
 int sparx_stats_init(struct sparx5 *sparx5)
 {
-	char queue_name[32];
 	int portno;
=20
 	sparx5->stats_layout =3D sparx5_stats_layout;
@@ -1249,9 +1248,8 @@ int sparx_stats_init(struct sparx5 *sparx5)
 		if (sparx5->ports[portno])
 			sparx5_config_port_stats(sparx5, portno);
=20
-	snprintf(queue_name, sizeof(queue_name), "%s-stats",
-		 dev_name(sparx5->dev));
-	sparx5->stats_queue =3D create_singlethread_workqueue(queue_name);
+	sparx5->stats_queue =3D create_singlethread_workqueue2(
+		"%s-stats", dev_name(sparx5->dev));
 	if (!sparx5->stats_queue)
 		return -ENOMEM;
=20
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/driver=
s/net/ethernet/microchip/sparx5/sparx5_main.c
index b64c814eac11..39c87e85fb8c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -596,7 +596,6 @@ static void sparx5_board_init(struct sparx5 *sparx5)
 static int sparx5_start(struct sparx5 *sparx5)
 {
 	u8 broadcast[ETH_ALEN] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-	char queue_name[32];
 	u32 idx;
 	int err;
=20
@@ -661,9 +660,8 @@ static int sparx5_start(struct sparx5 *sparx5)
 	/* Init mact_sw struct */
 	mutex_init(&sparx5->mact_lock);
 	INIT_LIST_HEAD(&sparx5->mact_entries);
-	snprintf(queue_name, sizeof(queue_name), "%s-mact",
-		 dev_name(sparx5->dev));
-	sparx5->mact_queue =3D create_singlethread_workqueue(queue_name);
+	sparx5->mact_queue =3D
+		create_singlethread_workqueue2("%s-mact", dev_name(sparx5->dev));
 	if (!sparx5->mact_queue)
 		return -ENOMEM;
=20

