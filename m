Return-Path: <linux-kernel+bounces-548704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064A0A54864
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AC01735AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59922080D4;
	Thu,  6 Mar 2025 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCGd7UPZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F39202F92
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258208; cv=none; b=iLZPjyq2/fLtHLURRrsITCpt3PiUpe+/Bs1jRPA9Nr5BWepbUMee6E8x/IBzPpwBKpG0LXktf90tei9d8mBGfkFZhbGCQ/3+YE7tFNH6ijYHLNogE6cdn3BvLF9zgi5Fb0uUifMwPf54r5NOyRUpRNWd4FctKv5wuhhb/NHseM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258208; c=relaxed/simple;
	bh=x8cdoj2sXfZyVOu2dEaZ2Iy4JESTAPjkP2XLqVhHdHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6wuyOUPlA7vQvQ9N5UMRkaysZfbfb+hGILFmyOu5Ux0IpAK2i77HTCrXIux3f8qwA7zjI6f7pUcmGwz8SBS6Z0NTz+iDg5xZA5ZfifU90kWFDtWyIVNwRW4c6nk8ihkbXMqVhHOw3YEtCZm6b3L1jXwKJtYFN+2WtxQrZMHyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCGd7UPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645BAC4CEE2;
	Thu,  6 Mar 2025 10:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258207;
	bh=x8cdoj2sXfZyVOu2dEaZ2Iy4JESTAPjkP2XLqVhHdHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qCGd7UPZhBFnbpW74MDbqLozBEGVSyCWFqmMDSh5gHv3W09BTeguZN+1o9+rrdiSR
	 Zh6gyAd/oHYeGlSRF0lqikMh3U6pdOYkQEBYRtAMqoH839f98aK2dLWoMe5aMfqHso
	 Z+Bvvx9wvtnp1mMkPH0Aia3rV/fBHs+/DSK4v9PI3UjgZqpeklBVdB4XJ5+qtNqGqy
	 ndeRpu6/DuQT1wi/5hyIhR9jfMJE/EHooJVKrYWiS3yfPnBKl+7e7ZhZ3KKT/ANfF8
	 MEYtWYowErygwkVVQ2YW8oimYdDDe4v/dKaw0Qeg0WxlelZ2c024GSHvBcj98yFzOr
	 FGlfviWlb28hA==
Date: Thu, 6 Mar 2025 11:50:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <Z8l922t-QoYGyuXq@gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <Z8lxmPmnJhBmPRvl@gmail.com>
 <CAFULd4btTdUrF6fTqafyViuaB+V8QD-s0pLE6XWb7BYzYAPmZA@mail.gmail.com>
 <Z8l7KeVvvHvmPmRc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8l7KeVvvHvmPmRc@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> Also, to shorten build & test times you can use the x86-64 defconfig. 
> It's a config more or less representative of what major distros 
> enable, and it's even bootable on some systems and in VMs, but it 
> builds in far less time.

And if your primary test method is KVM+Qemu, then the following build 
method will give you a representative core kernel bzImage that will 
boot most cloud VM images as-is:

  $ make -j128 ARCH=x86 defconfig kvm_guest.config bzImage

  $ ll arch/x86/boot/bzImage 
    -rw-rw-r-- 1 mingo mingo 13788160 Mar  6 11:42 arch/x86/boot/bzImage

And you can boot up a .raw distro image in an xterm:

  $ RAW=your_cloud_image.raw
  $ PARTUID=your_target_root_partition_UUID

  $ qemu-system-x86_64 \
   -enable-kvm \
   -smp cpus=4 \
   -m 2048 \
   -machine q35 \
   -cpu host \
   -global ICH9-LPC.disable_s3=1 \
   -net nic,model=virtio \
   -net user,hostfwd=tcp::8022-:22,hostfwd=tcp::8090-:80  \
   -drive "file=$RAW",if=none,format=raw,id=disk1 \
   -device virtio-blk-pci,drive=disk1,bootindex=1 \
   -serial mon:stdio \
   -nographic \
   -append "root=PARTUUID=$ID ro console=tty0 console=ttyS0,115200 earlyprintk=ttyS0,115200 consoleblank=0 ignore_loglevel" \
   -kernel arch/x86/boot/bzImage

This way you don't need any initrd build or modules nonsense - 
everything necessary is built in.

Bootable raw distro images can be found in numerous places, for example 
at:

  https://cloud.debian.org/images/cloud/bookworm-backports/

( And since I'm lazy to figure it out the 'cloud way', I usually read the 
  root UUID from the bootlog of the first unsuccessful attempt. )

Thanks,

	Ingo

