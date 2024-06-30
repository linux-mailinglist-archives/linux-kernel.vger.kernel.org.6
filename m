Return-Path: <linux-kernel+bounces-235355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D4C91D46F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938FE1C20864
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642EB78C67;
	Sun, 30 Jun 2024 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UlGI3SfP"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7017377119
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786592; cv=none; b=TwyhfYzwU/IDDtPzfgYKidoMEn79EDQWLzn0YwJaGA6CYR5kFKhJ5JTX+/UAMf9CcmkEvY448Pnyt+LWZNcqcltp6C5u3G9ABkY2Gu1jZUy8csLTUrDRxp15id4LgHPaX1nKbnGjGpqSVEIh/WSc22q66mC/j20QeoLWZmr2ris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786592; c=relaxed/simple;
	bh=Y13wtp1jarQ90R+t0Krp1VajIl83Vd5HL0bFkiqB/yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dD9lyY6AHaqxwC4WD4DyyqnQknR+HB1IcooVseNNUlFum8Q1E64lgWLTc4Ram+yTLcWzbmTDygDtO+gSdJsrdUIBfOMP9VBaWj53CCm1Q1w+byE4S8uyN2dypGrzubZWM9I4i24fMBRBiijAfZGdivT89TLEpZNhRi1lPkmXwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UlGI3SfP; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3l2709lzll9fG;
	Sun, 30 Jun 2024 22:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786589; x=1722378590; bh=rwCX1
	ywcYcwnO5dSnp8tJ42j3hIAQZC1onL11vo249Q=; b=UlGI3SfPxlMOmeVwbk2SD
	uqki70DxTeG6VQTY9JrE+Edi0vwcrWgg4xFG17U8d0SncQ22d4ZXIbQ7oMOPG4Xf
	eSFE4a0Z/UYHs9RxtGE+/RwExsKGJqDF/k8OEAifGA9E666AYne6rXaHQAJUbAQl
	e30M88GSBR5ff4WcPMtfbY80hok4TaSQWvs3M0KmeBk3aky+XeJAJmlr2MorAUu6
	GX3aURvV2LgeTn9cUmsvz5u0E69ow6sZ5DcHsjqhbXaosj4rh1yrHyMvBPek8Vmy
	djIx4eEQtYvc4nZokPYH9+4X1AuIzop0604sEEaWg6B6gDC4vR00PXV0OD8gW304
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id guarKsOnIYIK; Sun, 30 Jun 2024 22:29:49 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3kz45mZzll9f5;
	Sun, 30 Jun 2024 22:29:47 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 06/53] media: dm1105: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:24 -0700
Message-ID: <20240630222904.627462-7-bvanassche@acm.org>
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
 drivers/media/pci/dm1105/dm1105.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105=
/dm1105.c
index 9e9c7c071acc..05959891aa5f 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -1123,7 +1123,7 @@ static int dm1105_probe(struct pci_dev *pdev,
=20
 	INIT_WORK(&dev->work, dm1105_dmx_buffer);
 	sprintf(dev->wqn, "%s/%d", dvb_adapter->name, dvb_adapter->num);
-	dev->wq =3D create_singlethread_workqueue(dev->wqn);
+	dev->wq =3D create_singlethread_workqueue2("%s", dev->wqn);
 	if (!dev->wq) {
 		ret =3D -ENOMEM;
 		goto err_dvb_net;

