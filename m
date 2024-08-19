Return-Path: <linux-kernel+bounces-291394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BA8956182
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377F11F22147
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464D31386D2;
	Mon, 19 Aug 2024 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="aaqTjqnb"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB7A1804E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039472; cv=none; b=TUpFwqt2n7xwPoy5S+MdlwVCRu9McmE6/MUeH3OcW+BrelvwNrJHJk8fAY3dSHjXASUJVskrgvZmoFuZXyHwGNIQ7xOBTtPVzwMLpzltvrwsCFF4cup4ST1eUMh4SZqQ0Dm49eIPWy5e69e2l9l4GFIqHtaTFcOdmlprUEcYy88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039472; c=relaxed/simple;
	bh=X0HycfS+lzyAcjnHFZk/j+9u4+N4iqH0pb3amLt9Hhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N34e+AEa2v/yWtg7MtoSwjWgK4ANCYKUUyt59SF0QzMIEyhcaM5PaC2SrxaMGUKgP9XJRr/1KQhzJRKx8/ERN/oOIkKejaNJHWw6koSImQdWYrWJUvRt733/zVooZpiA6QIFG8+lHCjBQMxse/yMNSbSlW5pYoYAe4sSrokEhvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=aaqTjqnb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-67.bstnma.fios.verizon.net [173.48.112.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47J3oocN016579
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Aug 2024 23:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724039451; bh=yxUsUeRKeaxkZ867ki5/WdtgLVGmQ4pLzvoRd1yllIs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=aaqTjqnbXsps1zFTU0BfzESdXtMiNmti8M8B7g6Xvf6eajQHPF3bV6t6cTvrHAI3U
	 YCazCSoebHryZCsBx3gXP59DtWixbhiFxJzXU+jZP9p9mNKe2vUVcjU0CaH/rFq3c6
	 fJZ/OIhINo2AvWRI0xZ468RptIrLyxcwy/x+sXcm6sH9Gab9pml5/4L/zO9VtBlOTE
	 CnDSvufLnxp1ksPB1u0aZuJDgi8kPJnnjh5KnWkjd0BSoVNJ1WMNhdJrjLR5Jyr9AD
	 c23deBUAQnCBK4io7cuk4flifQMLemB1zmdPV3S0GNiu3gGwmyVUyxIY+apcZfVGXz
	 zVQKv90Fur0MA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id F0BDB15C6438; Sun, 18 Aug 2024 23:50:49 -0400 (EDT)
Date: Sun, 18 Aug 2024 23:50:49 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: jwbda <jwbda@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How to quick test/debug in linux kernel?
Message-ID: <20240819035049.GA9627@mit.edu>
References: <MvEVlTCbeP8Fr6I7mi3pGDQuv7_Yc7CB2OITb8_7IOgJvxmHxXKeIv8XTzTBfazMnyWs6SlMqcM4hAd_TKiRKL9TXppOEFEzbtrZ93Y9Jqc=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MvEVlTCbeP8Fr6I7mi3pGDQuv7_Yc7CB2OITb8_7IOgJvxmHxXKeIv8XTzTBfazMnyWs6SlMqcM4hAd_TKiRKL9TXppOEFEzbtrZ93Y9Jqc=@proton.me>

On Fri, Aug 16, 2024 at 11:05:31AM +0000, jwbda wrote:
> 
> Hi guys, would you mind help me with this:
> How to quick test/debug in linux kernel?
> 
> Here is my method: 
> Make some changes to the source code, add this line of code `printk(KERN_INFO ">>> run in kernel!\n");`
> 
> Then compile and run
> 
> ```sh
> make -j12
> sudo qemu-system-x86_64 -hda ./mybuild/mylinux.img -m 4096 --enable-kvm -kernel ./linux/arch/x86_64/boot/bzImage -append "root=/dev/sda rw console=ttyS0" -nographic
> ```
> Then check the results in the console. But I think this method is still a bit cumbersome. May I ask how do you quickly test/debug in linux kernel?

Since I'm file system developer, I have my own test appliance which is
optimized for running test kernels via KVM and on GCE.  For more
information, see:

    https://thunk.org/gce-xfstests
    https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
    https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md

The quick version: after installing xfstest-bld, I just run these commands:

   # This will install kernel config that is suitable for use with
   # kvm-xfstests or gce-xfstests
   install-kconfig
   # This is a convenience script that will build the kernel, with
   # some options if you are using a separate build directores, which
   # is handy if you are building for multiple CPU architectures, i.e.,
   #x86_64, i386, and/or arm64
   kbuild
   # This will launch a VM using qemu/kvm using the just-built kernel.
   kvm-xfstest shell

(Note: "kvm-xfstests shell" is morally equivalent to your
qemu-system-x86_64 command.  For example, if you run "kvm-fstests
shell --noaction" you'll see that it runs a *very* long command that
begins "ionice -n 5 qemu-system-x86_64 -boot order=c -net none ...")

If you are testing a file system change, you can kick off a file
system smoke test via:

   kvm-xfstests smoke

And if you have gce-xfstests set up, I will run multiple VM's for
different file sytem configurations using a command such as:

   gce-xfstest ltm -c ext4/all -g auto

The above command will create 12 Cloud VM's using Google Compute
Engine, run them in parallel, and then coalesce the result into a
single test report, and e-mail it to me.  It takes a little over two
hours of wall clock time, but it runs about 24 hours worth of tests.
So while I *could* run:

   kvm-xfstests -c ext4/all -g auto

... I'm too impatient, and using Google Cloud costs about two
dollars (USD), and saves me more than 10x the test time.

The whole system system is set up for development velocity; in
general, you only need to run install-kconfig once, unless you are
moving to a new kernel version, or you want to use different build
options ---- such as "install-kconfig --lockdep", or "install-kconfig
--kasan", etc.  And as I mentioned you can build for different
architectures if you have cross-build compilers installed, via
commands such as "install-kconfig --arch arm66" and "install-kconfig
--arch arm64".  Both kvm-xfstests and gce-xfstests support using
alternate architectures; using kvm-xfstest it will use qemu to run
with CPU emulation, and with gce-xfstests, Google Cloud supports arm64
VM's, so you can build an arm64 binary, and then gce-xfstests will
launch an arm VM and boot the kernel in that VM.

In general, my development workflow is:

1)  Hack the kernel, or apply patches sent by ext4 developers for review
2)  Run kbuild
3)  Run "kvm-xfstests shell" or "kvm-xfstests smoke"

And after applying a number of patches, I'll kick off a full
regression test build via "gce-xfstests ltm -c ext4/all -g auto" and
then come back after lunch or dinner and check for any new test
failures.

Cheers,

					- Ted


