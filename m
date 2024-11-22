Return-Path: <linux-kernel+bounces-418203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E05029D5E95
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C43B24402
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4AD1DE2C4;
	Fri, 22 Nov 2024 12:09:31 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8F4500E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277371; cv=none; b=hWFVZk6Q9iPiKrnK0j0erz/pnVX686vP+NMULDdT6daGoxnzPb1hYW7Hv3ymi/9+ecZdHxMfZyLVeaqSVkJLteknbhi4fwgpzFr06nuH3D/RZRkjfHygU+BctY+4oGBLk9ceaK8ZUax8gUhRJ5onb1y2OLMbopYKUtBBa6+iZ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277371; c=relaxed/simple;
	bh=EChpjUJNNEgIRjfpbKzhBZj4nB4CF0XHdtVk2OXKyTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay+TUrNNxfNf3DocD02EfqiCOIAgiMymGOb0mu/ez14wY0ZB2RC/Gw7NiRylsqy0syVpqCboXLfGWUr6iFjswz+ezkzMjn7Fw/Nib1zE4qNF27ySUhCSM8wt4YMwEJRld8clpCqqEsZ/nrgigOXJ29OuEkzJsbQu0YqHcaV0Dx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 63E2968C4E; Fri, 22 Nov 2024 13:09:26 +0100 (CET)
Date: Fri, 22 Nov 2024 13:09:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bryan Gurney <bgurney@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	mpe@ellerman.id.au, naveen@kernel.org, maddy@linux.ibm.com,
	kernel@xen0n.name, jmeneghi@redhat.com, bmarzins@redhat.com
Subject: Re: [PATCH 1/1] nvme: always enable multipath
Message-ID: <20241122120925.GA25817@lst.de>
References: <20241121220321.40616-1-bgurney@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121220321.40616-1-bgurney@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 21, 2024 at 05:03:21PM -0500, Bryan Gurney wrote:
> Since device-mapper multipath will no longer be operating on NVMe
> devices, there is no longer a need to set CONFIG_NVME_MULTIPATH=n.
> 
> Always enable NVMe multipath, remove CONFIG_NVME_MULTIPATH, and use
> the code paths that would be used if CONFIG_NVME_MULTIPATH=y.

As mentioned last round not having to build the not tiny multipath
code for embedded systems and other small builds that never require
multipathing still seems like a sensible idea.


