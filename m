Return-Path: <linux-kernel+bounces-347496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F39D98D371
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F5A1F22FAE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38521CFED0;
	Wed,  2 Oct 2024 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwUrVi4S"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850FF1CF2B6
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872888; cv=none; b=s57fmZSlpMdI3YrOp3dw1LFxuzMvuruj8EBmegprQDOH15aFiUrRCgSTqIdcOVqCnW3gCUOH7m1vBtji0J9pqrWo/n/7Y8cr9AjLydO7exKHAhLqEzILL+EXndqCsT8A0zO9H8gQTw8Y5+CcpnMwekANzTWAGQnRw4xzF+Vi+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872888; c=relaxed/simple;
	bh=lXHLcSOKFMvGv3YZXu3hUiORtPtZ9sh+ZPRF9UK8dms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYIgz3Nj9Qm6MVOKHytOBuZ+K2icW3R/hsqjhqvct0/ZEhLkqkZOG7sGA++5/SLjAZYbbr5EwQmxskuU5J5Oovwldk/5LoZzGAvC3PWlFtBO5pmoAjmYrE+zm+sbKhGCO8DhkQRyzBUoWavdgrNGXSbkAW313h8TAR8C+/eFtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwUrVi4S; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a83562f9be9so125555266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727872885; x=1728477685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WGFeasz9wTp+KifYsefeXZhkjBggefuf6eAiKnNEW7w=;
        b=HwUrVi4SZPyt1D8ZcpiQvmJwbDmIMXbqGgEeTgCLn04ldwPm6tWswAyDWiOP5x9Y9Y
         G7Jm88kEy/gGa24KAeXnrq2+0TU4jQ5ur/BWuzxRtfAdnjt0N6HIQfpSn0mY2ahIdLNC
         hdEjl9VN+1OyRGsAMdWfBCn372atssYnRugIhrKezR2yD/r4SclUBq7wcAwiBMo4FY5G
         C6m1OsO6S2w/IUWwKK2nWUkMqH6O8Cs9XIbdUUb95lg5VM7I3ZczwwUHQv6Wd49nFpr3
         f0xNyaB+YL+7xHiRF2vV47X/AjOtXI5qlijLd8NCLAONACdLs46wF+YeucVn2iIwAFZK
         rHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727872885; x=1728477685;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGFeasz9wTp+KifYsefeXZhkjBggefuf6eAiKnNEW7w=;
        b=DNcl2rM7u+8MQ0B8qiZsoWjmlUzJHuICK96Yuq/z/kbJcbt6hpA05i112GpYp/rq0d
         eOFVfZs10M5+y98AT//+ZCED/5SAk8Rt+8U0pIP/qymgH1zu51CaulV6L7wGdkWnhFHB
         2srcsvgaIFHnnuFZMINOyk1Avshj2QhOrla+XH0smqo3xohkZ64HfHfdALnGBnqm4v89
         kRecW4+HJaO0zmCM9d0l4Xp8zwZ2u0Fno7PEDtLSHE20Cc6uA7Dw2muYFM6ZripJPD8w
         d4UBaBabkTRCDsDk8vTW2OOoz32K0W88GW1LSQ6yjy5D54R3O5pmUqnma66HEpXEAZyF
         /DVw==
X-Gm-Message-State: AOJu0Ywoz9YjB1Gr+UOkuLMCJbdBes8/45pZALxQPWysk+FDODOhMU+w
	EOUP9Ib8CFIWzOO+FV+1TsNuASvylOTSzebYw01u9pAMTZZKMV3I
X-Google-Smtp-Source: AGHT+IH7Iy/7MHhUhc2PJud/HQBsRz2Eutqpbf/tCaaVc/Tk5iOkfD3ixjM0EruE2rJ2f2bck3ImAQ==
X-Received: by 2002:a17:907:d17:b0:a8d:439d:5c3e with SMTP id a640c23a62f3a-a98f8262880mr277838766b.30.1727872884691;
        Wed, 02 Oct 2024 05:41:24 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.162.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c7237sm858830866b.81.2024.10.02.05.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 05:41:23 -0700 (PDT)
Message-ID: <7d577541-cada-4f6f-8e83-c420dd0e9382@gmail.com>
Date: Wed, 2 Oct 2024 14:41:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] soc: mediatek: mtk-cmdq: Mark very unlikely
 branches as such
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
References: <20240918100620.103536-1-angelogioacchino.delregno@collabora.com>
 <20240918100620.103536-3-angelogioacchino.delregno@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240918100620.103536-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/09/2024 12:06, AngeloGioacchino Del Regno wrote:
> Calling cmdq packet builders with an unsupported event number,
> or without left/right operands (in the case of logic commands)
> means that the caller (another driver) wants to perform an
> unsupported operation, so this means that the caller must be
> fixed instead.
> 
> Anyway, such checks are here for safety and, unless any driver
> bug or any kind of misconfiguration is present, will always be
> false so add a very unlikely hint for those.
> 
> Knowing that CPUs' branch predictors (and compilers, anyway) are
> indeed smart about these cases, this is done mainly for human
> readability purposes.
> 

Are you really sure we need that? As you mentioned the unlikely() is probably 
useless as compiler and branch predictions will do the job. I don't see the 
complexity in the code to have this annotations for human readability.

I would argue against using unlikely() here as, in general, it is discouraged to 
use it. We will just create a data point of doing things that should only be 
done with very good reason. I don't see the reason here, it will only confuse 
other developers about the use of likely() and unlikely().

Regards,
Matthias

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 620c371fd1fc..4ffd1a35df87 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -336,7 +336,7 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event, bool clear)
>   	struct cmdq_instruction inst = { {0} };
>   	u32 clear_option = clear ? CMDQ_WFE_UPDATE : 0;
>   
> -	if (event >= CMDQ_MAX_EVENT)
> +	if (unlikely(event >= CMDQ_MAX_EVENT))
>   		return -EINVAL;
>   
>   	inst.op = CMDQ_CODE_WFE;
> @@ -351,7 +351,7 @@ int cmdq_pkt_acquire_event(struct cmdq_pkt *pkt, u16 event)
>   {
>   	struct cmdq_instruction inst = {};
>   
> -	if (event >= CMDQ_MAX_EVENT)
> +	if (unlikely(event >= CMDQ_MAX_EVENT))
>   		return -EINVAL;
>   
>   	inst.op = CMDQ_CODE_WFE;
> @@ -366,7 +366,7 @@ int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
>   {
>   	struct cmdq_instruction inst = { {0} };
>   
> -	if (event >= CMDQ_MAX_EVENT)
> +	if (unlikely(event >= CMDQ_MAX_EVENT))
>   		return -EINVAL;
>   
>   	inst.op = CMDQ_CODE_WFE;
> @@ -381,7 +381,7 @@ int cmdq_pkt_set_event(struct cmdq_pkt *pkt, u16 event)
>   {
>   	struct cmdq_instruction inst = {};
>   
> -	if (event >= CMDQ_MAX_EVENT)
> +	if (unlikely(event >= CMDQ_MAX_EVENT))
>   		return -EINVAL;
>   
>   	inst.op = CMDQ_CODE_WFE;
> @@ -476,7 +476,7 @@ int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, u16 result_reg_idx,
>   {
>   	struct cmdq_instruction inst = { {0} };
>   
> -	if (!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX)
> +	if (unlikely(!left_operand || !right_operand || s_op >= CMDQ_LOGIC_MAX))
>   		return -EINVAL;
>   
>   	inst.op = CMDQ_CODE_LOGIC;

