Return-Path: <linux-kernel+bounces-286489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCCF951B97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5316B25DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66841B150E;
	Wed, 14 Aug 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="XFB62eAB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bwyhsEFl"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7D1B012A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641151; cv=none; b=YLPIadhHVUcVvkUxqeapqGP+aRvHDNDu65q1pB0DPzayC5hGQLC8kL+IzCGZdGgTpz+JDCcRJeAvH519dMwJBzTmUJyMJojYlZezamyw4Qid9JMBeJalgswC4B4reangGDp1D2N5fE+IJSttk57T36n7R9PrCOYdqjlutuGrSDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641151; c=relaxed/simple;
	bh=ivJRk012mBJD8+SxgKSBAYqDXl7Pp+8GZdDzU/NNFk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqAeuiwkt3AN3EeSACfkLaWk8PyDE/cE5SKIV5JXoH5BKrgRaid+4hwQs4rghaYdTTVx4sNWDY+yoLXzFh5dIThi/FW3+KNSyTFj9eUI4IA0lrkTixDCSOasyD4yqwKy2Ib49nL6YtCGvLIloF0GbGC69sb9NghDevXkmAu+x4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=XFB62eAB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bwyhsEFl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DD6781148181;
	Wed, 14 Aug 2024 09:12:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 14 Aug 2024 09:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723641148; x=
	1723727548; bh=h51XzvDsQ4hxBQvXZZLP1R6qybew4VWlvslb3JFlNp8=; b=X
	FB62eABSmegj7ptEy834ChE65aYkfTyQnPoQb+ROX/xrAK9PQuAGlxqcv20I6D4l
	BFMD6009ONuxzNus2G0M2v9yWHCnNXvPtbXKRlxVx6h2mS5VVUyzBGAmgr7bpjVV
	hy/59JABhfNfWXbOXGUVE2YdceJZcE0o2wM6zpOZ7FM0KaTiOKIpmkRLzK1jRPT7
	jZI5evv+wauXRNSygfaMp2G9Cq9UcP1/wNMYxFJ30jgrFiir7/7i/o5t3rHFblKZ
	mC327Ucesy9o0DbGX1lv8vmxe5Ci46un7hFxB9AXznlLhyKp8C8QY7MD66zkW6Fy
	Y1jE7hCCQjRKHBtAptrJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723641148; x=
	1723727548; bh=h51XzvDsQ4hxBQvXZZLP1R6qybew4VWlvslb3JFlNp8=; b=b
	wyhsEFlsSNiiOUQowixvOgLYhTvnUnl1jhRG6lKIpaWf4sVNafxm8ITMJuhYDqy1
	EEcjwWBFK2jWhJW2ynkmE9Fyyi555S664Zz+6H8jkFzfpmRbhIT79B7zcsErfW/+
	U98EyA43fGhsR2DBFwVtUi5uCFckzgPB4ETXdnKV+3rNZwpgZ31SxX/CmquaraO9
	HvjbrASy6nu+0MLaKtbDFQo6bLmbHK8eaHk0PsNldUexz6yl/MHKhGXepsw0/KjN
	BC7vaQpvBO6MllWvoqENXzD8BA0lJRR80p1+ZXSg3HqyW5rDk0eP+eboI7bPEQqG
	qLMwAwDXW/fHtBtu1EWfA==
X-ME-Sender: <xms:PK28ZqRnJO3XT21fV45PjZR5c_Y2L7nYOSZZjoiDYMSTQ-laPDwOgw>
    <xme:PK28ZvyUw7jjE9KI5EmUcF8DQz073_C7RB505dQLNv-vL88xXKpndHtiXrnwW_rul
    XJE4-lew08GqRXKS30>
X-ME-Received: <xmr:PK28Zn0v0ToqMHvPIaxFLVsXRJ6P6ZDYO56L6O-VeGKDxgZhSrVCUKpPFHfSWrYB_TuHD0FFZtzpOEfsb3gz7ZCJIjVpNH37diXmZW6IPEJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:PK28ZmDy2m3AlWKk4dddPtrf_-oI2qvgEfpWpPqNcUTqMwn_10ldew>
    <xmx:PK28Zjg3v2hJbwiRfBAt_-phDxJwkzkxYsHTLAXHZZL8KXSl4xAThA>
    <xmx:PK28ZipvjV1MpSPw5Fh-SMogfj2iltwcLiDX5ppg4gCU0wH8oqH_9g>
    <xmx:PK28ZmiibUBWjucVCVg75yc_dIlQh3Y3ztToS3-n6BC1AxmeuzOJ5w>
    <xmx:PK28Zmvz1MNY81yC14OysFT3gSgBL1jLS9bB93zsIJzMt9cGRseXbTX4>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:12:27 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] firewire: ohci: use helper macro for compiler aligned attribute
Date: Wed, 14 Aug 2024 22:12:20 +0900
Message-ID: <20240814131222.69949-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814131222.69949-1-o-takashi@sakamocchi.jp>
References: <20240814131222.69949-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __aligned() macro has been available since v4.19 kernel by a commit
815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually
exclusive").

This commit replaces with the macro.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index e1d24e0ec991..198c96d75155 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -77,7 +77,7 @@ struct descriptor {
 	__le32 branch_address;
 	__le16 res_count;
 	__le16 transfer_status;
-} __attribute__((aligned(16)));
+} __aligned(16);
 
 #define CONTROL_SET(regs)	(regs)
 #define CONTROL_CLEAR(regs)	((regs) + 4)
-- 
2.43.0


