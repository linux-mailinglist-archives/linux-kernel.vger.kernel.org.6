Return-Path: <linux-kernel+bounces-376359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B609AB048
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABFF1C2099F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC6719F133;
	Tue, 22 Oct 2024 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J4W+gWEq"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE7A19F10A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605573; cv=none; b=JbrY/+4tyVqfjClZ2ORUdWfiPRCXWT92LCaN8QKFc5dw6dliSjw49C1uZqtVUuGfcqY9+8eFXZRv85zxpUJygkqOxSSfkBnOj6EIEy2Z6OiuyqatjHgsKKul4OQGph2HUP1a3n6EP33H5l0yIjuVRCf11d3wexO+WIP2ye8YuSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605573; c=relaxed/simple;
	bh=nmYzQvTLOd0AGimaPnzCNLv4y+hjTiGHY+PQ9ErcrK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPVl4Bdkc+WKZjrLUmyxmQ9qp9p0FRqEgeiMzKobYO/6bzIyalDBVfpc78wEL0mLhHc79eII53iekV8nVhZY21KhNPNwIJfsDsMSyAqGsEfxiehReb3R1Zr/obFKZM1q3zRmM/8W4WG7ZagVGAQzXo561iBcNsDTaGRtWwG9Yeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J4W+gWEq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YU7gQ+91UdId9E/ZlgbwaAF/ub8pej+7IhY0GgrdJQM=; b=J4W+gWEqhx5eKf8Eufpl99xgXO
	XSiqHWQVTa2VDcpK6F6VW6vrG0zQMUL0yNC8BVynISkfyxap2FiMRn8NJHrB0stK4Tb8HMjgGMdYb
	LK/cknjPn+jeeSkfMMYEWcSwNLQb122GBH5O52JZutib1XESXMKLfw1U1TQzlhOkRq1oPev7T5lM1
	sSGqKnnXfQWPuXd9/mfQaX8dnWtlnimqAsWAcx6gu33fizUELnDU1QhlB6tBcgbdezj9s/8/FVc8+
	3f77nSEhO5dI8acYDJGQScR4P3kkjGxtbd2kqI12IIdCU71+gNU/cKGQRnCnG0ucYhsayqhzVMKEd
	3K0rY/sg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32780)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t3FP4-0004yH-1a;
	Tue, 22 Oct 2024 14:58:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t3FOv-0002lB-38;
	Tue, 22 Oct 2024 14:58:21 +0100
Date: Tue, 22 Oct 2024 14:58:21 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, oleg@redhat.com, tglx@linutronix.de,
	peterz@infradead.org, luto@kernel.org, kees@kernel.org,
	wad@chromium.org, rostedt@goodmis.org, arnd@arndb.de,
	ardb@kernel.org, broonie@kernel.org, rick.p.edgecombe@intel.com,
	leobras@redhat.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] arm64: entry: Convert to generic entry
Message-ID: <Zxevfe-PZgB_Z8hi@shell.armlinux.org.uk>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <ZxEsZBvsirXJz2dT@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxEsZBvsirXJz2dT@J2N7QTR9R3.cambridge.arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 17, 2024 at 04:25:36PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Sat, Jun 29, 2024 at 04:55:58PM +0800, Jinjie Ruan wrote:
> > Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
> > to use the generic entry infrastructure from kernel/entry/*. The generic
> > entry makes maintainers' work easier and codes more elegant, which aslo
> > removed a lot of duplicate code.
> 
> >  arch/arm64/Kconfig                    |   1 +
> >  arch/arm64/include/asm/entry-common.h | 172 ++++++++++++
> >  arch/arm64/include/asm/ptrace.h       |   5 +
> >  arch/arm64/include/asm/stacktrace.h   |   5 +-
> >  arch/arm64/include/asm/syscall.h      |   6 +-
> >  arch/arm64/include/asm/thread_info.h  |  23 +-
> >  arch/arm64/kernel/entry-common.c      | 368 +++++---------------------
> >  arch/arm64/kernel/ptrace.c            |  90 -------
> >  arch/arm64/kernel/signal.c            |   3 +-
> >  arch/arm64/kernel/syscall.c           |  18 +-
> >  include/linux/entry-common.h          |  90 +++++++
> >  include/linux/thread_info.h           |  13 +
> >  kernel/entry/common.c                 |  37 +--
> >  13 files changed, 395 insertions(+), 436 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/entry-common.h
> 
> Looking at this I have a few concerns, which I've tried to explain
> below.

One concern I notice Mark didn't mention is (and I've made this same
point in response to LinusW's series doing similar for 32-bit ARM)
is... we need to quantify what the impact is of making these changes.

Historically, people have worked hard to make the overhead from
syscalls as low as possible - if one looks at the x86 architecture,
Linux first started off using int $0x80 to deliver syscalls to the
kernel. Later CPUs invented sysenter and syscall instructions which
I guess result in increased performance over the old int $0x80
approach.

syscall entry/exit times are one of those trivial things to measure,
most commonly done by seeing how many getpid() calls one can make
to the kernel in a defined period of time - and it's one of those
measurements people consider (rightly or wrongly) to be a measure
of the system performance.

When one considers that the majority of interactions userspace has
with the kernel involve syscalls, one can see why this is an
important path to be as performant as possible.

So, I think it's important to always quantify what the impact is of
any major change to the kernel entry/exit paths - it's all part of
properly evaluating whether the change makes sense.

If switching to generic code causes a significant degredation in
performance, then that needs to be investigated and fixed - not
waited for until someone pops up and eventually says "hey, that
change to use the generic code resulted in our systems becoming
much less performant!" six or twelve months down the road.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

