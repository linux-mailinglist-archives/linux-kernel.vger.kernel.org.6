Return-Path: <linux-kernel+bounces-235361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407D91D475
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA98B21016
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA012CDAE;
	Sun, 30 Jun 2024 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JVNSztU1"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647F81723
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786613; cv=none; b=XpaA7YJJheQr4h4Y9qGnFJfyY9a9khHQVIo2rA+1QSTJhdsR585HYKkTfNJDiuw5+uiXe37QU5GqKS9BbzzIaH5DdFyoIAWbuz4eH9mo4U8YfQAYB8JFcLBELnyIOuvyFFVc5+APSrwefWDOhs4J+wrnwuZEHrgWiKtzG9jTV6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786613; c=relaxed/simple;
	bh=uNZv+DCbQU5n8gVLuT10n/spm9zLX1ZtG75pG3RT8f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhSJ8mWXSw4N4MxIxXN0LU2tarV3bzy0B6VQCf4mdp/p7QtPw69kkuCOwqXQLioee6iK1lB0B7OTZDg2lGNxUb/Vrdw4cwht0p/Gq8vpEYHbOk5zJjLOPh05a6fZM+PGQLsEMRCd3Yjidf+e/z+bRzcF32HLs3rFnnB6PhJff9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JVNSztU1; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3lS0QT9zll9fK;
	Sun, 30 Jun 2024 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786609; x=1722378610; bh=oMVFz
	scC6SIB62EsKxrZrPjjvxmT+6ngvcSpCx5J3vw=; b=JVNSztU1QzuaYg41NngE5
	9xgENbZWuEiWrSRAvhdBoe/YLleYs5/XXQczcW7QkMA/1466qdoRf7z2AgMAlSVW
	8TuGiQeSevCMTDx8mDXp1gMjDWe152vAo+M2ysI3kNo040jheLtHdpqXMZIg52nt
	SSxIL/B6WkZ9CuYlclswh7A9ZJbqr+1r4s6eUnzUbra5ESa/DtjW0P0I2bGkxv/J
	lkTGq5iXQlqCXTzRUXiHl5zCRwdbk+dazbE89DE5rNHAIXk2s2mR3tBq8aHmuaCL
	0z4ETy7pC/ma5ANUCQaRCyTYs56EESyf6D3niLDn/HSzQwAeD6w/kvAH4YgR0GdG
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id D2V8LyrSHfe8; Sun, 30 Jun 2024 22:30:09 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3lM2FjGzll9f8;
	Sun, 30 Jun 2024 22:30:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 12/53] mm/z3fold: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:30 -0700
Message-ID: <20240630222904.627462-13-bvanassche@acm.org>
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
 mm/z3fold.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 2ebfed32871b..6fd3a05ecfc6 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -934,10 +934,10 @@ static struct z3fold_pool *z3fold_create_pool(const=
 char *name, gfp_t gfp)
 	INIT_LIST_HEAD(&pool->stale);
 	atomic64_set(&pool->pages_nr, 0);
 	pool->name =3D name;
-	pool->compact_wq =3D create_singlethread_workqueue(pool->name);
+	pool->compact_wq =3D create_singlethread_workqueue2("%s", pool->name);
 	if (!pool->compact_wq)
 		goto out_unbuddied;
-	pool->release_wq =3D create_singlethread_workqueue(pool->name);
+	pool->release_wq =3D create_singlethread_workqueue2("%s", pool->name);
 	if (!pool->release_wq)
 		goto out_wq;
 	INIT_WORK(&pool->work, free_pages_work);

