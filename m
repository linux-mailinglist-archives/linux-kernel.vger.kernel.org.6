Return-Path: <linux-kernel+bounces-565174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 700B5A6625D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DCF189D890
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2287B18C33B;
	Mon, 17 Mar 2025 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="o66rMn0y"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331C1376;
	Mon, 17 Mar 2025 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252611; cv=none; b=uzm18Eg/nhnDWU7vTh0uMEp5+GlAhGIMl46v8Cl2L5lMd7NnY28TJndZXCZUx49gp7ExYGtio3lFAh7a0bAQbbV5hxDcTtTDdmE4w/NWqMbeyngsk3RiK2q1At0OrBFhS8Xz3oarIi1Pip9cqSLJ8dAvPPq7XW4Db558uMhkDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252611; c=relaxed/simple;
	bh=h3reA+aWlA6dgBfBWlL0U5BYECup4bVKgKKBy4OkOLY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GvYaymPj/q9cb7QmJLxfvN4MuZzhw5ntRb0mv4sKRgkiO3vAhUYV18OlUnlZQFe2CtsTO5f9mt3U8pu/W0po322uAxOeVVvdYEHkJWemZ7LjdNaHt+2J0mp2sz/3W0f0bXDVXxIhfX3U4+6VpsE9JF5mFmZ6GZv6OhTxVRStZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=o66rMn0y; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 331DF41061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742252609; bh=Bn+dVkNzGPe0Z7ovmJwNwQJS6CVQZAD2/ACJeTPZJbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=o66rMn0yPNUuvIyQSiQf7ptnYAMzEdFN7OsleDrB2CQagQTgTljykJk2FfhjD/LQ9
	 UgSKjgC4POLxWyEHB6PWok4M/IZxbqATub5bXDMkk12CZgnFrKoExgCxD2Sr69hjl3
	 PY0ROqle6kFVnuU3rCHDlN/tK/y1wis0hy6oe2IYZqWE7/ovoovOFWU7OtsX5KYS67
	 qq28oM9VCprG39gqqPHXENOUU+S8wi//2PMnVMO+R/fYGrNpe8kmEwdrqoL9+qpABd
	 dBqlYuMBqAQ+Le355hqT6ACIr7yrV5WP2/+1j8wkV/GV1V0xVjtcRi4wF6UdGVBX7q
	 Xf3mFqY6fxW8A==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 331DF41061;
	Mon, 17 Mar 2025 23:03:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ignacio Encinas Rubio <ignacio@iencinas.com>, Akira Yokosawa
 <akiyks@gmail.com>
Cc: dvyukov@google.com, elver@google.com, kasan-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 workflows@vger.kernel.org
Subject: Re: [PATCH] Documentation: kcsan: fix "Plain Accesses and Data
 Races" URL in kcsan.rst
In-Reply-To: <9c6298a2-4efa-4f77-81c0-b2132f48c1b0@iencinas.com>
References: <1d66a62e-faee-4604-9136-f90eddcfa7c0@iencinas.com>
 <c6a697af-281a-4a91-8885-a4478dfe2cef@gmail.com>
 <9c6298a2-4efa-4f77-81c0-b2132f48c1b0@iencinas.com>
Date: Mon, 17 Mar 2025 17:03:28 -0600
Message-ID: <87zfhjcla7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ignacio Encinas Rubio <ignacio@iencinas.com> writes:

> On 15/3/25 3:41, Akira Yokosawa wrote:
>> This might be something Jon would like to keep secret, but ...
>> 
>> See the message and the thread it belongs at:
>> 
>>     https://lore.kernel.org/lkml/Pine.LNX.4.44L0.1907310947340.1497-100000@iolanthe.rowland.org/
>> 
>> It happened in 2019 responding to Mauro's attempt to conversion of
>> LKMM docs.
>> 
>> I haven't see any change in sentiment among LKMM maintainers since.
>
> Thanks for the information!

FWIW, I don't think it has really been discussed since.

>> Your way forward would be to keep those .txt files *pure plain text"
>> and to convert them on-the-fly into reST.  Of course only if such an
>> effort sounds worthwhile to you.
>
> With this you mean producing a .rst from the original .txt file using an 
> script before building the documentation, right? I'm not sure how hard 
> this is, but I can look into it.
>
>> Another approach might be to include those docs literally.
>> Similar approach has applied to
>> 
>>     Documentation/
>> 	atomic_t.txt
>> 	atomic_bitops.txt
>>         memory-barriers.txt
>
> Right, I got to [1]. 
>
> It looks like there are several options here:
>
>   A) Include the text files like in [1]
>   B) Explore the "on-the-fly" translation
>   C) Do A) and then B)
>
> Does any of the above sound good, Jon?

Using the wrapper technique will surely work and should be an
improvement over what we have now.  I don't hold out much hope for "on
the fly" mangling of the text - it sounds brittle and never quite good
enough, but I'm willing to be proved wrong on that front.

The original discussion from all those years ago centered around worries
about inserting lots of markup into the plain-text file.  But I'm not
convinced that anything requires all that markup; indeed, the proposed
conversion at the time didn't do that.  The question was quickly dropped
because we had so much to do back then...

I think there might be value in trying another minimal-markup
conversion; it would be *nicer* to use more fonts in the HTML version,
but not doing so seems better than not having an HTML version at all.
But, obviously, there are no guarantees that it will clear the bar.

Thanks,

jon

