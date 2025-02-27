Return-Path: <linux-kernel+bounces-537228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BE4A4895A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2758E18882BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CDB26FA41;
	Thu, 27 Feb 2025 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1WXaz0H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57BC226183
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686554; cv=none; b=OAIdP/i43H726eLzaH78YOSRpk53F2uthfuW1hDvsT4IXg2bHtgPwb94KDq1tPGnRlTiIOWnYNqspIfNogI4XGH21WcvMWh1MNqv22rPYtm3siBLCHQc00aKzG4wQStZiM5PezkGvvwJ0Siqx795yg9bYIK2k/F+POJ8Miyx+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686554; c=relaxed/simple;
	bh=64nF5jxVqiHGGFLYJ8cxRJSLB7wfHZjZLsoUKLq9F6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfEZxfbfLN9+zoxssNXKnPlvtUFw31bfNFQx+PnlONnv0GBbe+IFPV9EwLqZHpf/vzeukjdAiOpnlK+5OjfI7ZnfsqNZ42o9wCUx05ne39GXGP6OWtL4n1I4efr7cwACCQmFGgmZGcIoPr7A5fd9cH+WpnI5vNvEzvqXJvSuNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1WXaz0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A612C4CEDD;
	Thu, 27 Feb 2025 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686554;
	bh=64nF5jxVqiHGGFLYJ8cxRJSLB7wfHZjZLsoUKLq9F6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1WXaz0HpQOqAVQjoW6dDc/ggYS7jdsiOR+p7HEOYaacGQSmrJpoPLxvYM+QSELK4
	 QpUwLvLb7xl9QKlGzB9UTF7lb8TZUGCPlTAADG59tU9UlRE2UlR4AD+HE2L+FLbW8W
	 m1W2LiXZwTYyR9b5Ykxsoqv3oeOYDmEWcgAcgMXio1mCxfjraZkKOFmtV+WorfB1nV
	 Kr9VFSZ8mFKjcJnWQlej8H6WBoxO+xPG4VrzVQmxWOhJRhqFuRJMvw1a6tSkSfrCJV
	 gYl0zqJhMdw+AD5nVEvb//wzjL80OD3DuLufSYKgJKzzJQ9Q5s6wHPteu5HJtvspRx
	 eYqdfViqcbJ9Q==
Date: Thu, 27 Feb 2025 21:02:24 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order
 table and accessor macro
Message-ID: <Z8DE0K2EEDe1dQdh@gmail.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-3-chang.seok.bae@intel.com>
 <Z8C3ZcMgHuBtIjFR@gmail.com>
 <674db309-e206-4bb4-bf99-b3c39bff7973@intel.com>
 <Z8C-xa7WB1kWoxqx@gmail.com>
 <af4ec757-22fd-4438-91fc-d8778998bf07@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af4ec757-22fd-4438-91fc-d8778998bf07@intel.com>


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 2/27/25 11:36, Ingo Molnar wrote:
> > 
> >> There were basically three choices:
> >>
> >>  1. Reuse XFEATURES 3/4 (MPX)
> >>  2. Create a new out-of-order XFEATURE 19 that reuses MPX space
> >>  3. Create a n in-order XFEATURE 19 that needs XFD and an opt-in
> >>
> >> #1 risks breaking old MPX code in weird ways.
> > This is a false trichotomy. 😉
> > 
> > There's a 4th option:
> > 
> >    4. Reuse XFEATURES 3/4 (MPX) only on APX-aware kernels, keep it 
> >       disabled for old kernels.
> > 
> > Problem solved.
> 
> The worry boils down to code in the kernel or userspace doing this:
> 
> 	if (XGETBV(0) & 0x11)
> 		do_mpx_gunk();

New, APX-aware kernels wouldn't be doing this, why would they?

> So, sure, we could try to make sure that new kernels don't have any 
> do_mpx_gunk() in them, but that doesn't help old kernels or other 
> OSes/VMMs.

Old kernels would *never* see this bit enabled if it's disabled by 
default on bootup ...

VMMs would boot with it default-disabled as well, they can enable it 
themselves.

Thanks,

	Ingo

