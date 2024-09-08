Return-Path: <linux-kernel+bounces-320009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E8E970502
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3162830A4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558AB38DD6;
	Sun,  8 Sep 2024 04:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="XD1peft/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jjFXBT6u"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5F28FC;
	Sun,  8 Sep 2024 04:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725768357; cv=none; b=YL5lTX1z13/gBzflReIHU0S4sVQJSeLGW4fCvu0L0/DghEFo4y+V4IuWCONs8dr/AsmfZfDd2H7/jfiCW1KTfUjnGSSR/CvLmC+RfurdpMoiTJgmPZ3v9RBAH+JGay97CQpf5c4qDygzrAF4t6ZlzXaLC0D74REd8+ZkwpYDKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725768357; c=relaxed/simple;
	bh=TRtD2AWRlt3T/rrzb/USgXHxnGcSDerkJUiN3eZMmE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abVaD3UFduzGIkW1TlINZ3l5gv47r0ZhfLR0dkCc8yhQl53NpqfMol2TQEDvK6eWjmrOQcZ8xoXe11IaJadKF8176EQVXtougKUu0OasQWwEbU7YuCM4SY2sWeyJUtIXcJXzrGUgCvMqngmsBOZYeFWCL81f7GLhF7FL5jWD0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=XD1peft/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jjFXBT6u; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C8BE1138029D;
	Sun,  8 Sep 2024 00:05:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 08 Sep 2024 00:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1725768353; x=1725854753; bh=sD37MHZf8j
	sc9U1uEE8jgarcJ/ogTmY9ratxghKpm6E=; b=XD1peft/BS27DDGI2INIMD3WEG
	4kuRyB+4JOIeIX0tlyxWlF6J5U9InyWlDhH6/o0HzgTbNCJz0Ts/tLpfJTsCNnQA
	l91S7/AV37DDeFentgn5w8Wb0PveOiQ11qSxue0jpb3XhXB7mXLqY7TOHROGVSde
	I1DWcVoeCXz7MhfYsfeZqwoZpBtq5LLBENH4AK163BUvgZtEmaRY06g2C95hmmoJ
	J+M9+r70VjcFCLcyBBgtSnpqGKrkNp3aPMeSgoCDuzIcuIKIR1laNFgCRAd3fjhk
	fh0E+GE80Yhal5XL63xjf9YUB5X4aX3cbgnCLjvcOW3h0D8ObLkt+XbKGfyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725768353; x=1725854753; bh=sD37MHZf8jsc9U1uEE8jgarcJ/og
	TmY9ratxghKpm6E=; b=jjFXBT6uyYdBvOvFbFEnLJ8FpEkLIaZXVTn9xf4/It8g
	gU3JkZhu91MmcyLV4ejnNeklk9/09vR87lsiwnW11d5Cxnv5LZAYnvc+ZY2JwWbF
	EqsT0o3jkLYRvEt5EhhJg19ruqQmAmo8NvgWUYMy4sP3zha7jk+z7oqGicUujOFZ
	OJDnken+kTkkkIkqo5qhHTC352OM7jKXciWx/jD2RQNdLEO0mnmja0kid1vdxbpz
	upBQCUvSCk2m6IgwxwZgHVYmdQRpusCvQHm+DuYNVMf1kXMCpzws0740cYQV/8P2
	L6GJ82mAF+klj9nLWhgJRnTunU/6SkNdFq8fkppGdA==
X-ME-Sender: <xms:oSLdZkMyqby8AVn5E_dpLF2_OoVRIB2Ib9dDmVYB4GRUu4jV2APaQA>
    <xme:oSLdZq-07A79xC6jbTxwwKZFG4XKo95DJheuZhyIyFsCFR3YHyvLNeQfVibUmI55B
    G2WhF3XHF2-IaPLQzw>
X-ME-Received: <xmr:oSLdZrSA0k_xm4mf9SxpJuHCnXTByFLP2ksJf3w_3sVv6AN7ypjn7qXc3sCE3-r6sp-z9Y4fBnSRTU4dwOdAepHQTumy7GFxyaBWDSsspiUdHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohht
    ohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtth
    gvrhhnpeffvdeuleffveekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveek
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqd
    htrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlse
    hlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqshhouhhnugesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oSLdZsvwFR_mT_uyYuDw5NdqUJwdT7MjMV5bj5qeS3I3ksIOoioPig>
    <xmx:oSLdZsesFTQYVcfoEwf6Q9h81oVkIn7TRBWax62e8wo6EgPWppgzXg>
    <xmx:oSLdZg33zwCInR3H7R0tioR3-vKiB5RXWM5_Kg56L_DuNPKWC9Vl9g>
    <xmx:oSLdZg9wG6mxIr6UsS6Pi7BS9NkpZFlTyJsHxHM0ftn_dqbFeUJuKw>
    <xmx:oSLdZk5RyfKkQm477LpNdktX_oMBG3eTZjTUuQABtQ62Om16gDwJkMp3>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Sep 2024 00:05:52 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 0/2] firewire: core: allow unit drivers to schedule work item to process isochronous context
Date: Sun,  8 Sep 2024 13:05:47 +0900
Message-ID: <20240908040549.75304-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

ALSA firewire stack uses packet-per-buffer mode for both isochronous
receive (IR) and transmit (IT) contexts of 1394 OHCI. To process time
stamp per packet (or per sample in some cases) steadily for media clock
recovery against unexpected transmission skips in the IR context, it uses
an IT context to operate all of isochronous contexts by calls of
fw_iso_context_flush_completions() in the bottom-half of hardIRQ for the
IT context.

Although it looks well to handle all of isochronous contexts in a single
bottom-half context, it relatively takes longer time to finish. In the
future code integration (not yet), it is possible to apply parallelism
method to process these context. In the case, it is useful to allow unit
drivers to schedule work items to process these isochronous contexts.

As a preparation, in this series of changes,
fw_iso_context_schedule_flush_completions() is exposed as a kernel API
available by unit drivers. It is a counter part of
fw_iso_context_flush_completions(). This series of changes also includes
documentation about these kernel APIs.

Takashi Sakamoto (2):
  firewire: core: expose kernel API to schedule work item to process
    isochronous context
  firewire: core: fulfill documentation of
    fw_iso_context_flush_completions()

 Documentation/driver-api/firewire.rst |  2 ++
 drivers/firewire/core-iso.c           | 11 +++++++++++
 drivers/firewire/core.h               |  5 -----
 drivers/firewire/ohci.c               |  4 ++--
 include/linux/firewire.h              | 17 +++++++++++++++++
 5 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.43.0


