Return-Path: <linux-kernel+bounces-320847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DEE971146
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7AB283420
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DDA1B1415;
	Mon,  9 Sep 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCMDY2sI"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D6F1B0100
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869324; cv=none; b=fhOfYj7UoFbggvRaQxrpWaamOlmAhiiteyGdx9JkgX0L1lwSMmV6lryQ3v0cEIrtyFV6t5aniu94icADex3+eBRUopSPCnKVR+I+qLMzrK3BbtnDfqwk1inbDKIm8hTrn/12iuxlxkCKZIqVPcOFlTlZD69qPos+gP4C7i/QgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869324; c=relaxed/simple;
	bh=V5BhJfoI8DE1669LnYtPqVUItDPalk6JrarQkRtSgqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPH10sh/npJABMAvun1SO9pRmSwlPkqgmiZcQLO4Yo520WQiNa9W2Fq2URDVkh6MLji4rU2AZ+9F6NTa6agCXr8mH9IQRcY0ZveE6noxFqx5vHiRvN+boA+utPaRJUmoaGlXHCSXiHl8QQMsl273wCjfVVeXrTNKVWQXIw80rTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eCMDY2sI; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so4841632e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725869321; x=1726474121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZysygBP90xw0YfFSeVMvs3w7t7+9x3p5n611CD5diY=;
        b=eCMDY2sIXzcW4D1v9TFGL6cbPoSrzGY/z2CJFgJ1/Haj7tSssGKjrX8qzpcuFvaS51
         uLrxq0qx8QdF0dk1QkSyMvIC/qGGc7Uts21yq8nnIZlW9qRO9AZNFE5ubuU0QD9CG5Es
         S2IcLN1ZCe0u6TlWREfvAPEeGFuUBb/pHJXtkSjMrnxDb0e6O2QkjEthBKP29/OBrVvE
         iJ2kSVZvhdTAlgTo7cXDqqcIOTtNYfBMBH4V4+ksSVmhe8h698I9XESVo/7S86bfNRDk
         ZVNAOrg81eXeEt10gbhMU/+pEUv84wb+/SA4ZWxMaDW6J846mFnz9nsnm09kvXc/R2wH
         mYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725869321; x=1726474121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZysygBP90xw0YfFSeVMvs3w7t7+9x3p5n611CD5diY=;
        b=OBPekbsc/Way5WE9KZXblI4T4LM6UxoeSfKdNMZIWdccM7jvRTh/lICWKxeNaV9Osu
         bEwN0USfB3kU3IPjuTQ8w+n5QpOIjuXJ+h1bGfC0G3PdxUqw5tUSdWeOZq78HIFGAzwW
         gpxIrEtxYuosaBWXDabW94kOP81867/Se6B6Wc3kGjUN9PT9kFVnMqKp08CQOPhpTEY/
         R7pYzSPpkC++Ss4eR5hTwYg8/fPXh5LzWhV3s6fqI0ZMm2UbNO4CI/pqwhwdhOcW6WgC
         w47hV5j0XGQ3rAhRTC+Y2Ao/RIjBnfnJ4uaoiQGs4KiAqkOOKSy8muaIwe/wtg8jWpZV
         BVuw==
X-Forwarded-Encrypted: i=1; AJvYcCU9THlDmhGFSSJCyI4xXqGS0xWJ6ygEwj75QDx7NK5je1o0Sfjz/htp1fZKN7qhrfKF1RcPFyX8uT8Wkrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+LG8AiV9LH0gQnmhbPpAUzPbl4MRQzeqSE6yCqzjg90tmaERp
	IyVX+zZscs4QCYrpuaWXdims4MLrTBQlZghbPnw+D/3TAY89e7wt4+yuyNcX5fA=
X-Google-Smtp-Source: AGHT+IHcztwzp161pPkPxTg7Phfzj6aXh7Pftd14Z/cF9YHM4WDvI+mXDQKsiB5iZO7tWa85Ie9iJg==
X-Received: by 2002:a05:6512:220c:b0:535:66ff:c681 with SMTP id 2adb3069b0e04-5365881042emr5201914e87.48.1725869320025;
        Mon, 09 Sep 2024 01:08:40 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c6117asm304572766b.98.2024.09.09.01.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 01:08:39 -0700 (PDT)
Message-ID: <b2d0ce1d-fa46-43e9-bb29-c98d1161aae7@linaro.org>
Date: Mon, 9 Sep 2024 09:08:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: fix flash probing
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jon Hunter <jonathanh@nvidia.com>
References: <20240909072854.812206-1-mwalle@kernel.org>
 <ad9ee29c-b96a-4861-a7cd-b8649a3d1f3a@linaro.org>
 <20240909095247.48358afa@xps-13>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240909095247.48358afa@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/24 8:52 AM, Miquel Raynal wrote:
> Hey,
> 
Hiya

> tudor.ambarus@linaro.org wrote on Mon, 9 Sep 2024 08:35:23 +0100:
> 
>> On 9/9/24 8:28 AM, Michael Walle wrote:
>>> Fix flash probing by name. Flash entries without a name are allowed
>>> since commit 15eb8303bb42 ("mtd: spi-nor: mark the flash name as
>>> obsolete"). But it was just until recently that a flash entry without a
>>> name was actually introduced. This triggers a bug in the legacy probe by
>>> name path. Skip entries without a name to fix it.
>>>
>>> Fixes: 2095e7da8049 ("mtd: spi-nor: spansion: Add support for S28HS256T")
>>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>>> Closes: https://lore.kernel.org/r/66c8ebb0-1324-4ad9-9926-8d4eb7e1e63a@nvidia.com/
>>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>>> Signed-off-by: Michael Walle <mwalle@kernel.org>  
>>
>> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> This patch will only apply on top of spi-nor/next. It would spend more
> time in -next if one of you applied it to this branch before sending
> the MR?
> 

The patch is intended for spi-nor/next indeed, as the blamed commit was
just recently queued. No need to take it through mtd/fixes. Pratyush
will take it via spi-nor/next.

Cheers,
ta

