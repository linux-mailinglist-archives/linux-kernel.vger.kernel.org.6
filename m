Return-Path: <linux-kernel+bounces-373026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA799A50BB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 22:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622F71F22E39
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 20:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CAA1917CE;
	Sat, 19 Oct 2024 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcBmLRH2"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29C6088F
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729369975; cv=none; b=gs2vGe48m8RgMVqAPTm/JfrwC4CQsU/AmGZypa2Z75el38GwIfpGotpTEQEPMgKcXr4zFCNXuHYq4nrky0TwXcHnUJS5DIFooSEySNdIyIs2u/ntxaHKfGRB5z2ePc4m7Z3DJAWF7Ga0f5M0ui0HWqJrEKroSmCgp2tFaoYfTH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729369975; c=relaxed/simple;
	bh=bJThUEWG1+t9j7P15XRgfQfI1/h6Vs7V/Gt2u7FItJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhNG9zpC/j8v1baY72xnSjIHPiwuV7iNbi1AypaPAN3INxXqW5gLNZbaagGBNHl1+CJNswyrl0fAaJCkcj+r2rOLrJtg9yHjq7cRQ8IykXZzmNA1RPgddIo0w/rcUB11wImSgCzny97kSD571PfqkJM0FGywsyEI4GMlTvHxsoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcBmLRH2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d8901cb98so2748994f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729369971; x=1729974771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNSAF2YVt9nPu+f3L6phvZG/HyRYZLA36hwo/VBg3Vk=;
        b=WcBmLRH2pPuM895lYxs4ObWlLQoVQJygj8VVuACQjmPhBF6YqPullqn+B+rodPETzX
         cMS2htHg0giXVXLjqB94DCQLiCD8YwOAtGVWyzaBEr7sDEw7zT59L4o4ClX2Uq3IczGD
         TZLy8G1Id0zNt/he9Rae3yCmeIEC7E3QbCXSWfImi95g7n52Dp/+rxBHT5OkI4JYFMBK
         HcCOELFAdX0m9+7p0yspUU+SC23tagIsN9INs9ls3Hj7HWpvP+VI2c/dPf8UDDFCY/AQ
         3+LKdw2hJHrEeW3xzuqoFF8ZfUT4AlkBByuQTOpeLxQnTNV3Lg11yKGsxZiL71aKARbV
         WtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729369971; x=1729974771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNSAF2YVt9nPu+f3L6phvZG/HyRYZLA36hwo/VBg3Vk=;
        b=nFlVOwlyUdkb1zdKErhcfRWu46dStAhIBalqAi1O/uz8Q44fuwt//UeCWMA3cVYykd
         fk0Lkta4X95M2kOZ3MD2v6XtIpwcDCHWb7FXW4NK8WBmTELgAEUWpDfXRl6lGnBl7hpX
         /ZRO3EGHrby0W1e0V1eMwOnlOqgD9pNKZyogACmAbR743t+46ovzOgfJMOIqD5C4vhLl
         HQUfc0JmyTqXdlJF1Ue5cfRT/ExGOTRimSziARq0h8fg6rYMdp0P1S3na6MIsOW9FBkO
         UODiRKHTi1/vB6thFFGf+echWGP7DDf8CsusdY/2ujq8v+Y49PuYoyhcTcK6pjasUMHV
         NkKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJPu/VHP5at/jjnnXwfour35QyyWfQtMp4PyzH+TM+Y6N6YOWVPYtMsHFPgvf9KtLD9zHpT55VUsLuS0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaI9+X/5GbkP8h/+pKfrNequRpLulnqRN9Is11LTOqa6xCD0MX
	0TOCX+C5pXBMjaI5tvZ2Wfy4HQ+wmhDmfmUn1YyJ7AAUZyXeVba+
X-Google-Smtp-Source: AGHT+IEWyzayYGMJQLpshYPer1gVqLQR3xttK+cV+I+7abmQHdU4CTQ7JGRRYzfkRl+43W8uZZB6AA==
X-Received: by 2002:a5d:568d:0:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-37d93e24af8mr6583554f8f.22.1729369971093;
        Sat, 19 Oct 2024 13:32:51 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:f8f1:d6d3:1513:aa34? (2a02-8389-41cf-e200-f8f1-d6d3-1513-aa34.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f8f1:d6d3:1513:aa34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a58f29sm284695f8f.56.2024.10.19.13.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 13:32:50 -0700 (PDT)
Message-ID: <40e3ba82-6697-4ed5-a593-c54c6dcd2421@gmail.com>
Date: Sat, 19 Oct 2024 22:32:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: ubi: fix unreleased fwnode_handle in
 find_volume_fwnode()
To: Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Daniel Golle <daniel@makrotopia.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241019-mtd-uvi-fwnode_handle_put-v1-1-f5ef0d0cf9c8@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241019-mtd-uvi-fwnode_handle_put-v1-1-f5ef0d0cf9c8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/10/2024 22:27, Javier Carrasco wrote:
> The 'fw_vols' fwnode_handle initialized via
> device_get_named_child_node() requires explicit calls to
> fwnode_handle_put() when the variable is no longer required.
> 
> Add the missing calls to fwnode_handle_put() before the function
> returns.
> 
> Fixes: 51932f9fc487 ("mtd: ubi: populate ubi volume fwnode")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/mtd/ubi/vmt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> index 5a3558bbb903..e5cf3bdca3b0 100644
> --- a/drivers/mtd/ubi/vmt.c
> +++ b/drivers/mtd/ubi/vmt.c
> @@ -143,8 +143,10 @@ static struct fwnode_handle *find_volume_fwnode(struct ubi_volume *vol)
>  		    vol->vol_id != volid)
>  			continue;
>  
> +		fwnode_handle_put(fw_vols);
>  		return fw_vol;
>  	}
> +	fwnode_handle_put(fw_vols);
>  
>  	return NULL;
>  }
> 
> ---
> base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
> change-id: 20241019-mtd-uvi-fwnode_handle_put-7b220d2778b5
> 
> Best regards,

I just saw that the bug was introduced in late Dec. 2023, so maybe a

Cc: stable@vger.kernel.org

will be necessary in this case, right?

Best regards,
Javier Carrasco

