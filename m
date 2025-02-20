Return-Path: <linux-kernel+bounces-523858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B896CA3DC26
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA39C1656D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EFA1D432D;
	Thu, 20 Feb 2025 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1TcKTdZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ABC1A8F94;
	Thu, 20 Feb 2025 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060484; cv=none; b=oR2br47hbmZ5ILOayV2daGpPiiL1IQvOv1aM2KWwIfdDxgZhw4Um1E3248iTqgnNKk6Ua17sivt66kusTeBaWvfK7b5qyrAebcPOkFuM+J3QTeDGoaY6U6fnmw2n0q0YPsuqJpzcwzDP65/QfdfpodiDjTKYBR9JxGSFAjBeUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060484; c=relaxed/simple;
	bh=BUAFupbmeOg5OQr/zoe76B/ATDMFC2NaHM0MAwh8poA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBYxKKnILllAH3OGytTmy3dDLeuoq2W7AGwT1RK/cNHQBogSphxYorbUi8UlSKIK7U6qGlNdqEsKo/1HM/YbmVkCPVD0w4By9O5Fobbu4y7mzqdWOXXPw83U8z4DXvGPbXIl1nGzz5V5w7KV8A/xNAfzDD4ry3V1FFcpYKCiQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1TcKTdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F65C4CEE2;
	Thu, 20 Feb 2025 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740060483;
	bh=BUAFupbmeOg5OQr/zoe76B/ATDMFC2NaHM0MAwh8poA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1TcKTdZUzXz/x1a39o81aw14MuhGwJsF4M6GpI2JB2Sma+oDayeqIdc8JPt6g4TX
	 IJTT9xJhJi++YRfIV+qqM6v/VXvPipQXSTAP37Jjs9kMmTOdJ5nuVLonKeiGgli3KH
	 dVGbzBlgGoMJi0/Ic1gK1WlnbuM+vHjPWhlIf3rHm0rBs5gCocNPZR+EFycoQ+PFSE
	 X+4AIRclvO796gbR3MvWtACI8dbCJafMPViKtcZRaL9VmRSGYETupJ+MZp/YwEs5hq
	 kqs8y9dE8WQrXJmajXx9YkmPR6B1eFCE5nbvRJIXw2MJbP9HVDBAivtmMQV+9Du95K
	 Z4FPKEzV2b1hg==
Date: Thu, 20 Feb 2025 16:07:58 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Fiona Behrens <me@kloenk.dev>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Kees Cook <kees@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <Z7c3PguDn-sEl3gm@kernel.org>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook>
 <20250219140821.27fa1e8a@gandalf.local.home>
 <202502191117.8E1BCD4615@keescook>
 <20250219202751.GA42073@nvidia.com>
 <20250219154610.30dc6223@gandalf.local.home>
 <97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
 <89f2547edcaaba53d9965cab9133d809607330ac.camel@kernel.org>
 <87pljc6d7s.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pljc6d7s.fsf@kloenk.dev>

On Thu, Feb 20, 2025 at 12:57:11PM +0100, Fiona Behrens wrote:
> Jarkko Sakkinen <jarkko@kernel.org> writes:
> 
> > On Wed, 2025-02-19 at 12:52 -0800, Bart Van Assche wrote:
> >> On 2/19/25 12:46 PM, Steven Rostedt wrote:
> >> > I do feel that new drivers written in Rust would help with the
> >> > vulnerabilities that new drivers usually add to the kernel.
> >> 
> >> For driver developers it is easier to learn C than to learn Rust. I'm
> >> not sure that all driver developers, especially the "drive by"
> >> developers, have the skills to learn Rust.
> >
> > IMHO, Rust is not that difficult to learn but it is difficult to
> > run.
> >
> > One point of difficulty for me still is the QA part, not really the
> > code. QuickStart discusses on how to install all the shenanigans
> > with distribution package managers.
> >
> > The reality of actual kernel development is that you almost never
> > compile/run host-to-host, rendering that part of the documentation
> > in the battlefield next to useless.
> >
> > Instead it should have instructions for BuildRoot, Yocto and
> > perhaps NixOS (via podman). It should really explain this instead
> > of dnf/apt-get etc.
> 
> What do you mean with via podman for NixOS?

I sometimes use NixOS to test more complex kernel configurations. See

https://social.kernel.org/notice/ArHkwNIVWamGvUzktU

I'm planning to use this approach to check if I could use that to
build efficiently kernels with Rust.

I've not been so far successful to do it with BuildRoot, which has
zeroed out any possible contributions for rust linux. Writing code
is like 5% of kernel development. Edit-compile-run cycle is the
95%.

> I do still have on my ToDo list to build and publish a better nix
> development shell for kernel with rust enabled, and could also add a
> section on how to build a NixOS iso in the same nix code.
> But sadly time is a finite resource and so did not yet got to it.

Please do ping me if you move forward with this. IMHO, why wouldn't
you contribute that straight to the kernel documentation? Right no
there are exactly zero approaches in kernel documentation on how
test all of this.

The best known method I know is to extend this type of example I
did year ago:

#!/usr/bin/env bash

set -e

make defconfig
scripts/config --set-str CONFIG_INITRAMFS_SOURCE "initramfs.txt"
yes '' | make oldconfig

cat > initramfs.txt << EOF
dir /dev 755 0 0
nod /dev/console 644 0 0 c 5 1
nod /dev/loop0 644 0 0 b 7 0
dir /bin 755 1000 1000
slink /bin/sh busybox 777 0 0
file /bin/busybox initramfs/busybox 755 0 0
dir /proc 755 0 0
dir /sys 755 0 0
dir /mnt 755 0 0
file /init initramfs/init.sh 755 0 0
EOF

mkdir initramfs

curl -sSf https://dl-cdn.alpinelinux.org/alpine/edge/main/x86_64/busybox-static-1.36.1-r25.apk | tar zx --strip-components 1
cp busybox.static initramfs/busybox

cat > initramfs/init.sh << EOF
#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
sh
EOF

and then qemu-system-x86_64 -kernel arch/x86/boot/bzImage

It's sad really.

> 
> Fiona

BR, Jarkko

