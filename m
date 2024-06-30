Return-Path: <linux-kernel+bounces-235369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E75D91D47D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10581C20B41
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C815748A;
	Sun, 30 Jun 2024 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="s6m+89GC"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F12157E84
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786651; cv=none; b=pvuulIYuLNIqg7voDRCl7P6UPhUXnJ5hxoKMvYugyqUoN4LeSCjEKWaU27ZoQWeSpowPHVM8U+sdyBB3ZF3pUYzEDrAm5zTjPSQ65zn7iEnHi/kTnEPRtOGSL4fRIAl10GD4IpuP0x87ItYaiqUDWXUslAZdboffPY1WVc08gO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786651; c=relaxed/simple;
	bh=tUbVJzUuG7ZHw5+C7mddw9Sd0qXDDpc0D302ICxu/Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMSVVbisgJG6Sit+dS+x9/Y878lSAcrzz4mnkfeZV+NFaftpYV62B0yNHKvynwlilzniblcuLMJftP7Dlzj5B+Wh0XxICy6O0Bw70s5BG2MXsmj8cJNMSXix349fCCd3zbNWxS5keQe+yVx1sfd9iCWlIL8kITLQcvavm0xWNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=s6m+89GC; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3m94skKzll9fM;
	Sun, 30 Jun 2024 22:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786647; x=1722378648; bh=yMVfI
	qqoUIRy7beKrIhjA8D9DxyD+p0AAzeh8SHR2Mg=; b=s6m+89GC/Xvlg3YQlLoox
	s8dz/7y+TPmKint92MWdCJ10kMPwRSywMcryzPiIV3ITvcUCH5Qj6oBe3beQZHH/
	4uwUrmdTv2RSKatA2rXJGpfUNsFDNFTHlWUc/bQsOEKw1aGFafPizQ0DOJTNqYkf
	sfap9KnFC2dA5rAKXxg/2PzM0IYOkJkXeeDMfNyxdZKR7p2gOOj+yZvH4tiVzoas
	CoQPooS2lNMqW5LmBaGDqMmDyWYJB9y/1fdyj+MFdsKH42xc8h7Y28yVCboEAU/d
	Lg1YvzzSsAsmaFQMOfl/TEZHnUffZKbdI7jueFLxJL3AQnP4m1EYub5runl18Bl8
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5wnrQUsHYP8J; Sun, 30 Jun 2024 22:30:47 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3m42P8pzll9f8;
	Sun, 30 Jun 2024 22:30:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 20/53] scsi: mpt3sas: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:38 -0700
Message-ID: <20240630222904.627462-21-bvanassche@acm.org>
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

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/m=
pt3sas_base.c
index b2bcf4a27ddc..2d8a56309ef0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -846,8 +846,8 @@ mpt3sas_base_start_watchdog(struct MPT3SAS_ADAPTER *i=
oc)
 	snprintf(ioc->fault_reset_work_q_name,
 	    sizeof(ioc->fault_reset_work_q_name), "poll_%s%d_status",
 	    ioc->driver_name, ioc->id);
-	ioc->fault_reset_work_q =3D
-		create_singlethread_workqueue(ioc->fault_reset_work_q_name);
+	ioc->fault_reset_work_q =3D create_singlethread_workqueue2(
+		"%s", ioc->fault_reset_work_q_name);
 	if (!ioc->fault_reset_work_q) {
 		ioc_err(ioc, "%s: failed (line=3D%d)\n", __func__, __LINE__);
 		return;

