Return-Path: <linux-kernel+bounces-226465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA73913ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D5B1C2083E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0631850B7;
	Sun, 23 Jun 2024 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="RjQ8467U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TK6HfC46"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1861F65C
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180548; cv=none; b=hjCGdJPFfGHcmgkUNbFIqmcixHPSrhH9TkKZd1GJIHgcDt3H5wJsbo7WhHCXM2G7AEzjKwnqn5fZVnBH9HteeyFwf8tRgKp0wJrLfxWdLriP2fefDI15mo1OgXEMt7zMiUmhc1MAWzs8UCECWjWjgAfN8xwDFX5JqL9CU2lj+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180548; c=relaxed/simple;
	bh=dLcPaiGyJ29dSM9FXmu7oUGkmAFoD/rb8XPEmz4Ziqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHDY2ekujDtAs0IWfbfcRePyyiZquQZ54sppndLPQfIitQ9NQJHxy4E2BtBqW739uDKd2V5Y5Fbj7zXQU07Kzdz1Di3nytRtNqDsW0mds5Ows1wBXwdzw4vg0ghvEEkob2Mf5BgQkUW8fcSRsm8/RNyNAiNlvtKmpd+TzQuagog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=RjQ8467U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TK6HfC46; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 09F0F13801B1;
	Sun, 23 Jun 2024 18:09:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 23 Jun 2024 18:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1719180545; x=1719266945; bh=7RfH6xhO8x
	dDINnoMarHvc5Ol6E8OWCY9oRseH1LoUY=; b=RjQ8467URtKcCL6dcoqvvRkSr+
	cHpSA45roZWyXr+V8DZKpVVgbP8iml7IqayfKuszVDUm6n10YQsR4XoOu8M2HXSt
	Pjo9sDY/Hcg/TNgtEWhJlvAoQorVqM76J/2h8Djl2lVmjQ+Ty2zbVmWXKHZfGV5L
	2TJ0kJZ0Mh3LfBaQruPa+2He95TUjkxdvCIdkAniR739KHHmDyEpapFqnnH2lw5S
	/tNDxfE/4saIRe+FDEoGG0/Jt2HZWvG4IRvtM9fDK/ANkNpkNO5CZ/z39iEqUaC1
	XO/qkSEr+W4F9B0fBGfLisj7w5Tjr6DCa/WfkxRBd66GkEaMWH7wBAisA0WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719180545; x=1719266945; bh=7RfH6xhO8xdDINnoMarHvc5Ol6E8
	OWCY9oRseH1LoUY=; b=TK6HfC46PGuzLGUGNfbj6/k/Xp1t/4d5fYUTZxpJBurZ
	jhQXGqYlJRs+9f97ZXippmp8UcijvB3/A+1ThmQxt2Quep63hYomrNpTB1UfRoMs
	5IY5+i9yl1NGSid/xt5R7BnIilxxF/0yxOdjsEdUbgClwEnrhY4brmkurirI6TBv
	fLUo4rV9ngEl+gapYQzphzjWfbk9vN68FsKxCyCECQ/vSEHc7dNBahZJFV8ZPcFQ
	1240w/LYTC4PGlcsbzj0hEBw/sK+umXX/BTzPfPWfx7YYaQEGEelIF95LLRQPPg8
	3cvwy4UVcV4EYCIIjUQ5GRgjdcERO5BubWhqPG48gQ==
X-ME-Sender: <xms:AJ14Zta16LOs7O2qpzb2iI4dOBvgEloMmyghTYOTF_BOLtvwaJcFdw>
    <xme:AJ14ZkbMsSrjjWA33QiwmsVQ04IpBhG9hCSFBbncAUKvqsbbHV7jOMvmz6YWrW2c6
    Wf2UJ3zEt44WJWx9LQ>
X-ME-Received: <xmr:AJ14Zv81I-en1RVFeOMD5GUSpDpISBJe-DuUdTU8FFyPRdb4ZpCpBx7UK59k-SW4D8yPtjPDjqKSGgQz7XETBJDT5HJDXlMY5KmXGhndJTGJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegtddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:AJ14ZrqDeDpmhPPEmN6nC0xaU2ujMkU0UAKBKVnD9UpqBrnWOQ06kQ>
    <xmx:AJ14Zor2ZCM6Ra-wXSHwPSuml0d3z54PpP4tpW_z3S039uCRUbYc-g>
    <xmx:AJ14ZhSRmztKWfHDLydP1H4R0eZ0UQFJk-ywGh74JsqkCy7np5WiJg>
    <xmx:AJ14ZgpPoq4TV7RYbRiRZ9olmOMA5pP7awcOyOKBDszLLajjX3WvHw>
    <xmx:AZ14Zv2K4FmrXjLKFQZewaLzOXPRiLkb-mD1dR6cmQ59IZJd1g58GzQS>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jun 2024 18:09:03 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] firewire: core: add tracepoints events for isochronous context
Date: Mon, 24 Jun 2024 07:08:51 +0900
Message-ID: <20240623220859.851685-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

It is helpful to trace any operation for isochronous context for
debugging purposes. This series of changes is the last part to add
tracepoints events into core function.

Takashi Sakamoto (7):
  firewire: core: add tracepoints events for allocation/deallocation of
    isochronous context
  firewire: core: add tracepoints events for setting channels of
    multichannel context
  firewire: core: add tracepoints events for starting/stopping of
    isochronous context
  firewire: core: add tracepoints events for flushing of isochronous
    context
  firewire: core: add tracepoints events for flushing completions of
    isochronous context
  firewire: core: add tracepoints events for queueing packets of
    isochronous context
  firewire: core: add tracepoints events for completions of packets in
    isochronous context

 drivers/firewire/core-iso.c     |  32 +++
 drivers/firewire/core-trace.c   |   4 +
 drivers/firewire/ohci.c         |  25 +-
 include/trace/events/firewire.h | 463 ++++++++++++++++++++++++++++++++
 4 files changed, 518 insertions(+), 6 deletions(-)

-- 
2.43.0


