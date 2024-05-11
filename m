Return-Path: <linux-kernel+bounces-176322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F196A8C2DF9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A19DB230EE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690D1611E;
	Sat, 11 May 2024 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs7Lr8gn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB323AD
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388121; cv=none; b=MIGP5Ot5MalcKuSFK5tzMG+AcGDFfZUoF+cvCeKxzAOz3oARmHBAsiup60AFC90JAaPWWKK547KOFx9aEwQfs+pUC20JcZAsYutQhvTZnM0JfuC5F6JxhPmxSMu37dQmzv71fUFVb1TzGbwTLhb4D2zvQBWBDB/5TfFdG6eyN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388121; c=relaxed/simple;
	bh=JfkJCrRzMsVaxBdKSOt5V9y/UW7YoWut4OsHo5rBQiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhW4W8Vkc3FpRR1wB2bTHvCe9o4ooebTj1ZiqRw6sUcAx910vAi4VSBoLQke+ZipWtm8tUAbO5ZMH28aILk1IH9dSAK/RaejAr8uQbtFNy80fhxydnU4NEWVO0B/eq9T4k+35yUt5bW0Pvp+hhMVqNWBI5DWXEuxMalwc1rCes0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs7Lr8gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C593BC113CC;
	Sat, 11 May 2024 00:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388121;
	bh=JfkJCrRzMsVaxBdKSOt5V9y/UW7YoWut4OsHo5rBQiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gs7Lr8gnacl8F67NIAa4R+Nv76M4FVuVz/g1Ftt06AzMiYx7Q5K4ixLDuEstx3ghp
	 OgN6ySSTVegeCLCXIeoiP5Jc+rpnnFP34iPanQ/NTUe8OyP2vxSTyxe0UHUhLruQ49
	 zpTEDWbUY3AdSctYwTtv4bGkojgN3M2cb8uPDhlCNi2mWJtWoeJw7NRMaJhniSI42H
	 tk+JXR5vChAlDJbygj3fL0J9VGPAM3gQ87y81Zp0XVfivTHldB6Zue+B/gIqjOJLEn
	 MwXptyp6W83ne0DQa5Lia0e/4atrzo9srWZ6oHjr9wTDT1slRmtox9L1CvcathZYNc
	 uEdFqpe5+AJEA==
Date: Fri, 10 May 2024 18:41:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <Zj6-1sXvUNZWO1pB@kbusch-mbp.dhcp.thefacebook.com>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com>
 <20240510151047.GA10486@lst.de>
 <Zj5JMqWRY187PqnD@kbusch-mbp.dhcp.thefacebook.com>
 <Zj6yvTxIpUnOXl7R@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj6yvTxIpUnOXl7R@fedora>

On Sat, May 11, 2024 at 07:50:21AM +0800, Ming Lei wrote:
> On Fri, May 10, 2024 at 10:20:02AM -0600, Keith Busch wrote:
> > On Fri, May 10, 2024 at 05:10:47PM +0200, Christoph Hellwig wrote:
> > > On Fri, May 10, 2024 at 07:14:59AM -0700, Keith Busch wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > Some people _really_ want to control their interrupt affinity.
> > > 
> > > So let them argue why.  I'd rather have a really, really, really
> > > good argument for this crap, and I'd like to hear it from the horses
> > > mouth.
> > 
> > It's just prioritizing predictable user task scheduling for a subset of
> > CPUs instead of having consistently better storage performance.
> > 
> > We already have "isolcpus=managed_irq," parameter to prevent managed
> > interrupts from running on a subset of CPUs, so the use case is already
> > kind of supported. The problem with that parameter is it is a no-op if
> > the starting affinity spread contains only isolated CPUs.
> 
> Can you explain a bit why it is a no-op? If only isolated CPUs are
> spread on one queue, there will be no IO originated from these isolated
> CPUs, that is exactly what the isolation needs.

The "isolcpus=managed_irq," option doesn't limit the dispatching CPUs.
It only limits where the managed irq will assign the effective_cpus as a
best effort.

Example, I boot with a system with 4 threads, one nvme device, and
kernel parameter:

  isolcpus=managed_irq,2-3

Run this:

  for i in $(seq 0 3); do taskset -c $i dd if=/dev/nvme0n1 of=/dev/null bs=4k count=1000 iflag=direct; done

Check /proc/interrupts | grep nvme0:

           CPU0       CPU1       CPU2       CPU3
..
 26:       1000          0          0          0  PCI-MSIX-0000:00:05.0   1-edge      nvme0q1
 27:          0       1004          0          0  PCI-MSIX-0000:00:05.0   2-edge      nvme0q2
 28:          0          0       1000          0  PCI-MSIX-0000:00:05.0   3-edge      nvme0q3
 29:          0          0          0       1043  PCI-MSIX-0000:00:05.0   4-edge      nvme0q4

The isolcpus did nothing becuase the each vector's mask had just one
cpu; there was no where else that the managed irq could send it. The
documentation seems to indicate that was by design as a "best effort".

