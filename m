Return-Path: <linux-kernel+bounces-235362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186C091D476
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5BB4B213D1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3222D82485;
	Sun, 30 Jun 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="o+iXddNS"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D31C823AC
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786619; cv=none; b=V9eHe5ePCCEzuzq3fN7qWEH5R+b0eHJtVrFWgXrWRy9W2iHqOLj737HeRvPqgA9URlqDTm6pPvRTklLPF/Nbrh7cyMFoUuq6HfGatgzKGyWDFb8T0kZjwJkvsGXGQb+YHeilU7Y6ClpULHOZn4YlyaDazPqJ5noag2wlGk1rAbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786619; c=relaxed/simple;
	bh=5DBwAK8ENbekM53kfYQbfEVcEytL1hq0TYNe9O6o2Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFpbTM6z9XS/LGngh02qeqQlSvqMYeG0xd4E7bVpTbTLogoYl334WI7Zj7Xz67CsbvpNqnK6rC8m21Q453i3ih7tvVZYM1nsViS6ym7G52juvnp9EliPmmNI91M4g66EHLGd9+bGwnu0JVXIzfsUdOiNxxnra3Wyi9jC57oH5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=o+iXddNS; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3lY6xb9zll9fK;
	Sun, 30 Jun 2024 22:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786615; x=1722378616; bh=kOq4p
	ZRwmkRhXmZ+e9RZBKnbCV5MWVOSqeuQ/7HdtmM=; b=o+iXddNS9X8RHixLQSmZU
	/XdNvLw6ug5AXvjemgOnJfIbg5uBas4jEa510b1awTbOXHJmxMusbnUsUjQCr++V
	nJhA8nn7uBPDp+9jA7N40c7VVkEKinTH8lKa+/I6awa0WAi6lBMj82uWfiA4Jce7
	ucayGPCUj6cQGvu0UJEwCihxtCHdkTPjdf3JlMSfnFrXcNSvQN+0NljZbvaIf4mg
	zdKzkMW1E9K0WbvodjyN9OQHFDrFS19C7f9IWAKvHbcsJW+UQNsjYZXnODMV8+01
	iXXhaA9etMSyG3zbpIhExrU8C1JWu7zcezaWgs9MABqeuSJ/wUpSYWpB+MNk/z10
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4xuC5sUfFj_7; Sun, 30 Jun 2024 22:30:15 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3lS4Bprzll9f8;
	Sun, 30 Jun 2024 22:30:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	RD Babiera <rdbabiera@google.com>
Subject: [PATCH 13/53] usb: typec: tcpm: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:31 -0700
Message-ID: <20240630222904.627462-14-bvanassche@acm.org>
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

Prepare for removal of the create*_workqueue() macros.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/usb/typec/tcpm/fusb302.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fu=
sb302.c
index ef18a448b740..894e5f6bba60 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1715,7 +1715,7 @@ static int fusb302_probe(struct i2c_client *client)
 	if (IS_ERR(chip->vbus))
 		return PTR_ERR(chip->vbus);
=20
-	chip->wq =3D create_singlethread_workqueue(dev_name(chip->dev));
+	chip->wq =3D create_singlethread_workqueue2("%s", dev_name(chip->dev));
 	if (!chip->wq)
 		return -ENOMEM;
=20

