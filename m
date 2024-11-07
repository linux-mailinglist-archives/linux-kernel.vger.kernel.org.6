Return-Path: <linux-kernel+bounces-399803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DA59C0468
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CE2B219D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD0020EA45;
	Thu,  7 Nov 2024 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sm+lLW27"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125020B1FF;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979841; cv=none; b=YIF9Njxokoygq6BnaRSM5GQOKcWCfAJ1eDQjbtX4BVfornJTWIYoSnc7Y47bTXbPMBfPHiwCEHAx99AlQo32Pl3nC9r5AdloLnqvaAgL4qoAc2EXjJ2M+/Lbemvk+CsZY/uIQXH25obBBi0KMbulFc3eQvzwdN4fbS0o6DnMzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979841; c=relaxed/simple;
	bh=Q39jad0NPIB4FgTucf91Ia0Dj5I8+AxqvxAlHLEovsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTIymVBO1B186xX0nufbUqr4WjyYkGM/8gTK5w6G5Ev8S6xmb94e0QxHLCmfD7/jHQ4LSG+yZqmxhrH13qd3nXttnFU/S9hRm8HPao9qtOYhoy+GCFkO66DL9ZoVFx+nB9a0/qV/eBuaZ9wmjE+5Dljf62Ith/FqgyYEpfEjDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sm+lLW27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0983C4CED3;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730979840;
	bh=Q39jad0NPIB4FgTucf91Ia0Dj5I8+AxqvxAlHLEovsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Sm+lLW27swp5RVFWGOXVBoDLUALaQQ+vjIYc+sFrF3CxesL36BjCG63rpAKJ1m5ch
	 ug7Af933K44uMGlkqmiY8Wcf/ltBhTsbEYBZ55p9il5K4fFyY2RdPIfBGsDl8pIt8w
	 jFEujP0/8jLocKHGE8t6czgZAoZiaNHQbOBFPL2QFUog0mwFWMyJCkNNbfyrgBWMTc
	 wMWQhHnVHiGFf1cvoqhjzgUCZab54m+X8BqR4ZSTvXt3LeJSMQrsltH4RD1dm6Hp0q
	 /iI2hd32n8jbidRxI9h0s1gcI09FTyfZQguxXrBtzN+ev1h1d6Xjapjj4QXNj95LZs
	 FFKeLk2g1XFHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92852D43352;
	Thu,  7 Nov 2024 11:44:00 +0000 (UTC)
From: Oliver Facklam via B4 Relay <devnull+oliver.facklam.zuehlke.com@kernel.org>
Date: Thu, 07 Nov 2024 12:43:28 +0100
Subject: [PATCH 2/4] usb: typec: hd3ss3220: use typec_get_fw_cap() to fill
 typec_cap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-usb-typec-controller-enhancements-v1-2-3886c1acced2@zuehlke.com>
References: <20241107-usb-typec-controller-enhancements-v1-0-3886c1acced2@zuehlke.com>
In-Reply-To: <20241107-usb-typec-controller-enhancements-v1-0-3886c1acced2@zuehlke.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oliver Facklam <oliver.facklam@zuehlke.com>, 
 Benedict von Heyl <benedict.vonheyl@zuehlke.com>, 
 Mathis Foerst <mathis.foerst@zuehlke.com>, 
 Michael Glettig <michael.glettig@zuehlke.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730979838; l=1169;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=V/ZRmfdf8rYgiBJZgxIzqV0Qzt6dP65mnitUcwhfB4w=;
 b=CAlkuKbhXj0tvqdtVk2f1Ln9aB48sV4so98MjJKKfxfKG8Za5hyKKq/0s/E/2ZApPZo2Jhb2q
 oz3Iqv2qZo/AQ5EkCw4BGfjybZpQYk7qt0d3DLA2eea4TtbDU63qn+b
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=
X-Endpoint-Received: by B4 Relay for oliver.facklam@zuehlke.com/20241107
 with auth_id=271
X-Original-From: Oliver Facklam <oliver.facklam@zuehlke.com>
Reply-To: oliver.facklam@zuehlke.com

From: Oliver Facklam <oliver.facklam@zuehlke.com>

The type, data, and prefer_role properties were previously hard-coded
when creating the struct typec_capability.

Use typec_get_fw_cap() to populate these fields based on the
respective fwnode properties.

Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
---
 drivers/usb/typec/hd3ss3220.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index 56f74bf70895ca701083bde44a5bbe0b691551e1..e6e4b1871b5d805f8c367131509f4e6ec0d2b5f0 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -259,12 +259,12 @@ static int hd3ss3220_probe(struct i2c_client *client)
 		goto err_put_fwnode;
 	}
 
-	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+	ret = typec_get_fw_cap(&typec_cap, connector);
+	if (ret)
+		goto err_put_role;
+
 	typec_cap.driver_data = hd3ss3220;
-	typec_cap.type = TYPEC_PORT_DRP;
-	typec_cap.data = TYPEC_PORT_DRD;
 	typec_cap.ops = &hd3ss3220_ops;
-	typec_cap.fwnode = connector;
 
 	hd3ss3220->port = typec_register_port(&client->dev, &typec_cap);
 	if (IS_ERR(hd3ss3220->port)) {

-- 
2.34.1



