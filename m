Return-Path: <linux-kernel+bounces-369593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A38B9A1F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49937282FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68861DA62E;
	Thu, 17 Oct 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLMUVtRl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064DD1DA10B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159272; cv=none; b=jJv5WzYZNqWi3LClTFTUD1T+uldBygsvoC3Qz8/1lsS0tYGtCMrsKK287c4GqZGLWwC0wOrb3RpOFfMLR/nYyjnG1sw3ED7eByZEYF/tvYF2ulixTqhRZqdl3+mLi2/U6ivKbStQ1VpB0j9+a71Y/mmOakiEHaLMQee8Qbyh9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159272; c=relaxed/simple;
	bh=vN5XyVfrxrxoAZYcVh5tDUAZHsclorzekDqmFxRKq+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuOve3aFQcKPEu34GfA6k4z8enG8YMguEyRtkTylA2PwkSzYMseM2LqeUWmB3ylP5baOxCTmVaezdJIEy1rZQ0Bg+2ctj5qSWlvvVxd1pe/+7aP4qh3xlwvqxnUjS9SBYRzo8lPcS9dMi3dijeujv/pvPXMWmaCB7VvZHxNVQK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLMUVtRl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729159267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bY7iWoxj9CZSiYPztvl4Gv25W+IisCK/5xSZ4Gjk1ss=;
	b=BLMUVtRlxY/yQ8zkVpopr2lBtP5GuEXogCyL8HsIBSE6CjI8uv00kvJg8YiAJa76D/wV8d
	z6uAkyO4YtzXuLpxKd1O+O63JzFEwa1tc93ZN73g5TLdgGV97oTFadBneFAs3QtoHd7mjV
	/UzZK3mazPZcQAYhEU5QyzcjZFFLFM0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-eaqMFTC4OAKVOg6zGGsT2g-1; Thu, 17 Oct 2024 06:01:06 -0400
X-MC-Unique: eaqMFTC4OAKVOg6zGGsT2g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d458087c0so1018525f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729159265; x=1729764065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bY7iWoxj9CZSiYPztvl4Gv25W+IisCK/5xSZ4Gjk1ss=;
        b=Yg7+nSql40xuCI61uXmjA8yI5N0kQWXwzmRgo0mdyIOro2P2LjvlWCIgGGGffJYGcE
         ya1GZEZGFdFOzCZyvDJ04PpTksdFxA86tHzxb1ATS6UJ40FrPcsEJUInQcS1w5Qj8RR8
         wVbn6/bNYFmMX1uU9KmM5UjkaiODbV2rVVOmpuF5IxBf2Q+QajMKLSoRzZJqouWTx5Qe
         ZO+DQF2H64UB0yBNSYuabpoLErFZ9Z3V4NWYktqqoJnR1xcvzimK22kjgCa2Gr6S9M//
         mTQfx3j4ps5dVTMeoH3h5HFDhk8wwdZ5ItvrbCavjvJOqtOC61bXbId8WvSqUkOVKpEQ
         VIaA==
X-Forwarded-Encrypted: i=1; AJvYcCV8o0k2NvX60uHKoSosBfTkLRZoeMf3DEb99advs4y+La4Qm7EYrGZiyaVSOOQfG1Q103LDXOKvu0wOb5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwON+x0ZXsT/6L4DHaPnu9ktRCjXIE63BLgSN8LaQKtIM1WE+v+
	B9dVBBjrRZLBSvLxpJ95ug9HjueCoysLFa6qjnnXEk8e9JnMBMcRltliqHKHEmXodJZAAMnqfsa
	9wOtuAQJhkeQz2qrocA0m2p5uQbAla9Yt4VlnhTuXVdyxd4u80a6GwPVU6HJiSA==
X-Received: by 2002:adf:eed1:0:b0:37d:364c:b410 with SMTP id ffacd0b85a97d-37d93e7c0demr1376191f8f.33.1729159264639;
        Thu, 17 Oct 2024 03:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6m9HZ9VFkMarpnDHPdKY9Ze3IrDZnULc4nzyeU8rI4nQl9HH2QzNL2vR2k5JWur7cDZ09Hw==
X-Received: by 2002:adf:eed1:0:b0:37d:364c:b410 with SMTP id ffacd0b85a97d-37d93e7c0demr1376135f8f.33.1729159263735;
        Thu, 17 Oct 2024 03:01:03 -0700 (PDT)
Received: from [192.168.88.248] (146-241-63-201.dyn.eolo.it. [146.241.63.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d94626094sm1972380f8f.88.2024.10.17.03.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 03:01:03 -0700 (PDT)
Message-ID: <a0aec660-c18b-4d85-b85b-58fce3668e64@redhat.com>
Date: Thu, 17 Oct 2024 12:01:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] fsl/fman: Fix refcount handling of fman-related
 devices
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Igal Liberman <igal.liberman@freescale.com>
Cc: Simon Horman <horms@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Sean Anderson <sean.anderson@seco.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20241015060122.25709-1-amishin@t-argos.ru>
 <20241015060122.25709-3-amishin@t-argos.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241015060122.25709-3-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 08:01, Aleksandr Mishin wrote:
> In mac_probe() there are multiple calls to of_find_device_by_node(),
> fman_bind() and fman_port_bind() which takes references to of_dev->dev.
> Not all references taken by these calls are released later on error path
> in mac_probe() and in mac_remove() which lead to reference leaks.
> 
> Add references release.
> 
> Fixes: 3933961682a3 ("fsl/fman: Add FMan MAC driver")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> Compile tested only.
> 
>   drivers/net/ethernet/freescale/fman/mac.c | 62 +++++++++++++++++------
>   1 file changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
> index 9b863db0bf08..11da139082e1 100644
> --- a/drivers/net/ethernet/freescale/fman/mac.c
> +++ b/drivers/net/ethernet/freescale/fman/mac.c
> @@ -204,7 +204,7 @@ static int mac_probe(struct platform_device *_of_dev)
>   	if (err) {
>   		dev_err(dev, "failed to read cell-index for %pOF\n", dev_node);
>   		err = -EINVAL;
> -		goto _return_of_node_put;
> +		goto _return_dev_put;

We are after a succesful of_find_device_by_node and prior to 
fman_bind(), mac_dev->fman_dev refcount is 1

> @@ -213,40 +213,51 @@ static int mac_probe(struct platform_device *_of_dev)
>   	if (!priv->fman) {
>   		dev_err(dev, "fman_bind(%pOF) failed\n", dev_node);
>   		err = -ENODEV;
> -		goto _return_of_node_put;
> +		goto _return_dev_put;
>   	}
>   
> +	/* Two references have been taken in of_find_device_by_node()
> +	 * and fman_bind(). Release one of them here. The second one
> +	 * will be released in mac_remove().
> +	 */
> +	put_device(mac_dev->fman_dev);
>   	of_node_put(dev_node);
> +	dev_node = NULL;
>   
>   	/* Get the address of the memory mapped registers */
>   	mac_dev->res = platform_get_mem_or_io(_of_dev, 0);
>   	if (!mac_dev->res) {
>   		dev_err(dev, "could not get registers\n");
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto _return_dev_put;

Here we are after a successful fman_bind(), mac_dev->fman_dev  refcount 
is 2. _return_dev_put will drop a single reference, this error path 
looks buggy.

Similar issue for the _return_dev_arr_put error path below.

Cheers,

Paolo


