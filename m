Return-Path: <linux-kernel+bounces-257882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C7A93800C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F376B218AC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2697636120;
	Sat, 20 Jul 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="HiBpTs/R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jPPLms5D"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16F4BE6F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721465259; cv=none; b=EST8p8cIxAhFJwNYKbQDDffd5w1iltan2TWKD0kZCE/yqRFJa/vkFYIfVDZGihkdCjEE0gp95Z6RNBqtUPOZmxejuGOV7eS7aqEw0c/IsLbmhFkxGznhuh9vbdRPzhOxErznUCVxNp/S9euZqfYeXKX5L+y622NXrxImavSYHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721465259; c=relaxed/simple;
	bh=3Zb/myzLpOkNLi6nu7HCGQ90rVAbJJd+tvocrJPveas=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QIKAztFALhSONOAuwC1jm+7HqzwIf3yQ6ljB+dQEVsIwu1E0dt0grhnB38zmZrizNcVa10RaFEpcmwWomtsxjaGYuPD5IxI/TYPurv4DTchDkjYhPCLXvQOiBPtdSxFaCqSxy9Zdd5tHE7vIsyUdgFTW+pTJHfZvKxd6lGqKGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=HiBpTs/R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jPPLms5D; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E1DEC11402F9;
	Sat, 20 Jul 2024 04:47:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 20 Jul 2024 04:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1721465255; x=1721551655; bh=/Gv9A8bJd9k9fQW2Ee25X
	oeDqaXZc1JlgKbWNYLaOWE=; b=HiBpTs/RC0QsEUG8JN5MXlcSFG6or67WGrLKN
	3vNo/efnTi3jqnpFY4AYU4yUwWXs4Jay+y2P7prQR86j2qdOyP7lzoETJakcsFRf
	3bLgv6KGuTcC7vz1BVn7dX2h/QXdfs/YmOu3OGmHtahey3Uybx0LRfOl4WYww3JE
	YdUwOOFr7GBRdAdG01CLQ4ZNvXLzc4jgQX4OaG61pZ5bNdhxQGgR6w8LAVouuiSV
	dtoafhNb/p7wDD0gI368u7yeIx+m9kNxXYv09fnNeOVTuwLNXNNJP68NxUG25cXN
	zH6umU25Pj/oTlKa1F8oy6KmW1jSvrm7Y/RVYnRcZsdjlOW8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1721465255; x=1721551655; bh=/Gv9A8bJd9k9fQW2Ee25XoeDqaXZc1JlgKb
	WNYLaOWE=; b=jPPLms5DCb1tZckl9UyVB8KHKVozXJWuGaUjq/O3vyiLsTchoCh
	MtAtM29gKCPeopvzx984vRQ8mJaybfrtQRwY45tg7ZwdV6eWNNEfDx2qgMkwAcQh
	f3Y9tliQ7/RPI6HEkLtsQc8uW4zgSSqndBbEKHuBrtoanOcl7RnDXALhCTsFmDKr
	m43bAdPjyF6kWZZF3hDz9ImURlOf04h32S3TyVB17l9m3/Iqum9rfabqNVcFIUXc
	w2pWdJzpbuY8uzs23Iuxi947GAA7aIwLRXFAZoHPdRmaIK5Cobhz0E7xT5BarJjH
	ONc+WbFgcm8viGO37qcAMA3r6x0qBgyy+mA==
X-ME-Sender: <xms:p3mbZiU0mTEzHHBFVNyBRs8JaZd3dzOjYiGRsYdkFcvpnhNGRvWEWg>
    <xme:p3mbZumNJjOW5_ejUsR3VYiLs4BLaEl-0Gb8ELsP2aavuQVikdOotiHhI19r9DwoO
    PeuwtBxJdbuan4fg2o>
X-ME-Received: <xmr:p3mbZmYaFkOjy5tZRVEMZObumjR5_a_HhfnYrwNvXw5aalHmpyKAU9mN4Qu_9UJvnj5aZk4qXqXQyzT4BWkE5XvZhmJnbB1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheefgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteefieetfeevge
    dvgfegffehteeljeekkeelueegfffftdfgtdetteekvedvvdfgnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:p3mbZpVNDHvhltJ_9T7jcQqYaj5kfNQ0qNcNlWRQV3UyXcbrWe22IQ>
    <xmx:p3mbZsmqkGmID3mpDw5LlUydjQJYxJPJlsHLQXsDV2uXrzRdPfPPXA>
    <xmx:p3mbZufpOyxDfPerRcetPTIuQ9rTIezhWiGcBnykVbitJHlsRZ_nTw>
    <xmx:p3mbZuGyOQ-RJqR7Ss7VjsMCGAApbxVgauz54jNBGbBRJ44QHUxP6Q>
    <xmx:p3mbZmgFCxfHUGC8gMTsUDwGjXsNNAPzl5oVKg4DU_ffaLdaED7IRcq4>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jul 2024 04:47:34 -0400 (EDT)
Date: Sat, 20 Jul 2024 17:47:30 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [GIT PULL] firewire updates for v6.11
Message-ID: <20240720084730.GA59546@workstation.local>
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

Please pull FireWire subsystem updates for v6.11.

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.11

for you to fetch changes up to 06dcc4c9baa9e92896f00d02ffa760c0988b4371:

  firewire: core: move copy_port_status() helper function to TP_fast_assign() block (2024-07-12 14:34:12 +0900)

----------------------------------------------------------------
firewire updates for v6.11

There are many line changes for FireWire subsystem, while there is no
functional change for practical use. The most of changes are for code
refactoring, some KUnit tests to added helper functions, and new
tracepoints events for both the core functions and 1394 OHCI driver.

The tracepoints events now cover the verbose logging enabled by debug
parameter of firewire-ohci kernel module. The parameter would be removed
in any future timing, thus it is now deprecated.

----------------------------------------------------------------
Colin Ian King (1):
      firewire: core: Fix spelling mistakes in tracepoint messages

Takashi Sakamoto (31):
      firewire: core: add enumerator of self ID sequences and its KUnit test
      firewire: core: add helper function to handle port status from self ID sequence and its KUnit test
      firewire: core: minor code refactoring for topology builder
      firewire: ohci: minor code refactoring for self ID logging
      firewire: core: use helper functions for self ID sequence
      firewire: ohci: use helper functions for self ID sequence
      firewire: core: add common inline functions to serialize/deserialize self ID packet
      firewire: core: use helper inline functions to deserialize self ID packet
      firewire: ohci: use helper inline functions to serialize/deserialize self ID packet
      firewire: core: arrangement header inclusion for tracepoints events
      firewire: core: add tracepoints event for self_id_sequence
      firewire: core: add tests for serialization/deserialization of phy config packet
      firewire: core: use inline helper functions to serialize phy config packet
      firewire: core: record card index in tracepoints event for self ID sequence
      firewire: core: undefine macros after use in tracepoints events
      firewire: core: add tracepoints events for allocation/deallocation of isochronous context
      firewire: core: add tracepoints events for setting channels of multichannel context
      firewire: core: add tracepoints events for starting/stopping of isochronous context
      firewire: core: add tracepoints events for flushing of isochronous context
      firewire: core: add tracepoints events for flushing completions of isochronous context
      firewire: core: add tracepoints events for queueing packets of isochronous context
      firewire: core: add tracepoints events for completions of packets in isochronous context
      firewire: ohci: add support for Linux kernel tracepoints
      firewire: ohci: add tracepoints event for hardIRQ event
      firewire: ohci: use common macro to interpret be32 data in le32 buffer
      firewire: ohci: use static function to handle endian issue on PowerPC platform
      firewire: ohci: add static inline functions to deserialize for Self-ID DMA operation
      firewire: ohci: use inline functions to operate data of self-ID DMA
      firewire: ohci: add tracepoints event for data of Self-ID DMA
      Revert "firewire: ohci: use common macro to interpret be32 data in le32 buffer"
      firewire: core: move copy_port_status() helper function to TP_fast_assign() block

 drivers/firewire/.kunitconfig                   |   2 +
 drivers/firewire/Kconfig                        |  31 +++++++++++
 drivers/firewire/Makefile                       |   2 +
 drivers/firewire/core-iso.c                     |  32 +++++++++++
 drivers/firewire/core-topology.c                | 219 +++++++++++++++++++++++++++++----------------------------------------------
 drivers/firewire/core-trace.c                   |  11 ++++
 drivers/firewire/core-transaction.c             |  24 ++++-----
 drivers/firewire/ohci-serdes-test.c             |  56 ++++++++++++++++++++
 drivers/firewire/ohci.c                         | 237 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------
 drivers/firewire/ohci.h                         |  43 ++++++++++++++-
 drivers/firewire/packet-header-definitions.h    |   2 +
 drivers/firewire/packet-serdes-test.c           | 334 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firewire/phy-packet-definitions.h       | 302 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firewire/self-id-sequence-helper-test.c | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/trace/events/firewire.h                 | 541 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/trace/events/firewire_ohci.h            | 101 +++++++++++++++++++++++++++++++++++
 16 files changed, 1867 insertions(+), 222 deletions(-)
 create mode 100644 drivers/firewire/ohci-serdes-test.c
 create mode 100644 drivers/firewire/phy-packet-definitions.h
 create mode 100644 drivers/firewire/self-id-sequence-helper-test.c
 create mode 100644 include/trace/events/firewire_ohci.h


Regards

Takashi Sakamoto

