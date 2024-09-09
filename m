Return-Path: <linux-kernel+bounces-320703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B179F970EBF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345AF1F229E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE281AD9F6;
	Mon,  9 Sep 2024 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B627BVA2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34D1AD9E2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865465; cv=none; b=o196tThPmQLVGDdiKlV+/1DfAhqyJ8yuX29t4PmZeFzUv/8WZUEni4WK58gL3PxAZMmiAZ3JCqItBA1KN1z4uf5kTez3Iyzj8Et3/+q6ycDevRy2H493OtnK905a4un7HTVFhQmNTW4Pk0tcuGX1LsO1RerPV71ivqW/XVdP6Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865465; c=relaxed/simple;
	bh=I+ekrEE7N6hPPpVkdnOaxyndxVf84BdMAGWnGPhGJI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekCYqKb+gyTp3r4KxgD9udwaODEJkw5qS+n5GDvg4trPcd79tBG7iBXciTSeZOFm7ZIJ8MvoGOVEfOImTTOLfuj+yzfb+zUBfsg1uYs35ktzyfinY8v3v/YE7r06zmcTt3p0NHkjtz3PgJs+1f8agiZSVEeN3s3cny1NVDVev/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B627BVA2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725865463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W9UntbWfofaIB4YAjR4BroyGAcd6kcCGEM9YX8LZ1XM=;
	b=B627BVA24mT1+c2Pb0m4Mjr1AjNdb27yiKWx4dPENehHY7ziHnWZ1XI+UlXMTH7zHgafMA
	UfeGBbVqqXkQPSXU0n+n0KTbihV+JY2S+1OkTty58rPwBRpDHuAhOrXj50bfuyokGXNorx
	s/KpVkh1oVOC/FjL+r8ge0tU9wNEAQs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-hg_OK5OuP4iphcuggEDOfA-1; Mon, 09 Sep 2024 03:04:21 -0400
X-MC-Unique: hg_OK5OuP4iphcuggEDOfA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3789c3541e9so233979f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865460; x=1726470260;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W9UntbWfofaIB4YAjR4BroyGAcd6kcCGEM9YX8LZ1XM=;
        b=fgoKe4OhLurq7i5MzpIXGc9TxFuLBMkRsEBFiDKF4liq89NClHKfCCzakiMaRPq1WI
         ZB9LWy9Jmi88DQuvnwlQyPCdZAppB2CRdAirt9somrIo/I0i2uLRrHkYOotMCCufdtS0
         8HS3nZRsG20wkgpQEj8eyuYHH6yknsUT2nVAE+Lc4ZbjCbFDPN/sazVUQkeohvV+LoCq
         olqmVZc8wvhGQ8+MzwaiADhcfCYEZKImhc9nVxbfkfXaVf2n7EL/mDH+bSlBXYVMoTkh
         Wz0TpFbg0jzwcg9EtIDnTzNYH6mf8gYoQ8DYm57ZSK99yfYV8ePF9LSBfNstxGbOHPpF
         zqTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaZ7yexZ8wFVNELng7nIIJm5rz75DkVF5IWxDg2o7/YXXfTMYcgVzMZvQ5+yegX1ikDbrStD5wWHpi+TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/6dXQVJlVfNfp2oJY2uqcgk3Hbjh0N1YUp0/HINb/PXEw0bK
	Et5iCkSG8tF3ElKH50qsxandlhx2F0pv1vlgN7O/3G+orYtIB3ma2RXSCexEk23o8mKGRhCBWAZ
	VNrh5hDw+C+7WHn/KrjzErUHvrTP5HLUiON8+Tq7MWRg0sBJBeB3BMffAZgF3fA==
X-Received: by 2002:adf:e90d:0:b0:374:c1a9:b97b with SMTP id ffacd0b85a97d-378895c53fbmr4944117f8f.8.1725865460440;
        Mon, 09 Sep 2024 00:04:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKsksmYNMM04k9QXoV9gMeEmguq+XHVPA38dE0q3HAPM255o4T33Naj9QX5pZ2FR2FFOfi7g==
X-Received: by 2002:adf:e90d:0:b0:374:c1a9:b97b with SMTP id ffacd0b85a97d-378895c53fbmr4944058f8f.8.1725865459050;
        Mon, 09 Sep 2024 00:04:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:d800:d3b6:a549:7878:a6ee? (p200300cbc729d800d3b6a5497878a6ee.dip0.t-ipconnect.de. [2003:cb:c729:d800:d3b6:a549:7878:a6ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653d1sm5162998f8f.33.2024.09.09.00.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 00:04:18 -0700 (PDT)
Message-ID: <28bbd51b-cc47-4468-9523-45dab25d20dd@redhat.com>
Date: Mon, 9 Sep 2024 09:04:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v3 2/3] resource: Make alloc_free_mem_region() works for
 iomem_resource
To: Huang Ying <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
References: <20240906030713.204292-1-ying.huang@intel.com>
 <20240906030713.204292-3-ying.huang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240906030713.204292-3-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.09.24 05:07, Huang Ying wrote:
> During developing a kunit test case for region_intersects(), some fake
> resources need to be inserted into iomem_resource.  To do that, a
> resource hole needs to be found first in iomem_resource.
> 
> However, alloc_free_mem_region() cannot work for iomem_resource now.
> Because the start address to check cannot be 0 to detect address
> wrapping 0 in gfr_continue(), while iomem_resource.start == 0.  To
> make alloc_free_mem_region() works for iomem_resource, gfr_start() is
> changed to avoid to return 0 even if base->start == 0.  We don't need
> to check 0 as start address.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Baoquan He <bhe@redhat.com>
> ---
>   kernel/resource.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 235dc77f8add..035ef16c1a66 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1873,7 +1873,7 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
>   		return end - size + 1;
>   	}
>   
> -	return ALIGN(base->start, align);

You should add a comment here. But I do find what you are doing here 
quite confusing.

Above you write: "We don't need to check 0 as start address." -- why? To 
make the code extra confusing? :)

/* Never return address 0, because XXX. */
if (!base->start)
	retrn align;
return ALIGN(base->start, align);


And i still haven't understood XXX. For whom exactly is address 0 a problem?

> +	return ALIGN(max(base->start, align), align);
>   }
>   
>   static bool gfr_continue(struct resource *base, resource_size_t addr,

-- 
Cheers,

David / dhildenb


