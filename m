Return-Path: <linux-kernel+bounces-204665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 138B98FF1F3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93CB1F2665E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4FC198A1D;
	Thu,  6 Jun 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaFXcok6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F85198843;
	Thu,  6 Jun 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690282; cv=none; b=pEnYKwDgmG2G5fg2M3uAxxr6NfvutpWp3spw+XMqy2qCdU8XL/w3m+tPw/grk3SogACfhOK3q1jw7xCAW8PJyQ5xPqFpxQdwXshgv19IIKdLMHyIjt120aKa/hDSCRXYf7974rc8RdHFVeWbBnMrn2tweMiyBCGQU8H0QOxc+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690282; c=relaxed/simple;
	bh=EouAagpep61jA1tkJh5qPmOHoRUQb4lmBEbh90kZRwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgVB0NoiLmEhUhj/+Hntj0UmDTIIBhKXBGYSLFFHEXorrbgfaxMpPcaI9DQJsCcfdwPKi+DO16OnhqD7iCudYysW4sfR+wFSEcx2AH0VKbNSo24MXD2VT/UolS/ePFz84aZM9BJ/rHS8uEs533i4GMKmh5pDdm4SQxHobuSnK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaFXcok6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717690280; x=1749226280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EouAagpep61jA1tkJh5qPmOHoRUQb4lmBEbh90kZRwc=;
  b=OaFXcok6n1CoL2KuGT7qrFwePOGmm9pO8VdRcQRYL7YmQZrE8Z5BeeDu
   Gg4NkCedxA9PfC2cRzLoJR1fq+DJOvRf9ohRp6Hcc64QCgrJ75OQfgEIy
   s0G6gY0yLcpqxw/YyucIM9ZXFX85LSBcFrEwbVst9GeMEEI7lGqgwzyy6
   bMNCyWy5u7jHpHrfk8xVVZFniCwi+xpKyDvS6UHl12+IasLizwo5ByY9M
   Aut3JDleTxb9EVhyHoWii1BiSd9wlmOE1sruvBzIs1dikrxCRoFSjrybo
   eAG7069gX3Bxg2aZE04M0j/gcliRdYccmC2zuVHv+Fi0PZDAwDRy78vBy
   Q==;
X-CSE-ConnectionGUID: DaCbEcIKQ9WBvfQnghl2uA==
X-CSE-MsgGUID: CoeC/IGyS6GDanyThdC0Pg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14525408"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14525408"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:11:20 -0700
X-CSE-ConnectionGUID: LTzS1sx2QHC9CkgSFMHcfQ==
X-CSE-MsgGUID: /kKnSnQoTwWrIAFgmczGpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38696127"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.168]) ([10.125.109.168])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:11:19 -0700
Message-ID: <4dd8ebe0-868d-4125-ad23-c5a8b5249ce9@intel.com>
Date: Thu, 6 Jun 2024 09:11:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvdimm/btt: use sizeof(*pointer) instead of sizeof(type)
To: Erick Archer <erick.archer@outlook.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Justin Stitt <justinstitt@google.com>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <AS8PR02MB72372490C53FB2E35DA1ADD08BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <AS8PR02MB72372490C53FB2E35DA1ADD08BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/2/24 1:18 AM, Erick Archer wrote:
> It is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not
> change the former (unlike the latter). This patch has no effect
> on runtime behavior.
> 
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/nvdimm/btt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 1e5aedaf8c7b..b25df8fa8e8e 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -751,7 +751,7 @@ static struct arena_info *alloc_arena(struct btt *btt, size_t size,
>  	u64 logsize, mapsize, datasize;
>  	u64 available = size;
>  
> -	arena = kzalloc(sizeof(struct arena_info), GFP_KERNEL);
> +	arena = kzalloc(sizeof(*arena), GFP_KERNEL);
>  	if (!arena)
>  		return NULL;
>  	arena->nd_btt = btt->nd_btt;
> @@ -978,7 +978,7 @@ static int btt_arena_write_layout(struct arena_info *arena)
>  	if (ret)
>  		return ret;
>  
> -	super = kzalloc(sizeof(struct btt_sb), GFP_NOIO);
> +	super = kzalloc(sizeof(*super), GFP_NOIO);
>  	if (!super)
>  		return -ENOMEM;
>  

