Return-Path: <linux-kernel+bounces-216074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D713909AFD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 03:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04737B21289
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 01:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F156610B;
	Sun, 16 Jun 2024 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GUgGAYdN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M6xTCjvl"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BCB1C33
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 01:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718500497; cv=none; b=ks7S/C2ComYE/e+dqTEEie/wOaETFsZKNGuf9KvcoqilMRYzOPeVP7oyhngHYMQAlEU/fE6KV3rowNp+BeeZ5mJQCGVCI0S2wif1zn4VPpd24TLd4EhLLpUP0IZ31fKYMaJ0trMOGlrjz2Ndobt3f9DC3Yoh/DZAoLmRzjiI/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718500497; c=relaxed/simple;
	bh=yJ9za7om+bJ//lhGKtd/jONXrcOQG5T+R4DO7qbr6xc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mWPt8rqIYjUK4z03FJQ2Nv9VknzIMFTlGdoWW8w0CElH2lEk3ljYoD9gzjEO+TZPj5NEX70/WwwjUBho66F3YLz4ct7H6pZ4haKK0UMQHTlUuh1hzlX4YiYr3qBU9YMP8M3ryHCaKRlWykacg6NDTaRxT/4FXxOqHYFDXDTNsPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=GUgGAYdN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M6xTCjvl; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6FB5B1140169;
	Sat, 15 Jun 2024 21:14:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 15 Jun 2024 21:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1718500493; x=1718586893; bh=RTCIX5TDU2IEg42AjFI4T
	7JZGGcukFZrFGECup+a9C0=; b=GUgGAYdNCkgt+dLT2xnRYaCwsyc9cq1uAuRRN
	OL0Mvqx6Q0CrguL+BMMuRxqePLWXuk9sZRMojCM28LCUlfYh5wo25tovyxMpl4aK
	5ok8WuxZbxztrahYx5sRSfsHKCDbWoX8kNCl468yg1DkZctj9Qewc3XBNp/mM2Vk
	mXslb15W51AGiOtApQmN5HbMvgbZzeYiciqyRoB6Lq5jWMYxtjvMIWjYSpYDXPF5
	9azZybdmXnE1w23H+Iy9sz9FiB3tfhQNzCNkGIw9RcqLHI5XZ4Qq0n5gweRsIWIa
	KhDXYZ8TYHsr+53mkwT1HL0DBaZqiqndLBfoS3WKYTLHS1YNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1718500493; x=1718586893; bh=RTCIX5TDU2IEg42AjFI4T7JZGGcukFZrFGE
	Cup+a9C0=; b=M6xTCjvlkTN3M6FsQ0GZAWaQ9nY4U6w+6Z5VyHMjVQ8HstWQxLW
	xHd8lzphSEvgX4dlVqwJT7fSmjZZSRZz8bk5w9JPz8XrovTcMIymb5EXMLflKK2R
	2zhLtYntclKX3nJDl8nfrTA2BP5yowChYYY85fEheQBLUVOTE1UfQat7kYrntNtq
	dqYMEZXr6hgqtRHl5pVwsNqwMLf+qIIK7bUlA5I5GvDpxlgZOy8eELGEM1XAchFP
	BVKa8YBDO5GiRav+cARDgd4DRiikZ1d0oTvhkvadMd9my9q5Zw4GpT2FPlnypjfm
	tcV81+LtD7hNwYC8xHTX+2qFiPtLr9fy77Q==
X-ME-Sender: <xms:jTxuZlEnYV7G16v_da-bYdTDtZht2-7-_0xXq18KdZZHljl2OlWYQQ>
    <xme:jTxuZqWfUj1mCPwXO98Oj6IbGP90ryJwJ764-39M48GzDpagM6JBzwfgg-Zg4MrTn
    nWQjeAqudnEOKciJ-g>
X-ME-Received: <xmr:jTxuZnKPGJGzhOlR9OvHghjXPYJsUzJvK5eA2pMsjigpZ8eZdhaVZJP0xKc2wmOv2qr8pf6-lAc0bQFSUgfSuKrGk3mbrQXFuss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:jTxuZrHrUDYH3PpRcovQscI8gaAAzFkQKvfA7d7FYRCC8Mzrc-obGA>
    <xmx:jTxuZrUkpdVmp9ny8Q_Rt_0bnGmeXzzqRko_91cD-vl2fD3X9imWBg>
    <xmx:jTxuZmPbDaSRyGGyTJ4uahqkf7VHSbZV5Ib0CFm8d8nDeWZ3LgUooQ>
    <xmx:jTxuZq3s4tjhGq8iyp1bZx16YfJy8tdVi_L83PBDtNwI9PpMTIpICw>
    <xmx:jTxuZmQqA9lE9Dnm24IP1QXrFIh4Stl5MqQzUobeg0VitXqVtGB21k49>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Jun 2024 21:14:51 -0400 (EDT)
Date: Sun, 16 Jun 2024 10:14:50 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [GIT PULL] firewire fixes for v6.10-rc4
Message-ID: <20240616011450.GA516847@workstation.local>
Mail-Followup-To: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.10-rc4

for you to fetch changes up to 893098b2af3ea12bab2f505aa825662b379df67d:

  firewire: core: record card index in bus_reset_handle tracepoints event (2024-06-15 14:59:26 +0900)

----------------------------------------------------------------
firewire fixes for v6.10-rc4

- Update tracepoints events introduced in v6.10-rc1 so that it includes the
  numeric identifier of host card in which the event happens.

- replace wiki URL with the current website URL in Kconfig

----------------------------------------------------------------
Takashi Sakamoto (9):
      firewire: fix website URL in Kconfig
      firewire: core: record card index in tracepoinrts events derived from async_outbound_complete_template
      firewire: core: record card index in tracepoinrts events derived from async_outbound_initiate_template
      firewire: core: record card index in tracepoinrts events derived from async_inbound_template
      firewire: core: record card index in async_phy_outbound_initiate tracepoints event
      firewire: core: record card index in async_phy_outbound_complete tracepoints event
      firewire: core: record card index in async_phy_inbound tracepoints event
      firewire: core: record card index in tracepoinrts events derived from bus_reset_arrange_template
      firewire: core: record card index in bus_reset_handle tracepoints event

 drivers/firewire/Kconfig            |   2 +-
 drivers/firewire/core-card.c        |   6 +++---
 drivers/firewire/core-cdev.c        |   6 +++---
 drivers/firewire/core-topology.c    |   2 +-
 drivers/firewire/core-transaction.c |  30 ++++++++++++++++--------------
 include/trace/events/firewire.h     | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------
 6 files changed, 93 insertions(+), 66 deletions(-)


Regards

Takashi Sakamoto

