Return-Path: <linux-kernel+bounces-271776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF2294531E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553C01C229EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897F41494D1;
	Thu,  1 Aug 2024 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="onMTodDX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J47zcBmQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361B143897
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539306; cv=none; b=Khe/DTzoJckkR0bqTBbh15qnPykUmuizBY3RadY+8mRY4EprrNZbfEVdyH/knLJHxifyZaHFvUoa+FbD8rBEdqxXw7DoPyFirJhWPjMrrSHgYpgvn8I4vIEPWkQ33qF9fF3Fy0HD731UjjC4clqHGs9gN9P//epVAtT1jnvV29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539306; c=relaxed/simple;
	bh=VFQ6vc7m2LcMWbo83coD+PFYONi2nTZuiz1vFUAQoSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SBNsa66I6ZMxXH9X22nR7wh61caYv92QeuUQePwGo0eq64R0onfggxOKelTsLwzBm5EkpdpFMMr1ibSeSE6brXYbnFVPD10ctJjv+qzsEyHJ+E+hqVOt+OT4eVv+3uwMZHc2iKdTzqTBN/NeGjwC774b+Cln34n5ENDhi5DDcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=onMTodDX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J47zcBmQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722539303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7rFecauNrUJNv4kCU5uw04s4iBRr3/U9tBY9AZZrRmk=;
	b=onMTodDXidhdmWrMSTTFcc+l4BcdIiPrQtndgl1mByyHD9M3PQHW048XwTzfGFJNQIViKQ
	X5h9Qpaoy6boTMagw5bw/beRgjvy5wz/3lAlODZLgs54eFjDWEauNeIjbXbWuF1Z2SiZI4
	pkm/hTNkTgFvePfi/Od8p2XiR4I9OxEx3SeDfGtIHYdXWIok+jPXz4mDvzUgZy0ZFeQNGd
	H0ubf++zpiDBBY/JWUNSRDCWoykVMkr+yItIgz6EBw1BSTky+cwkIns78+lsGL0d7jCYrL
	YzkARi0cMlMNW4Y3NqDeaeNz2BU4syQuU+Kutd+i35B/23oFBU1P2E2dX5H5LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722539303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7rFecauNrUJNv4kCU5uw04s4iBRr3/U9tBY9AZZrRmk=;
	b=J47zcBmQQS+NtpGqMjcn8mdgm6Ygvp4UnCQiFKl82CHwSZforU3lhU2XABuZ8O2UnY4Ihh
	WGR7loC2EmvBbdAA==
To: Linus Torvalds <torvalds@linux-foundation.org>, David Gow
 <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar
 <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter
 Zijlstra <peterz@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/uaccess: Zero the 8-byte get_range case on failure
In-Reply-To: <CAHk-=wj40jGrTES8SL69EVdtUwauL+C_12KGMpapdkDZEgjhiw@mail.gmail.com>
References: <CAHk-=wgPD+=Wi8T0A59muq46LxquhsWQSyPV6KM5xa8V1UPK=Q@mail.gmail.com>
 <20240801063442.553090-2-davidgow@google.com>
 <CAHk-=wj40jGrTES8SL69EVdtUwauL+C_12KGMpapdkDZEgjhiw@mail.gmail.com>
Date: Thu, 01 Aug 2024 21:08:23 +0200
Message-ID: <87frro2h94.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 01 2024 at 09:24, Linus Torvalds wrote:
> On Wed, 31 Jul 2024 at 23:35, David Gow <davidgow@google.com> wrote:
> But I'm also not going to argue that this is really worth pursuing on
> 32-bit if anybody is in the least worried.
>
> It's on life support, not like it's actively maintained. Your original
> patch may not be exactly "pretty", but it clearly fixes the problem
> without playing any games.

I queue that oe up and if someone really cares, then it can be updated,
but I doubt it's worth the trouble.

Thanks,

        tglx

