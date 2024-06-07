Return-Path: <linux-kernel+bounces-206191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F580900574
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38BB2859FC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D296194ACD;
	Fri,  7 Jun 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DFmbfU1i"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6CD192B89
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768109; cv=none; b=Vc0Z3CAKkzHQ0HPM1WTHjXFKbxP2ZADPFAamYUPPPXAEfvdKLbF8Od0YUU6PQgXbGopDsUVCeCVm4Dz6PYbNQDD3AeEeMVMi1dFnbN3jCp5t/MoFlHnAJVmYcLOK5mBIY3NhVlB4aEIteKyEYlH5MZMCgGvv4DXUc90gBsE7WHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768109; c=relaxed/simple;
	bh=flRN4f0GUMAs2oVcEL67vF6IZujwClDcBgizdMQWYyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtYHvsgCyIadX/MQyZhXeY80S0ZkWhCJvO3HCrpzGwBb8+siIfJ/eRGLLjBNM9CwiAukSN4elUj6UFn8HDiOAKPgoI2VVh4maO0Cf3VURoip/zjvEoAm3qDOtFiCu/m9GBZU9f5W2qd1v/uVKa2Losjqyr4jbTcHXUTDOcCRJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DFmbfU1i; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717768100;
	bh=flRN4f0GUMAs2oVcEL67vF6IZujwClDcBgizdMQWYyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFmbfU1iw3Zphmxi3+Lr+gl5uNpaCfP7J5ADHYUrx7yWq6CrnVCjGRPg2jjlVPKKZ
	 se3REKn9ko7gyYaBrCete4eUy25cElcWnQc5V21yKnOVuy0ENZ/GvUKC7x8u3xtG9X
	 jUJLY8qXHibmG4NvDMalFeDXFRyHhFgq4LxWAZlk=
Date: Fri, 7 Jun 2024 15:48:20 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: Current state of the sysctl constification effort
Message-ID: <a872f104-32ed-4479-9480-0cc01c31e998@t-8ch.de>
References: <7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>
 <CGME20240531163128eucas1p20976d08e829373bfa8aa04fda1c7bec4@eucas1p2.samsung.com>
 <202405310930.5E2728A@keescook>
 <20240605082625.6hwdc3haim66rr7v@joelS2.panther.com>
 <202406061143.27C12F44A3@keescook>
 <20240607093053.ig6cqrr3xdxhbbt5@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607093053.ig6cqrr3xdxhbbt5@joelS2.panther.com>

On 2024-06-07 11:30:53+0000, Joel Granados wrote:
> On Thu, Jun 06, 2024 at 11:52:25AM -0700, Kees Cook wrote:
> > On Wed, Jun 05, 2024 at 10:26:25AM +0200, Joel Granados wrote:
> > > On Fri, May 31, 2024 at 09:31:24AM -0700, Kees Cook wrote:
> ...
> > > @kees: Since you have probably done these before, I'll ask you the
> > > questions:
> > > 
> > > 1. The idea is to send Linus the treewide-constify patch on its own at
> > >    the end of the merge window for 6.11. Right?
> > 
> > Right. The best time is likely around Wed on the second week of the merge
> > window, assuming all dependencies have landed. And it could be sent
> > earlier if all the dependencies land sooner than that.
> That makes sense. I have added a reminder to myself to do this when the
> time comes. Feel free (@kees and @thomas) to scream at me if you see
> that I might be forgetting :)
> 
> > 
> > > 2. Is there a special way to send these treewide patches? Or is it just
> > >    a regular PR with an explanation on why it is being done?
> > 
> > I would do a regular PR with all the details for Linus to do the change
> > himself, but many times people send these as an explicit patch. For
> > example, include the full Coccinelle script, or the "sed" command
> > line, etc, and then detail any "by hand" changes that were needed on
> > top of that.
> @Thomas: have you sent the 11/11 patch on its own to the lists? I cant
> find it in my history. Please send it as a stand-alone patch, so It can
> go into sysctl just like the others.

No, I didn't send it to the list on its own yet.
Do you want some changes or can I send it as-is?
(Plus the new motivational blurb)

> 
> > 
> > > 3. Can you please send (if there are any) me any examples where this has
> > >    been done in the past. Maybe some lore.kernel.org links?
> > 
> > I found this one that is a good example, though it's a PATCH not a GIT PULL:
> > 
> > https://lore.kernel.org/lkml/20221220134519.3dd1318b@gandalf.local.home/
> > became
> > https://git.kernel.org/linus/292a089d78d3e2f7944e60bb897c977785a321e3

