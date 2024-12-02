Return-Path: <linux-kernel+bounces-428014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BF49E08B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBDD280FB9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A11D8E1E;
	Mon,  2 Dec 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiueJSIJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64F1A4F20
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157332; cv=none; b=BenZUoarRo6CcnPt4Wv3zjX/opVZlPCzOjL2gHsGzcfDcejrdAB7/LxLOd+kErxGd2wO3L74Fr/uFnx/YOU5OJeUo9KbdH9N4cKOM2/zaCM5AqUUL8BBKfD88IXN8M4thPLKMHVtOIQx7Eoq3QDehcaMjyWJpH1Gwzxr6pAaE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157332; c=relaxed/simple;
	bh=RUqSuOrIU5RfL1TOZs7Z5ENFkMnZ9Q1EPtuXOwalsAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6FEZoRV92M36T8MZFQ0ybVyhSuJVCh5gGYgAulcsXziLlGgFfRmNmm8MEowgHtelz34evhKtbMPO3qJGc+7zYee/e6p19+ifbIOQDW8hNpLm+tanETNoh3mugUOKdUCg1dLi9SPuzYyhmTVM2PZPG7rVwSjicQ+ppVnlDyeL+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CiueJSIJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733157330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpeDd+7B9ztAilsfvA8YQqfJL+Dpex3xILQfCZIzWdg=;
	b=CiueJSIJH/4Vrn29Bv8N6UCe+aj13hEWlqG8bT8o+wUue+ZHRqdL4LqlJII6aUIUFh1IIX
	Z9uGVWhzS1FP7O0TcpbMtCWYtLJNlriYlwC9vd8zF2Zeiu3zxHOrAMWrBOZ6Lw4kbuJ7gF
	9mdXFfGoky0eYy/cN20IdCRRRL1r9As=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-q8ccNZUINeWjn9YamZk7VA-1; Mon,
 02 Dec 2024 11:35:26 -0500
X-MC-Unique: q8ccNZUINeWjn9YamZk7VA-1
X-Mimecast-MFC-AGG-ID: q8ccNZUINeWjn9YamZk7VA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 836FB1955F40;
	Mon,  2 Dec 2024 16:35:24 +0000 (UTC)
Received: from rhel-developer-toolbox-2.redhat.com (unknown [10.45.225.22])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABE2F195608A;
	Mon,  2 Dec 2024 16:35:20 +0000 (UTC)
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
Subject: [PATCH 4/6] pps: print error in both cdev and dev error paths in pps_register_cdev()
Date: Mon,  2 Dec 2024 17:34:49 +0100
Message-ID: <20241202163451.1442566-5-mschmidt@redhat.com>
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

For pps, a device_create() failure is just as severe as a cdev_add()
failure. Print the error message in both cases.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/pps/pps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 92be7815a621..f90ee483d343 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -357,11 +357,9 @@ int pps_register_cdev(struct pps_device *pps)
 	pps->cdev.owner = pps->info.owner;
 
 	err = cdev_add(&pps->cdev, devt, 1);
-	if (err) {
-		pr_err("%s: failed to add char device %d:%d\n",
-				pps->info.name, MAJOR(pps_devt), pps->id);
+	if (err)
 		goto free_idr;
-	}
+
 	pps->dev = device_create(pps_class, pps->info.dev, devt, pps,
 							"pps%d", pps->id);
 	if (IS_ERR(pps->dev)) {
@@ -387,6 +385,8 @@ int pps_register_cdev(struct pps_device *pps)
 free_idr:
 	scoped_guard(mutex, &pps_idr_lock)
 		idr_remove(&pps_idr, pps->id);
+	pr_err("%s: failed to add char device %d:%d\n",
+	       pps->info.name, MAJOR(pps_devt), pps->id);
 	return err;
 }
 
-- 
2.47.0


