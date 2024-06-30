Return-Path: <linux-kernel+bounces-235399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAF691D49B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A3C281421
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14415FA90;
	Sun, 30 Jun 2024 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="uqdB3qe5"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029F2152E05
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786775; cv=none; b=TgRmCFfu4S1mig/zBTfCpBFT+Ertp1vfIJBEzprF3c8pGdjZg9wYOVB0OBXqOY0q/XbXeGfWL5Aj1gz41T+Ag01feaXjn8RqaoFKIU3GSREA0U3AQttfQpbVxSLwhwKYJcKz+UdQZKQpZot52YNnBMUIRPT9vEcKwcNkahAjzcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786775; c=relaxed/simple;
	bh=KdKXZB0z/guBxicLlk/q6so368Vo18UU3FWu9nn+quc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uV1iIwsiMqkumQ2VHxzKZjfEzlaP4tqiIG2RmRtaAxybN2xHjGbXfBE9+iDKm/DFiWNQ7pasxep+IFzBxOxotGP+aCnfsytGRxTchpiZQPRMdl5NKH/JSiqBRJ2oVyzH9nU0u4rZECa+NwTlFsoeu3KZR1yjLsktDkZVTXT0dro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=uqdB3qe5; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3pY5FlPzll9fH;
	Sun, 30 Jun 2024 22:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786772; x=1722378773; bh=8IK+B
	TaSdZkQ3BhysHIJwNCbPfP6WrIPCnh9smlGuRU=; b=uqdB3qe5+vgZmLWP6PKtJ
	r3kg+DHPfPrKfF4gFkyL/FTEGyQibJVaHOORHo8d4ShryaRBF15pTCfeUZzMd4/d
	JnVR8XAL1X0qqUFv1JYZHlBnoNXEipBd9PVlMiFBS39TUbm233JmXrhz86fKNSNU
	gvREjUpW5DHh4r7yv6p0719x120KdV3FeZnKCVWuY/VIUFJwg8oa0DvURcP/g1HZ
	2JVx1jJmX9+rq8VsaHM79wbVS9t/ZO5ACQQRrqE4E4n9sWuGmJOnMCcsnWR3reSK
	IO9Gez3bf4hFD+6lIDqh5iXtsJX/Gq4O8FZLvKvW5VYPY6MCAndqMn5iVAzRwZof
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CnGocwtBD9pr; Sun, 30 Jun 2024 22:32:52 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3pV3vbszll9fB;
	Sun, 30 Jun 2024 22:32:50 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 50/53] cifs: Simplify a create*_workqueue() call
Date: Sun, 30 Jun 2024 15:27:08 -0700
Message-ID: <20240630222904.627462-51-bvanassche@acm.org>
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
 fs/smb/client/smbdirect.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index d74e829de51c..045067fa2a37 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1458,8 +1458,7 @@ static int allocate_caches_and_workqueue(struct smb=
d_connection *info)
 	if (!info->response_mempool)
 		goto out3;
=20
-	scnprintf(name, MAX_NAME_LEN, "smbd_%p", info);
-	info->workqueue =3D create_workqueue(name);
+	info->workqueue =3D create_workqueue2("smbd_%p", info);
 	if (!info->workqueue)
 		goto out4;
=20

