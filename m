Return-Path: <linux-kernel+bounces-572394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2478A6C9EE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F8817880A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED491FC0FE;
	Sat, 22 Mar 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhPHJJvg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3B8634D
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742643656; cv=none; b=QIIM9rZSSzGVd9WK/ERkcRsMQ9L7H56SoJ24Dn4CIyjfTJJeSymSYpeW0ZgnbM0O6fuOe2UqyqycHPxsr/A4hAo6pWmy2PvqNsTw5kCewOVH98vdXXBsekynTrMxwkaRU6iEpUk/MTZPO7v4hHouRvpOiI/DQRlAGmDwX6+EeN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742643656; c=relaxed/simple;
	bh=0Ffq5mk8VfPaEZfLSWB3h0E+yh5rDLlQECqJk5MaIaU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uLWTBgasnJSN7ONX1UfWI4zPuphGbMAaGzQilKWFM1lXKxrBIiF5l+ImK98cUo6kU+l8fdNIhn6+rsnXVfQrzRRoRdqNETvhxnxrBp67+dDv+OU6CD0bNCoqK2N5C/1J7k8IRJTiwnz3fdtsWE1zL7TqefrTvs5Mi57s+sr8+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhPHJJvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D40AC4CEE4;
	Sat, 22 Mar 2025 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742643655;
	bh=0Ffq5mk8VfPaEZfLSWB3h0E+yh5rDLlQECqJk5MaIaU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GhPHJJvgymTPRn5yx3PMcD7lPKbgH4ZWIm+evsriYlAmMD3Z14GGXz3q+QAAgKWkk
	 5Z7mKEtg40j2mU7IxYlp2Zq6HC1PAzR59tp9uib3IbiDUMOGxYO5qQ/N4IpmELoEP8
	 92a365XPd93UFS9CaYrGCaivND91M9erd7G6k2EoZfElx1Hgju/J/EzIK2NqUT/eg4
	 /IzM9kGx1kmnD8y2+cPdDAm9i/nffUorNiAGglHuFdm7/+ROYHCDs0jXYxhmotbluP
	 1qMyxUtrIyOZ2C9TXwPPayRvCBpdGCLOTCwHooPWAkFZCuGQ0yYCyB3/ICAQEq3BGW
	 GHLXzh+4P1Icg==
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 38E68120006A;
	Sat, 22 Mar 2025 07:40:54 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Sat, 22 Mar 2025 07:40:54 -0400
X-ME-Sender: <xms:xqHeZz_-XgdAjrZxVtEWkPWPBpwGIAh3LKXv8BdEkjfe39O5XeIZFA>
    <xme:xqHeZ_v26MeaCDmExp5jSy5ODxVeQZfwrAhptDBazcYy1s1eZ0wZDQpConLm8pBkn
    NYTfoLRIZumWd4neaI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnh
    gvlhdrohhrgheqnecuggftrfgrthhtvghrnhepjeejffetteefteekieejudeguedvgfef
    feeitdduieekgeegfeekhfduhfelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvg
    hlrdhorhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepgiekie
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidr
    uggvpdhrtghpthhtohepthhorhhvihgtleesmhgrihhlsghogidrohhrghdprhgtphhtth
    hopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtoh
    hrrdgtohhm
X-ME-Proxy: <xmx:xqHeZxAD27y2jHA4dhWRpEipAKFg_VEtFKEvzFiNZnVqHusViymQrQ>
    <xmx:xqHeZ_cZpCVHQM_nYxO1OOIPjLuraINsVM4IfH3YnCauluOWe9b4UQ>
    <xmx:xqHeZ4O8KtQchqwYgGbHsn8r9yXJihQCFY7k98PJ2Mbc3aFzl1Pi0Q>
    <xmx:xqHeZxmSOp8_fyTUmFvhJxih90gkUkQDYNKhEMw2zf6ERYASaglLfg>
    <xmx:xqHeZys83DqhjmtDzweXy6763XoNsszdiNkpnm8djuAAeJdp20r6na6c>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0BC352220072; Sat, 22 Mar 2025 07:40:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T54c1b8b1cd0488d2
Date: Sat, 22 Mar 2025 12:40:08 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Tor Vic" <torvic9@mailbox.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Borislav Petkov" <bp@alien8.de>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <e37ee471-0b10-48d4-ad20-871e585c98f6@app.fastmail.com>
In-Reply-To: <20250321142859.13889-1-torvic9@mailbox.org>
References: <20250321142859.13889-1-torvic9@mailbox.org>
Subject: Re: [PATCH] arch/x86: Add an option to build the kernel with '-march=native'
 on x86-64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 21, 2025, at 15:28, Tor Vic wrote:
> Add a 'native' option that allows users to build an optimized kernel for
> their local machine (i.e. the machine which is used to build the kernel)
> by passing '-march=native' to the CFLAGS.
>
> The idea comes from Linus' reply to Arnd's initial proposal in [1].
>
> This patch is based on Arnd's x86 cleanup series, which is now in -tip [2].

Thanks for having another look at this and for including the
benchmarks. I ended up dropping this bit of my series because
there were too many open questions around things like
reproducible builds, but there is clearly a demand for having
this included.

>       hackbench (lower is better):
>       102.27 --> 99.50                         (-2.709 %)
>
>   - stress-ng, bogoops, average of 3 15-second runs:
>       fork:
>       111'744 --> 115'509                      (+3.397 %)
>       bsearch:
>       7'211 --> 7'436                          (+3.120 %)
>       vm:
>       1'442'256 --> 1'486'615                  (+3.076 %)

3% in userspace benchmarks does seem significant enough to
spend more time on seeing what exactly made the difference
here, and possibly including it as separate options.

> +ifdef CONFIG_NATIVE_CPU
> +        KBUILD_CFLAGS += -march=native
> +        KBUILD_RUSTFLAGS += -Ctarget-cpu=native
> +else
>          KBUILD_CFLAGS += -march=x86-64 -mtune=generic
>          KBUILD_RUSTFLAGS += -Ctarget-cpu=x86-64 -Ztune-cpu=generic
> +endif

I assume that the difference here is that -march=native on
your machine gets turned into -march=skylake, which then turns
on both additional instructions and a different instruction
scheduler.

Are you able to quickly run the same tests again using
just one of the two?

a) -march=x86-64 -mtune=skylake
b) -march=skylake -mtune=generic

    Arnd

