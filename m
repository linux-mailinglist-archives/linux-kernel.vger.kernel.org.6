Return-Path: <linux-kernel+bounces-531397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DDEA43FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8A83BF787
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02F62690D1;
	Tue, 25 Feb 2025 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="CUYBtmRN"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB5268FFE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488474; cv=none; b=GDHTQb7WV7HlXtS3IuYOytIgQP7npVZ6i9LGdm9C2L4vIDT8cJjsAAEN/zx9aXoRMGLve4geWWQw+/2l4Zx50Rs1n64pSbnNRMWk0R0ur+a5TP7Ovu4TfHzy5YLVD1vL4Mckvn4A0y6u2PfIJs/HCGifpWXIfGxK0Fwfhk4j7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488474; c=relaxed/simple;
	bh=jyeTnXrsHhsYX3YxoE9935CbRvycdZ3AB5a9mTYXpbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSACyfyyR4S5Wg1BWvSYlml+RROyTrGia4pTt7VXx605gZ4XVhbHw/dGpaWrl4tUCCytz325QCqJtbRZbKxganTBu4WldcxHqRQrjpFF4ujoxlkE8s9WpHl7GuR2POiNH0/hyIEZSIHAPxKmXTFVfAXhExjfO0RbK17N+tcwl0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=CUYBtmRN; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=ch15gq6+yE1qgD1FXBTrb/33lczrC6ySmbc2ZQVM5Fw=; b=CUYBtmRNiIFcQN/k
	6j68mdwWTdymE54OmfVyfwMlMRPrvNvgP0GJApfTGlM9DaUdz5CjGh/n7NA7XWGPG8tjk1IiDjoZn
	lDit+S86eKQ9wFGSMD1uoNgL+pjc4j3G0NuSszCSaaZlJ9L4B2XhGF3wfFvo7pWof8+TXhqcu4Qfp
	MGR7Y0i9flw2SXUFXs63bbwkzoThdCvNHXb460Wgy4n09Z3gcY0uMqlWFVxVi//ZJXH7+nbp17JtV
	ujSXbtlToIjg8qMESBddmC8fOlnR6hoy3t8BF5WVDSBWfSKuu3oYDq+MAKqUKHlnZN11c8zM84okk
	Y//Vs/uWo1b2vzW6fQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tmuYc-000ggP-25;
	Tue, 25 Feb 2025 13:01:06 +0000
Date: Tue, 25 Feb 2025 13:01:06 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, david@rowetel.com
Subject: Re: users of drivers/misc/echo ?
Message-ID: <Z72_EnXyHoDACRk5@gallifrey>
References: <Z7tZhYET41DAoHVf@gallifrey>
 <07afd3cb-3ab1-4dc9-b0c1-3fef2d52f60b@app.fastmail.com>
 <Z724l3DFJbGevtPF@nataraja>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Z724l3DFJbGevtPF@nataraja>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:43:57 up 292 days, 23:57,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Harald Welte (laforge@gnumonks.org) wrote:
> Hi Arnd,
> 
> > Adding Harald to Cc, might know more about it.
> 
> thanks for Cc'ing me on this thread.

Hi Harald,
  Thanks for the reply.

> On Sun, Feb 23, 2025 at 09:38:12PM +0100, Arnd Bergmann wrote:
> > I don't see any in-tree users for it either, but I found one
> > project using the exported symbols, and there is a debian
> > package for it as well:
> > 
> > https://tracker.debian.org/pkg/osmocom-dahdi-linux
> > https://gitea.osmocom.org/retronetworking/dahdi-linux/src/branch/master/drivers/dahdi/dahdi_echocan_oslec.c#L34
> 
> Note: The official upstream of DAHDI is maintained as part of the Asterisk soft switch project,
> the Osmocom fork has just become more popular in recent years due to very slow maintenance of
> upstream.
> 
> Any of the DAHDI forks is used in production deployments by a number of
> different telephony / softswitch / telecom software projects (like
> Asterisk, FreeSWITCH, yate or many osmocom sub-projects) in order to
> interface with classic anaolog or TDM (time division multiplex)
> telephony technology.  
> 
> Even today this TDM technology (most likely in most instances without
> open source softswitches) is still relevant in commercial production
> deployments, including many (but not all) cellular carriers
> around the world, but for example also as part of GSM-R (railway
> communications systems) for at least until 2035.  I personally also know
> of present-day production deployments in satellite telephony
> infrastructure.
> 
> However, those DAHDI-using deployments that I personally am familiar
> with do not use the software echo canceller discussed here.  On the
> other hand, I'm quite certain that there are many PBX/IVR related
> systems out there (unrelated to my area of cellular or trunked radio)
> that would still use the echo canceller discussed here.
> 
> In any case, for this discussion, it doesn't matter, as all DAHDI
> flavours make use of the same API function.
> 
> > With our normal rules, we should just remove it as there is no
> > way to use the code without external modules, but I don't know
> > how we even got to this state.
> 
> I'd expect the echo cancellation code was used by mISDN for as long as
> that was still in upstream.  As mISDN has (sadly, but understandably)
> been removed, the echo canceller likely remained in the tree without any
> other in-tree users.

OK.

> DAHDI has been using the in-kernel echo canceller for decades.  If it's
> removed now, it will likely mean that DAHDI will carry a copy of it and
> selectively compile that as out-of-tree module for future kernel
> versions.

Well, it's a bit odd - but if it's actively used it's not terrible.
(I guess there are kernel drivers that are fully usable that are never used!)

Some questions:

1) I see drivers/dahdi/dahdi_echocan_oslec.c

/* Fix this if OSLEC is elsewhere */
#include "../staging/echo/oslec.h"
//#include <linux/oslec.h>

now that moved to drivers/misc in 2014 by Greg's
6e2055a9e56e ("staging: echo: move to drivers/misc/")

So is most of this on ancient kernels or do people
actually use modern stuff?

2) I see there is a fir.h that's different from the kernels
drivers/misc/echo/fir.h  doesn't that cause problems?
Should one get updated from the other somehow?

3) Any idea why it's never been upstreamed?
  I guess the problem is that dahdi-base.c is quite a chunk and
that would have to go in to take any of the useful other bits.
Oh hmm, and a whole bunch hasn't got signed-off's so it's
very hard.

Dave


> I personally wouldn't see that as a big problem, as DAHDI itself has
> always been out-of-tree anyway, and adding one more module to that is
> not a big deal.  Note that I cannot speak officially for the DAHDI
> project as I'm just maintaining the Osmocom fork.
> 
> Kind regards,
> 	Harald
> -- 
> - Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
> ============================================================================
> "Privacy in residential applications is a desirable marketing option."
>                                                   (ETSI EN 300 175-7 Ch. A6)
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

