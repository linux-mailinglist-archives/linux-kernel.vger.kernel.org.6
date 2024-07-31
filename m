Return-Path: <linux-kernel+bounces-268512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C7894259B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3214E1F2395B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B792837A;
	Wed, 31 Jul 2024 04:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbEf0Ac0"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC53BBE2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722401925; cv=none; b=sPAq+1pDqHy6hIclRVhnNrEKjOun0GL7hpB7uiqgfTqrtwtMME9A3/TkIfmOX/jELkQlmLDK59Pdkywdx96+7oxcY0XdxTowRQW7/XkE5D2hpJ+QqDOz+Yx48qNjVkdOR9OJl24C3DZmT1iC0HsfG4IObSXijEKYlen6yQA3F10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722401925; c=relaxed/simple;
	bh=NVUNyd4l8NBOU55aoxt7CFuV7mdL6LGF/55dnei9uSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsehBsubYsuWBsP3tBbpAKL+d+RE+mlmTkxQTLS190UhxeLTZIG++o9774+9Jk1hcpW3c934AsOcq/UVwhgMXh/x34bu3UtSS7Cpts1IgcU15uRYG4uWjMohy3JkzgwVmsKdsZQ8y6wZKUFmnrsPA9LSmO90VtrsgYfW+cxu1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbEf0Ac0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a0d75431cbso842476a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722401922; x=1723006722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/PsU4QPtdaw9JWR+k0QZBRBLHI6SUIxR1xLkmoJhO5M=;
        b=DbEf0Ac0qFJv70r3zmR+xpzc11gu6UpRG8lMEQDCy2Asd6U8XotWasgRb5KddR18pd
         FabaPdyVkn49hYqdV5WSBrGsfLIQk19Fja96r6O6yop6HZ4w3efFFEvN2p6StfJynnUP
         ft3q56DgRWjcJsYg3+e5j5VMD0lXltrLlK559iWA6FGfVkRIkbvyJD9WDkJRQLnOzAY4
         fydoon5Oxc4p4QawlsJpdIrOWdg18rhmNMsmOEyJcNIpcs3WoQRidfiDkKP06yD22mms
         X1+hhos/PbfMfe8JipIKl0/RQfy7ONakkNLa+xBRE3WtEFqwOIku6VpBgGHcCj9eOLjD
         rpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722401922; x=1723006722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PsU4QPtdaw9JWR+k0QZBRBLHI6SUIxR1xLkmoJhO5M=;
        b=TILEHkCIaf3BFmtxvHMZ/YUt/0TpBlB5CnNoaVEXhRSuSl7oVqRQOH6Fm0uFe/64Rj
         mPoqf2nt2M1clQAciHFAVnyWYaXrzUFlFMJrB39bCcg7ZhyVFv9A5IuA2D5BdtT9LzN5
         DsjrUwk/T5gnVWj+bdSsG76vuPdybGBbrNaqtsFucOVicHF8zHeqifnk0Nd87H+hv6dD
         i7qOtxksIQwduOXBkbYJE99wMZUFvuCNY1IEqrwJxhFXG8mXmEfEHn4pViGQwWBHGRaZ
         o74ZuDckWxzUF4yNQCK6dUsqLC7PAw7GvxTKBRq0j6QOOJHi4sqIoLwnu0nd/1zozJyM
         OM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBjfm1KhLnDHJXynJfuZMlRYV3shj2/9DcYgYCyc9IMekd97l9fBYoggN1ojlshCLFcIb3x2M998WpEIqpZML/XjBzTVVW/Wsd51JL
X-Gm-Message-State: AOJu0YwoO1sctQbfQaFZ3aY3WJVMQdcqIcVPzJnSbU5Qyti/042jdEJP
	jPbi/Cdo2uplukkbf8c3mfPQ7gqJped4JUUzPdUEO2vkTOof++AV
X-Google-Smtp-Source: AGHT+IFGDqLoeOpxPhFPUM5lpU6Hs665oeNWL989zgzESHN3kWkAZhdsEDEYm8cIBD6QNIKcrIUpmw==
X-Received: by 2002:a05:6402:524e:b0:5af:6c44:6807 with SMTP id 4fb4d7f45d1cf-5af6c44694fmr6970761a12.6.1722401922082;
        Tue, 30 Jul 2024 21:58:42 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8552:b861:5a1f:1e40:f01? (p200300c78f2a8552b8615a1f1e400f01.dip0.t-ipconnect.de. [2003:c7:8f2a:8552:b861:5a1f:1e40:f01])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590585sm8162341a12.22.2024.07.30.21.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 21:58:41 -0700 (PDT)
Message-ID: <80076244-4d77-45d9-a721-06664e11477e@gmail.com>
Date: Wed, 31 Jul 2024 06:58:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rtl8723bs: Improve MAR register definition
 and usage
To: Manjae Cho <manjae.cho@samsung.com>, gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <CGME20240731004335epcas1p382229e79bdaf3f2d48b0f3faa7414ea6@epcas1p3.samsung.com>
 <20240730231046.412876-1-manjae.cho@samsung.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240730231046.412876-1-manjae.cho@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 01:10, Manjae Cho wrote:
> This patch improves the usage of the MAR register by updating the relevant
> macro definitions and ensuring consistent usage across the codebase.
> 
> Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
> ---
> v2: Fix line length
> 
>   drivers/staging/rtl8723bs/include/hal_com_reg.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> index baf326d53a46..93aa391fa749 100644
> --- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
> +++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> @@ -151,8 +151,8 @@
>   #define REG_BSSID						0x0618
>   #define REG_MAR							0x0620
>   
> -#define MAR0						REG_MAR		/* Multicast Address Register, Offset 0x0620-0x0623 */
> -#define MAR4						(REG_MAR + 4)	/* Multicast Address Register, Offset 0x0624-0x0627 */
> +#define MAR0		REG_MAR		/* Multicast Address Register, Offset 0x0620-0x0623 */
> +#define MAR4		(REG_MAR + 4)	/* Multicast Address Register, Offset 0x0624-0x0627 */
>   
>   #define REG_MAC_SPEC_SIFS				0x063A
>   /*  20100719 Joseph: Hardware register definition change. (HW datasheet v54) */

Hi Manjae,

this patch cannot be applied because you build it on top of your first 
patch which was not accepted. Please rebase this patch.

Thanks for your support.

Bye Philipp

