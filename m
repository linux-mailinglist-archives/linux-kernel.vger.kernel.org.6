Return-Path: <linux-kernel+bounces-428012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CE29E08B1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6CD281D2C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18561B6555;
	Mon,  2 Dec 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ig0uKw4v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8201AF4C1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157323; cv=none; b=Dzk2qnis7MwzRd+wfJ67vedk/EplYPz0XYv3/x6CA0RRx92lTutAGVvnJ7bCwild86qATFtBxD3wjW2928IoCYlAAU+IgTS5z8EVbLXx87ZfwNGNqp0h8X6n04PI5UeDRVuQ1Ri0/aWNsmbWy/fuSLD4LzVqyLrv66WPRzpAUN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157323; c=relaxed/simple;
	bh=PZFWMMZcLO/qhlPXqW6e0YrlQMvPOyvQ/klWUVWdxmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXuptkTOGY9y83tzXiH9wQy655BR1eXWk8cTekr26zxrjDmC+m5bxg/1j6AsPAz0wKx9lxn+DT7zZ72BX94FBbVw7b7QG1KvSUmJZSInJIDpiCywxgKpjDYgBkpVj4pxa7sj1D84AAeTXRGLsiDG4Y8ObisE10b037IjIScGNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ig0uKw4v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733157320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PSHFNlDA9lcePqjIa440ia9/4xR3F3nAudrFnACkrk=;
	b=ig0uKw4vTd8yVv+rovtJbFKoxqpnuvPbt2E6/v9oGMnT3Emt4cFAU1F4D/YU/ZQj7PrZXo
	etqtAl5gOQEvruckwaDEgIKBXtqRtaAFuPO0CS2PzbaPj7oQl0ysbB+1dDKE8j7AWFT7cB
	SC2wAXhBo4wz2oOjC7HZme/9sEr7REA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-CmKKg31rPTqwnMDqqfjwJg-1; Mon,
 02 Dec 2024 11:35:17 -0500
X-MC-Unique: CmKKg31rPTqwnMDqqfjwJg-1
X-Mimecast-MFC-AGG-ID: CmKKg31rPTqwnMDqqfjwJg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5700D1964CF4;
	Mon,  2 Dec 2024 16:35:15 +0000 (UTC)
Received: from rhel-developer-toolbox-2.redhat.com (unknown [10.45.225.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E668B195605F;
	Mon,  2 Dec 2024 16:35:10 +0000 (UTC)
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
Subject: [PATCH 2/6] pps: simplify pps_idr_lock locking
Date: Mon,  2 Dec 2024 17:34:47 +0100
Message-ID: <20241202163451.1442566-3-mschmidt@redhat.com>
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

It is sufficient to hold pps_idr_lock only around the idr
(de)allocations. There is no reason for the assignment to pps->id or for
the error printing to be under the lock.

Simplify the pps_idr_lock locking and the error path.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/pps/pps.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 4f497353daa2..9a631f6d3a1e 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -336,22 +336,22 @@ int pps_register_cdev(struct pps_device *pps)
 	int err;
 	dev_t devt;
 
-	mutex_lock(&pps_idr_lock);
 	/*
 	 * Get new ID for the new PPS source.  After idr_alloc() calling
 	 * the new source will be freely available into the kernel.
 	 */
+	mutex_lock(&pps_idr_lock);
 	err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
+	mutex_unlock(&pps_idr_lock);
 	if (err < 0) {
 		if (err == -ENOSPC) {
 			pr_err("%s: too many PPS sources in the system\n",
 			       pps->info.name);
 			err = -EBUSY;
 		}
-		goto out_unlock;
+		return err;
 	}
 	pps->id = err;
-	mutex_unlock(&pps_idr_lock);
 
 	devt = MKDEV(MAJOR(pps_devt), pps->id);
 
@@ -389,7 +389,6 @@ int pps_register_cdev(struct pps_device *pps)
 free_idr:
 	mutex_lock(&pps_idr_lock);
 	idr_remove(&pps_idr, pps->id);
-out_unlock:
 	mutex_unlock(&pps_idr_lock);
 	return err;
 }
-- 
2.47.0


