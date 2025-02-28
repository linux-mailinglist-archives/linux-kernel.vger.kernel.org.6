Return-Path: <linux-kernel+bounces-539406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75609A4A3CB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6FF883A74
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3298202960;
	Fri, 28 Feb 2025 20:15:07 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658691C5D74
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773707; cv=none; b=Q8okX08O5+IUXwJIs5WN07EuMdSREPu3QiajTOP0SLCaa+O6YHpGFWLJfSvuAmBT5ZH5U59iUMmq4/Q4aCCDEzC2fNdoJ+Ph8TcJOflqJbynwswzH/pbUd2IDNah4/N1vts0hBbGWODnopVg6QV7902Eh/TpHCla1RMdKOPOlOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773707; c=relaxed/simple;
	bh=TDLx1ut9fLDUlPjMi+huWJFEZjd5UkASbLn+PkWdEkg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ag4G8PF0Ph4JYXb+ilfIjafjVGD0YuSFBAa5RsfniwyyAsAHxgWqZ1aILFobZBDpe+ntvci8qT7Af5fqU0qEgsS9e3irme1WmA4OQBuaFZ6rIhUnltRx2iPpSazzZoc9FqPSKuoWtPK2sKxz+nVmgWzRF3haJIXGoydZDH2+MD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9817A92009E; Fri, 28 Feb 2025 21:15:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 912CB92009C;
	Fri, 28 Feb 2025 20:15:02 +0000 (GMT)
Date: Fri, 28 Feb 2025 20:15:02 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Don't use %pK through printk
In-Reply-To: <20250226105757-e935ee3e-f70d-4e0e-83bb-61307722a186@linutronix.de>
Message-ID: <alpine.DEB.2.21.2502281957310.12637@angie.orcam.me.uk>
References: <20250217-restricted-pointers-powerpc-v1-1-32c6bff63c9a@linutronix.de> <ffd5dd44-babc-480a-b1bc-61bd7ff1e920@csgroup.eu> <alpine.DEB.2.21.2502241840360.65342@angie.orcam.me.uk> <20250225091250-eac544ad-4e5b-47f7-83fc-5212c720483a@linutronix.de>
 <alpine.DEB.2.21.2502251654370.65342@angie.orcam.me.uk> <20250226105757-e935ee3e-f70d-4e0e-83bb-61307722a186@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 26 Feb 2025, Thomas Weißschuh wrote:

> > > By default, when kptr_restrict is set to 0, %pK behaves the same as %p.
> > > The same happened for a bunch of other architectures and nobody seems
> > > to have noticed in the past.
> > > The symbol-relative pointers or pointer formats designed for backtraces,
> > > as notes by Christophe, seem to be enough.
> > 
> >  I do hope so.
> 
> As mentioned before, personally I am fine with using %px here.

 Glad to hear!

> The values are in the register dumps anyways and security sensitive deployments
> will panic on WARN(), making the information disclosure useless.

 And even more so, I wasn't aware of this feature.  But this code doesn't 
make use of the WARN() facility, it just prints at the heightened KERN_ERR 
priority.

> > > But personally I'm also fine with using %px, as my goal is to remove the
> > > error-prone and confusing %pK.
> > 
> >  It's clear that `%pK' was meant to restrict access to /proc files and the 
> > like that may be accessible by unprivileged users:
> 
> Then let's stop abusing it. For something that is clear, it is
> misunderstood very often.

 Absolutely, I haven't questioned the removal of `%pK', but the switch to 
`%p' rather than `%px' specifically for this single hunk of your patch.

> > "
> > kptr_restrict
> > =============
> > 
> > This toggle indicates whether restrictions are placed on
> > exposing kernel addresses via ``/proc`` and other interfaces.
> > "
> > 
> > and not the kernel log, the information in which may come from rare events 
> > that are difficult to trigger and hard to recover via other means.  Sigh. 
> > Once you've got access to the kernel log, you may as well wipe the system 
> > or do any other harm you might like.
> 
> As I understand it, both the security and printk maintainers don't want the
> kernel log in general to be security sensitive and restricted.
> My goal here is not to push site-specific policy into the kernel but make life
> easier for kernel developers by removing the confusing and error-prone %pK
> altogether.

 Let me ask a different question then: is your approach to bulk-switch all 
instances of `%pK' to `%p' as the safe default and let other people figure 
out afterwards whether a different conversion specifier ought to be used 
instead on a case-by-case basis and then follow up with another patch, or 
will you consider these alternatives right away?

> Security is only one aspect.

 I think it's important enough though for us to ensure we don't compromise 
it by chance.

  Maciej

