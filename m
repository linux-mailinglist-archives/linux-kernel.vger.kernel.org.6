Return-Path: <linux-kernel+bounces-523784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E69A3DB3E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19C0179F49
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB341F8EF2;
	Thu, 20 Feb 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Tj0Y5N/E"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D71F7910;
	Thu, 20 Feb 2025 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057852; cv=none; b=FEJ0o8Y2Ud7CittKzIxnEzZ5Vix85hM7wxd46Y55MwvUhdQaIq+PNAT7E4EDBN7MhWyEsyUwGtdJGmfOAEwDvtH82EZr7Ty0MeKTjKsewtZMYX7gpbKqPXfDwhH3dx7N190tXPhnbPZFFwtK9FfgfDuIPwh4JM4CDNjae9XZjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057852; c=relaxed/simple;
	bh=dOdvPQ6dysn6f0iIXIyYxVeHePOqbU19F/Sa7CvIDTM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=is8MGLFazHOcIymx/V6Vk+/lCdlZ8YKmpylp/VF/T7Ra7G9YpakzBoIPY6g9zuQzCpwOfVHTapM0DiK1o2hym7Wr9dKfc177PsDv5TP+1IaFApFd68P0f9h4uulVlFKZ6uAl9pmifjCNkfNR862zPCrvSI8xY7X6e+ImmcY84Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Tj0Y5N/E; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51KDNsoG2216050
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 20 Feb 2025 05:23:55 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51KDNsoG2216050
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740057836;
	bh=dOdvPQ6dysn6f0iIXIyYxVeHePOqbU19F/Sa7CvIDTM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Tj0Y5N/EqrIWF7XArfkaqfFvxuxq+3zvBT3x0KkfhTyLbBSQKLYbYCgOcjJnZWnpT
	 N3+Pv5klrOvIxfClH4UIdZzltn1uYPQsFCCHDZaFJ9HxCpfiedhi0Yd74jnzVJBHL5
	 D3GWAGJqD6HapImgkKQkr4AyksDoCmjRlLMS9rAH04lCtBsJ3q7+03bFWdpXLntXCq
	 /pe8Dch6qmVvHl0L2rkKi6cRCzufEh+3/nYAhEqWq2wiCJfjne1BeYU2DahEsH+A/W
	 eOl7LrOK12XyEhWO3yyzzhoQSez0+M8lUmayto/AWxdUZ/IQF4GlKQyNuQbcax0Ufi
	 +LXvnkvwpVSBw==
Date: Thu, 20 Feb 2025 05:23:54 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Greg KH <gregkh@linuxfoundation.org>, Jan Engelhardt <ej@inai.de>
CC: Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
User-Agent: K-9 Mail for Android
In-Reply-To: <2025022052-ferment-vice-a30b@gregkh>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com> <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com> <326CC09B-8565-4443-ACC5-045092260677@zytor.com> <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com> <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home> <2025021954-flaccid-pucker-f7d9@gregkh> <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr> <2025022052-ferment-vice-a30b@gregkh>
Message-ID: <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 20, 2025 4:37:46 AM PST, Greg KH <gregkh@linuxfoundation=2Eorg>=
 wrote:
>On Thu, Feb 20, 2025 at 01:28:58PM +0100, Jan Engelhardt wrote:
>>=20
>> On Wednesday 2025-02-19 06:39, Greg KH wrote:
>> >
>> >The majority of bugs (quantity, not quality/severity) we have are due =
to
>> >the stupid little corner cases in C that are totally gone in Rust=2E
>>=20
>> If and when Rust receives its own corner cases in the future,
>> I will happily point back to this statement=2E
>
>I'm not saying that rust has no such issues, I'm saying that a huge
>majority of the stupid things we do in C just don't happen in the same
>code implemented in rust (i=2Ee=2E memory leaks, error path cleanups, ret=
urn
>value checking, etc=2E)
>
>So sure, let's make different types of errors in the future, not
>continue to make the same ones we should have learned from already
>please :)
>
>thanks,
>
>greg k-h
>

I would like to point out that quite frankly we have been using a C style =
which is extremely traditional, but which have been known to cause problems=
 many times; specifically, using *alloc, memcpy() and memset() with explici=
t sizes; migrating towards using sizeof() but still having to type it expli=
citly, and the known confusion of sizeof(ptr) and sizeof(*ptr)=2E This coul=
d and probably should be macroized to avoid the redundancy=2E

In the NASM codebase I long ago started using nasm_new() and nasm_zero() m=
acros for this purpose, and structure copies really can just be aasignment =
statements=2E People writing C seem to have a real aversion for using struc=
tures as values (arguments, return values or assignments) even though that =
has been valid since at least C90 and can genuinely produce better code in =
some cases=2E

