Return-Path: <linux-kernel+bounces-286488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CA6951B95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F52B257EF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973A01B14F1;
	Wed, 14 Aug 2024 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="XgaZoPKu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="seZ5Ti4U"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A391B14EE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641150; cv=none; b=FdItQi6t+nLqjLLUOMZiXu4yy3/EiW6cRlmJDC0Tcz2aubUIXffiU/lXvJucanQ60SXqYoZJfURrsgqZNJ/ADeIvzFiGDUMbEsu2BjG17NcP9ubAjZkpeXJScf5Ll4x+k0MpD5CoBkObHPDh8n4RhEzHm++79ccrAY3ILYWBhhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641150; c=relaxed/simple;
	bh=aJ5DvBJ+jpZ6xZs3LIXI5EPHIvSr9x5g20KjYEVnKUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9HmeUxSK9URCDzZpM3UISEOSjorVSsLDTY9Bu7SNEImylANF+n0fGHtCYX6W+gl6JUIIzNkU4DxSc9NFixGlRkkexT38P5z49SCHi6eMVahRQROnqk9Mo6eV3RbPrRJ/s+Y6NM8FZ2RCuKi+gMN0LW5QRhOKhGNncBfyZlbVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=XgaZoPKu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=seZ5Ti4U; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 544A5114E9C6;
	Wed, 14 Aug 2024 09:12:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 14 Aug 2024 09:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1723641147; x=1723727547; bh=mXQOUI9Nn8
	V2TZdfVFQKYg4yY73eGuHvVPjqgNl+nDw=; b=XgaZoPKu5HJWIgKMzsW23+htp9
	je2yEvxYeBsAcFIaU478oVrreBkUh6UBuFcH1z08Ar+gjdksEVMLtCbrC6r0E3qE
	DKG0rW8lLe57htl6wQo+/9klqAyZXDguAlsmmLaSwc5is7DmcByrhiPBXWqeLVxD
	ERSXN/pZXTxhxURJPXgnLjtmdBzHdRHv7Tv2SNpRdPoNUJlcpeaGQtSs983MlYt8
	3qI58cBLC7XObiw57rog3W2qPN8W5R4G0AcMWTnYJOXwyHDID0EqzWylrWqsDcAR
	u+DxazNNbUKB3R1p1U1mqtZdFoxVVVFNV7IUteSLTSvw1oE7a1uoc5lUJtxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641147; x=1723727547; bh=mXQOUI9Nn8V2TZdfVFQKYg4yY73e
	GuHvVPjqgNl+nDw=; b=seZ5Ti4UqSiwr1pvrAEw4jmmkh1Rn+OpBsez29OY8j2X
	9U5Xrp6EKZs7F3YBPiy9lVYSuYUfhYRsSVoFTDClnbUdTUWcECxf4dQc2wCTx4gX
	cUgkTsxenEbop3AC/5gGRZT+Fy60Zqu/y+pEnImhFf81KDJR63rt1ldgHRh+5kJz
	zpqajLKobzxV8FAkImVQsW/PfrdzZm6fWqbdm0TuDfTFISJ8lsx/6MvuJ0kScdnG
	TM/obWCgCh7pIrDMyO/4fSr9fSTWfRV4Zvf3H/TGXsuBKrLE3UbGflXEhHH/LW2j
	kM4uw9rGW/rZMvB5UUqSdIKl3Pu/y53Esy+7vp8wOA==
X-ME-Sender: <xms:O628ZvV1sFoHulGUawEWM9w13wl_n6TZlGTn6J873-yPq77c9DzzLA>
    <xme:O628Znlz7qL3WAUJs8WP18PgTdcCBYOfUhj9QOta4HN2xF6Ycpz8xRfnqfD54JHlU
    mngE7A4P-YgVxpd4NM>
X-ME-Received: <xmr:O628ZrY4MvTbv2t9JkCf7R0zxZAoY-JXKtPOXmIT3QlzBPCDZhJcoUWo31vJRis3u6A8YfwIqtHUYvjRTmlmvps0fsv_J7nVPbYYaYsxc6UM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:O628ZqUVAXlTR_2jDlKH0DahbOlQFlzud6SIWYnTSV290GU2z9AFZg>
    <xmx:O628Zpk5SMWYSePSE57DocyiIUy0pStl8tA9e0kJoXwwvosZj27kEw>
    <xmx:O628ZneYcitISuJKeLwxE_0Y73rrQhzxWtkKuXtIkhlH-tMy5O-x2g>
    <xmx:O628ZjFmF6egvlvXvkc1MM35icw3-179_CE4NaUFjhPqRTLs2VHZFA>
    <xmx:O628ZuyA_WBaQH-GSz8D4aW9Gt1Mo-Ejjy-pmuYjrrXqksZospPQN-oS>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:12:26 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] firewire: core/ohci: minor code refactoring
Date: Wed, 14 Aug 2024 22:12:19 +0900
Message-ID: <20240814131222.69949-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series of changes include minor code refactoring in core function
and 1394 OHCI driver.


Takashi Sakamoto (3):
  firewire: ohci: use helper macro for compiler aligned attribute
  firewire: ohci: remove unused wrapper macro for dev_info()
  firewire: core/ohci: minor refactoring for computation of
    configuration ROM size

 drivers/firewire/core-device.c | 3 ++-
 drivers/firewire/ohci.c        | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0


