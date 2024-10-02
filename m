Return-Path: <linux-kernel+bounces-348092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CF698E26C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25D528498E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE0B212F12;
	Wed,  2 Oct 2024 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLmxQ7HU"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1B1D0BA2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893639; cv=none; b=AwuOg7bhDve3bEV0/hOEdx29VjE5erzKfrAIN044yp7iFop1CbPORi21LfOAHqY1/hlvMUbc9bGrEvyLd+kitvTlyazRIp7i+ZTdwlh1JlviGrWRhXQhVEj0W3sO92Vg4AfmTIdOsvondzVSlrKkDWjXkPh8372MyP3UJsbMz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893639; c=relaxed/simple;
	bh=XdF7nHkSZZ13Wad6dzUoXmR4ktGP4yFIe/9lnQpVuZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xke1DKr8+nrn/RLls2JUuMY/+vykESFzorey9rhu8migtXt4cDAOf/Kfgy+vPFDfW0hAnAO6xOavMgyNtNnMUIdGJmRrgLET3z7MplyPQ/flII2baqjFzDJDbDTBMPOyfZ7/EIbd12bmgJO0DITt1fS4cjXS3jKAxXCqvfpQ5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLmxQ7HU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a90188ae58eso5991866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727893636; x=1728498436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VeyD8C4FvXwo0FLaCDBvuCrxOTWQzD59jm/41g8MBdY=;
        b=fLmxQ7HUY45dO49hO2uqlE97v3lsxTtIevhJRk4h0aOyisO5Gir4Fe7zJ1SSL/1sPO
         dUR0XAs5RwII5VreWRlAS0vwduPJm+OIW1Cj8Y1AJIoiAyY8GaNpGDuWzZhQ1e6rNFLH
         HVWRZMe6mrU1U0ssJBL4WOSg7A+mUQHrcfGOHripj69a4IsF7dKAwEJBFfrxCGErrCgc
         JPLvzbhPXSfrQ9xeKa6NSPjWIsOaV9z6FQ3yByKTI5CwsEALZTeRDIcZx1eyAp0ozEgi
         83HEc2Tsj/RAIxiJtawwuPWL4HL6d8qzqPEhciC0/tneF6OYLmhBmrhaflzGKzCw2McL
         3eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727893636; x=1728498436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeyD8C4FvXwo0FLaCDBvuCrxOTWQzD59jm/41g8MBdY=;
        b=TZjhS+gIhRJF+VfiMLL5G70T7v7nTCboPc7XZDr5k0P7s5KQePjK5RJCXTjuMp1Zrl
         wO7NO848dwd39WsAtWKxFrTJIiVtiQUMS//u0LmG8WgOdxE0/BimHcXg7SpjgZoIFyQ3
         m+yZ8KlyOwlCE/a278Fzc3piOBwqFCSo0Ho4P0sCpq/4aBJV73iF9QM7oCwWO30lDi80
         6/5PDqeIwLYdr8x673s5Kp7H3Q1G59u72Lu1mIM+k0NwVF4m3vXRb5mDFZ5GT1rN+pLd
         +vqKQQ1gogCqMPyBch1Jnsy0+MqeLZElIWcuV/bZO/RzyK7/divO8A8ZugYN8WjX3dID
         YqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGzwUGGMco4ypWFSkpVicLcqKTBXi3Vtxffjsbb+rTNL1RGoMQhHhg/SKVcc6rf7k1Pec8ahWQkayXRjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB29X4qndCs721+fl/FICp0kXfSlIS63MWnoSMA8zIJYGzGReb
	QM048sw3LUlMOGFCBiXh+f8Lk18SvQ0ADmz5acnCqS54HNaNik10
X-Google-Smtp-Source: AGHT+IHTSIjSt5+kq2Va3437ePosbnMc3AbvavYo29mtfo/HCGdVSaMSEBjfv7Bea7bUOomY1BUTKA==
X-Received: by 2002:a17:907:a4c:b0:a8d:7210:e28d with SMTP id a640c23a62f3a-a98f825aa48mr373675566b.29.1727893635890;
        Wed, 02 Oct 2024 11:27:15 -0700 (PDT)
Received: from [192.168.1.50] ([147.12.138.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c70dfsm905469666b.52.2024.10.02.11.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 11:27:15 -0700 (PDT)
Message-ID: <213a8a00-7ecc-4f52-a9df-7e2f9b1ff977@gmail.com>
Date: Wed, 2 Oct 2024 19:27:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: zswap: Delete comments for "value" member of
 'struct zswap_entry'.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com,
 akpm@linux-foundation.org
Cc: wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
References: <20241002173208.213631-1-kanchana.p.sridhar@intel.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241002173208.213631-1-kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/10/2024 18:32, Kanchana P Sridhar wrote:
> Made a minor edit in the comments for 'struct zswap_entry' to delete
> the description of the 'value' member that was deleted in commit
> 20a5532ffa53d6ecf41ded920a7b0ff9c65a7dcf ("mm: remove code to handle
> same filled pages").
> 
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Reviewed-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  mm/zswap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 09aaf70f95c6..c3e257904b36 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -190,7 +190,6 @@ static struct shrinker *zswap_shrinker;
>   *              section for context.
>   * pool - the zswap_pool the entry's data is in
>   * handle - zpool allocation handle that stores the compressed page data
> - * value - value of the same-value filled pages which have same content
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
>   */


