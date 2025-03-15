Return-Path: <linux-kernel+bounces-562685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D047CA630FA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCF91688E6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E9204C06;
	Sat, 15 Mar 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BwEMJi2P"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA31F5847;
	Sat, 15 Mar 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742060893; cv=none; b=KmJjm1bOW1SoF3/E38JIYYi0dPVL5sPWKmFnUmzjHVuTrKJGlxNOIQQQOWaAHg/FfbAhNodsRhm70XldhbWaq3jONlqrWwZ2W4Bqn6tguRnnS/bGkQTPgILHz8WQF9EzJwQ44FqbNgrG9qT7ahgbok+A/9OokeGfFrxUifRPy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742060893; c=relaxed/simple;
	bh=RfWdd+iWooQft/JQ8SdLIg0TGNmFGd3defhv4cFGeYc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jULRHH/nJ2kISp7T5VU3mqWQaN2hpIqqgXKxffFZmFyiDfDQ0ouwgn8KBSTMVlA3Ib7t3kLnFIKr6HsE2NWViAFvIwQ/1qR/p330euPU701zYrWCzk52nzgq0keOZ793Sq5em5sY85AyNL8g61OoON6/iHEIymafKdTcDpySbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BwEMJi2P; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742060889; x=1742320089;
	bh=VtOFGapc7Hrt2pxDRBLYPcGygqLzAZFo+RD/jsMgI5k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BwEMJi2PL1DFvKgfMGsoGkUljR2PXCB+/15LBqPuAVGcYIEl0IEwJ7E5LuR03qGaH
	 P9Quh9kdfw0SWeDmrz+SkoV5BfBQI1lJxwgFWVTebuEdf96koZttypj/dRgQAXISAb
	 KUhmFO6xznZxxCZyaALTfmq4sun2/UpREH8Do0i9eLfLKJtiV+kaPdPT1uRumOPTRx
	 TzJmMC03p92EUED0Id4iUpj2FH0ume1bhloTuWZIj1WdXRFPPRiioIlfEfNh0Wh1/w
	 mTYGpUtetGLFIu1GOF2yZ6Xod8zyykE5m/wfRYHmspLihDOfpP4FAYyxg5AELEIEYA
	 wpg3XwU87NaBw==
Date: Sat, 15 Mar 2025 17:48:03 +0000
To: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust/revocable: add try_with() convenience method
Message-ID: <D8H11HOL93UD.31F853PYJA9U2@proton.me>
In-Reply-To: <D8GWQXK312SX.2RI3EOHM1QGG3@nvidia.com>
References: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com> <D8F7D2RPRVAO.2EF39MZXM6FPR@proton.me> <D8F8E4PBHK7O.399Y83M1L3XK3@nvidia.com> <D8F91L51P2EA.2FBHGJYSV06HY@proton.me> <Z9L-Z4Aw64Hi5Lj8@pollux> <D8FBUHBNPIEL.5A8GOEMPJSEA@proton.me> <D8GWCWYM15WI.3II7R71LIAEI9@nvidia.com> <Z9WL-95sJ0DCpaPa@pollux> <D8GWQXK312SX.2RI3EOHM1QGG3@nvidia.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3c6b8247cf645c614ea56d9a7e76be0677e8c9d1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Mar 15, 2025 at 3:26 PM CET, Alexandre Courbot wrote:
> On Sat Mar 15, 2025 at 11:17 PM JST, Danilo Krummrich wrote:
>> On Sat, Mar 15, 2025 at 11:07:44PM +0900, Alexandre Courbot wrote:
>>> I suppose drivers could add their own macros to do that automatically
>>> and reduce code verbosity, at the cost of less cohesion across drivers.
>>> Guess I'll go with that if I cannot come with anything better.
>>
>> Maybe we could do something more specific but yet generic on top (for th=
e
>> use-case above), but we still can't assume the exact error code a driver=
 wants
>> to derive from failing try_access(). So, maybe a driver specific wrapper=
 is
>> indeed what you want on top of what this patch provides.
>
> So be it! It's not that bad and more flexible in the end.

You could have the following signature:

    fn try_access_with<R>(&self, on_vacant: Error, f: impl FnOnce(&T) -> Re=
sult<R>) -> Result<R>;

That will use the `on_vacant` error instead of hard coding ENXIO. But
maybe it's better to just have such a wrapper in drivers that actually
need it (ie even with the concrete error specified and not a parameter).
You'll know better through actually trying to write a driver.

---
Cheers,
Benno


