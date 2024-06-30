Return-Path: <linux-kernel+bounces-235383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBF991D48B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4E41C20BEE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A2815B0FE;
	Sun, 30 Jun 2024 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TEwLndRk"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F78415B0E4
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786721; cv=none; b=X13NXQFno86ugYoDLMjpczr/obAXE3ZtWxZdGJhBuZyn6QuklMhkjrV3VJRuSSL23P8a7PpbaoiLbdYZfF8akupJySuSr/E8lyGdntgdIfcqEiMK0yikEe0jRrqiuCDIeBHB40Oho7u1RNAK8hKUCBc2vOPsicXtoWjH37mmBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786721; c=relaxed/simple;
	bh=QEZizNUnkWcfUtwkCplZ989M4ffp/NuXuEiUX4Dt6/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw05Kf2DN3U98sqqshbur3bhcoBEMr7L36pStmPe9ueOaNhdDgd6bk6VAjo/OO8PGgQHH1vMcGt3W1uEOqX2gn87PSppBNGEng1YRiciFnb/BOnwpnrp9fgHrEmc2V0Fha8NwXzutL9mS50jD2Ftex22QXVqDttfcKcdbyUCRN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TEwLndRk; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3nX1TTczll9fM;
	Sun, 30 Jun 2024 22:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786717; x=1722378718; bh=fSfnP
	5iliplLm9OZ7mV5lO1OU9QqHqPYYpabkUaKddo=; b=TEwLndRkHxfjkbDsKba7+
	64Dw9Ub6dSHAGmQia6Ona5jI0asKgf21KVvOQG7fJwTaQB1sFwPgiChGEY1UyZ0x
	fuZQhzNbJ6UF411xPNGPD9DfcvXsNN1q1m3yKMrqqf8FBadPYD2R8PGjH06sYkOt
	HNHipsHjPZuziaPWJtNlt1jwm80J1WH6NXRxsEFEf0CS3loptb3//yzobWhkaXgB
	tOdbunuAi0uogyeJHoR7wcB2jKDLrRmftYx9HmT31srFtT9NupAGL2mPT9ypvSBZ
	5sFeo1BP0L6m6eOoeRYrs5asq0iI2msTAWbu+8OgCdVBOA1FT3u+xvXwiAr5mpGV
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wJMKd8pJJuTq; Sun, 30 Jun 2024 22:31:57 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3nQ0WW3zll9fB;
	Sun, 30 Jun 2024 22:31:53 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 34/53] scsi: mpi3mr: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:26:52 -0700
Message-ID: <20240630222904.627462-35-bvanassche@acm.org>
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

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr=
_fw.c
index c2a22e96f7b7..d0dfd0c43f71 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -2689,8 +2689,8 @@ void mpi3mr_start_watchdog(struct mpi3mr_ioc *mrioc=
)
 	snprintf(mrioc->watchdog_work_q_name,
 	    sizeof(mrioc->watchdog_work_q_name), "watchdog_%s%d", mrioc->name,
 	    mrioc->id);
-	mrioc->watchdog_work_q =3D
-	    create_singlethread_workqueue(mrioc->watchdog_work_q_name);
+	mrioc->watchdog_work_q =3D create_singlethread_workqueue2(
+		"%s", mrioc->watchdog_work_q_name);
 	if (!mrioc->watchdog_work_q) {
 		ioc_err(mrioc, "%s: failed (line=3D%d)\n", __func__, __LINE__);
 		return;

