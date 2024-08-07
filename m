Return-Path: <linux-kernel+bounces-278014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B594A96C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7109C284789
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123538DF9;
	Wed,  7 Aug 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vhv6AxuD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="umHM0cBf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EE821373
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039710; cv=none; b=SAl4lfY0khhY7UEQCH9Yx5sYe98l6e/TCbsY+ao05X0ELLMtpv5jDnuKSH42sYmezbIR/fNtN6Pje9qAT83kuuwRgJfq06wNnsYfwfagmE2IyPrhrTgjj+rTXykxoemA6RnNDkWtHyIU9Sts3ikqbwgNse4lNdqctkSyK961fn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039710; c=relaxed/simple;
	bh=/jOQEhumNXTyaduml+sLbKQNZrCH/ztkMNN6ZJT+Pig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hgIFJoOqcS2nUHLvCBmIGmwF7GGzplApJcF5J30lJPqh6uHRy+G+TgfkHGQbKEGWpQsbW3ZJNu/VkQRQaSHGt7WISIXpBCZKT+4qQjg636Ngb6B+832z5/vy92vaF5Bh/gqJ3Vm6brLCqniGOl2RQ/l3xhS8299Rd6KeOe7s5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vhv6AxuD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=umHM0cBf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723039707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JekNKamQNFnh1llzQrZHHy9rwaj4mGN4INvqAhxkgxo=;
	b=Vhv6AxuDNWeYXoJVVDPxczm9NQ2JOc86lffvcnoopQNKFrUKY9IddRA9SQBee0NFGS9lpf
	Uf8E2LQIq7HxkcT0FrwNZx296wlkLs7z6J2eoqFQPDrgaaDBdt1sr3gGOb6hicClXhP4w2
	iQH97nKVAf5fJRXjUJMqJ4YtEj1iJ/8+4LcKf/p2n2PiKUPHRlbQQE8gGKm0IKBHPb70hX
	hpwsK6Hy3TRn3ylc46xIS2MILy4guAN/Q0sqdUBCx6dv4qSOpEuKfAFCMpEjdaa1RvmLpY
	WeI/0Se5UwEdvH6HijEPJ6KVyPJ+KtGEGCFZW7ZpZsKa2B7igUNsdMk/wZBIbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723039707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JekNKamQNFnh1llzQrZHHy9rwaj4mGN4INvqAhxkgxo=;
	b=umHM0cBfciCJ7/eRmCLlVIEsL2QvttsyDagiyqSbjv9cGV/+rg/Li6nU32mGDBRZtHPycu
	BbWuTs5G1Gdq3TDw==
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, x86@kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Breno Leitao <leitao@debian.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, Takashi Iwai <tiwai@suse.de>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann
 <arnd@arndb.de>, Stas Sergeev <stsp2@yandex.ru>, mrwizardwizard
 <terrym3201@protonmail.com>
Subject: Re: Fwd: error: 'const_pcpu_hot' causes a section type conflict
 with 'pcpu_hot' when compiling with -flto
In-Reply-To: <Zq2qQW62G63dr70s@archie.me>
References: <Zq2qQW62G63dr70s@archie.me>
Date: Wed, 07 Aug 2024 16:08:26 +0200
Message-ID: <8734ng4e91.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Aug 03 2024 at 10:55, Bagas Sanjaya wrote:
>> when compiling linux kernel 6.9-6.10 with -flto
>>
>> compiler outputs:
>>
>> ./arch/x86/include/asm/current.h:42:25: error: 'const_pcpu_hot' causes a section type conflict with 'pcpu_hot' const_pcpu_hot);
>
> He could reproduce the build error on mainline:

That's caused by:

  ed2f752e0e0a ("x86/percpu: Introduce const-qualified const_pcpu_hot to micro-optimize code generation")

Uros?

Thanks,

        tglx

