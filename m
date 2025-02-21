Return-Path: <linux-kernel+bounces-526068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42704A3F981
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04646703A21
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE661DE4D5;
	Fri, 21 Feb 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFeCZQLU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4E41D8A10
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152871; cv=none; b=KtE4q08tZGvPY14fjVUnz2QT3mbtsnxSgBpJ5xw9+wBTOv+RqT6ejTPtRxDJgwrxXttJo1mOM2iQHnd1bpQzBXBN474BLnWYyGoJ6uZoSQ7QkK2F8CYH8CU5QWyMc5gKUTkY4WO/HITRLUyrqhVRc5pdXFMcenfRyyKHr98b89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152871; c=relaxed/simple;
	bh=g+HuL5PbvHlLrqAdSGE6xkj7LNnhPB5aBd77hBqjA2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZC8pyWtjqShNnO1ZQj/6QbNShCELIoENxpZRjheSCuiNL08LuAPlhZ5TLm921mg4JvCu5LFThhIdgBIoLb1A8Hja11I4pP/UbmRNWocHnO9mvIfpoI1HdklYBiVT0STfyrDrnvf+bk18BZS+Nq+VmoyM3dqIZJtZvsrLwDYUFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFeCZQLU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740152870; x=1771688870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g+HuL5PbvHlLrqAdSGE6xkj7LNnhPB5aBd77hBqjA2s=;
  b=lFeCZQLU2F+NUbu0EuOaOfCTaN3nQuH3OXevYxHZBAwieQ3LZAH7rU5p
   b3phMO+XHiU4FkN+spRCJPDAdf+UWGoEIUkT5PhnY9RZLOb/WcAhUQ0Zk
   fslHMI8HD+kb466pv34MCYFgZ3n71hCEqjv7WDEdGlWYQp4dg9TvuQ8p8
   yBCd7HigSafm9MUK0qaB8ZfbzoGyOGCnQ/04xCHPTsxmFglhPcVk5pXOy
   /1m3iydr1HdNVIwRElfviJGBAjBBKgVkJWYX0mc1GamWrcjs4ko2WKTI2
   d82/qt85W6B1q57rIZL1VLMAhAlm0ejMnvadQYlaa3sXVAqHUP8SsJ/x7
   g==;
X-CSE-ConnectionGUID: 18eOoQ+zTjydBHlae0aaYg==
X-CSE-MsgGUID: hJGAWcKSS6uOgxC4Do+07Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="58524608"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="58524608"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 07:47:49 -0800
X-CSE-ConnectionGUID: +pSRTvMaQnaahvl/d6uFNQ==
X-CSE-MsgGUID: YlgDdXvdRmqP7cAl+zgw9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115237204"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 07:47:49 -0800
Message-ID: <0e7e6ce7-7d7b-49cc-90eb-a07e831441d8@intel.com>
Date: Fri, 21 Feb 2025 08:47:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntb: reduce stack usage in idt_scan_mws
To: Arnd Bergmann <arnd@kernel.org>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 zhang jiao <zhangjiao2@cmss.chinamobile.com>,
 Philipp Stanner <pstanner@redhat.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250221085748.2298463-1-arnd@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250221085748.2298463-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/21/25 1:57 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> idt_scan_mws() puts a large fixed-size array on the stack and copies
> it into a smaller dynamically allocated array at the end. On 32-bit
> targets, the fixed size can easily exceed the warning limit for
> possible stack overflow:
> 
> drivers/ntb/hw/idt/ntb_hw_idt.c:1041:27: error: stack frame size (1032) exceeds limit (1024) in 'idt_scan_mws' [-Werror,-Wframe-larger-than]
> 
> Change it to instead just always use dynamic allocation for the
> array from the start. It's too big for the stack, but not actually
> all that much for a permanent allocation.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202205111109.PiKTruEj-lkp@intel.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

LGTM. Old code didn't make sense to declare on stack, allocate later and memcpy.
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> A number of users have reported this in the past, but I couldn't
> find any other patch for it so far.
> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 544d8a4d2af5..f27df8d7f3b9 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -1041,7 +1041,7 @@ static inline char *idt_get_mw_name(enum idt_mw_type mw_type)
>  static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
>  				       unsigned char *mw_cnt)
>  {
> -	struct idt_mw_cfg mws[IDT_MAX_NR_MWS], *ret_mws;
> +	struct idt_mw_cfg *mws;
>  	const struct idt_ntb_bar *bars;
>  	enum idt_mw_type mw_type;
>  	unsigned char widx, bidx, en_cnt;
> @@ -1049,6 +1049,11 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
>  	int aprt_size;
>  	u32 data;
>  
> +	mws = devm_kcalloc(&ndev->ntb.pdev->dev, IDT_MAX_NR_MWS,
> +			   sizeof(*mws), GFP_KERNEL);
> +	if (!mws)
> +		return ERR_PTR(-ENOMEM);
> +
>  	/* Retrieve the array of the BARs registers */
>  	bars = portdata_tbl[port].bars;
>  
> @@ -1103,16 +1108,7 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
>  		}
>  	}
>  
> -	/* Allocate memory for memory window descriptors */
> -	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt, sizeof(*ret_mws),
> -			       GFP_KERNEL);
> -	if (!ret_mws)
> -		return ERR_PTR(-ENOMEM);
> -
> -	/* Copy the info of detected memory windows */
> -	memcpy(ret_mws, mws, (*mw_cnt)*sizeof(*ret_mws));
> -
> -	return ret_mws;
> +	return mws;
>  }
>  
>  /*


