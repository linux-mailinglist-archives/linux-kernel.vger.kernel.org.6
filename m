Return-Path: <linux-kernel+bounces-241631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ADF927D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C718284683
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AC773442;
	Thu,  4 Jul 2024 18:52:47 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AE373452
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119167; cv=none; b=kcgViWZyiBal1Y2SVz3QUI8a2SFnVKvtV20ga6GOMYkFdwG+p42SKcXhszJ78kYGqNnC03Vfn6le1d8OrEUbo7Hecm/yxO48Cvls6W4AmEAneQiXhfshK8oTObbflqFzKh5RQf57l0nmaPXiYn8TwzAgiEcSTwQCCk9vtCIOPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119167; c=relaxed/simple;
	bh=GQBx1MxgEDAe5DdKAvCgpIEoVogab7OgI3MQjkxoDZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc53UqDJxJDYvG0rcYiyVMxxDJzthX/vfnDEqHxxMQnTg0v5lUt6qSAhp6MHklehhh2+ifKE6yf5kMwCDhnKDW8g/eCEs0VsuJRUmZihrW3Tz4fZ1Ync2DmrOqUN06uX4/ubf6u7co0qsnY3+tJpdi1dK3bdmUwzXb7t2oqrRC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 464IiPxH012837;
	Thu, 4 Jul 2024 20:44:25 +0200
Date: Thu, 4 Jul 2024 20:44:25 +0200
From: Willy Tarreau <w@1wt.eu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, jolsa@kernel.org,
        mhiramat@kernel.org, cgzones@googlemail.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: deconflicting new syscall numbers for 6.11
Message-ID: <Zobtia2Zsaamh9KQ@1wt.eu>
References: <ZobXdDCYBi8OM-Fo@zx2c4.com>
 <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com>
 <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>

On Thu, Jul 04, 2024 at 10:55:46AM -0700, Linus Torvalds wrote:
> A trivial google for "rdrand library" finds lots of hits for things
> that then use the AES-NI instructions to whiten things etc.

As a userland developer, I can say that dealing with external libs for
low-level stuff, which themselves sometimes even come with their own
set of dependencies, is always a pain. There must be compelling reasons
for adding dependencies. It's reinforced when you have to deal with
long term support on your software that goes beyond the lib's.

And having to go through instruction support detection and open-coding
all that stuff with runtime fallbacks for older CPUs is also a pain. Not
to mention the cases where you run in VMs where features are there but
not listed or presented but slowly emulated.

I'm using a lot of arch-specific code at build time, I'm often fine with
detecting -ENOSYS at run time to fall back to an older implementation of
a syscall, but I've not crossed the barrier of runtime CPU features
detection which adds further burden and further fragments bug reports
between users.

Regarding VM migration, my code is not concerned because I'm not aware
of users migrating such VMs. BUT I've got complains in the past from
some users generating UUIDs for each forwarded request that they were
seeing duplicates in their logs due to the lack of thread safety on
random(), which made me work on an alternative. Thus I can easily
imagine that equivalent applications that just want to assign a unique
ID to an event that ends up in a log, and when such applications suffer
a VM migration could face a similar problem that is not easy to address
in userland.

In my opinion, abstracting the hardware is the role of the kernel. If
getrandom() is fast enough for my uses, why not. If it's not, I find
value in having a much faster proposal that offers the same API to all
applications without each having to reinvent the wheel. I can't judge
on the merits of vgetrandom() vs getrandom() though. But to give you an
idea, years ago for portability reasons (random() thread safety, multiple
OS support, performance), I ended up writing my own xoroshiro128 generator
to address multiple problems at once and I must confess I was a bit sad
to see that randoms remain so little portable between operating systems
and their various versions, and that the work left to be done for users
is non trivial.

I can imagine that users with higher expectations than mine would want
to adopt vgetrandom() when available.

Now would I replace my existing RNG with this new syscall when it gets
widely available ? Maybe, if it brings some value. It's easy enough to
deal with two code branches, one with the new, optimal syscall, and the
legacy generic fallback.

Hoping this matches the type of feedback you were looking for.

Willy

