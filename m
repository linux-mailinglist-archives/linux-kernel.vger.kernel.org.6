Return-Path: <linux-kernel+bounces-326601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C7B976A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3184A1F2166A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92F1A265E;
	Thu, 12 Sep 2024 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="edsSBqjX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BRS5XQf1"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0851D8C06
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147847; cv=none; b=MST1vCa61jHRlPAMyfSeyEcmsO+j1peu7m/rly/2NUk/pgQGgdKcIQvUW55Z5BVbFxVEdpwoicvcKp2Y4TuTDA6tjOvvXmfL3I6D1SipvN33VcWGRlIURuVHUAn+0WSFj0sWM6+Lm8FRQ1GAiQdHQPbbN3YbRgHKgwDhskBPnYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147847; c=relaxed/simple;
	bh=O20CzYkY/1iOA9uc7dHhmVbbmR3hFr6VQqBaUP1/1RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hehrUSeCkhs0CqSFw6vSXer2wJb2N3g7J/fExpOThkKyRKrZfjR6DkJTWRlvHYUB+T7nSxIKeanknFjZY3bpwR6EJL/XS0aIJWq440nRNAI8M3wKeLfliCOdrimINptYTGqeVKlfrA2dM081mrhEmrBcvyaMiT6miSx6u59Zur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=edsSBqjX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BRS5XQf1; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0FFB11140161;
	Thu, 12 Sep 2024 09:30:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 12 Sep 2024 09:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1726147844; x=1726234244; bh=V2HnsVLgrr
	YZBI3hAFY2ve/W7OIqLPa9tNiZfQ+T1WI=; b=edsSBqjXI7XyIXjoEUJYxDHEyq
	0qzDmnf0uUxo0BbFDnXbTw6NeR33OhUHg79uSLVVLMNfktcjdPZJ/eZJdJtLDVo5
	ynaHTGtydmBfPAyGYT/PwiC+7ImfnA0hrlJYia3VqkVtCI/S35dXBp+h/qcFB9Bb
	EGMzRCoAQScopKGmU3+aKDvHrSJl6HfSHC94PhF+gZ2XxYA0rrtVwakC2A5X3vcN
	kd/DesXwr3g5CmVicdJBf8DOuBXR6vLfqgcl1Sptbc6t3E1HgQbieDwucNSvc/M1
	oB6uTg7n4kh1gyTsFtx9SGRu1PHTYwHmQIiz3toYLVqn5nuxGv6+ZyXHJ0HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726147844; x=1726234244; bh=V2HnsVLgrrYZBI3hAFY2ve/W7OIq
	LPa9tNiZfQ+T1WI=; b=BRS5XQf1pHFomiEOW0RSlEKRcAIG5NxmFoR0GPCvHzI5
	ajrDfBfKrQm/8I+Dp+zaMkjnz/f7n+w7atGAP9AanegbQN5i12h4heVdyTFIvbTC
	5KFvfw20MtCggRJWh9Rup+jTST1GKRsnsO34F40jO/tSo7Wjm8aALYWDnuZqo6aG
	hlB2AZROjBszPCtyiSY4pQXQTsRcIwWzAz0p+c+yr3SILGZv77Xryj0bqcmM1DKi
	EJQiBNU5WEyEnDBDHB2zwJybH5V6+mW/FMuzCkOLF8727BiG82FmwzGoCs/D1RBX
	8oqhYobjKc+PndfV8R9sjvArIY/IBIKMOhDJ/1ePFw==
X-ME-Sender: <xms:A-3iZh_lEBGRmE91jp1eJdXAzXqKybdfhl7lODPGjo1BisRrP9yGyA>
    <xme:A-3iZluEldS-tEju0PVp0AUqPG93NM6b4YRMN3osR173LFwlCEZ-LyARn-ChnYo2j
    DUFg--FsUIQj5X-_2Q>
X-ME-Received: <xmr:A-3iZvB0171Lq1C9ps1Q9TxS2_L_WuBcQs_Bs7i6hc2UF5hbZjov-iD8bSd_yh-r1ldecfqvK9dUgBc6_2R3FGxQXH0M9fRB5oSwmRVjl-gHPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohht
    ohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtth
    gvrhhnpeeggfehleehjeeileehveefkefhtdeffedtfeeghfekffetudevjeegkeevhfdv
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggt
    hhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhg
    vgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:A-3iZlfW75nMal8VSPJNLk88oRfKRqqqAlPxCUZu806v2apLXWzvHw>
    <xmx:A-3iZmMxKEzAjCTO4PLe6HNgZM7IGC8_M9oIBvPwZ7OiTzt02J5THg>
    <xmx:A-3iZnmVpmv37TlmL_hH2Tbc3fffrbaXH0ck88UfL_10-NHA7hPP1A>
    <xmx:A-3iZgvsYaxZbJW8bt8VYT34JSJ-MiD15h5ryJGbxocoamZabQSG6A>
    <xmx:BO3iZvbn9CRf_ZGncyuWno9OWTHwp1LGoZ40dOYC27CIhIxfYhg7X9yA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 09:30:42 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] firewire: core: revert changes to keep interface compatibility
Date: Thu, 12 Sep 2024 22:30:33 +0900
Message-ID: <20240912133038.238786-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

It appears that the changes in my previous series[1] bring the behaviour
change of core function in the view of user space applications. It is
not preferable at all without any preparation.

This series of changes includes two reverts commits as well as some
minor code refactoring.

[1] https://lore.kernel.org/lkml/20240911151253.GA167609@workstation.local/


Takashi Sakamoto (5):
  Revert "firewire: core: use mutex to coordinate concurrent calls to
    flush completions"
  Revert "firewire: core: move workqueue handler from 1394 OHCI driver
    to core function"
  firewire: core: add helper function to retire descriptors
  firewire: core: update documentation of kernel APIs for flushing
    completions
  firewire: core: rename cause flag of tracepoints event

 drivers/firewire/core-iso.c     | 40 +++++++++++----------
 drivers/firewire/core.h         |  5 +++
 drivers/firewire/ohci.c         | 61 +++++++++++++++++++++++----------
 include/linux/firewire.h        |  9 ++---
 include/trace/events/firewire.h |  4 +--
 5 files changed, 75 insertions(+), 44 deletions(-)

-- 
2.43.0


