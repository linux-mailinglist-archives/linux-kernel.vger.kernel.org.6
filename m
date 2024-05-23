Return-Path: <linux-kernel+bounces-187749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A258F8CD7E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407531F22D76
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD061862A;
	Thu, 23 May 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7Wzpk5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2D17C91
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479776; cv=none; b=RScGSRsxXkCl4gdff/7DuErMvy9El+PFIfEYfEflzwES4/Xozw3kBFCl2HHy8sZaQBqyQ/CY2ybQskdQx4MIVVAWeLTUlFljgPxhF9H9gUTuI9Lq/Gw/SWi0euUfjB4RoF5t2fscx9gGXFJcSEfztth9pAsU6w9rQ375VocGpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479776; c=relaxed/simple;
	bh=i7Tw0ka2Azlqbu89fYZKEbsu4QyMAXfiYj37ZuKugPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW/1fuayS88TaBSulhRAgueiQOSIbRdxteRq2e2SkkfQDohkLa/k66/xlWR4k2EmQ+ebZoPIeK5EN6DJ2XLD3+InMWU62i3K6KbtUCFaKDezMf4CdVmGRc1IavGniLvINZd0806L+AHeg0v9Vpi/b4pk0SciX9rSaSLbfHGehOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7Wzpk5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0F4C32782;
	Thu, 23 May 2024 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716479776;
	bh=i7Tw0ka2Azlqbu89fYZKEbsu4QyMAXfiYj37ZuKugPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7Wzpk5AmmtRPHaKPz92DnriJQv5L+1r412h+7e9S8JeA7pTvn8WCSqEAJgvQaNGn
	 RAIHoI9GuY97T+8SGeuRaxPab9w0kUZbC0WUkaRkpVJwO4FaO/YRc1oM1WJwDvb/Qb
	 mYwCZZIqC5u6YWRfTGyknhnJn2O1G9scrksGWe6Dlx0rh0BjZED744bCF7cQJzGuwC
	 vArjFlGGEbxq53ULw7E+LhNT00wQHmAAMba3+OOPJLglAWFVV4nQINJNHnhHslEH2q
	 KwLmMSiBhb8BkFTYNWKwD3Il+twaLSdWqSBu8AseJhYA9iu4lgIeNN2G0Ju75/9ZSQ
	 l8Lq2sMTbtcPA==
Date: Thu, 23 May 2024 09:56:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <Zk9nHgk6e4Yb8rOV@kbusch-mbp.dhcp.thefacebook.com>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
 <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com>
 <20240523064525.GA28524@lst.de>
 <fe13bd05-76c5-4bf8-bfda-f9ecf08b2272@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe13bd05-76c5-4bf8-bfda-f9ecf08b2272@redhat.com>

On Thu, May 23, 2024 at 09:12:21AM -0400, John Meneghini wrote:
> On 5/23/24 02:45, Christoph Hellwig wrote:> On Wed, May 22, 2024 at 11:32:02AM -0600, Keith Busch wrote:
> > > Christoph, Sagi, 6.10 merge window is still open and this has been
> > > iterating long before that. Any objection?
> > 
> > No, it's not.  The window for development closes with the release for
> > 6.9.  New features must be in before that.
> 
> So what's the next window for new features?  6.11?

The nvme 6.11 branch will be created after block creates a block-6.11
branch, which usually happens after a few -rc's are released in the
current cycle. So at least a few more weeks.

