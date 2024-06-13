Return-Path: <linux-kernel+bounces-213264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D00907347
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795E01C211C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046B143C7A;
	Thu, 13 Jun 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="nr8Heike";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AZU3OYwm"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484EA143C46
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284486; cv=none; b=gbM4QZ/g0Ink2ehjBaCL6KSm1ThVUGefmM+G/05/yoUNs4HRHBPoyLe41f53JBRDuCDkCnXpZGpibm0k3rw4D85eFpvHDUdmVMfU/xySPQxLEdRAK+kJSKrxGnDOpibEowEMP3aU0YeU7by/k6NM89/2geX3mVhSrUgvbZO6JMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284486; c=relaxed/simple;
	bh=fUbjzeTWfb/eILkE1v3hYNjfcAhaVAv9dJj5NuPanpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXXZa+/9B9F5+79UQoP9jQ0uUNpkNDERMjkkanvdTdw35Rks2DHvWvs8TjSkTGk6eh7IEcJN33W/vILkFe+t3sCm071epBoo0YzHrhdIPQyPbAkcoR0ViCBW/R2AL/SEhuMgVKr/ya2cmy1VOhEZkHLsd6KuBV4IaWxIuebdO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=nr8Heike; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AZU3OYwm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 66F0711401D2;
	Thu, 13 Jun 2024 09:14:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2024 09:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1718284484; x=1718370884; bh=P1562d71NK
	6Q3gwSAvpUv5imcbgap8NODNrDu/VOPAc=; b=nr8HeikeoDJplTeazpG0Af3UM8
	/SXrM5StOrgF5+jW6Tt9nR9WQNx7grZzSShB40sXhz8ZXmBZfPbYb6VKtS1AJOin
	dk+zBOxG3qR+1q724OghcaSyagV21kf55uEyimZQUWsK+kxbyEuSrh1nFYyy5GpN
	urGoStEv6kCMG9pe/gO8SFw42wYoBxwKogtmoMYGxMDHVEysaUwGUdEkrzz31v5m
	+XDMn6NDggewaHp6eSZEN2Vxph8QMhlePQH01iJep+EcWl7cGr0aFdKRqSxvYWRb
	2q/2VaSh5kZ7XLbM94n8jAXz3iXV28Kj2/MKQjFH8jr+UvmL0QRmVeXJcV1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718284484; x=1718370884; bh=P1562d71NK6Q3gwSAvpUv5imcbga
	p8NODNrDu/VOPAc=; b=AZU3OYwmXiG2ym7qIZjZTP1n7QzHpklfveFFSya7ABeZ
	UVP3U/OXulooEVkiQJu0OUZ1mVBQGsEKjxXo2CG4/3IUyV6gQQZZEls3KnjoGOTk
	tIF2i8SoGMC4zyatsYxg0mDAymFtVBllkQQuDgCGY2r9S+BmTUOFdfA5eCJixc2S
	0M/J706X1lReQKl4kbdRyjtSSJPzsEU2WNBZD/KfT+Cwa4oZfe9pNq1huMXnWnkT
	wJLUeK9ZJ2t38Is71m41VDH6DoBqa896bKiuLsfgt+/+YPf8oW68T2bX+JIguXc9
	ycP5yxochGD3cc9aQtm+lCHlUYejcaYBo9lChXUKjA==
X-ME-Sender: <xms:xPBqZpHm0dB3YwsefIy7Hp9DgMCdP5L3L1L7Bh03rrW0X-_KgbNZ1Q>
    <xme:xPBqZuWNJxK0AZ7N-nZNIkcqfMavX4K15zZzMeuro5_feuJcuMYWKjIvfepaxWD4B
    oMPjeT2CPG9VqbWQOg>
X-ME-Received: <xmr:xPBqZrKAz6BbmlAAOC5f06xD2JQE4wcUTcZhCq0bI2tZZ2fgRAFjJTIzI2wQluh6wjKW1J6hky3pQ7Oj7MCEPdXWBNqL88UXwxQpalT_lYGNVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:xPBqZvEj9SrK-6F1Hl0lcmSYzrUUUmMGGIuhPQo6xzvRk5fLal7azA>
    <xmx:xPBqZvWXGuWCPiUD7PgudFbOpsKzE1S6A_fHRKbsyu0fwZ8v5mOG1Q>
    <xmx:xPBqZqNtm33v6LeQF9_But69uJJzRk1ehQpsCZtRAjLPMDZvvjqOLw>
    <xmx:xPBqZu2xj_7_hh6fUk95UzR5O00vXV_Z7lUnZXttEVc_JXtCLQVAZA>
    <xmx:xPBqZsjOAusaF6Am4HZbTMUYe8Rj216eZCVKaMjalhyKO-fOr5Y3wIZF>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 09:14:43 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] firewire: store the numeric identifier of card in data structure for tracepoint events
Date: Thu, 13 Jun 2024 22:14:32 +0900
Message-ID: <20240613131440.431766-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In v6.10 kernel, some tracepoints events are added to record
IEEE 1394 asynchronous communication. In the case that multiple 1394 OHCI
controllers are available in Linux system, it is hard to distinguish
the controller used for the communication, since these events have no
member in their data structure to express the used controller. It is a
bit inconvenient to diagnose things.

This series of patches is an attempt to solve the issue. In Linux
FireWire core, the available controllers are maintained in list, and
each of them has its own numeric identifier (=card_index). In this
series, the index value is added to the data structure.

I would like to put the change to v6.10-rc4 (or later) as the part of
fixes if receiving no objections.

Takashi Sakamoto (8):
  firewire: core: record card index in tracepoinrts events derived from
    async_outbound_complete_template
  firewire: core: record card index in tracepoinrts events derived from
    async_outbound_initiate_template
  firewire: core: record card index in tracepoinrts events derived from
    async_inbound_template
  firewire: core: record card index in async_phy_outbound_initiate
    tracepoints event
  firewire: core: record card index in async_phy_outbound_complete
    tracepoints event
  firewire: core: record card index in async_phy_inbound tracepoints
    event
  firewire: core: record card index in tracepoinrts events derived from
    bus_reset_arrange_template
  firewire: core: record card index in bus_reset_handle tracepoints
    event

 drivers/firewire/core-card.c        |   6 +-
 drivers/firewire/core-cdev.c        |   6 +-
 drivers/firewire/core-topology.c    |   2 +-
 drivers/firewire/core-transaction.c |  30 ++++----
 include/trace/events/firewire.h     | 113 +++++++++++++++++-----------
 5 files changed, 92 insertions(+), 65 deletions(-)

-- 
2.43.0


