Return-Path: <linux-kernel+bounces-235353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B363191D46D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0BDB2101C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC182C63;
	Sun, 30 Jun 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NK4fETID"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D56F31C
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786586; cv=none; b=Os2KtpngANwpN2syF6eMhhaEU+4rqwVVoRui02JAvifwXzhU7O7ZmQawNQ1uz/xJH59lKhbK1EFf61N19dWYadqwIM8BGS+TcjmmihKJWw8MuGlfNdjDiulHeMCOMxgXvYprGw6PF8p2tjHlbwzT9Yj+zT6cFJJhgKSCNodfJJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786586; c=relaxed/simple;
	bh=s9ZW5IoiwjV792ksbbS77mqpVwzeO6i1N6cAwyQNsUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddnUD4q8lNM7XJMGA8GAfnkC2hwwLry96iiXsR6S6sJLqVb628Dl8FiPC8XmobJPxg1tAN5ab8E5NDP0HYm60EdxJb1iXVVJCA6L4Yds1fzWalY/9l99IHXXOdmziami0NjQhghKRXhALpZSt0P8s4GsEOJa8VtRndjtF1HRGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NK4fETID; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3kw1fW9zll9f8;
	Sun, 30 Jun 2024 22:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786582; x=1722378583; bh=Pq13P
	A9rPPjwKyHkV0PQfbbv9azfBtA+liw7/3TKGY8=; b=NK4fETIDm133l8LjqQ/ms
	fN+qtCRF56muo2JSpqFwXJyJrpYfPkJtmkd5mQ8xSfwZ08ydPIord/321g55Yx3U
	05NNq9C4YInX/UCw/zv6Kcwu6PARBavXghtmZiMr85AJbkV6JvemAMCmwLPZxol0
	RIwORPvMmU7ao5gDSCRJuiV0WFlbpXstGn2P1YIdhLUEA/Rz0rDJ7XDPxbhTSTbc
	4kE4cY4z+4AaXK2X5DKwCS2ZM6X8DNurXeHe6DSD5tTklPcMJOynBcznU5DoKAOJ
	8a3uhZLZXUNs5nUej+GYAfU8xB9vRW9RctsJD1mhCNzrQ+dqVjyGgxQ93/R5euc5
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dfIuY4182nPU; Sun, 30 Jun 2024 22:29:42 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3kq70zqzll9fG;
	Sun, 30 Jun 2024 22:29:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 04/53] media: i2c: adv7511: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:22 -0700
Message-ID: <20240630222904.627462-5-bvanassche@acm.org>
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
 drivers/media/i2c/adv7511-v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv7511-v4l2.c b/drivers/media/i2c/adv7511=
-v4l2.c
index 79946e9c7401..88e065a65ac1 100644
--- a/drivers/media/i2c/adv7511-v4l2.c
+++ b/drivers/media/i2c/adv7511-v4l2.c
@@ -1885,7 +1885,7 @@ static int adv7511_probe(struct i2c_client *client)
 		goto err_unreg_cec;
 	}
=20
-	state->work_queue =3D create_singlethread_workqueue(sd->name);
+	state->work_queue =3D create_singlethread_workqueue2("%s", sd->name);
 	if (state->work_queue =3D=3D NULL) {
 		v4l2_err(sd, "could not create workqueue\n");
 		err =3D -ENOMEM;

