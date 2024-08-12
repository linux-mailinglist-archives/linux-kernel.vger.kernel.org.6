Return-Path: <linux-kernel+bounces-283922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0759E94FA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17991F22093
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2DD19AA5F;
	Mon, 12 Aug 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="2lRfy2fo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BA5ismDI"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC918A6B0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506737; cv=none; b=kELTzo5kK+QPx+cPgGeCz+/+qzTV91p5M1t7FDnr5cWJk+x+OQDqcp1GaD8K85LzI5Tze62wfeJ/DwmeYXbOBmDYyZSOBA6htNfLaW8xc+TdgoldPXRrkih6wIwFGPy+t8qj+mDEh8jSNBnH3H5ZcCdOcdR90xHMVeLTu7rQ0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506737; c=relaxed/simple;
	bh=OndbeOxmzP/dufq0N5DWULRQV8Qz9Vmmhrwj824vVV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABb00z90VJPdX2YY4CX8Cx9n/RtaMxCgLuMYC7vuL94R7aoY+msM3tnO5Pl6TpgaUu2M8pchredzNlu5T/J994NPzlr+ofARAFde7ThbOTT7P0hpMe2poK8U65W7+nPzf6gVMGr1dX9ge2suJy9PWSaUypRU+H/Pb4D7jXEPXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=2lRfy2fo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BA5ismDI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id B0DC9138CCDE;
	Mon, 12 Aug 2024 19:52:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 12 Aug 2024 19:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723506734; x=
	1723593134; bh=hYAgmHW3sPNyEffqeWqwPUE6kfVNpSaXPU2TRDZTgeo=; b=2
	lRfy2fo6ZI9gH/XB+QRhqZeuApk/XSjQLH0YGD1S47JXPWnjH3gPLYB9/4f8DCWs
	IyV+3KLbsnNu1oa4oDoxdt47gBQgQoNZi7qialTNb009k7eqlSgIWKH5p2gPJFSG
	ebaMbL86MaB9vKn2hLIhiHPtlY+T/OEqM3ZxPxXgqS46PsLSd4Dk6Geh+JP2FLP1
	hHoajiGFWaR2QOMMtoz6oZ379SCTdjSem+j06OYRM5DR/bkb/QAbMi3MxM43r/bb
	K1crR7AWlS0KXzerdPc5O3UN3bIH/Z7pY1zxTkQwT0ButTaaaEdE3mUBf+6EdI1E
	Z0hu04UCm0mmENd/nwOkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723506734; x=
	1723593134; bh=hYAgmHW3sPNyEffqeWqwPUE6kfVNpSaXPU2TRDZTgeo=; b=B
	A5ismDIxYid2WnHTNdIifFtgiXpHKAbXXwhY+8BUBM7H6BuC732qE9dIPW96sTT0
	HdlLlWDpkON+Esc/SR/mgNSqeyweuueGX0zvfPB3UHWljABXglyJBUlGT4ZMaXZn
	Pox9pfkoFz6AGMkAY5Xj/TRlx9jgyVfAzCtE9EZLkYVUuynrDoaVS+rCIOZcWJwy
	2ZDXgSXHTnQXg7KJ8XJM5ni8yIG676rG0ZzUWca7ZzZvze4i6JJsv756+LVESoX5
	RcbSVcfGSDtag0T/mC1cW34VxwmFB2waHxUeJpdagSyO60Vo1rrz7Ujd7lPr7yrI
	kr5YWVYM920k6TpPEUesA==
X-ME-Sender: <xms:LqC6Zv87FejEbnDfJnKqZI-RzKCTSDh8gbZuJk5uvI1usyJbsJpdHw>
    <xme:LqC6ZrvB-50HSTPjjieB6rn6Gi0srgnuAy82XpYmNSuk6zUTIWVMa8kAu3yP1W0DJ
    a4ppbyjuGl_YNFLGHg>
X-ME-Received: <xmr:LqC6ZtDWAy6vgOQBQs2HfZGiLHzYJxrK0f7C2xkDjPyPsPow6cuDSZIRKCfjYoY9aRfNxchyCdATw3yURFnwZZfja4gsfB_d8Dm0a157sbpBjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpedvjefgjeeuvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdff
    kedvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LqC6ZrfCRLcH--WW-nmMgDcAhZSd2fNxOFCBP8CHmFHt-tJyTWay3w>
    <xmx:LqC6ZkMWLz7BmPHoBOK6O1lAK0RyW1qy4eAlXZEWBw7ZBuJFirxNYw>
    <xmx:LqC6ZtlIt-hm9ZUoKX1nz9as9cCKupwGEQp_JHqZT_oQK5SC0eEehw>
    <xmx:LqC6ZuuLJor9dc84KUiM2G4Ozpn5-g1aWFDSVRWFO3qS4gQP4muesA>
    <xmx:LqC6ZtaIX9Tca7u8VXCU5YvMT4OB-vGE6KuvXenpUGGKhrObn4mA0lNn>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 19:52:13 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] firewire: core: minor code refactoring to release client resource
Date: Tue, 13 Aug 2024 08:52:06 +0900
Message-ID: <20240812235210.28458-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812235210.28458-1-o-takashi@sakamocchi.jp>
References: <20240812235210.28458-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation checks and validates the result to find resource
entry two times. It is redundant.

This commit refactors the redundancy.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index c211bb19c94e..81fdb2be9063 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -512,15 +512,14 @@ static int release_client_resource(struct client *client, u32 handle,
 
 	scoped_guard(spinlock_irq, &client->lock) {
 		if (client->in_shutdown)
-			resource = NULL;
-		else
-			resource = idr_find(&client->resource_idr, handle);
-		if (resource && resource->release == release)
-			idr_remove(&client->resource_idr, handle);
-	}
+			return -EINVAL;
 
-	if (!(resource && resource->release == release))
-		return -EINVAL;
+		resource = idr_find(&client->resource_idr, handle);
+		if (!resource || resource->release != release)
+			return -EINVAL;
+
+		idr_remove(&client->resource_idr, handle);
+	}
 
 	if (return_resource)
 		*return_resource = resource;
-- 
2.43.0


