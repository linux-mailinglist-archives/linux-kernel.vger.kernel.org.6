Return-Path: <linux-kernel+bounces-274505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B40094790B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E131F2236D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2135154434;
	Mon,  5 Aug 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWRDz09z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156915250F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852322; cv=none; b=FqZBQemmum4/KZxlp/1Qt/YkauF4NzZnNIzjH+6GW+Us9dGsGkr8K1QEg8F85z+5mqzBmleTn0TU2cicXwhFkX6YKP7dGq0C7ksUK6VmWsdODKWKCtsrkRlB76qp4Ot5k4/4PqaqPRPkQJw9bTBz/5FGT1ceO4WIp4qNK+1m+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852322; c=relaxed/simple;
	bh=/06IadH+EV4lkjqp7OH/dHVKNM+jHZzeTgU9JSf+Pi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl7yb2yHSvzzequlb5ltCbZviHSwDNxevUwFDrkjY6puKnpKBHsxU4zNJS38mfpxhZHBaniC1RjAoTkAklReM4vITElRtV9wbaXfr9ljt8Anwzi4FxJUcGWO0TFB5MpYMXIBg1YEV5hjszsE0ubAIoYx6Leoyxd8Ra24K7TWRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWRDz09z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14751C32782;
	Mon,  5 Aug 2024 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722852321;
	bh=/06IadH+EV4lkjqp7OH/dHVKNM+jHZzeTgU9JSf+Pi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWRDz09zNVaVoJEyrZtuKh6/2w+lw6Y+tSkZHOCots2S1uDdq1MP5jEPd8zzxCLAn
	 5r3DaqHtiSrx90zy6r6MtNt6OPZu6tjF94eB7Uy1TX9Nw5xZPCzueGt9yh5dCmavlh
	 MIXc/2DKBfV9tCSqKi/n+xaKpcfIQoEp13qGeKVpOkNrC8OAPhAR+5FDYI9DiooxF9
	 Hb5Li+SY3Q2+wEfjsY1ozrIKAVfmeIHUEMalMoj7gSV6MRpEXOxMY5maNLLnRPqrGG
	 ZOkp56DWeYJyFl2mRGDkK98CIz+QYBV3iMeGSc6O9F7UrlxiUZA5Ed1G0gf/nmt6B9
	 DY5Z0zbQiM1/Q==
Date: Mon, 5 Aug 2024 13:03:14 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/5] memblock test: fix implicit declaration of
 function 'virt_to_phys'
Message-ID: <ZrCjYqdmNfn3di-o@kernel.org>
References: <20240802010923.15577-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802010923.15577-1-richard.weiyang@gmail.com>

On Fri, Aug 02, 2024 at 01:09:19AM +0000, Wei Yang wrote:
> Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
> alloc") introduce the usage of virt_to_phys(), which is not defined in
> memblock tests.
> 
> Define it in mm.h to fix the build error.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> 
> ---
> v3: use static inline as phys_to_virt
> v2: move definition to mm.h
> ---
>  tools/include/linux/mm.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
> index cad4f2927983..c9e915914add 100644
> --- a/tools/include/linux/mm.h
> +++ b/tools/include/linux/mm.h
> @@ -25,6 +25,12 @@ static inline void *phys_to_virt(unsigned long address)
>  	return __va(address);
>  }
>  
> +#define virt_to_phys virt_to_phys
> +static inline phys_addr_t virt_to_phys(volatile void *address)

Why volatilte?

> +{
> +	return (unsigned long)address;

This should be phys_addr_t, look at its definition in tools/include/linux/types.h

> +}
> +
>  void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid);
>  
>  static inline void totalram_pages_inc(void)
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

