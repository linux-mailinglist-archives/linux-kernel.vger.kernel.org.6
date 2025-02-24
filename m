Return-Path: <linux-kernel+bounces-529874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EADA42C13
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7099118901EF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827102661BE;
	Mon, 24 Feb 2025 18:54:58 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A030F264A74
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423298; cv=none; b=qpxRUOCF6REJC5s0GvNBrro/Lm0qnGP6TZLtEBY6/TP3U0oe6JqWQbfpBeLpCHAgpIoxRMJCnvYEkincimdMFhKq98SC69HX2cJBx/WNP3CmkjFS/EGS5mNUfVHXaXdEb96f/KwstA7pCKuOmyHrB5gHbG/pS2m5Eqdqg7ggj+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423298; c=relaxed/simple;
	bh=zO1Nj+G37HFh5abgCmhWvYGXDLskzEKUbRouOVDvN64=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eyzheSiH+lVJOfCfH0bs2q/7Uefs4bZwNCZvzEZSnmTSZOZgV/NFvpWtp68VEh3zXgVh+4xuI6oP+XNNvVRpetlX7rn97hsjdbEpBOoBOTm1LR2Pz+Q+4+GiyCGA5t8qJmixR8xlF58FvYQQuKHlM1yySavcY5PY4PqzFou9HpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6D16692009C; Mon, 24 Feb 2025 19:54:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 5F97F92009B;
	Mon, 24 Feb 2025 18:54:47 +0000 (GMT)
Date: Mon, 24 Feb 2025 18:54:47 +0000 (GMT)
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
In-Reply-To: <ffd5dd44-babc-480a-b1bc-61bd7ff1e920@csgroup.eu>
Message-ID: <alpine.DEB.2.21.2502241840360.65342@angie.orcam.me.uk>
References: <20250217-restricted-pointers-powerpc-v1-1-32c6bff63c9a@linutronix.de> <ffd5dd44-babc-480a-b1bc-61bd7ff1e920@csgroup.eu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 24 Feb 2025, Christophe Leroy wrote:

> > Restricted pointers ("%pK") are not meant to be used through printk().
> > It can unintentionally expose security sensitive, raw pointer values.
> > 
> > Use regular pointer formatting instead.
> > 
> > Link:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023%40linutronix.de%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C75a852a0fef54fa43a3608dd4f263f45%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638753747883689862%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=aUgq6pXb1ySaQ6e%2FdyM09jfc4MNLE71Njw0%2FnCg%2F6VU%3D&reserved=0
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> > ---
> >   arch/powerpc/kernel/eeh_driver.c | 2 +-
> >   arch/powerpc/perf/hv-24x7.c      | 8 ++++----
> >   2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/eeh_driver.c
> > b/arch/powerpc/kernel/eeh_driver.c
> > index
> > 7efe04c68f0fe3fb1c3c13d97d58e79e47cf103b..10ce6b3bd3b7c54f91544ae7f7fd3f32a51ee09a
> > 100644
> > --- a/arch/powerpc/kernel/eeh_driver.c
> > +++ b/arch/powerpc/kernel/eeh_driver.c
> > @@ -907,7 +907,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
> >   		/* FIXME: Use the same format as dump_stack() */
> >   		pr_err("EEH: Call Trace:\n");
> >   		for (i = 0; i < pe->trace_entries; i++)
> > -			pr_err("EEH: [%pK] %pS\n", ptrs[i], ptrs[i]);
> > +			pr_err("EEH: [%p] %pS\n", ptrs[i], ptrs[i]);
> >     		pe->trace_entries = 0;
> >   	}

 But shouldn't this be using `%px' then instead?  It would be sad if all 
the address information from error reports such as below:

EEH: Call Trace:
EEH: [000000008985bc3b] __eeh_send_failure_event+0x78/0x150
EEH: [000000008c4c5782] eeh_dev_check_failure+0x388/0x6b0
EEH: [000000001fb766c1] eeh_check_failure+0x98/0x100
EEH: [000000004b9af8c6] dfx_port_read_long+0xb0/0x130 [defxx]
EEH: [00000000e23999c1] dfx_interrupt+0x80/0x8c0 [defxx]
EEH: [00000000c7884fb7] __handle_irq_event_percpu+0x9c/0x2f0
EEH: [000000008d4e9afd] handle_irq_event_percpu+0x44/0xc0
EEH: [000000008c39ece4] handle_irq_event+0x74/0xc0
EEH: [00000000d85114a9] handle_fasteoi_irq+0xd4/0x220
EEH: [00000000a692ef4e] generic_handle_irq+0x54/0x80
EEH: [00000000a6db243b] __do_irq+0x68/0x200
EEH: [0000000040ccff9e] call_do_irq+0x14/0x24
EEH: [00000000e8e9ddf7] do_IRQ+0x78/0xd0
EEH: [0000000031916539] replay_soft_interrupts+0x180/0x370
EEH: [000000001b7e5728] arch_local_irq_restore+0x48/0xc0
EEH: [00000000088691b7] cpuidle_enter_state+0x108/0x560
EEH: [00000000e6e26f30] cpuidle_enter+0x50/0x70
EEH: [000000007c26474c] call_cpuidle+0x4c/0x80
EEH: [0000000036b8a2fc] do_idle+0x360/0x3b0
EEH: [0000000048702083] cpu_startup_entry+0x38/0x40
EEH: [00000000d3b1fb8d] start_secondary+0x62c/0x660
EEH: [0000000041a9a815] start_secondary_prolog+0x10/0x14

was suddenly lost from the kernel log, the access to which unprivileged 
users can be denied if so desired according to the site policy.  Whereas 
running the kernel such as to have all output from plain `%p' exposed just 
to cope with this proposed change, now that seems like a security risk.

  Maciej

