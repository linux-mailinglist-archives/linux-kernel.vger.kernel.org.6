Return-Path: <linux-kernel+bounces-277287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C866F949EF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8436728630C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B50191490;
	Wed,  7 Aug 2024 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMf88erh"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA1919149B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 04:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723006208; cv=none; b=CmNb0FFBC9sGwfNsTOM1YEOs6kUFv/Hu1ar9eBZ+ah3W6T3HQop0lRSK1/gO9AQvl7gYs3qiRTgJcm84h/Awd+rvhLZbz5cLJppT8f1z1BvVJcu88eEQfDOB3J+8+J28SUHsjW4cIHtnO+Hn6ZG9F0o6d3xMXptAX7RwJHzfYEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723006208; c=relaxed/simple;
	bh=KPAUxZqJrhsS4KCtmCVx+w7hmq3WMoxRxbv6d9nxS6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBwA1dAPnYErtsXJGAS+BbWmtgNsf3frDyENtnBI4xG7jVOYHkSURg5rHsPKnE17O4iFQ1nezc21bTKfFOsl1oj96GyIzJNMKmc155KYixVsQC+e31i024hRO5bIOBmgD3T0gEOxmZsm9sGh1lsRIUHEo1JXMJcwCq8QVY1GNY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMf88erh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efa98b11eso206070e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 21:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723006205; x=1723611005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxW/EOKuv2Ggq7C49WbAgTm8GRc4ALxx4EED6SiYzio=;
        b=hMf88erhqutTFAQhMqiCi1u0nm3sncVU6V5Pz5f2cukm/VwbYp/w7zjkNGp0Mlk9FC
         W06C4Y0nyE1N3TjtKPTpfOgeyrdBGk5dhRGyMXU8NuIWdjpaidOvvl9SkHLBX21WZu/k
         caDnIda2uQx8Pdu64/wNJWVs272EGKddT5F0aT7Zbb/a+YGHzh6v72YgIBnKwZlTyGE1
         fgCKPMHyD/G5MVhKvnUnAfbmOqtYcu74PrM1hv02bhBQY5FIugdqO4UP1Fo1QCZvspE7
         ftGQHL7hFSYNE9obtCv0uJW8WnnF7pwhpNHjv2VxjxOISB7Bk53+eaHWutPTh77Bd7Am
         X9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723006205; x=1723611005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxW/EOKuv2Ggq7C49WbAgTm8GRc4ALxx4EED6SiYzio=;
        b=n+p+BCSu0eah43ZHGEECX6ujD0gu9nNybLPp1noWCOoEDZnz9PNaS3uaViLHUOZGrs
         +QjHs5BfFWuJI0NDipI0kPAVcCx3MQyvWPyWiwomvbyDhNfcPWjSwlY9xbYRMzoRMuEc
         ErGMLvdsk0DYVqfmg22Q8szUyWbJvTA3Fc8dF00exMHeye7LMLxkkaDIHXgpKwfEgtoT
         Wz/yt0kPhtEaajCJRF2LppOOmwIwPRCQsPF+IYuG24v+/M9wRDGJuCVDssMDkhVxb1ke
         2n3calX9ocFkdLRtjGowd06Buo/F/BoWlOJO5AuRNIXZDZZYdwVwORRg4tzq8bd6MlR9
         6y/w==
X-Forwarded-Encrypted: i=1; AJvYcCUDog7hdc8/vDiv8wRSI5yV60sjgiuwiFaFtaDoU8vz4ZhDefw4zTvq4IVNc1c2i08nr8Wy9edC6kk1ND4GRGh/IlgR1INULxu1jkBV
X-Gm-Message-State: AOJu0YyWKnvE6YYOiydmi+eBbsaK2g3nwDaNjRCBCZCen4l29uw7LdZZ
	YOjdaqqWk2xwFGflXnvTleysN30Dea6ZVitiOmoNcsOdszH0NHBc
X-Google-Smtp-Source: AGHT+IE2FO8Po63soVEnx0OCYSC5d1Kb5hMUN7fMjnVorI03GJcKhRF+ANqXWTBm6AY6e++1NJMc+Q==
X-Received: by 2002:a2e:9b88:0:b0:2ef:27fa:1fbe with SMTP id 38308e7fff4ca-2f15aa7f67emr62938041fa.2.1723006204617;
        Tue, 06 Aug 2024 21:50:04 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8533:9f5e:f4:8922:a04c? (p200300c78f2a85339f5e00f48922a04c.dip0.t-ipconnect.de. [2003:c7:8f2a:8533:9f5e:f4:8922:a04c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a552984sm6597089a12.58.2024.08.06.21.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 21:50:04 -0700 (PDT)
Message-ID: <c1212c50-f571-4193-84e5-9c2c909f876e@gmail.com>
Date: Wed, 7 Aug 2024 06:50:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: rtl8723bs: Delete unnecessary braces for
 single statement blocks in xmit_linux.c
To: Jiwon Kim <jiwonaid0@gmail.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240805135623.2069-1-jiwonaid0@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240805135623.2069-1-jiwonaid0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 15:56, Jiwon Kim wrote:
> Delete braces {} for single statement blocks to shorten code.
> 
> Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
> ---
> v3: Fix subject
> v2: Fix subject and description
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

Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

