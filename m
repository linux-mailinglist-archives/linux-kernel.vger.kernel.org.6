Return-Path: <linux-kernel+bounces-330261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24836979BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AA61C22874
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E424D8C6;
	Mon, 16 Sep 2024 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cWhI2bw0"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2753CF73
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470101; cv=none; b=Ny8mGCovdX7i6/4WKB5J+gcIhpaHEsnNWaeFd6e3plKUn/wU1TYajLD0+68GHq1c2Fk9BdqnNbhfA5qamWRwR3Aa2OiaRhjUsFpJAYAEarsIbOJeYnpSPehgilQ3DerOfHnpoqLslQch2f9t8qTI6bNVvccBHa9teUIZ3znPJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470101; c=relaxed/simple;
	bh=HAIqkvoRzle5vIm/45KlUqIQro3cqaxEZuIn2gdLHDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqY88GgOguz7bnkb6wFwdFczUQSHeCG2ivFkbdTNnRmf6APTBtYd/B+bIuqrTv3Ux9H1BeQK5yiHYPl3s9ilaZWP2TD7udxX9ongrajNNFtbs+rARRaVqSzU51ASNFs2k5DBlS/4/Qo/5FbgDb6BSLPRFoVrGaNAf8l9oPMdVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cWhI2bw0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aa086b077so489772166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 00:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726470097; x=1727074897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFjCBoKriiG3bsVxWjcbX/7DjM3PloTt4D8ntNKj6ak=;
        b=cWhI2bw0ZZ53ecGHzdylw3T6osPMl/tFVW6IJjV7JBQS+YgkpfWAkr+ia0nj7kXjMN
         Xnv+P43KqB6XB7h8tJi8dIJDGoBjTh0THmkyjtWm0OGb33T/3bGgg1PhGvtlUDD0Ac9F
         +myWEetTw5LRgLJrGRbr80+LIfSnGr7Sc/+lWsIAEA3umXhzR++KQD88CzUyI0XDLySM
         g4cMoW1C0fBeXFhLjJiIjC9kzJcvKMZPY2T2vZGLtSDfL3rnEprnPYuotwQdxL6H0FBh
         Dkf+7/ABvG1ilKGq7ZzaxnnZ6bqd/vDiDeXpr+RiEo71FI4vFWim83mrBhueS/X3rfbl
         jJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726470097; x=1727074897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFjCBoKriiG3bsVxWjcbX/7DjM3PloTt4D8ntNKj6ak=;
        b=jpEF7rrM1bRB8kF/2/naVt+LCQd3VXrcBXDuzb/0viG/wk12LYZAU0U3bkoeBI5BDs
         sLn+o4ClvyqhgDayzc5wn1zqeNQLx0v5N7qgAv4ex2Dtwo2A90azaITsHO1sA1yqxGDf
         a6R8/7Rt+ggKUXoeex89Lw66gJjlGLCfZQt1NvvUBW59DnNTZ7ZeFwcf+5GYC07NsFkW
         d2sJZ6g60UxaLXWlNytQymKNvzYvcEECfatxjD9vQbwatIAbwo2aZWwoYpT+8w2i6WNX
         qf2avn4mJegNLUNpYES+AypZ8RNF2YlWjk8ZKPqxHa4iwqYvTeoiEghly41QDxBLCskl
         o9kw==
X-Forwarded-Encrypted: i=1; AJvYcCXhPVrPzHdxRu6fP9OBOhVaaAqjO1I/q93QPNczhL7QzVH/pcDLuDwqX3xcGPqABXZS52oeFNbHhpMmJsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhH7uO2V0GcLD2/+mk87Ds0+IplWhspW5KKsm2OETBVkQiOHoC
	V4tI7uzqIiUg4k6GcLppNjgL5AAQgDGG7M6TDI1D0RRvtWv3dCz0qWenVy5NAA==
X-Google-Smtp-Source: AGHT+IG2H8XqbpT8Q3ZMJfToOCB+0WLbtHpvn+Re7pOlLnWqXMfVhKg8+cfsUhl+CFlcLBPYX2i4zg==
X-Received: by 2002:a17:907:e26a:b0:a8d:6329:d8cc with SMTP id a640c23a62f3a-a902943b52fmr1392161066b.25.1726470096749;
        Mon, 16 Sep 2024 00:01:36 -0700 (PDT)
Received: from [172.31.47.100] ([193.118.249.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061321568sm268978266b.191.2024.09.16.00.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 00:01:36 -0700 (PDT)
Message-ID: <c3a52494-7ced-42ec-8839-11bd18a7c3d9@suse.com>
Date: Mon, 16 Sep 2024 09:01:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] xen/swiotlb: add alignment check for dma buffers
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-2-jgross@suse.com>
 <d23c9af4-4a79-4300-891a-fba3ea9cbb1c@suse.com>
 <c2dd89b4-46c7-4a0a-a47b-70862294176b@suse.com>
 <8866f8a6-e42c-47d2-af6f-c4bdda5a358f@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <8866f8a6-e42c-47d2-af6f-c4bdda5a358f@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16.09.2024 08:59, Juergen Gross wrote:
> On 16.09.24 08:56, Juergen Gross wrote:
>> On 16.09.24 08:50, Jan Beulich wrote:
>>> On 16.09.2024 08:47, Juergen Gross wrote:
>>>> --- a/drivers/xen/swiotlb-xen.c
>>>> +++ b/drivers/xen/swiotlb-xen.c
>>>> @@ -78,9 +78,15 @@ static inline int 
>>>> range_straddles_page_boundary(phys_addr_t p, size_t size)
>>>>   {
>>>>       unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>>>>       unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
>>>> +    phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
>>>>       next_bfn = pfn_to_bfn(xen_pfn);
>>>> +    /* If buffer is physically aligned, ensure DMA alignment. */
>>>> +    if (IS_ALIGNED(p, algn) &&
>>>> +        !IS_ALIGNED(next_bfn << XEN_PAGE_SHIFT, algn))
>>>
>>> And this shift is not at risk of losing bits on Arm LPAE?
>>
>> For alignment check this just doesn't matter (assuming XEN_PAGE_SIZE is
>> smaller than 4G).
> 
> Wait, that was nonsense.

I think it was quite reasonable, as long as also algn (and hence size)
isn't absurdly large.

Jan

