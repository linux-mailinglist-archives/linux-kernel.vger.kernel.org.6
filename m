Return-Path: <linux-kernel+bounces-442712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352CA9EE0A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078A5167B78
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66BA20B7E6;
	Thu, 12 Dec 2024 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6Hf+qEV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556220ADE2
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990135; cv=none; b=KFxalgE3WfhYPh11OpUZ14WF9y4pqYf+Jkbz2ZRqro3SKnc9GoeBt8tO8lTvE2oQ4HFj75WCWq79n3F6yetyrPNiB7GXbjjcOdVjuBkX+HoomssKQk6d5jNi/kJHe02X5mN4JPxFx5o/VmreJvAPTsXQEZUF2Lrad3bOqpWNHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990135; c=relaxed/simple;
	bh=UhNWU2tGfAci2njpbZCAWV5dGcf9OARUUQhbJ12YPQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOeH7IWiKd0EY5AOoOuvJYRyZa1CHohpak49vI0/5WnolvnSwqUnUNkeyLH17eBMmt5P7TQHR0v/ysDmHF+FUkTIbynzkqi7Zx7aT3ChJCW1fQvEN3u0MdavGFrnjxIRy5JQoDSwHmJLgnndgFSUhC3oPJTP7nMsUA6ChE2IvIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6Hf+qEV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733990132; x=1765526132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UhNWU2tGfAci2njpbZCAWV5dGcf9OARUUQhbJ12YPQQ=;
  b=l6Hf+qEVko/4teOtCGNBRXtMIIA2AmhjWYoHs6NzS5UMnMghgCt0kRP+
   E9KbCS4yTUrU3dZghaT1ttjwwiba3S2ZtZ2NIajguYFzN62daXOKmlaeJ
   UZTEP1Oyowj1Zzz/vsrgoS/fWGLwgAokzPkMV8MVt9CTtiASh4EVqQK1/
   4q4a8Jd0sANkl/Vhba4WmNRVyx+/mWsbPTI3hV1pWkCzBNY+R1hqZsQA5
   iNvjE3b0nzA8La1flGSyiuX5ZxpVwnouDM8leorzQ5te0uGqX+2GfqYQz
   ftSd+U6P6lda2wReyUKt1NN4Wiaz5eBXwW3OFHo3obCiGtdATFi+eY+P3
   Q==;
X-CSE-ConnectionGUID: d1ak6LgDRSmyPeSeEuLlHg==
X-CSE-MsgGUID: NkypidwfQIugQK3R/jL9Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45781413"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45781413"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 23:55:32 -0800
X-CSE-ConnectionGUID: iPZ5d7eJQ56Lg0oV1v+8Pg==
X-CSE-MsgGUID: CUMN4fCTRfqAIhYsN7UpuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96693738"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO himmelriiki) ([10.245.245.25])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 23:55:29 -0800
Date: Thu, 12 Dec 2024 09:55:20 +0200
From: Mikko Ylinen <mikko.ylinen@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v4] virt: tdx-guest: Handle GetQuote request error code
Message-ID: <Z1qW6C4I5Rbju-F-@himmelriiki>
References: <20240411022250.4091435-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411022250.4091435-1-sathyanarayanan.kuppuswamy@linux.intel.com>

Hi,

On Thu, Apr 11, 2024 at 02:22:50AM +0000, Kuppuswamy Sathyanarayanan wrote:
> The tdx-guest driver marshals quote requests via hypercall to have a
> quoting enclave sign attestation evidence about the current state of
> the TD. There are 2 possible failures, a transport failure (failure
> to communicate with the quoting agent) and payload failure (a failed
> quote). The driver only checks the former, update it to consider the
> latter payload errors as well.
> 
> Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Closes: https://lore.kernel.org/linux-coco/6bdf569c-684a-4459-af7c-4430691804eb@linux.intel.com/T/#u
> Reviewed-by: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v3:
>  * Rebased on top of v6.9-rc1
>  * Added Dan's Reviewed-by tag.
> 
> Changes since v2:
>  * Updated the commit log (Dan)
>  * Removed pr_err message.
> 
> Changes since v1:
>  * Updated the commit log (Kirill)
> 
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index 1253bf76b570..c39f0007958d 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -228,6 +228,11 @@ static int tdx_report_new(struct tsm_report *report, void *data)
>  		goto done;
>  	}
>  
> +	if (quote_buf->status != GET_QUOTE_SUCCESS) {
> +		ret = -EIO;
> +		goto done;
> +	}
> +
>  	buf = kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
>  	if (!buf) {
>  		ret = -ENOMEM;

Would it be possible to get this queued?

I had the same fix implemented as I ran into the same issue but then
noticed this had already been sent out.

One possible improvement here could be to add a reason for the error
to make it more consistent with the other error paths above:

pr_err("GetQuote failed, status:%llx\n", quote_buf->status);

Anyway, it works as expected as it is so:

Tested-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>

-- Mikko

