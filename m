Return-Path: <linux-kernel+bounces-532090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF01AA44871
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB638188CE9D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99EA19E804;
	Tue, 25 Feb 2025 17:29:14 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3068817B418
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504554; cv=none; b=snso4KkgXADX8UBtIj7ODF9mIdJ3oTMjPUsW5s1NT4WfxtcxmqMl8cEjqiKyTEAifsVeNIUEzf2iVLs/qyGFO9G90dtwNZ5xpk54rDlg627m5vW8LcuM1Uk4XQ404w10/xVgRusd40ShreJFjyJhxV4jhPx2kb4UKxMDHxPz54Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504554; c=relaxed/simple;
	bh=+3/HyB4QuuPOf5t/WmOnKXVbHUTEErYfCEcPq6iMK90=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ToJBB6zMBh4Q3vP3VE3rmLCo4Dz34wbboKcu+LcdzHIWKCPS8oCp8/b9jrdLyD4dWiCrRAIFTTi3keqzcTxYeyIM39ayeBZghF/QIc7DTIZjBcWMoPrUvkH4eZn0xMGR/9zR+KRv5FbpKUJ/2X2YuePL1RmMPgg+lNHPGKYTonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 10D1992009C; Tue, 25 Feb 2025 18:29:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0CEBB92009B;
	Tue, 25 Feb 2025 17:29:10 +0000 (GMT)
Date: Tue, 25 Feb 2025 17:29:09 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Don't use %pK through printk
In-Reply-To: <a7a135c9-c65b-48a8-a3a8-6aa98afe77d0@csgroup.eu>
Message-ID: <alpine.DEB.2.21.2502251703450.65342@angie.orcam.me.uk>
References: <20250217-restricted-pointers-powerpc-v1-1-32c6bff63c9a@linutronix.de> <ffd5dd44-babc-480a-b1bc-61bd7ff1e920@csgroup.eu> <alpine.DEB.2.21.2502241840360.65342@angie.orcam.me.uk> <a7a135c9-c65b-48a8-a3a8-6aa98afe77d0@csgroup.eu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Feb 2025, Christophe Leroy wrote:

> > was suddenly lost from the kernel log, the access to which unprivileged
> > users can be denied if so desired according to the site policy.  Whereas
> > running the kernel such as to have all output from plain `%p' exposed just
> > to cope with this proposed change, now that seems like a security risk.
> 
> The purpose of hashed addresses is to avoid kernel addresses to leak to the
> kernel log. Here you have function names, if you get real function addresses
> at the same time, then you know everything about kernel addresses and for
> instance KASLR becomes just pointless.

 Why is it so important not to have kernel addresses in the kernel log?  
This defeats the purpose of having diagnostics for such fatal events.

 If your site policy so requires, you can disable access to the kernel log 
for unprivileged users, in which case once you do have one you can poke at 
/dev/mem too and have a thousand other ways to do harm.  And if you are a 
sloppy admin and have /var/log/messages world-readable where you really 
ought not to, then well, what can I say?

 From the description of `%pK' I infer it's been meant for /proc files and 
the like that may be readable to unprivileged users, and I can certainly
understand the security implications here.

> By the way, why do you need the addresses at all in addition to function names
> ? When I look at x86 dump stack, they only print function name, using %pBb

 They can be handed over to GDB, `objdump' and similar debug tools when 
working with `vmlinux'.  Function names do help, giving you assistance to 
make sure you work with matching `vmlinux'.

 NB I don't know what x86 does, I've done little in that area in the 
recent ~20 years, mostly taking care about my legacy 32-bit i486/i586 
stuff.

  Maciej

