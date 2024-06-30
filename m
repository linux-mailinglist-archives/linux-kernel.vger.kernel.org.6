Return-Path: <linux-kernel+bounces-235370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE5C91D47E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A121C20941
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2E083CDA;
	Sun, 30 Jun 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="poXrv6Pp"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAAC83CD2
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786661; cv=none; b=LNGAHlwIXLg7gvZD3slWInInhQvneJq+iGy/8wxcI8J4KImtSK1kGmINUnSoSxRgE3oXbogk2KAk+/Nw/mOJezNTtf/LZPp8MGL3/OWU8DTGbYAbYLsz1ex5sKlqXaOHYr7qV5PqdWQ4RnvbCCVX629D+gj2fiTLRH6ek2s79pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786661; c=relaxed/simple;
	bh=YYP7ECM245oOndbZpOAQKMWR4jnF2PEPqJOhen+RRTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oi/UzoNDJDyDDX3aplj11w/71X0J/dFjP7GcZ6F+zykwbkFr1EnyATZkR2W89hr7fpbVFsQAxBfVnOXmPuEm41/fJHx9qmvTK3y5E/vqUt2VWIWoSvodgCn0C3pBoYRNTckMPG8B8LesrekQ5Z6Tp2jDhoLas0LLvusEQh9T1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=poXrv6Pp; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3mM4MVxzll9fW;
	Sun, 30 Jun 2024 22:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786657; x=1722378658; bh=srS5k
	sO9b7hJ8Vkoa/n7YlGzN/WBGtTuwo7iQfvBhSU=; b=poXrv6PpNYZRUSvdrZwI2
	YvrGVT5abMmBX3jxRdUcUjSIpz+dR7/Kr8lgeu0ouP+5wkShopwlMvt9K+Q2y2j0
	/PcNv4bLC1XBPVEadDHhIcCKablMJm1clY6XMktIh0uIAew7oQKNENdpD0YZ/oBA
	f0fjRaoAt4U/f6xk3clDDe2JPVaKgT46t1JA8uiaNaU5g6X3EorYk4mantGDktSf
	DxQeaH7+L8xOKSXRlbhFe48HN3vyEjryrfoqUHpNawB7yqGTRdWrQYa4BN3ZHb95
	PvL3gk7UVTLRRUVK8Xtf4bD13rOmDdnMp63xtVMmkfw096M9gj+3JEtM9EtzMXm3
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id j4XH3eIq4beq; Sun, 30 Jun 2024 22:30:57 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3mG334rzll9fH;
	Sun, 30 Jun 2024 22:30:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Antoine Tenart <atenart@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 22/53] crypto: safexcel - Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:26:40 -0700
Message-ID: <20240630222904.627462-23-bvanassche@acm.org>
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
 drivers/crypto/inside-secure/safexcel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/ins=
ide-secure/safexcel.c
index f5c1912aa564..45cff3adc71d 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1615,7 +1615,6 @@ static int safexcel_probe_generic(void *pdev,
 		return -ENOMEM;
=20
 	for (i =3D 0; i < priv->config.rings; i++) {
-		char wq_name[9] =3D {0};
 		int irq;
 		struct safexcel_ring_irq_data *ring_irq;
=20
@@ -1664,9 +1663,8 @@ static int safexcel_probe_generic(void *pdev,
 		INIT_WORK(&priv->ring[i].work_data.work,
 			  safexcel_dequeue_work);
=20
-		snprintf(wq_name, 9, "wq_ring%d", i);
 		priv->ring[i].workqueue =3D
-			create_singlethread_workqueue(wq_name);
+			create_singlethread_workqueue2("wq_ring%d", i);
 		if (!priv->ring[i].workqueue) {
 			ret =3D -ENOMEM;
 			goto err_cleanup_rings;

