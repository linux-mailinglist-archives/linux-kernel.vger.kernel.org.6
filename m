Return-Path: <linux-kernel+bounces-241555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 865AA927C84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F67E1F237CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CE64E1CA;
	Thu,  4 Jul 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LifcrDUZ"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1073456
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115412; cv=none; b=EFy/sjW8gcWqDX8YYjbjO07fvrZ/b9+3j6D2SSu/VaQJGc7VajE+gkIfIJICY3J3d/YeibaYfoh3xu0jnjD5JnMkQTjollxl3NjRfQe1zQyEd1FmuXCq/VSSbcz3MRQz+iNhMcGCD/cX13DfATs+RKHhdGvjYWOr4UZAEXjqwj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115412; c=relaxed/simple;
	bh=nUom0qLxMPGp2up9CnruaiVjIjcb/QyFMpGO91rE9mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8C2d5+VWZisvrteqqgnhSsNLSc0us2wv084SC8TOYnH6ZYEqjCuDHs4209dsHFC2JXYOFN65xbUTLu6MphORnCMkDKvqG0gxO/lThHzmdFwq5exLzvPVE8DpJ8Xrpda5mhn9KLCs7aiMwQC9DHKlGLJHMiqzzDeFjcpnigw6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LifcrDUZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-17.bstnma.fios.verizon.net [173.48.115.17])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 464HnHV8014631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 13:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1720115362; bh=WPuRfg5i2QUmJI+blsG4PPUd4hX8D48Cv5VVTqWmnUA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LifcrDUZVZ313tEZ2vFpCnySwZ/MMyfHEz4sx5LrJ/WU+mS4EALs4kWCT4mXKS54d
	 o2TOjZcsmUAQpK6fPwBJbhAadpgBZ5pCrThPX0zO/IacxSrPd4KFaNX6cRtSEhG3B7
	 Q7RFBT9dF7dHO6NZfx9WxtclEpwfJYch5M1VAI2KdhoS6hYehFiatVmItplhmI6/LY
	 HRm+UPAy/6kXQYCHzIiX9x7n3Hu0OG3jyhs+ON1q0zswyf01EY7HN7NbGP8me82ys8
	 bTr7B5uKxxfniMSFog3JB7ncbU3Wu7TdL9ddqToauMraEQar8Y+YPnRFT10rOxR5fL
	 clCcQbo4BS+8Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5B2A415C026C; Thu, 04 Jul 2024 13:49:17 -0400 (EDT)
Date: Thu, 4 Jul 2024 13:49:17 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Polakovic <email@dpolakovic.space>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: proposition for fixing Y292B bug
Message-ID: <20240704174917.GB973460@mit.edu>
References: <3be3235a-dea7-a5ca-b5ea-4047bdeb695d@dpolakovic.space>
 <ZoFgga45QCh2uA0i@archie.me>
 <9e3b638d-76f2-8520-2a24-7de0cd0bc149@dpolakovic.space>
 <ZoJx5GaBDHg7nayw@archie.me>
 <cef39a6f-426d-4c4d-950e-edbbe5e95acf@intel.com>
 <d88861a6-ccd9-3fe5-67e0-b50a72ca1e51@dpolakovic.space>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d88861a6-ccd9-3fe5-67e0-b50a72ca1e51@dpolakovic.space>

On Wed, Jul 03, 2024 at 05:29:58PM +0200, David Polakovic wrote:
> 
> I am not sure if I don't understand your solution, but extending the
> memory designation from 64 to 128 bits, is another temporary
> solution, which will again overflow one day.
> 
> The sole reason why I was proposing the new "BigInt" type was to
> store each digit of the time_c as separate element of array, which
> could be resized (added one digit) as needed. The only limit would
> then be the physical amount of memory in the machine.

You state that you're not experienced enough to be able to send "a
merge request".  Fair enough; you also apparently don't know that
github merges is not how kernel patches are submitted, reviewed, and
integrated.

What you apparently don't appreciate it is that performance is
something that is critically important for the Linux kernel, and using
multiple precision integers is not really compatible with the best and
highest performance.  Computer Science is an engineering discipline,
and it's all about tradeoffs.  You could enginere a plane that can
travel faster than the speed of sound, but if that compromises fuel
efficiency and annoying people who are below its flight path, pursuing
speed at all costs is not going to lead to commercial success.
(Exhibit 1: The Concorde).

Similarly, trying to make sure that software will work in the year 292
Billion AD might not be all something that most people would consider
high priority.  After all, it's.... unlikely... that the x86_64
architecture will still be what we will be using 290 billion years
from now.  So if we need recompile the kernel sometime in the next 100
billion years for some new CPU architecture, and if it's unlikely that
hard drives brought brand new are likely to be still in operation a
decade or two from now --- there is plenty of time to evolve the
on-disk format before a billion years go by, let alone 100 billion or
200 billion years.

Finally, kernel development is driven by people who are willing to do
the work.  If you want to demonstrate that it's possible to use MP
integer mathematicswithout horribly comprmising performance, then you
need to do the work.  (BTW, if you don't know what the term "cache
line" means, then I encourage that you understand that first.)  But
dropping a pointer to a blog post and expecting that people to do your
homework for you is not really realistic.

Cheers,

					- Ted

