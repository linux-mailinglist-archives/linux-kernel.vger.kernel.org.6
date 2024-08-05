Return-Path: <linux-kernel+bounces-274384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5468E947796
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3131F22423
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8343814C5A1;
	Mon,  5 Aug 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="D23uQAm7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NV+YLifk"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7413D503
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848054; cv=none; b=oYxmBd/0TszyslHNLNDjVRhFshOu2xNZPoWITkl7AoWzKsiRSYEk7BpmHJ0GudmY+N0CSp30AkYyQ7cxgsbJaaY65mt4ZH//LHbHGQU8qniJDOLAxaKLSGKlIVgPCdWYQZnKc8W/P4I9Bwv/KJmF1ldi0LZRi0W2Ip+cYnb0czo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848054; c=relaxed/simple;
	bh=qGGycTHPW6FQxSO6Zet7w4y4vqxpNW1K088kSBE6Wkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WaPZN+hEnW0dDcT05XAB3DJMV9jQGWF3v0TiUG5tkcDCPd5lmhB2O/xHJj7YVpPC57jO3HpJMQvU6vsD0ni6SPviL0ZLxsv5pqrIfyggusFU54fv12PVKqTjUMhX9/w2thcEY8WQbFprxq2cUDw2gZvxZ6GgYOKIcnoU4h2AEbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=D23uQAm7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NV+YLifk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id F3AC9138FDDF;
	Mon,  5 Aug 2024 04:54:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 05 Aug 2024 04:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1722848051; x=1722934451; bh=i+Ir2QJeVd
	Es1CTqER7N3iE55rTpvUreoCyf0MkTYpY=; b=D23uQAm7Gbv3zbKOO8lRbv+pGT
	gGQ6xvSnbrHOvSiG1KTLeGb7DqpsQBFp9KSKatziSelem+t89C69UzBzFH20QtZ7
	+foZDEdeDpaGTglGqCVjqFPLzQQ4djGDimIcsjhoalHA/gFjMhoK12PfXQ+wJ8MD
	TD1pGPM9bmMq4p3lYpJ9hQP2VKnMfP1mBDh2QOqmneYhVM35Uc2Za87tZDdxjIJ9
	9FgjuITAw4yDQgkWDEpfvJjuweZ5+ZOp1BM7+rUb3QJF6ZK1/+HaVVSkZ2Xjan0+
	hkqoFaIz32v4XY50F9CJxPiBnSRutzvwR+8pPo/vQTnAD6e9YQGSx1oaOBuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722848051; x=1722934451; bh=i+Ir2QJeVdEs1CTqER7N3iE55rTp
	vUreoCyf0MkTYpY=; b=NV+YLifkCajeOllmhIeuDqu5/SMX9qXf76V+O2A+MfrK
	eyOnnQABck3KTZah3UI1VSyXNkvx/lvjTowbaJypiqf4Lo9rNxaZp7U4YSvC3DeJ
	Gj7mcyEf3qFbSlY8Bc2h7zU7yPElSzIhR+W8WqZieCn6W/Yy75CK9NYpxpFEh8SJ
	Od5AFwrWbKtIPwMnKe0k0bdcnuhglr3qXmKnrsoa434KG2b9UlSbIbYmgrVIhIXm
	PJtqNhrUcXMShLmu9OdvFEMTCcVF6UYiQoZSX+ywPKXaC0/HOXzPTR3waF2v7oTr
	Pyzqzs04JhKNS3iCvts5r2dFIteZUfOR8h0CsdNnYw==
X-ME-Sender: <xms:M5OwZjUInO545kkjCYrLdqyLXXMDEh-yzLCZxY9ES1eqgB4eJc-KVw>
    <xme:M5OwZrk4oZYpd_m30sP4YXxxjXtb_ivzIcchoOK4dxZyDeV4x5mNaJAqy_oDQ0eyV
    H6mi4T1vAjAJzekKYM>
X-ME-Received: <xmr:M5OwZva0h6tpotlik70eS4WhnkvI8ltzvzDhuCy_EBPlZ5qlxI_b69CoNi4IPIx1dFPgxVItJmlJXKAxFADXWH43uUGsVbMl9gDyCZXUXM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepgefgheelheejie
    elheevfeekhfdtfeeftdefgefhkeffteduveejgeekvefhvdeunecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgt
    phhtthhopedt
X-ME-Proxy: <xmx:M5OwZuV8CGGKHzXJktg2m65pe-vOB5h3UAgJTMwF9fP2E9tI9UIQ9g>
    <xmx:M5OwZtmvMuYaNoMjZYGCgPJiT5UJ7Tz-y_5kmJsnRQ_dY9T85nqRRg>
    <xmx:M5OwZrdxhFgixsfhZdataRju4jxB--DXJP6HddoOHSAS3f_7Pxs1xQ>
    <xmx:M5OwZnFm4KcJSLlPmL1NGMIbiw5ZChd6QAuzuvRRT-MqnIPLGmtSRQ>
    <xmx:M5OwZix_6BWh9t5Ggd5Q-BRmY6FhEZHP55F48h-S8xUqtC8i9-gjRvin>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:54:10 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/17] firewire: core/ohci: use guard macro for any type of lock primitives
Date: Mon,  5 Aug 2024 17:53:51 +0900
Message-ID: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset is a revised version of the previous one.

https://lore.kernel.org/lkml/20240804130225.243496-1-o-takashi@sakamocchi.jp/

The guard macro was firstly introduced in v6.5 kernel, and already
available for spin_lock, mutex, RCU, and R/W semaphore. It is useful to
ensure releasing lock in block.

This patchset includes changes to replace lock/release codes with the guard
macro.

* Changes in v2:
  * use scoped_guard() instead of guard() just after label so that
    statements are expanded there instead of declarations.

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
 drivers/firewire/core-transaction.c | 146 ++++------
 drivers/firewire/ohci.c             | 399 ++++++++++++----------------
 7 files changed, 403 insertions(+), 547 deletions(-)

-- 
2.43.0


