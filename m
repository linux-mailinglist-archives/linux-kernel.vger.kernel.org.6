Return-Path: <linux-kernel+bounces-178435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D18C4DAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344001F226F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAA01CD38;
	Tue, 14 May 2024 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZpO5p/Ei";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I/3Db3S8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF9182B5
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715675110; cv=none; b=eJp9j468Ud7jnSnKug6xn3BIH79D2mzPdeL1DSsenK1q7cAIKUmTHPLjbezkfZJFb5ssKtQFaDBoUFyAugOZ4+lVIyOIEIAyxm87Kp58ecydq5yF66H1/c1eM6NdXjZvf43672kYsrjoAHup6MO6rY4is4E2IotsooGFbIY8W+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715675110; c=relaxed/simple;
	bh=E1jl8ZjAyUFlpawQFcuvFX7RI2JhugpIXhQkNMW7VGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pKbJOldKiJqgxmStrufjhfdXfVjz8t7O5GwvPiAiTQBIKIvj5nNklnR1gvwIB44e1N6QD76gh+ueAacT7UlvlQpk8Gvbtspqito94yu4SrKEIZTTLyOiEgsWRa6t1LwBBj2TvlYfT4JoYQ35pkK++e8NE+ZLbNQ+qXCX3AeAan4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZpO5p/Ei; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I/3Db3S8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715675101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rya9VEOvXpJSVd+MOeMBD/eFCeJ8PzLNGegzNQCqGfg=;
	b=ZpO5p/EiAzz3rLhJ2lV+LlIt412WOp8MZJC72zUBUsK3PJ/t1M3LlAovqh2X3hBrJtz4BE
	gnIV/MV5uy0nPm+cdknW0IBEkfq97oy+Uof5x/IB5himmUyaYE5bMftqSYzXwX+LsaftAy
	Sayq7VixBOX9LbPLFaMmJ6+IdN+I35WPAlZIgkbhCPEC/xXd8i1EAaZI4Dce9avHjroIlJ
	h5VrhYRvw/mhYmlpe37XGsWNpBTP3JL4SaQ7Z9DK3kilxv+/j3WKG7cl6sHyCjO5r75OtE
	hj1PM7z8ozE3qN870DQ6yz9KfCNo/ZNu+laqXdA7jOmNmND0CivHDTLaiH1/Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715675101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rya9VEOvXpJSVd+MOeMBD/eFCeJ8PzLNGegzNQCqGfg=;
	b=I/3Db3S8nfD54rKc6DNf8xY5f6sjY5bu7j8MBrYa+hE3qNoBpEBJ0pxgf87pe1KlAMM2/K
	GcOvMnWOAB5aWEDg==
To: Lyude Paul <lyude@redhat.com>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <97bd95480a8b9951edc9ee2d2648d1b9c574e3b0.camel@redhat.com>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
 <87plumxz4x.ffs@tglx>
 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
 <87le59vw1y.ffs@tglx>
 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
 <87edautcmz.ffs@tglx>
 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
 <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info> <877cg4ppd5.ffs@tglx>
 <ea927dad269cc21de1d0baf3d6c9f66ee025b862.camel@redhat.com>
 <d2c6f335a6eb5892b0d894d5df4a6e713fa013b5.camel@redhat.com>
 <87jzjxn6s5.ffs@tglx>
 <d3fe5278e7cd5af6c62b470b281b547b67e3959a.camel@redhat.com>
 <97bd95480a8b9951edc9ee2d2648d1b9c574e3b0.camel@redhat.com>
Date: Tue, 14 May 2024 10:25:01 +0200
Message-ID: <87bk58n6le.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude!

On Mon, May 13 2024 at 19:32, Lyude Paul wrote:
> Oh! I am not sure what changed, but I realized that you might also want to see
> the serial output from the debugging patch that you had sent me a while ago.
> So I just built that against the 6.9 kernel and it actually seems to boot
> without needing me to pass intremap=off. So it seems like that might actually
> be a fix!

Which one of the debug patches did you use?

>> Yes - it still boots. As well I finally got the serial console adapter in, but
>> I don't see any additional output:

That's fine, but now I can provide you debug patches which dump
information during early boot.

Can you please provide the output of 'cpuid -r' ?

Thanks,

        tglx

