Return-Path: <linux-kernel+bounces-323412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB4E973CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B941F25E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB11A00C5;
	Tue, 10 Sep 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qR95IchH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oYO7Wbqc"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8219EEDF;
	Tue, 10 Sep 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984481; cv=none; b=LfuG9sIFCYExIrWzK+0BGZXlZW6gnbf01Sd99RViEYx31maOAM/MARa+aVZQVgnDPjdxePkN9vXpPdf7q0AZy5BL4rUOZPSkG0qgWUETLv25vqH0Q4I99EUfUi79249DG41NAwFiWAUtxrgehzdAJ/cNsZfJV9gxjp9XpvVqjCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984481; c=relaxed/simple;
	bh=xgiNPzlk3rdOgQAeLCz0Rqy3FzKDE9kL++ZKI/q3MF0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Bc87h9KDLq3bvUopRp00CbVH/SgZmNm6hCyWqZADEf5hcjmr2WcgrHpvqHkbweFmZyQjIQQjp9pt01Na6hvdawEZcY0Dy/oGkwwQce+8pipGkxHY8xDlsqFDnrVVDO3zzOKW/VJ5gKtZ95kv7Ej+Dk9gHaW57kDjICsmGaRaiB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qR95IchH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oYO7Wbqc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0AAD31380235;
	Tue, 10 Sep 2024 12:07:51 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 10 Sep 2024 12:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725984471;
	 x=1726070871; bh=XmqaOFKs/9jjAyPoV6aQ+QxNwaOF1DP+TYLlXI2Z4GE=; b=
	qR95IchHoslkzTyT6yrfYzpqZK9UtRm+wdPaUcSCtpC0SZNMdkbpwHRV7ouLHrVU
	tdFJ5u3EwUrEG3jcsEZml74pksbpx2UDYUbnj0XHjbG8EyLUXlAXO3pgXufj+JWD
	XpLpFEqTAjXbyyuL+rjsk3hL7nmXxPFIt4o3vNrJrLr9K7RDVaM6wZZCwxovU3X/
	RC0+dAEjQ0FyRHGhXec8qXA96kvKDYu7t54JnnN9s0NDJcqCe5iHS1ybVAEGeKAz
	+5603amQqDhGTC8nNbdhWGxyJXn81dOeN9KzcRToYe1L4u9s7Eyc7lbz8IX6BjNx
	mGFDzUN43DPGOXTZv0zjNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725984471; x=
	1726070871; bh=XmqaOFKs/9jjAyPoV6aQ+QxNwaOF1DP+TYLlXI2Z4GE=; b=o
	YO7Wbqc1VQkwyEF26eLWJFl+EgChhJLQNsrO3eUxxa3q6Ip4nGgOWcI2hiUM+/VD
	KpcI+X53qRtVySBgdUGRH3Vdfvk1lgkOt1hEpZs1mVZk/A70MO0zXHAxsl0/A5hL
	MpE9s8QptDsGNCWOSmVbmlpvw0UJfruaSmoGejs/y3Vo7mR7YOhq3AeAIj990YIS
	6AgX2Af2zwaaW3pdyKC1M3PZyNGsbPv3i0ae+SSVHC7/IjTyDXEzFci5KNO1cu/k
	O1KpCiW0SZ/DAWQLceA7e5nxuXq2qVV7mEQCrB/dy5+8aeeFoyxRNnLOAASfkErz
	wEUfHvuVabMNqRi3UVYJQ==
X-ME-Sender: <xms:1m7gZjweIef606GR8mCsU5828iTUm5bAhLCO57lPJ1oClhdWauPWDg>
    <xme:1m7gZrTjiVnNC3SytCSyp1Momaj0Pvc2nWoPXY4S91k6b28D6HIZPbbX6Yi4GDlnv
    fEIEX82ZMpv4hlTBXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrg
    hssegrrhhmrdgtohhmpdhrtghpthhtohepjhhvvghtthgvrheskhgrlhhrrgihihhntgdr
    tghomhdprhgtphhtthhopeihshhiohhnnhgvrghusehkrghlrhgrhihinhgtrdgtohhmpd
    hrtghpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehguhhorhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrd
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishht
    shdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:1m7gZtUDmvusXS7jVk_uO3p3Q83B4oveqs8vmmbMcObHgRl5rjrEYQ>
    <xmx:1m7gZthrRAPX2zNJvUytEKdO28FZvsJt7qpZdslgjFrIXcVgicOkGQ>
    <xmx:1m7gZlC_adRSGOOTeOhF2lAPIxLs4PWk2hy0IQEvtkKy5eVJ6KYW4w>
    <xmx:1m7gZmLxjrFavvf3B89sZczSprZ_hXa2OEkI-BrTC5zVJ5WNs4FiFg>
    <xmx:127gZqIgLJKjUIGL91pXI4tNRUPmTZt2Naa2Kdrwm7GfdHp-BBZ0Xg6a>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6F8CB222006F; Tue, 10 Sep 2024 12:07:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 16:07:20 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <jvetter@kalrayinc.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 guoren <guoren@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <601b10c8-148e-4d61-b6b7-5b473842927a@app.fastmail.com>
In-Reply-To: <20240909133159.2024688-1-jvetter@kalrayinc.com>
References: <20240909133159.2024688-1-jvetter@kalrayinc.com>
Subject: Re: [PATCH v2 0/4] Consolidate IO memcpy functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 9, 2024, at 13:31, Julian Vetter wrote:
> Thank you for your feedback Arnd. In regards to the filename, etc. I
> went with the first route and created a new file called io_copy.c.
> Although, I'm not sure if it's a good idea to create yet another file
> that serves a limited purpose. But I'm a bit afraid to add the
> functions to iomap_copy.c because there is no common consus in the
> architecture code about memcpy_{from,to}io. Some specify it with
> _memcpy_xx, some directly with memcpy_xx, and another bunch uses
> __memcpy_xx.

Just for clarification: the idea in that file is to have a
generic implementation and use that on all architectures that
do not define their own, hence the "#define __iowrite32_copy
__iowrite32_copy" for the three that do. The exact same method
would clearly work for memcpy_fromio().

At the moment, there are 13 architectures that define a custom
memcpy_fromio/memcpy_toio/memset_io, and nine that rely on the
fallback using memcpy()/memset() in include/asm-generic/io.h.

What we could do here is to first change the fallback
implementation in asm-generic/io.h to your new generic
version and then remove the three extra copies.

> So, if we want to merge it with iomap_copy.c, I would need
> to export the __memcpy_xx symbols for all architectures that don't want
> to use the "generic" memcpy_xx functions for now or rename their given
> implementation to __memcpy_xx, right? But if you think it's better to
> merge the two, I will have another look and modify the code for all
> remaining architectures as well.

No, this would not be necessary: the architectures that
already have a custom memcpy_fromio() etc can just keep
using the same one. Cleaning those up is something we
can do later, in which case most of them would probably
converge on the generic version.

     Arnd

