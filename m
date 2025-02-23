Return-Path: <linux-kernel+bounces-527550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9147AA40C88
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 03:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E7844061E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 02:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685D17BA1;
	Sun, 23 Feb 2025 02:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wF3TtTfy"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227628837;
	Sun, 23 Feb 2025 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740276540; cv=none; b=Gp2QCHc3+5yeWnBUnhQN2utqNQNrcrxSNYgfJXtoGPSZhR37FMOE3huEMClgkkN2dq+u/RdBIa95rJcys1Vot2yRChJ/0Goz+gJLdc1KvvF4n3CKKimxJ9fkbngEgPmp+WoGI4tWIH6vgGg9ZpSjni27dCvZp1cBz7N3K/9/Mms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740276540; c=relaxed/simple;
	bh=vf6+ldCnaCq4Wucbk4Xinu/7Ok73HHXxjwSmqGKQ2HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3fKkoZdMWFsfafbBPPJ2pG2lEBqVkgMexea8IdOJS7Q2xLpgE8cfxaXSGVGoCNCfQCOcwFp0c5krI2FdbXqZl1SJrwv7hZkE9DF9xe2IlwcuyRyjEL0+xjPJCs0Y5Ilv6kNBXYQJURKAtvM2kTlpKezCY6+e1WrodFWa8rNwSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wF3TtTfy; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Z0nNN0PhNzlgTx8;
	Sun, 23 Feb 2025 02:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1740276530; x=1742868531; bh=lEZjZSgan1NZiPLT5501plBl
	+F63xZotvQMDWo+b+Ds=; b=wF3TtTfyhuO1WUfVVWi52zxkG1yQBr8UN9Cdb+G7
	xrcctzdP1fua5ne1gp7t8rU6+b+rrmkQ8zUm9bdPS7BiwSY4pYDDsCyZIED0qYmA
	fslTn0pQooeJ8IigrJ9Ofn1nJhXTFqH4t0BfmIsLp+2fSuk6OxLRzvGObTlffRPr
	c0gXW/8colUbSQFOoudBiP73O6nYB8jN/qwDOYDYY2Uz77QnZl369OaEnvyIgQUO
	Yyf5vNRsMrPNRBu6Xfd9JULSLqMBHK6Ro+JWOtdMl1NC9YWqg6p/NMrA86Au0agf
	W3nI/TU2qQQ83nDLCMSvkGxX0K1Z8oBPbUv4grSTIyQTyw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Svh3k8lE6YPe; Sun, 23 Feb 2025 02:08:50 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Z0nNJ17K5zlgTwy;
	Sun, 23 Feb 2025 02:08:47 +0000 (UTC)
Message-ID: <11e58048-9cc5-4d7a-b96f-54f9a44e0133@acm.org>
Date: Sat, 22 Feb 2025 18:08:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rust kernel policy
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <sbcgis4vibueieejklfvv5zgz5omirryjyiynd5kloilxfygqb@zcqrjc6snxey>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <sbcgis4vibueieejklfvv5zgz5omirryjyiynd5kloilxfygqb@zcqrjc6snxey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/22/25 8:04 AM, Kent Overstreet wrote:
> On Wed, Feb 19, 2025 at 06:39:10AM +0100, Greg KH wrote:
>> Rust isn't a "silver bullet" that will solve all of our problems, but it
>> sure will help in a huge number of places, so for new stuff going
>> forward, why wouldn't we want that?
> 
> I would say that Rust really is a silver bullet; it won't solve
> everything all at once but it's a huge advance down the right path, and
> there's deep theoretical reasons why it's the right approach - if we
> want to be making real advances towards writing more reliable code.

The ultimate goal is probably that we can prove that code will behave as
intended before it is run. That goal might be difficult to achieve. It
would e.g. require a formal specification of the requirements, a formal
specification of the hardware the Linux kernel is interacting with and
software that helps with generating correctness proofs.

This goal falls outside the scope of the Rust programming language.

The following issues are not addressed by the Rust programming language
(this list is probably incomplete):
* Preventing DMA controller misconfiguration. This is a potential source
   of memory corruption that falls outside the scope of the Rust type
   system.
* Preventing privilege escalation issues.
* Preventing security configuration errors.

As an example, one of the most significant security incidents,
log4shell, is a type of security vulnerability that cannot be prevented
by the selection of the programming language.

Bart.

