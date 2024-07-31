Return-Path: <linux-kernel+bounces-269757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B3994368C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A801C21E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5177E59A;
	Wed, 31 Jul 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZZatykF"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353038DEC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454685; cv=none; b=ZDcOQ8Ne5Or9ZWhRiAORb3SGEOR2lCzgbt0LjMiESFKimCQm+Cb7zSHMGWDryJ7Hjwr6Q/ucaOdau0kw+KWykHa2av/ANjKzW/u/+rn6pDnHDxtmuKeg9GTKTAm6oz0GLusWVBh12fpn1BO82ivhEAHLWcnHUHpZfCa2363yfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454685; c=relaxed/simple;
	bh=dSb8vVCLtvBwVy0nW+BM0SMjTiQyTQKs//IgzE0RTUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWUgP8UTtdsZ54J85z+nSJbvUk7p17v7t3fON+rlLylxCwwn30VEhfIYmxBoT1A+pWknDktztTsrQ3FHUtAIJ6zcgD88T1AJNg+TjsyGlP0xXBnbEjxsSLPGOu8Spyb5cOYO8dLyAT5oqFRZ12q9n4JYYUWxEYj8OjLPhxetBFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZZatykF; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f01db9f419so7072341fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722454682; x=1723059482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72sAWVBR8h+gUQRIaEFVlfyy2iR2XsX6552mwHwwfZo=;
        b=XZZatykFCw8Z3W76JGlEebBPxVVPCBwpxwo2J6ADMQevw1oHyCOcx+3QojrPdY5z7q
         VmttSWaQNUyfwZL+S0x8UKA86tDUKddhOxQs3wIqaB8PXGCj4ZrFKHRuxXzoTp3MXIUn
         Pe2IDUkzBZNSPlmAaP4FWmiEv37nKZOkQv2rpVAEoVWRaTaDEa+hg4Zm8rVpSvumQix9
         MOKqseRYPjbx3UlMC0bzn4kVpvb/DyrHau0zqrYI90hkL0mp5LOQJEEOHrROY4K2NsNY
         /0dzmI/7xQtbxBau1d1IMQdgZ6J4IdxmcVrSqDQwHLN19iu+fFXXkjVpKbbNPLDeBlaq
         5poQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722454682; x=1723059482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72sAWVBR8h+gUQRIaEFVlfyy2iR2XsX6552mwHwwfZo=;
        b=C3KLfHb1KPfQ9fj0yMojDPj22fIgHh6T9JsJbA+PZlsYbDmhg2/NisJOPZRIPOPAA+
         OyqT/ftkLhiJoq7RYFbuBOEhqkjZ8hSvC1xP74e4nGO/VCbt7PXxt0BdhiqAjfmPeii/
         ad7fA/gOcXK25KFWd+7vD0VjFWmNdQ1zEfK0MXkTYaAmjujx1BzDYfDOqZCahoC0/wsR
         jfDu3dWuStcs/DKXQzG4++EcTMP83F1TQVnnuUMtZ8xl+OG9xzf7hgWb23CshztAFOj3
         GpLjl22HLY39j/Y/6ozCe0b1x8FpjEUbUGSFr38JwRO46ucsvD/A3eqUXS4IuL82+VEx
         bSLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+CndCI5J25kHrylcRYP+c8jyDyz1ms5SH70rPeezrezJVdZpkkK8bflGNdP//kddvVLQugot4y2XizwlF+xi0OM2iXWwCBecOSUHV
X-Gm-Message-State: AOJu0YyS7UdFhI48n60MphSP2xJI9NfNHdDEcmQQWcckJqmpuiPmGSVh
	GOScmvXRmMfKNinZxAWKVddSzQQ8uW9eFOD5dD5N9m5+5ddWaW5d
X-Google-Smtp-Source: AGHT+IFX5EBt208JIlRQZNgRtMb35uf1gZ2AWx4Ej3RVS/mj0n7QNgKL7UUCQ0rbAcgcHJYP0DaOyA==
X-Received: by 2002:a05:651c:b27:b0:2ef:315c:67e1 with SMTP id 38308e7fff4ca-2f1532e7c89mr2091761fa.4.1722454681414;
        Wed, 31 Jul 2024 12:38:01 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8500:f3cf:8e28:7954:b203? (p200300c78f2a8500f3cf8e287954b203.dip0.t-ipconnect.de. [2003:c7:8f2a:8500:f3cf:8e28:7954:b203])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b59c95sm9188229a12.50.2024.07.31.12.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 12:38:01 -0700 (PDT)
Message-ID: <8f82f816-b677-4f6d-b381-d25f0bb04521@gmail.com>
Date: Wed, 31 Jul 2024 21:38:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rtl8723bs: Improve clarity of MAR usage
To: Manjae Cho <manjae.cho@samsung.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CGME20240731081603epcas1p1d140964329ddaf9146bacb6bd1111506@epcas1p1.samsung.com>
 <20240731081540.912533-1-manjae.cho@samsung.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240731081540.912533-1-manjae.cho@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 10:15, Manjae Cho wrote:
> This patch improves the readability of the code related to the Multicast
> Address Register (REG_MAR) in the rtl8723bs driver. It adds comments to
> clarify the purpose and offset of the register, making the code more
> self-documenting without introducing new macros.
> 
> Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
> ---
> 
> v2: Add comments for clarity instead of new macros
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

Hi Manjae,

may be this is version v2 of this patch with this subject. But the 
version is not about the subject. It is about the code change itself.

So I can see that this patch was send in with the following subjects:
[PATCH] Improve MAR register definition and usage for rtl8723
[PATCH v2] staging: rtl8723bs: Improve MAR register definition and usage
[PATCH] staging: rtl8723bs: Improve MAR register definition and usage
[PATCH v2] staging: rtl8723bs: Improve clarity of MAR usage

To me the last patch should be a v4. The next patch you send is the v5.
A change history is expected.

Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

