Return-Path: <linux-kernel+bounces-200973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F898FB79F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EA32850F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581AC1448ED;
	Tue,  4 Jun 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QFYHrfR2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EABBE4A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515705; cv=none; b=oInvFF4MFAOgcWuEbDt8E3ADRhsfge4JmbYVpglXsO6KcldaZ6DcD2xkXG41nFf993t598dNFYjONdStNJwaRFeJsLU0JHPJ3+IMnV98eMlRZGNERzkTPxo5RDOfES5zUi5niCRgPCw2dSQcnFZwEOPnFzhGTZDaY1QZoigNao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515705; c=relaxed/simple;
	bh=MkqW4oRMkhNEdYOvDU8SXsza2MZUGZIzZNiOeC/dQY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/cgN6W0w4yM+ocxmUPQWKawni8cG3owAn1hsqN3y6nnaP8cbjmuNuQnUQTZwRfdf8srLS8C09NK+XjSEjmGyd7Atvcr1vicSYPqi/prU/+XTTH0amwORi0pKNqqSLlrHtcsfGQMwVG3qu5nrNfBTDxb4jxQGZXZPICUnoB2X8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QFYHrfR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419ADC2BBFC;
	Tue,  4 Jun 2024 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717515705;
	bh=MkqW4oRMkhNEdYOvDU8SXsza2MZUGZIzZNiOeC/dQY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFYHrfR2wBDLSr/NAUq7a4NDJajg6kry2t9DxkVnMJNuCwbyEticVZz7z2cXgWxSV
	 W/tFV8bzudGtOLJnKhHl1GTe7pvxoBR5+Kc53ItMaFHBUJT0bjGH7NoEruB+u04AF/
	 QvjXc0tth8Ny884yL9+o4j1zEe6gYh2NE+pGVcfU=
Date: Tue, 4 Jun 2024 17:31:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	christian.koenig@amd.com, alexander.deucher@amd.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/resource: optimize find_next_iomem_res
Message-ID: <2024060427-upstairs-jackal-b10a@gregkh>
References: <20240531053704.2009827-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531053704.2009827-1-olvaffe@gmail.com>

On Thu, May 30, 2024 at 10:36:57PM -0700, Chia-I Wu wrote:
> We can skip children resources when the parent resource does not cover
> the range.
> 
> This should help vmf_insert_* users on x86, such as several DRM drivers.
> On my AMD Ryzen 5 7520C, when streaming data from cpu memory into amdgpu
> bo, the throughput goes from 5.1GB/s to 6.6GB/s.  perf report says
> 
>   34.69%--__do_fault
>   34.60%--amdgpu_gem_fault
>   34.00%--ttm_bo_vm_fault_reserved
>   32.95%--vmf_insert_pfn_prot
>   25.89%--track_pfn_insert
>   24.35%--lookup_memtype
>   21.77%--pat_pagerange_is_ram
>   20.80%--walk_system_ram_range
>   17.42%--find_next_iomem_res
> 
> before this change, and
> 
>   26.67%--__do_fault
>   26.57%--amdgpu_gem_fault
>   25.83%--ttm_bo_vm_fault_reserved
>   24.40%--vmf_insert_pfn_prot
>   14.30%--track_pfn_insert
>   12.20%--lookup_memtype
>   9.34%--pat_pagerange_is_ram
>   8.22%--walk_system_ram_range
>   5.09%--find_next_iomem_res
> 
> after.

That's great, but why is walk_system_ram_range() being called so often?

Shouldn't that be a "set up the device" only type of thing?  Why hammer
on "lookup_memtype" when you know the memtype, you just did the same
thing for the previous frame.

This feels like it could be optimized to just "don't call these things"
which would make it go faster, right?

What am I missing here, why does this always have to be calculated all
the time?  Resource mapping changes are rare, if at all, over the
lifetime of a system uptime.  Constantly calculating something that
never changes feels odd to me.

thanks,

greg k-h

