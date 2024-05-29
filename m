Return-Path: <linux-kernel+bounces-193890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478FA8D33B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F2EB27400
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D997C172BB6;
	Wed, 29 May 2024 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qm06aAls"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104AA16EBF0;
	Wed, 29 May 2024 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976267; cv=none; b=lR0P3JbNi9zOGZvObShSntavoS9opdHqTxSHrlAXHa05EL4ZHZdWcpIAEnwwsGp/imhTCrcqn9QhD0pzThmVGH2OCGRp7l6C6PU238ODs9BNNzFMO6aQ6tsRXh6fskM7PU8nWci2H61kxzdNBUHgbt4jSCJW1vuYWeWuERemCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976267; c=relaxed/simple;
	bh=Ej4XwkzDkEmG6il/14B3rRjy6ji6WOc6Cr9GX+IKhcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ/c8B9iRWBgZfohGsZ4SE9u11yJaar9k1MJXMTQ3wU2dky5AnfwUZ3Ur6HA8rS8t4gzdpe+Iu4cwUGfVbPSdjRWsY5K13UvGKaU5+dED1yAyfqmbwRpbKr1qaxyIV6KTRdlJsCSsT8mXfRGOZpArxwHXFxP4U/JRjd2azsLUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qm06aAls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433C0C2BD10;
	Wed, 29 May 2024 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716976266;
	bh=Ej4XwkzDkEmG6il/14B3rRjy6ji6WOc6Cr9GX+IKhcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qm06aAlsY9bZFoqH4rtst1sXhSTpY9t4IX8Dt/A6VBMQ4G0a9LFFf9H3l7hEQTnWo
	 Kvs/rX0XD5ioTwybM3csJxB6d6bgL1E60yrR0EIcPUDnYOJ1/memvf8bIrO3VoHiW/
	 Nu0VRQVHkbmoohatv8W/Kf3YJ3bdueY50EoViHZk=
Date: Wed, 29 May 2024 11:51:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: CVE-2023-52734: net: sched: sch: Bounds check priority
Message-ID: <2024052930-dealt-class-f845@gregkh>
References: <2024052100-CVE-2023-52734-c8c2@gregkh>
 <ZlWNaIMC3NCkIFxv@tiehlicka>
 <2024052824-justice-lair-14e6@gregkh>
 <ZlbIZ8bdBK4tZcBa@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlbIZ8bdBK4tZcBa@tiehlicka>

On Wed, May 29, 2024 at 09:30:08AM +0200, Michal Hocko wrote:
> On Tue 28-05-24 21:06:39, Greg KH wrote:
> > On Tue, May 28, 2024 at 09:53:12AM +0200, Michal Hocko wrote:
> > > Is this really soemthing that should be getting a CVE assigned?
> > > First the fix is incomplete - 9cec2aaffe96 ("net: sched: sch: Fix off by one in htb_activate_prios()")
> > 
> > Incomplete fixes are still part of a fix :)
> 
> Sigh
> 
> > > Second is this even real problem? https://lore.kernel.org/all/Y9V3mBmLUcrEdrTV@pop-os.localdomain/
> > > suggests it is not.
> > 
> > Ah, good catch, I didn't see that.  I'll go revoke this as it's not
> > doing anything.
> 
> Thanks!
> 
> I wish the CVE review process would catch something like that before
> issuing a CVE for it.

I too want a pony :)

> > > And third, WARN_ONs are considered a real deal by CVE team because
> > > somebody might be running with panic_on_warn. This patch adds one!
> > 
> > Yes, but if you can't hit that by anything from userspace, it's not an
> > issue and just dead code.  We'll have to wait for a future syzbot report
> > to prove that wrong :)
> 
> I am not judging the patch itself. It is maintainers who should decide
> whether this is something they want to accept.
> 
> I am questioning the decision to make it a CVE. Because if that was a
> real deal then WARN_ON is something kernel CNA is considering a CVE worth
> problem! So a CVE has been filed with a fix that is CVE itself.
> Seriously how could this pass through the CVE review process?

"How" is "this was part of the entries in the GSD records that MITRE
asked us to back-fill as CVE entries".  Those entries already went
through two different rounds of review last year for the GSD record, and
I did another one as well now before the CVE creation happened.  It was
in a batch where I reviewed 124 entries at once, and if I only got one
wrong, hey, that's a very good % overall, don't you think?  Especially
as it has been a publicily listed "vulnerability fix" for well over a
year now in the GSD system, and no one objected to it there.

Yes, I will get things wrong on the GSD backfill, and I am re-reviewing
them all, which is honestly, something that MITRE did NOT ask us to do,
but I am doing just because of minor things like this where perhaps the
entry should not have been made in the past.  And as part of that
review, yes, I have found some other entries that didn't deserve a CVE,
and so didn't create them.  If you would like me to just do a simple
"import them all without an additional review", I will be glad to do so
as it would be much easier and save me loads of time.

I welcome others to help out with this work, including yourself, if you
so desire.  That would help out a lot.

thanks,

greg k-h

