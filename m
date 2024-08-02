Return-Path: <linux-kernel+bounces-271970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E66945586
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72971C22E3C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE461BF58;
	Fri,  2 Aug 2024 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="z2JVsdop";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jl9J6JjQ"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC310A24
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558973; cv=none; b=Tlub8GCkvK/5S3XGJm24NWz/UinIpMNFFIgbJJ9WQ+zwFqjjkadmn3oxIp42hhbT8BKPcH0FtsRjPmW6WTqzr4ansV5oizCYjfzGMsm6QX6aOb2Eph0Uhd8m91nh34epa2cJz+ndkhwrai4xgKh6N3mIk3e4ZVMASzCb5Md+P9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558973; c=relaxed/simple;
	bh=+KAuYZGdaXJh6F4t4TC3jNEmE54y4IJeYoLtTi5Tp6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XhQ3heGCNxrEa1uXnUWLaxsBzleBJYR/kM6Se4nx5yFYoFzrAiCfLF/paU4W8zrElHgzhSP10P7HgOktjHmJx1xxS8kvtlVH2XYCvHHYn1HqFnxAy2M5INwbz2ppF+kcOxsi8iB6Lx93qUdqCW9FBtm9cZBdG3iOoLED64IwxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=z2JVsdop; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jl9J6JjQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 80DC0114FA9F;
	Thu,  1 Aug 2024 20:36:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Aug 2024 20:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1722558970; x=1722645370; bh=Xob+tHyOMT
	XsAL0OHM/0IJJHBwyznfprn3VWRCkTfDU=; b=z2JVsdopzI4AB/yLrvohE+ZTRk
	Caqj8vDwl7bFR1WrDrA5kkgF64gM0u4eipEt5CBeKpqJDdWPsPQT4yBxDKFr2VMD
	slRJqiEeofFuHzLWGRu3kwQPrOaC8z307pBCq2nPsm/UBb4m/PqCvODIA80bYz5h
	YJ1lymum2cPFHQPDM7lfwENnuK0MWTPo4zj7dj3v9QAT+LQhDSwYSLyUvMctCW0w
	VOY6j2M9jY1UGczxtUvGQmnX6D7yenNTOdJpSKv1FyE2z6s4Eg95eOuVKDu5oOSk
	QOJd3UAyuzsfLGWTGTT5Fe4wB/pPDRrZC0cMxpqokSep9xPzyDpUIp0mZUmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722558970; x=1722645370; bh=Xob+tHyOMTXsAL0OHM/0IJJHBwyz
	nfprn3VWRCkTfDU=; b=jl9J6JjQHmShptgiR1dfGVz1F+IVBzaikZ6tzg/V6QU+
	js29YOs+v/NMJAljuapLKfu5Z7iaJozvyxCGTo7KV/2pN/XEU0xylzQySBC8Is2U
	D1RwlYaUsOxYknMllYIcxVWag3w61m090M5muIuCGL0HIFiHJkHz4VwXYhLGoxRC
	YKwlf3IA1qT9fgeVFOOdetR+fkifmNiPiHHdxC97BuSYjiV8XeigeEz0SS06jIvN
	KJ+3YwXNbZYCut3aSGdy47v78X+TxWkQnHR0/yy6Wa+3+mWHkcn+occA0zgoG+SR
	680r+FV2v1LNR6iPxa/nWOfxNRM7ESVQh9LawcwrQA==
X-ME-Sender: <xms:-imsZi09SMn0LNKxBEUqsu4fU8UZ3k2P6WWsk4ACEe0vwk0uDs1eXg>
    <xme:-imsZlGWKk5SsoWjte2SMq_AEwrEO9ngDaHl_YCCttPJlUthzp_L5ApIUGo6L-cH9
    kqyIom7ZNxOD6P8erw>
X-ME-Received: <xmr:-imsZq4eO1Nw92USaGvMkHyfAu7h17RVz7IBSyFuu9nqFSwV-BV5PPbculJ6E9X8EXWHXIv5IFqSd8XZRIzVZd6YzwR2DH87onOGBRRbAzYy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeelgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevke
    duhfetjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:-imsZj3QB__slypXMXmfBEgWM2mDwuZVz6pdeACL34p2SA6HM7jV3A>
    <xmx:-imsZlE86rV10kXR6hjY9IKGXe5t75n6dpgm4eD4JUi2UjgMZXxUMA>
    <xmx:-imsZs8Qf0Ae-posUAGF72G37YJ-zm3ucxS_i8GQy-0yn9ZbyHBSFA>
    <xmx:-imsZqmzpRIV71gA2lq7VGtMZlgkMuXEpzMKSzJDa_pdn38N4_rrmA>
    <xmx:-imsZqQiKLLgcq_HMj5FW7YJSt983TKiEWxyHsZko1eK12TnXTirw5Ps>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 20:36:09 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] firewire: ohci: add helper functions for data format specific to 1394 OHCI AT/IT DMA
Date: Fri,  2 Aug 2024 09:36:02 +0900
Message-ID: <20240802003606.109402-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In 1394 OHCI specification, the data formats of AT/IT DMA are specific
and different from packert format of IEEE 1394 specification. Current
implementation includes some ad-hoc lines to construct the data, while
it is not so easy to read and understand.

This patchset includes some helper functions to serialize and
deserialize the data. These helper functions are tested by KUnit, and
replace the ad-hoc implementations.

Takashi Sakamoto (4):
  firewire: ohci: add static inline functions to serialize/deserialize
    data of AT DMA
  firewire: ohci: use static inline functions to serialize data of AT
    DMA
  firewire: ohci: add static inline functions to serialize/deserialize
    data of IT DMA
  firewire: ohci: use static inline functions to serialize data of IT
    DMA

 drivers/firewire/ohci-serdes-test.c |  66 +++++++++
 drivers/firewire/ohci.c             |  66 ++++-----
 drivers/firewire/ohci.h             | 199 ++++++++++++++++++++++++++++
 3 files changed, 299 insertions(+), 32 deletions(-)

-- 
2.43.0


