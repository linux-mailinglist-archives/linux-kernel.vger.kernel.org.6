Return-Path: <linux-kernel+bounces-434094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C789E6190
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFB9168623
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3201FDD;
	Fri,  6 Dec 2024 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uDmidVB7"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F4372
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443425; cv=none; b=nEjlwIuYGHRZv7Q7N8ylbSmRMGtoYBjxPw0txNO6E6KH6W5mHB/k/SnPqNfjvNG3hZi1SH428yCDB7ZEGfbLXDWQV17h5FROUG3LQyDAsdXJyXAI8FJnQdXUpRHPxtQewvXbA6//jyXPOC2a3lqtsGTsKHMy5G5dK6fRS63DbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443425; c=relaxed/simple;
	bh=qbCLbXOAmU7/fx5+PDIlZxfkhc6FTJSnBNp9tcZ/sBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJ6sWuYl69eZ19eTaDY7g/fBjURMZi3xDCO1OjmRT+T91oYLArP0uM+1R269s+yJNvOP5ex+6E3cKB+irAzZhSl/jdWfqx95zCA4l41pWVGl7zt2XT72e8S3w6PCkwNsd4+zLnua3KhBmwgTGvQ1byVqJnFXS9TlhtIhlQtMiwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uDmidVB7; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29645a83b1bso824274fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733443420; x=1734048220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5vFET2LxG5T8tpAsNWIDLmJd+E6eUUYCjL8dYpTWOg=;
        b=uDmidVB7oXNr/6cbSTzWwLQC7y8JS/D3KYhPUGf/10suZbkQLoqfDzjsPYTtP5MZs/
         uu6MutZQzAKT+FWYH3DqGL5RMLk84Ilx96t9EkMzK19DDW2FOs+gHfLrH5ML/Yu6Vjfb
         BQI1pvIAlv59LLnAyXRqlelNL1Sns4qQceDTUFjUml79geWGJABXPOhGjsdbwxXCS+uY
         uJZuPRUZHuCWvxnz9E622KMgp/bBh5AzNAJXrncQkeNFYgpAPdFhO1FdYmB5tGpvmKO5
         V6vaWQskXllB0zdabkVEbN8wseNbZ1PYiKLLNTmREbt1gZLhArY5E7NrPtExik28Tit9
         DO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443420; x=1734048220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5vFET2LxG5T8tpAsNWIDLmJd+E6eUUYCjL8dYpTWOg=;
        b=BvTYtB0jH8eY3uiy8K2YokUN1szjFcgiqk8axScNGPK8nmJq+jiAXGFepPq+RLcxJ7
         d0oMcUxgc8pV3LD06sTMTookUK8oK04OxfwlZRRoJn0kLa+5eEAlC8KPK90IsHdg1dnZ
         2eYjuOyctkSJ0B2TSIvdcA+19n3HfS1KJjcnBo3yxF88/C1WYqnS74hVJywPB1Zyvxkb
         /aEvYg50br0xD/Uy5VzUX+pVgIBg8SmGvCLvuh70CQgDTenFair7sd6+5/po/fB2bTT9
         A81qWXlFymkugEWg3IoEa0o0lley6lEbQqcrC9WzV70PdVkg8/zrqBBmRsuWzvCQkiQT
         mXsQ==
X-Gm-Message-State: AOJu0Yw+eTw2jzWKS2s4CAShawn1nVr/GR3TqriWH1jPO+V1yXjmv8js
	1ObTjy6kJBQ//x/6bnz+4kb+g9GwGzxzIOyBH4nCFNDIZfS0Oo7n+X5dKTx4JbE=
X-Gm-Gg: ASbGnctyo6Qsh+VcA0QYTFekCXe2SzkjRl+M/QLn2meK/myJV8rrgCkDfEHKD+OrNCC
	LQLrL8PgMHwBDwa17j9lQoVjoppHOWoA7y5SlWqNtNHfYv/CU3X1OkPLcU8SdJDM513rnmmjf9z
	3nrO6WW5cawW4kRhYa53oAsXheXNFadSIKjcV5xhQu+FNdhxqP/x/1RHxc27AZIFvxfB/gy0cJx
	KkttoWtkH5yXXmbGUWFUoSNIaaZ1s3kxBwiWevalkhIOmDFz4Fzue/Nil4MEO3WH0qbIuw4IVNa
	b2oahp/4d84=
X-Google-Smtp-Source: AGHT+IECYU0jj5jbbPl6E6YzHzZxPOVKClUUsz6XXsvoWGW5CsRwuTbkcIDj8EBTYuLuAoRMOO2XjQ==
X-Received: by 2002:a05:6870:6b99:b0:29e:1cd8:4a0f with SMTP id 586e51a60fabf-29f73283e34mr546914fac.17.1733443420263;
        Thu, 05 Dec 2024 16:03:40 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f56739df9sm587232fac.21.2024.12.05.16.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 16:03:38 -0800 (PST)
Message-ID: <5c2d828b-247a-419f-97a9-a77a6653e846@baylibre.com>
Date: Thu, 5 Dec 2024 18:03:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad9467: Fix the "don't allow reading vref if
 not available" case
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org
References: <556f87c8931d7d7cdf56ebc79f974f8bef045b0d.1733431628.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <556f87c8931d7d7cdf56ebc79f974f8bef045b0d.1733431628.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 2:47 PM, Christophe JAILLET wrote:
> The commit in Fixes add a special case when only one possible scale is
> available.
> If several scales are available, it sets the .read_avail field of the
> struct iio_info to ad9467_read_avail().
> 
> However, this field already holds this function pointer, so the code is a
> no-op.
> 
> Update ad9467_info to actually reflect the intent described in the commit
> message. Keep .read_avail to NULL, unless it is changed to
> ad9467_read_avail() in the probe at runtime.
> 
> Fixes: b92f94f74826 ("iio: adc: ad9467: don't allow reading vref if not available")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is compile tested only and is completely speculative.
> 
> Another solution would be to keep ad9467_info as a const struct as it was
> before and add a new ad9467_info_no_read structure.

Yes, making it static const again would be best. Modifying static structs
that are shared between all instances like this based on the properties of
a single instance is asking for trouble down the road.

> This way, instead of writing in the structure itself, we would choose at
> runtime which version to use. The main benefit would be keep this structure
> with function pointer const.
> ---

