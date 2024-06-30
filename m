Return-Path: <linux-kernel+bounces-235356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA0891D470
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3554D1F21486
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0056D7A702;
	Sun, 30 Jun 2024 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WR6KB0D6"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A1584A5B
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786596; cv=none; b=dPEZNkVermPVymdywtSoeH3NyfxhvY3Zln7o3xTx7si6F8vg7c26U8o3kdIn+mDKoEn6vPhviEBj51vQI/dAQPYuXmhf62L7sAnmkNhm5CcWd6gmtRDbHbG+WuMdCyyGxlc5bMEsQM+3H5hkT5q5fScL4c/gJPmlNLvDZ9rU1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786596; c=relaxed/simple;
	bh=bvnAAZt2+wqMGZ/U2sdbo4EzEV1L8nvRQKKn7HYdWIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IM8a+qwF5m6ZZAzTYNr+WJkqYZZ9AOU3ctONJQ3/u/okDkyCb8U8Csx2FRko32WMcaJ6rH2BR1/0mAK0Don4dFmhbrsDVwZp7Sv72A0x+BTEVOSdfge1k/s3iXBHsN6CWie5uQPleujcz5rOyM6wUM8V5glZ6AuL0yOw6FS9qsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WR6KB0D6; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3l63n4Vzll9fG;
	Sun, 30 Jun 2024 22:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786592; x=1722378593; bh=TfM2Q
	ISTaBZoe8uISpjU6SHar0Us4f1UDqehm6nwva4=; b=WR6KB0D6QQFukWuaLPYt8
	yTYVe7seq/GE9fFBwVyZ9LhzHIp8XUZsyogUrlRqJ2S+wGQnHCqt07pb5vylzUh3
	eYOo3pDWLILW/YVAO2DuyICF/PcOOcDUTPgs1YKeluP3NPCrvV/tbPpkrg2Zbwf+
	s/7FdLKJ4CRsXso7M+B0cv0yYY7EPVvw9AUfKlKPpsqZqisncmGN1hhJ3iuzW2Cy
	1RoGaDTKqSHxh3GLCtsaoiAAMQrzNFsbNcNxAtiEgGeB4TKgBhSWu8kv1I9B0hEK
	osVCd/0N7aQeqt51YAUqBPaBaXjYhVioEgGX4ijOEiK45gwHyyknpyltiTOUT/V2
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9bOcIuPOfwpI; Sun, 30 Jun 2024 22:29:52 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3l16MY2zll9f8;
	Sun, 30 Jun 2024 22:29:49 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Scott Branden <scott.branden@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 07/53] misc: bcm_vk: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:25 -0700
Message-ID: <20240630222904.627462-8-bvanassche@acm.org>
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
 drivers/misc/bcm-vk/bcm_vk_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_v=
k_dev.c
index d4a96137728d..ced5c9f17909 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1428,7 +1428,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
 	INIT_WORK(&vk->wq_work, bcm_vk_wq_handler);
=20
 	/* create dedicated workqueue */
-	vk->wq_thread =3D create_singlethread_workqueue(name);
+	vk->wq_thread =3D create_singlethread_workqueue2("%s", name);
 	if (!vk->wq_thread) {
 		dev_err(dev, "Fail to create workqueue thread\n");
 		err =3D -ENOMEM;

