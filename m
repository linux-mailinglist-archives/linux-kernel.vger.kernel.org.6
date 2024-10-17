Return-Path: <linux-kernel+bounces-369835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8CB9A2342
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D56B213CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C251DE4F9;
	Thu, 17 Oct 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f9E1BCSU"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6411DDC3C;
	Thu, 17 Oct 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170779; cv=none; b=s5a3kRGQiwsFktgWG+p+EG3NV1zT0wdQVg8LcLtMqhu2aM6CqQto3r7RyOI8xlIrIXazw7SDSqFFeRgFarJWNTaYHz4457DFatzyZdTLviKMQRwpHMGv1w5ryB1E0g5WgyGBFtyQ9gGAhuSE23avjYWfy5+bwcwb2incno7Rnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170779; c=relaxed/simple;
	bh=YmPKHblmykCYSpTXM4GbHkuG2YVDdbnNCpiO2NiFhRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plKf46HW3m6pWRIyAGxnDKq6fZG2AGYzojcwBZCQuPOAoX9P82JDJElHZ5MlJBfrazks/S0hNQ21dgD8WcdOjFaQPSDqVMc5SP++XfbYqIGuUwuyCfxF4Ufjwe/ESUZZAzD9AFBNBxr2O/OH7kZ/r62itqfxr6wtRe8/XC3mGyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f9E1BCSU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YmPKHblmykCYSpTXM4GbHkuG2YVDdbnNCpiO2NiFhRY=; b=f9E1BCSULnSugS1EghEBwHw0l6
	zQ3Gk6pTRx0UFUwvhS7/QVjlX0Hf2PrR3WtDAuc0WJtV5BrIMKHFQ6poJj068iXE5HPhablrFUo67
	MGkkhQ8qf0FJ6PLrTdLSBf5j2R3pEgurLlaVeDox3ljUsYGxbDYygYPWcLv+25D+sELMvGtdjquA0
	bZd/APhOUz3Pby05vHrYJODgTtxhpASNztVy/ApfHKosY+NMBHrlC6cx7rXcM7lZToV3hgRBrTs+I
	TZ95IZLqPyXabFZg1Oq+H1xdllas7yBhvJ92uhWJBHxdyeUyBYfn1Q69UDb+LevK1JuB1EX6oSp9t
	Mzge6k3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1QJD-0000000EtT8-3yia;
	Thu, 17 Oct 2024 13:12:55 +0000
Date: Thu, 17 Oct 2024 06:12:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yonatan Maman <ymaman@nvidia.com>, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, herbst@redhat.com, lyude@redhat.com,
	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	leon@kernel.org, jglisse@redhat.com, akpm@linux-foundation.org,
	dri-devel@lists.freedesktop.org, apopple@nvidia.com,
	bskeggs@nvidia.com, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v1 1/4] mm/hmm: HMM API for P2P DMA to device zone pages
Message-ID: <ZxENV_EppCYIXfOW@infradead.org>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
 <20241015152348.3055360-2-ymaman@nvidia.com>
 <Zw9F2uiq6-znYmTk@infradead.org>
 <20241016154428.GD4020792@ziepe.ca>
 <Zw_sn_DdZRUw5oxq@infradead.org>
 <20241016174445.GF4020792@ziepe.ca>
 <ZxD71D66qLI0qHpW@infradead.org>
 <20241017130539.GA897978@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017130539.GA897978@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 17, 2024 at 10:05:39AM -0300, Jason Gunthorpe wrote:
> Broadly I think whatever flow NVMe uses for P2P will apply to ODP as
> well.

ODP is a lot simpler than NVMe for P2P actually :(


