Return-Path: <linux-kernel+bounces-538293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C43AA496BF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C663B651B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C3D25BABD;
	Fri, 28 Feb 2025 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="D5ychM0b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4va8r1Bz"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5C225BABB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737437; cv=none; b=roAu8A5KPwGZW6xlQbaPRZNxss1OmC0+BR/2rC/mHPYCYkPIQuwoJyPTijv7tTBxTNVnAuFXgrR1fp6HWyX5R0keySiWGnmBPkHFOUHFZiGAz25eXp6alCUFwuRVeSEXbyq9lR912iLpRXwIDoPwrlToqpduAPiYlm2av0RL3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737437; c=relaxed/simple;
	bh=fKqQI3s2FMm42MNPlyL1kWLuLNcXuQkszUs7PCGftLM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FHk8zFTVjdwoZI+waAo570DPfpf7Muopj5CpTjOzQKq+uHSWY6Ml3uXt1FgKZm2Rxwtm+Qx2wjkFriY5l0bsqbF2kWzUfxRB/AjQpBTcz2uhANaG4PJBNxdSvMWAF8AGLebA+LHqOLPu6OKSboyvSpT1Rr1qDKj/kT/D+vzEZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=D5ychM0b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4va8r1Bz; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9EE2F1140191;
	Fri, 28 Feb 2025 05:10:33 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Fri, 28 Feb 2025 05:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740737433;
	 x=1740823833; bh=ik0P9ijBiTa8if2P4+hjGAfPoRpksM1NfwYxIjjhWH8=; b=
	D5ychM0bGYllqlgSZ4FwIh1EtFsi2hkkKezSS2wmXOeqakDsvp1Tr4AXGUNeOAH8
	FmA3TQpp5kkb8j7V85IrXdYZ8yXHPjSNkQ2QW1aBshgbRGzvn5iGYnjkgyb/vDZ8
	E3xLUr/J75m5ohPdqydoQk4G8Cb+E5qlx86/D9P2eT2UTcUy8q40Yzv9JZJsjbPY
	+8UqBh1lHtK7C0SXm+lIHB7ku0i68H84NWHcq/t2+crdn3U3OW6KBCxV4D+7RUOe
	7gRZw8I8BiLuYS4dlHNLvq9kC52ubdMASjAgNv+LJiZQxrl0rWMTPA4MfvvCn/7r
	j4BCCSQ0FRO2+QuSloerEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740737433; x=
	1740823833; bh=ik0P9ijBiTa8if2P4+hjGAfPoRpksM1NfwYxIjjhWH8=; b=4
	va8r1BzRU8s4zwlvp7bV0y1uhTSgppd/LdkfzEaeGPuBzlubUI3EfWJH3tyNMs5r
	M5wAF8fTXuyz1M7R5lziJXgajGKExwrARiA1x9M516VP6GzPjizdbiqs8XYNr3vn
	62R4Qb6wi4lRhwzWfNTZCfRb5SyC1AS949unQVU10zZEed3NVzLZ+Et1L9sC1EOo
	iEPOc4tkGJJVmTjPJbCiBvSnAqryNbXKmbuFAksOpAHl1XYffWukvZpiJJpeB4qi
	U33fBoHrOqSTRYqIh6iZpafS9cjN70xQdtsXYK3Af0O4fIR/GNZJmlcCe+Eq5DTk
	RbVLYjOGc3esz1V663BvA==
X-ME-Sender: <xms:mIvBZx3KdYfvHUxUPZ29NHmQUpi7R03E7h8uFil7XBVPI25Dds5eDg>
    <xme:mIvBZ4E4b0GsG-B5UJxlHaC29F0bE6x2wuhCVjf4NmffcYwrVyDQszKNDIYje5Hro
    7nFG5sudyZgL1SvPg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpd
    hrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegr
    nhguhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhroh
    hnihigrdguvgdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrih
    hnthgvlhdrtghomh
X-ME-Proxy: <xmx:mIvBZx5Na7X8RQT34utg-uuV2nK-OuuEUn-06G_IJ7p0YlEK-Da2Kg>
    <xmx:mIvBZ-01hAato2rHF7SzRESMH8G71SZWf7xp70vmn_ELJy3mCeTZsA>
    <xmx:mIvBZ0GofQfIy_ks2tNjrRSxHogpN_-vyvVdlXZvms_uZSNTJpkvOg>
    <xmx:mIvBZ_-lfRDLD8xGtgwtE1t8bNfw5xtEnWTV_8TDRk1HqYIblqaTtA>
    <xmx:mYvBZ382VUEe1f0VUDoZ5P1C7nGGWcst_c_GtZeLcOe2Pj2P7BWz4uOd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 806B62220072; Fri, 28 Feb 2025 05:10:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Feb 2025 11:09:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Matthew Wilcox" <willy@infradead.org>,
 linux-mm@kvack.org
Message-Id: <0047f565-ada4-491a-b157-f2d8dfde0ac0@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wjFb7jeWXB2wovPeHqZ7XaxfiCbb+Vgk9FeGO2pcY78zA@mail.gmail.com>
References: <20250226213714.4040853-1-arnd@kernel.org>
 <20250226213714.4040853-6-arnd@kernel.org>
 <572DCA31-1CCA-45FB-ADCD-29C24A527437@zytor.com>
 <CAHk-=wjFb7jeWXB2wovPeHqZ7XaxfiCbb+Vgk9FeGO2pcY78zA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] x86: remove HIGHMEM64G support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 27, 2025, at 17:51, Linus Torvalds wrote:
> On Thu, 27 Feb 2025 at 07:41, H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> One of the generations of kernel.org ran on a dual socket system with
>> 6 GiB RAM. It was a mess; basically it achieved less than 50% memory
>> utilization because of highmem.
>
> I'll be very very happy when HIGHMEM is gone completely, but yes,
> HIGHMEM64G was particularly painful.

I'm optimistic about being able to remove highmem in the future
as well, hopefully this series was a good step in that direction.

This is a rough list of what I think the remaining problems are:

- anyone running 32-bit kernels on 64-bit hardware or virtual
  machines should move to 64-bit kernels. This is mostly about
  educating users (on x86) and embedded system builders (on arm
  and possibly powerpc/booke64).
  One idea we had discussed in the past was to have the
  kernel refuse to run on 64-bit hardware if highmem is
  detected (with a command line override to allow regression
  testing).

- arm32 needs a way to have sparse physical memory linearized
  into lowmem, to deal with the case where the total memory is
  small enough to fit, but half of it sits at a high physical
  address. We are working on this.

- Ideally the same change should support a boot-time vmsplit
  selection on arm32 instead of compile-time CONFIG_VMSPLIT_*.
  This would also help x86-32 when a distro kernel needs to run
  on both 1GB and 2GB RAM machines but still allow
  3GB of user addresses on smaller machines.

- Machines with 3GB or 4GB of RAM (pre-2005 Intel PC/server
  systems, 2005-2007 era Intel Laptops, 2007-2009 era
  Netbooks, 2013-2015 era Arm Chromebooks, rare Arm/x86/PowerPC
  embedded systems) can hopefully get away with a combination
  of VMSPLIT_2G and zram/zswap.
  Someone needs to rework the highmem code to separate the
  bits needed for zsmalloc from the rest so we can disable
  and eventually remove normal highmem while keeping
  zsmalloc-in-highmem. I have not looked in detail at how
  that would work in practice.

- There is still an open question about implementing a
  4GB-split on ARM-LPAE (flipping a 3.75GB ttbr0 between
  lowmem and user). Linus Walleij has done some work on
  this, but we may find that VMSPLIT_2G plus zsmalloc-only
  highmem is good enough that we don't need both. Both
  approaches have important downsides.

- arm32 machines with more than 4GB of total memory need to
  get rare enough that we can throw them under the bus.
  There are still a few of them in use, but the chips are
  all more than 10 years old by now and eventually they
  will stop needing kernel updates.

- sparc32 kernels should start supporting more than 192MB of
  lowmem (or stop existing). Apparently there are Leon3
  machines with up to 2GB of RAM.

- mips32 has a hardware lowmem limit of 512MB, and I think
  we can live with that because they tend to have less actual
  RAM. There is one important chip (mt7621) that supports
  512MB RAM in machines with real users, and apparently that
  number goes down to 448MB without highmem.

- arc/csky/microblaze/xtensa all support highmem in theory,
  but I am not aware of anyone actually needing it any more.

- Lastly, there has to be some executive decision to actually
  do it as there will always be /some/ systems that are
  affected in the end. I don't think we can do enough of
  the mitigation work done for arm32 for this year's longterm
  kernel, but probably enough that we can agree on a
  deadline at the Tokyo LPC kernel summit, and maybe remove
  highmem after the 2026 longterm kernel.

I'll try to collect more data from affected users about what
will really break for them, and what I may have missed.

     Arnd

