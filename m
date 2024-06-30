Return-Path: <linux-kernel+bounces-235354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B77B391D46E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F33C1F213D2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BDE83CD2;
	Sun, 30 Jun 2024 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CVgC2Wqh"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576C82C7E
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786588; cv=none; b=skIIgANVG+8uYbbUvqYwl1IfWgxzLq6k7hqTnysDSVIOzoXXloBeSkHrmf+SC1+QqNi7mWoHaMyJpg/pkxFCDBkcWSxDMf7p8Z+7Yf+jLPbb3XxjvbUhG2a5BpJB/Jj1N5+OHd6al1zDABlgoNrZC2J2Z/VISmY1jOiDfoamgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786588; c=relaxed/simple;
	bh=CRiQL6WAk5l29cXAJl6kxhVbDiSQnvBfGkRj/Fl4i0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnO0YGab+tpGbGEBgvh7cEKI6CtB3ZeqLFOH5SlZu1LIuKZME8+PNvGgQ6ZXyB7U8T8gkxLBYM8pM17YcXK8mH5eL+MfV8PPc1UaWKyESYYo38XxTBOSjEjOzWNZjtE+i/bz6AGER1eo+092UvzTiennwvtGmTebrcDUj5ucIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CVgC2Wqh; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3ky3s6Tzll9fG;
	Sun, 30 Jun 2024 22:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786584; x=1722378585; bh=RsCNG
	HI2vnPyK1WUHqgDfapbjbllnZ71QBajHG4cE2c=; b=CVgC2Wqhwnluy73L4sTzn
	8Ad4gYujdOHQzsZZ1+v9oIN6puDIwwPXllItEcua9YacjK45xOGvIl/uE4SeQWPz
	ChxmYVe79OgnVZfpbLeQHMCfoM3qcSGpm8V/laDV2v0fbzQQWOYhPyDgaeo5GAHi
	eT0xdt2fVnEdv+uqObxWLo/etGITEppOsArKRveiJTx7IlJ/8PbCNM4K5EQb3jjl
	6DL+L09bnC/6dc78WjDnkWKoMhi2v8kVFe9yteR1KJcnkS0XylPDgpjufa+sqHKy
	H/2P8dkHRCGIV6sbxE2shupm7Q5MjpAthsxtkEKY1SDoN1Vpu41E4sEQ85qxemgW
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cIcksz7TIG0a; Sun, 30 Jun 2024 22:29:44 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3kt4T8szll9f5;
	Sun, 30 Jun 2024 22:29:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 05/53] media: cobalt: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:23 -0700
Message-ID: <20240630222904.627462-6-bvanassche@acm.org>
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
 drivers/media/pci/cobalt/cobalt-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cobalt/cobalt-driver.c b/drivers/media/pci=
/cobalt/cobalt-driver.c
index 6e1a0614e6d0..24e8f4439c53 100644
--- a/drivers/media/pci/cobalt/cobalt-driver.c
+++ b/drivers/media/pci/cobalt/cobalt-driver.c
@@ -683,7 +683,7 @@ static int cobalt_probe(struct pci_dev *pci_dev,
 	cobalt_info("Initializing card %d\n", cobalt->instance);
=20
 	cobalt->irq_work_queues =3D
-		create_singlethread_workqueue(cobalt->v4l2_dev.name);
+		create_singlethread_workqueue2("%s", cobalt->v4l2_dev.name);
 	if (cobalt->irq_work_queues =3D=3D NULL) {
 		cobalt_err("Could not create workqueue\n");
 		retval =3D -ENOMEM;

