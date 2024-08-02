Return-Path: <linux-kernel+bounces-272143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829BF9457BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05F87B23531
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5D34778E;
	Fri,  2 Aug 2024 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUHHBdNn"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3AD41C79
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577552; cv=none; b=DE0KoDcriwaPgcRfP+H+m+a1erlwDYzVGzuLhFc1zGMHXmfHeig6lilGufz2s6tUWVgY+4OF0G2l7bJQv81iI8jZr6GQlFEA44XNvbpDOHPWdFLDsbBU0QGP+Pu/zxNHCfPoiQ5JBKnpZ5VutmXrVPlr6ixzdnowLSuwh6pXp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577552; c=relaxed/simple;
	bh=Q0yAB9fGL/5NiS6EFNSaISF6pHTBZkj0KtQmn+C7hc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LouI8uDlyAG6Yljh2OAQvMjEVB79ZQ3F/+6pVk9uhIVhwoedA89MJu8OR49cUtQ1r92qclJMsjjRDE01B/mmckZyHRqi4LHSYkp6c4poOwUr1dB6Zqd+364tGR3fV25yc5T4LghyI7A2e/R2flKT3moLFkRLDcrRVj1YH/KElu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUHHBdNn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a920d2eb7so95621266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 22:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722577549; x=1723182349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RigXAXY8XojMY0eL40pCCW/KOV/0idGGpOe3OTx1b1k=;
        b=lUHHBdNniT1rlmjYSPrYc2PE0EAnWlwV1qF3iWDeydzBXilAsQx+d33cvYXM4a1PWq
         qucdGz4NXSba4L1lv4Sk2ZPpbmvvtChh+glkjK5bsEgjGlhJ/rs3Ywe7tujJ3/6Jdizl
         zdFu2ADA90hUeU1u/5hC2yvNGNW2ol2XEBXqS6s0ys20N+xpKbsD4KIclpCOScf36ofK
         25FPYWTs4L1uSSWfd7pKqfvpe5mmFPK6CoaHcH/qSd4ruGAZr4pA65+6NZaa30Ug+MeO
         oJGPenEYR6HpkRLYiptKN/Clq9InfY9H8o3I0wdAvbm6b+3uQs52mEeSUTqUVNBd3NsH
         KfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722577549; x=1723182349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RigXAXY8XojMY0eL40pCCW/KOV/0idGGpOe3OTx1b1k=;
        b=I6pLQq2aPoeIIN4NI848QvHlUeKVNfAFpwNNn1BzAI6x+WoLy8KjAzal7UzzL/JyLt
         uWHgQA0Frd9UvZ4Q16gfHRduonikPNjTADKaeMTO4Xfp/42d0VFOwAsmBKuHsRm/trW0
         g1mIVbsxo21Toau2plTGPI1svJPpF7lk93epnu9iwVPbyD6DeXktksxdcugswrW97h72
         kdwsKzI6ULLDVcN0aR4yQvA/DjWYlQcI+djQUCLmVE0ziaS7P9GAPJHoXyg7oEYddW53
         mrd77jIdot5Qk4GG4v+mmDpEgRCg3fU6FwuxMZATEggV1arb/p00a13em2xQsIBgt2CR
         CQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg3fIYIrqB+MsZx1Hf65Gg+xqZfFjh2j3v7k+M0cGmrZn/mFXWnrHDKw4Lf8udhG+RoprbhhmvBXP6G0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSLU98i4ENqE0D7LuwGPdX90Ndi3ltsRBOwE20zK+duXEM5FNj
	xNP/okhfKnq01UmTUrxWxIYi3rRQ5xotVuFfNjZowRXiXFhFx6oE
X-Google-Smtp-Source: AGHT+IFgVJrNhR4s9Ifa9W84XRJ00zIdgSl9ZMABKuDHEC/LVng8I81ppLHgXW4oIaKDH20HoC3JCw==
X-Received: by 2002:a17:907:728d:b0:a77:c825:2d0f with SMTP id a640c23a62f3a-a7dc508d453mr118562266b.6.1722577548892;
        Thu, 01 Aug 2024 22:45:48 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8543:bb0e:65aa:14e1:2135? (p200300c78f2a8543bb0e65aa14e12135.dip0.t-ipconnect.de. [2003:c7:8f2a:8543:bb0e:65aa:14e1:2135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc9dabsm56084066b.39.2024.08.01.22.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 22:45:48 -0700 (PDT)
Message-ID: <e4308685-bfd1-4795-bcc4-d2a246dae0c1@gmail.com>
Date: Fri, 2 Aug 2024 07:45:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] staging: rtl8723bs: Delete unnecessary braces
 for single statement blocks
To: jiwonaid0@gmail.com, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240801155138.25531-1-jiwonaid0@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240801155138.25531-1-jiwonaid0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 17:51, jiwonaid0@gmail.com wrote:
> From: Jiwon Kim <jiwonaid0@gmail.com>
please omit the previous line as it is not required.

> 
> Deleted braces {} for single statement blocks.
> 
> Addressed scripts/checkpatch.pl warning.
> 
Please do not add extra empty lines in the description when not 
required. Consider that we have a lot of commits and it is most wanted 
that the description is short.
It is not required to add the name of the tool who found this, but it 
can be named. Much more important is a good description why this change 
makes sense...
For example:
... to shorten code.
... to improve readability.
Use present in the description. So Deleted should be Delete.

> Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
> ---
>   drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> index 1eeabfffd6d2..e0736707a211 100644
> --- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> @@ -144,9 +144,8 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
>   		psta = list_entry(plist, struct sta_info, asoc_list);
>   
>   		stainfo_offset = rtw_stainfo_offset(pstapriv, psta);
> -		if (stainfo_offset_valid(stainfo_offset)) {
> +		if (stainfo_offset_valid(stainfo_offset))
>   			chk_alive_list[chk_alive_num++] = stainfo_offset;
> -		}
>   	}
>   	spin_unlock_bh(&pstapriv->asoc_list_lock);
>   

Hi Jiwon,

please consider the above comments.

Please make your "Subject" line more unique. Consider that we may end up 
with having dozen of commits like yours, all of them referring to 
different removals and all without the necessary information to tell 
what they differ in (except the driver/subsystem). So it would help if 
you add the changed file or function to make it more unique.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

