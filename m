Return-Path: <linux-kernel+bounces-371370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CEA9A3A26
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ED41C22BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80973179965;
	Fri, 18 Oct 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YAJLw9Ic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA307189F58
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244251; cv=none; b=IiZRGk4kBbVzpr5U0hkog0LrqqHatEr0Wd1HDCTy6dQl9woACed7jFZwd2AThNvGTPk2NQQQ7Yca8RuX4tFGuwjH1NJ0laNPT042D4sQT5gnCeTfkPN7JzIVkcYAtnKX/ox2QgpII6pAIVQgY5OSFEeXndsvuvHJjhRe4VAtMhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244251; c=relaxed/simple;
	bh=3tfw6kwha5dEhRJgoh+7ac3boOs7M6p7ZM1zuo9oEZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WilqtdjOWEbVTcOrmEvCCPFRXorbgldBWpzJEOYKnwefLvMbYbZOlZqSMmanA6mLY4OoLRAy8OSwbQu+9NkryvJ4G5Ze4iwrPy6bIRBGXmC5wp8X7AHvNNdXdyOpWY96SoQdWV5GJn3PL3PoHnRa0cff89a6aCgjSSW/xX2TNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YAJLw9Ic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A87C4CEC3;
	Fri, 18 Oct 2024 09:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729244251;
	bh=3tfw6kwha5dEhRJgoh+7ac3boOs7M6p7ZM1zuo9oEZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAJLw9IcO5pq9FnAUFToJ0U9LydlHRNXgqwAr4ArIBV5VhwzOpgsE//ZA3YlXYE4y
	 DERLl+d6plZH5aL3z/0An9svl2x9B6DL81/emeu/NSoU3RtU6ag0W2f1eUdHFpvtbD
	 9eInJ1TCCHWoV6cYB8VJ8Jr8pg8b6TB+9IJCyRp8=
Date: Fri, 18 Oct 2024 11:37:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v9 0/4] shut down devices asynchronously
Message-ID: <2024101808-subscribe-unwrapped-ee3d@gregkh>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
 <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com>
 <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com>
 <2024101809-granola-coat-9a1d@gregkh>
 <ZxInC1U7WiB7FNkJ@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxInC1U7WiB7FNkJ@wunner.de>

On Fri, Oct 18, 2024 at 11:14:51AM +0200, Lukas Wunner wrote:
> On Fri, Oct 18, 2024 at 07:49:51AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Oct 18, 2024 at 03:26:05AM +0000, Michael Kelley wrote:
> > > In the process, the workqueue code spins up additional worker threads
> > > to handle the load.  On the Hyper-V VM, 210 to 230 new kernel
> > > threads are created during device_shutdown(), depending on the
> > > timing. On the Pi 5, 253 are created. The max for this workqueue is
> > > WQ_DFL_ACTIVE (256).
> [...]
> > I don't think we can put this type of load on all systems just to handle
> > one specific type of "bad" hardware that takes long periods of time to
> > shutdown, sorry.
> 
> Parallelizing shutdown means shorter reboot times, less downtime,
> less cost for CSPs.

For some systems, yes, but as have been seen here, it comes at the
offset of a huge CPU load at shutdown, with sometimes longer reboot
times.

> Modern servers (e.g. Sierra Forest with 288 cores) should handle
> this load easily and may see significant benefits from parallelization.

"may see", can you test this?

> Perhaps a solution is to cap async shutdown based on the number of cores,
> but always use async for certain device classes (e.g. nvme_subsys_class)?

Maybe, but as-is, we can't take the changes this way, sorry.  That is a
regression from the situation of working hardware that many people have.

thanks,

greg k-h

