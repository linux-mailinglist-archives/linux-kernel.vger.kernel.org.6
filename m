Return-Path: <linux-kernel+bounces-557243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C1A5D591
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FBB189CA3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D531DE88A;
	Wed, 12 Mar 2025 05:32:51 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A781D9663
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741757571; cv=none; b=LV2auPV74HbbIohbSAyI+1eyJr014uWX1L7N3W1q1ocEKFFJCrpSAIisZUyiunWhcOOenCWCbkTPwKudSVVCfFqvnDwgRPym7JPZQk+KqNDZQ/PtzhTUP5rdgD7hZjFarItwoWrWtYsvsLP3iDAh/qfZUgtPVu3vGKpqJpfJi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741757571; c=relaxed/simple;
	bh=z4jwwaLworZ/2NBXvH/Ndw7WxSlxjDR/5s9Behu6RBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnF3qlD+HgAm6IAu8OO8KbS/o6I2ZYvhVzav7Xy1bLbSWo2ffgF6MNShNwhBsXVmI7G9qFze9qyeEgAGy+QRYTl1jVGEywUD7hy1uPc8w6jAQDQL0mmXZIcL9wxdbHJ+qBO2O188TqKlZqrvTUjngyHNoguYOni5tr9bTfv/VTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E48268AA6; Wed, 12 Mar 2025 06:32:45 +0100 (CET)
Date: Wed, 12 Mar 2025 06:32:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Huan Yang <link@vivo.com>, Bingbu Cao <bingbu.cao@linux.intel.com>,
	vivek.kasireddy@intel.com, hch@lst.de, linux-kernel@vger.kernel.org,
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org
Subject: Re: udmabuf vmap failed (Revert "udmabuf: fix vmap_udmabuf error
 page set" can help)
Message-ID: <20250312053245.GA12112@lst.de>
References: <9172a601-c360-0d5b-ba1b-33deba430455@linux.intel.com> <d7a54599-350e-4e58-81b6-119ffa2ab03e@vivo.com> <ab468ce7-c8ac-48eb-a6c0-386ea7aa9a0c@linux.intel.com> <78cd737d-5e85-4d3c-8bb5-0b925d81719b@vivo.com> <29445257-b8df-72bd-0650-44c8deb1506c@linux.intel.com> <5da7bd8a-c6db-4995-b947-444e2c78aa7c@vivo.com> <32814695-359e-4c4b-90a4-c7c34421a1d5@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32814695-359e-4c4b-90a4-c7c34421a1d5@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 11, 2025 at 11:14:28AM +0000, Ryan Roberts wrote:
> Hi,
> 
> On 11/03/2025 09:34, Huan Yang wrote:
> > Hi Christoph and Ryan,
> > 
> > Can you help us check vmap_pfn's pfn check is right? Did here mischecked pfn_valid?
> 
> I'm no expert on this piece of code, but I believe pfn_valid() is checking to
> see if a pfn is valid *memory*. i.e. does it have a corresponding struct page?
> 
> I'm guessing that vmap_pfn() is only intended to be used for non-memory pfns,
> e.g. mmio regions. You probably want either vmap() or vm_map_ram()?

Exactly.  vmap_pfn is a special case for mapping non-page backed memory.

Wjile looking ad udmabuf, the crap it does with dma mapping to the
misc device-attached struct device also can't work except by chance in a
few very exceptional setups.  So as far as I can tell udmabuf isn't
really something usable to start with, which might explain why the
issues with vmap/vmap_pfn weren't easily noticed.


