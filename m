Return-Path: <linux-kernel+bounces-300624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFB795E634
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB46D1F2139C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2CC1FBA;
	Mon, 26 Aug 2024 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M25mwsJY"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491333E7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635065; cv=none; b=DplhzgSX3yrIRnLrJHtmtCodN1Abcf8Z6vspiFTimSbItbERjIcta6286EbI46ooc6JlGqM8WqLY6NHOXQAlcI+ZrmCnfFzyJENPW28ejbPj25T6+ty0wVWWGvYg2mTLQAEvoUixat0SuTlRYT6Ym+19ihhCH7+ZImhmIt4EcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635065; c=relaxed/simple;
	bh=ezGCtAxcjcPK8pheEZEEdKvztkYND4uAspNgza6uDhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pE1eI5HnHMeqEnEoDgps8FdNL7s8KV/NvkFbj5H6V3ogantUU+UL/rtnU0oomFN13Ml6gqrV7NXqiSgPLLvDpw05PtbxZRM1u601kxEZqtm+toO/QkSBE56PMDSS76qsyZHeeXmUYjW4s9DHe6+FP7EdKHVmlKV37wplryX6N8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M25mwsJY; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f4f2868783so32084361fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724635062; x=1725239862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QxFDewXXFNunsztuQO0RvZBxeihd9YkWSHDT+saDUe4=;
        b=M25mwsJY19mKJsl6Hq0Jm4orVY+W3VugXcv7idQRAMuo2LLMYegnfuKfO9HFhXtb7G
         zuxzlSS2lADpcKYcQpryW5vJneybQeQgQkdtHraudylfvhBJmqiwtOHzkIVVysysusea
         TmeQt+AxljYqnUsghTgJr9R95djFoHiHEnGrZ6Gne04H+KHyyifE1vqwfESyizhdUmDe
         TV2P+/LTdC+QN5jdjpnpFZye+pzMVXYcSiti0miCt2pTndZpfFF9R07YgyqSWf4ndAjn
         89BFVqzAqXXU/2kuziTJ3sDk22FGwRbsGkG2qpoj4/GOrN1otFtQ6pRh5hmENVkYgRvL
         3hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724635062; x=1725239862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxFDewXXFNunsztuQO0RvZBxeihd9YkWSHDT+saDUe4=;
        b=lF5RQ4ZaOuNhsnCZaKDr/gDEB8/d9oFsPm8zSYvVQLFfx/FbBsFsUQQ8F7WkPJa1ly
         SuBMZDtVlEv8Zh4XvEW4JxO9i/XsWiPqYX8SBm+vAaLTE1Eu5zYGayIwYhJj0bGV1foA
         +LQADACQfQ9V4wECrOSD6Tl/omtv89TYthI7PLlMgpl0OUVCGy49d7u0ewXZ3+vDJ5Kt
         lZQVt2ql9R+S99dpoUqawKeeRByQE3XpSSoC3q8sOJwRzVWQSTFB+xiCXvf9QZthcs5/
         jUKG/yGi0IMbfpX9QhsUbjWvCwu1wgLRgWlXTm7CW+IrXthFN10slRnPYu1uzaGvmV++
         9Hfg==
X-Forwarded-Encrypted: i=1; AJvYcCUCXcGFEdXsgn67lroAetQmvI5MvqIJVQl8nPJfGTzrWtP6SawmN9I2R7MmzHncDJaO3Z9ly/rw6N0kvPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVCrM4z4sHW/m+oDi8VpMqWYODsrKporrcWD4fczR/VX3oTD5
	Tcxknv2rgDg2KiWtQulrmAvCE/1N5u2NceLbm9xbszFaC4r/MI5s
X-Google-Smtp-Source: AGHT+IHnZ7IT3cdohBhWPZ6YTHGuayfRidXmP/WHsf/HBFEug8GF9wIz0d/MIfigFSY8K3BmYWnoNA==
X-Received: by 2002:a05:6512:159e:b0:52f:d128:bd13 with SMTP id 2adb3069b0e04-534387bcf46mr5019071e87.39.1724635061452;
        Sun, 25 Aug 2024 18:17:41 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f39b5sm598277566b.193.2024.08.25.18.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 18:17:41 -0700 (PDT)
Message-ID: <7ab3f48d-841d-4d61-936c-9e5112a3aaef@gmail.com>
Date: Mon, 26 Aug 2024 03:17:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: Fix parenthesis alignment
To: Gabriel Tassinari <gabrieldtassinari@gmail.com>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ~lkcamp/patches@lists.sr.ht
References: <20240824144345.8873-1-gabrieldtassinari@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240824144345.8873-1-gabrieldtassinari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/24/24 16:43, Gabriel Tassinari wrote:
> fix parenthesis alignment in _rtl92e_qos_handle_probe_response to
> silence checkpatch warning:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Gabriel Tassinari <gabrieldtassinari@gmail.com>
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> index ad21263e725f..18739583f579 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> @@ -322,7 +322,7 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
>   
>   	if (network->flags & NETWORK_HAS_QOS_MASK) {
>   		if (active_network &&
> -				(network->flags & NETWORK_HAS_QOS_PARAMETERS))
> +		   (network->flags & NETWORK_HAS_QOS_PARAMETERS))
>   			network->qos_data.active = network->qos_data.supported;
>   
>   		if ((network->qos_data.active == 1) && (active_network == 1) &&

Hi Gabriel,

Please make your "Subject" line more unique. Consider that we may end up 
with having dozen of commits like yours, all of them referring to 
different removals and all without the necessary information to tell 
what they differ in (except the driver/subsystem). So it would help if 
you add the changed file or function to make it more unique.

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

