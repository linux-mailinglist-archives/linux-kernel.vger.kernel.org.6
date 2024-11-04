Return-Path: <linux-kernel+bounces-395601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A06C9BC056
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA931F229CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01AC1D54C0;
	Mon,  4 Nov 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LWArabD+"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242CA1925B0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757121; cv=none; b=Z45Vi9HmM9vYU8tUT6jk/JiCiCOgO9W53liVLQ4JK+pqntdn5rVvNhQVubsnEaiorcwrgCGcTxpJRjxBawGRHv5EbPE+dhEBecm0HEuK2wml4+q3ijHg6FvRCvuf9yUorI7759W/cFOA6TAaHRE+eZhEOqZNZrjljOjXDIh+63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757121; c=relaxed/simple;
	bh=UsiBc1g53sq+K0xqyImn41o5l2118hJKKKhUPiwFY6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRBG/ysydv8NknUaKuNnhBRkmGSKS0MNnh/89WbUaic6UhsNNn4Csc2OU1ANezY1aKo43qOSs8D1ZoWL2/yF8ELDBetCAEwurw1XTkskXnHGbd5tV99CxJeW/4PfZvPhHY8UCkklUzlBDk/xRNOGiON37/bq9mgZ+P7AqNzTWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LWArabD+; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83a9cd37a11so186055739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730757118; x=1731361918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3V3t06tAcIBFTGvKOZbL8ly+O9NdFQ2GFTEgezZueso=;
        b=LWArabD+pj1ezYDQ3NOeq2dOl2b6KA5J4o8y5SoXh6p+5IXjeZ/yCp7kHVzyIbkS90
         xSEyXCJmcgR1hc5qyn+r9BPjyp/1H9bRwohoxeRRH7DbmaUnCoCZk2ikZGbBN2G77rQ9
         /rMQBEjPvNizRYq5JoxrYup6HYX3kU6iNKGu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757118; x=1731361918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3V3t06tAcIBFTGvKOZbL8ly+O9NdFQ2GFTEgezZueso=;
        b=KdOf9uqrYnIU5FKGe3gCV7GEcG2qOKKtn6fJE6Jfo6e7w3KIp2dPEI0d7tHEK6faJc
         cVNJbqVTlW7td/X6uxKNmOimPXBsLOqb+xM9QXVCeQzzPghbBRetxnudFnjevYKE83q+
         hTHvD8jhZGO0rURnJdRxQ5swuBw6wPZb48nJ+q/2OriSrQSoZ5ceSGHEypbAvx22CHax
         KNHft/AzT2zbpvhi5yHkStgsxIq/vmpmGPJjpW1UwaJsNvMuUBIX21oSMUmQI0B/YmZF
         Z0ewlJK37Fvljm8pAh1IxdC9FDDle6bdqyz9jc4cKDzPw7+IH5TuvZrayIGlNzSyCpTZ
         fhag==
X-Forwarded-Encrypted: i=1; AJvYcCXBhgeM5Yeg64Z9gkcuSrTZkMifSp6GrK3x5d1r3klFyR9XXN28kAg/3vrcYVpVeMll2/1oORPsskmEKPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dbQ7eD9wO72LoogLNDZgCYosjM/eieYq2B2olh5HSrvrHNKK
	pFw69JpmNkg8avnRjLRyGVj5j9/RNOitONsdZjU9KAMDBDu08k1aJi82QL3bypE=
X-Google-Smtp-Source: AGHT+IFP9aXJEqHwR2wuVf4JYtqpech/vN7YFiF50djAXb6OhhwndHvwXMCJsUuSMdtnvOdMXSCUGw==
X-Received: by 2002:a05:6e02:1528:b0:3a2:7651:9846 with SMTP id e9e14a558f8ab-3a4ed295a05mr365210515ab.13.1730757118227;
        Mon, 04 Nov 2024 13:51:58 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6a97b009csm25308285ab.4.2024.11.04.13.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 13:51:57 -0800 (PST)
Message-ID: <3c347f99-485c-453d-9b9a-9924abf1e868@linuxfoundation.org>
Date: Mon, 4 Nov 2024 14:51:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
To: Karan Sanghavi <karansanghvi98@gmail.com>,
 Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241104-coverity1593397signextension-v1-1-4cfae6532140@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241104-coverity1593397signextension-v1-1-4cfae6532140@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 11:34, Karan Sanghavi wrote:
> Explicit cast pc to u32 to avoid sign extension while left shift
> 
> Issue reported by coverity with CID: 1593397
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
> Coverity  Link:
> https://scan7.scan.coverity.com/#/project-view/51975/11354?selectedIssue=1593397

Please include the coverity message instead of this link so
reviewers without coverity accounts can see the report.

> ---
>   drivers/ras/amd/atl/umc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> index dc8aa12f63c8..916c867faaf8 100644
> --- a/drivers/ras/amd/atl/umc.c
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -293,7 +293,7 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
>   	}
>   
>   	/* PC bit */
> -	addr |= pc << bit_shifts.pc;
> +	addr |= (u32)pc << bit_shifts.pc;

How did you determine this is the right fix and how did
test this change?

>   
>   	/* SID bits */
>   	for (i = 0; i < NUM_SID_BITS; i++) {
> 
> ---
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> change-id: 20241104-coverity1593397signextension-78c9b2c21d51
> 
> Best regards,

thanks,
-- Shuah

