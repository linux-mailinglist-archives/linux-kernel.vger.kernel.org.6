Return-Path: <linux-kernel+bounces-531392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428A2A43FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3B4440546
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B992690D9;
	Tue, 25 Feb 2025 12:59:17 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674D268FE9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488357; cv=none; b=fib4VrdVsh8ZBxBy/Yx+lUHdrAXlCwtVM6kz2E+xxplDHoWrB7kzBA8NiRkwrh8DKuBK4CyR7hMmazfPOqgLActLL9+6kP/3k7m8GP0+JKLORpHxhNJf2o8TjZdT9RJpYggmNuW541ByHWbDll5sKa0bVonBZ77moXfdF4gQ5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488357; c=relaxed/simple;
	bh=9MDAaOkzjRCOz3MuMWw4HXIQo4co0NCFHKCaS5GZhbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awQeG7B/ZyGocrfpUeon8zksHElOErJA9cjftFCayh+IUx2qzIp7wsbqt8yVTNFyelleAAYY48OVDaMfTGVCVlx/p4UOKDHGi3hkh75ziqiM2CJSApy7AnotxkP7b4yx4QN6I9nLVsfmE+uzuHSKFsIgcGQg2yf+jwvgDV1lGA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
	(envelope-from <laforge@gnumonks.org>)
	id 1tmu7y-003Gx0-L0; Tue, 25 Feb 2025 13:33:34 +0100
Received: from laforge by nataraja.fritz.box with local (Exim 4.98)
	(envelope-from <laforge@gnumonks.org>)
	id 1tmu7r-00000000YTm-4306;
	Tue, 25 Feb 2025 13:33:27 +0100
Date: Tue, 25 Feb 2025 13:33:27 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux <linux@treblig.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, david@rowetel.com
Subject: Re: users of drivers/misc/echo ?
Message-ID: <Z724l3DFJbGevtPF@nataraja>
References: <Z7tZhYET41DAoHVf@gallifrey>
 <07afd3cb-3ab1-4dc9-b0c1-3fef2d52f60b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07afd3cb-3ab1-4dc9-b0c1-3fef2d52f60b@app.fastmail.com>

Hi Arnd,

> Adding Harald to Cc, might know more about it.

thanks for Cc'ing me on this thread.

On Sun, Feb 23, 2025 at 09:38:12PM +0100, Arnd Bergmann wrote:
> I don't see any in-tree users for it either, but I found one
> project using the exported symbols, and there is a debian
> package for it as well:
> 
> https://tracker.debian.org/pkg/osmocom-dahdi-linux
> https://gitea.osmocom.org/retronetworking/dahdi-linux/src/branch/master/drivers/dahdi/dahdi_echocan_oslec.c#L34

Note: The official upstream of DAHDI is maintained as part of the Asterisk soft switch project,
the Osmocom fork has just become more popular in recent years due to very slow maintenance of
upstream.

Any of the DAHDI forks is used in production deployments by a number of
different telephony / softswitch / telecom software projects (like
Asterisk, FreeSWITCH, yate or many osmocom sub-projects) in order to
interface with classic anaolog or TDM (time division multiplex)
telephony technology.  

Even today this TDM technology (most likely in most instances without
open source softswitches) is still relevant in commercial production
deployments, including many (but not all) cellular carriers
around the world, but for example also as part of GSM-R (railway
communications systems) for at least until 2035.  I personally also know
of present-day production deployments in satellite telephony
infrastructure.

However, those DAHDI-using deployments that I personally am familiar
with do not use the software echo canceller discussed here.  On the
other hand, I'm quite certain that there are many PBX/IVR related
systems out there (unrelated to my area of cellular or trunked radio)
that would still use the echo canceller discussed here.

In any case, for this discussion, it doesn't matter, as all DAHDI
flavours make use of the same API function.

> With our normal rules, we should just remove it as there is no
> way to use the code without external modules, but I don't know
> how we even got to this state.

I'd expect the echo cancellation code was used by mISDN for as long as
that was still in upstream.  As mISDN has (sadly, but understandably)
been removed, the echo canceller likely remained in the tree without any
other in-tree users.

DAHDI has been using the in-kernel echo canceller for decades.  If it's
removed now, it will likely mean that DAHDI will carry a copy of it and
selectively compile that as out-of-tree module for future kernel
versions.

I personally wouldn't see that as a big problem, as DAHDI itself has
always been out-of-tree anyway, and adding one more module to that is
not a big deal.  Note that I cannot speak officially for the DAHDI
project as I'm just maintaining the Osmocom fork.

Kind regards,
	Harald
-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

