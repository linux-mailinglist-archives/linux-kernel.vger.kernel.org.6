Return-Path: <linux-kernel+bounces-423930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B7D9DAE62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36BBB21C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B81F20125E;
	Wed, 27 Nov 2024 20:13:51 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD0612E1E0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732738431; cv=none; b=dEI2vU+ZP+VK/wLsXlwf2/c76T+Rf7IPIsOkBx7PHC7Vz7L77F4Ka2kNzSluvyBQ6cF1yoK+oA0yszkJDUfOqxLpiokpyYudJJoFuSIG5pkZmGI7IZ7OjNshUGxiD3lPHDaT5PHpQ2OBhenA7rYQ8crEU5B7iDXRN8augJEhtY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732738431; c=relaxed/simple;
	bh=1AlcZanFnP+t+j0vD87Ebae2fiwPOYbqZu2hIx8r7KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2IACsP+o/Dm3Nh7RzxUEtdDbYN9rkl7jaiNNUGAh7xBTWyC8ugGFsE592XJYliCUjcOUm6Q+R8U+VIYn49RX89n7t0uBM7AkKjxdH+Hn7gR5p5Bzp4y2YSqJLcFhacN8KbJ9qhl274uQu9jgrroGW3stZn9BdiSpy3C03gDnoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4ARKAHQb021080;
	Wed, 27 Nov 2024 14:10:17 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4ARKAGvl021078;
	Wed, 27 Nov 2024 14:10:16 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 27 Nov 2024 14:10:15 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, arnd@arndb.de
Subject: Re: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
Message-ID: <20241127201015.GO29862@gate.crashing.org>
References: <20241114131114.602234-1-mpe@ellerman.id.au> <20241114210418.GM29862@gate.crashing.org> <87mshm7ixu.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mshm7ixu.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i

On Tue, Nov 26, 2024 at 02:49:49PM +1100, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > On Fri, Nov 15, 2024 at 12:11:04AM +1100, Michael Ellerman wrote:
> >> CHRP (Common Hardware Reference Platform) was a standard developed by
> >> IBM & Apple for PowerPC-based systems.
> >> 
> >> The standard was used in the development of some machines but never
> >> gained wide spread adoption.
> >> 
> >> The Linux CHRP code only supports a handful of machines, all 32-bit, eg.
> >> IBM B50, bplan/Genesi Pegasos/Pegasos2, Total Impact briQ, and possibly
> >> some from Motorola? No Apple machines should be affected.
> >> 
> >> All of those mentioned above are over or nearing 20 years old, and seem
> >> to have no active users.
> >
> > This was used by all non-IBM 970 systems as well.  The last was SLOF on
> > JS20 and JS21, about 20 years ago yes, and I doubt anyone uses it still
> > (I don't).
> 
> By "this" you mean the CHRP standard?

I mean the "maple" stuff, and the whole "chrp" thing in PowerPC Linux.

> At least in Linux the "CHRP" platform has always been 32-bit only AFAIK.

No?  I've written stuff for it for years :-)

> My memory is that JS20/JS21 used the "maple" platform, which was a
> 64-bit only bare-metal platform, possibly it was actually == CHRP, but
> we didn't call it that in Linux.

Well, it is what it is called in the Open Firmware device trees!

It has a root "device_type" property that starts with the string "chrp".
But that really is only because Yaboot for some reason needs it to
behave reasonably, heh.  (I didn't remember the details, but I still
have the original SLOF open source release tarballs :-) )  So yeah it
wasn't anything "chrp" in Linux itself, aha.

> But maybe I'm wrong, you were more involved than me back than, and it
> was a long time ago :)

Very long ago.  Sad to see it go, but the Git tree will never forget :-)


Segher

