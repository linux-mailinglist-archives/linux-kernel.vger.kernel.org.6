Return-Path: <linux-kernel+bounces-250634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9892FA4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4409828494C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC5116EBE9;
	Fri, 12 Jul 2024 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GvtxtZN9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jwvNGdW3"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE316EB65
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720787344; cv=none; b=PBdKCVr0/3XZHw1GY1zv5t+Y1f5mR7W0jHhGV/eUCnY+pMxO2ediN22v9iovajYUeg9D7xR2LeSAfugJ/4TNHNGTYE5MmSXg2M/YZ3MNHmlaOJJT3dxm6BqbJ41yBQ+qQ5vMz8j9hk0MeBvH9iMNuU98nTHH1hrUg6pdmBZUY2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720787344; c=relaxed/simple;
	bh=lJ23vDx6v+OivJuVkN9SXhsy0zNALvQx9pJz/uUZOEE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=G0j2APqzBordAcHpOOanNkHdWm5VU7eq+ygLkB3epWy42Cr68Rzby9MaYZSHUOgUJAgIuKs5SSbcuBAvHFOb2+7U86W3PboQk84sLwIn2OIUfJbGs9c0w1rdb2X5SCNIy90vHEK3pxEEBCqKSqB42Fuo3D6/mpBxPVuYJI5IkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GvtxtZN9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jwvNGdW3; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A65401143995;
	Fri, 12 Jul 2024 08:29:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 12 Jul 2024 08:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720787341; x=1720873741; bh=eARDcejekm
	zNYMJwYKo8pcFYVkx5npQBheYRXF8XDpA=; b=GvtxtZN9Sw31Hud51fOpdUdakl
	msKdbZxb3rSKDAjYlBojdXebnVb1jB/D+LKzm7n7FnqANh8fuwBBc51ljiYuU+bs
	+zC5lvWRr3jptSQCYsdpLEQA4zBZaGWz9Ini9qihTunEdFZe6BqUxcQc+tbPVXR9
	ZtezT7tZxc393xgRqmzv5W0vLqUsIjX3GdcQ2Irt0NE9d8cppyEzyUCSOKkk+sC2
	xWD8/MxzrYP8L90UfwhJ/i4VT4tb62fd47p4QUnVGSPpPKGquejZqXGNp/cBK8lA
	6aDXK9y561ohfIvGZAzu87qBnvvFnJzGcdIeVQCiSU0lXxOBLSkMsZ+dpmTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720787341; x=1720873741; bh=eARDcejekmzNYMJwYKo8pcFYVkx5
	npQBheYRXF8XDpA=; b=jwvNGdW37kLHQ/ZQ97OXn6GuYYGukE8lTs4Omd+h77vL
	wkLvkNXq8gPRcuFCNZNnIzHIxh+KSZtgiAzjT4/mcfQGIZl8AYDjwdvMYamfhnqD
	Y30UYgTEe3ETwY2aqbf60YYWlgs5MSV6fwSv+ar4s0+HwWwLCI4hhO9OvG2KWUyi
	o0OaQvfkDNtO4tbosou+b0+PRr4NYNdubpHQ2/276SjWPruTN47nesZaorcgZ4XH
	XQy8R+t4KSWTgY4MqvU1uJJ+v7VrUsPU7+8rLOact1vOpHs/8VyeyDJr7e+hD7kV
	OL73t79y/w/yhWoFX//rqfVz90D4qOBOWXzYtRxPuQ==
X-ME-Sender: <xms:jCGRZq3uUFVKhbwyMBw4NFA1gP44hW7S3Lzt_MNMc_u1VwoJvvvnwA>
    <xme:jCGRZtEpV18r5psZRDuOFZRxPHh76jIWfmAD5dW7R3fS8ekVGiYP7c7nSE6pr8UL-
    AlSNgTwkDByRo2sSrU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:jCGRZi7suqma90bfZ8c6k0Aitfhxd0AifSdA-G0EUX0qA2fSa28rRQ>
    <xmx:jCGRZr1PExgpIjPjwcIWQsizX0gbhgsbYWq5CUZTOnD-7TonQHtMQA>
    <xmx:jCGRZtGFXD6YuR_xNQY-C9dw4EA6KOynwYXuRU00uJ0GGYEcCNnxww>
    <xmx:jCGRZk9cMcmsty-WlzKFmmYyxFOdZLNm_gncMUdAiYzw7GY2M1py-w>
    <xmx:jSGRZk3KkijdRMCWDTeDWtIZ8hoyhMGeHrRGUgYkRiAyX5NgzoDJOTs6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id ED5C0B6008D; Fri, 12 Jul 2024 08:28:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e25a690e-6cb9-4e00-ac1d-07cda43b12de@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYv0xfJbt=+STRDu65G-Tq_w9wEH3C0q1ucyoAa7DbWLAQ@mail.gmail.com>
References: 
 <CA+G9fYv0xfJbt=+STRDu65G-Tq_w9wEH3C0q1ucyoAa7DbWLAQ@mail.gmail.com>
Date: Fri, 12 Jul 2024 14:28:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>
Cc: "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Peter Zijlstra" <peterz@infradead.org>
Subject: Re: next-20240712: task_work.c:(.text+0xc2): undefined reference to
 `irq_work_queue'
Content-Type: text/plain

On Fri, Jul 12, 2024, at 14:13, Naresh Kamboju wrote:
> The 32-bit arm, mips and powerpc the tinyconfig builds failed on today's
> Linux next-20240712 tag with gcc and clang builds.
> The defconfig builds pass.
>
>   GOOD: next-20240711
>   BAD:  next-20240712
>
> Build error:
> ------
> arm-linux-gnueabihf-ld: kernel/task_work.o: in function `task_work_add':
> task_work.c:(.text+0xc2): undefined reference to `irq_work_queue'
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The call to this function was added in 466e4d801cd4 ("task_work:
Add TWA_NMI_CURRENT as an additional notify mode.").  It's possible
that we may have to always enable IRQ_WORK even on non-SMP
kernels now. In practice it is already enabled in most
configurations for one reason or another, the the cost is
likely very small.

Otherwise checking for CONFIG_HAVE_NMI in the new code might work.

     Arnd

