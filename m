Return-Path: <linux-kernel+bounces-235378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4D991D486
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5801C20B7F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27C015A489;
	Sun, 30 Jun 2024 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pcR/wko7"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB7159207
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786700; cv=none; b=qTqI7ZmdTDp5HhTFDE4h12/de5p4yX/UCXebnpCFD1QXODwiZ/xG9zQbPaV5HXm/7q5VNSUo3MPtgR/RvwGZ8PiRh1rbtLbIobPOdeQfmkTkpZ+Ej0p+2rsM8XMJl2ef6FrC+1SNYLsNDZUwfn+DTkajO9AJF7ud8CIFWfpz1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786700; c=relaxed/simple;
	bh=5nXDwYcUndMN/hXfZxWms1Bfi4qrheYAH/IuzVKtBfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggAH9BuR/UTBnd+ySyUEvLhE4feSrvbzyyLd/wbOH4QY45ANh7vcncSBMM7wA1MKh2gnlmcJrxKh8/RO4VAuFwOmtvg8omuybJOdwO9Rf8GV0qWyllZx3SKVyXaM5mz7FDhNiDxmLWeoulqFikAJuShGHsre9ZrQ0vH/FA+OIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pcR/wko7; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3n65GxKzll9f8;
	Sun, 30 Jun 2024 22:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786695; x=1722378696; bh=Q3kJ2
	KuV1/JaaGNMf/Ki3r1gW/L1Or/OKqX6F4/esOs=; b=pcR/wko7BTdM6SG+5rdTd
	Spr1G2PeDRd75Otno35PZY9cWACLqkWNE6TqC4rD64BmiU0IP+82bfOq5v8xzdNk
	c54wszSjriVGk5ILKXcu+c9WQN+li/HONg0hR3FoWrBCM2i2QjzPhOmwUofZ3K+G
	UeK2TUtpFz75FZ6wE1kQE6YO0xlNQKX4lRNyEB7tf8eY3F8wXK5o7E5gDkJidUD3
	NheUk7Fz+jU3gIyVRX/BBF44apc3o1BK/DLKA7x0xatkXdPgzycRCjomocaJgDbY
	y3qAIsar1I10lkpZt2mdVcI0jrDaqRo42zq5s5BhUjkrZCn2R5Qo1hGx5gzazVfT
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cjYvoBAK_nai; Sun, 30 Jun 2024 22:31:35 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3n030V3zll9fH;
	Sun, 30 Jun 2024 22:31:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 29/53] net: qed: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:26:47 -0700
Message-ID: <20240630222904.627462-30-bvanassche@acm.org>
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
 drivers/net/ethernet/qlogic/qed/qed_sriov.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/et=
hernet/qlogic/qed/qed_sriov.c
index fa167b1aa019..29c5b301bbd7 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -5262,7 +5262,6 @@ void qed_iov_wq_stop(struct qed_dev *cdev, bool sch=
edule_first)
=20
 int qed_iov_wq_start(struct qed_dev *cdev)
 {
-	char name[NAME_SIZE];
 	int i;
=20
 	for_each_hwfn(cdev, i) {
@@ -5274,11 +5273,9 @@ int qed_iov_wq_start(struct qed_dev *cdev)
 		if (IS_PF(p_hwfn->cdev) && !IS_PF_SRIOV(p_hwfn))
 			continue;
=20
-		snprintf(name, NAME_SIZE, "iov-%02x:%02x.%02x",
-			 cdev->pdev->bus->number,
-			 PCI_SLOT(cdev->pdev->devfn), p_hwfn->abs_pf_id);
-
-		p_hwfn->iov_wq =3D create_singlethread_workqueue(name);
+		p_hwfn->iov_wq =3D create_singlethread_workqueue2(
+			"iov-%02x:%02x.%02x", cdev->pdev->bus->number,
+			PCI_SLOT(cdev->pdev->devfn), p_hwfn->abs_pf_id);
 		if (!p_hwfn->iov_wq) {
 			DP_NOTICE(p_hwfn, "Cannot create iov workqueue\n");
 			return -ENOMEM;

