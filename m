Return-Path: <linux-kernel+bounces-268085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385A394202A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F4528552B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECF018E022;
	Tue, 30 Jul 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFC1TpI6"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B418DF9A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365728; cv=none; b=SF4Bg5+vkswl4b+90elB37I/aeDARWvYd1hgb6yh/mF9CYj3Z0Z3xRes10zQuOSmcDQ2SqnvYpQ2+H689lHlSF0mZS3bVp3tVFZETovpcUR6CJxw5T66yH0PMQDYzGh/A5Kr07YjwX/WtGjpx1PmYtKxyqyeiARd7WCWL03whqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365728; c=relaxed/simple;
	bh=ytLFwU5W9RoxWln8v2ZX/zIXkeL6cGK2uuWkaCil1VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WO/p7s3QAMSDvr82IyYKfBoumrfzvOI7wcVcnnfC9Z+7/WTrJjNdOhfVhU9MVAI80Q/85LD/idU0pFm4Q/V2u56GNDukZK9qcacy7w5n0PfXPh8JOTHxrdLhdnhbRkuiF5i95U+z+L5E7PkvmwiXOxDuGZkc5qjVjnBknhlQwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFC1TpI6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b19f9a9d91so352739a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722365724; x=1722970524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXefQtP22X5XOJj1KBluJ3kHyMBxuAX9s4JgXdRwuF4=;
        b=LFC1TpI6MoYxwrK/g/iXFk4jutLAvToxeE/Hf4CFLCA+PZkw8pjanvsgpPw9A3DTKN
         njTZGNESJqPSS6CVSxax3jrsX9NQn8mCPqKS5PaXlErGGfDjv/nUeB2i+nMyVp2yu29i
         Ywn1BmHGwtH399xbZvSPukm1izpeeroHgCplevGmMvMPhTm6Q1nXUh+YpKOaEnNK+SEx
         yk+G3THEnRPJ6TcAuB1tH6PIwvfoUM/ym8CmRR2kwSukZMyEq0UrN2E950E4U1Waewz6
         CUW9EaDKZ6N9V5B27QOKqsY3oyG1Dftz8iH2D/fUeZb3JdSETuS9rn0rWDRbPXdIL73U
         Ubyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722365724; x=1722970524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXefQtP22X5XOJj1KBluJ3kHyMBxuAX9s4JgXdRwuF4=;
        b=CPDmjiRTKYjC638ZEgQbgw27M2mcogTBlE2oPeSWOgdapxnxB82LOmFEE0QR6j4lRf
         WC7amL2N4jxBnkvim+3LV70LVP6mQz5koe3N1jyvlqY2aW5mpnEsCdAOTEb3opHyligf
         VUFcYjha7c2OVxWpRaNT4Rt2madoNoWNtVFv3GvjHszoWdNYHZ5Y32Mx+8RZ2422NOe0
         tbkr98ZNF4ZHxlBvivUv86Y+K7XaBLo2Og/b2qK8SiuUf8MsZ1sgEFCwMeulgG3EOgrS
         tudY6AawrspBYifHIW+jfpaGM1jU9n9/xS0iBZKEGuSpUTYpa5meAyxiZViJTc+nYlG+
         +0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9KqS1uBJC8ijRMFkRsNIUi30ajhU7lBB7QuE9ghCwiIOxwN0/u9e9AF5DqEe4H6uhYlUQjxVVBM9bcdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyehKx+aXf7jEimzKGNyX9tEQjPithlIUMWTx19KIKq4Q+75T57
	xVNiDJL/rflSP7Y6QE0xN+kPUimNJPebSK+HhrdSqJFN83ZH0AiQ
X-Google-Smtp-Source: AGHT+IHHqeJ2PT13d4BRk5orAhekOZklxnTzS4pVLy2itB3AyI24Xcdas+iLqsgimifwTN0sQP+Kbg==
X-Received: by 2002:a17:907:970a:b0:a7a:ab8a:38d with SMTP id a640c23a62f3a-a7ac58c4a2amr863457966b.4.1722365724008;
        Tue, 30 Jul 2024 11:55:24 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8552:f0f5:c00a:214:55c4? (p200300c78f2a8552f0f5c00a021455c4.dip0.t-ipconnect.de. [2003:c7:8f2a:8552:f0f5:c00a:214:55c4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab231fdsm673446066b.41.2024.07.30.11.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 11:55:23 -0700 (PDT)
Message-ID: <0812112f-a06d-4ef1-8ca2-468973191ca7@gmail.com>
Date: Tue, 30 Jul 2024 20:55:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Improve MAR register definition and usage for rtl8723
To: Manjae Cho <manjae.cho@samsung.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CGME20240730155255epcas1p4ab3b5e88d400e2221aa1cf5cf234ea19@epcas1p4.samsung.com>
 <20240730155054.411059-1-manjae.cho@samsung.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240730155054.411059-1-manjae.cho@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 17:50, Manjae Cho wrote:
> This patch improves the usage of the MAR register by updating the
> relevant
> macro definitions and ensuring consistent usage across the codebase.
> 
> Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
> 
> ---
>   drivers/staging/rtl8723bs/hal/sdio_halinit.c    | 4 ++--
>   drivers/staging/rtl8723bs/include/hal_com_reg.h | 3 +++
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> index c9cd6578f7f8..9493562c1619 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> @@ -380,8 +380,8 @@ static void _InitWMACSetting(struct adapter *padapter)
>   	rtw_write32(padapter, REG_RCR, pHalData->ReceiveConfig);
>   
>   	/*  Accept all multicast address */
> -	rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);
> -	rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF);
> +	rtw_write32(padapter, MAR0, 0xFFFFFFFF);
> +	rtw_write32(padapter, MAR4, 0xFFFFFFFF);
>   
>   	/*  Accept all data frames */
>   	value16 = 0xFFFF;
> diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> index 9a02ae69d7a4..baf326d53a46 100644
> --- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
> +++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> @@ -151,6 +151,9 @@
>   #define REG_BSSID						0x0618
>   #define REG_MAR							0x0620
>   
> +#define MAR0						REG_MAR		/* Multicast Address Register, Offset 0x0620-0x0623 */
> +#define MAR4						(REG_MAR + 4)	/* Multicast Address Register, Offset 0x0624-0x0627 */
> +
>   #define REG_MAC_SPEC_SIFS				0x063A
>   /*  20100719 Joseph: Hardware register definition change. (HW datasheet v54) */
>   #define REG_RESP_SIFS_CCK				0x063C	/*  [15:8]SIFS_R2T_OFDM, [7:0]SIFS_R2T_CCK */


Hi Manjae,

please start your Subject according to the expected standard:
staging: rtl8723bs:

The description seems to have a line break that should not be there.

please use checkpatch for your patches:
File Nr: 0    Patch: ../../../Downloads/20240730-[PATCH] Improve MAR 
register definition and usage -17243.txt
WARNING: line length of 126 exceeds 100 columns
#41: FILE: drivers/staging/rtl8723bs/include/hal_com_reg.h:154:
+#define MAR0						REG_MAR		/* Multicast Address Register, Offset 
0x0620-0x0623 */

WARNING: line length of 126 exceeds 100 columns
#42: FILE: drivers/staging/rtl8723bs/include/hal_com_reg.h:155:
+#define MAR4						(REG_MAR + 4)	/* Multicast Address Register, Offset 
0x0624-0x0627 */


If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

In case of questions feel free to contact me directly.

Thanks for your support.

Bye Philipp

