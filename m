Return-Path: <linux-kernel+bounces-541876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3B1A4C2C2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DD21886521
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B6212FAD;
	Mon,  3 Mar 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyLKPQJG"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3F212B0A;
	Mon,  3 Mar 2025 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010692; cv=none; b=BILq+zoWhjuM2DZxd5oKyydox1X3C8SCHzcMghF4AQNhzy2KQKTOAlSPaYvx47OFScWv5sv04qcuwIxK9IWQ00l2eih9dIlMmtCasS70uVLYcDSbPqh8J0khZzZv79f0DPrnkb0DE9V77uD5FIr1BTQLPcHkFyK2Q4ebn6vSl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010692; c=relaxed/simple;
	bh=zgcKsEOUWpNBJREA/izuckdYXAzMPtyUrD1iD60/azs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0lMtDpoqQ+FQEOIIsKhoOlSEsCqfPX2UQSFQ1xzUJEK1Ygtmv5+VDiFV37Ba7KOQ59p7gvI0hTX5kEtuOsIE94kOv9OVt0kL81NMRLFqiL7n8MSmQwEE5VSwdGr15XV9dBpsySuNh02MwSEBli9PxV56KbKyF+xoAjmY4Oln2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyLKPQJG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f42992f608so6887518a91.0;
        Mon, 03 Mar 2025 06:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741010690; x=1741615490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvE6T4ivpLX+1F6WHj2bh0sHwMKlhe/ppb8XVzDUeaA=;
        b=TyLKPQJGep8Cc0uqH5IyHW6TjXZzCZMDFW02ayDyN177fUIuhRT7rQjD7/Zsd0R+G7
         kly/41M3wtb0HM0I0nj+s5/dI+vWvJEPXfuEeAEo+d4G2mBUmvKRpAr3/XTVWB9AFAOL
         D3Wa3scDaPETPk+pmht6rGe58nffWpg8PZm+pLgLL/wOaHAMyPRTDo2RiJRxyKJPZiC9
         PrF6/B8JODgoyQPGinlIQaEayBIXMUrZyODPX+vk7PNu08oP0iCfQVow0gT5VTDoumKM
         BXkpMSAZfCGdklGzGISLIYfCF1ajytTs6+pJaqscNU5YNV9QCyDzu8DDKG44AbGVaJqQ
         mrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010690; x=1741615490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvE6T4ivpLX+1F6WHj2bh0sHwMKlhe/ppb8XVzDUeaA=;
        b=ehv54HhlP2bKuXE1JUIYAU3b29uBEyOd2qloCzBsIhL4L1OUOwfmz/ENDdLdpKwRua
         wk6qDmDmzK5QG4O3FOer11eO/d5yoc2K+bCo+bRoAvGIKEpIXfQtjdjV30EJX3v3LWMt
         o5JEh17C0/wdy+ncafX0VpTbU4H9Z97BAh7cDzmKLQhn67LxnGqUhMsiWTioCiqxUJzn
         IxQ6b89pKxa8fXT7DirCLqPQ96Eg3+z/H/9rjAar9DI7dz6yKz1o1U7Y6auq49h9kua+
         7SggOI1wFopm5MOWsRFmqijeaLe336nvs2smfTEIREPKdvk9JEe58/Q5+GwnMp+WUqJ1
         lo2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8Y9MUDd26EtUk0an9dbXb1o5o11Lwen4drNtHQJpkDu3q/zuM62l3gKBJeuaE1n34IJnQxR1/LJ4fEQ==@vger.kernel.org, AJvYcCW/zMgV6jnNmDq/bxcoj/692K+5NiAZvS+rDMiWATOZe/0IC3+C9uG7nRf++uHZbkiYqhnYzi4sU7Z69QaI@vger.kernel.org
X-Gm-Message-State: AOJu0YytQJ6jAswdhoVnCpifixTvR1ZPUesc4+4eKfzm3aKbl8rdIsX5
	iHGa1k5lCWQyY3U1Bt/b4YbBpvGotzHnTk7iPBt7aEZqKPuvlcS71ildoQ==
X-Gm-Gg: ASbGnctnnCCboUKL/fsBBMAp0Bvdg+B4hkWdnCFoKww+4Phug09q2VkZ1lYuyl8Mgke
	XuLlFLdhCg+T1Mb5HK9QTObpsz7JaBDTQ//MC9oADu7q1c8ygzz2j8GKvLeQNk0Rm7Hlwemwqij
	3PMVSHBPqeWb9nnT/RU6akc9km8Zy4lchAuanfc8fS65Zx2aqEWSiWLQYXzcMa8s8yl7RjOaeXj
	oJOxZkuXJvfxotRqrJ3C9AMkzwcg7SoEGv8UzQLQOoI2aNbno/nMpX/KPiwyk3GlETtGYDSjx5x
	setpTsYYYvWTaF4T+YcxOCwSuT8cei/GLxBx/Cd0vb+x5mmgQrBNhz/7fA==
X-Google-Smtp-Source: AGHT+IGPO1HLnLRdrbDTxb8Lo5MjAMwrz3DRbHe7D8TQ81it8ZfNDaagM1DXl9eEgK9x7XZMXDez9A==
X-Received: by 2002:a17:90b:1e46:b0:2ee:f80c:6884 with SMTP id 98e67ed59e1d1-2febabf8235mr22991089a91.33.1741010690181;
        Mon, 03 Mar 2025 06:04:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea679df1asm8934905a91.22.2025.03.03.06.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:04:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 3 Mar 2025 06:04:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: xinghuo.chen@foxmail.com
Cc: jdelvare@suse.com, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, jingfelix@hust.edu.cn
Subject: Re: [PATCH v2] hwmon: fix a NULL vs IS_ERR_OR_NULL() check in
 xgene_hwmon_probe()
Message-ID: <4e8b32f8-4570-4630-bd0f-91e63cd33767@roeck-us.net>
References: <tencent_9AD8E7683EC29CAC97496B44F3F865BA070A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_9AD8E7683EC29CAC97496B44F3F865BA070A@qq.com>

On Mon, Mar 03, 2025 at 07:57:33AM -0500, xinghuo.chen@foxmail.com wrote:
> From: Xinghuo Chen <xinghuo.chen@foxmail.com>
> 
> The devm_memremap() function returns error pointers on error,
> it doesn't return NULL.
> 
> Fixes: c7cefce03e69 ("hwmon: (xgene) access mailbox as RAM")
> Signed-off-by: Xinghuo Chen <xinghuo.chen@foxmail.com>

Applied.

Thanks,
Guenter

> ---
> v1 -> v2:
> Use IS_ERR_OR_NULL() instead of IS_ERR() as devm_ioremap()
> return NULL on error.
> 
> Link to v1: https://lore.kernel.org/all/tencent_370DBB5BD8EF699EC030ACA74BCB440FFA0A@qq.com
> ---
>  drivers/hwmon/xgene-hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
> index 1e3bd129a922..7087197383c9 100644
> --- a/drivers/hwmon/xgene-hwmon.c
> +++ b/drivers/hwmon/xgene-hwmon.c
> @@ -706,7 +706,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
>  			goto out;
>  		}
>  
> -		if (!ctx->pcc_comm_addr) {
> +		if (IS_ERR_OR_NULL(ctx->pcc_comm_addr)) {
>  			dev_err(&pdev->dev,
>  				"Failed to ioremap PCC comm region\n");
>  			rc = -ENOMEM;

