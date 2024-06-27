Return-Path: <linux-kernel+bounces-231926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9538B91A06B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECC3281058
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6964EB3F;
	Thu, 27 Jun 2024 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0iTGi8ci"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2792E288BD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473410; cv=none; b=sozcysPRMvziDLbi1RPPbdRKfEoVhbMCpZ7h32Vlev85u5ZvZa946j987MUeoJ+m3Na+LL9LGpEJbBaDgNuh1v9JMTKSRYcA7c9LiTKfJH5e1lADRP4L3VKIawF5Y43Es7uvknArti11LI0X+bBNo5V9vQqt/AG17QmUUGKAORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473410; c=relaxed/simple;
	bh=L0iDbGCphSHH/3ZKqfEW7HtNdel6Lk26zULKayrmyUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmNq6O97fiDL7vbvRFTCuKVcA9C3yEhcwLyzEOcM6iSsetsIX7DUjhroGGD5HdFhxpyncbkUCUC9XVCeeC2oRbAy/Ga1PBLIPhu4nV9MAevQVfW+RU2V75Mq07dOqLCpuQbx0by6GzfksBv1FNqayhaMBKaTImi9kyTJislwck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0iTGi8ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A6EC2BBFC;
	Thu, 27 Jun 2024 07:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719473409;
	bh=L0iDbGCphSHH/3ZKqfEW7HtNdel6Lk26zULKayrmyUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0iTGi8ciwkk0hWC8JQsX60EJpqDx+oxe+mR/d4pDNiRZmwhf5xVqm5vAynPenA31B
	 v2Fxa34RenmP+eg6dNXYUoTLWFtitiIvPB/xmpOPtv0HJwdxU/zG6TB7WOHG/n/fBh
	 YeabEevW2RldDVgeUYcTT1W1Cb7KJwgyU2+RLCdE=
Date: Thu, 27 Jun 2024 09:30:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 1/4] driver core: don't always lock parent in shutdown
Message-ID: <2024062751-itunes-silk-ae8d@gregkh>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
 <20240626194650.3837-2-stuart.w.hayes@gmail.com>
 <20240627055121.GA15415@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627055121.GA15415@lst.de>

On Thu, Jun 27, 2024 at 07:51:21AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 26, 2024 at 02:46:47PM -0500, Stuart Hayes wrote:
> > Don't lock a parent device unless it is needed in device_shutdown. This
> > is in preparation for making device shutdown asynchronous, when it will
> > be needed to allow children of a common parent to shut down
> > simultaneously.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> .. but I guess this means async shutdown won't work well for busses
> that set this flag (just usb currently)?

USB can't do async shutdown due to the tree topology requirements here
so hopefully this should be ok.

thanks,

greg k-h

