Return-Path: <linux-kernel+bounces-282019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC0094DE83
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 22:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906BCB21D69
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 20:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3CE13D512;
	Sat, 10 Aug 2024 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="hd2xZ0h0"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE6A40870
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.211.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320641; cv=none; b=OKK24sudkKgD683w9hGSuZWC1JtEbqKuxq1UldQPhVGgeKobwGjvNYKxz0lh8LbZpdPRVVqjtd0qE50yepoJXKLKvARxLuXAOxtORNJ1PcGh8WtMVShPFo/mktbyyMvBQj9IXPCRUQCh06qT7OfPKFryrP1Jd4cXn0ux3k9prHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320641; c=relaxed/simple;
	bh=5qU6w71yG9BtLJuBIekCb9HqyN3NGuyPBShuH4t4e9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a21qtLlFxODUCY3txPDisVGtB39Isa8Mrz95WA9nuCkL1dyg6jLIrDAhFQnK2RBqN6g14iRZpVEmtDBvPVAiXaz1toB857dUVorF28BfW7i2+yVY+CiPmBC5M0v1bLy+DpGImcK9FuAR2yUx+XBLG/KqXfNNjAWCTnO3aGRBmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=hd2xZ0h0; arc=none smtp.client-ip=51.81.211.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1723320639;
	bh=5qU6w71yG9BtLJuBIekCb9HqyN3NGuyPBShuH4t4e9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hd2xZ0h0xo39vwAFRMmraXpZynki6EsVC5PuG3ElO/42BGR28R1LHJ3fogFe722Ta
	 GVmSQKnXJQIKZIt76hJIZduxEkmu9HuTNUhhCXYUsn+8WGGbf+REmyTQ3vKekFWdSx
	 +rCcVyuUyUn4T2gu2KcBGrmSQJ+iIXVYX+oYidMwrNhHRJA++ZHtPXqENNv0mUvg2r
	 0PhOP4Ka3usTUJGrhCs6deUoOR4RZeQDDFYw1EgjQaGcsk48Wyh9X8S24gPRTrgaC5
	 gluKtB7+JPqVdsnaV85XBbE9WUOFR7bfr8qJ5u1qcHzyaSr3D4hcZAgko4YiuXDLPU
	 iXt13+8/0UDMQ==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.223])
	by gnuweeb.org (Postfix) with ESMTPSA id 0D79824D05A;
	Sun, 11 Aug 2024 03:10:37 +0700 (WIB)
Date: Sun, 11 Aug 2024 03:10:34 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: x86_64: wrap asm functions in functions
Message-ID: <ZrfJOr6Dmn0j00Yh@biznet-home.integral.gnuweeb.org>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
 <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
 <ZrdZKcQ1SClUHWa1@biznet-home.integral.gnuweeb.org>
 <121f58b7-b781-44cf-a18f-6f8893c82187@t-8ch.de>
 <20240810143556.GA9168@1wt.eu>
 <384a1d29-13ca-4e4b-b4b7-2a99e3fdb01b@t-8ch.de>
 <Zre8cPOKetof24nJ@biznet-home.integral.gnuweeb.org>
 <20240810194545.GA5065@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810194545.GA5065@1wt.eu>
X-Bpl: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Sat, Aug 10, 2024 at 09:45:45PM +0200, Willy Tarreau wrote:
> The constraints are trivial, the problem is that they're not supposed to
> be used in a naked function. I tried, as you can guess. gcc accepted
> them without complaining but clang not at all. However what's interesting
> is that the compiler being aware of our unability to inform it about the
> clobber list, it did consider everything clobbered and saved the registers
> in the caller in this case. That does make sense, otherwise it would be
> impossible to use asm in naked functions. However we need to restrict
> this use case to true naked functions, not the ones we were doing ourselves
> before the existence of the naked attribute.

Ah, I get it now. Apparently, my ignorance of naked functions led to,
well, not knowing about naked functions. I didn't know about the naked
attribute.

Yeah, clang indeed throws errors while GCC does not:

```
  <source>:24:10: error: parameter references not allowed in naked functions
     24 |                 : "+D"(dst), "+S"(src), "+c"(len), "=a"(rax)
        |                        ^
  <source>:4:16: note: attribute is here
      4 | __attribute__((naked))
        |                ^
  <source>:7:2: error: non-ASM statement in naked function is not supported
      7 |         void *rax;
        |         ^
  <source>:4:16: note: attribute is here
      4 | __attribute__((naked))
        |                ^
  2 errors generated.
  Compiler returned: 1
```

For now, I'll wait for your discussion with Thomas to resolve this
issue. And yes, I agree that we should find a solution that doesn't
require maintaining two different versions.

-- 
Ammar Faizi


