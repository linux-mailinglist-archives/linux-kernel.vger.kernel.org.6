Return-Path: <linux-kernel+bounces-234550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CAE91C7D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52026B2409F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5C07B3E1;
	Fri, 28 Jun 2024 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Jh2KpHTB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jMqQGIBa"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CBD7603A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608961; cv=none; b=PiaC+WsoPGohNpXV9RKr0tjel4QUP9xS96dRQkoCy9ilZo8BNP5GcTGrQHJ0kngxKOfDjomzHeHyOupjx0eXjqkj3MlxOwrbyikpOACYexTNOR/I4wO5jH2zflNxvI9QUzrLb+0/jfhTaWz1MKmb6mtDx8ksWTAZXnN7ZcMj1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608961; c=relaxed/simple;
	bh=0qZJDGeuMw6g6Q4rr7lWfel+F3Oz08lh5E2NhPjZhcM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=uiyx+CyZIuPW51gbFMkjJnEoshmfsFPTwveLIyKSeuwJ3HeXA7ndfkwncHstxNe7JZhaEgHYXuJORIEsQnNt7zWv5pVQ5gbA4qG5KXlJhJ71sTF2U8xaHI8mgMsmTIQdftmDE64pI2lDThANn6sG41mDRR8X0EFdYaS+6yJmgTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Jh2KpHTB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jMqQGIBa; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 19017114024E;
	Fri, 28 Jun 2024 17:09:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 28 Jun 2024 17:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719608959; x=1719695359; bh=scgODfwNL4
	CYgwQvZcaLwj7iE8a/wz2sFq0wfLTcPuk=; b=Jh2KpHTB+wPSS+NB3D6qQQ6XGa
	XRg//MuqGnF/27VM2cnj27V/o7gYkq5Rl4WcLCWtI9Y26Ybnsbh6BuJgzEMPrRX7
	yZIzil6qldcUkYoEoaoBe8ZBr4rbF7noqIJXqu2yHA1j/1ZGiXlf3D2A2weFLCJ/
	9jQEzpZJraXNANmVDn5vtRYyKuAm3iBzMyIMo49LAMALSh3tEr++fokBhIG6nWXa
	Qx2hOTAeUaXrGxGSb5sUo+4SRDpjeLRIDnDUTo0Np9/DHtUB4Jq89F2O/JriLnpF
	xqxdm4QO7pUUbCdj3sXloFTVQKfha3Ad5Unj+CQjpmzp9IqCuohEvpi3VfJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719608959; x=1719695359; bh=scgODfwNL4CYgwQvZcaLwj7iE8a/
	wz2sFq0wfLTcPuk=; b=jMqQGIBaDf2k5fWi2k7jhNzL4gD2DizK8YYu0laz4+tE
	tkMSEjk+N+aLX9cWsF0QjYAjY/FV8BccQnAfEJeh+mL/yCnBi4ZJann1IRjGhahS
	Mo2FO6B+3wP6rL14ctnzTcU2PoznU77ADiid5zoGixzA77vvsphHzdJjhvFCpsSr
	gYy4ozA2qoxpJEpGiRrxi8lrRj2RNpfkH9vuIXGhXOg8NkmXL6GRhxrEXm8XYgIJ
	plLMNihmGLy98kOQORqS2r3tiocN+8BRgLGUtESnql622yQaJxRPCgTE7fG8FCF4
	SevVR+jgUUl0VqUy+bm+3V4uhSY1elSs9gFmaYb3tw==
X-ME-Sender: <xms:fiZ_ZmhbqDxbrVN0aQp8ULDXU-FRKDJVwZ_9CsBBVgwEonQTAN-ocQ>
    <xme:fiZ_ZnB3pNHJJ8nIQUqtuCxLAec7ikkqlHDqogFHPQMydqyskr71zrrpOKB70wh-q
    J_E0J-tKs4A78PCVps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdejgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:fiZ_ZuHS9ThZbeOCz9uN-xzIJnw1Q493EgmzFdpNQc4gAuigGtdKtA>
    <xmx:fiZ_ZvRbcOZAuciv0mMYD7GOnOnAP6Pyh9j_WwLWTz5g7A1jiiK5sw>
    <xmx:fiZ_ZjwjqKnmMB0kwJ6QLkNSqreoIHnSjF2UbaymDVkCp5ZRWwxizA>
    <xmx:fiZ_Zt6EdVC-1LjEl-4JhHWpbU4WuSM5yjyxec5UhehUbpcRewslGA>
    <xmx:fyZ_Zqy92pTVURsYJXmfJvfZtHix0T1VsQyEGdo4eQNIl5s2r2YNFr3o>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BC952B6008D; Fri, 28 Jun 2024 17:09:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dcb8c64a-3dbf-4e23-83c3-2bb99b285f62@app.fastmail.com>
In-Reply-To: <ed9dd921-56a6-48cf-9f25-b8bb079c4249@app.fastmail.com>
References: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
 <ed9dd921-56a6-48cf-9f25-b8bb079c4249@app.fastmail.com>
Date: Fri, 28 Jun 2024 23:08:55 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Daniel Mack" <daniel@zonque.org>, "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Linus Walleij" <linus.walleij@linaro.org>, soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] ARM: pxa: use software nodes/properties for GPIOs
Content-Type: text/plain

On Fri, Jun 28, 2024, at 22:59, Arnd Bergmann wrote:
> I'm happy to pull these in directly, hopefully with some extra
> review or ack from the maintainers. If there are no negative
> comments, feel free to resend them to soc@kernel.org for me
> to pick up.

I just saw that you did in fact send it to soc@kernel.org
already. I'll wait for comments then and just merge it
if nobody has any objections.

      Arnd

