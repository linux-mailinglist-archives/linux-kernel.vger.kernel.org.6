Return-Path: <linux-kernel+bounces-330250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32142979B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F271C22E59
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207381AD2;
	Mon, 16 Sep 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bM8LXC4/"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8386F305
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469463; cv=none; b=AXFAjGg1MJYksXSWVaVi36T5NP2XX/LyBtYxGXixgZAMMP++48EJfPAu2HAlDb/f6+X4KXtG0wcuTmo3PawfHQsT5zpSs9qmqNo0lHEFLBNg3Vf461w/9Je46ks7rw08AALJUrCottM+lmqgbb0okRsBkYz1n1hOJ3pdqKjGI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469463; c=relaxed/simple;
	bh=vqx3byxzt1bdXTwPL8aHobPNsSNVoaxtI2qJmsNesYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1aRNKgPnJRfvsAEXN3PE3mudkMk+c4coUmyFAttsOH16DKhy0VK5XpSiUqyqhQCgN8+eM9cQmuEXjx/NaVxMKC5Sxdh/x1HaWj4472Eu6U6ca+nl5RAL+yuW8b6yLhwLj6V0dcFgAHmkCNf7H/3Y2LpLUqLWUF0bedxnuyx5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bM8LXC4/; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so32210491fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726469459; x=1727074259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPgpIAwUtRjyGXaz2UWsyQSvP3nVeWuucx2LpeEpAfE=;
        b=bM8LXC4/pV0DT/Srle87cGinIP/S+hXeQm3/SGt99x3Htbt2SBnsyhKRNeO2kWimUv
         QcOsHyQGPTcj66T8TP9TxlHM7kiVNVAeHJu0JXfV02SA6f7eZqk0l9PlBWUmBzNu8AUl
         ljPEfd/D+vQZXrwukXpQnyc15LLf5O6zBomPXBsAZ8AU79ht5grPE7SdFkw2Dd9A+TSM
         UaLyNjGYItzBWvea2kgWkQ9XHA2l3CSC3IMvVxPrYC1krBLjdzqwMto2W5zy/7HZYOdc
         QEPawM4XvkZlSiar4u8aYeJWKWb3Gszn4WBjLbPksn0ZYMOwk/VJIsx8zRHGRA/LCiTD
         pSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726469459; x=1727074259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPgpIAwUtRjyGXaz2UWsyQSvP3nVeWuucx2LpeEpAfE=;
        b=P27PTwAqgqboPygIPj/XyJtc6hGPn6M4iUwQdrjC/f+GPdFtAdtg2nHbQWcXwFnH/a
         kiAAhlJCauIgxgzIezNEos3FoDc9NYsfRVE1BV5YUneDtmIvPheVBaUjr/X8ikEIb6Oe
         zN8zJjMURmk2mFcNn1gcXI8k3XSIqk/f9vLqXb+KxAjHmEIunSpHSeKzDLuvht5+E1A3
         tjWMTZgS7EKUR7hjxmy26cGc9zuNhO0XmRKqERR0QaGaFQQxVeZllYvytG5H9lGA1czg
         g659TnNxqoPXWTG8AAObnDDw5Bby/+4hHIE4m2Y5ZtnNaBcA34ql8U/LA+71pWoUmvnp
         r/7g==
X-Forwarded-Encrypted: i=1; AJvYcCWk5e0OaHji6hDJTZvCIjPN4a3U9V+KDtNgSN/Y0yh7Z+xSzMsGCiOKeZ8X/PMJvi0qcPk+0cD+gUAS30c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmjt/CZ4rorz/s81vNUNU0cgmqEQkPKJbOBbznz0BPi9QtwfhE
	87S3UgB7hJ2l57tGRFheUdf8/IVyJgQYY974zEaXx0VbSfjW4n3w91ZqZLfE3w==
X-Google-Smtp-Source: AGHT+IHdV1TNRmBScApbJF/19sNrIq7EW1xqWRb7LFjySq6rhBb9plTuYbfalnfxPg2RJC3tI6SHDQ==
X-Received: by 2002:a2e:bd12:0:b0:2f1:67de:b536 with SMTP id 38308e7fff4ca-2f791a04b9fmr61395021fa.24.1726469459276;
        Sun, 15 Sep 2024 23:50:59 -0700 (PDT)
Received: from [172.31.47.100] ([193.118.249.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f3883sm271634266b.50.2024.09.15.23.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 23:50:59 -0700 (PDT)
Message-ID: <d23c9af4-4a79-4300-891a-fba3ea9cbb1c@suse.com>
Date: Mon, 16 Sep 2024 08:50:58 +0200
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
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20240916064748.18071-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.09.2024 08:47, Juergen Gross wrote:
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>  {
>  	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>  	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
> +	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
>  
>  	next_bfn = pfn_to_bfn(xen_pfn);
>  
> +	/* If buffer is physically aligned, ensure DMA alignment. */
> +	if (IS_ALIGNED(p, algn) &&
> +	    !IS_ALIGNED(next_bfn << XEN_PAGE_SHIFT, algn))

And this shift is not at risk of losing bits on Arm LPAE?

Jan

