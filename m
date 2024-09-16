Return-Path: <linux-kernel+bounces-330304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88243979C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C105284466
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F1E13D613;
	Mon, 16 Sep 2024 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="COUQRoBX"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F811411EE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473619; cv=none; b=OZQNfdyfa6XnYqNZ8tMf5bEBW4uaRzqT6EQkbsl+vz3wYYIMJCYhhwgMpq5OiU5s+KMmDBs4b4pDs69GY4LxZyg424DRZWWbIggQ2q4+/B+/DLCRhUTSgJI91sR3u3vBYPnuTDHI67x/2DbacSv6BZ5DhFFefHDXH36AxQnavYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473619; c=relaxed/simple;
	bh=bJcXbdXi/bBMjFx84WzwakUtCeMe/SHb2HmqPvKtDhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdxyMVBgw/+doUtE+sosOCVUoeN3xuq8QQXd1Zkn613x+Wsu1tpXKYcrDg+sSe3RjEDDTfYpaapHLycSf3qf+PeEcCYCr7gvBoW9X9826wF2g6Z73A/8Zg0g1S+PbrRkhTK+KAX4X+VymNnTw9SWMa2Yp+CeBKIbIk1rCfFHw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=COUQRoBX; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75aa08a96so41868291fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726473600; x=1727078400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qudf2MQ3UZQreuuw4+jXlv16vEaaWx0V0RrDsu0g1yU=;
        b=COUQRoBXB35m+pP4WNR2faXckZDal+QkNmmWw/KnXs6cHl67Cdhuv+ubK4Y0CBaxPR
         I2DTdIMHFp3rl7SVConXn7FfZistrynd73BUnRLEdzYJl/uLqnsUOQXg00/B/EnDbWZH
         wPYK7zugaRQkZffrGhI7j2QGdVK4iD5A83BAY9EFn+Rod2XPuGHqnb5Szcs7faESVMSp
         aED0gtbtYV9thwkCID65sm5tVAL4Gk161BjAEkhAx7YHAlMvKMsVKoe1i6yvC69Z96ht
         718yQrk+SXgQ8h6EKe1MvC7BOsKE+RW/St61pK0l3aKiNyCSvSrJkuMBoI46Nljh8V3V
         YMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726473600; x=1727078400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qudf2MQ3UZQreuuw4+jXlv16vEaaWx0V0RrDsu0g1yU=;
        b=wGPhq2qRPFbFXLlVXtl1ofLN6YR059a/n7peebCj/b/0KdeJh+9lxEYn5UTN2F6YXa
         mUnoTrXDA/6Rhtv3qHsoa/04ZZoQ9c2KTAVeEuYl6AA8TzIOH2/GGqT0vB8An4utfjhB
         N6NBUhjPIhOE9aATLCr5RL/IR/ECcI/56CoXU3dxsFnacdB7OpnDhWb5gdSBTzVj+8pL
         EHvHlojaX2aDplEl0aYRvtdDyqlHV3g2Wi5pt2dV7mamLsoFepwkPwKjcOJiakd7vf/7
         GWz87Zg44cAiRKatcJFNaaLCVWVOStRO3x7oRWDCUFLnoBGVZs4+PU3z5jqtTXuq2l4+
         dOCw==
X-Forwarded-Encrypted: i=1; AJvYcCWrracJ+hq8n496XSwLn3zypboA06fcA8r9+/Ir2/SRDeeKiP5sH5Psy/FFhXHy1UmLbjINRXvT8dBdqo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ZLfCbF7YnQLJ8gm/xENQijuXBn+2vgciXZLFk8iFKW5UfbnQ
	l+61dnKsOiNPnJwZy1aUmjkkT8YoIR3N96nrkaPQh4KKAFwJDhcDqpVPqmCp9w==
X-Google-Smtp-Source: AGHT+IHdIkWMQR3aesRlGasdjYBJwe3tel2LE9D2ZWT2mM68cxw2NsWVmqtGdan6xXJwpw0uQcQ4aA==
X-Received: by 2002:a2e:611:0:b0:2f3:cd4e:b929 with SMTP id 38308e7fff4ca-2f787f1cbe0mr55700981fa.34.1726473599876;
        Mon, 16 Sep 2024 00:59:59 -0700 (PDT)
Received: from [10.9.6.216] (vpn-konference.ms.mff.cuni.cz. [195.113.20.101])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89e1fsm2395943a12.72.2024.09.16.00.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 00:59:59 -0700 (PDT)
Message-ID: <d0075562-6a21-4a87-b7f5-854f09c0743a@suse.com>
Date: Mon, 16 Sep 2024 09:59:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] xen/swiotlb: fix allocated size
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-3-jgross@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20240916064748.18071-3-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.09.2024 08:47, Juergen Gross wrote:
> The allocated size in xen_swiotlb_alloc_coherent() and
> xen_swiotlb_free_coherent() is calculated wrong for the case of
> XEN_PAGE_SIZE not matching PAGE_SIZE. Fix that.
> 
> Fixes: 7250f422da04 ("xen-swiotlb: use actually allocated size on check physical continuous")
> Reported-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>

> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -147,7 +147,7 @@ xen_swiotlb_alloc_coherent(struct device *dev, size_t size,
>  	void *ret;
>  
>  	/* Align the allocation to the Xen page size */
> -	size = 1UL << (order + XEN_PAGE_SHIFT);
> +	size = ALIGN(size, XEN_PAGE_SIZE);

The way you're doing it has further positive effects, as the size
is now also no longer needlessly over-aligned. May want mentioning
in the description. Hope of course is that no-one came to rely on
the up-to-next-power-of-2 allocation anywhere (which of course
would be a bug there, yet might end in a perceived regression).

Jan

