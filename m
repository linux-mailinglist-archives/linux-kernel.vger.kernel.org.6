Return-Path: <linux-kernel+bounces-320991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF1E971315
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6159EB222A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A009176AAE;
	Mon,  9 Sep 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oTeKh8kc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FC414A0A4;
	Mon,  9 Sep 2024 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873339; cv=none; b=q2xa8KxHNxS75pDwf7n2S+AIhJQrrql/j4jZJpMPhs3CB+v0rZQxXKHJC8FhKfzmb5hTDDMUjhTFISr5qUkmEVSy/cANJugmgoLe0jsFAEjGOhjOY+PO5QB7zNMETJ8mDYTDrdns+xP/qhMGtlgQBf1WAkZlor4gQg3AWTsxWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873339; c=relaxed/simple;
	bh=CuqIpLmSbFqT0pouoRYK2jeju1VMvaz0q35DVYXqkpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2MtInFr06fXMBtYRNLaIc9KeXHulMtv8eOZzmKxNdnb3GLceRj5MpFVdjiyIT2okYl5fLKHGOaspRj9r6DbI1jMGeMmwiTQbjHgGXNc+td+7AjDXeNhqEi/RfJtOwQW6EtXHuGqYlWYqEGDfuNuPhgM9Kyywi498ecJ4tRXrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oTeKh8kc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PBskL+cMDAuRhOP1x2HkiAaBeJUGPRX9h9rFdehDhyc=; b=oTeKh8kck9PL6EMyHIkHq+X3gf
	Q8fdVYKEx6wGPsVk6c0k71eZeDRGOwgjlnr5Jm3ge6K2MEmJ+QtxIDSYv0ENQJ8mUOJAqWa+kCsPf
	x1DjRzo9eVb19+8Xkh9FIBiRHe+nlRDpN6ZiZ7+w/uJvbFNO+DtjGOLarGi4PmKvHRAnr53jiaFwi
	LBKVKSimrUJezP+1fLAkbFXqSYaTD35wM8EZOOGPozyNK394N/LqKa7JGfS2jbl6WpSH4UdGPoKEI
	Xio2R8hXbKFSZihU051KbRYnpy0u4gcmILZ2aasEatRazYca2BZ8YjOknABA+UpMPQMW5NIlwejgI
	WDy+alQA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1snaUe-00000000Mtl-0i7i;
	Mon, 09 Sep 2024 09:15:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 62DBB30047C; Mon,  9 Sep 2024 11:15:31 +0200 (CEST)
Date: Mon, 9 Sep 2024 11:15:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip:locking/urgent] [jump_label]  de752774f3:
 kernel_BUG_at_arch/x86/kernel/jump_label.c
Message-ID: <20240909091531.GA4723@noisy.programming.kicks-ass.net>
References: <202409082005.393050e2-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409082005.393050e2-oliver.sang@intel.com>

On Sun, Sep 08, 2024 at 09:06:55PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel_BUG_at_arch/x86/kernel/jump_label.c" on:
> 
> commit: de752774f38bb766941ed1bf910ba5a9f6cc6bf7 ("jump_label: Fix static_key_slow_dec() yet again")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/urgent
> 
> in testcase: boot
> 
> compiler: clang-18
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 

> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240908/202409082005.393050e2-oliver.sang@intel.com

So the whole thing actually boots and works on my real machine, so I had
to resort to using this qemu nonsense, as such I did as instructed in
the reproduce file.

I build the thing using clang-17 (for some reason debian is shitting
itself trying to install clang-18 on this machine and I don't want to
spend the day fighting that).

Except, once I do:

  bin/lkp qemu -k /usr/src/linux-2.6/tmp-build/arch/x86/boot/bzImage -m /usr/src/linux-2.6/tmp-build/mod/modules.cgz job-script

The whole thing grinds to a halt like so:

[    4.671842][    T1] /dev/root: Can't open blockdev
[    4.673451][    T1] VFS: Cannot open root device "/dev/ram0" or unknown-block(0,0): error -6
[    4.676062][    T1] Please append a correct "root=" boot option; here are the available partitions:
[    4.678814][    T1] List of all bdev filesystems:
[    4.680333][    T1]  ext3
[    4.680337][    T1]  ext4
[    4.681328][    T1]
[    4.683185][    T1] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[    4.685856][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc3-00004-gde752774f38b #17
[    4.688668][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    4.691573][    T1] Call Trace:
[    4.692614][    T1]  <TASK>
[    4.693562][    T1]  dump_stack_lvl+0x3b/0xb0
[    4.694800][    T1]  panic+0x108/0x2e0
[    4.695890][    T1]  mount_root_generic+0x27f/0x300
[    4.697283][    T1]  prepare_namespace+0x72/0xa0
[    4.698547][    T1]  kernel_init_freeable+0x14d/0x190
[    4.699828][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.701036][    T1]  kernel_init+0x16/0x1a0
[    4.702122][    T1]  ret_from_fork+0x36/0x40
[    4.703275][    T1]  ? __pfx_kernel_init+0x10/0x10
[    4.704424][    T1]  ret_from_fork_asm+0x1a/0x30
[    4.705546][    T1]  </TASK>
[    4.706476][    T1] Kernel Offset: 0x11600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

So clearly the day is off to a good start... :/

