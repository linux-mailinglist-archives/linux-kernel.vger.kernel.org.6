Return-Path: <linux-kernel+bounces-360883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2CC99A0EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF011C2303D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1BB210C08;
	Fri, 11 Oct 2024 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXdq8yye"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97C210C02
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641575; cv=none; b=KJdDoFOJ9rhGP7vcnecjbGx99KGtbYLLpFjksydVhwNVbc+Ma18AR65x7NM3RlpIRpDAzG7NEd6by73Zfm0S+RXif4wK7R8tHuJhXbq4j/Z3kzo30zIG7K7wQlZFnuuWt8WBr/CAr8pLsP+nMkNO9/rVhzr4SRM6EF7LhmUUELo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641575; c=relaxed/simple;
	bh=ITyRor3JdJos1JyEAK2AGPCwGL2c54YEf1ZZbDL/aJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmH35DiegZluEMAibTz193lUUQbx2aVTF7pSGYtgGGJY1ZGzx8lsSMV8C2vJNju6x7w46PBE36tqXHsCZpjgieLu3B8AYuvrdKjnZ1jQ/x1oV1bbe01LLKEtIULbq9+2nfF1rrPqA2TEdKVrv7Dw+3RzzYzzBq6jN4Tn/KoWhVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXdq8yye; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728641573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WQWsLiswUAEolJ5Zq+g89OXnK9lDNhB/HZWV87yKp0E=;
	b=dXdq8yye7vvpG751rRYOg+ZJdILsjyarBxQMbb6w2/DuE7XEwRpkpPpTdGreGxATYXEtp2
	s9HEqjFXltKpknpeq1r7lMijH/2Nt1gGdIUA2NGwNYgaFRBo96KyZUTkcXP2gf97bonDYH
	1PHFhue9ylr9U/5SPWtm7vfLFTF23PU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-6NgT4uLTNDignpqHJW2_5A-1; Fri, 11 Oct 2024 06:12:51 -0400
X-MC-Unique: 6NgT4uLTNDignpqHJW2_5A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2fb3110b82aso4452221fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641570; x=1729246370;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQWsLiswUAEolJ5Zq+g89OXnK9lDNhB/HZWV87yKp0E=;
        b=XplCogOrDY7bc7b9g2Zp38wWP56K2Z6AU/eS4e/6nc/mQxkwWD7C41YPFOyvz+m2w/
         dnsZHC6FY52nnNvgTaqv0wdDQtQTKRKKuAHjJCeMDB7vgMm5kT48nyG0glDMLJqjlE9Q
         c+bZhFjS53gujxJ0qbRq/5TN6AqgC8hfPOWnYKiwoJRf8VjMoOhptw6gz6g4f5aARkFA
         h9lIa4XA7rz3x6a2yCpbTTK4x4hBHsC8SBJtgCjMXlzDsXsI3ryWYLUEfdphicloJSPx
         KJDvfB32SmcbTPXKvd64+/Dqs6tTMHEQEk+QhjFA456fITVDQXF4Z42ewBhtZmiFwVXP
         kKPA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ/++OPCKTYOHpVOYe+WMDpAN2VGp5rK3MJNu1yhdxiK9l/7qwfFNtyWQ/aj81HFB9T2qkc7E3fw7mkCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUC9wXI6K7pozQlGUiek+/3pgmuVMrKVZmVM+v7qd4xDiTtp0Y
	vAHypXny5E84C85uP1lY9Kg/cJFHLCHqf6GnGe7GBlrkzjQFeF+ajYyhEpS7fR0vcih3AGhrqPP
	wd0sHjnP5RPNpDj4GIc6KUBRjN5k/UeLbmBHv9cTMTaETZ3HRDa6vEvVIdg07vg==
X-Received: by 2002:a05:6512:12d4:b0:539:a3cd:97ca with SMTP id 2adb3069b0e04-539da50f0c9mr1054407e87.36.1728641570300;
        Fri, 11 Oct 2024 03:12:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN+eYs3u1dWQ+McbGmavTYymimZPrm22yBmTSLd/38O6XNRnZ0tYqOCLDaL1+Rkdsb4vOoxw==
X-Received: by 2002:a05:6512:12d4:b0:539:a3cd:97ca with SMTP id 2adb3069b0e04-539da50f0c9mr1054357e87.36.1728641569770;
        Fri, 11 Oct 2024 03:12:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:9100:c078:eec6:f2f4:dd3b? (p200300cbc7499100c078eec6f2f4dd3b.dip0.t-ipconnect.de. [2003:cb:c749:9100:c078:eec6:f2f4:dd3b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7934sm38293995e9.3.2024.10.11.03.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 03:12:49 -0700 (PDT)
Message-ID: <e894f6f2-d93f-4787-af40-7f021a40b156@redhat.com>
Date: Fri, 11 Oct 2024 12:12:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/4] cma: Enforce non-zero pageblock_order during
 cma_init_reserved_mem()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Donet Tom <donettom@linux.vnet.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>, Sachin P Bappalige <sachinpb@linux.ibm.com>
References: <cover.1728585512.git.ritesh.list@gmail.com>
 <8579f887412720bd6f2fbce513c1c9904772ead4.1728585512.git.ritesh.list@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8579f887412720bd6f2fbce513c1c9904772ead4.1728585512.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.10.24 09:23, Ritesh Harjani (IBM) wrote:
> cma_init_reserved_mem() checks base and size alignment with
> CMA_MIN_ALIGNMENT_BYTES. However, some users might call this during
> early boot when pageblock_order is 0. That means if base and size does
> not have pageblock_order alignment, it can cause functional failures
> during cma activate area.
> 
> So let's enforce pageblock_order to be non-zero during
> cma_init_reserved_mem().
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   mm/cma.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 3e9724716bad..36d753e7a0bf 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -182,6 +182,15 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>   	if (!size || !memblock_is_region_reserved(base, size))
>   		return -EINVAL;
>   
> +	/*
> +	 * CMA uses CMA_MIN_ALIGNMENT_BYTES as alignment requirement which
> +	 * needs pageblock_order to be initialized. Let's enforce it.
> +	 */
> +	if (!pageblock_order) {
> +		pr_err("pageblock_order not yet initialized. Called during early boot?\n");
> +		return -EINVAL;
> +	}
> +
>   	/* ensure minimal alignment required by mm core */
>   	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
>   		return -EINVAL;


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


