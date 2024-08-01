Return-Path: <linux-kernel+bounces-270640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FA29442B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16E71F22AFC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F11140E38;
	Thu,  1 Aug 2024 05:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCZ9XhUt"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620C13D62C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 05:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722489859; cv=none; b=Aafuvy3qInWYfJFuRz7thT1haHJL8h2uIzVhWifW9+3BTQvjvPoKL91K0PrO8oyEbxjWDfxr1+7mjokn8ZSq7drFkfzJ15BB2bpKnDv3pD6NoFWql92YM9B7PT/O3E8fxTL6/uj21o9692JZ34YOQwlaZEbtwWQgN8zxx21qdhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722489859; c=relaxed/simple;
	bh=Yomr5iZ2RYuI8MiommezWCszl7V/zyy4FImaVpWSAJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krJnRFSFA1HoiLqT3V5W529VziD9Ho1KNnCWgiy/srmaLkxEv7xKwloNlR4NHmBtnanrPhR3GK6LvOhpVBs6f3Ip4RhmO7olgIZfWfYygHtVZfhWwhiutsYYtjgmlckOqOvT9k2mUjmwwkHH1w+iEp758DsBNqa8U0OszL2nTJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCZ9XhUt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aa74d1ab8so65558566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722489856; x=1723094656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTCkhYC110sy/G2TV66FBtBgbpExBLZ3KMUjKZM4qT4=;
        b=TCZ9XhUtzAESfh7RrWUJqM1I7wIYFBZIryPuzLKmDwOi0rKkybii0hRtBfYeEZTJnI
         E0C9FVEXjbSsbyPmKL2UcwtPnqPUWxj8xIp8WRi9co8Ik8ZgwW5O0w2XlTZsyc5Y9tsY
         EDhL24tmMuvdmD11lD8g0EAokCITJxJoPFf01zP+Z+CnOQpLAUGFOikahPzbgx9hh0gY
         aoAu7R5gcAODn5EgL+utPw1ad0JQEUBlctIVy2RRRIivCX613myVwPthWZoaV5SfJN9a
         3NnwhrolnXRD8gXTnLmP3nQ1coW0q53UPFUMHMFz1KZPaUHSgDDeCdrsyXGOddYGLKWu
         2SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722489856; x=1723094656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTCkhYC110sy/G2TV66FBtBgbpExBLZ3KMUjKZM4qT4=;
        b=TEXLhIHMDU5WprL+1c2DmiOg82oHVUNA3VQxNTPNrIzhPkI/4CZffY2+uVCTHn/6sS
         caWGMRK6DWIphlEjD6jcu3Gax0AXndo8LqmH0l+ybpv6M7xLJfgYPOKzlSEjeqrVRuvr
         tks3oPB7AEeoTO2wDcN7p4+05MAke2XazTi7WndoDQsRJl1w3v5ZZLC+orOG/al4VJRc
         7USUKFliTf+5a+w++eaxCDIJNOlT7TZfOPrr+pLyQ0I1gJsMoVKnfvrFKweNzxSl2oi9
         i/ihGN7MV92xFkYN8mZRdIF5pO2C84Lx9bFE8VMsXVsg+h8SYiPn34jBMaWBWtAmFzwe
         1r9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAOEr/NIpx22tA2s5uuOhMD/oQwHRfkns8XEkHvXi0hHS/8AS2wN99pXzgsSuxGbvpDCdq9UdHYY47Ja4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8n21BNazudNTpGdMXxWU7BdqTepaDh3/KbKpuTUHEq8SJG8tZ
	25+lHFnyUW34vQjSb7LE0SIfoia5t1ccYidiVNTUrsGOyYXcx/vc
X-Google-Smtp-Source: AGHT+IFlZr68ijykOhEFF19rgRm12fwRwHIyPsAwN+nI1o5ek8oPATxR4OnCVtRqFblnAWDqocOA1A==
X-Received: by 2002:a50:c181:0:b0:5aa:19b1:ffd6 with SMTP id 4fb4d7f45d1cf-5b70159020fmr445985a12.4.1722489855721;
        Wed, 31 Jul 2024 22:24:15 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8500:57d2:826:6de3:1237? (p200300c78f2a850057d208266de31237.dip0.t-ipconnect.de. [2003:c7:8f2a:8500:57d2:826:6de3:1237])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6377d724sm9628385a12.40.2024.07.31.22.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 22:24:15 -0700 (PDT)
Message-ID: <fd2dc636-762f-4fd4-acd0-a473097406ff@gmail.com>
Date: Thu, 1 Aug 2024 07:24:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] staging: rtl8723bs: Improve clarity of MAR usage
To: Manjae Cho <manjae.cho@samsung.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CGME20240731225631epcas1p2658d1e469ff9339c90542f6dd947746e@epcas1p2.samsung.com>
 <20240731225134.917542-1-manjae.cho@samsung.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240731225134.917542-1-manjae.cho@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 00:51, Manjae Cho wrote:
> This patch improves the readability of the code related to the Multicast
> Address Register (REG_MAR) in the rtl8723bs driver. It adds comments to
> clarify the purpose and offset of the register, making the code more
> self-documenting without introducing new macros.
> 
> Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
> ---
> 
> v5:
> - Maintain consistent patch versioning
> - Add change history
> 
> v4:
> - Refine commit message
> - Adjust comment wording
> 
> v3:
> - Remove MAR0 and MAR4 definitions
> - Add comments for clarity instead of new macros
> - Maintain existing REG_MAR usage
> 
> v2:
> - Update patch title
> - Improve commit message
> 
> v1:
> - Initial version: Introduce MAR0 and MAR4 definitions
> 
>   drivers/staging/rtl8723bs/hal/sdio_halinit.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> index c9cd6578f7f8..535cd439121d 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> @@ -380,8 +380,8 @@ static void _InitWMACSetting(struct adapter *padapter)
>   	rtw_write32(padapter, REG_RCR, pHalData->ReceiveConfig);
>   
>   	/*  Accept all multicast address */
> -	rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);
> -	rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF);
> +	rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);	/* Offset 0x0620-0x0623 */
> +	rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF);	/* Offset 0x0624-0x0627 */
>   
>   	/*  Accept all data frames */
>   	value16 = 0xFFFF;

Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

