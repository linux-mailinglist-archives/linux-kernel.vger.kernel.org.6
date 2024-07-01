Return-Path: <linux-kernel+bounces-237110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FF691EB8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 01:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A781F224E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6447917332C;
	Mon,  1 Jul 2024 23:48:40 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC12172BD6;
	Mon,  1 Jul 2024 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877720; cv=none; b=En6X2w+lDoeaUGo3TUB9m6HKh77fFct1TejBcCP3FdG6DJ9HBf733zooivMtCPPR1gpm6oXVdVhcXcs0A48XnvVHrz101JrUm/3kd50f5Etg02Jcg2XnYXc1x+3PYE1savfRTAXXbFY/UGz2IKV6EaVA/9vrru72BqKTQPpAgJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877720; c=relaxed/simple;
	bh=rvFiYLf8K6reYFK3b2XAnPVQ+G8uEYnny6VRYt/HqA4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hTiEy8MbClbTyFh/BnlhjDwnJIMab7IHC7iZ0OQvsG2vVEWLwav0f+7Fgyc0FfEGl8Sa3UbLThPzqtiTgCUofhjjmc2RDury0ZIMcxxBSqeVK1UtnfPdqKbAQvOFbVwItRbVsNU9UQh3ay0nFpaCV53uLAwrtJ66SPKajc9IUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 2873092009C; Tue,  2 Jul 2024 01:48:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 217F792009B;
	Tue,  2 Jul 2024 00:48:36 +0100 (BST)
Date: Tue, 2 Jul 2024 00:48:36 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: "Paul E. McKenney" <paulmck@kernel.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org, 
    Arnd Bergmann <arnd@arndb.de>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
    Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
    Michael Cree <mcree@orcon.net.nz>, Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
In-Reply-To: <CAHk-=wha2rH2UcTvHUYK+dNnP6UCDRkYM0atvw_GTP5Sz3OZrQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2406302009050.43454@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de> <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <CAHk-=wi7WfDSfunEXmCqDnH+55gumjhDar-KO_=66ziuP33piw@mail.gmail.com> <alpine.DEB.2.21.2405302115130.23854@angie.orcam.me.uk> <CAHk-=whiH6g+T7+YWSYgAhJ9HsJ2bUUDJfLLo_Yhbi8CVgkHDg@mail.gmail.com>
 <alpine.DEB.2.21.2405310457060.23854@angie.orcam.me.uk> <CAHk-=wha2rH2UcTvHUYK+dNnP6UCDRkYM0atvw_GTP5Sz3OZrQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Jun 2024, Linus Torvalds wrote:

> >  Anyway, back to my point.  A feasible solution non-intrusive for Linux
> > and low-overhead for GCC has been found.  I can expedite implementation
> > and I'll see if I can regression-test it too, but I may have to rely on
> > other people to complete it after all, as I haven't been prepared for this
> > effort in the light of certain issues I have recently suffered from in my
> > lab.
> 
> Yeah, if compiler support makes us not have to care, then I don't
> think the difference between pre-BWX and BWX is going to matter much
> for the kernel.
> 
> The real pain with alpha has been that it's special enough that it
> affects non-alpha code, and BWX was one big piece of that.

 Understood, that's burden beyond justification for an obsolete legacy 
platform.

> That said, some of the EV4 misfeatures end up being a huge pain inside
> the alpha code either because of the horrible hoops that the IO
> accessors have to jump through, or because of the broken ASID's.
> 
> So even with enw compiler support, maybe it's worth trying to
> re-introduce any support for older cpu's incrementally.

 Ack.

> For example, the ASID hw issue is _claimed_ to have been fixed in
> PALcode, and maybe the games we played for ev4-era cpus aren't
> actually needed any more?

 Actually my system seems to be an odd relic that has very old PALcode:

[...]
X3.7-10895, built on Sep 15 1994 at 10:19:05
>>>sh conf

SRM Console X3.7-10895  VMS PALcode X5.48-60, OSF PALcode X1.35-42
[...]

-- which is dated well before the system's release date.  It has been 
heavily patched with extra components retrofitted on the PCB as if an 
early hardware revision and the part number labelled on the PCB it's an 
AlphaStation 250 and yet it came packaged as AlphaServer 300 (the only 
documented difference between the PCBs of the two systems is the maximum 
amount of DRAM supported), with a vast mismatch between the dates given on 
the PCB and the case.  I don't know what's the story behind it, maybe it 
once was a DEC engineering machine.

 And for instance its SRM cannot netboot over BOOTP/TFTP, it can only 
use MOP.  Not an issue for me, and I feel a bit uneasy about upgrading the 
firmware, I'd rather I didn't brick the machine.  I guess we shall see 
whether it matters and if so, then what can be done about it.

 I used an AlphaServer 300 before that was purchased brand new and I can't 
recall any such patching on the PCB, and I reckon SRM was more modern too.
Indeed having checked old logs I found:

[...]
version                 X6.2-165 Nov  4 1996 10:06:10
>>>sh conf

Firmware
SRM Console:    X6.2-165
ARC Console:    4.49
PALcode:        VMS PALcode V5.56-2, OSF PALcode X1.46-2
[...]

> And the various odd IO platforms should only be re-introduced when
> there are people who actually have access to the relevant hardware and
> will test.

 Absolutely, what's the point of keeping something we have no way to
verify?  I'll begin with what I'm interested in myself and will gather 
input from people willing to verify stuff with other hardware they may 
have.

 Anyway, it's been a hectic month for me and I have my Alpha machine in 
the remote lab fully ready for this effort now, with a number of issues 
fixed, most importantly rather tricky GCC PR rtl-optimization/115565, 
<https://gcc.gnu.org/bugzilla/show_bug.cgi?id=115565> which prevented the 
userland from being used as installed.

 With that in place the system was able to complete GCC 15 verification, 
so now it should be able to do pretty much anything.  I ran some glibc 
upstream master testing too.

 With that ticked off I do hope to work on the GCC part throughout July, 
and then the kernel bits will follow.

  Maciej

