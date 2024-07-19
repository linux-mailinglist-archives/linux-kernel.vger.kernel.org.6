Return-Path: <linux-kernel+bounces-256963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A8A937349
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184691C21BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 05:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A5C3A8E4;
	Fri, 19 Jul 2024 05:31:25 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4DF2A1DC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721367085; cv=none; b=EXHUWYMrT4pPh5wWRm8zuL56dKpsa/g3cEHgpdFudMdP83idjOQw2ziBWr0uwbsBGHlVeijuCb/N+lOi0p0jDZn0VL+WFeTocoe34uy28ZkaWnHTB5BZ0Ut7uFfYHom7YX2XgjTrQ3x/+Fwcmd4893WcTE+Dyq9VcjAJq/gLyY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721367085; c=relaxed/simple;
	bh=ZE5EojKxUAjvISgGJyNlirn7RmotoRr27lG9mVhGVJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px+N9BdaFZixOMCCrUSbicpGkE9M48SZq3jFq8PSpZQ1tri2i7PS3p1+5OMPe7WPkRN+Sir4bkJz3JU0BynJM4WHl3UaqWx5hK+0UsMnI2bZh2epKIbmnhj4+DXJm6WyZNyqSJmLEc5LTdLgXIw6ksaZTdYfKTZc1HO63G8aKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0286768BFE; Fri, 19 Jul 2024 07:31:16 +0200 (CEST)
Date: Fri, 19 Jul 2024 07:31:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ping Gan <jacky_gam_2001@163.com>
Cc: hare@suse.de, sagi@grimberg.me, hch@lst.de, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	ping.gan@dell.com
Subject: Re: [PATCH v2 0/2] nvmet: support unbound_wq for RDMA and TCP
Message-ID: <20240719053116.GA21474@lst.de>
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717091451.111158-1-jacky_gam_2001@163.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 17, 2024 at 05:14:49PM +0800, Ping Gan wrote:
> When running nvmf on SMP platform, current nvme target's RDMA and
> TCP use bounded workqueue to handle IO, but when there is other high
> workload on the system(eg: kubernetes), the competition between the 
> bounded kworker and other workload is very radical. To decrease the
> resource race of OS among them, this patchset will enable unbounded
> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
> get some performance improvement. And this patchset bases on previous
> discussion from below session.

So why aren't we using unbound workqueues by default?  Who makea the
policy decision and how does anyone know which one to chose?


