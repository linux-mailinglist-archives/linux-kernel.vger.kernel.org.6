Return-Path: <linux-kernel+bounces-260834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131DB93AF15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB87280579
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831D14A4C5;
	Wed, 24 Jul 2024 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BCuJ6u4b"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3B13DDC2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813552; cv=none; b=JTx3415HSb3LLSNBonqfn/eD0CbtsH8trBnAP66Uzfk82ntO8/wDcyTExqNHVuuimjGVO2471qvFtBhhQaoVR9+qxMbN1rSQsKirPwdTB1TpZp3IXu0VgEu4OdBRddAOk7h9eavEUumzi99jQfEwe8nYdoZFMtMdkhncyQTEU2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813552; c=relaxed/simple;
	bh=ZDtz5wNfgFB+bM5S7J3BlKZ5MriLrTcZPwN4EF7yzLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeiZF1XfdKJBItkpGrTrpSqhSQmC+/QLsStrKfZ1ICVUvSM605MEEVoKOxLDj7fT9qegFzIvFmpLgKCva3A7SIOKE/jMB0beGEXiT76Uo/1+5u6pYteGhm2KCH14s7/HM1kEXRmUNyy0qaie8JpDSs+BwC9kzViOJ+vPUs4RXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BCuJ6u4b; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1721813547;
	bh=ZDtz5wNfgFB+bM5S7J3BlKZ5MriLrTcZPwN4EF7yzLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCuJ6u4b0m987SqUN4AdENzSaSbUZkNR7/wXR5gsniaBr9qUTrj5Ef9D8jhmnq1l9
	 uDlNc4jn8cKom3elPNOBDVAaW1CqS4fYI+MakZ1ueyL1N+a6O7kXoDFO7sNHcM60RN
	 if9EShifvrMLZuAbzLIXdBk5vAv4g1kJBFb6ua5U=
Date: Wed, 24 Jul 2024 11:32:26 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sysctl: treewide: constify the ctl_table argument of
 proc_handlers
Message-ID: <84dc8f21-78d2-4ea2-ad79-3f85b610c0a7@t-8ch.de>
References: <20240619-sysctl-const-handler-v2-1-e36d00707097@weissschuh.net>
 <20240715202319.mccb6jlsa6dkynap@joelS2.panther.com>
 <f7489470-b0da-406b-a8dd-0ae7aaeceec8@t-8ch.de>
 <20240716152705.juet6srejwq5o6je@joelS2.panther.com>
 <cdf0831f-f9af-4aa7-a3a0-970efeec1def@t-8ch.de>
 <20240717195748.fe5ttokbibcsw2ca@joelS2.panther.com>
 <8a48b4d3-94ca-4a42-bf59-c340d7316603@t-8ch.de>
 <20240724084124.hbbn3jfcbsc7pyov@joelS2.panther.com>
 <12465755-1df4-4231-9bec-1044bfcdca4a@t-8ch.de>
 <20240724091817.eohhckduvtjscibg@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724091817.eohhckduvtjscibg@joelS2.panther.com>

On 2024-07-24 11:18:17+0000, Joel Granados wrote:
> On Wed, Jul 24, 2024 at 10:56:10AM +0200, Thomas Weißschuh wrote:
> > On 2024-07-24 10:41:24+0000, Joel Granados wrote:
> ...
> > > > > to be in master before we send the PR to Linus. Will check these three
> > > > > dependencies on Wednesday next week and send your V2 [3] if I see that
> > > > > it applies cleanly.
> > > > 
> > > > All dependency PRs (sysctl, net, mm) are now merged.
> > > > My compilation tests all succeed now.
> > > 
> > > How did you apply the coccinelle script? I ask because if I do this:
> > > ```
> > >  make coccicheck MODE=patch SPFLAGS="--in-place --include-headers" COCCI=SCRIPT
> > > ```
> > > 
> > > I have to add "virtual patch" to the first line of the script you had
> > > sent. So it would look like this:
> > > ```
> > > virtual patch
> > > 
> > > @@
> > > identifier func, ctl, write, buffer, lenp, ppos;
> > > @@
> > > 
> > > int func(
> > > - struct ctl_table *ctl,
> > > + const struct ctl_table *ctl,
> > >   int write, void *buffer, size_t *lenp, loff_t *ppos)
> > > { ... }
> > > ```
> > 
> > Yes, IIRC I got told during one review to drop it.
> > But for me it is also necessary.
> I also remember a comment from the XFS part of the patches where you
> changed the formatting on some functions. What did you do to address
> this? Did you change them manually? Or do you have a script?

Yes, the style fixes were done manually.

> > Thinking back, there were other "virtual" lines, too.
> > Maybe those were to ones that needed to be removed, but
> > "virtual patch" should stay.

> Understood.
> 
> > 
> > > Additionally, this cocci script is not changing the header files. Even
> > > if I pass --include-headers. Did you change those by hand?
> > 
> > Yes, I changed these manually, originally.
> > 
> > To do it through the script, you need a second subpatch:
> > 
> > ```
> > @@
> > identifier func, ctl, write, buffer, lenp, ppos;
> > @@
> > 
> > int func(
> > - struct ctl_table *ctl,
> > + const struct ctl_table *ctl,
> >   int write, void *buffer, size_t *lenp, loff_t *ppos);
> > ```
> Yes. But you are still missing one more subpatch to catch the function
> declarations in header files that don't name the arguments; like the
> ones in include/linux/mm.h. This is what I used for those:
> ```
> @r3@
> identifier func;
> @@
> 
> int func(
> - struct ctl_table *,
> + const struct ctl_table *,
>   int , void *, size_t *, loff_t *);
> ```
> 
> > 
> > (It doesn't find anything else, though)
> Maybe you are missing running it with --include-headers?

There seems to be a slight misunderstanding.
I meant that it does not find anything *new* on top of the existing
patch, not that it can fully recreate the patch.

(I used --include-headers, undid one header hunk from the patch and
validated that the hunk gets recreated)

> This is the full cocci script that I have:
> ```
> virtual patch
> 
> @r1@
> identifier func, ctl, write, buffer, lenp, ppos;
> @@
> 
> int func(
> - struct ctl_table *ctl,
> + const struct ctl_table *ctl,
>   int write, void *buffer, size_t *lenp, loff_t *ppos);
> 
> @r2@
> identifier func, ctl, write, buffer, lenp, ppos;
> @@
> 
> int func(
> - struct ctl_table *ctl,
> + const struct ctl_table *ctl,
>   int write, void *buffer, size_t *lenp, loff_t *ppos)
> { ... }
> 
> @r3@
> identifier func;
> @@
> 
> int func(
> - struct ctl_table *,
> + const struct ctl_table *,
>   int , void *, size_t *, loff_t *);
> ```

LGTM, thanks.

