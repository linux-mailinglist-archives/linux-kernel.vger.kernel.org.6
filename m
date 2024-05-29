Return-Path: <linux-kernel+bounces-193524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F36C8D2D66
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36ACDB212ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D1C15F403;
	Wed, 29 May 2024 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="edGgTgeB"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A615A878;
	Wed, 29 May 2024 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964614; cv=none; b=b/73nrPSxit7tnXMrr9BpvMeNSHtZlzVOjse14EgyrQbcC0yDjAOmyr2fMOZ1Ghpn584CS9Z7xR6K1z0DRTovfAmiNpR8OKhf8ojUToya4dtBqlk0vBPOtXrbNlf34rdwvZNDEERsNYj082nETG+u3WH8pUvWUdjCD+y+BcWMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964614; c=relaxed/simple;
	bh=wFthIixpM/4AONv71bNR6b9b00SBagOCPApCQOH6ONU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK35M/OOyiVuEjUrI3j9UO9zsuRn+7jIOmZ/ByD8SV0yEUr3U00kAjFqWmkcO0Y0V2lZebcbc37rfoM5XcRPGi7yw4EjnEcsISw3TfFYdLG5fR6nMSGMHnfiVum2HkwOCiBYlBgL1+5/4XF15ei0KOkfmmZ7wOb4ZfTSR41vMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=edGgTgeB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1v28HEPxLDPa8kCPdsNqS5C39hyNdpdHx3rI+3xkpFg=; b=edGgTgeBp4/w8cu4GMdrvhYvoz
	Tv1VHFIrbFxN+iReY0a4LSGBThEw/79PhmUm4nNH3j5gcYQT6Ph6YaBiaSb6vRLrIhfI4WW4vCgV5
	1n2zbStCOHoRDo135QmUHdDUkcXP2U8JNnQIS9nxXmokJYD8Q3o5Ntz5NKmtI6ir1ASuV7MeOmWFn
	wGi43mE4M73g37FrR9akci3mvr/3CrkrqA8AEjKeHZ6El/6bctebfn1vXLNHNFgQDMDTZCI2D+HNW
	G92+RSe56CQ6jNXgOdjBGq0EoWa2CggobW7G672jXSsuR/nSU0fv7HiiiTIpA/RwQfdXmrGfsnctD
	Jl70Iygg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sCCvY-002CeZ-35;
	Wed, 29 May 2024 06:36:49 +0000
Date: Wed, 29 May 2024 07:36:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Alexey Gladkov <legion@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: PROBLEM: kbd busted in linux 6.10-rc1 (regression)
Message-ID: <20240529063648.GM2118490@ZenIV>
References: <ad4e561c-1d49-4f25-882c-7a36c6b1b5c0@draconx.ca>
 <20240529052543.GL2118490@ZenIV>
 <d7412ef9-8e25-4f55-aac9-8ec479fb6775@draconx.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7412ef9-8e25-4f55-aac9-8ec479fb6775@draconx.ca>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 29, 2024 at 01:36:28AM -0400, Nick Bowler wrote:
> On 2024-05-29 01:25, Al Viro wrote:
> > On Wed, May 29, 2024 at 12:45:56AM -0400, Nick Bowler quoted:
> > 
> >>        All other headers use _IOC() macros to describe ioctls for a long time
> >>        now. This header is stuck in the last century.
> >>    
> >>        Simply use the _IO() macro. No other changes.
> > 
> > ... are needed, since _IO() is arch-dependent; this is quite enough to fuck
> > alpha and sparc over.  _IO(x,y) is (1<<29) + 256*x + y there; both ports
> > got started with compat userland support, so _IO...() family there is
> > modelled after OSF/1 and Solaris resp.
> >
> > kbd ioctls predate all of that.
> > 
> > Please, revert 8c467f330059 - commit in question breaks userland on alpha
> > and on sparc for no reason whatsoever.  Might be worth adding a comment
> > to those definitions at some point, but that can go on top of revert.
> 
> FWIW I see exactly the same problem with 6.10-rc1 on powerpc too.
> 
> > Folks, 0xXYZW is *not* an uncool way to spell _IO(0xXY,0xZW) - if there's
> > any chance that those definitions are seen on all architectures, they
> > should be left alone.

arch/alpha/include/uapi/asm/ioctl.h:36:#define _IOC_NONE        1U
arch/mips/include/uapi/asm/ioctl.h:22:#define _IOC_NONE 1U
arch/powerpc/include/uapi/asm/ioctl.h:8:#define _IOC_NONE       1U
arch/sparc/include/uapi/asm/ioctl.h:35:#define _IOC_NONE        1U
include/uapi/asm-generic/ioctl.h:57:#ifndef _IOC_NONE
include/uapi/asm-generic/ioctl.h:58:# define _IOC_NONE  0U

FWIW, ioctl number is bits 0..7 and type - 8..15 on everything.
The fun is in upper 16 bits:

alpha, powerpc, mips - bits 29..31 are for direction (001 - none,
010 - read, 100 - write, 110 - read/write) and bits 28..16 are
for argument size.

sparc - bits 29..31 are for direction (001 - none, 010 - read,
100 - write, 110 - read/write) and bits 29..16 are used for
for argument size if bit 30 or bit 31 are set (i.e. when it's
not "none").  Uses the fact that "none" does not combine with
"read" or "write", so we can treat 011.... as "write with argument
size in range 8K..16K".

everything else - bits 30..31 are for direction (again, bit 30
is for read, bit 31 - write), bits 29..16 for size.

You get the arch-independent values from _IOR, _IOW and _IOWR
(with argument size limited by 8Kb on alpha, powerpc and mips,
and by 16Kb everywhere).  Upper halfword in range 0xc000--0xffff 
is read/write, 0x8000--0xbfff - write, 0x4000--0x7fff - read.

_IO, however, is arch-dependent - you get 0x2000 in upper halfword
on alpha, powerpc, mips and sparc and 0 on everything else.

Rationale: compatibility with definitions on other Unices on
the same platform; not sure about powerpc, but alpha, mips
and sparc ports used to have binary compatibility with OSF/1,
IRIX and Solaris resp.  Incomplete, but having compatible
ioctl numbers layout avoided a lot of needless PITA...

