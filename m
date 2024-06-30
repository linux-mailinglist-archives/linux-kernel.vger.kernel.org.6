Return-Path: <linux-kernel+bounces-235349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1636B91D469
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8910FB20E2A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54C2762EF;
	Sun, 30 Jun 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Y1ZnFrzB"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5EF6F2F1
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786579; cv=none; b=Jii1SsdzXsByirF1xf8SDU6tCYkqHME7B3AnldkDbTb2jGGdIs6nhUv/7Rr3NrNshLiBkSyGLD/LhKZ+0hjgh34nZofd/Fu2U+wwud9BBn9dqtkGen/3lDGNqmbZinb4jn56Pr5RaMiVLSJjn3Ud3TyMsi9Ksxu6REjLhm56NAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786579; c=relaxed/simple;
	bh=TtxHGt+ZDV6Up1efv6hPse6Tr8kRShS6DELPnMPSyiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8GVhL3mze7i7BtiZkIxG5s5OvAbn0ZM6NvG7N2G6JWmLIBsLXIuCQrFDSMGDpNDgPdLN7nMVsliWc9IqHcqR+LEJaBiweWLy9Ub8M6FKFJhPD0+j4jN0tp1jxGgfXOZKMqEO7KV7UwN0P8Bs8t117+yYI8O5XYn+l9+1XvN7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Y1ZnFrzB; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3kg2Mydzll9fH;
	Sun, 30 Jun 2024 22:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786569; x=1722378570; bh=IiRz3
	eVOkuyIZsY+zjS9RBHbCwn+rjEJTbR1vgk1ooY=; b=Y1ZnFrzBq0bf9on2YrPTG
	R6T34TbGkGUgU5at7CzFy6R5annieP/49Ah5nB/1tzW8wECoKp7yQ7W7FrAQdWj4
	+OQkrFoZMEBvgZ2gV9y3LXO7QoeqdLoHC6NB9QOnMbs8AwLD+fhd0VDR+VHiyn6y
	CJfesHTVq8LKWSD/HjFWQbP1tYZ5eM0LtMCmM0GXOiPxpDjJxHyrUEoZ9Xt8YxMv
	REbIV7u30s/CqOb7hfIXGtYz0aPRbETm3a3RuqhrfiYuY8wd3EoWwQLOvL73OSPg
	94zbM3qNLaPPY0RY5qKUch9Nd4HfDqKeqx3F+MWgiHhFL8Kp+Fsh9TcqO0HqcUth
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9EHWVaS-8QQj; Sun, 30 Jun 2024 22:29:29 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3kb5g9Wzll9fL;
	Sun, 30 Jun 2024 22:29:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 01/53] workqueue: Introduce the create*_workqueue2() macros
Date: Sun, 30 Jun 2024 15:26:19 -0700
Message-ID: <20240630222904.627462-2-bvanassche@acm.org>
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

A common pattern in the Linux kernel is that sprintf(), snprintf() or
kasprintf() is used to format the workqueue name that is passed to
create_workqueue(), create_freezable_workqueue() or
create_singlethread_workqueue(). Prepare for simplifying such code by
introducing the create*_workqueue2() macros that accept a printf-style
format string and argument list. A later patch will remove the
create*_workqueue() macros and will rename the create*_workqueue2()
macros into create*_workqueue().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/workqueue.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d9968bfc8eac..762aaedaba56 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -525,11 +525,20 @@ alloc_workqueue(const char *fmt, unsigned int flags=
, int max_active, ...);
=20
 #define create_workqueue(name)						\
 	alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
+#define create_workqueue2(fmt, args...) \
+	alloc_workqueue(fmt, __WQ_LEGACY | WQ_MEM_RECLAIM, 1, ##args)
 #define create_freezable_workqueue(name)				\
 	alloc_workqueue("%s", __WQ_LEGACY | WQ_FREEZABLE | WQ_UNBOUND |	\
 			WQ_MEM_RECLAIM, 1, (name))
+#define create_freezable_workqueue2(fmt, args...)                       =
        \
+	alloc_workqueue(                                                       =
\
+		fmt, __WQ_LEGACY | WQ_FREEZABLE | WQ_UNBOUND | WQ_MEM_RECLAIM, \
+		1, ##args)
 #define create_singlethread_workqueue(name)				\
 	alloc_ordered_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, name)
+#define create_singlethread_workqueue2(fmt, args...)			\
+	alloc_ordered_workqueue(fmt, __WQ_LEGACY | WQ_MEM_RECLAIM, ##args)
+
=20
 #define from_work(var, callback_work, work_fieldname)	\
 	container_of(callback_work, typeof(*var), work_fieldname)

