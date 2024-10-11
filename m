Return-Path: <linux-kernel+bounces-360949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032FC99A19E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F243B2233D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CE520B203;
	Fri, 11 Oct 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nu/iZllj"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C14820FA83
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643194; cv=none; b=QqF+WkcDt0GZnERrZxoPtQ82nuoMHB1RTJdqjK4S0fPkXWK+/7WzKAk7YrDK7nnZBcJEDvqMgaHtMxwknav3m51zer2bv9ut1rUu8WRM1QmDbdaMVa1w1Ob4OPnC+hZfh4tsFRwAWD+4RHbR/0Ey5EL/U7fwmJKfC4u92B3ibNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643194; c=relaxed/simple;
	bh=ek8yRoQld6PNWsf7wevQwhf6mUGkYUiNqAVM33loAqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BbRMBZv5fAq18uU6fm9S7aj8ncD5gkDIhrtB/3JiMAvVDwExmAYZM3w1+RWDH1VZPocqo4HXGNOptuLoLPzeaXIFTHG8A1RR01jomQTO7nZErdvhslAd0OH59LhVgJaGtjBX/l5tqK4BedY7/E9rWnEQSih/QHzwXRMmOXmXgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=nu/iZllj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1728643190;
	bh=jULBzTk3CDTvnIp8S8qdm9jX+CRuhYTgoOkcmDLNJPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nu/iZlljRycou9HLfh9m7/sPKwDLX3kiMGcdLI1LggQZTACImAY7NBSyXcLzCCcSl
	 vMT+Q/Pj/kB88F4l+dxva22ZvFXCT+9z5ccEpMbH0fn7MBSmO5KUjbMsxA3jjiwzi5
	 t2BAEfxADz+htlc7ThCgf+H63xnXxS0fLZ504qJcuCQERXzYZxTj7gbs+7oC+nopnJ
	 bwUdsfDV7RHkXzxV53mjEiRjUTFcZr1ZxwUK5f0eTU0cbxOo5VIjxBV8/95r3hFsbx
	 oT1yuQ3ZpoBCGNTDPtbDyF+UtvKUB+F16VXK7yGKeVjY/HKVhy+QBoz0kcNUj3gmqM
	 Oy9c6YAsr5S6Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XQ36G3fjkz4xN6;
	Fri, 11 Oct 2024 21:39:50 +1100 (AEDT)
From: Michael Ellerman <michael@ellerman.id.au>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/vdso: Implement __arch_get_vdso_rng_data()
In-Reply-To: <ZwQMPmfG5zDGz1Wr@zx2c4.com>
References: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
 <a1a9bd0df508f1b5c04684b7366940577dfc6262.1727858295.git.christophe.leroy@csgroup.eu>
 <Zv7HcuhVH1uM9BNI@zx2c4.com>
 <EF78F2DB-7219-407B-9017-990462128B13@ellerman.id.au>
 <Zv_1tqMf-RIXapBD@zx2c4.com> <ZwQMPmfG5zDGz1Wr@zx2c4.com>
Date: Fri, 11 Oct 2024 21:39:50 +1100
Message-ID: <87ttdi6hzd.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> On Fri, Oct 04, 2024 at 04:03:34PM +0200, Jason A. Donenfeld wrote:
>> On Fri, Oct 04, 2024 at 08:52:40PM +1000, Michael Ellerman wrote:
>> > 
>> > 
>> > On October 4, 2024 2:33:54 AM GMT+10:00, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
>> > >Hey Christophe, Michael,
>> > >
>> > >This series actually looks pretty okay to me. I realize ThomasW is
>> > >working on more generic cleanups that might obliterate the need for
>> > >this, and that may or may not wind up in 6.13. But, I was thinking, this
>> > >seems like a good correct thing to do, and to do it now for 6.12, maybe
>> > >as a fix through the powerpc tree. Then ThomasW can base his work atop
>> > >this, which might wind up including the nice lr optimizations you've
>> > >made. And then also if ThomasW's work doesn't land or gets reverted or
>> > >whatever, at least we'll have this in tree for 6.12.
>> > >
>> > >Michael - what do you think of that? Worth taking these two patches into
>> > >your fixes?
>> > 
>> > I agree the series looks good. But they're not fixes by my reading, so I'd be inclined to put them in next for v6.13?
>> 
>> They're "close enough" to fixes. The get_realdatapage stuff is super
>> wonky and weird and it's quite good Christophe has gotten rid of it.
>> Returning NULL from the generic accesor function never really sat right
>> and looks buggy even if it does work. But more to the point, given the
>> other scheduled churn for 6.13, it's going to be a tree-clashing
>> nightmare to get this in later. And this Sunday is rc2 only, so why not.
>
> Bumping to top of the box.

Ack. It was too late for rc2, and I'm naturally cautious, so I decided
these would go into next.

We can handle any merge conflicts with a topic branch.

cheers

