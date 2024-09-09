Return-Path: <linux-kernel+bounces-321922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE6797212E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99AB1F253CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73819189F42;
	Mon,  9 Sep 2024 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhLDNHS/"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE5017ADEB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903415; cv=none; b=ofvW/dUTxS4Lt1Ux4iJiQMqoq1FzM0Tc8L7pWK4mMsBmi+jqQWfTpZxzU5nuXBsujdHMduIPQiM/zZPVcpzVY1kVtVhrppP5Ujq67aGdk1NoUX1SmiohcoXOK8Vlz7Pxxp1VC9kMqRQeMB/EpP6kgVQesv4VDFuPaAmyC/8cyBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903415; c=relaxed/simple;
	bh=MTxKqsw5IqC4HqkVbXDcQ1y6sW/Td5RdD7+PeHVBnWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nouDcnwCXQ3xX8isL0nLtyvKpXIm7lQEnu3F4vOWSrJ1IsJW9KzR2oGMTVjgZHImLpjjGFyKBDMDfpb5Yp0U+3Dvr+qkUhEex/A9I1qy6YqFa4rzbrBgO9gU/UbfYG8S1EBxumePJmZ0krKPVMEi3srSGQyqz9IdruTOmjLtxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhLDNHS/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so18739335e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725903412; x=1726508212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=edu62SKFx/YpyglOioE6A1hLunOx30kHckG0mJ2Eplk=;
        b=NhLDNHS/O4Qk355Nu0acgtonAtf6UPLWlO0+I+jhEYnAAJzwJYc/b81dvDyuGW0NK3
         izVNXyEr+jvv83vAPXEWaPLoKewJwPTKxA7fY/4bwSW6qsQqScN2gVfZ718oZt+uV3F9
         Z8BP6bhZO0ij61pPWkMUBvpgWYjRG14L5/hP8rthpfD8iCHJIavPYziy2tMeKTGS0Fp3
         RveDXjLrIYBq01AZxYR5GHTme9puYxv6LUFyoZsyooDacJ9oS4ItUqdyrm5xgBNh+AxW
         42VjB/iof3ELlUznBTv4lwQDAmyTM07COmZ60uUzlhk4LViw8BLELhpyBY9PXd3R+U6E
         fUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725903412; x=1726508212;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edu62SKFx/YpyglOioE6A1hLunOx30kHckG0mJ2Eplk=;
        b=SJYrw/tp0RltWgo9Qx8rxMEDvabqQoYSBXkqjVqqDgPADpY0zUPO3/DylUxcTI+WFY
         5QktFELsyRfxCvkJxxOTC/iiv87xDDw5KJ9J3GnjEx7AGtowiK5opvaMNn2CM+o02V/F
         uy5CBHwEpukO+S1QAhKJGdv6HXbap5uaCL/9E4fLF1Pzh3qjaI6Wdg+3h6pU/vhkBljT
         WL9YRuppAJ4wXq+33GCXZEjvoroiUIuJcXXee7wLNjfKpR1kdT+S275y9xYvZYGrj2w9
         z6vMmB4fITPI8ro+UMi3UjBYEoeaxz9g4CfwPuKiYENv51TikpWZ/H4F39vObuW5IyJV
         T0ig==
X-Forwarded-Encrypted: i=1; AJvYcCUGds9ILCKOsHk6j00ouWR/T2vvNtGLo8/WkWOS5+i3eYgWMaLgrb3VallxhzzrJ8DaCa9EHM9SojJ3u6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqo6Wsvmm7rA54FxCF5Fbqm3tPTjMr4XC0gw56GZxdkEILdbHh
	z9rhJe6zNm3iayhgsggKUWXaHKUPbVL6BsLGnjuM6Sn66IiAJZr2rnNj48JL
X-Google-Smtp-Source: AGHT+IGrv5H+Lpsi965fERLzo//PdNn+OI+QnPSNR7zzAfkc9COJPnDwsUHRN5xXW1Kiu0i+PmDaJQ==
X-Received: by 2002:a5d:5547:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-378922b690emr6684131f8f.24.1725903412165;
        Mon, 09 Sep 2024 10:36:52 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8598:2e4a:77ed:cf1f:2f2b? (p200300c78f2a85982e4a77edcf1f2f2b.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:2e4a:77ed:cf1f:2f2b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ceb1ffsm373610366b.146.2024.09.09.10.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 10:36:51 -0700 (PDT)
Message-ID: <0de6807e-c6d1-47c7-8f01-000800880c7f@gmail.com>
Date: Mon, 9 Sep 2024 19:36:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] staging: rtl8723bs: include: Fix spelling mistake
 in rtw_xmit.h
To: Roshan Khatri <topofeverest8848@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240909041352.2392-1-topofeverest8848@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240909041352.2392-1-topofeverest8848@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/24 06:13, Roshan Khatri wrote:
> This patch fixes spelling mistake to increase code readability
> and searching.
> 
> Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
> ---
> v2: Created patch series as suggested by Phillip
> v1: https://lore.kernel.org/all/20240906141024.10021-1-topofeverest8848@gmail.com/
> 
>   drivers/staging/rtl8723bs/include/rtw_xmit.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
> index a3b4310caddf..544468f57692 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
> @@ -15,7 +15,7 @@
>   
>   #define XMITBUF_ALIGN_SZ 512
>   
> -/*  xmit extension buff defination */
> +/*  xmit extension buff definition */
>   #define MAX_XMIT_EXTBUF_SZ	(1536)
>   #define NR_XMIT_EXTBUFF	(32)
>   


Hi Roshan,

something is wrong with your patch series.

When you look here you will see it is not a real series:
https://lore.kernel.org/linux-staging/

The command I use looks like this:
git format-patch -o ~/Documents/kernel/patches/ --cover-letter -n 
--thread=shallow --to="Greg Kroah-Hartman 
<gregkh@linuxfoundation.org>,linux-staging@lists.linux.dev,linux-kernel@vger.kernel.org" 
74d21cf6062fc65c61ca2c91b81a3a98a646a4f2^..HEAD

Hope this helps...

No need to call may name in the change history.

Thanks for your support.

Bye Philipp

