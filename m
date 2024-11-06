Return-Path: <linux-kernel+bounces-398905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E6F9BF7CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79F71C2145F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611A120BB3C;
	Wed,  6 Nov 2024 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6dMi0ve"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D420BB2F;
	Wed,  6 Nov 2024 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730923658; cv=none; b=sLJqFpHL/F7JlCt51+S9MSubFQ/g+EJc3oCluRs1Yp2R9Ocw0dfo4sO5b9Ff3M4YcfaUDXEEMuzD34mel27DCmmKbzFyOg2C2OksgSRVmdnEHVDnqet1uUAbxNbpTvNL7wnL0SQ+Gr61IvItnaiVfVvcSpfZByl1ukhFNmQHxcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730923658; c=relaxed/simple;
	bh=YXWh5dB8xfshWs8f7ssynY60GzKOcsVTu7zsSubcvAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2nJqsx4Y7II2Rj6hfX8o1hVh3Q2Z/M4CacZ8KzeicZ4kgB+OUj/IvNpB5IaBgWnNsnRPOlzMu3Yzp2yceCghTvUCNh8uSAeTmVGTn5NHHVDes+9oS1Z42njz2AY198aqkrKOzgsbxM7SUoqIRnzxfP4Dfh1Uhl4VLQhvW1SCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6dMi0ve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210C5C4CECD;
	Wed,  6 Nov 2024 20:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730923658;
	bh=YXWh5dB8xfshWs8f7ssynY60GzKOcsVTu7zsSubcvAU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=A6dMi0veQ2vjiAC0m1McxZuRzyHi6T7tXofLPzEPmExU3w/UcYQWNVYbaXRiCpU+F
	 4+qXFpCN+KddDCtY3JfhNS3Gku3eINXdjq/KrWbF6RxkrMsc3JWbB/xXlhfzx41CfY
	 c4DmJ7koYR9rEH1Ls0QHYB3THM3RVqGS4I5lIkhS6NMOifnm64r62d6DBVmw0JxbNO
	 O4P1DFLI868IJtskzQqkRCjG1X2wEIQA5lvmyRm/fzBQfPLm17GWtE1o2xZW3fOGbL
	 LsEX/7HdbSsrCfhvFbRLFkLltzlRGHTn/mxWeJ9UosNo6ndSs1oSfu2V+LmOujwxNH
	 qHFEDk3mLctHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A6DDDCE09DB; Wed,  6 Nov 2024 12:07:37 -0800 (PST)
Date: Wed, 6 Nov 2024 12:07:37 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.11.01a] [rcutorture] 622baf5d79:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <1092459d-48e2-4839-a84d-c38d96fa2a36@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202411051012.f9224879-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202411051012.f9224879-lkp@intel.com>

On Tue, Nov 05, 2024 at 01:00:53PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]" on:
> 
> commit: 622baf5d79169496973d50fc43636469e6af02b7 ("rcutorture: Make rcutorture_one_extend() check reader state")
> https://github.com/paulmckrcu/linux dev.2024.11.01a

This is an old commit that failed to handle any torture_type other than
"rcu", including the "srcu" that you tested with.  It has since been
replaced by a series of newer commits fixing this and other bugs, with
the current version here:

c815d319a933 ("rcutorture: Make rcutorture_one_extend() check reader state")

Does this one work for you?

Either way, thank you for your testing efforts!

							Thanx, Paul

> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: default
> 	torture_type: srcu
> 
> 
> 
> config: i386-randconfig-061-20241103
> compiler: gcc-12
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202411051012.f9224879-lkp@intel.com
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241105/202411051012.f9224879-lkp@intel.com
> 
> 
> 
> [   94.499370][  T628] ------------[ cut here ]------------
> [   94.504179][  T628] rcutorture_one_extend_check before change: Current 0x20  To add 0x20  To remove 0x0
> [   94.505405][  T628] WARNING: CPU: 0 PID: 628 at kernel/rcu/rcutorture.c:1876 rcutorture_one_extend_check+0x1ff/0x2ba [rcutorture]
> [   94.507176][  T628] Modules linked in: rcutorture(+) torture ata_generic ata_piix mousedev sg intel_agp libata serio_raw intel_gtt agpgart i2c_piix4 rtc_cmos fuse autofs4
> [   94.508995][  T628] CPU: 0 UID: 0 PID: 628 Comm: rcu_torture_rea Not tainted 6.12.0-rc2-00086-g622baf5d7916 #1
> [   94.510118][  T628] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   94.521987][  T628] EIP: rcutorture_one_extend_check+0x1ff/0x2ba [rcutorture]
> [   94.522990][  T628] Code: 00 00 00 80 3d 9c 84 2c f0 00 75 bd c6 05 9c 84 2c f0 01 57 56 53 68 9b 00 2d f0 68 40 1e 2d f0 68 a9 00 2d f0 e8 82 22 db d0 <0f> 0b 83 c4 18 eb 98 31 c0 89 45 f0 80 3d 9b 84 2c f0 00 75 23 c6
> [   94.525121][  T628] EAX: 00000053 EBX: 00000020 ECX: 00000002 EDX: 00000002
> [   94.525898][  T628] ESI: 00000020 EDI: 00000000 EBP: c77c3dc0 ESP: c77c3d8c
> [   94.526758][  T628] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
> [   94.527733][  T628] CR0: 80050033 CR2: b7248000 CR3: 07bc8000 CR4: 000406d0
> [   94.528515][  T628] Call Trace:
> [   94.528885][  T628]  ? show_regs+0x61/0x67
> [   94.529424][  T628]  ? rcutorture_one_extend_check+0x1ff/0x2ba [rcutorture]
> [   94.530342][  T628]  ? __warn+0x9e/0x151
> [   94.530852][  T628]  ? report_bug+0x120/0x19d
> [   94.531398][  T628]  ? rcutorture_one_extend_check+0x1ff/0x2ba [rcutorture]
> [   94.536465][  T628]  ? exc_overflow+0x37/0x37
> [   94.537098][  T628]  ? handle_bug+0x3d/0x58
> [   94.537683][  T628]  ? exc_invalid_op+0x24/0x60
> [   94.538224][  T628]  ? handle_exception+0x133/0x133
> [   94.538880][  T628]  ? exc_overflow+0x37/0x37
> [   94.539408][  T628]  ? rcutorture_one_extend_check+0x1ff/0x2ba [rcutorture]
> [   94.540399][  T628]  ? exc_overflow+0x37/0x37
> [   94.540940][  T628]  ? rcutorture_one_extend_check+0x1ff/0x2ba [rcutorture]
> [   94.541903][  T628]  rcutorture_one_extend+0x39e/0x3a7 [rcutorture]
> [   94.542657][  T628]  rcu_torture_one_read+0x7e/0x4d3 [rcutorture]
> [   94.543218][  T614] srcu-torture: Creating torture_shuffle task
> [   94.543494][  T628]  ? __lock_acquire+0x684/0x72e
> [   94.544510][  T630] srcu-torture: rcu_torture_stats task started
> [   94.545082][  T628]  rcu_torture_reader+0xb7/0x16a [rcutorture]
> [   94.559381][  T614] srcu-torture: Creating torture_stutter task
> [   94.559414][  T640] srcu-torture: torture_shuffle task started
> [   94.567377][  T614] srcu-torture: Creating rcu_torture_fwd_prog task
> [   94.567413][  T641] srcu-torture: torture_stutter task started
> [   94.567748][  T614] srcu-torture: Creating rcu_torture_read_exit task
> [   94.567772][  T646] srcu-torture: rcu_torture_fwd_progress task started
> [   94.568324][  T647] srcu-torture: rcu_torture_read_exit: Start of test
> [   94.568329][  T647] srcu-torture: rcu_torture_read_exit: Start of episode
> [   94.587605][  T628]  ? rcu_torture_one_read+0x4d3/0x4d3 [rcutorture]
> [   94.588336][  T628]  kthread+0xe9/0xee
> [   94.588796][  T628]  ? rcu_torture_cleanup+0x750/0x750 [rcutorture]
> [   94.589492][  T628]  ? list_del_init+0x21/0x21
> [   94.590015][  T628]  ret_from_fork+0x19/0x2c
> [   94.590524][  T628]  ? list_del_init+0x21/0x21
> [   94.591142][  T628]  ret_from_fork_asm+0x12/0x18
> [   94.598922][  T221] 2024-11-04 17:44:01 sleep 300
> [   94.598941][  T221] 
> [   94.601820][  T628]  entry_INT80_32+0x125/0x125
> [   94.602363][  T628] irq event stamp: 621
> [   94.602906][  T628] hardirqs last  enabled at (639): [<c10c43dc>] __up_console_sem+0x59/0x69
> [   94.603896][  T628] hardirqs last disabled at (646): [<c10c43c3>] __up_console_sem+0x40/0x69
> [   94.604836][  T628] softirqs last  enabled at (636): [<c1067d80>] handle_softirqs+0x2fb/0x326
> [   94.605797][  T628] softirqs last disabled at (629): [<c1b1071a>] __do_softirq+0xa/0xc
> [   94.613261][  T628] ---[ end trace 0000000000000000 ]---
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

