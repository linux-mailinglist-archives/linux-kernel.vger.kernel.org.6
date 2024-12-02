Return-Path: <linux-kernel+bounces-428021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5BC9E0911
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8669216C4A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11FB1DD884;
	Mon,  2 Dec 2024 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N32fYeE1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255C01DA622
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157345; cv=none; b=KKjNzPFyj7qB8EtHoS3hx7wiC1ZmQy8m+ZqZcWneqKSxuLwFm0gf8qKet3Sq5SQ2BqBzIUy/I7eHn+FLeEXMCOnEhv7sMqgOiSXk/ANmhe76JOUlxWyT9Hxl3gJPhvY2g1nWAACb0Jz9AGUPpSVEVtRptoH6X1YYnAveyZXZD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157345; c=relaxed/simple;
	bh=lu/T8c/ONtFclthiZfbjtk5Klo4nJJWTbw0vZYcIpiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbQms+cq5ZavzqM04ZuKKmOYKdHjbP17OVVcKUfz2QzawTE57L3vlSkRYdiDiJBpSiMt2AmqIZuXVhAYxtMJ2bTfx//CFVowUGgn4sAFvQF1mdLMctzr4chPXYKvadGtIEpBGuT9+0CtG0X4msUPFObgyS8S0mHcZ01rPBMO+i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N32fYeE1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733157342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MD7vpVzmNdr2zkj6ePakrYVQbOesXQVj6yS9qMqPqYA=;
	b=N32fYeE1G+m5facH/k5Nu6Ky4lMiALJbXzk8QbVnjXX+JjzVF3r7Oo4BUZ/2P7iH6692wz
	aPQ/rsWfVyg8xHKA2IUitd2gJcK8e/fNKiLdSU34mxIvdoTlDb7FxAhSxE3lbd44KhqCj3
	J8/JpZcKpxJKJ732lU43ObUZdgmfrtI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-kTsgXmKUOoSBAhS4dEswpQ-1; Mon,
 02 Dec 2024 11:35:36 -0500
X-MC-Unique: kTsgXmKUOoSBAhS4dEswpQ-1
X-Mimecast-MFC-AGG-ID: kTsgXmKUOoSBAhS4dEswpQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DAAD195FD0C;
	Mon,  2 Dec 2024 16:35:33 +0000 (UTC)
Received: from rhel-developer-toolbox-2.redhat.com (unknown [10.45.225.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD0471956067;
	Mon,  2 Dec 2024 16:35:29 +0000 (UTC)
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
Subject: [PATCH 6/6] pps: use cdev_device_add()
Date: Mon,  2 Dec 2024 17:34:51 +0100
Message-ID: <20241202163451.1442566-7-mschmidt@redhat.com>
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

The cdev_set_parent() + cdev_add() + device_add() sequence is just
open-coded cdev_device_add(). Use it.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/pps/pps.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 64a8b34aa4ce..89b502855e7b 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -361,13 +361,10 @@ int pps_register_cdev(struct pps_device *pps)
 		goto put_dev;
 	cdev_init(&pps->cdev, &pps_cdev_fops);
 	pps->cdev.owner = pps->info.owner;
-	cdev_set_parent(&pps->cdev, &pps->dev.kobj);
-	err = cdev_add(&pps->cdev, devt, 1);
+
+	err = cdev_device_add(&pps->cdev, &pps->dev);
 	if (err)
 		goto put_dev;
-	err = device_add(&pps->dev);
-	if (err)
-		goto del_cdev;
 
 	/* Override the release function with our own */
 	pps->dev.release = pps_device_destruct;
@@ -377,8 +374,6 @@ int pps_register_cdev(struct pps_device *pps)
 
 	return 0;
 
-del_cdev:
-	cdev_del(&pps->cdev);
 put_dev:
 	put_device(&pps->dev);
 	scoped_guard(mutex, &pps_idr_lock)
@@ -392,8 +387,7 @@ void pps_unregister_cdev(struct pps_device *pps)
 {
 	pr_debug("unregistering pps%d\n", pps->id);
 	pps->lookup_cookie = NULL;
-	device_del(&pps->dev);
-	cdev_del(&pps->cdev);
+	cdev_device_del(&pps->cdev, &pps->dev);
 	put_device(&pps->dev);
 }
 
-- 
2.47.0


