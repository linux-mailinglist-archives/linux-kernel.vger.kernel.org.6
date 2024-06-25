Return-Path: <linux-kernel+bounces-228248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC72915D45
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D591F21817
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4744C73;
	Tue, 25 Jun 2024 03:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="nUvX1+yd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cuNYSaZm"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1050286AE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719285494; cv=none; b=tjBovwgDOJ+hbTXq08LYukgSKpQgAnOHfJmi8MzzyiJoLsmY4/GNnvq2zyAwqH/4LlbvQR6YVfpT+O6kNqlkAN85CC5NwC1lvIBVuYhgUo/5rucmwEg38KkWDLWV9HFyOpgOicUySoJGXG6Xmia0B20Bz0g1uP9iSaNSIbYvuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719285494; c=relaxed/simple;
	bh=rulFZv6l3OXjyLZhtgfaqy7Xutiv2ynApHEnJLbZAGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CxwMVORg9jy9qC3Zj5FfBR/csAMqHLut36tXSe+PRm2OudXB5JnMOhJYVwo5Xc+cQLjqwfbTU204bmOlkw6IlYh+5Yg9OXBqG6mBiW+xkbj5zB6+PIKGRTUpXDtjn+vtK3p5MJ61cX7FgICpEtrBpFesCBiXBRF58Y7i2IvHblQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=nUvX1+yd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cuNYSaZm; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id DE84C1380154;
	Mon, 24 Jun 2024 23:18:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 24 Jun 2024 23:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1719285490; x=1719371890; bh=5bf7LX7qk6
	lej+Pi64v9f03QP8RBHuQgJ20EFqd6G5U=; b=nUvX1+ydIM5DqoVydAak/wN3ca
	rclgYwuTJ3k8miHYSCdNioW3TYPYenqIe2nMP2T5R3Prx/5sYjUTB9qhPagO2h0B
	v5f5Dz3De1iGyEnskekSeqy0D5YgQU7mz68LR3FbvKW56mAEDdjNLLMtgVSb+3XM
	MBHvdn++L0NLVoe1eVqjzvQdCaaW/KcF+todDk9mhcnVkdfibObLT4uwH82yfxi2
	99UWLQnPoBzki1FxLZup/FSanYu8KYy7GQBuo+bNE0LNWDZVdU0HEgWHvAGEJwQF
	y9eBJcvZ4ecR8suWpsX4TQdUSVNYyaegFlxvCognjdLRY55mF+r0cy0+24mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719285490; x=1719371890; bh=5bf7LX7qk6lej+Pi64v9f03QP8RB
	HuQgJ20EFqd6G5U=; b=cuNYSaZmACnf+6iEAOzBQG24ra7j0k+64n1o8S/0WYh+
	jcyBZXRHOr/uuZ0jNuQHVk+fqaJlFOlxbAj+O0zVXRpC+BvZfAJzqVtKNDY85AIe
	Fo6Jnce+A2pq+e4c4pJHOQnzl5JTWcvNkh2GJAyn+j3lw5or/1gai95l6CkRaBaV
	SgGK0CrhnMb+TwGyWPRhoPonGN27k0u21xfraMFXzSTGgJ15RaKvpdL/OiZo5Es2
	IQ0kNyazjIV4MLNurK0ZpgMrqUuLzZZZW+ProsHCscSaJZ7JHWDQNtuliJTdPL9e
	wLmCeGTkGkM+vv2JNRqATPA6Cf8yrB/tVOZbHVWIMA==
X-ME-Sender: <xms:8jZ6Zn2v9ADwjmtdhAi97y4S4JbTN_9nnCNTrW3diPXPkJxTpJoTxg>
    <xme:8jZ6ZmEiC7MykpG1Jov_tBKjHdgyzVhZc1XpHdNhx_uFh0Uvjx4-WdTBf877iIWRw
    zgZvfhLezXTz0t_S00>
X-ME-Received: <xmr:8jZ6Zn4hbQPqlXRGEkGonsxgUL8FV-_tvs0XskoAHXiSSkbSjiSz4bnRHjNJ7i0_II6LWnkP7PdZw88O8BqsoNocvwCpAfD8MWF9HaIBMQ8H6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:8jZ6Zs3imep9gA9zzCRQ7dY4zLXWdPwyiXN954yKXQTEr0CvWWfwIA>
    <xmx:8jZ6ZqGDiTyXZWU8Vs8kVTvGJugZNiv8KJFocw__smC4cy3uxl9P9w>
    <xmx:8jZ6Zt9NIsq9K4xm7_iHKN-ntpQiJw4crqtMcrhsOobF9YNpH4RS5Q>
    <xmx:8jZ6ZnkTw4BJnLIIiTbhOnTR8tjDanOQTN3FcaAM-X3j9xDFHBzwMA>
    <xmx:8jZ6ZvQDi_iWaOOyxavdpzVJrnoID2rBJgf1jswC8LgkxQqfRI92rMU7>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jun 2024 23:18:09 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] firewire: ohci: add support for tracepoints events
Date: Tue, 25 Jun 2024 12:18:04 +0900
Message-ID: <20240625031806.956650-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

1394 OHCI hardware triggers PCI interrupts to notify any events to
software. Current driver for the hardware is programmed by the typical
way to utilize top- and bottom- halves, thus it has a timing gap to handle
the notification in softIRQ (tasklet). The Linux Kernel Tracepoints
framework is enough useful to trace the interaction between 1394 OHCI
hardware and its driver.

This series of changes adds support for tracepoints events to the
driver, and adds an event, 'irqs', so that comparison of the event and
any event in firewire subsystem is helpful to diagnose the timing gap.

Takashi Sakamoto (2):
  firewire: ohci: add support for Linux kernel tracepoints
  firewire: ohci: add tracepoints event for hardIRQ event

 drivers/firewire/ohci.c              |  4 +++
 include/trace/events/firewire.h      |  1 +
 include/trace/events/firewire_ohci.h | 47 ++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 include/trace/events/firewire_ohci.h

-- 
2.43.0


