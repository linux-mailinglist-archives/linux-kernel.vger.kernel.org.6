Return-Path: <linux-kernel+bounces-235377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433D491D485
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25E5280F8F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79CF158DD8;
	Sun, 30 Jun 2024 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZxAw1Ga3"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A853D7BAF7
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786698; cv=none; b=BSnWFbDgKndueJgqYJswVMig5Ujw9vFjyO6npx3RdAwQysPIWLNOeyaLh83d8lPUawz/fKYRsDDmiwMEFALjUcgR4aQjdu3R7dtdfr3sfm0CeSxauH9xputk9DiupPgsdgp/mZSTaCTmTYvw6F4G7UvN35qGJbskn3G+0T0meG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786698; c=relaxed/simple;
	bh=mw7l5f4R++WEdPuCdKV5WyWPRJl/Q6YSFF6cOqPMzT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6f7d11R5di+YQunJwwwQ6woJIqZIdB8eRDy9IFS0an8a2tF5i3I/Ajw9epi89raW1/H5LXI/gyC+MiR2rWOJyv3U/pfzsxj+oqU2bXajrtPH+T6UiuNq2ZWHXT7nfNkqSKXd+vzhe5yu9ffw60RSuELvvAa8vDgAIPzRAvxx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZxAw1Ga3; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3n42cXpzll9fM;
	Sun, 30 Jun 2024 22:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786691; x=1722378692; bh=YWSij
	EBZQ118jMcwKRXHb4cBm8QyefsNotC/8fgFnxA=; b=ZxAw1Ga3Z6vXeJslBwZxE
	yv+DsahOxDteo4vUW8v4q7/RlECqHhHVfuZ03YjPjVpmQGZEpJzLmGnElfL+GeOf
	JJiSgMnunpEvDj0xxfSv30tPcIm4w6jGp3qJOBF7RskJIG72B0/r0E1BkrbIjddd
	IJ72LGKyp6ZVMfiwISmI7Zarzy1x3paMWQzYL1GOsutUU6KwM6gVio4ITqB2ce3a
	UInjjp/+JJpmODj7csqrzkD7RI/23ZD9k+eN22Y0RjyEHkCC/AoTk9PjF/moI61N
	7eOUd8KYqtSchWMlsVjDjuVaM2r1KIvcJwIG/nityuyCoTpBw0tb9TZZEbB9ge2r
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HQN6LzH9jJFF; Sun, 30 Jun 2024 22:31:31 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3mw27y9zll9f8;
	Sun, 30 Jun 2024 22:31:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 28/53] net: mscc: ocelot: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:26:46 -0700
Message-ID: <20240630222904.627462-29-bvanassche@acm.org>
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
 drivers/net/ethernet/mscc/ocelot_stats.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_stats.c b/drivers/net/ether=
net/mscc/ocelot_stats.c
index c018783757fb..55bb6fac6e36 100644
--- a/drivers/net/ethernet/mscc/ocelot_stats.c
+++ b/drivers/net/ethernet/mscc/ocelot_stats.c
@@ -951,7 +951,6 @@ static int ocelot_prepare_stats_regions(struct ocelot=
 *ocelot)
=20
 int ocelot_stats_init(struct ocelot *ocelot)
 {
-	char queue_name[32];
 	int ret;
=20
 	ocelot->stats =3D devm_kcalloc(ocelot->dev,
@@ -960,9 +959,8 @@ int ocelot_stats_init(struct ocelot *ocelot)
 	if (!ocelot->stats)
 		return -ENOMEM;
=20
-	snprintf(queue_name, sizeof(queue_name), "%s-stats",
-		 dev_name(ocelot->dev));
-	ocelot->stats_queue =3D create_singlethread_workqueue(queue_name);
+	ocelot->stats_queue =3D create_singlethread_workqueue2(
+		"%s-stats", dev_name(ocelot->dev));
 	if (!ocelot->stats_queue)
 		return -ENOMEM;
=20

