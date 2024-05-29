Return-Path: <linux-kernel+bounces-193486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD058D2CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B728C9AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B43615CD7D;
	Wed, 29 May 2024 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MXsRvcJp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5E21D531
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962756; cv=none; b=cNkIwWMkO6bXGNcMDsuSOco7XJOef+d9nglKmJOjkQI6hgLocOkaF8PIqqVGm+2W8lVanB3LA+mmnJDu4dtZTibo8i1gnqnTMZgSys6qnr1csdcsS5nu5StgBYkvro+8yo4YwgFRsKSjx0P1F60joFUUhMBteLfmY/njXJtD+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962756; c=relaxed/simple;
	bh=cMeCo2Wv/H8lM/gi80oDYtFefeaUPGECO5IUqO8vWfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru6NEhDb/89bIHuV4kLnHZjlzMZPXe8WNSsQLwwNXNg8OFWg/mwf3E1gmstLXlAC7gYjmNb8MwFFwNAVUawGtI6sXu/DhKGhr2M5KfPbVxN/PVSIar4g2YGGEqYtQzL90arAtUg+nEpIpF7lYMNfZg13AN57cDlqfyy/oeUezLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MXsRvcJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C32BC2BD10;
	Wed, 29 May 2024 06:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716962756;
	bh=cMeCo2Wv/H8lM/gi80oDYtFefeaUPGECO5IUqO8vWfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXsRvcJpIs8UvENjyDVODCcVLUb0y8EYZkISMz5gehg1/3CvC46plee4dMnttg5Rn
	 JYXIyPB2g4R6TA+sQqKuyNPwm7rxDlYmu9+CgQR5frsxuvIY1Rq7v1EUlsAXCwTq3w
	 SnKZiPl67tvnvYs1eVz/esSwWK7kQy/AaoSeQfSw=
Date: Wed, 29 May 2024 08:06:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v6 3/4] driver core: shut down devices asynchronously
Message-ID: <2024052951-buffalo-humongous-df1f@gregkh>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
 <20240516154920.221445-4-stuart.w.hayes@gmail.com>
 <20240528063109.GA29965@lst.de>
 <f480f2a4-2958-4b08-ae32-ce307c3c63aa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f480f2a4-2958-4b08-ae32-ce307c3c63aa@gmail.com>

On Tue, May 28, 2024 at 10:35:27PM -0500, stuart hayes wrote:
> 
> 
> On 5/28/2024 1:31 AM, Christoph Hellwig wrote:
> > On Thu, May 16, 2024 at 10:49:19AM -0500, Stuart Hayes wrote:
> > > Add /sys/kernel/async_shutdown to allow user control of this feature:
> > > 
> > >    safe: shut down all devices synchronously, unless driver prefers async
> > > 	shutdown (driver opt-in) (default)
> > >    on:	shut down all devices asynchronously, unless disabled by the driver
> > > 	(driver opt-out)
> > >    off:	shut down all devices synchronously
> > 
> > The on option seems very odd.  IMHO safe is the only really sensible
> > option, and maybe we have to support off as a bandaid due to userspace
> > behavior dependent on synchronous shutdown, but I'd rather try even
> > without that first.
> > 
> 
> I added the option because of comments from Greg K-H on the v4 submission
> of this patch--see
> 
> https://lore.kernel.org/lkml/2023102151-rejoicing-studio-6126@gregkh/T/#m5d0459480bc0fda4563040cab2036839bcbb79a8).
> 
> I thought it would be nice to have the option for testing, even if it gets
> removed later, but I'll certainly remove it now if necessary.

Opt-in is the requirement here, that's all I asked for.  The "on" can
probably be removed, and by doing that, you can make this option simpler
as well.

thanks,

greg k-h

