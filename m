Return-Path: <linux-kernel+bounces-529885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CBEA42C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2CB3AA3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273F126656F;
	Mon, 24 Feb 2025 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJgLE7SP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7A266196
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423532; cv=none; b=QYBjZoRGsYRgQS90vAXYRXSnL9qnHB3gTAFDLgIbz7AooZryq6nbbPaaebw0hsI83pGqgLdZ6NuHg4cNyG1/xdog+cbuXyL1Q8iHdNQczI47T7TQU7TEwlVCLj5rnWUQOEtGIDDr4tpzusuUtOnrbPKAsG2LAPpZr6IZc2qQmQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423532; c=relaxed/simple;
	bh=kco9JhOyw9aErXxaF4cc+qzMzFliIklzSq+CgtqlG38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg36v4JgBs1hTFO2lWsEAO2yhkEjA9uK+NclmyP9HEfwMrAriQup2HNlnP4GbEMrPlufbE30H9g/2k9I1XfkNkD2AkZZyYJETbBkHTuOgVYKnNsw1BdUYcBcXFmXLl5W+Lj90H58wW6yO9tXIIgmfoic32p0A2ODw0ZTgLH7s5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJgLE7SP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E16C4CED6;
	Mon, 24 Feb 2025 18:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423532;
	bh=kco9JhOyw9aErXxaF4cc+qzMzFliIklzSq+CgtqlG38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJgLE7SP9ZcFFZO1HYQkgvnTYb6XFOOUN+EV0oGkgvT5+KkDvpi9LbRNxRO4e/zM8
	 jJvx3CUuSotGQjnhRCfhUatCmmtNcsZ95T/oEMZzYftxDGuqY/LQWrn37/gpj3T5Ao
	 hynxsUWM2U3BTuXM+7mr+R8iKQ9EnfIWfhF/04243wHmcd0HZLOpIu0xKicSHWkHws
	 naaN5XZFk/gvMt008QE+rJGnLbiALwH5crdXUq6/euHIUXL1JscY01g6DY1deR7E6x
	 0RYWXs7x6PHbwbdykY64d1NoS3DwoBHAM4HGWgUdYwiACDmwJwz42FcRlq+2wo93sH
	 iD+XK5sAVnPtw==
Date: Mon, 24 Feb 2025 19:58:39 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2] x86/bootflag: Change some static functions to bool
Message-ID: <Z7zBXyywUEC2ieiR@gmail.com>
References: <20250129154920.6773-1-ubizjak@gmail.com>
 <31e1c7e4-5b24-4e56-9f17-8be9553fb6f9@kernel.org>
 <CAFULd4a4qbMiP3dYXDp0_vPapkoi-i-ApOY5pHfKG1h7=vfbbA@mail.gmail.com>
 <43c41ab4-1771-4b01-853e-08e1689df7f3@kernel.org>
 <CAFULd4bTYudfNap1trVyjqA0xv5cQQeWxSZ8numv_uHqxz1Afw@mail.gmail.com>
 <ef6e2925-f005-41e9-bc24-b9adc3922706@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6e2925-f005-41e9-bc24-b9adc3922706@kernel.org>


* Jiri Slaby <jirislaby@kernel.org> wrote:

> On 24. 02. 25, 8:39, Uros Bizjak wrote:
> > The internal compiler representation of the following testcase:
> > 
> > _Bool foo (int x) { return x; }
> > 
> > is:
> > 
> > --cut here--
> > _Bool foo (int x)
> > {
> >   _Bool _2;
> > 
> >   <bb 2> [local count: 1073741824]:
> >   _2 = x_1(D) != 0;
> >   return _2;
> 
> Yes, exactly as dictated by the C99 standard.
> 
> > }
> > --cut here--
> > 
> > For me, !!x in the source means that the change of types was
> > intentional. Surely, the compiler can do it by itself, so at the end
> > of the day, it is just a matter of personal taste.
> 
> I've just learnt, that we even have that in CodingStyle:
> ===
> > 17) Using bool
> > --------------
> > 
> > The Linux kernel bool type is an alias for the C99 _Bool type. bool values can
> > only evaluate to 0 or 1, and implicit or explicit conversion to bool
> > automatically converts the value to true or false. When using bool types the
> > !! construction is not needed, which eliminates a class of bugs.
> ===

This rule doesn't apply here, because the !! operation isn't done on 
bool types: 'x' in the parity() function is an 'int'...

So this CodingStyle entry is a red herring, and the !! is absolutely 
used in the kernel as an explicit marker of intentional type conversion 
to bool.

Thanks,

	Ingo

