Return-Path: <linux-kernel+bounces-303936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56167961718
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13151288BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3EF1D2F47;
	Tue, 27 Aug 2024 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEs0hjMT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA41CFEB7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783852; cv=none; b=D+HdaGcUqTEa1yLjmC9h/ayAp1QTt4N2LsNUKUP+d7wEk4dNzi4H6eLy4C5uT0wSH90kl6IrNkDUN8f709bSd0jZRuH+Ym+zs6c71EknIIZ4jCFwtwEUvSLDTcCen+7W4OWKee7XLppuGs1UfCJWumIOnj6X+QcfQDdfMbVS9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783852; c=relaxed/simple;
	bh=H8JC4zGBxm+uxM52UrU4l8SHxhWiPw69WAVC5vNwhWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rZuReD65+iQlTZEGYdbICi4NSRffRxyoPy5oVHAjaeRSlsq/oqXwlS8WyqDrNRRXqZSW6lTD27L7Kk9TIfVdfX/Yg/BnrZLgrGUXxNMxXHcmPVpq47o/iyGgnIrsKbT2F1pfBk+huBEX0ILjF2ozkyoMQi2wvwkWpjENQONpnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEs0hjMT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5334b0e1a8eso7694759e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724783848; x=1725388648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+wei2YqmI+C13JiYiOFBXj7v+/g9gbGsLnKaP0aiRLc=;
        b=MEs0hjMTLbFsCg3Yk0gPfo6UmkD3rddIs4XdoSCDmItnOExWX2AOq6bUzdyCtvklBV
         ZqDWwV6LCrEcMvQn01D9fZXcHXwODj9TPwYQlAVBz8xsO1FQ1o2jgqPANODPOQOFHxjp
         WSiofBNn6+rfhwadlnxfiYLzatRq649orZ0a5mlMCIs8VFuDtc8EeZ+UZ3AAlZO+LQhv
         A17EHowXuL5er8UpHJFrKctzt6v+cv6FpaTC+4vaiJRnDaymVboX6XkaThA3FcUN2nH+
         gId4h2RlUm9zXKrsgB2ahU15nop/0ec/uOxuZ+kA5+NmzDPyHjEAkWkCbS0Kr/+tjsPB
         wQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724783848; x=1725388648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wei2YqmI+C13JiYiOFBXj7v+/g9gbGsLnKaP0aiRLc=;
        b=tQtdOjAXK7qrfBTzVnY7Dp6WD515tZ1VlpZhmYr1F+pyQcqUGSuS5xANNTXlEPe5bv
         ZXtS3kThkRTHVjbncXBWX2UNW2sq2/DxoHJc0JrfMKLLhes2u+PGqnnH6hAmFgvZldrt
         f/mi3e5Kv67MZjGd+rEuv/k9moswjtUJ0P9U06HnbJRgmAuyZsuGgU76Ul5eUaXOWCu9
         8ETrOu5mshTKtRS84DCJZywrh212w1KapmSONuLE/SPBxK1aNzgpB9vbU893w1MKOkGZ
         RDokYYSYxMy3yCEUDIX7FdC+7At4Ig6/9FzZT9bexhjjKP8ej3pBpXNO0Ge5F5C/MUJi
         6zpA==
X-Forwarded-Encrypted: i=1; AJvYcCUSGmrUp8GWyD5YjMS/FV3dLiOrRvpDoVrxE3CqqEFUE5PQC9GJxOZ8Ae+/cy2FF+vP+gayWDUYiTX7dbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw2D2zErgSYcxUbBzgBaVShdeGoi9QhrZd5bSZJ8cy995of1rj
	Y1uMNEy8HP63KCR3vhi5JKvr+v1fWmKZIery5RXzMbBLJhwXTawhEb2NQkfu
X-Google-Smtp-Source: AGHT+IGjTs1qBRmJssjl7qNqtqxO0v6xB7rTHw2xEE6XsBHUuOo7xKcZmnVQ4t+E0w8lWtlykvdd8g==
X-Received: by 2002:a05:6512:401d:b0:52c:a7c8:ec43 with SMTP id 2adb3069b0e04-5343870bbf8mr10454113e87.0.1724783847885;
        Tue, 27 Aug 2024 11:37:27 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8589:9a84:3869:ee20:88fd? (p200300c78f2a85899a843869ee2088fd.dip0.t-ipconnect.de. [2003:c7:8f2a:8589:9a84:3869:ee20:88fd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e54851fesm142103066b.43.2024.08.27.11.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 11:37:27 -0700 (PDT)
Message-ID: <e1ab1e44-e5ed-4a6a-821f-859bf54816fb@gmail.com>
Date: Tue, 27 Aug 2024 20:37:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rtl8192e: Fix alignment parenthesis
To: Nilo Alexandre <n1lux.comp@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht
References: <20240827162910.15459-1-n1lux.comp@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240827162910.15459-1-n1lux.comp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 18:29, Nilo Alexandre wrote:
> Fix alignment parenthesis in _rtl92e_read_eeprom_info
> 
> CHECK: Alignment should match open parenthesis
> 
> ---
> Changes in v2:
>      - Using tabs instead of spaces
> 
> Signed-off-by: Nilo Alexandre <n1lux.comp@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index b767dc00100aa..2d17d8e8898e7 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -322,7 +322,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
>   		if (priv->epromtype == EEPROM_93C46) {
>   			if (!priv->autoload_fail_flag) {
>   				usValue = rtl92e_eeprom_read(dev,
> -					                     EEPROM_TxPwDiff_CrystalCap >> 1);
> +								EEPROM_TxPwDiff_CrystalCap >> 1);
>   				priv->eeprom_ant_pwr_diff = usValue & 0x0fff;
>   				priv->eeprom_crystal_cap = (usValue & 0xf000)
>   							 >> 12;

Hi Nilo,

please make your "Subject" line more unique. Consider that we may end up 
with having dozen of commits like yours, all of them referring to 
different removals and all without the necessary information to tell 
what they differ in (except the driver/subsystem). So it would help if 
you add the changed file or function to make it more unique.

Please answer the why in the description and not so much what you did. 
Why do we need an empty line? Please use a dot to end the sentences.
I propose:
Align parenthesis to improve readability.

You can mention the tool which gave you the hint but you do not have to.

Thanks for your support.

Bye Philipp


