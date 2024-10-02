Return-Path: <linux-kernel+bounces-347527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD8598D3E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57171282B84
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52561CFEBA;
	Wed,  2 Oct 2024 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6QoBIE9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44211E487
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874024; cv=none; b=MEYlG8KqdhSRU3geaHHPmcB9RhdR6HW6vWMrX9LweRsR6k+JGcTvBN2MXulHqSa7YcPJE8xjhHZp5O9bIQWkrlpwZRJza1R8a022n5QC25OLgrFYNJGZBoYJCCjD1MovLH3nsdBkYKRolYHtEbHIiD+OTNyZUmXc6OBSicVn1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874024; c=relaxed/simple;
	bh=d9mtQUW3MSAM9I+YiIpfV0t+pqpLZBUaL5LA3a+I/tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV0uKptuab35U3l3OI8cyMu3MuPaDMVnx0Q+sXqYpxgZZmwFKDgBP5qOH4g20O2ZiEvGiXRqmgzCw9tcaDBu6wwkFoGXt9+q0ShrkQvklUT3dEuWHuK/zG8CV4L1JYLW1T1WlzWdxFJyAa14BIMmyzH/J45AGPBtX/+ypMVmp8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6QoBIE9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso81822135e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727874021; x=1728478821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NMdIpPEQdZo5IDWuNHv072UJTqokJz4+ex0Kj+irrgo=;
        b=V6QoBIE9wZDem646eAIte+EQlAEa3Vd5pgGtQ+0GYSRiNIL995oeeslzKy6/l5Q0X8
         lGEyOfpxGHO5tOOwR1OcwQNGTierA1oD/GvomNBihD0EJPAHgLPIJzJWoCKa3S7zTwk1
         627vqlDb7TFeo6vuq36cFLHqvyrtWquz6xOEZfQcZCBE7RPpLfS60GdsAvEUg06J9PDN
         C9PRqzMpB4npxuo2zxyluA6c0TrrDq3XYjuoBRi2/SiP0AvUNGCIWpDyVs9XsGS/sv52
         WMkKbsbcPfVI19sKwxYnAyI4YFfo9RTWwW9ILgbNhxjgDOLPJTHdWK1NJ06QuPW7IZRc
         RRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727874021; x=1728478821;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMdIpPEQdZo5IDWuNHv072UJTqokJz4+ex0Kj+irrgo=;
        b=HXdzPuNus+NGy7AFFfZZBCzXOu12iaJd5f++IHv0umIlhhCX7JD1LulPJuoFNTBX3K
         YQN/UmrcAePGQHt+0+svdnN9i/5QOOYMJcgQ+dImqGXLhu5q51cd+BC+IiqPBTJilkZJ
         DqUn4gijcab4WoYqbdY+usAQBjxe3lRPyk3fR+LAoLMuDHNBb0Kqqf2Q9GTAc+EeUDgT
         Rchu/LYE1oBnAFO5j09tc8dz19wJ50GCshLdy5FASAKrh9F7ZmNJ84W1y2bPS3q2Zl39
         IplBUE5UrY4LFwUtwimgnN9bk4aS0nmmXdWpiFgfrm9W4f4qqfHttRrEyfe/o2eb38Rz
         HLvQ==
X-Gm-Message-State: AOJu0YzBnIQMt8OBJCCZ3a7bD+4t/+LBGU8MtXy0lSMrG6gOnX/Lhgt6
	CqSGHJuZ1gW7N9eluY1MbE6iQjSlloKxzs1YyeANHBoPHY25P3SW
X-Google-Smtp-Source: AGHT+IGVTfSIiYdjttST9gFTbzi69OdywRKKgdj+2TUzb6nIhogriwCeves4Qq7PWVI35rJcmC6+bA==
X-Received: by 2002:adf:f04e:0:b0:37c:cdbf:2cc0 with SMTP id ffacd0b85a97d-37cfba19c49mr3010871f8f.53.1727874020720;
        Wed, 02 Oct 2024 06:00:20 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.162.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5ad4sm865258166b.68.2024.10.02.06.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 06:00:19 -0700 (PDT)
Message-ID: <3e0c8b18-81ce-4c9b-886f-d7c50fdf4c3d@gmail.com>
Date: Wed, 2 Oct 2024 15:00:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] soc: mediatek: mtk-cmdq-helper: Various cleanups
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
References: <20240918100620.103536-1-angelogioacchino.delregno@collabora.com>
 <172786008674.33539.15432336067797076322.b4-ty@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <172786008674.33539.15432336067797076322.b4-ty@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/10/2024 11:08, AngeloGioacchino Del Regno wrote:
> On Wed, 18 Sep 2024 12:06:17 +0200, AngeloGioacchino Del Regno wrote:
>> This series performs various cleanups to the MediaTek CMDQ Helper lib,
>> reducing code duplication and enhancing human readability.
>>
>> This also avoids double initialization struct cmdq_instruction as,
>> in some cases, it was stack-initialized to zero and then overwritten
>> completely anyway a bit later.
>> I'd expect compilers to be somehow smart about that, but still, while
>> at it ... why not :-)
>>
>> [...]
> 
> Applied to v6.12-next/soc, thanks!
> 
> [1/3] soc: mediatek: mtk-cmdq: Move mask build and append to function
>        https://git.kernel.org/mediatek/c/2400e830
> [2/3] soc: mediatek: mtk-cmdq: Mark very unlikely branches as such
>        https://git.kernel.org/mediatek/c/21ab3dae
> [3/3] soc: mediatek: mtk-cmdq: Move cmdq_instruction init to declaration
>        https://git.kernel.org/mediatek/c/66705b89
> 

You probably oversaw the sparse warning email on 3/3?

As I oversaw that you already merged this.

Regards,
Matthias

