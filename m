Return-Path: <linux-kernel+bounces-347512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD5398D3A7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004251C20CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786981CFED7;
	Wed,  2 Oct 2024 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCeC+LG4"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61E198E7F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873553; cv=none; b=X8wuTZRxGBg0+Q3hBYdkBXOy2KgH/LyeY+Gg+0zC3gwIOsJUj1jphUFnBHRmtkQ2/GHpDAuiMdeBswhWui+SGFfCeGZWbTVVeuCI5PHh+ZlQi1Bn+fHwnyn/TMIaItoWd1bt3JZwdHDr4A2FJwxIJ//deF0bMOXql7Bxs+qlZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873553; c=relaxed/simple;
	bh=0Luwzbfs72rdPk7Ye1yKQ9otFH5z/vSaVzWUKvcurHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4mwlZ3UnkcQoAN6DZNLMvlKXLCcDvJcObOZbWGxPHL50kkQ+E2wY4qq7RBzZ3g2xcn4ruVFH1OFl+wD+wg13DUIBnlberfwOHdsZb1WAaZdxpD4ibNiR8BhI0vG0KIpon+5Xwp1nZ1uhs+EaMouGo8+Z0IIPnbeipK2BspdAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCeC+LG4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so8185533e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727873550; x=1728478350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1PbCagmKSyF5NfFazt3PlNiAfcyN7P8zftXuIOnLEJk=;
        b=PCeC+LG4f1fm4F0Zzhj913WDqexI/dZ5yJa6Mrx9e3xe5S5JShXsWs4A9nIaDB30My
         +JKIr1EjxYbuDgqyOlRRjw0DRWEPUvIPMzCUCLrQwljavBZnzjcdcfiFxU6dI7rVcWNo
         YvjZCcOzQ0U9/wsPg6HDx8rbaOvMgh4CVBQHvAAXFPPzX+kcFPtkKImPkkd/Jof5xYs0
         GotlbsV1wSTSjG5TZgR/xL30FSyKBsmHXQY9mGyYEHZGzI7IFDKpKgzufocdVEVuI1Zs
         asplhg3UVyRawb/Br/+X+5x8pqVnfAmwqJoVBoqFHr2dFkT1MLdTrSqUzIMpccdSss2A
         03ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727873550; x=1728478350;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PbCagmKSyF5NfFazt3PlNiAfcyN7P8zftXuIOnLEJk=;
        b=w9O6hUxx+FhGwpK9z3127XAsJvNdh0QgzD6gbBycCOgI6RyR7hZMPEr0D6MOBXMEoO
         8qfPOPtzS7JCBNSYQj1aAHo5zuWmvuw/naGh5t5GAWEZEmZU2PGBYKuEVyptEAAFEwsK
         J590sYOBHO3oUGWk0IIMh4znBQRzGBKLLJ5wA0x1mC2xXdtL0Al9RkaA+OPfCi+RljMn
         QtRPO1NyAlvOAND6GEnSXX8tUvpx1Dbg7jOyO3bQJ7fg9cKvWtrZSSj1H/HXcdf8NewG
         C0864Uy/PpZ0J5LEVA8T15vL+pDu+F5Q6EAtQZa4Ez3eAC6/1B+I8mJrrBq2qysVpDjp
         CqcQ==
X-Gm-Message-State: AOJu0YyeXmkF0V0UndMvo9CZ7xX6xFKAnVIKprBu17Hug8RhZHBT8kIb
	h73v4P1W8oVle6qy+t28i7HzpxuMXW/3AAbIjZPjBry3kGC8ry/+7KRt8Q==
X-Google-Smtp-Source: AGHT+IEkHmSoDixHs/VplPEvIUMIMClIFrcuXm8VLSW0qSt6KY1AQ5IoxFZ+eDLS86l5ehfDXsXI2w==
X-Received: by 2002:ac2:51ce:0:b0:539:9524:92bc with SMTP id 2adb3069b0e04-539a07a66fcmr2088738e87.55.1727873550108;
        Wed, 02 Oct 2024 05:52:30 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.162.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93d4bd51f3sm733367066b.92.2024.10.02.05.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 05:52:29 -0700 (PDT)
Message-ID: <e482ec86-c7c5-4fa3-b035-a469161b9eb1@gmail.com>
Date: Wed, 2 Oct 2024 14:52:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] soc: mediatek: mtk-cmdq: Move cmdq_instruction
 init to declaration
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
References: <20240918100620.103536-1-angelogioacchino.delregno@collabora.com>
 <20240918100620.103536-4-angelogioacchino.delregno@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240918100620.103536-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/09/2024 12:06, AngeloGioacchino Del Regno wrote:
> Move, where possible, the initialization of struct cmdq_instruction
> variables to their declaration to compress the code.
> 
> While at it, also change an instance of open-coded mask to use the
> GENMASK() macro instead, and instances of `ret = func(); return ret;`
> to the equivalent (but shorter) `return func()`.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 200 ++++++++++++-------------
>   1 file changed, 93 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 4ffd1a35df87..0b274b0fb44f 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
[...]
> @@ -474,11 +463,12 @@ int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, u16 result_reg_idx,
>   			   enum cmdq_logic_op s_op,
>   			   struct cmdq_operand *right_operand)
>   {
> -	struct cmdq_instruction inst = { {0} };
> +	struct cmdq_instruction inst;
>   
>   	if (unlikely(!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX))
>   		return -EINVAL;
>   
> +	inst.value = 0;
>   	inst.op = CMDQ_CODE_LOGIC;
>   	inst.dst_t = CMDQ_REG_TYPE;

I would add all members that are not based on left and right operand to the 
definition of the struct.

Regards,
Matthias


