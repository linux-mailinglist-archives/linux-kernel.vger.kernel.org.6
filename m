Return-Path: <linux-kernel+bounces-178540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AF98C4F32
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342221C20E76
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94CD13D28C;
	Tue, 14 May 2024 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="bxMfk41b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyWZne+p"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB45CDF0
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681066; cv=none; b=CEBuI3RpggW7q4DDwDpRXcDE0ewU+y/84YMxnWWYGHZqoMgAaGzHuylQ1CqAaNJ1WhxuqzL3u79CKsMs4ImRWuOjxVOw1z0rFNFTkRj99U+EMhTdF/AufcWtUt4BI+KAU3PXCTmwjK4oB5Ije0RKLYwIurmbwqw6KTdRVizqr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681066; c=relaxed/simple;
	bh=6OJIOyMTfIXgBoq0fS6wbecGUkAEW6z+MnJbYsQDwWA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lp7Vxn/2Ylr3ygB5SQP6L+DyIXP3IPK0avnEbS6NezKL3vCy1HN8jwomkYdEzw0k5GVgxXQmKDGd1rN4m8kpbInnV1U23ptbM5AWJilnZL40hjhC3wkRwauii5oFYKT9yENs4hGD7E74Z2q36OJ77LHic5H7ORUsONDXGUPWjs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=bxMfk41b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dyWZne+p; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D2C8A1140183;
	Tue, 14 May 2024 06:04:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 14 May 2024 06:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1715681062; x=1715767462; bh=BVpwueAcvJAsCC2GVmhfS
	yVrFXijg21zaPEOzVgT+Pk=; b=bxMfk41bTjA8GQ/X4aLL9gKfd71TkusavooNK
	DaajTMkPECc048g8xqaKkwqDOMqxJ9xC19Y7Sra+hzPnlAXwVwMcLcN+/eNElknJ
	vkv08yfWxmdAG2VLQeD6L97n3BZMy0LvbYRbxDATmNsP6y+4H96Uo7lUHZakLY4a
	xni8IslkUonEWfogpydPlQa0k+44YUS/fhvadxAZ/R4OAF1f3TkoDfX5nVHTXyf5
	jKHd4bgaX7mN1dLki764JGfiJGcLyK5pFQw6ItIfha0+7RfEhTWdn0zUPXpzRTeN
	X7jZ8BVl7YLPrJOEVkgAsg5ci2F4HdRs/tci6oXGbDEopuV5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1715681062; x=1715767462; bh=BVpwueAcvJAsCC2GVmhfSyVrFXijg21zaPE
	OzVgT+Pk=; b=dyWZne+pFA0d8/PaQ14J+HpZ4LcWmxCQchZfXWsigEPT/kWh9Pb
	WwsWAyAVYQgdXHK9C157SebIDNPGT5w4g7Nwtc7zTkFXZZ5c1wSmOquHLJWczomD
	us14kw7SRB9jZRnWg32CviWtR3Abb4p05d8zuySNbWVnr/pqUAYRuM+9YjAJEvxa
	CqCGz45W77RrEIplDklwU0Di7iJHFj+tydmAwWZfOmmglAymcktc7Qm6XDb2y09X
	lHUKl0GuPhMYwD1QDhAJ6vmC19bNiHUfdYmSHO8GnxFLQzux6USEMxMTv6jwObG4
	vd/FPSIcfqudKwjGloMDbG1DnVsQmHZ+4pg==
X-ME-Sender: <xms:JjdDZmr8GJsVby9sK-lHkWQBo8Fp86B_bwjJALLlJK__49JnAwWVtg>
    <xme:JjdDZkrRGGIi3s3bLet7bBcFEUNjXdWA5SdnajVfx36lWw-T1NhEsSG_0MjsoTXgA
    JzPTudCIuCauvgWgHg>
X-ME-Received: <xmr:JjdDZrPwMSTn_HTGf3bjz6LDeW-8o_gYjROEQ2-KLrmIV8JeD0VduZvzwASUP5JbrKemPLk2MWGSMYQ-cmt3FvgfcjaUwiBasdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegiedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:JjdDZl66a6tjqgQK3pq-opOznNYfAFF8N7LJO8_YERruYzsOrG7h2g>
    <xmx:JjdDZl6SOlUnrskQtIWWDZNBH9qUObS5juM8vfluIvYznslevz48EQ>
    <xmx:JjdDZlhi_9zfIT7AGcVfac1Gt5DfbRU2nxJ-iYVnnVMgh5ntqgs9xA>
    <xmx:JjdDZv6A1fa4eQSE78wzUHh0bGwIUZSKKwiU0cGk40oNZOuzyUFzPA>
    <xmx:JjdDZvm6YN_svNnIqEdOezVeAHyVis_I1hD4rbm418UCbmh4nkZNnUGi>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 06:04:21 -0400 (EDT)
Date: Tue, 14 May 2024 19:04:18 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [GIT PULL] firewire updates for v6.10
Message-ID: <20240514100418.GA198864@workstation.local>
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

Please pull the updates for firewire subsystem to your tree.

The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.10

for you to fetch changes up to 21151fd8f0ea5dcff27e8db25b65bf892d408bdc:

  firewire: obsolete usage of *-objs in Makefile for KUnit test (2024-05-09 08:06:22 +0900)

----------------------------------------------------------------
firewire updates for v6.10

During the development period of v6.8 kernel, it became evident that there
was a lack of helper utilities to trace the initial state of bus, while
investigating certain PHYs compliant with different versions of IEEE 1394
specification.

This series of changes includes the addition of tracepoints events,
provided by 'firewire' subsystem. These events enable tracing of how
firewire core functions during bus reset and asynchronous communication
over IEEE 1394 bus.

When implementing the tracepoints events, it was found that the existing
serialization and deserialization helpers for several types of
asynchronous packets are scattered across both firewire-core and
firewire-ohci kernel modules. A set of inline functions is newly added
to address it, along with some KUnit tests, serving as the foundation for
the tracepoints events. This renders the dispersed code obsolete.

The remaining changes constitute the final steps in phasing out the usage
of deprecated PCI MSI APIs, in continuation from the previous version.

----------------------------------------------------------------
Adam Goldman (1):
      firewire: core: option to log bus reset initiation

Gustavo A. R. Silva (1):
      firewire: Annotate struct fw_iso_packet with __counted_by()

Takashi Sakamoto (27):
      Revert "firewire: ohci: use devres for requested IRQ"
      firewire: ohci: replace request_irq() with request_threaded_irq()
      firewire: ohci: obsolete usage of deprecated API for MSI
      firewire: ohci: use pci_irq_vector() to retrieve allocated interrupt line
      firewire: core: add common inline functions to serialize/deserialize asynchronous packet header
      firewire: core: replace local macros with common inline functions for asynchronous packet header
      firewire: ohci: replace local macros with common inline functions for asynchronous packet header
      firewire: ohci: replace hard-coded values with inline functions for asynchronous packet header
      firewire: ohci: replace hard-coded values with common macros
      firewire: core: obsolete tcode check macros with inline functions
      firewire: core: add common macro to serialize/deserialize isochronous packet header
      firewire: core: replace local macros with common inline functions for isochronous packet header
      firewire: core: add support for Linux kernel tracepoints
      firewire: core: add tracepoints events for asynchronous outbound request
      firewire: core: add tracepoints event for asynchronous inbound response
      firewire: core: add tracepoint event for asynchronous inbound request
      firewire: core: add tracepoints events for asynchronous outbound response
      firewire: core/cdev: add tracepoints events for asynchronous phy packet
      firewire: core: add tracepoints event for asynchronous inbound phy packet
      firewire: ohci: add bus-reset event for initial set of handled irq
      firewire: ohci: obsolete OHCI_PARAM_DEBUG_BUSRESETS from debug module parameter
      firewire: core: add tracepoints events for initiating bus reset
      Revert "firewire: core: option to log bus reset initiation"
      firewire: core: add tracepoint event for handling bus reset
      firewire: core: fix type of timestamp for async_inbound_template tracepoints events
      firewire: core: remove flag and width from u64 formats of tracepoints events
      firewire: obsolete usage of *-objs in Makefile for KUnit test

 drivers/firewire/.kunitconfig                |   1 +
 drivers/firewire/Kconfig                     |  16 ++++++
 drivers/firewire/Makefile                    |   6 +-
 drivers/firewire/core-card.c                 |   7 +++
 drivers/firewire/core-cdev.c                 |   7 +++
 drivers/firewire/core-topology.c             |   3 +
 drivers/firewire/core-trace.c                |   5 ++
 drivers/firewire/core-transaction.c          | 251 ++++++++++++++++++++++++++++++++++++++++++----------------------------------------
 drivers/firewire/core.h                      |  21 ++++---
 drivers/firewire/ohci.c                      | 131 +++++++++++++++++++++++--------------------
 drivers/firewire/packet-header-definitions.h | 234 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firewire/packet-serdes-test.c        | 582 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/firewire.h                     |   3 +-
 include/trace/events/firewire.h              | 348 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 14 files changed, 1420 insertions(+), 195 deletions(-)
 create mode 100644 drivers/firewire/core-trace.c
 create mode 100644 drivers/firewire/packet-header-definitions.h
 create mode 100644 drivers/firewire/packet-serdes-test.c
 create mode 100644 include/trace/events/firewire.h


Regards

Takashi Sakamoto

