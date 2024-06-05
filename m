Return-Path: <linux-kernel+bounces-203421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DAA8FDADE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BA51F24F57
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38259168C0B;
	Wed,  5 Jun 2024 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="dCkjvKZ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="plSjkLye"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42EB1AAA5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631524; cv=none; b=AB2R3MAbLlRQ2DUoGwEMBYXfNFtqBQQL/UdYNX7zZkZvzmM2Y4mMiwBC6i6RaaDhnYLNk4h1e75CxulN/Xq8w7aD4fBFk9isBvrU2XK3pQeg0VdTmmoUp6SGyk0X7GJC/qyQ9n/5+ZNfTt18r3Nd8qCdTmU3QfqGYD/wfCn5lcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631524; c=relaxed/simple;
	bh=UAHBzCNBzgQHC5AkOhgB0xfu06l9LyKNv/ykFdJYCVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6gOxTINLgWS4ZcmQe2BBqKT+cGP1KbmBrpJks6jK/0cWUxHDayVRNpD7DtbxTdtDot+dwVAw7hYMxN+KpvTdFBTbGVrsK6Fkb8IxP7sqIrQAwLhB3zaSzZb0AUN3wYMbd++tntYXj3WptkSZoEDhfaXkwrvvP17bQUr0GRA2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=dCkjvKZ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=plSjkLye; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id C966F18000BC;
	Wed,  5 Jun 2024 19:52:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Jun 2024 19:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1717631520; x=1717717920; bh=Fiy9hqDbM4
	Tn7rMtDl155r1TRdgLzNnb58yHVTsN+CE=; b=dCkjvKZ+1Z6m6JkV2utfIVRELm
	Qh7ZgCXO/1TVNwrwhe+z0NhyKWxeTmwUD8ELvXGUbWgHGGP5AhjDhmTZLO9AW/hj
	DNWqdBwcM2nS+N19y1dYOaL/FK/NEtnQX8BAZFrAJWZInhbsRmeyrpPexBPOT4lf
	YajDs+cP1U8RxA5B6yv0zASOQOlK3g7T84CEkqhOKJsiF0ftMedEGZOfZ37aBQ0H
	/sgondso1ib5LNaBjpm/TE87xXqWNcSZHdoSGwdiwVp61HAodvgrFbXAmAeIW5JA
	F2W38sRAL99GGAV9qQve0wHdlda1QEojQ9IpP3lUmBLTFSNv7EL9uYxYVkxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717631520; x=1717717920; bh=Fiy9hqDbM4Tn7rMtDl155r1TRdgL
	zNnb58yHVTsN+CE=; b=plSjkLyeM01TFD+QNsQPWHogM1Y44wUqWCLxabwfgOVq
	1vycik6jUDG8MO/TdPE6zAxtGwc4lH4w6sw6DyqXgY/7ChTEQbowMavDxHRg0rU2
	1O2igghBO/BL1p5l2Psl7CAiPCVg7i/eygwZrAg7z8RgU43BA4PNPwYsbSbiVMr7
	tZEJo4g8WnoB/ipIPuFFZSTwYNTRsTTGrrkLJjsLPaRnPTApI9WdhLcVIpGtRv+P
	i/lzXacKhS/4XkDSvFWneF/Se9sDiUKH8yxcNpmO2UoYnd6ksUKlnLnhx1k8kJ9M
	GdOAYYQr2FGfNHtqgM3QrTf16gBR5kZIcRMwxtL2rw==
X-ME-Sender: <xms:IPpgZiF4vFRzvfsVhlglMWHPpw1uoiYTWgIi8cziGjuhLjVniK00-Q>
    <xme:IPpgZjXojgx0mY8gjhhZLqBbAzQq4tQU9p-EiVEUs3UpgH3ZQ70Ui_rigem5PatJk
    FbFYHuYZP7OUc977IM>
X-ME-Received: <xmr:IPpgZsLUtLt1PgnG5ph8JqXpMEJzMPWkZhXNLrRZvgoX2vCQlxyHV-wUPmz8WxNS2TzxnPZNaeMiX6aBdb-KWbShDkqCcOFJrU6Oc5sN5htggA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:IPpgZsFO4AaTzsF0qwLVNZiOXlfm-ZaDwMrX6JZRXFA44ybXuBtsNQ>
    <xmx:IPpgZoWycqg1u5TF-HJeHIgbtT5cyZF0dAIY9vXfG28c5sPeJxUKXw>
    <xmx:IPpgZvMcvC5K75D_CsxeHNJvC2xtwyHA_w3dXpOgMoQ2nUCV9JL9oQ>
    <xmx:IPpgZv02vMSFWxvr0EbJdT9z6jPsyoTl3hfaUqMH2tOLZeOYwRT_XQ>
    <xmx:IPpgZlirrRigZiQM-rEsQlKwmlPPrK7M54vqib1OEezAZr20bl0dnu69>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:51:59 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] firewire: add tracepoints events for self ID sequence
Date: Thu,  6 Jun 2024 08:51:44 +0900
Message-ID: <20240605235155.116468-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In core function, the enumeration of self ID sequences is the first step
to build bus topology for the current generation. Currently, 1394 OHCI
driver has a module option to dump the content of self ID sequence, while
it is implemented by printk. My recent work is going to replace such
logging with tracepoints events, and this series of changes is for the
self ID sequence.

The content of self ID sequence is delivered by a kind of phy packet,
and its serialization and deserialization codes exist in both core function
and 1394 OHCI driver. They include some redundancies, and the series of
changes includes some inline helper functions to replace them.

In the series of changes, some KUnit tests are added to check behaviour
of the enumeration and the helper functions.

Takashi Sakamoto (11):
  firewire: core: add enumerator of self ID sequences and its KUnit test
  firewire: core: add helper function to handle port status from self ID
    sequence and its KUnit test
  firewire: core: minor code refactoring for topology builder
  firewire: ohci: minor code refactoring for self ID logging
  firewire: core: use helper functions for self ID sequence
  firewire: ohci: use helper functions for self ID sequence
  firewire: core: add common inline functions to serialize/deserialize
    self ID packet
  firewire: core: use helper inline functions to deserialize self ID
    packet
  firewire: ohci: use helper inline functions to serialize/deserialize
    self ID packet
  firewire: core: arrangement header inclusion for tracepoints events
  firewire: core: add tracepoints event for self_id_sequence

 drivers/firewire/.kunitconfig                 |   1 +
 drivers/firewire/Kconfig                      |  15 ++
 drivers/firewire/Makefile                     |   1 +
 drivers/firewire/core-topology.c              | 219 ++++++---------
 drivers/firewire/core-trace.c                 |  18 ++
 drivers/firewire/core-transaction.c           |   2 +-
 drivers/firewire/ohci.c                       | 148 ++++++----
 drivers/firewire/packet-header-definitions.h  |   2 +
 drivers/firewire/packet-serdes-test.c         | 255 ++++++++++++++++++
 drivers/firewire/phy-packet-definitions.h     | 247 +++++++++++++++++
 .../firewire/self-id-sequence-helper-test.c   | 152 +++++++++++
 include/trace/events/firewire.h               |  61 ++++-
 12 files changed, 935 insertions(+), 186 deletions(-)
 create mode 100644 drivers/firewire/phy-packet-definitions.h
 create mode 100644 drivers/firewire/self-id-sequence-helper-test.c

-- 
2.43.0


