Return-Path: <linux-kernel+bounces-572177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C7A6C7B0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 06:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45D81B60ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 05:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BD91531DB;
	Sat, 22 Mar 2025 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrFFgi8V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A24C6C
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 05:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742620714; cv=none; b=L6ZHC5KLrXj3HQNgQy94Po73j6KjdrNbqrCr5LDjaJn8kM32c8sht1Va9hCWcxtx27yNl1bWSiXkAzJwqRkkt0LtesJ1Vq+Hfh/nMqJhyN1ibFXPXsrsspmTR9LWg0Gvrij2G2Jw3hrqUnvlgKzofVrlNWH+4gaEwwMxmNVNrdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742620714; c=relaxed/simple;
	bh=Ym8+X+S+TbRsSZ4gjQVsW+2Gciky/sDsP+68wMbfz5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CURfSIvgHDnr76NxJsK6keKm+UYd3/iTltZXsK9x/cf/d+n/bfewuXOpUNfxcEslzBCIdy9GwBWXvoq1dFNbeokjeSHwV/v90aq2LWizX8koeNYR6T+iKvHmTtP0llimPmvWz4IfxeShi6ROUF6pja3BccOm3X7SyxMPzzCLNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrFFgi8V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742620711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XTCmCxutqFfrzzoLad6xzCrVpxCx1WuivbcXCPa4GOk=;
	b=YrFFgi8V6ncLccUdoy7L1SCzmNDWsrKnzpMvKYX4I7xm0zd+hH6sDfea0YBUzdAOXV0Lj0
	Dxx19zw7/gDAN6ckjMVl5SOthDEUput7rknmffmC75mbD9dCx6tCYYYTxUEz9Ohm8kdhZp
	sQ+LtaSuFuffHAgtpEvPL8HWE0+Pk2Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-DwlHOtsPN1SNRiPKRV2F0g-1; Sat, 22 Mar 2025 01:18:29 -0400
X-MC-Unique: DwlHOtsPN1SNRiPKRV2F0g-1
X-Mimecast-MFC-AGG-ID: DwlHOtsPN1SNRiPKRV2F0g_1742620708
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d51bd9b45so6930325e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742620708; x=1743225508;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XTCmCxutqFfrzzoLad6xzCrVpxCx1WuivbcXCPa4GOk=;
        b=UMOjyyuBBc5KMhuYrY92sDkALUtPoFCS0eTUIaQ/zt614HHm8RyX+jppj/Bbv1+L1a
         r5rdg/rlyH6dc90JPUkDAciEqpkMYTQTrF/WkJReYuDkbEo1XCOFkXbGxSIt2mJ+g0pk
         R8xT4h+Nec63cYJkWBp9ecGRVBGOZZb/58g6YPwCnqloAiG3FTyv5+S1WiVh5c41uo4J
         AG7lFKM1ebosWk6vWH+a8jVq/8z/WorqjyrWvHuZLaVMAYWHgmnM9LY39I7gAAdDObgx
         vVd2ykVgYvGLq0FglU3oAO/NqbeMsmvrLzGCMBWOeRSvkl1L9awHnvJ6iyii9rN9JMRj
         264A==
X-Forwarded-Encrypted: i=1; AJvYcCW0Aw5MaxCdInb+vlYpgb9WOSaFuP350fmEegSdKDyH7XbrzWAmHb1j3+/02RcPNBAm9GqHzER++IAL9NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoF9AzZRlVYA3iZANcT0QPoCFa7tx+wb9JOSEwSos3/WaZS2oL
	dXoFcyVRzih+n5Jyp/WT5+Qz7RtJ+wyyQGEslspEVvJzXdPtWuPhUn6qGRu+pIkpCT7r63zCh5T
	9I/FYirzVT71uN72vKradjJyb5Pp3ZliZB9GUaH3lwNrGSMt6+qXcKF8Uc+mzWw==
X-Gm-Gg: ASbGncs7qwLaaNgnsSAUM83fIHv20Xhh40Y6+mARh306XSiGE/5aHN10afMkxMjEgSc
	D6MR8mpPDK1wt/PwtPgJ2S573KQkh9G3sr/uW4voDse1hfDELw0cZnHdz5Z+7K39zXtPiC2ST2h
	2LkxkD7/zhSGFRSUe7YvKedtoOvHwoWx7mgpp8urwbAcDhwZP3OXUK0rJvMLbCYedsbh/jiibtP
	yICLTKaKodStdz02n/niO49ljQOqc62c5zpfnSLmi/C6gRUU9okfWN58mmraqQIFlgtLpa7xu2d
	/O/0zMOd7I2Cu74=
X-Received: by 2002:a05:600c:1f8b:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-43d50a4a938mr58607095e9.30.1742620708435;
        Fri, 21 Mar 2025 22:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2YCyfrlPP3G8pShfgvgE8JMpszQjESi2Jtv/ETNYhFB8iJC5kL2lA56pxfuvgdT3ujjkBCA==
X-Received: by 2002:a05:600c:1f8b:b0:43c:f1b8:16ad with SMTP id 5b1f17b1804b1-43d50a4a938mr58606995e9.30.1742620708003;
        Fri, 21 Mar 2025 22:18:28 -0700 (PDT)
Received: from [10.239.241.125] ([88.128.92.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed4cbsm98232765e9.34.2025.03.21.22.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 22:18:27 -0700 (PDT)
Message-ID: <f5e08406-c5f6-4d51-b2aa-44cef2386de8@redhat.com>
Date: Sat, 22 Mar 2025 06:18:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: Correct the update of max_pfn
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
 mark.rutland@arm.com, ardb@kernel.org, yangyicong@hisilicon.com,
 joey.gouly@arm.com, quic_cgoldswo@quicinc.com, quic_sudaraja@quicinc.com,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com
References: <20250321070019.1271859-1-quic_zhenhuah@quicinc.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250321070019.1271859-1-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.25 08:00, Zhenhua Huang wrote:
> Hotplugged memory can be smaller than the original memory. For example,
> on my target:
> 
> root@genericarmv8:~# cat /sys/kernel/debug/memblock/memory
>     0: 0x0000000064005000..0x0000000064023fff    0 NOMAP
>     1: 0x0000000064400000..0x00000000647fffff    0 NOMAP
>     2: 0x0000000068000000..0x000000006fffffff    0 DRV_MNG
>     3: 0x0000000088800000..0x0000000094ffefff    0 NONE
>     4: 0x0000000094fff000..0x0000000094ffffff    0 NOMAP
> max_pfn will affect read_page_owner. Therefore, it should first compare and
> then select the larger value for max_pfn.
> 
> Fixes: 8fac67ca236b ("arm64: mm: update max_pfn after memory hotplug")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>   arch/arm64/mm/mmu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 1dfe1a8efdbe..310ff75891ef 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1361,7 +1361,8 @@ int arch_add_memory(int nid, u64 start, u64 size,
>   		__remove_pgd_mapping(swapper_pg_dir,
>   				     __phys_to_virt(start), size);
>   	else {
> -		max_pfn = PFN_UP(start + size);
> +		/* Address of hotplugged memory can be smaller */
> +		max_pfn = max(max_pfn, PFN_UP(start + size));
>   		max_low_pfn = max_pfn;
>   	}
>   

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


