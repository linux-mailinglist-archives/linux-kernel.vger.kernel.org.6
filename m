Return-Path: <linux-kernel+bounces-536908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08AFA485A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BA73A89BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385F41BCA05;
	Thu, 27 Feb 2025 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hm4yOuD2"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CFF1B0403
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674913; cv=none; b=FHvALV4KtWOPd0W60fdFn5zodxlRI2ZzTUolg8bUqQ8sUW8SiYhEMC43Ism0HtcMjqh0imv4b8kiOw8NlTyIAHPQavcHyp8uPo3vwGgwEBht7OJq2p7lvEbOH3CsJisLgFQBqVs8ojUvRotVp0KRgsqaxpOgcysGyGQYt1R9E4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674913; c=relaxed/simple;
	bh=WeAE/TxeOmGnY4+JQF5xk1qUh5Kf+dfgn0Fy3i422Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTEioH4mNKRXsfJNsBztK+ovRoKWzNXBXQMgRjJDEWuqokJ3xaj8EA8VME9mR7FHYynK1ULeygIhXfrLIJDpZIRWmpK8VGN4SHuFQgW8N+XurIEPj4ZR2FeuloPHNSJRFyR/vVupMdTz/EgQFj1tlsH/HQy4GlNfKL7DrQ6xV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hm4yOuD2; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 16:48:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740674908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYqkwfqBGdERzPpqSrLqEfTuFzAy3l3vuA3S89dJKzI=;
	b=Hm4yOuD2Z6trhtMH/dLnwVtxrs93F6QIonjOPAnYVXPum6sNIsIlUnQ39AVOZPf0RNm+Dq
	PW6tP66dmw+uUfk6i1Nv8BLPd+82mtB1ZfErKAKMLfURNR7J6PycbmJulzavL4cqWtvoYQ
	cDim2l1RgjjtYJwuy1rcm2PgMGKEhns=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Parav Pandit <parav@mellanox.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: don't expose hw_counters outside of init net
 namespace
Message-ID: <Z8CXV4c9GSPXvgLN@google.com>
References: <20250226190214.3093336-1-roman.gushchin@linux.dev>
 <CY8PR12MB719566F1EE6987670B7D85F0DCCD2@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB719566F1EE6987670B7D85F0DCCD2@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 05:22:59AM +0000, Parav Pandit wrote:
> 
> > From: Roman Gushchin <roman.gushchin@linux.dev>
> > Sent: Thursday, February 27, 2025 12:32 AM
> > 
> > Commit 5fd8529350f0 ("RDMA/core: fix a NULL-pointer dereference in
> > hw_stat_device_show()") accidentally almost exposed hw counters to non-init
> > net namespaces. It didn't expose them fully, as an attempt to read any of
> > those counters leads to a crash like this one:
> > 
> It is not the commit 5fd8529350f0.
> You just want to say cited commit accidentally..

Right, it's a typo, it had to be 467f432a521a ("RDMA/core: Split port
and device counter sysfs attributes").

> >  	WARN(true, "struct ib_device->groups is too small"); diff --git
> > a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index
> > b59bf30de430..a5761038935d 100644
> > --- a/include/rdma/ib_verbs.h
> > +++ b/include/rdma/ib_verbs.h
> > @@ -2767,6 +2767,7 @@ struct ib_device {
> >  	 * It is a NULL terminated array.
> >  	 */
> >  	const struct attribute_group	*groups[4];
> > +	u8				hw_stats_attr_index;
> > 
> >  	u64			     uverbs_cmd_mask;
> > 
> > --
> > 2.48.1.711.g2feabab25a-goog
> 
> With above suggested small commit log correction, 
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Thank you!

