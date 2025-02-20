Return-Path: <linux-kernel+bounces-523920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889F5A3DCD5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C14987A5D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D16E1F3D59;
	Thu, 20 Feb 2025 14:30:45 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810C1A29
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061844; cv=none; b=OHbw2FGch6aSxlCOuiLdn7G4CR/uHbWlAtUSGNeE9jtm8c7ZX4w9dZ2ktAeW8ynEnNRK+CcsJJUIIYM3qg1qS4m4vVIG71rv12XgHcEU78xsFke2Qi14Cslv8NYQLOVP6kxBZswkLXHWjopcx1X/M8f+JrQUrIL2RcIkEZXgcVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061844; c=relaxed/simple;
	bh=rt/G0jQexfL+NWGB4h1jHOayHkbjaBi/Qf5DtoBSzNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPV7/wUWS1mM8jgccfD7FpLYHko+tX5z2F9avx/WS4YoOsqAwnbN+Kv1V78/0Q5C0ApNzhBGPTnjyYEx9Cu2GQbEtlA2msOvP84A3U2LqZKXM6pnXfDUlVY0hPhlKTNUOcbzI/iOxs66Hdd9wm6Lqpz5HkJPENXHNFez27fyeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id DAF6172C8F5;
	Thu, 20 Feb 2025 17:30:40 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id CD17C7CCB3A; Thu, 20 Feb 2025 16:30:40 +0200 (IST)
Date: Thu, 20 Feb 2025 16:30:40 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/31] ARM: Switch to generic entry
Message-ID: <20250220143040.GA24540@strace.io>
References: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org>
 <20250214010325.GA12626@strace.io>
 <CACRpkdZJYFUhmPg3EWJeU42fzJMzWm7Sgn3XfELB2-PSCf6Ssw@mail.gmail.com>
 <20250214110508.GA19194@strace.io>
 <CACRpkdbmOiapucnzyd9-x4WJsRBs2pRdcgZ2-AoN3bdkNJaW_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbmOiapucnzyd9-x4WJsRBs2pRdcgZ2-AoN3bdkNJaW_A@mail.gmail.com>

On Thu, Feb 20, 2025 at 03:04:22PM +0100, Linus Walleij wrote:
> On Fri, Feb 14, 2025 at 12:05 PM Dmitry V. Levin <ldv@strace.io> wrote:
> 
> > > Sure, where can I find this test suite?
> >
> > It's a part of strace, you can find it e.g. at
> > https://github.com/strace/strace
> >
> > To build and run it one can roughly do
> > ./bootstrap && ./configure && make -j`nproc` && make -j`nproc check
> 
> make check produces some test failures on v6.14-rc1 on ARM
> even before I apply the generic entry:
> 
> FAIL: filtering_syscall-syntax.test
> FAIL: qual_fault-syscall.test
> FAIL: qual_fault.test
> FAIL: strace--tips-full.test
> FAIL: strace-r.test

This is surprising, no tests are currently known to fail on arm.

> Then there is the fact that I had to add the  PTRACE_SYSEMU and
> PTRACE_SYSEMU_SINGLESTEP as stubs returning -EIO
> (modeled after UM) to use generic entry. Do you think this affects
> the results?

No, strace doesn't use PTRACE_SYSEMU* and doesn't test it either.

> Is there a way to run a single test? I tried to check the docs but
> nothing obvious to me ... I guess I'm not used to this unit-tester.

Sure, it's a regular automake-based test suite, so you can do something like
$ make -s -k check VERBOSE=1 TESTS='filtering_syscall-syntax.test qual_fault-syscall.test qual_fault.test'


-- 
ldv

