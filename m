Return-Path: <linux-kernel+bounces-194088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81068D3669
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174A51C240ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69679181312;
	Wed, 29 May 2024 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IuJVe1Zf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ViFZqJ4b"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B962869A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985802; cv=none; b=Sx5s30OYF56cQs/NU58jhX/Tp0HKbzzATtGv63eMBbuCQWN3O3Y541y8eMJXUBWKVBf0cxBT/hy98fsVNb9SHCxM2H/1osfjV+b46LRedYfO4PskLazs0ncLqFuicxacd1ZWsgQLx7q7rbLv2/7Gdxk0h5J0qtU2+nls1i62oB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985802; c=relaxed/simple;
	bh=ZTtRPXu1uNDYT6LgLq48Uj+HG2fXM4HZEfAeRbVg/S8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=geNje5zKKycp3yH/ABH0kxY3TVOrzFh54E2MizeUaKG8kliSl1Fh4F1d/g5FG8ec3/QVZiByIUIXbHcheEFmZO6qgc3/XdbVo6Xqj5R7lm+ApK+DyrE7bIw2GJ9JS7H7EZIdscTIPRNVHzyVodD6+lBjcSK0gDV0KomPTIKtzjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IuJVe1Zf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ViFZqJ4b; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id C24351C00099;
	Wed, 29 May 2024 08:29:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 May 2024 08:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716985798; x=1717072198; bh=sYEH2A6/Fk
	Kh/OJLUXEHX6R9YKo5fgdDk4asAVIZiks=; b=IuJVe1Zf7fCjzap6H2auKd2dqY
	7k73pHCYJbWDAJUanYcM9AGs/HNJR/yNPxYc1WkqJH+hkSc3oIMp5Bp0XUCV4uM/
	tnZhfD4Wg7FfqcJLS1iywUERe0Eu8/pgg+5d+B1eZ9vnS2ac41elIsXCb/DgryvT
	8J/vbIJyNoYKbv4ixoLAjJYgW3QRNzE9IF/h9RUNuEXU3VrlbOrDhUt/6XMpVeJQ
	4NQeUjHrdAVVCBPHjZ/5yl2uaJrptDlqG2iFRT+C2djZMhInOphs75V79UsKagT/
	RuuaGVIbM2mh0eOQxqAU+5kxzz7/aVSJhhA4VXM1RJud+FkiohYIdKHFFe6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716985798; x=1717072198; bh=sYEH2A6/FkKh/OJLUXEHX6R9YKo5
	fgdDk4asAVIZiks=; b=ViFZqJ4bqYqRAZUaLYl8b9eN/AoyJoD27teUzLcTqKgH
	rbnX0OKFWV08aKLDLKzVYW6R4ocyiTaQ9bEyK/5Lfd53iD8YsmU5BjpUlshDFew/
	8/O/IHGGcuZGO2Q3ayOcx8dxXAuRDZl9tRFZzhoBSJjmghVVEOr/svuKnRNNmUOW
	wf1OqISEQ0ODkVZDSAS5deitJjNylvgMfMqOPEJv62fNK9qkPE3DNFbC0XXzwr6g
	fCszrE9M36QjG6tRzjV4Iy+opNdE+Boy9qP3m2M800bK5R+nDuBbYlW013ZebWxB
	n+uRZnmm0zjh240JrjnmkzRTMCsZw+5/YURHArKU3Q==
X-ME-Sender: <xms:xR9XZkLRlytlGyw4d4A60DnhoP5Z0mhayQaUqevlNAAsEl8-PtorzQ>
    <xme:xR9XZkKBc2KroIEg_hMnfT4tJQWIwV_KkPYpaZK47UDe0CX5RQYWANO6osvadR325
    LdEvH56cCG_28a_opw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xh9XZkuthw1-7YQQjH4tPQafzhSaYVcFu3a1CRBq4kLZ-Aik_7P-Kw>
    <xmx:xh9XZhaXfbhpLSASX4oNdbkYVPT9r5YMTXBokUe4-J0zdT4VxN9TFQ>
    <xmx:xh9XZrbcwvsKW3sL-_8_ahozUP7o2APrIxAtfLAqyJ8dnaAwKpyV7Q>
    <xmx:xh9XZtAZ8hC2H5fgxF7YxlQh-x8KAl9p91lfOQthPhnDeovrTWtJow>
    <xmx:xh9XZlmpHqbCLS_ATCbpwQyFkC1K3gVVT2qMx0Egx-kIJJ9vKn6OTcze>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E0E08B6008D; Wed, 29 May 2024 08:29:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8ff9bc52-bf2f-4856-9335-14bf659e7e4c@app.fastmail.com>
In-Reply-To: <ZlcODqVXTDh6n0h-@J2N7QTR9R3>
References: <20240528120844.3523915-1-arnd@kernel.org>
 <ZlcODqVXTDh6n0h-@J2N7QTR9R3>
Date: Wed, 29 May 2024 14:29:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Rutland" <mark.rutland@arm.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Valentin Schneider" <vschneid@redhat.com>, "Baoquan He" <bhe@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/io: add constant-argument check
Content-Type: text/plain

On Wed, May 29, 2024, at 13:14, Mark Rutland wrote:
>>  {
>> -	if (count == 8 || count == 4 || count == 2 || count == 1) {
>> +	if (__builtin_constant_p(count) &&
>> +	    (count == 8 || count == 4 || count == 2 || count == 1)) {
>>  		__const_memcpy_toio_aligned32(to, from, count);
>>  		dgh();
>>  	} else {
>
> I don't think this is the right fix.
>
> The idea was that this was checked in __iowrite32_copy(), which does:
>
> 	#define __iowrite32_copy(to, from, count)                  \
> 	        (__builtin_constant_p(count) ?                     \
> 	                 __const_iowrite32_copy(to, from, count) : \
> 	                 __iowrite32_copy_full(to, from, count))
>
> ... and so __const_iowrite32_copy() should really be marked as __always_inline,
> and the same for __const_memcpy_toio_aligned32(), to guarantee that both get
> inlined and such that __const_memcpy_toio_aligned32() sees a constant.
>
> The same reasoning applies to __const_iowrite64_copy() and
> __const_memcpy_toio_aligned64().
>
> Checking for a constant in __const_iowrite32_copy() doesn't guarantee
> that __const_memcpy_toio_aligned32() is inlined and will actually see a
> constant.
>
> Does diff the below you for you?

Yes, your version addresses both failures I ran into, and
I think all other theoretical cases.

I would prefer to combine both though, using __always_inline
to force the compiler to pick the inline version over
__iowrite32_copy_full() even when it is optimizing for size
and it decides the inline version is larger, but removing
the extra complexity from the macro.

According to Jason, he used a macro here to be sure
that the compiler can detect an inline function argument
as constant when the value is known but it is not
a constant value according to the C standard.

This was indeed a problem in older versions of clang
that missed a lot of optimizations in the kernel, but
clang-8 and higher were changed to have the same behavior
as gcc here, so it is no longer necessary now that the
older versions are unable to build kernels.

     Arnd

