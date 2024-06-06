Return-Path: <linux-kernel+bounces-204116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE58FE465
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05361F24296
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD43194C9A;
	Thu,  6 Jun 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fjgmxjsN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9c9hgd3"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6514A63D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670076; cv=none; b=TL+q59CJoVJV20uz99hCPj8RU2cu7LuhBvgK5ZBHQpJVmYV/+FnnzxEWymG/1/qJKpYHboNOl4vU26wBg2onagwwWVbBk1PyujuxF9Xh9gx2YU4CwWrhAkjPz8ZIHK8UlxwwP/+nlGR3B46MAG4bp+qE+PUGGuu6sYIAtd/Deno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670076; c=relaxed/simple;
	bh=cvyZ/7L1W/sMKUoGTzgpr7rHrNNeRA3a1PKzfaJ2JeY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=Fd68Ry2es64mFu6bnW+dXo40Z0214B84+YBxztEGxrFVhLjwJDy8tbcXobtvcGGiU6rkYQosRw7XEw77zkCO4H82wqEKgt1Qq2n5htKrkWHr0PTkQhaA9e5YQsKdEL3ZqxbGi2rEB9XZ2shURvvrQt6xgm4yrBUfIRDBphcIuZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fjgmxjsN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U9c9hgd3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A158B11401C0;
	Thu,  6 Jun 2024 06:34:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 06 Jun 2024 06:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717670073; x=1717756473; bh=jXJvaMIeMq
	D7KMAhp02FWS9gqDr1lXH41UZet54nW88=; b=fjgmxjsNcRBWSJnJtFwh1wG2yn
	fjbyCkvAqbaSOgyl3rOAr7jMzGjoTQbYrSKzuuWTCmga4EPlsiBEZZaA8cCxgi/9
	dakxT/csYGIXe65Zi8qDFGQLehzRl56hmxQsaxkedYZd7JDPN6Lzb+j5sFesFMwf
	U1Wi6Umwq+nZGkWucTf10pD9UMij8inhdu7xzvquefdG3EeR6QzV5MkuFlHpFI7U
	/2ANaA3gQBjekWtCifQEqQT/79mJb9jg1jiUtisU0dyrdTZKE8xLoIuOvlpMmlAC
	HOd3Qx7PmXyFWEQ+PGj6mQ/exFsEC206xQha52JUFu/u2UkX9ZgZbRXMcesA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717670073; x=1717756473; bh=jXJvaMIeMqD7KMAhp02FWS9gqDr1
	lXH41UZet54nW88=; b=U9c9hgd3vJy87It56sbRV6trPiqutZdi1oiT2S2GSny2
	A2oTPkApM3u0AJrpIRsDAt3Igo1TLSOjV7kUcFCJlbwNtxNHP1ehHMEp4tUC+OfT
	mvpinNz8lWiYQnzZY0SMcaXZCzTLkjnt9zOW0mH/qvlNMwlk6xc8OvExldI/f+wz
	tEq8hPQqrG2tFykzloaHRcT6lOSeQ/eqN0zo/Tcp91uHQC17Ov1+uzOlNJ4mv3fX
	qo3nXq4XROxogbT3jk6ERtrJeKHnpahcSrMvCZq8BziKvc2QOSt6iATl3DJfHxL4
	0gLEaNNVrTIlT/5Mak5jOLRvX9F4sbr+FESZsJy3fg==
X-ME-Sender: <xms:uJBhZv2DjfEoX1c5F_od8EQ5m7iiWdkLOh4043SKeTbJMey_kggr4Q>
    <xme:uJBhZuGcCFmYMok73spDiHQjO2jGtxspCQIqc2RO_QvCV7ezkN1amTEP2x0ygH2FF
    ogvM9TOTmBhxZf5beg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffgeffuddtvdehffefleethfejjeegvdelffejieegueetledvtedtudelgfdu
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:uZBhZv5JaVoJ3E9gvza1A6M4zAuqyjK9Yvvifpl8YR7PeNXJJAq07w>
    <xmx:uZBhZk0hWtarkEmS-kYhur8PdO47KK-IYMmXwW3eNdqMN0jx_JGkbg>
    <xmx:uZBhZiEgi_MJggWRykZN0ImqbLeE63axFEe1uVcr3-hB57gByru2bg>
    <xmx:uZBhZl_wbG4e9gliIvtZd-8Xp62Pr8K4zkMUBLVCpjE7HtuER448LQ>
    <xmx:uZBhZuBiuYk8ju7-vs9hqMAougaqg7dFBtfzfHYTUMu4SWdq5eZKd-YE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E3817B6008D; Thu,  6 Jun 2024 06:34:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5050968c-6807-4688-ad7c-24c19820f1e6@app.fastmail.com>
In-Reply-To: <20240606094620.3946453-1-zhe.he@windriver.com>
References: <20240606094620.3946453-1-zhe.he@windriver.com>
Date: Thu, 06 Jun 2024 12:34:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "He Zhe" <zhe.he@windriver.com>, "Clemens Ladisch" <clemens@ladisch.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hpet: Support 32-bit userspace
Content-Type: text/plain

On Thu, Jun 6, 2024, at 11:46, He Zhe wrote:
> v2:
> - Use in_compat_syscall to determine if we're handling 32-bit or 64-bit
> - Drop unnecessary compat_ptr for hpet_ioctl_common
> - Add comment for COMPAT_HPET_INFO and COMPAT_HPET_IRQFREQ

Thanks, this version looks correct to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I would suggest one simplification though:

> +#ifdef CONFIG_COMPAT
> +	if (in_compat_syscall()) {
> +		if (count < sizeof(compat_ulong_t))
> +			return -EINVAL;
> +	} else {
> +		if (count < sizeof(unsigned long))
> +			return -EINVAL;
> +	}
> +#else
>  	if (count < sizeof(unsigned long))
>  		return -EINVAL;
> +#endif

The #ifdef/#else is not really required here, since
in_compat_syscall() is defined to return false when
this is unset. For both cases, it should be sufficient
to keep the part inside of the #ifdef block.

     Arnd

