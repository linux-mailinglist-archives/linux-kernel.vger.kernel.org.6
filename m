Return-Path: <linux-kernel+bounces-235365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4068B91D479
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7421F21001
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699782D7F;
	Sun, 30 Jun 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ty3ePXj3"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F258289A
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786639; cv=none; b=T+gtv6B6mwyiin1uMGo8raL5SKSC12JNE0rBQG+Xocz+hEVKBaVE4qDImywIlYYXDNNUskvgU5sCLM+D5GJh3tuEy1QTjA2EHnPobC/NwCBy2iC7ZYx73Z1pA4bjBVJcIJil2Ei9lYUIU1gyZAzosy1GdQrj2IAunu0t/KsFPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786639; c=relaxed/simple;
	bh=t6wjaU2fJFsV5j0V/fLPxTPrDJDveGhLLexBHT5WHaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLXocmfIzHN0e1kBT8oAsxRGFdaqYNhRVEEvSY0g8b5OoytaKxbHR7phTzEmbVc1OlWNnNvzqe4h9ScQbX/4w9DyFiizwmrOsAoJkSx9G7EyYR4aacPpN49KTn8alGttSi/Aw3bW829MKiS7JiKW44jvtpOFBtXSNGprApyplqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ty3ePXj3; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3lx15YSzll9fK;
	Sun, 30 Jun 2024 22:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786634; x=1722378635; bh=N1R1X
	DVWyfq4EWSGcsvb+u+j+2IcCrjwkKAM+atAk9w=; b=ty3ePXj3zTz4QpVUaNV6F
	WKs0TVbLM9b0mCgmiPVhUZf149QxhnKrf0ePvqD1AHGVeRyomwuxVT1rlFmSUmcz
	kHfGZQGN4oU/7dFoVdugyyYz+GHKDpylEQsybvUaCHGFIoyYuo+3HIcv/DbqJ1f8
	12+SWkkvMkjMIn8vl0UWZ9GNWb+oQ0zW6Q2RQsrqgrX3dkXMADvKkL6KBkpMIm4J
	4ZTL2UesJ3z5um9vnYry2UlgQ4N8hj6sA3L1Emk/pT1PwjtLaRMvWX/dafD+jTH3
	gL3MoGXvKBvnUL9+7AqcQkLSGGUDms/JoGysxuL9afUvkLiWT4XLat/juQPK7OJi
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 09xJEvQZNffi; Sun, 30 Jun 2024 22:30:34 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3lr3PKPzll9f8;
	Sun, 30 Jun 2024 22:30:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Kalle Valo <kvalo@kernel.org>,
	Yueh-Shun Li <shamrocklee@posteo.net>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/53] wifi: zd1211rw: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:34 -0700
Message-ID: <20240630222904.627462-17-bvanassche@acm.org>
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
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/w=
ireless/zydas/zd1211rw/zd_usb.c
index f3b567a13ded..54501732cd91 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -1542,7 +1542,7 @@ static int __init usb_init(void)
=20
 	pr_debug("%s usb_init()\n", driver.name);
=20
-	zd_workqueue =3D create_singlethread_workqueue(driver.name);
+	zd_workqueue =3D create_singlethread_workqueue2("%s", driver.name);
 	if (zd_workqueue =3D=3D NULL) {
 		pr_err("%s couldn't create workqueue\n", driver.name);
 		return -ENOMEM;

