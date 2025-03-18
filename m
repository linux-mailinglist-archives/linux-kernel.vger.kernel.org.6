Return-Path: <linux-kernel+bounces-566494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF8A678C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5F6178C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639AF20FAB1;
	Tue, 18 Mar 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3SK5kFP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37451586C8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314275; cv=none; b=qxdHVYNC+MY5mb9nn5vXxVqee8boc2sjhZjoWnyMELZOPSDG9FGE4Jo746dicRVkhNfNYrUd+8ysZmNzJCJWhyMlBMAnBCOWGIE76n2T582H3tuK/SAO5lf/2Dso0j0UfqZjJ3vxVxjl6BzW+gpbFDwDIvTu6PRkebTjzb1rYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314275; c=relaxed/simple;
	bh=DJznTK9wfd62bjKGxd9NXjtY5194EOGALbaCxEQznmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJOLYmYNhLcylU2Y3QK2gljjWOIqWephJzkFfsXDuV9K7IWLtKNMduE50415y9igndjcwmncSjiExm6z2DAGCxYytsbOkklQH/W4jkoH9qmFlSGQhXkQ2C/83xfd6tYDxwXCNTW7B6obe1yVEbFFnj4v24lovtpHMQ/73ZwjtQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3SK5kFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498B4C4CEDD;
	Tue, 18 Mar 2025 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742314275;
	bh=DJznTK9wfd62bjKGxd9NXjtY5194EOGALbaCxEQznmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U3SK5kFPf+I1n2yaBNQdeHZ7nbDK4HwSYUCTPIp6e1WnEbAAQyeQdxTVYHTiDIIq+
	 0mFupGyj9oN152XWl+pezZkAf+PC72c3CYsqn79vYsl0NAnork4vLYM5qVG0NppMFN
	 2OpkeMfFUEOUyUmGaMBej8SzUgvyBVWvtQ+RnzIHecHyCNyrZbFB5n4s+nhCj1JkwS
	 mByYoLxpL83jpG/ANwdEMmpX/4vxhWzlOu4LT8cln0o7aUOi2DK3KAdbReDmBouHum
	 XXAz8daETMwGL4GJiiuFAJn1QHE9ghY3+3xCSEf2/neesNhTITmM3A1RUrPthElo7E
	 7a+EOJ62O+hwQ==
Date: Tue, 18 Mar 2025 16:11:11 +0000
From: Will Deacon <will@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: Don't use %pK through printk
Message-ID: <20250318161109.GA13981@willie-the-truck>
References: <20250217-restricted-pointers-arm64-v1-1-14bb1f516b01@linutronix.de>
 <20250221145513.GA20567@willie-the-truck>
 <20250224150920-87b1bf56-9520-4cd1-ab51-93da2eece162@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224150920-87b1bf56-9520-4cd1-ab51-93da2eece162@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 24, 2025 at 03:12:54PM +0100, Thomas Weiﬂschuh wrote:
> On Fri, Feb 21, 2025 at 02:55:14PM +0000, Will Deacon wrote:
> > On Mon, Feb 17, 2025 at 08:39:06AM +0100, Thomas Weiﬂschuh wrote:
> > > Restricted pointers ("%pK") are not meant to be used through printk().
> > > It can unintentionally expose security sensitive, raw pointer values.
> > > 
> > > Use regular pointer formatting instead.
> > > 
> > > Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > ---
> > >  arch/arm64/mm/physaddr.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
> > > index cde44c13dda1bc0924d2d50369ad87f544a0a802..7d94e09b01b35094e883875a46b979666549095c 100644
> > > --- a/arch/arm64/mm/physaddr.c
> > > +++ b/arch/arm64/mm/physaddr.c
> > > @@ -10,7 +10,7 @@
> > >  phys_addr_t __virt_to_phys(unsigned long x)
> > >  {
> > >  	WARN(!__is_lm_address(__tag_reset(x)),
> > > -	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
> > > +	     "virt_to_phys used for non-linear address: %p (%pS)\n",
> > >  	      (void *)x,
> > >  	      (void *)x);
> > 
> > This is part of a WARN() and knowing the actual address may well be
> > useful in debugging. I suspect it also ends up being dumped as part of
> > the register dump _anyway_.
> 
> That makes sense, especially the value being part of the register dump.
> OTOH in the default kernel configuration (kptr_restrict==0), %pK is an alias to
> %p and also hashing the pointers. And so far nobody seems to have cared.
> 
> If you prefer I can also change it to %px, to specifically show the value.
> My main goal is to remove %pK, as it's prone to misuse.

Probably best to ignore me, then, and keep the existing behaviour with
your change (as your patch is doing).

Thanks,

Will

