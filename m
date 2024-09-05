Return-Path: <linux-kernel+bounces-317933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA31996E5B2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC26B217C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B591A4E6B;
	Thu,  5 Sep 2024 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTHOBgwv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA58F54
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725574423; cv=none; b=S+tnmlyS/4iNsxrIZcBCIT9KnGFgr7MeYUprkEa9Cj0Z8ikt+S8urt49ZYP/2fcaKiVoEqCUXLIxfu+qs2qbr+l6bBcIidlW6/3kW8zNc5NbdBX7R0X/vPlo/IQvi3drcboAF52LJBAUnj/q+nW9hbva8pulPORp7pEBHaS7s0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725574423; c=relaxed/simple;
	bh=wlGcOqVw1zlmE3nrLDDnTcljzhPleYJaO2RahZ5tAVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0MoiXHzU+LcT1v9pUFJThqqz/u8F8azm2Q/VV/CGTv6Lx+2eCRLjUYtc7a51eX1Pq6FlCAao8wzrKi4BnMXR/43WGjLzAXojgJHHFpu20/X5g/eqpbf5KO7fdv2mA9HmiJlFCzaUdjKSo+8Ki//musYebfZKazRXth24vGcbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTHOBgwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E278FC4CEC3;
	Thu,  5 Sep 2024 22:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725574422;
	bh=wlGcOqVw1zlmE3nrLDDnTcljzhPleYJaO2RahZ5tAVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTHOBgwvX/OW7+eOlFseiwvNfCCwaJqB1OrsCRO4crdB+0Ne1bqu390hqvoC7tBAa
	 Y4jcqGAzlI4DQgYH5iHLXp5q03dzn09b+CHDbQyinpyt9b5YRs4Ro9oHX5KfhUWiW2
	 kIDM0n3atyJcz6vtUNA/+Gtypw512xcna0hs2+drno6fLa0KSiw8UgSQBxRKayyHbS
	 tEqMB6cPSDwNLm8RL5G7OjZ92u8fuhqKSYDWQrCO5wF9sgnFQIvlPaSwarLH4VPmXn
	 gW8BGTxhOmvRUoJpeNV2829IxT5oIf2oCF3685OYuKzhVfQhiTs35jDCKkRVTomjoN
	 219Ie8k9PTsOA==
Date: Thu, 5 Sep 2024 15:13:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
Message-ID: <20240905221340.GA2732347@thelio-3990X>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822202805.6379-4-stuart.w.hayes@gmail.com>

Hi Stuart,

On Thu, Aug 22, 2024 at 03:28:04PM -0500, Stuart Hayes wrote:
> Add code to allow asynchronous shutdown of devices, ensuring that each
> device is shut down before its parents & suppliers.
> 
> Only devices with drivers that have async_shutdown_enable enabled will be
> shut down asynchronously.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>

I am noticing several QEMU machines hang while shutting down after this
change as commit 8064952c6504 ("driver core: shut down devices
asynchronously") in -next. An easy test case due to the size of the
configuration:

  $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- mrproper virtconfig Image.gz

  $ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/arm64-rootfs.cpio.zst | zstd -d >rootfs.cpio

  $ timeout --foreground 3m \
    qemu-system-aarch64 \
      -display none \
      -nodefaults \
      -cpu max,pauth-impdef=true \
      -machine virt,gic-version=max,virtualization=true \
      -append 'console=ttyAMA0 earlycon' \
      -kernel arch/arm64/boot/Image.gz \
      -initrd rootfs.cpio \
      -m 512m \
      -serial mon:stdio
  [    0.000000] Linux version 6.11.0-rc4-00022-g8064952c6504 (nathan@thelio-3990X) (aarch64-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT Thu Sep  5 15:02:42 MST 2024
  ...
  The system is going down NOW!
  Sent SIGTERM to all processes
  Sent SIGKILL to all processes
  Requesting system poweroff
  qemu-system-aarch64: terminating on signal 15 from pid 2753792 (timeout)

At the parent commit, there are the following two prints after
"Requesting system poweroff" then the machine properly shuts down:

  [    3.411387] kvm: exiting hardware virtualization
  [    3.411741] reboot: Power down

If there is any other information I can provide or patches that I can
test, I am more than happy to do so.

Cheers,
Nathan

