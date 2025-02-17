Return-Path: <linux-kernel+bounces-517236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F4098A37DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A807A222B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3591A8F71;
	Mon, 17 Feb 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aRbj+VwH"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331D1A76D4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783451; cv=none; b=q5JBaM6bzv08J8RE7OobWSM+NTXtQVuGA1GVT8O7WdKV+9/AjoI+WsR+SvkTVwPT7Rhmi+Fz3Qg6W0mrjePwlQiJJYKXUZJpC7x3Y7rXAYAPPaxRu/Xmv+u+QcTSIXd1Wms+TaeYFSZF1rocjlyglK5GJ8+yFqfxh1nBZKprlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783451; c=relaxed/simple;
	bh=+8uc3Cl4FDkfpG7IvlrGiw305nAtrrtdyAjwd5EfOBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BY2RtM50nXFyBpQFvVb/Gc6/sMUy9u3N76k1YQMjUxC+vW4Y0r+xTQ2reoEQ9lhWXiDzxOo+4zip8YfYmhJzfFUcLtze/GjMzeUqCCkV5lts1YxM5Pe5rfSMCOKAYih+pJEo7Au/OGszgVGDdJvqMR06bJDQ9s4jX5sXD+dHTSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aRbj+VwH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb7f539c35so322155066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739783448; x=1740388248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fM64uRKLmrwWOZ1Ir+jCO/kphMaDgkxnNNITVcvwwUI=;
        b=aRbj+VwHE2odjl1FWHLcw2nuW8wMlVRUX6M2ZdpQq2ECkc32IFGrsw7mpJGhyfzYcC
         PnD3Xqf/nfjWZ6oh0XXcr1SnqG9bYEXviDGvKnRVTQkRSXYZ933rNu5hoH9vsfe6vzqa
         8pAAXcOAeup/r+uq+dfbEsBGTbKtZqAe5SRIMbrAiTgJIufQrewsBfhJY3rHSuHqNKxK
         z7i7IqJb37c+dDLEVo8Z7Z37TUzHDeKITNYvVo7AQLjQrCz7b9Y4U/WaPjybJmWT5hRu
         egNKek7CuzPLRqeWzs/Hf/eiKQhNxH/Atbr1GiKsHTtkS/fFoUWgO1RgH+SEsVtyYP2y
         1+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783448; x=1740388248;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fM64uRKLmrwWOZ1Ir+jCO/kphMaDgkxnNNITVcvwwUI=;
        b=m6efaqa9IjTB1lCIeobUEr/fpClo0x+NoD1tl9YBG6RN9JBYp3RY+gyUZiqFB7PbxN
         1ZyCmUoTiLQ7CF/N7mWy6tcbCsWk1AAkWYLoF/Xj3cymjcwc1OhWPG+eOONFjeQlhriy
         xKNqz1e2iFAPU0a5GNFQLCig3F7t3q5wkmn6aGzES5NVNKzpZ/wJTfRqfTKmwe8I3cWf
         Fy0q3c+ngu4veW/5ndu5CBrj5g0cQKKH3jT4QUO9zJxm4/Lr3lxQAHgPL1ftKOPe8LpR
         wwsIX591fphh0N2EYT55XQq0A5hvSb33o68HvJkB9UZPLBRMFAKmqqhUo3+aaNArV+mg
         wuJg==
X-Forwarded-Encrypted: i=1; AJvYcCVBzMXxi2D9KrO4aVbFmjtG8iQWe+Aqp6pzIJ2LBThAEJ/xczqDu+pT6c7ZKf254Rshn4rriXvLznzPppg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrP3EUzd5NWsqnYKpYSBPprA5AlcGxfwoXotivbR/VrjGIYvb1
	SNbXyyUB1MV/O73Tvfgwd5PEEuInX5+40e3cE3vZ3YnsZc/ScZOwPhFk0zW9OgQ=
X-Gm-Gg: ASbGncsVJ/Awicu93YVjxYFeCoKLCJswK+9iIjlu6Ezyirxb6r4sNIA5/oDih9xvknJ
	UHFOQbBWiPV8B4ZSD3yPFdcP5Ivv2ELwdKQztnlnfXcMPnDdwk96Cwhd6ykUpSVoKHaXLM4GgW7
	K2CMahMNBlIgLrhkWGPhTRAHjBUdlgIN4V8HNsNmIEyQnxRI4DcsTOtXGlA+S0CZKEBUGmdJ1l2
	Kr4+TUlSGE+N7jf12k+oJGJwb70ayZIed0m5zk2e673pe/OnkQ0ThwTfgsdQXBDl4lrHjvJiI+T
	LeKBeC1qa4l4xesjvPEb1g0=
X-Google-Smtp-Source: AGHT+IHrxbwT11nHlNtihnFEo6GxLB5WUZzVMCb1sDWISI6fMsTNPgPdGYggA0tSbgXZaPERaVzy5g==
X-Received: by 2002:a17:907:da4:b0:ab7:a5f2:ed22 with SMTP id a640c23a62f3a-abb70a7c9b4mr851455266b.1.1739783448057;
        Mon, 17 Feb 2025 01:10:48 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba3d765acsm91405266b.130.2025.02.17.01.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 01:10:47 -0800 (PST)
Message-ID: <116c9e5c-8bb3-422a-a52d-9d6d8c79e10a@tuxon.dev>
Date: Mon, 17 Feb 2025 11:10:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] nvmem: microchip-otpc: Fix swapped 'sleep' and
 'timeout' parameters
To: Alexander Dahl <ada@thorsis.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Ryan Wanner <ryan.wanner@microchip.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250210164506.495747-1-ada@thorsis.com>
 <20250211065223.4831-1-ada@thorsis.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250211065223.4831-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11.02.2025 08:52, Alexander Dahl wrote:
> Makes no sense to have a timeout shorter than the sleep time, it would
> run into timeout right after the first sleep already.
> While at it, use a more specific macro instead of the generic one, which
> does exactly the same, but needs less parameters.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> Fixes: 98830350d3fc ("nvmem: microchip-otpc: add support")

Fixes tag goes above you SoB tag.

> ---
> 
> Notes:
>     v2:
>     - Add Fixes tag
> 
>  drivers/nvmem/microchip-otpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> index e2851c63cc0b4..bf7e5167152cb 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -85,8 +85,8 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
>  	writel_relaxed(MCHP_OTPC_CR_READ, otpc->base + MCHP_OTPC_CR);
>  
>  	/* Wait for packet to be transferred into temporary buffers. */
> -	return read_poll_timeout(readl_relaxed, tmp, !(tmp & MCHP_OTPC_SR_READ),
> -				 10000, 2000, false, otpc->base + MCHP_OTPC_SR);
> +	return readl_relaxed_poll_timeout(otpc->base + MCHP_OTPC_SR, tmp,
> +					  !(tmp & MCHP_OTPC_SR_READ), 2000, 10000);
>  }
>  
>  /*


