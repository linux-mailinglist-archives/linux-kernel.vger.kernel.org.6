Return-Path: <linux-kernel+bounces-273839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84180946EC9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57351C20F70
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F12B38DD3;
	Sun,  4 Aug 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="02Ek8Zid";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCNlZro6"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712314277
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776553; cv=none; b=hV5wsCeiz7OkBSN3t/HG4kA0Nu+5dcM8HZhv0ZE0qE1dmveEqGCAvxEy5NZXjW1RxUNkZYn9pzK42tWnxhZD4NGSkbGA57+fjedPf0aLOxrWXVOaG7+JQV5d/HLXvAivVDo2EmMKuwjnPIKAeTzsmmmVvGJGLXjq3v/iFfOCvF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776553; c=relaxed/simple;
	bh=IHrHcjPhnWaQ0q3hG6fa+KL43ySJMpHUIDdUBZ9LZ80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBM+dyHxA9fa2i5h5IPz1TRjwcipwDr49gqSy234NLk0+oCsLeqypYHUwummgzQOXlrMMQp4c24x1jMl3IwW/i03dA+0Xn+fm0+LIgYrZGQs2DpC9O6gFESp+TpWcp9dghoX1qmyr6BpWnSt6dHTEREe7zSqtJ0MWmMQNo/cnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=02Ek8Zid; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCNlZro6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 917A31148189;
	Sun,  4 Aug 2024 09:02:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 04 Aug 2024 09:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1722776549; x=1722862949; bh=bkRnP/9kkn
	9kcWDlcH0PhqD14WR0C3W4aSnKlWJpfEI=; b=02Ek8ZidMf1hjdWVCZCTTQghgb
	4uH38l6k50yxGsjzr/AMTqqIuR909CML1NZbBFTO7BzZVmcx71zZe3GmI28Zxhwr
	WMu9Sh9N5s+UjZKeBVs6/EDLlv05wrFvbZ4G2SwnbGUhHl/NLbQZypyY6ymvsZax
	ilR7zXZ4BI+AZ1uSOrRghimNUQCVHKwiMZPnrZDK8/4xocw4OLNi163InLEJ0TJh
	VjaW0YJ1fjUPKbwMafinvnDK3kXkcc0GiT0XAlf5O4Oo1l0H90AHZdmzptGIZ8rJ
	Jzpp2PaNO4oIC6KtxdiDSQrhZn+6n6Mx2MmL0LRkeibL9idqyDOiGAiadXTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722776549; x=1722862949; bh=bkRnP/9kkn9kcWDlcH0PhqD14WR0
	C3W4aSnKlWJpfEI=; b=XCNlZro6IB94zItBNYf0j7SIl4DIfn+nE0MB8s/SG86c
	mEeI9irxTHZaq1QqHlqSHX87Ftmm4NnbTfHjDMQ2GdTNVtJ8ljsnq9Uj3yuaXyK4
	LkUbB7kkIU8/cuZ6OQbBRJmcCX+JX5AtC87hPG+fSGpGRvY3aOythMXbzaHn5MkO
	pNMGpUPVo1V0tJUsdlsYiXEo1ODyY5tJSWqhQMZr08/BWbu2/57As8EnuZzz65SZ
	h5T157xRAoR4u4tN8zKGp3L2HR+pX5k85ouRgSYbSzDxQIAKlI3RGoqxgZKLvAwd
	V+Mz72PKBXXobQyNi0lAZDQSAXyzR30dOcYmlyxcvA==
X-ME-Sender: <xms:5XuvZuAT9WlYRyoUjVvqvCNyLVZiNFcv8LfhO3t8Krl6-O0d9x6V_Q>
    <xme:5XuvZojSqidPDEFkcgO6gdaGkqDOmKcVxJwKmjOMNi6rPb0LAWaNLkaWzjYTuSRHd
    1k37gi0KjeAUbFGo2s>
X-ME-Received: <xmr:5XuvZhksolkAS0r9PlIyadQJmoEI204vZHtTlWOuB9EFaZ2iOScJYk-yl-5ElPnp7mskQGD3y0XNdKPsS3NJXkABkrMeTpFh5LJj_JezOmvcgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevke
    duhfetjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:5XuvZsyomnc3Tr3HsYkSLQSxHb6Eq4ylpNKGGMEsVnm2pfonkzYyZw>
    <xmx:5XuvZjTr1KCOB5n79zq0KdEYdjQ-Vwdm6I7w731Qa79SAwLzBRxPiA>
    <xmx:5XuvZnZ5zzKDg0UmHlxS9r6AC-UZIYHDHBmHEqD6olLaCA9nzmYC1Q>
    <xmx:5XuvZsRM3MiBmynSYnqledS6oAiw45wycjhr2aCQuQ8eezfmk_vhgA>
    <xmx:5XuvZueq1gCeA2dvNGWe9X-4j0HSWd9t-tPtluGGbPj7_Fi0-gZEluvZ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 09:02:28 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] firewire: core/ohci: use guard macro for any type of lock primitives
Date: Sun,  4 Aug 2024 22:02:07 +0900
Message-ID: <20240804130225.243496-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The guard macro was firstly introduced in v6.5 kernel, and already
available for spin_lock, mutex, RCU, and R/W semaphore. It is useful to
ensure releasing lock in block.

This patchset includes changes to replace lock/release codes with the guard
macro.

Takashi Sakamoto (17):
  firewire: core: use guard macro to maintain static packet data for phy
    configuration
  firewire: core: use guard macro to maintain the list of card
  firewire: core: use guard macro to maintain the list of cdev clients
  firewire: ohci: use guard macro to serialize accesses to phy registers
  firewire: core: use guard macro to maintain RCU scope for transaction
    address handler
  firewire: core: use guard macro to access to IDR for fw_device
  firewire: core: use guard macro to maintain the list of address
    handler for transaction
  firewire: core: use guard macro to disable local IRQ
  firewire: core: use guard macro to maintain list of events for
    userspace clients
  firewire: core: use guard macro to maintain IDR of isochronous
    resources for userspace clients
  firewire: core: use guard macro to maintain isochronous context for
    userspace client
  firewire: core: use guard macro to maintain list of receivers for phy
    configuration packets
  firewire: core: use guard macro to maintain list of asynchronous
    transaction
  firewire: core: use guard macro to maintain properties of fw_card
  firewire: ohci: use guard macro to maintain bus time
  firewire: ohci: use guard macro to maintain image of configuration ROM
  firewire: ohci: use guard macro to serialize operations for
    isochronous contexts

 drivers/firewire/core-card.c        |  60 ++---
 drivers/firewire/core-cdev.c        | 252 ++++++++----------
 drivers/firewire/core-device.c      |  83 +++---
 drivers/firewire/core-iso.c         |   5 +-
 drivers/firewire/core-topology.c    |   5 +-
 drivers/firewire/core-transaction.c | 146 +++++------
 drivers/firewire/ohci.c             | 381 ++++++++++++----------------
 7 files changed, 394 insertions(+), 538 deletions(-)

-- 
2.43.0


