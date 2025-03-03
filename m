Return-Path: <linux-kernel+bounces-541258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4146A4BA9B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B757E166D56
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6BF1F09B6;
	Mon,  3 Mar 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYstp4Pb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2911E9B32
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993451; cv=none; b=Sy1/yB7fTytrmeq+N41AoRJljZ5RUn2zSAIgvulYJAKWkmUgdcLULEGK9SB2fCS+U4iexWwQm7ZZw1RDYD3OAlTVbQVedmmrPfj8RNlJTbuCku43wV9gXh1hiVJpBC8xhzbTkk4nPs2nRTeAXLvorpu1LMy7gLXLHD2Pwog5hiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993451; c=relaxed/simple;
	bh=c3vGuDJXQVWUN1IGO9z1SkJ1yh0RjQwZFlMIfuF2kZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dZvog1LHwWpVb9RxwcaT9LffDxpn9nipYFnUR8vyuYawDQzJYIEnXTfKNT0clm9VqVINA4DN5H39/pyKjPqnUeFWZ+aMIJGspFz6nrWRfj0oNFSnSn09lXno5io5/mOnmh986VwDfFcXLbqJxkX3fqX1s7zZpz2i3neWBOJE0/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYstp4Pb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740993447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ug6PDHjZqZOZtfI1AtH5/y1/S7T0/8vlvgF54X+kceo=;
	b=GYstp4PbqP45tXF4z4+eDq4Kt3UH+vjT6vudXxgSR6syBuSnFEoUSz8AWD9CoLi8w0BVEU
	k5iW7SVNc/d2wsaZDX55+xfhaD/YfWjcfrPgHOjps4qbmKR+lz2zXRzm2JGuPUUQeCpoZi
	pJqwnZweaFYucPu+4FpE4yCYv8IgGbg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-I792Eu-8MqW63kRezr-_Kg-1; Mon, 03 Mar 2025 04:17:15 -0500
X-MC-Unique: I792Eu-8MqW63kRezr-_Kg-1
X-Mimecast-MFC-AGG-ID: I792Eu-8MqW63kRezr-_Kg_1740993434
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390f729efacso647433f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993434; x=1741598234;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug6PDHjZqZOZtfI1AtH5/y1/S7T0/8vlvgF54X+kceo=;
        b=Vbp1PzqL/IEJ2FwyFAmq2jS7DhjH299hnPVqbB9lYrN2T4MmiF0gHdn70ohSDJmfzs
         n7I8xy3xSFK1CxkhRnNCQqvPijKGAEnp/rEpUt2GYDYC8uvE0HBbZcjxpVU8qmhPEdpn
         YAaPWJM6hxqo5sU+MtNCo8sxbsIaeNS0jNqlmtY1Hhn4R0AFEATeN9y2bvlQQjTVmB9c
         1RQRYtioEtIGYmdqX3UXPsc/SXZPpedttP7uS/3Sli9dsOWkik3anb38WwW5D7cnzTeR
         ciLGCOZUJn+tLU6StCCC1WZycPlOYNd8COeWf70LPXBtR/6e/c/Q/FTRt73/Y4b/3XYA
         EzSw==
X-Forwarded-Encrypted: i=1; AJvYcCX0GxF2Z0kVUgDlyP1lYazPVEOPdc1WQV7mCnG9aZZ16mpkTwBB/Q92QpP7njka/Q4MLPMR2TvYIoyS4DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU1VjbKnmbrM/JH6xShNhTHDVNBV2LEYzPne7IMqFPqRbo7lMs
	1FbivCPIE7ZLwAHVBJZMLXHDSd64rBMJqvGe4o1xdmvqcIvErwFnymlOezGiao/kERbFEYfN98z
	cX0J2+e3f7Ju7AUQnpp5fKOedfOtOZ9rgmtpG8tQG0EWPHgaQUuCm8WXKQR7pbw==
X-Gm-Gg: ASbGncsuIImNX+96TZ/+AmyOTFilMXJv0ZDIet2HSG9tIC5d9/77SvpID53CtyqSEtm
	//I91ntiPIbZBiLVgKbvZbHU14ScdBBIAm9DA6yvMuD0aG1ssa9Y3gN92sTeQlBkj8U/aWAlbnt
	9oQJRvzo479xA1F2sxx6piEimmhZPfdVJVNheXozb9RYcUpUKstUWlLeHaSrl4VOtpJwJAX0dXu
	vINxSq7fF7jN/ueGK7ZDfOjG8Ijhu00knkxd8M2vF9Mn5fbrzIXwZTzO+sBpcjhmo/pfmX+QD0F
	9D5Ol3WnCZjxeN2EgmJZdoCZPFcjl4DFfdAnSnAg/wash7V+ACiU/xveGjbHFamL9pMo+f7GL31
	s0jhpmeW3tOqUpIluRND1DBcRddUnAGO41DEAmKKXEPY=
X-Received: by 2002:a05:6000:1866:b0:391:5f:fa47 with SMTP id ffacd0b85a97d-391005fffc5mr4077643f8f.55.1740993434188;
        Mon, 03 Mar 2025 01:17:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE51baowC1VpSwd3Tw1Mohl/fQPY43ZcoLesvTW+DDs3LlvAj1x8rHXqPyfJEGN/yGq/5lR9g==
X-Received: by 2002:a05:6000:1866:b0:391:5f:fa47 with SMTP id ffacd0b85a97d-391005fffc5mr4077617f8f.55.1740993433851;
        Mon, 03 Mar 2025 01:17:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d17sm13644614f8f.28.2025.03.03.01.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 01:17:13 -0800 (PST)
Message-ID: <f270bb5d-aa54-45d3-89ed-2b757ab3a4b0@redhat.com>
Date: Mon, 3 Mar 2025 10:17:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, suzuki.poulose@arm.com, yang@os.amperecomputing.com,
 catalin.marinas@arm.com, will@kernel.org, joro@8bytes.org,
 jean-philippe@linaro.org, mark.rutland@arm.com, joey.gouly@arm.com,
 oliver.upton@linux.dev, james.morse@arm.com, broonie@kernel.org,
 maz@kernel.org, akpm@linux-foundation.org, jgg@ziepe.ca,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-5-miko.lenczewski@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250228182403.6269-5-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28.02.25 19:24, Mikołaj Lenczewski wrote:
> If we support bbml2 without conflict aborts, we can avoid the final
> flush and have hardware manage the tlb entries for us. Avoiding flushes
> is a win.
> 
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/arm64/mm/contpte.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 145530f706a9..77ed03b30b72 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -72,9 +72,6 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
>   		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>   
>   	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
> -
> -	if (system_supports_bbml2_noabort())
> -		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>   }
>   
>   void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,

What's the point of not squashing this into #2? :)

If this split was requested during earlier review, at least seeing patch 
#2 on its own confused me.

-- 
Cheers,

David / dhildenb


