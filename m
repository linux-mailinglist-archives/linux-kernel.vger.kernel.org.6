Return-Path: <linux-kernel+bounces-523956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B480A3DD58
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F085F1744E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567B91CEAC3;
	Thu, 20 Feb 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CqyIWVv1"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE518A6CF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063166; cv=none; b=PLNm6HIUTvwfXrrWh3xZek649bv2gA768hyAiAkYhTHcegYMiU9h0zBqb5g1DZ9AtkjTDzHJgykWRj2n+72mZKIeHRJfOWzdrEoSVprKQ8Xwf6yyWVXRu1BGV/1m7IgYGsCiXtmiwh9razVAAwe4i691nG9K8PCwuqLQc01s/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063166; c=relaxed/simple;
	bh=D5angpQQJR0qz9qpvNYAMzDWygBtBc/QA/VqOVkLSxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5JEOKLTQur21Fx9v7P255QIVriDb/sF60CBmUdHdDgQZwtper/fzIhYjnx4EMRy9PwU99JovqbYjFSoELYSwqWPfpv8HRO57PBCj10Dd6qrWyupmqieeFja58Dr9PGyzbOmL9Lqv+07rgE/nu7cSGl76s7YZW5JdKGN2ZOI/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CqyIWVv1; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hRdR2YgEdCrWMJfthrHGyyzG+URNUoUTUwHsNvS87ng=; b=CqyIWVv1etTM/2DBBKxYMWbxQw
	zgMjJqzNIv+qGacw1U8H27g0r2iRkFONppgeetYY5hgfZ9Qk1C69PbkL8orG1Z0yXlAGZNryybD9R
	vQegoZ8SCE7DtT4WC/T2jA4YrA/ga2lADolUuozmrUos55XmDFerhKPvDC6sBjobAr/vonIEcBWu6
	owQzQF4UsgCyZ1jzcoD1PqA3oaedbTHp5J0FBgRxsqiIVy7hqi2G5oQRcuGYRTHeowFOrfAZsTybE
	j6fnv/g1WAx3w53+6uiP9s8gAne1d4NqoN9RkX0WI8l7nPIt6QeduoJfUcV35rtuwbw/E7Z+VIjDt
	NnSoXJxw==;
Received: from 179-125-91-157-dinamico.pombonet.net.br ([179.125.91.157] helo=quatroqueijos)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tl7uh-00FPSk-SG; Thu, 20 Feb 2025 15:52:38 +0100
Date: Thu, 20 Feb 2025 11:52:31 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dirk VanDerMerwe <dirk.vandermerwe@sophos.com>,
	Vimal Agrawal <vimal.agrawal@sophos.com>, kernel-dev@igalia.com
Subject: Re: [PATCH 3/4] char: misc: restrict the dynamic range to exclude
 reserved minors
Message-ID: <Z7dBr2WJGH-XDL6d@quatroqueijos>
References: <20250123123249.4081674-1-cascardo@igalia.com>
 <20250123123249.4081674-4-cascardo@igalia.com>
 <2025022007-rudder-refocus-5d45@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022007-rudder-refocus-5d45@gregkh>

On Thu, Feb 20, 2025 at 03:31:11PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 23, 2025 at 09:32:48AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > When this was first reported [1], the possibility of having sufficient
> > number of dynamic misc devices was theoretical.
> > 
> > What we know from commit ab760791c0cf ("char: misc: Increase the maximum
> > number of dynamic misc devices to 1048448"), is that the miscdevice
> > interface has been used for allocating more than the single-shot devices it
> > was designed for.
> 
> Do we have any in-kernel drivers that abuse it this way?  If so, let's
> fix them up.
> 

From the discussion 15 years ago, though found only by code inspection, dlm
was theoretically capable of creating such multiple devices. But, in
practice, its user space never did create more than one. 

But from commit ab760791c0cf ("char: misc: Increase the maximum number of
dynamic misc devices to 1048448") description, we know at least
coresight_tmc is abusing it like that.

I can work on fixing coresight_tmc and any other abusers, but they will
require their own class (though I thought about making it possible to
create compatibility symlinks under /sys/class/misc/). So, this should take
a bit longer. In the meantime, I think we shold apply something like this
patch for v6.15 and even consider it for stable.

> > On such systems, it is certain that the dynamic allocation will allocate
> > certain reserved minor numbers, leading to failures when a later driver
> > tries to claim its reserved number.
> > 
> > Fixing this is a simple matter of defining the IDA range to allocate from
> > to exclude minors up to and including 15.
> > 
> > [1] https://lore.kernel.org/all/1257813017-28598-3-git-send-email-cascardo@holoscopio.com/
> > 
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> >  drivers/char/misc.c        | 4 +++-
> >  include/linux/miscdevice.h | 1 +
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> > index 2cf595d2e10b..7a768775e558 100644
> > --- a/drivers/char/misc.c
> > +++ b/drivers/char/misc.c
> > @@ -68,8 +68,10 @@ static int misc_minor_alloc(int minor)
> >  	int ret = 0;
> >  
> >  	if (minor == MISC_DYNAMIC_MINOR) {
> > +		int max = DYNAMIC_MINORS - 1 - MISC_STATIC_MAX_MINOR - 1;
> >  		/* allocate free id */
> > -		ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
> > +		/* Minors from 0 to 15 are reserved. */
> > +		ret = ida_alloc_max(&misc_minors_ida, max, GFP_KERNEL);
> >  		if (ret >= 0) {
> >  			ret = DYNAMIC_MINORS - ret - 1;
> >  		} else {
> > diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
> > index 69e110c2b86a..911a294d17b5 100644
> > --- a/include/linux/miscdevice.h
> > +++ b/include/linux/miscdevice.h
> > @@ -21,6 +21,7 @@
> >  #define APOLLO_MOUSE_MINOR	7	/* unused */
> >  #define PC110PAD_MINOR		9	/* unused */
> >  /*#define ADB_MOUSE_MINOR	10	FIXME OBSOLETE */
> > +#define MISC_STATIC_MAX_MINOR	15	/* Top of first reserved range */
> 
> I don't understand, why is 15 the magic number here?  All of those
> "unused" values can just be removed, all systems should be using dynamic
> /dev/ now for many many years, and even if they aren't, these minors
> aren't being used by anyone else as the in-kernel users are long gone.
> 
> So why are we reserving this range if no one needs it?

Because those were reserved historically. They are still documented under
Documentation/admin-guide/devices.txt. What do we gain by not reserving
those? Since we moved past 255 for dynamic allocation, we are not going to
miss those 15 minors.

One alternative is that we just disregard the 0-255 range entirely for
dynamic allocation, which should also simplify the code a lot. If that
would be preferable, I can work on that and submit it soon.

Thanks.
Cascardo.

> 
> confused,
> 
> greg k-h
> 

