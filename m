Return-Path: <linux-kernel+bounces-194425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED428D3C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC2D284B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD06181CF8;
	Wed, 29 May 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Q8LDi+pE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BFLNSryf"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E03E576
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999382; cv=none; b=kCf0B3T85+1uyZhmYWpCH7O8Hao+FbNXPjpVf+N+BI8l/njMpS2Q4R9gs04oTB0zmwNNZmpe1pNbwnKJ9ByRALgy5O2cwwtnwF2F2MhDD8P9rmluScCmEBtSbYIZqx5hYDRJn9l+6VHv9SUWlG+eOEW8GmL2oXO37plhAx/8W8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999382; c=relaxed/simple;
	bh=EqJAejCEwHBD1o0Ooto8/uootPIHZvzUkap3vf1e8uk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UJetdA1gBHeCT86y7QmtOEHM4JO+qvCf5mkE/CprykROMfel4Y2lQJbfNTjPv39JWp8iFfFVoCv3c2kayDZ1l1HEiW2ou8aBXLmTRxvFBZuUOEZ4ICpQ88g03EHUnDOGpJupk/8AZDq0ZhvWdAK11OiQs8KM32vZ6njOS2zlmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Q8LDi+pE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BFLNSryf; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 006A31C00175;
	Wed, 29 May 2024 12:16:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 May 2024 12:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716999378; x=1717085778; bh=S5R/JNc7/l
	jjEDZ3hBxEn5WrA7aCH0n4qM8QxOATcnA=; b=Q8LDi+pEkl8jmoVGODM3muxHEC
	4ViCjDv09nJCOO3eGQAdeL0kQWr5qukJ11VNGULC65KzjXBVpjb7jlLkzIxCLIVQ
	Vj2BG24UD0J+yJYYNlWH7y++9LzWFS1vyjKImxp/NijFsFBeGNtgCKLtkVA/3g5p
	42CIS7fjk1VLcNfPzIC0lEldu/7IZgZFl3jiAwL/C6yW3mikfZ4/3gYvIo0PbONx
	NuHSSj/xXVeHS6r0FeCy01y1Fypxr0uU9aypZQMnwLHH6AVF/p6DifFN+zYu6ZGr
	IQLklZTjnCbwNBSiJ39jLIjEn6LAz4HDk4r5III11eVydnvP3rFcDLB307sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716999378; x=1717085778; bh=S5R/JNc7/ljjEDZ3hBxEn5WrA7aC
	H0n4qM8QxOATcnA=; b=BFLNSryf4sMuzc9P4UMBOF05JAQKHeBH6X+wMxXO7Pox
	EZZRdakrfF9YFkOxRwjtw7CInpoV5LtBVse+tUCP7HGI2mfyAKlyFFa85HsvZ5lE
	g11lc/3oMDxXa5GgYxTd34oo8dWLOOmVawMqVAOTKBWPLX+NSqwjzXTmfxniCIy8
	xExm4cUVCK5/Hamq0nkuCDsCaIJZQBIG06yPc/gZd0Wi7ThvTemdt5ML5pnqjhkR
	b2E43M4ODU7Ynp0N1YV6IZys5cpEiRDNcDoH0DqldGmX10rcd4VUQu/ULN3Woykr
	pBL6OXFffJ9zrJxu89CAyl1a2g8rKLRkU9zJtKZpmQ==
X-ME-Sender: <xms:0VRXZh2Gp1a6mCgY3GDoBNCXPK8mhxgNznya3nHtXyHNtzALKJPDyg>
    <xme:0VRXZoFEhHhT2QScuAP1cFGhKQ0iIFfQcZV5aIq4d80CGwqrGDaC7sRa7rpLLkl6J
    tqPrJ1OJKCeIe1Bu4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:0VRXZh5pKSJ8xvGzhh8Uyawly2wHoXCWg0fSQ_Ox1cW5OJHz3_dGqA>
    <xmx:0VRXZu0hnvB36swEsrKZIq7aN4rUGWeaaClyt5j0zwP1g9hg0JGgRg>
    <xmx:0VRXZkEkj47I93QQ2SlWRS1wPspVgMmvrJ9Z16A7AVDzs9chVaShiA>
    <xmx:0VRXZv9xV5jf9qGzJSdqBPKR9mAU_NwDDYNyce9cFNFFDgEphEb2Qg>
    <xmx:0lRXZvCX47DJbfejf-1iTjXIo05hrM1kIuYtaUj96QFmy8vZ47rgTCd9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B3A83B6008F; Wed, 29 May 2024 12:16:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c63093a6-6787-49ba-ac23-8e27b4861560@app.fastmail.com>
In-Reply-To: <ZldE0dp7cBpZl4JY@J2N7QTR9R3.cambridge.arm.com>
References: <20240528120844.3523915-1-arnd@kernel.org>
 <ZlcODqVXTDh6n0h-@J2N7QTR9R3>
 <8ff9bc52-bf2f-4856-9335-14bf659e7e4c@app.fastmail.com>
 <ZldE0dp7cBpZl4JY@J2N7QTR9R3.cambridge.arm.com>
Date: Wed, 29 May 2024 18:15:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Rutland" <mark.rutland@arm.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Valentin Schneider" <vschneid@redhat.com>,
 "Baoquan He" <bhe@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/io: add constant-argument check
Content-Type: text/plain

On Wed, May 29, 2024, at 17:08, Mark Rutland wrote:
> On Wed, May 29, 2024 at 02:29:37PM +0200, Arnd Bergmann wrote:
>> On Wed, May 29, 2024, at 13:14, Mark Rutland wrote:

>> 
>> Yes, your version addresses both failures I ran into, and
>> I think all other theoretical cases.
>> 
>> I would prefer to combine both though, using __always_inline
>> to force the compiler to pick the inline version over
>> __iowrite32_copy_full() even when it is optimizing for size
>> and it decides the inline version is larger, but removing
>> the extra complexity from the macro.
>
> Sorry, I'm not sure what you mean here. I don't see anything handling
> optimizing for size today so I'm not sure what change your suggesting to
> force the use of the inline version; AFAICT that'd always be forced for
> a suitable constant size.
>
> What change are you suggesting?

What I meant is that reason gcc chooses to not inline
the macro is when we build with CONFIG_CC_OPTIMIZE_FOR_SIZE.

Since it doesn't know that __const_memcpy_toio_aligned64()
is intended to be small after inlining, it sometimes
decides against it, which (with just my patch) would
fall back to the out-of-line __iowrite32_copy_full()
while trying to generate smaller code.

The __always_inline annotation just overrides the
calculation.

    Arnd

