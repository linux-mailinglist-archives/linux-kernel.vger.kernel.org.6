Return-Path: <linux-kernel+bounces-265862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 300D493F6F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F59F1C21B58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28DB15359A;
	Mon, 29 Jul 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="jwy6Zcqk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ac0YGOqZ"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705598005C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260799; cv=none; b=YH3agwNXSwsjDrO8SWqMrOpTCv8yxPLAn3cuVjqNFVAR/UKKfTgZj5XNH5/Wf6z1wOYTsy789LIXjDXhgNxhe3VG4+MMam7dZFtGYtKG4yN0e8Ca6k5fwYYpJ4hgZDWmb5eDtmU8kU4hN4tzn1k1LqA0SHQIU7mDmwwBiSB/4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260799; c=relaxed/simple;
	bh=f4BUtph53GmxZRWGC9NQTLWpKscQv+SG6WluY1ofuCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQR3MWTW5vx9H7bVDLK6dnuYkug3GbzVZjZKFc98DfjgDkHJ/Y6Id+qI5WLx+q5ilmdLn07A+wRoUCr47j9phTLv2xvSf88Lt69+4uxGW8rFdIF984D3PjPV92DuN1pz+raf5W3jNz3AufVdA12Eh0vO2Ko7pOglBkyVKbaP2pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=jwy6Zcqk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ac0YGOqZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4C0F71380116;
	Mon, 29 Jul 2024 09:46:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Jul 2024 09:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1722260796; x=1722347196; bh=rozWhg0J1W
	WVKDKNRV8YgKBVCNPoo9SXVgPoDqNdCao=; b=jwy6Zcqk8R1AQgYwp7OYIGJPHW
	naKyLzbz0N69Zbni1Gg0htolgcn53HJR9jX4koE9tobhlj7wEl326IX0+FonS5q1
	CUjjiUQyqtmhw0G2Xbl4iG41Jbtp9PKV8E8QCzTb92KF0EquAvzUgLANOWooRdM8
	jNoo1HGN1m3UnwwYuCnxH2hYmiP95+5lv3urMXb/dKodw34ttxxTQCUSJjID6Bxe
	Eltkj4n8fED0ogiiWEoJ9HVHFUJ2FPpzd3tZkq0ZHr+GPyAK4F4E8u2tSZodWYse
	a0iGSc9Cyx7ro/yycWl0eCdhv4An3d8vMfS/Vf9m9ThNqk0iF2g7+PH8TgsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722260796; x=1722347196; bh=rozWhg0J1WWVKDKNRV8YgKBVCNPo
	o9SXVgPoDqNdCao=; b=ac0YGOqZvZZ3l0vcAoQLZy2uOVk/2fqgoYCi4n7GpqjS
	YUDNe3X1GYTFpGF9Lv8KDiPqV2+czkyuyUvjKEsfa4tJ1w+SRAnsMR/nAo+oVtaH
	mwUaakC0jkfWmO4Ym0OAhGUjduiHkWrc5lFijZ+V2OAoGk6fQ9VjGlrw1bXJYQSl
	7/to0Jfmeq5BziIhmFZk/vYQZnz8JvqwiFdFSgwYk0moRo1Yz2cjjU2cHNr3c0S0
	LTx9cGij/3xHdJbpSd8UZoH98dt/65AXDp9OgNZHzZE6VpgMfgW1Mvh8ZHkBERs6
	AFSigCksaeC1MMzp56C6W52FJOowl8bj/aYxUINhyw==
X-ME-Sender: <xms:PJ2nZlviqi8Fel8BgHART9srxwK_QAVjizW_pXCyST4n-sk24asddw>
    <xme:PJ2nZuc--rBfxK2RDKwiKvc1BQd_nU4KSwRGbDBWUT1TaQQoisBx5UUK6v9HCIpEE
    FBA0IYjc8kFSsbxgjY>
X-ME-Received: <xmr:PJ2nZoyqZHVNUrziRmX75XrQw7sN5qFJgpmo7KXCy4MvA1Pw9A0Ve5PRz_viPz-QC0EX6eqIw_snRu8c1h1DYO7liA2nqGksWG2V_IX7qkHYRMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevke
    duhfetjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:PJ2nZsPRCVOZWKDT5GDVID9NzyL8PQqyXmOG6GiPspvljvw5o0EMTA>
    <xmx:PJ2nZl9Gq-MRALA9V5uu6lZQoCFkTdnxGL0NWCQd7OEhnhhQ6vYMKQ>
    <xmx:PJ2nZsXsoJPo8TLzynPnbZM9NiAxZmcQFU0uXVlVKDT4kwMEuytbWw>
    <xmx:PJ2nZmdfd_7APBBd5yB9Wyogy_g-mmGE85RWJwDCswjG4-jcFRU3lQ>
    <xmx:PJ2nZnIgT6OdMfLfhzw1fKSpQtIDFDykoNFZjqs4x04ThbYDIhVREQW0>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 09:46:34 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] firewire: minor code refactoring for link internal data
Date: Mon, 29 Jul 2024 22:46:28 +0900
Message-ID: <20240729134631.127189-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The current implementation of both core functions and 1394 OHCI driver has
some points that need to be refactored regarding the handling of link-
internal data.

This patchset is for the purpose.

Takashi Sakamoto (3):
  firewire: ohci: use TCODE_LINK_INTERNAL consistently
  firewire: ohci: minor code refactoring to localize text table
  firewire: core: use common helper function to serialize phy
    configuration packet

 drivers/firewire/core-cdev.c        |  4 +++-
 drivers/firewire/core-transaction.c |  2 +-
 drivers/firewire/ohci.c             | 37 +++++++++++++++++------------
 drivers/firewire/ohci.h             |  1 -
 4 files changed, 26 insertions(+), 18 deletions(-)

-- 
2.43.0


