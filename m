Return-Path: <linux-kernel+bounces-269802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2B6943701
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2BA2B220BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9EE16C865;
	Wed, 31 Jul 2024 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8F3QVi2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712921607B9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456972; cv=none; b=so6MgSfFDwgAyKxko1BB7pY8t9eFo3dkUI5ZxyI0mPJ1SD1y/fC/LeQmYYlv9OP8uuysfi6k/imUV7LXXqVw1bCaIi5zVw2MVU2lomiAlg+mkG7+yGIb+XJID4DyEkfln5ZvRrljSDXjo+DB2dqKbanx3xGNucWPOicu6z6ywYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456972; c=relaxed/simple;
	bh=SjrMsNC52JDqtIOjtEo7o0X17BNCRDDWDiRUJgX1U1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nGEbzPgS2/hnYA7BJBK7AKzxTFZqmpdzk4noIw5dBgTG3vO0x7xbAbwv8mqT+nqvYwrMIMBHmhOVq0y5V4bdH+Y5AneEIutc1xImkl2F2srfb1W7/48T4g6MQmtv6awsJoCIqL8XEahKWg5Xz1iKHioeXJQ3C7s3b375URz40fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8F3QVi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA63FC116B1;
	Wed, 31 Jul 2024 20:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722456972;
	bh=SjrMsNC52JDqtIOjtEo7o0X17BNCRDDWDiRUJgX1U1Y=;
	h=From:To:Cc:Subject:Date:From;
	b=M8F3QVi2GEx8xd0Z5m4sbf0mxz/jxzLbLHScHpdGIWCjr3G3AbrYedmsX0GYVoOdJ
	 6dd/HAmBhneoT2QmwQCPY+N5XltRbvHoyLhBoMEzez1FXqto2oUCOxjEwm/wQjimYa
	 x9StmLcGp8ptk7R6VFyjUffMzTzWn5IAU6TN7A8XlT2OL90gTUZdn1t9S2z9KrNuYM
	 ixCdvQ6Eon5U4/gU021Xqx5eE5ljN+7B8+D5KUwbwNr5vIP/o1m5XTArsK6eNoFNk6
	 qxi1nmYuZEZbXp/BQZUB8Q1lRjhNkEPpYPnx6tccULcCAg1QIxSQt6EB/zWBZJT74U
	 EyjZGo7eGRudA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: Use of_property_match_string() instead of open-coding
Date: Wed, 31 Jul 2024 14:16:08 -0600
Message-ID: <20240731201608.1840977-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_match_string() instead of open-coding the search. With
this, of_get_property() can be removed as there is no need to check for
"mbox-names" presence first.

This is part of a larger effort to remove callers of of_get_property()
and similar functions. of_get_property() leaks the DT property data
pointer which is a problem for dynamically allocated nodes which may
be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/mailbox/mailbox.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index ebff3baf3045..d3d26a2c9895 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -450,30 +450,20 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 					      const char *name)
 {
 	struct device_node *np = cl->dev->of_node;
-	struct property *prop;
-	const char *mbox_name;
-	int index = 0;
+	int index;
 
 	if (!np) {
 		dev_err(cl->dev, "%s() currently only supports DT\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (!of_get_property(np, "mbox-names", NULL)) {
-		dev_err(cl->dev,
-			"%s() requires an \"mbox-names\" property\n", __func__);
+	index = of_property_match_string(np, "mbox-names", name);
+	if (index < 0) {
+		dev_err(cl->dev, "%s() could not locate channel named \"%s\"\n",
+			__func__, name);
 		return ERR_PTR(-EINVAL);
 	}
-
-	of_property_for_each_string(np, "mbox-names", prop, mbox_name) {
-		if (!strncmp(name, mbox_name, strlen(name)))
-			return mbox_request_channel(cl, index);
-		index++;
-	}
-
-	dev_err(cl->dev, "%s() could not locate channel named \"%s\"\n",
-		__func__, name);
-	return ERR_PTR(-EINVAL);
+	return mbox_request_channel(cl, index);
 }
 EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
 
-- 
2.43.0


