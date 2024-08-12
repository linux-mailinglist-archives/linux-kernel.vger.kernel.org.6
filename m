Return-Path: <linux-kernel+bounces-283921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C994FA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017751C21DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A05C19A2A3;
	Mon, 12 Aug 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="HtmNKE5q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pf6vvk7r"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B01804F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506736; cv=none; b=mARlBMb7DD6AhY4LpvKEucKrJGfpMONOpHPH0VOAtxUc9evWMk7FBO1jjqEX1wW0blB6O6S59UmF53ysexoGW18AEhIOcBmtLEx640nWxHImdfvWjbvK3SkMfqka0NJ+oypyQwk/EGedDAORC3LBdapAS2z7RwdCCoZUwXUeIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506736; c=relaxed/simple;
	bh=r7UBLwfQC9CsT1AaRfuw3P34LzpglgWCJsKhrTVWkTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7f/15PY5c3aCCU7E31Ku/O9hspnHyg6zHfIJ9E5RlWjj3IZi1/e67HNAANjnwwMmdA0XoAd2tth+OQTtt8CJUqnHETo6ocW1JmcN6Yvn4O+bOyovXV7MBOnR1dU3hAYD/DcI+t5fiBxKUgfP17yy3MUiQCfrnUJ1KnPTNT/Z+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=HtmNKE5q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pf6vvk7r; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5B1331151B5D;
	Mon, 12 Aug 2024 19:52:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 12 Aug 2024 19:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1723506733; x=1723593133; bh=OvwBSx5ssw
	pPM9gzQtgAIKFWJVfBWE1PlVCsQqD/Reg=; b=HtmNKE5qTaBWJRcCj6ZNiI0SRA
	fF8I0JM6hLMhUZ+O5CSku2XdaR7h/rA+FeB0mgFY/RTzXPuZIsRMTwH/So/oJcxY
	Qiy0PRj4uNFQf8zaVGHuveytbqcp2LTQ7q+t+gCIzaO7sb+Fp9j1W65+L8Irhfdp
	owGOzVWZOJhDzYwqz2T6Dy8I/LAGysfaQ39BKnUJAeemza9kC8RKBb1Z9S7cENoV
	ZithkHeqPjSR0TTeMdeBscd1FKW8EDD3WwDX630nHIdc7xVP7ZzBabYYTOFS7TJ7
	aY+qSsEIyuiALN/6wbyuwzPojPj7poLYqTeSh1qHQ3nihSQBQWhLHDtO8V4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723506733; x=1723593133; bh=OvwBSx5sswpPM9gzQtgAIKFWJVfB
	WE1PlVCsQqD/Reg=; b=Pf6vvk7rAVQVesmiKLfeVkEQATbnXRtGmI9PYEI7Cjzm
	CFgs8HOUPw+TtOuFv/g5WUe0brFWv/Riwuy1SrsMpz0vXwn66bzYaCV45dEvOq+f
	uCbQ26MI4JwWHktXnhPlh1AVg4Tr/75T2Tn5NYZOQVQFS+lsN2tAGn1zK6zynaJb
	pEBspgB3pf1W6hm7CMAsdERMjrXBsc2EajLJdFB1JqCCP2XA2xmQ6PKz4xa0K3+4
	aosikhOq8ttWpd4SIje6rJmdtMxfJmv8fvuOO7ZFlrS+GoNDGO6+rAm5SV63xiD3
	JmPqtzgERgPT/lwTfK5h7CwEKfdHyDbvyvF7r+oMWg==
X-ME-Sender: <xms:LaC6ZoYDBQsm_xp8XH4mcKopUgeZz1lLmneSJdbglg3ibEWmGxiDxQ>
    <xme:LaC6ZjYAy-3CI37epV1z41CkMxh1LfxUkdrWMMPJDJDb7PS6xj_uy12kVG3_5YMy2
    rm5ic5GUImYuZann9k>
X-ME-Received: <xmr:LaC6Zi_zx55UklXXhi-EqZ3sP_zUXelh9cM4MdKpnvv0OiMgxWawGVhacDahTL1kwlG1H5NUwLkIFZRzMu436f2zdwr7L2JCrXZZfwRq1RaP0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohht
    ohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtth
    gvrhhnpeffvdeuleffveekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveek
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqd
    htrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlse
    hlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LaC6Ziox1nX68_NypP-_0RLFhndSKcOxtot3nifI7570mzbVYdkbjQ>
    <xmx:LaC6ZjpvWpeX60o94SmVE6KvTsF6EBCC5z2kCrSq931ZTD2T3F-uAw>
    <xmx:LaC6ZgQUzgc9m_WhiaLXcWn4nBMciZ511Egw3jdEtH9fwI9QPOe5pg>
    <xmx:LaC6ZjqvB9f2RvoQOXgp7hQZdv0GwXFKyrO2rC4cdt1zN_AOEByaZg>
    <xmx:LaC6Zq1p6oMPcE59j4BvA7y7BWl69Md4oWIJDrfq_4ou15ED3cgGsvYE>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 19:52:12 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5]  firewire: core: use XArray to maintain client resources
Date: Tue, 13 Aug 2024 08:52:05 +0900
Message-ID: <20240812235210.28458-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In core function, the instances of several types of client resources
are maintained by IDR, and the index value of each resource is passed to
user space application as handle. As of kernel v6.0, IDR has been
superseded by XArray and deprecated.

This series of changes is to obsolete the usage of IDR with XArray.

Takashi Sakamoto (5):
  firewire: core: minor code refactoring to release client resource
  firewire: core: add helper functions to convert to parent resource
    structure
  firewire: core: add helper function to detect data of iso resource
    structure
  firewire: core: code refactoring to use idr_for_each_entry() macro
    instead of idr_for_each() function
  firewire: core: use xarray instead of idr to maintain client resource

 drivers/firewire/core-cdev.c | 170 +++++++++++++++++++----------------
 drivers/firewire/core.h      |   1 -
 2 files changed, 94 insertions(+), 77 deletions(-)

-- 
2.43.0


