Return-Path: <linux-kernel+bounces-529365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C533A423A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C79444243
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F4A190063;
	Mon, 24 Feb 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2g6mToH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C32152E12
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407843; cv=none; b=Pg/x3gLdBCIqQAWb/b39oD6+AJLTVA6V5NOz4Ch98uhgD0O1HWzdpkHg/hpT2deKDCzQNI32x9KB/bMMsD92yoH43j8N3dHaJviTGmIX8XuMoKqbY6psUC6WC5iozw/Rmxr6j66e2bBXCDANLH/EiTe3WtsCwDxrso1By+rI64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407843; c=relaxed/simple;
	bh=jlphq0Jof3bRTJ7MBXqVmTTElhEpnSobrv7W4kpBGJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4qNLuIXc/I8hLd6aFENLeyXBT3Qb+0Cki2z0xSAj9C7zyvKAWhXSC6EPI997fmEsPqBykvhPA1OmN7+0qardOmh75TMb0BW1kYobzDvX4TrFeZdZbzMqZgZvx6+R2hxyKnwQeh6aiD+eUAdOWLdq0Vj2GOKNpOk2peGKytstZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2g6mToH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740407840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8cBqLVMO9KyDdhAhicbfLxQ0QgptAxHHChSiZfSWUp8=;
	b=b2g6mToH593YM38m1sC0RHaUA+BMAEknDcZMRlYYyi37atHt0jUk+UQhfa0n3DX/BZItMH
	hre9/naXCpiUNx4zR4DYUx2APo2kV7A0jnK5VLufOUbpBtBjqryBNPf2PcahrWsQHHpy/d
	RT2cKQmzbky75H0JK3oblJ0NuDAUYqY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-vtVIPAztP8q90WvDjEVOSg-1; Mon, 24 Feb 2025 09:37:18 -0500
X-MC-Unique: vtVIPAztP8q90WvDjEVOSg-1
X-Mimecast-MFC-AGG-ID: vtVIPAztP8q90WvDjEVOSg_1740407837
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43943bd1409so31707575e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407837; x=1741012637;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8cBqLVMO9KyDdhAhicbfLxQ0QgptAxHHChSiZfSWUp8=;
        b=eyrRpUZCak/zC5JdrBZPsPEeLekyFfB2OJPljzLgjUyVwaCl7T/ywjhkaf+XShoCF3
         VKEELNMOtxDz2FDvS4zWLIX6Ty1k68f8fx3DZHyYvR0O86Vp1wrOpEUVqW/hnTJkhm79
         PWXIEgd/7xCaLyPO+6Ta0ObzFaYHkK425+CEYJivmaYVZV5XNB4QSe+KYOzus8tpcuY/
         I8fTpUOeqaiSNXpDGHkACTisWXVM1i01kdJTK4jZcZNQ+7msCPXcehSKSgweAbx2r34v
         VMMk+P6yew+2606s4rkq5MdxWLZNPrXWAdIPhb0Pm428QozbTtO139k+Sw3irzMgFZCS
         Llhg==
X-Forwarded-Encrypted: i=1; AJvYcCULsHgTKq57xlkCOMlgvt3H8/Xrgpg5gHn/6T+3Cq4Q4iYH08wp293D4KEQEV0cTsRI/aWPuG2dcVkBoM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEB5T+gGrQl/t3j0tAs0yUXrOfKN9ApH9CSQSaOfr8pv8v5+KM
	mCXODmvyHkPmvsEj9fdOpWmPa3UI+bj+Kt2fmQ8Hh5PNEQW0oCPsoAVnNUOz43DE2joBvUVsbQF
	7bS/5lfeiF7oeJ2cRQVECBrNA7kpDgEtrcnGeIaaxu8MshwMTkLK6lfUGB3Nc6A==
X-Gm-Gg: ASbGncv2TsQlGwiGY30fPX26FlpHm1KXeZriVY5Y2UHomXwwLptW2eNTvllKtXD2PCd
	NdU9HMjfP1AKxvM6Jh4CKnLgXyxNu8KUyvVPh7+10OuAjJbV2w7bqPqi4iOfrts6CNU3895P2bH
	DFuJx4u1Mb1nwQPI+5zviphSxBs6OziQ2Grg02mVf8ojBIAVarRO0ZQ4jtQ3XRVR6+WDS99oHf7
	HL0iucmDnt1LZjFM5vDXuk53+AEMDWZgqsHAUjhKYL8wt2C1PCA7R4s28JWNYJRkmG2Q1tPGZf3
	mXz+C1g1t1K8Inujy4JD4AVHvVH3alu+RS+crTn1h5EjR/nmQ0z2oXXV5TwbsECKKQZ0NGH+MAp
	2+LnWzox7UlBnMsiOIU+LsvZN8Ms7DvGClYifIrui8Og=
X-Received: by 2002:a05:600c:4f02:b0:439:689b:99eb with SMTP id 5b1f17b1804b1-439ae1e6668mr111032595e9.7.1740407837354;
        Mon, 24 Feb 2025 06:37:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsgWIR7iUmkg5e2QIW4/Xk5GM1LXoMIZsAwAYVXVELaDEwSw/hfMUlejuAwccBjLpngSd3iw==
X-Received: by 2002:a05:600c:4f02:b0:439:689b:99eb with SMTP id 5b1f17b1804b1-439ae1e6668mr111032365e9.7.1740407837022;
        Mon, 24 Feb 2025 06:37:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc? (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de. [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b030c615sm108844235e9.32.2025.02.24.06.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 06:37:15 -0800 (PST)
Message-ID: <697ca5a0-174f-441e-a27e-6a1652235a87@redhat.com>
Date: Mon, 24 Feb 2025 15:37:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm, cma: use literal printf format string
To: Arnd Bergmann <arnd@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Frank van der Linden <fvdl@google.com>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20250224141120.1240534-1-arnd@kernel.org>
 <20250224141120.1240534-2-arnd@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250224141120.1240534-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 15:07, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using a variable string as a printf format can be a security issue
> that clang warns about when extra warnings are enabled:
> 
> mm/cma.c:239:37: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>    239 |                 snprintf(cma->name, CMA_MAX_NAME, name);
>        |                                                   ^~~~
> 
> This one does not appear to be a security issue since the string is
> not user controlled, but it's better to avoid the warning.
> Use "%s" as the format instead and just pass the name as the argument.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   mm/cma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index ef0206c0f16d..09322b8284bd 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -236,7 +236,7 @@ static int __init cma_new_area(const char *name, phys_addr_t size,
>   	cma_area_count++;
>   
>   	if (name)
> -		snprintf(cma->name, CMA_MAX_NAME, name);
> +		snprintf(cma->name, CMA_MAX_NAME, "%s", name);
>   	else
>   		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
>   

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


