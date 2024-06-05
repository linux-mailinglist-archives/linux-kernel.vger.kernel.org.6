Return-Path: <linux-kernel+bounces-202242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB228FC9EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59251C24142
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CF11922FA;
	Wed,  5 Jun 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Z/dW1V/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HKZb8F41"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0336190490
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585960; cv=none; b=mrNoAEjlDtvV7ox2VyC2w9/gQJw9MJwLurNaRffODeHizLDnF1+x/Aw2ub7DWJTx+7aksXfGpvWspKeh7qBCLGFFl8VBpiNU9KPMkxuOXeFPcjhV1eLs0J3mMpl4c+KqEIYJWTHXgb9nqCjtKgZ8qTK/gHvbxWwwQ6/Jl9mo7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585960; c=relaxed/simple;
	bh=H4OeqS4v9XYBERN4WeYcxJy12iXmfI3Lsg5bERbc2ZE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=mNUpaUQN9KJ35pyqI8acKV4Zprvr2TwzmAsbfybzwMoj0Rhn2pRfzV7BGzJJ5b9PuzFRouvWNgAJrXIk5V5yv0ohnFuzednNnrgRzIdxGHWZmxqWArBOCxUXr4BCDViDPRDg16DTuTj8821S6/sZijcEoI8ji+CsR+MybGqvLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Z/dW1V/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HKZb8F41; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id EE04B18000F4;
	Wed,  5 Jun 2024 07:12:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 05 Jun 2024 07:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717585956; x=1717672356; bh=CP7e2tWVOJ
	LS21Dk/fSKZ9nuJKGzlXo1Ih4NyojX3uo=; b=Z/dW1V/n+WUV3r2WWfRVFQA2sb
	ufSrMZqxPlv7r6p0mAooOi7Hsx7OTVvwjy40SRxTZxhY7wkN1HIx4Kz2joo+1NPn
	N18ADVM1OY+SS5LvRvxL2s1AK+4yqP4LiTsBqQZyVDAbcIyrDipYFDdid4rY5lcO
	k8B5W3r6vRcN07qMorNHbYGYWSLgKJI2XM4f3nxXokcvgY2MLAypGfKSZQgFnPbU
	DDfV2ocaSsiH/wDlv6XoImzk1RAfhnCrC8SV2UWZ6B9bap495nDi/EsXmyXJc5LV
	h6C60IOyu5sWgWzk3L6eHlvU4EyXlVnDDa0RPBPMjBJSlehIA8sVg1X2lFwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717585956; x=1717672356; bh=CP7e2tWVOJLS21Dk/fSKZ9nuJKGz
	lXo1Ih4NyojX3uo=; b=HKZb8F41Jnm/5dF6omNRUZPh+pd8A19LNEV7ZXDwTyU+
	z4LkoqzJNVG4dCT4AKdKuiYsmCSdvYb65Zou/2zLvsyowGpkJ/+KGhEsZSnOd82c
	jzwCm0UPL1B1QbelXfgQ0vtYn93UYuqwETMB6g1RVL6gILww6al2oCJIUIHEIWey
	IFgTNIYIFdG9hdqQg0WB1KFbRq501o3ZO8eDqehp2dEkQBBzNti0tm6eXVWYNNrG
	5I4VVYoDsQLdIcKt+3FXG5j8P3AhKr2FHOamkA8LPtKZngIxlNL+xMaNRMnAVssM
	HVU/N0/oCus4g94JE14JXjzRiuAvosd/8jncA8VFFA==
X-ME-Sender: <xms:JEhgZjK5vk-6POQhs7O4cjRRyuni_i-tlo0FKvKIuCl-9Ka6zqTeaQ>
    <xme:JEhgZnLipayPRV8umdBh-WRq72PjzDP40NZmAfBwBt_qnK64ExxO-0ZfFGIASBHPa
    CueX7ZZ7H2hX_oD0C4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeliedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:JEhgZrsujCBcsJa2t2APDSyrYnbakOeT7blFAHNQARQUpCF05UJneQ>
    <xmx:JEhgZsZT81DgbfcohrWcioie6BPkQw0jUs9U7QSBofBxnSfNWh8enw>
    <xmx:JEhgZqZTqj8zAxmUwHQxdkYSpEprSJIa3uNVDbwE0UnUM3tzNiBveA>
    <xmx:JEhgZgBem7ROT7J0wPWaI8z3fqkUPIG_HoJ-00BwyewMPDk2pqco1w>
    <xmx:JEhgZgyCKYJ4tIG1EOZP4tq-emKtdJ_oLT3tyGqrH0MWeLRgZ76Qaiu9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1D5B2B6008D; Wed,  5 Jun 2024 07:12:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <73051ed4-248e-4a33-828b-c34093d5ce4b@app.fastmail.com>
In-Reply-To: <20240605111008.GA21651@willie-the-truck>
References: <20240604210006.668912-1-arnd@kernel.org>
 <ZmAsutGzL5_Kx8Pn@J2N7QTR9R3> <20240605111008.GA21651@willie-the-truck>
Date: Wed, 05 Jun 2024 13:12:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Will Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Mike Rapoport" <rppt@kernel.org>, "Baoquan He" <bhe@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] [v3] arm64/io: add constant-argument check
Content-Type: text/plain

On Wed, Jun 5, 2024, at 13:10, Will Deacon wrote:
> On Wed, Jun 05, 2024 at 10:15:38AM +0100, Mark Rutland wrote:

>> > +#define __iowrite32_copy(to, from, count) __iowrite32_copy(to, from, count)
>> 
>> Normally we'd make this:
>> 
>> #define __iowrite32_copy __iowrite32_copy
>> 
>
> I can fold these two changes in.

Sounds good, thanks!

    Arnd

