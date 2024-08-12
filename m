Return-Path: <linux-kernel+bounces-282852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE1894E977
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BA51C21631
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C6A16CD19;
	Mon, 12 Aug 2024 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWg67dbl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04CA16D32D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453953; cv=none; b=Gxm/g2bwgoqe8SLUTUsuUnXT4DY860ZGtbtyTRr2bu/lj3Hp4Py8LrvhDdFJcd4kbbIOLhoJ3BNrNS0/J4tvODd7km7juLZ7ITvXqDLA/5LanNvvt/nV7cWhuyPGR9whf75al/RQU6YhLHdqcOD4OlPk1fGSQQK/iF3r8He63yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453953; c=relaxed/simple;
	bh=Khm3nWFS9ZC/TfTWLB3+984Z3CcI8S5v1VR5r79ksBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOu74fRBmU0Vq3eDo0yBajdfdIB387MQNH0UNWN8QfkBI8iXicRUu5WoymRcePvrqArFnKAFdwauB7Wjgr06Y0fdf/3n9pkGgQZZiijscGGrkJ0+BX3cRgaiFON+ip156PBEcLHIs5dJ+jQKxSKTwcVcA49fGVGGqy4aZ2ABNCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tWg67dbl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso28606085e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723453949; x=1724058749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otmQtjUnHdhUFyCUXEQnuCmx4X7aHI52s1lrQeUIOKc=;
        b=tWg67dblmaxVhLiNmFu56GfGq45TZUYUkV0R/0Ey+Hy4F1QBQnImAghvcmspdvZbVJ
         3MEkMKHxZY45+Zmf19hvkjstnrAOsCXduQoAUdB6gDDG75qLX5eVn0MGfN3kf3m7TYIL
         tjZCCqH9CHthzK/hnlKUc0a4af5FPGpMtnDrrPcIPxLCJbJ0XXXHhOXO2URtum4FelE1
         jRhKld+79EAKtBjsiTNTYz17MrsjP3xWWEM/Npp5fEDi/mO+yfgdJnGB5NWKB2WyREL3
         SVtnx4X3O98+Ji20PJl60dnzt/TsdsYp9jKayKp93q2BS/H/N06I14Lq5wLhNG5Plzgo
         rYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453949; x=1724058749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otmQtjUnHdhUFyCUXEQnuCmx4X7aHI52s1lrQeUIOKc=;
        b=qFP+uB+Zf5+1cl9rAt8eEbSuQXexTpBm29Q4+HLJawVdXpWNnju5GMdVEW3FMEeKYd
         yUz8PPJ31sKZAbh9Wb9E+GYALlyvml0MOBJC5BEj25hmS4ChZOnOvDqs6ri15G/89ams
         zpnOe1XyYm3EMVj6hN8CDmGIp6mM4U82LWe1u3Z7ACvttSqcPml52e3CK2Csr7xT+geN
         xm5K1SoX1m3KPlSxehPFUnq7GCmn41NZGixz7H+cWXNgzXJpMhghZmqBXzIymC7GAPRY
         Shpg0g2IU0sk1mShfLYaHRgldHJl1eGfotgyZTzkK4I2QkfZxqhV0ZsLawcY1UpiUnut
         y1nQ==
X-Gm-Message-State: AOJu0YzL8QmaaH/mHgmXVcZzFL4MIMNX/kKyZecmGpSLKa24npX8YYDH
	bI72QzYCstXV2I0IJKZN0t4AtlxYtt7Azi8eapIn3zi2qd/JFFb75vJHcKL/ROo=
X-Google-Smtp-Source: AGHT+IEQhChTySXXAXyus4QQjPlrOoUKIwMOqwv3b3OCrnrDlEW8Ji+zatdgSVTR7qUKlPt6Zht0QQ==
X-Received: by 2002:a5d:498e:0:b0:367:326b:f257 with SMTP id ffacd0b85a97d-36d5ff6f2c3mr5494258f8f.33.1723453948717;
        Mon, 12 Aug 2024 02:12:28 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4f0a6d76sm6937701f8f.115.2024.08.12.02.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:12:28 -0700 (PDT)
Message-ID: <d8164311-83e7-4fb0-ab82-90e1a2762b01@linaro.org>
Date: Mon, 12 Aug 2024 10:12:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: configfs: Constify struct config_item_type
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <1011717e5ed35ec12113a0d8c233823e820fb524.1723368522.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <1011717e5ed35ec12113a0d8c233823e820fb524.1723368522.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/08/2024 10:30 am, Christophe JAILLET wrote:
> 'struct config_item_type' is not modified in this driver.
> 
> These structures are only used with config_group_init_type_name() which
> takes a "const struct config_item_type *" as a 3rd argument or with
> struct config_group.cg_item.ci_type which is also a "const struct
> config_item_type	*".
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>     text	   data	    bss	    dec	    hex	filename
>     4904	   1376	    136	   6416	   1910	drivers/hwtracing/coresight/coresight-syscfg-configfs.o
> 
> After:
> =====
>     text	   data	    bss	    dec	    hex	filename
>     5264	   1120	     16	   6400	   1900	drivers/hwtracing/coresight/coresight-syscfg-configfs.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only.
> ---
>   .../hwtracing/coresight/coresight-syscfg-configfs.c  | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
> index 433ede94dd63..213b4159b062 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
> @@ -160,7 +160,7 @@ static struct configfs_attribute *cscfg_config_view_attrs[] = {
>   	NULL,
>   };
>   
> -static struct config_item_type cscfg_config_view_type = {
> +static const struct config_item_type cscfg_config_view_type = {
>   	.ct_owner = THIS_MODULE,
>   	.ct_attrs = cscfg_config_view_attrs,
>   };
> @@ -170,7 +170,7 @@ static struct configfs_attribute *cscfg_config_preset_attrs[] = {
>   	NULL,
>   };
>   
> -static struct config_item_type cscfg_config_preset_type = {
> +static const struct config_item_type cscfg_config_preset_type = {
>   	.ct_owner = THIS_MODULE,
>   	.ct_attrs = cscfg_config_preset_attrs,
>   };
> @@ -272,7 +272,7 @@ static struct configfs_attribute *cscfg_feature_view_attrs[] = {
>   	NULL,
>   };
>   
> -static struct config_item_type cscfg_feature_view_type = {
> +static const struct config_item_type cscfg_feature_view_type = {
>   	.ct_owner = THIS_MODULE,
>   	.ct_attrs = cscfg_feature_view_attrs,
>   };
> @@ -309,7 +309,7 @@ static struct configfs_attribute *cscfg_param_view_attrs[] = {
>   	NULL,
>   };
>   
> -static struct config_item_type cscfg_param_view_type = {
> +static const struct config_item_type cscfg_param_view_type = {
>   	.ct_owner = THIS_MODULE,
>   	.ct_attrs = cscfg_param_view_attrs,
>   };
> @@ -380,7 +380,7 @@ static struct config_group *cscfg_create_feature_group(struct cscfg_feature_desc
>   	return &feat_view->group;
>   }
>   
> -static struct config_item_type cscfg_configs_type = {
> +static const struct config_item_type cscfg_configs_type = {
>   	.ct_owner = THIS_MODULE,
>   };
>   
> @@ -414,7 +414,7 @@ void cscfg_configfs_del_config(struct cscfg_config_desc *config_desc)
>   	}
>   }
>   
> -static struct config_item_type cscfg_features_type = {
> +static const struct config_item_type cscfg_features_type = {
>   	.ct_owner = THIS_MODULE,
>   };
>   

Reviewed-by: James Clark <james.clark@linaro.org>


