Return-Path: <linux-kernel+bounces-276606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A139495F9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A08B21AFC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552D46434;
	Tue,  6 Aug 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="PeRMjYxT"
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C92BAEF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963415; cv=pass; b=bSK4FtFam4Fl6M2XHTa2+KsLIBKRQHEkh98eRfCaRFU8TBEEWuVbQAxcE8kAk1wnRG4AVApLAH69QHajQdhCN4VWwra+h+8KqHLjLmDAhz78O7nleGCrwJ1Gd8zQuamKrd7D1RXSc0nFONdXCQTrcowkedmcch6lgqsQPykLbYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963415; c=relaxed/simple;
	bh=x2yfkM4+BYxQFYx2HZQKkatL7izKnECBvwUUXDfRJlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdGmeVsF3oicYxeTWPSGLBmPwF8lqni+PmST4uzHspClzkwdYjV1uL7R/JcrlvMw/jhsUIFNN86mIQD9FbAOo75n0iRv5W4ZZhpyjibSel3OovdPCkkNmIZHQn0h0oWwTFr2ayBmoSo+uonzJO2DguQd1EPJo2opGEvznaCTA5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=PeRMjYxT; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6E0684441C;
	Tue,  6 Aug 2024 15:39:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 07F9A44D67;
	Tue,  6 Aug 2024 15:39:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1722958781; a=rsa-sha256;
	cv=none;
	b=BGDrFvG/AKjNKXXhV1ftCrTF+EIRNyUL4+SbTnbF0+9E2nrTOOrWBpEuvyaTX1wW0usV07
	yvInzikI8TgNh6fvZU6pxqiQOhJGI6vnuMkXbJ+0Lfm56FGRCF2tHUYRJV8xLtumDFgvUW
	Art7+HO2KwkCaVlsM3fCn9H2F6Tw9DUNqWXcqRIoWRtolII/GCMXtLOEM3+YsP2A1xeHGE
	6RvyDxRxo8cglZDsk6iCHanPrhaR/rklFN98TDeA/jWJQupi2lKG3C+txQ8aI4oVyETNw5
	cJ9kDIRkNLxs00xGiX2wVOjIh93qJE38fcDMMjj+EzJAqhbZ9WnGv/u9nnlL9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1722958781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=+enCwdwoR/ZF5O3WzPlsRvPL1lbfnfGxbZbKJW8mbW8=;
	b=t7d+l8S/OYGlcE0J6H3RE35kzDprp3YnUocRn3y0B1oMIdc+snMPZadxIAcKa35vPibplz
	GmJgReudqm2Bk4rd/zJY/ChABCRrrsHwGFYBTGamMIdXFnDKVWmw298ajpI3kRgA/Dk1Mg
	m86xwFHxfJG/8yBEVmeMtoSdvSNo/IRkgAi4stM90i+G2HNqJeNoLi+dKyv9/E9+BpQKIL
	u/eiNtrdm5gVjac6SZwEvk/jkiWPOYwCVoyJLOstlDAPQAbp1Wp196cZz51fHIFynJYAA8
	Wk7+8qSGTs3aaMFrv5/9y/P9FU29ydO++Zd5RJPG2KHfpJJvgMkct7o+6aUNEw==
ARC-Authentication-Results: i=1;
	rspamd-6777b474b8-9zgzn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Juvenile-Plucky: 26a85ecc6a3a0565_1722958781298_4277617738
X-MC-Loop-Signature: 1722958781298:1849616613
X-MC-Ingress-Time: 1722958781298
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.110.160 (trex/7.0.2);
	Tue, 06 Aug 2024 15:39:41 +0000
Received: from localhost.localdomain (unknown [172.56.208.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4Wdcth0BK3z6v;
	Tue,  6 Aug 2024 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1722958780;
	bh=+enCwdwoR/ZF5O3WzPlsRvPL1lbfnfGxbZbKJW8mbW8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=PeRMjYxTPCA21Yp9rEfPA/qkelw1Nth/w1aFQKHG77Kfq6iBeBrLpUQqdYhcXV9p9
	 VzGnSr3uwZzE7cAT/Z7XhFS6ZraFTuala0m4d7m3ooohSqU9U71/pnb2c5GABtXsp4
	 Fe/tMN2qtJj62LZJKe/hSI9ZvnZhgOMPmfMJj44odRiptZDHgUKKeFZojugOgRmiIs
	 caZkDP4+NC3Ax9IyvnILsIB4RK9gB6cyM4R8215vl1kISww79itisDBGfEBp4siBt5
	 vdm2t4nxsCYVgUCqH8QxDJtZkQ55UaYDmFJPQvOHvuojLzfbMbNEK7kX4NsuzqDjXE
	 FtAhCJ40MRUAA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org
Cc: mhocko@kernel.org,
	21cnbao@gmail.com,
	herbert@gondor.apana.org.au,
	dave@stgolabs.net,
	linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH] lib/rhashtable: cleanup fallback check in bucket_table_alloc()
Date: Tue,  6 Aug 2024 08:39:27 -0700
Message-ID: <20240806153927.184515-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upon allocation failure, the current check with the nofail bits
is unnecessary, and further stands in the way of discouraging
direct use of __GFP_NOFAIL. Remove this and replace with the
proper way of determining if doing a non-blocking allocation
for the nested table case.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 lib/rhashtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index dbbed19f8fff..6c902639728b 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -189,7 +189,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 
 	size = nbuckets;
 
-	if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
+	if (tbl == NULL && !gfpflags_allow_blocking(gfp)) {
 		tbl = nested_bucket_table_alloc(ht, nbuckets, gfp);
 		nbuckets = 0;
 	}
-- 
2.45.2


