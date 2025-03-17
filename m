Return-Path: <linux-kernel+bounces-563374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C6CA64050
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496681890D24
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C46219A72;
	Mon, 17 Mar 2025 05:53:13 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC581DF990
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742190793; cv=none; b=Rrlh6ynRfF2CAbgGjqtz818c1pyFLjE+Yz2gBnwebEk8O2ueyVOpYgZDV9LdsJQx5HFAq0rbwL3Dh3mTKMI0HoqfWlIVpgyUiilGLueSLt8Ez0TNvGefxzcRMipPAe5DYEPlFX5i2QC+KoxQUlGhgn3OxbQezOa1+ThTKsCk4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742190793; c=relaxed/simple;
	bh=xBIck/UIYbiemwjFp0J9ppT7pV4l+AHnLoc1fvW3rbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyVp1XZflM5j21uR+AYlh4IYu8GN0YwFptk2RTMqqrnaNL80/fS2VaqntMUEoe7gZ/mV6mhqif+fVt56F/8Bn1mpUzh9emxVjLYFtgIAeiKo7KqctS0TJoxtPqFMYt+0ewum0fttnc0i1ufBGRkXIz/upNyFpnXxsZY+9woRTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F55068D0E; Mon, 17 Mar 2025 06:53:05 +0100 (CET)
Date: Mon, 17 Mar 2025 06:53:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bingbu Cao <bingbu.cao@linux.intel.com>
Cc: Huan Yang <link@vivo.com>, hch@lst.de, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, opensource.kernel@vivo.com,
	rppt@kernel.org, ryan.roberts@arm.com, urezki@gmail.com,
	ziy@nvidia.com
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
Message-ID: <20250317055304.GB26662@lst.de>
References: <20250312061836.GA12841@lst.de> <339b0c1f-ce90-449f-a1fc-2656d5a1115c@vivo.com> <79247edd-761c-82e3-b8d2-acdbe31c8205@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79247edd-761c-82e3-b8d2-acdbe31c8205@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 17, 2025 at 01:29:05PM +0800, Bingbu Cao wrote:
> Why not update udmabuf to make it work with both vmap_pfns() and
> vmap()? As only the udmabuf knows it is actually working on?
> 
> I don't think it's a good idea to hack the common API, the WARN_ON()
> is really a mandatory check, and current case is a good example.

What non-page backed memory does udmabuf try to work on, and more
importantly how does it actually work on them given that the normal
DMA APIs require page backed memory.  Or is this just made it up
and it doesn't work at all given that it also tries to dma map
to the fake miscdevice struct device which can't work for most
cases?

Mapping non-page memory is difficult and without having coherent theory
of what non-page memory you are mapping and being very careful you
are extremely unlikely to get it right.

