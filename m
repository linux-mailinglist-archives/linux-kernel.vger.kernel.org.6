Return-Path: <linux-kernel+bounces-370976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595969A3489
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FD6285C75
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A91817B50A;
	Fri, 18 Oct 2024 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y4jlaY+q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0FF17279E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230595; cv=none; b=hfmMqkxe8gqPz+C+kM5CW/pXO6BX/2m7hH8Njj/yE+snp1Q03ovZ0XHR5vtcdKFEkTpb9PRkGHXJ2pHKi+cAjYbmPtU827uFqQDq6AFUiproMGUM27hh/1Y8/7lhghLD3ZoMXpf6dR2poSqs653+Ft9Giht3Nf3qbxN3VGZDdUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230595; c=relaxed/simple;
	bh=hKS4vmBWWMoYIGu21fHqLzEas0MmTWeORGm1/vmtlOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU6N8+g64Aq4kMI6EseeQeY3HTJzRmIAWRRdycJaaG2KnUwgmmSFbv/iIkhoH/P/v3DYrEjoSRhvaAgcSBo8FYS9HWAt2/Jh7jgqGIVaVLGcNJy7v/74BmbTCLVzjWA81I6zogxMQKmW6zuFzlZSwQNjP88VHPIWaNhFMssBc98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y4jlaY+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD3DC4CEC3;
	Fri, 18 Oct 2024 05:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729230594;
	bh=hKS4vmBWWMoYIGu21fHqLzEas0MmTWeORGm1/vmtlOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4jlaY+qtS3/Tevld4aw0Mh0MjD4jme5QzUbdHcttzQoHfPrUlzqAdbP1Z2ldv4c1
	 5ZYpUW9ZdL1ZYzgT9XVRIH0DjlbZLGLC0+zljmajyXoE25aCBw5IbstZFos8nWTTQZ
	 WIfRygcw34XTYv6xbddkWC0+k8gAVfGfBH6Ihhxg=
Date: Fri, 18 Oct 2024 07:49:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v9 0/4] shut down devices asynchronously
Message-ID: <2024101809-granola-coat-9a1d@gregkh>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
 <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com>
 <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Oct 18, 2024 at 03:26:05AM +0000, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com> Sent: Thursday, October 10, 2024 9:22 PM
> > 
> > From: Stuart Hayes <stuart.w.hayes@gmail.com> Sent: Wednesday, October 9, 2024 10:58 AM
> > >
> > > This adds the ability for the kernel to shutdown devices asynchronously.
> > >
> > > Only devices with drivers that enable it are shut down asynchronously.
> > >
> > > This can dramatically reduce system shutdown/reboot time on systems that
> > > have multiple devices that take many seconds to shut down (like certain
> > > NVMe drives). On one system tested, the shutdown time went from 11 minutes
> > > without this patch to 55 seconds with the patch.
> > 
> > I've been testing this series against a 6.11.0 kernel in an Azure VM, which
> > is running as a guest on the Microsoft Hyper-V hypervisor. The VM has 16 vCPUs,
> > 128 Gbytes of memory, and two physical NVMe controllers that are mapped
> > into the VM so that it can access them directly.
> > 
> [snip]
> > 
> > But here's the kicker:  The overall process of shutting down the devices
> > took *longer* with the patch set than without.  Here's the same output
> > from a 6.11.0 kernel without the patch set:
> > 
> [snip]
> > 
> > Any thoughts on what might be causing this?  I haven't gone into the
> > details of your algorithms for parallelizing, but is there any extra
> > overhead that could be adding to the time? Or maybe this is
> > something unique to Hyper-V guests. The overall difference is only
> > a few 10's of milliseconds, so not that big of a deal. But maybe it's
> > an indicator that something unexpected is happening that we should
> > understand.
> > 
> > I'll keep thinking about the issue and see if I can get any more insight.
> 
> I've debugged this enough to now know what is happening. I see the
> same behavior in two different environments:
> 
> 1) A Hyper-V VM with 8 vCPUs running on my local laptop. It has
> no NVMe devices, so there's no opportunity for parallelism with this
> patch set.
> 
> 2) A Raspberry Pi 5 with 4 CPUs. Linux is running on the bare metal.
> It has one NVMe device via the Pi 5 M.2 HAT.
> 
> In both cases, the loop in device_shutdown() goes through a lot of
> devices:  492 in my Hyper-V VM, and 577 in the Pi 5. With the code
> in this patch set, all the devices get added to the async_wq in
> kernel/async.c. So async_wq quickly gets heavily populated.
> 
> In the process, the workqueue code spins up additional worker threads
> to handle the load.  On the Hyper-V VM, 210 to 230 new kernel
> threads are created during device_shutdown(), depending on the
> timing. On the Pi 5, 253 are created. The max for this workqueue is
> WQ_DFL_ACTIVE (256).
> 
> Creating all these new worker threads, and scheduling and
> synchronizing them takes 30 to 40 milliseconds of additional time
> compared to the original code. On the Hyper-V VM, device_shutdown()
> completes in about 5 millisecond with the original code, and +/- 40
> milliseconds with the new async code. The Pi 5 results are more
> variable, but also have roughly 30 to 40 milliseconds additional.
> 
> Is all this extra work a problem? I don't know. Clearly, there's big
> benefit in parallelizing the NVMe shutdown, and in those situations
> the extra 30 to 40 milliseconds can be ignored. But I wonder if there
> are other situations whether the extra elapsed time and CPU
> consumption might be a problem.
> 
> I also wonder about scalability. Does everything still work if
> device_shutdown is processing 5000 devices? Is there a possibility
> of deadlock if async_wq can only have 256 active items out of
> 5000 queued ones?

In talking with someone off-list about this yesterday, we guessed that
this was the "thundering herd" problem that might be happening, and you
went and proved it was so!  Thanks so much for doing this work.

I don't think we can put this type of load on all systems just to handle
one specific type of "bad" hardware that takes long periods of time to
shutdown, sorry.

Also think of systems with tens of thousands of devices connected to
them, with tiny 31bit processors (i.e. s390), shutting those down and
spinning up a thread for all of those devices is sure to cause us real
problems.

thanks,

greg k-h

