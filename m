Return-Path: <linux-kernel+bounces-548689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A8AA5480F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9467F3B30D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B5E2036E3;
	Thu,  6 Mar 2025 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ToOO+wEJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6PS1R2z"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604FD2045A8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257507; cv=none; b=U01ep7vXo/3gZJ+oZP+DqAAQBXuyIANFH8HtzjgkpVI/qvk+C8UafTg2v/dImIUw+fqW4bOE5vLcUEXWqDfrIZYViKBm8B43ql/ss00yZqEjF/3Q8r7wFDblXrscNwyCMIl95k0yRFJ1fdz5ox+JOYTPtfA1J6PKR5kh8f5D/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257507; c=relaxed/simple;
	bh=AVLMfdUsbXqEcOInj1m2//b/vELQxoqZXCwD6tdfMiQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a0Ur5mUHja4FRuo62gP8SpxVnjome0xfjuJjX1NGpEfW0plSFMs3CRaowy7qd2zRuK5JN6J3FRDDZYYd+sksQNyYjfK9QYc8nLyq1G4gu2dvcsoAY5X1GBaYQMbEMMSnmTwVJwrSRKBdSIpC57tISzQyVbVhWo9vO6EVkBueXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ToOO+wEJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6PS1R2z; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 325EF114013F;
	Thu,  6 Mar 2025 05:38:24 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 05:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741257504;
	 x=1741343904; bh=lAf5dDCCfHop1iqmry/QrUOr5MggYh2TVK2zV6PqcXo=; b=
	ToOO+wEJMwz3IKW6X2lsVh7j0m0IUT6JLYiemVVTbijYFaGd6i+0lNtjwWVa5ky5
	8vpUO37ttxgEbjUUUqXX/K68KR8l7e7eN7uMXiCFFStQL52S3y41w9teDU9UP5kd
	J5wj998bTpecDIRR3mYS7+4AlmmwjF0LdLN/IGl3ln4qgFE2ZZrTqpkBJYCjMv0M
	UNbLorSvAoMA42WCswA7YM1kzjRUj20UC73qgBwDSvu+4zJVAmrG0l06q60PkZDB
	qnQfOXTtn1R4K2GSMg2D3s0DpX/zIMSY9PydSJVqoPLU9P8c/nbnjRmUxPWjf4GG
	E6PItqz0rgsJ6+CFekhnzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741257504; x=
	1741343904; bh=lAf5dDCCfHop1iqmry/QrUOr5MggYh2TVK2zV6PqcXo=; b=n
	6PS1R2zyYG5WuLdnztm4qyyursj+8pXjnbdTZ55oS8yu13JPp55rIEa7BilUGdQx
	f0pN3TMYL59Sa2ImTO18xVnqr4VWfyDTot9hFY7dOtMtfP0ekLLHCPCMYVO9vDsk
	9s/6h6z7LQ/HO3ka2lG9+oo510/DwMVK09o3ZaAnQK/Rh38aYv4P65TQ623YViV3
	OsAhou4Y+VtLsIZ1DyoormTfXIGlma7C6tdZhCjh9vkFlhs9t/lO6kwkw4uBXhNx
	eXY3nM7PGkVqvBf7rc8+l7eR0K6fGzuI9GGWf2rjkXT1W/O3tIUh+e4Mk3gep94H
	RABYoOpdbk5bfN1Hbj9/g==
X-ME-Sender: <xms:H3vJZ2WxaFJQRjjN98yQNkcj65UEp_k6MYc-Y84OMfytSmKbsgZjFQ>
    <xme:H3vJZyliBo1dSJb0lZ-0VYBNnUjnCPpm8kdpQ6sASVj9qPkuxHvWTFTLIziBtF5XG
    TqhCRlDK0Gvjpa2F00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedv
    vdegjedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
    dprhgtphhtthhopehusghiiihjrghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    thgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggrvhgvrdhhrghnsh
    gvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgi
    eslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhu
    gidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnh
    eslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:H3vJZ6b5FMsPiuyTK_FI3StYPPVFxwHBKo74OWbTucTUNP15CUPpOQ>
    <xmx:H3vJZ9XbJK7QQng_vaG6AfJ5hJsrxJHbYrLNSLLCCqxlaGKMSVYvLw>
    <xmx:H3vJZwm80t2fe1HM5ekNzDruv-AXX5uqAWNw6k8zDysoy10wTDI0BA>
    <xmx:H3vJZyfC3G6fAGkE75N9bN00XUlZdaF9rbJ5rLnCSHRUZevAW4Oe2w>
    <xmx:IHvJZ6es07eWOn5cK8Gssc-0dke48SUWZJtdIFfyUWcI8LrTVAmc8Smj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4D0B62220072; Thu,  6 Mar 2025 05:38:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 06 Mar 2025 11:37:58 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ingo Molnar" <mingo@kernel.org>, "Uros Bizjak" <ubizjak@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Linus Torvalds" <torvalds@linuxfoundation.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Message-Id: <1e0cf823-e272-437b-b84b-b24e2d1819f6@app.fastmail.com>
In-Reply-To: <Z8luPgXr9hcO7jDz@gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
 <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
 <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <20250305203633.GNZ8i10cVCCnhhULis@fat_crate.local>
 <20250305212638.GC35526@noisy.programming.kicks-ass.net>
 <CAFULd4ZsHKA4Yh9CsxPjdoW-fa7yD1-Ov7xDN4E3J3c8O8yQ7g@mail.gmail.com>
 <Z8luPgXr9hcO7jDz@gmail.com>
Subject: Re: kernel: Current status of CONFIG_CC_OPTIMIZE_FOR_SIZE=y (was: Re: [PATCH
 -tip] x86/locking/atomic: Use asm_inline for atomic locking insns)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025, at 10:43, Ingo Molnar wrote:
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>> On Wed, Mar 5, 2025 at 10:26=E2=80=AFPM Peter Zijlstra <peterz@infrad=
ead.org> wrote:
> So the best way to drive -Os forward is not to insist that it's good=20
> (it might still be crap), and not to insist that it's crap (it might=20
> have become better), but to dig out old problems and to look at what=20
> kind of code current compilers generate in the kernel with -Os.
>
> There's been a few pathological GCC optimizations in the past, but als=
o=20
> other problems, such as this one 9 years ago that hid useful warnings:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
>   877417e6ffb9 Kbuild: change CC_OPTIMIZE_FOR_SIZE definition
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
>
>   From: Arnd Bergmann <arnd@arndb.de>
>   Date: Mon, 25 Apr 2016 17:35:27 +0200
>   Subject: [PATCH] Kbuild: change CC_OPTIMIZE_FOR_SIZE definition
>
>     CC_OPTIMIZE_FOR_SIZE disables the often useful -Wmaybe-unused warn=
ing,
>     because that causes a ridiculous amount of false positives when co=
mbined
>     with -Os.=20

I think that should have said '-Wmaybe-uninitialized', which is a thing
of the past, since (IIRC) gcc-9 changed the default inlining rules and
Linus turned it off globally after the false positives started happening
with -O2 as well.

This is rather annoying of course, since we miss a lot of warnings
for real bugs, but at least clang's -Wsometimes-uninitialized and
smatch still catch the important ones in the CI systems, but we keep
seeing new ones in linux-next and have to patch them.

> But yes, I'd cautiously agree that reduced kernel size with a -Os buil=
d=20
> is a stochastic proxy metric for better code and better performance -=20
> but it comes with caveats and needs to be backed by other data or=20
> robust first principles arguments too.

My impression is that for the most part, the -Os and -O2 options do
exactly what they promise, picking either a smaller or faster object
code. Clearly there is no single ideal choice because if some
optimization step is a win for both performance and size it would
be turned on for both.

The crazy options (-Oz and -O3) on the other hand are intentionally
not offered by Kconfig.

      Arnd

