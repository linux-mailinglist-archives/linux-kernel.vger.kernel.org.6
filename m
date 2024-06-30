Return-Path: <linux-kernel+bounces-235358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7F491D472
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182901C2099E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD74127E37;
	Sun, 30 Jun 2024 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qGW/JrMn"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762668624A
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719786603; cv=none; b=Z5AaedMZDZioHcpWeAl2AzNVpgjbPWyCi/vnv8/4+mVIf7rdrvylvB6SnHRQOrPwgcIBX6wCwapAYVRwxzUf9bGt09qDkkrN/YFNm00trJSURsJNiU6qB/+SLcBmEc09Sv6B2TM/vnrJAsGtXG6pPi9u8T6/1esqUXtUDwVl4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719786603; c=relaxed/simple;
	bh=irvSMTCzI3t4tfguws3Nrcz/k9hV9SmulSyBsJFulpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjqTBzqGYe9h8L0+DvLXstkDVGp52GkN1yrINVHd77SmTihZbKI+Sl62yeo89qIkf+vG2K5G0hQCKlAxIQoMVvNFPNQRtiUpSyxLrHPm12cQNqccAV87uTKCw0ZlFpnlp01d8GyhXxJDAUKBMWCxbCnEbNhB7wFh6vEkXnoQZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qGW/JrMn; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WC3lG1qWpzll9f5;
	Sun, 30 Jun 2024 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1719786599; x=1722378600; bh=44MW5
	f10dQ/FgETCP9mDtvWVX+L0nriVCkHaNfe0l5E=; b=qGW/JrMneUGeh0x5KCKTr
	anxgifqRovFpB7LUNZu4H5+9N49Olo+Iqp+DL1VbaC4Hm5lTiVHrO4DxEZyAaBul
	JF7TsRswhOyPCROa218CVd+o1aIxhqNR7KP1tmdM39781vVdqoiS5izNDvJYxvW5
	keEW1NG8VElUBCt69eufHuqzfmQLM0aqnKcZ84l/D8fOc/IIOqxEsd87/8+XxuHU
	a2wLmFzzRMet1PsK2JPUYH2hDyHIdYsAFxyyr7KTonT1cga8sYhsndijDQbN4Yca
	hRi9/WSEj+VTtEnMyNokMt6U6u3ps3ciQjNsJtjNMSUZhctAvCuEuQYj9k68oLJZ
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dFK0kVybXwe9; Sun, 30 Jun 2024 22:29:59 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WC3l82SKjzll9f8;
	Sun, 30 Jun 2024 22:29:56 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Igor Russkikh <irusskikh@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 09/53] net: atlantic: Switch to create*_workqueue2()
Date: Sun, 30 Jun 2024 15:26:27 -0700
Message-ID: <20240630222904.627462-10-bvanassche@acm.org>
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
 drivers/net/ethernet/aquantia/atlantic/aq_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_main.c
index c1d1673c5749..606ec93ba429 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -513,7 +513,7 @@ static int __init aq_ndev_init_module(void)
 {
 	int ret;
=20
-	aq_ndev_wq =3D create_singlethread_workqueue(aq_ndev_driver_name);
+	aq_ndev_wq =3D create_singlethread_workqueue2("%s", aq_ndev_driver_name=
);
 	if (!aq_ndev_wq) {
 		pr_err("Failed to create workqueue\n");
 		return -ENOMEM;

