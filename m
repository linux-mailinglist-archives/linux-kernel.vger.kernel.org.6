Return-Path: <linux-kernel+bounces-235364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A410291D478
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FEB1C209C2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA318287A;
	Sun, 30 Jun 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="m5hufEhb"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D327A74079
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786636; cv=none; b=cYb5lfNZ292ZCcdYBIJh4KpW+3BJmjlX8E6cAUm6QFtijHwihktgWy+jJWiqSSz/iUsLfcerh8yOfaKmhTyeMKU3e+UcthqLTbr3hmUkjTXYdhz/2smYIbsbqHhR+rmhZIafro7gu0xGJNUlN8cgSL4OvM8n+kLvSjZk766jZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786636; c=relaxed/simple;
	bh=Djbd94CdrEtKSbHgDb5v5suu+gNVTGQkonadpjrUK3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omKbBTq8K3mwzXe0Sud9tiZj4Q6uHpN7odlOhI9XBWRx5zwxvY/vlh6dEJRrs2J1WcVOMJlOzdf4HvYV4G7RiZwYSg91lDvAel8Z4bbhPJF8yXHaMDF4Qir+cqp+Z3SozTlUrenFXWRCEFzbcGbC50BEFC1yUcX4jG7YLp5qnxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=m5hufEhb; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3lt4W3xzll9fR;
	Sun, 30 Jun 2024 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786629; x=1722378630; bh=K4aMI
	K1f+/crGztkhLQqK03mPGM4Wwp4lzWfOle59+0=; b=m5hufEhbBzn0k2zbfqCF5
	SquM9JJ6Pl2X6QABgAFvXcflUoNcmULiRAw2m5j4KOtH3wixe4O0RU1icmCp74xo
	ln8DZPIetuUmRNoWEE75H/mxZeUX9SucX9mGSeKyyvipUUowmjQdRi881l+SjVy0
	BDnC4COPBRuE+iBWle4PadSnwq0I9wKOHB1LDd8yI62YLtD9O0MQGi/VcLkVOxZw
	1xp35PIAmSiFRbARgg3s31t+OAWRuF/3EKk6ZK3VOdhlHRbX4lPYivHi8IgQgONM
	ewJM4hicAWFuR9EkooGle51u55ZIBY2wlG/QTMFfyjGIVKWwgB5pHaalYf3yoQ8w
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ihSpZnsXdFIS; Sun, 30 Jun 2024 22:30:29 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3lj0TNtzll9fK;
	Sun, 30 Jun 2024 22:30:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 15/53] sfc: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:33 -0700
Message-ID: <20240630222904.627462-16-bvanassche@acm.org>
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
 drivers/net/ethernet/sfc/efx_common.c       | 3 ++-
 drivers/net/ethernet/sfc/falcon/efx.c       | 3 ++-
 drivers/net/ethernet/sfc/siena/efx_common.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet=
/sfc/efx_common.c
index 4ebd5ae23eca..6dc068d2c295 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -1035,7 +1035,8 @@ int efx_init_struct(struct efx_nic *efx, struct pci=
_dev *pci_dev)
 	/* Would be good to use the net_dev name, but we're too early */
 	snprintf(efx->workqueue_name, sizeof(efx->workqueue_name), "sfc%s",
 		 pci_name(pci_dev));
-	efx->workqueue =3D create_singlethread_workqueue(efx->workqueue_name);
+	efx->workqueue =3D
+		create_singlethread_workqueue2("%s", efx->workqueue_name);
 	if (!efx->workqueue) {
 		rc =3D -ENOMEM;
 		goto fail;
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet=
/sfc/falcon/efx.c
index 8925745f1c17..d4d02e2438c6 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -2671,7 +2671,8 @@ static int ef4_init_struct(struct ef4_nic *efx,
 	/* Would be good to use the net_dev name, but we're too early */
 	snprintf(efx->workqueue_name, sizeof(efx->workqueue_name), "sfc%s",
 		 pci_name(pci_dev));
-	efx->workqueue =3D create_singlethread_workqueue(efx->workqueue_name);
+	efx->workqueue =3D
+		create_singlethread_workqueue2("%s", efx->workqueue_name);
 	if (!efx->workqueue)
 		goto fail;
=20
diff --git a/drivers/net/ethernet/sfc/siena/efx_common.c b/drivers/net/et=
hernet/sfc/siena/efx_common.c
index cf195162e270..1a1448a75d99 100644
--- a/drivers/net/ethernet/sfc/siena/efx_common.c
+++ b/drivers/net/ethernet/sfc/siena/efx_common.c
@@ -1050,7 +1050,8 @@ int efx_siena_init_struct(struct efx_nic *efx,
 	/* Would be good to use the net_dev name, but we're too early */
 	snprintf(efx->workqueue_name, sizeof(efx->workqueue_name), "sfc%s",
 		 pci_name(pci_dev));
-	efx->workqueue =3D create_singlethread_workqueue(efx->workqueue_name);
+	efx->workqueue =3D
+		create_singlethread_workqueue2("%s", efx->workqueue_name);
 	if (!efx->workqueue) {
 		rc =3D -ENOMEM;
 		goto fail;

