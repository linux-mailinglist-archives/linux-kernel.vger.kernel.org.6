Return-Path: <linux-kernel+bounces-428013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3856B9E08B2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F181D281FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24091A3AA9;
	Mon,  2 Dec 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNrHjCaW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C31A263F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157330; cv=none; b=cwpSWVNg3Smgu91m8NRg+WwpAMBQjF33WFh82Tu7vjYaBMYQtA3oZSZrnyEdJmyGejsBWnzEVmnhmhoDAsWm0/zAwYCsosFfcW5SUN1m8WocO4au0gS02J8/J2+UhBCkZ2Bj0MqsRJvz+vtIZa4TD5H+sLbXKihvTiLyVuoaLBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157330; c=relaxed/simple;
	bh=w+ZcGKebnCge9cWTm+RUJ97cLvqTCMo8kHxVVTYWbKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3YCs9odJyCHBp6zLmBNRfY4kwmW146PT8ZCNNLKb36EPKXtAJ/6iY3ljB2RNbaToneVnbPe+ZcPd4XmssMq982/x19I/POPD7mdjC0wACARAG7aKEKqcoOLMm3oSsjhl7oQdXBWqTlJsXUVS7niZe8yoreWnqltQeSNkktvh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNrHjCaW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733157325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zjeefh/Ite+E0sy7DyA+HC2ndpLT7TPRyVlqY/4lKWs=;
	b=HNrHjCaW/HxOVL8M6eXbNHRWkF2WEaSDtSfc8eDMZ6gEH76s+8LhLY+aageeYh96/W0ac2
	TDSL1DAAsfQZlMmdz/LIZyUNRappyjiM0dSzDmopbOYeYp9GTQ1BRg1QF6h1sc9ozxNV9o
	7b57Bx/WXybx4X8CdfbDFRojcL7U57M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-OAHhXO0mN5egkWvU2y1x9Q-1; Mon,
 02 Dec 2024 11:35:22 -0500
X-MC-Unique: OAHhXO0mN5egkWvU2y1x9Q-1
X-Mimecast-MFC-AGG-ID: OAHhXO0mN5egkWvU2y1x9Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFC281944D3E;
	Mon,  2 Dec 2024 16:35:19 +0000 (UTC)
Received: from rhel-developer-toolbox-2.redhat.com (unknown [10.45.225.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C0FC1956089;
	Mon,  2 Dec 2024 16:35:15 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ma Ke <make24@iscas.ac.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	George Spelvin <linux@horizon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] pps: use scoped_guard for pps_idr_lock
Date: Mon,  2 Dec 2024 17:34:48 +0100
Message-ID: <20241202163451.1442566-4-mschmidt@redhat.com>
In-Reply-To: <20241202163451.1442566-1-mschmidt@redhat.com>
References: <20241202163451.1442566-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Use the scoped_guard syntax to be more brief.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/pps/pps.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 9a631f6d3a1e..92be7815a621 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -323,9 +323,8 @@ static void pps_device_destruct(struct device *dev)
 
 	/* Now we can release the ID for re-use */
 	pr_debug("deallocating pps%d\n", pps->id);
-	mutex_lock(&pps_idr_lock);
-	idr_remove(&pps_idr, pps->id);
-	mutex_unlock(&pps_idr_lock);
+	scoped_guard(mutex, &pps_idr_lock)
+		idr_remove(&pps_idr, pps->id);
 
 	kfree(dev);
 	kfree(pps);
@@ -340,9 +339,8 @@ int pps_register_cdev(struct pps_device *pps)
 	 * Get new ID for the new PPS source.  After idr_alloc() calling
 	 * the new source will be freely available into the kernel.
 	 */
-	mutex_lock(&pps_idr_lock);
-	err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
-	mutex_unlock(&pps_idr_lock);
+	scoped_guard(mutex, &pps_idr_lock)
+		err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
 	if (err < 0) {
 		if (err == -ENOSPC) {
 			pr_err("%s: too many PPS sources in the system\n",
@@ -387,9 +385,8 @@ int pps_register_cdev(struct pps_device *pps)
 	cdev_del(&pps->cdev);
 
 free_idr:
-	mutex_lock(&pps_idr_lock);
-	idr_remove(&pps_idr, pps->id);
-	mutex_unlock(&pps_idr_lock);
+	scoped_guard(mutex, &pps_idr_lock)
+		idr_remove(&pps_idr, pps->id);
 	return err;
 }
 
-- 
2.47.0


