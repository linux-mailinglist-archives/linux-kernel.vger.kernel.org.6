Return-Path: <linux-kernel+bounces-524668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B53A3E59D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D445A3B9FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14BA2638AA;
	Thu, 20 Feb 2025 20:09:16 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32331E5B6C;
	Thu, 20 Feb 2025 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082156; cv=none; b=pKL7vIy/2p0/t9Pdtp5pp72tUacgcqn8v86UagcIeYVm/7goCMv9HNEJ69VAl8suhPUJxA+fhGUa6I/8VE8ceuIWynjEHlIVdTWxW7g8sUeqR+z5tqVBjeZR/WjUBqg33ZJljOU3OLPBq3k80Y6sopupStiDLQnEt1jDexDbjMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082156; c=relaxed/simple;
	bh=GeE1Y79wHUZQQCWuVYkBo/qm9ep3L0B2WVecTatnIcM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B92R5sc/PKeORJ9vHpV7XeXb/QdfNBOTiRnX8s4Bp7h4PjkS5rR1ByNALfAkCt0S8mobSP0w07RDouDaQwPwwUaCeZphcrLQjVJHfeP6Knu1cjNwObS8zqqgR8lYaHt5ne/vXKgPFg+CbvxsttqIl/zuBjHdqZ3y6KS9RROHaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5CD3292009C; Thu, 20 Feb 2025 21:09:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 55A4792009B;
	Thu, 20 Feb 2025 20:09:12 +0000 (GMT)
Date: Thu, 20 Feb 2025 20:09:12 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matt Turner <mattst88@gmail.com>
cc: Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@unseen.parts>, Arnd Bergmann <arnd@arndb.de>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Magnus Lindholm <linmag7@gmail.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Al Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alpha: Emulate unaligned LDx_L/STx_C for data
 consistency
In-Reply-To: <CAEdQ38FMnWwT4bM41y2Zxh27KGbMokwc8YTBw4mYDZnaJPsSUw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2502202000410.65342@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk> <45155869-1490-49ab-8df1-7ad13f79c09a@linaro.org> <CAEdQ38FMnWwT4bM41y2Zxh27KGbMokwc8YTBw4mYDZnaJPsSUw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 20 Feb 2025, Matt Turner wrote:

> > > Complementing compiler support for the `-msafe-bwa' and `-msafe-partial'
> > > code generation options slated to land in GCC 15,
> >
> > Pointer?  I can't find it on the gcc-patches list.
> 
> I believe it's this:
> 
> https://inbox.sourceware.org/gcc-patches/alpine.DEB.2.21.2411141652300.9262@angie.orcam.me.uk/

 That's the original series; v2 is here:

https://inbox.sourceware.org/gcc-patches/alpine.DEB.2.21.2501050246590.49841@angie.orcam.me.uk/

> The first half or so have landed so far, right Maciej?

 Yes, fixes for bugs discovered in the course have been committed and the 
rest of changes already approved, although there were a couple of comments 
I yet want to investigate/address by the end of next week.  Getting clean 
GCC test results with the kernel emulation was my objective before moving 
forward.

  Maciej

