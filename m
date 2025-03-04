Return-Path: <linux-kernel+bounces-545035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FB0A4E85C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A74880EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076442BEC4B;
	Tue,  4 Mar 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="Vm/wzv76"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D196299B43
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107022; cv=none; b=OQEUzxW2YYsEFRCF9eLY1KXPnauxmxLy8v1vGU9Eu+3rsOge7by2hEfox6KFOimY29DEwqkg2P+/voT1SY7HZZPRf366mSx4PJH8IUcaQlQv0QQZNe9x/JSngEglty3/pEkIm+sKpgs61Y9v+hYQWTdhGwbfFjIPi2k3kI1XAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107022; c=relaxed/simple;
	bh=zrUZ2K6obbHVLkq6hfv8AXP8IsKmoHtrwEOg1loa8q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F33mwqENiOLxQFfdwPA4pdK4CiiXP9SZZ8wHeK2LpL5dDWnLVwkKo0sb5xlVQjoNi8rS2GQlU7sUoJe0O3CKlVY2O9vPTaaL1GYS+YvDaSIslmjY/t8LkLyj3IyyIKm1YBEhxgzzBpkh3KMj9sRhxfX4yVFoiEOSEl5Il7kWqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=Vm/wzv76; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f674752049so863104b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1741107019; x=1741711819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7tkrL+e+a2YbJa4w+KDK4bewexCr454QdQiczaO5JMc=;
        b=Vm/wzv76ieaZX2hnFuV+tlHt5eOHLM7h2glXcGiJNmS61bTW0SrTX3IjGuHlADB0vj
         ASs7BlP5mpkZO8Lg3dM0nY8YGHRk+j3vg26a8KkmME0hMZlx9liGM96dhIvjAtn9w2m8
         2+lEbD3u2sGg72n0q3/WoX2HawQJ5JXBKZ2QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107019; x=1741711819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tkrL+e+a2YbJa4w+KDK4bewexCr454QdQiczaO5JMc=;
        b=sbcNEpdVheNQ1J9DPr/PuiNKhkRleR5H+m1oqNDqEPOMifVBxuKaYbcIKawkU/+7gC
         Vf9enfD3IYaritNt+7TTu5T0XlBmL7PQFmfmc3Lzwo1Owlsji5doxjX4SsK6bw7VZ8CO
         wZR8faw+WccCGh7ZjbgBi0MZTdLF+rdGJn+bcSfgzaG++7afSAn6Yf54M4UsMFTJJG3M
         FtPFrcTi3k3EXqp9ioMGD84q3jYk/A2isjB4/28xm033s1HBNA2L9sd2O0MMuTYxs1so
         xU85oqT6XBnnVcKvDqeS4gtYQ2yj86zLaRW0JZIt5eF61brwO2hqPszX54WpfZ9IS8MX
         JgTg==
X-Forwarded-Encrypted: i=1; AJvYcCWp0VP/nIHoDIXeP3qgSeMrO2Ydmcm52XKOfrXZN2U7En/ZPimZONnEwLhPWp83P/RJ6w5/sePAkXBS1ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZg+uLlXNcpJeiOYHg2wkDjGFgTMOFZ0KAeXvP+m8sV2zr+uE
	zmF+jTJeoTXkaDa36/2yeV8TmOAN/Td3YkvOxQhR46+by54isP13RcJO/GV2DA==
X-Gm-Gg: ASbGncsDVLgLag8uv3et/e1Rwle9Kbt6DlvKlSdFRalnu1aWZdBYU9knVyT/1NNdPSd
	ZjBqiRfZzPcp/2hUd9Ou1XamM4nL8aLJ+dniyBaix5AmAnRKtpQzbveymLG2lN14gGPwZcmFPYX
	eafX84ht9oa3hUw7Wztei9itvXPIBABayv+LSYx7TRI52xr8NEpG+kFm4W0ExT2p84VEYgWGNhc
	8v+xHB3l0RcG+ysDcZUjEx47Rg/OlUga22k0IzHm78IDRHuKQjlOHxO+adO8oIs7+0QCaByChfS
	3tMsb57lNLGtz0UaZM4FlGLGgyJQA60OgNgQhdsfgqEM3YIiXgfRlfaxgeDjxC5kt0EDf3CK1on
	Adhg=
X-Google-Smtp-Source: AGHT+IFWGzlfKIJoQMdZwPV2HzDzwdowvDtxXCUhLVhv6U+fgKXlNTeZeV9ExhknYcVynokP8VXzFA==
X-Received: by 2002:a05:6808:23ca:b0:3f4:cf:5d5c with SMTP id 5614622812f47-3f678f4ed49mr2747867b6e.10.1741107019054;
        Tue, 04 Mar 2025 08:50:19 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3f5506a0b92sm2255999b6e.6.2025.03.04.08.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:50:17 -0800 (PST)
Message-ID: <2246f041-3e42-4534-bf89-3630ca2426d1@ieee.org>
Date: Tue, 4 Mar 2025 10:50:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: ipa: Enable checksum for
 IPA_ENDPOINT_AP_MODEM_{RX,TX} for v4.7
To: Luca Weiss <luca.weiss@fairphone.com>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
 <20250227-ipa-v4-7-fixes-v1-3-a88dd8249d8a@fairphone.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250227-ipa-v4-7-fixes-v1-3-a88dd8249d8a@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 4:33 AM, Luca Weiss wrote:
> Enable the checksum option for these two endpoints in order to allow
> mobile data to actually work. Without this, no packets seem to make it
> through the IPA.
> 
> Fixes: b310de784bac ("net: ipa: add IPA v4.7 support")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

This makes sense.  The checksum option affects how outgoing
packets are formatted and incoming packets are interpreted
by the IPA hardware.  So with this being wrong, I suppose
packets (one way and/or the other) might just be getting
dropped as invalid.

This looks good to me.  I'm really pleased you were able to
get this working.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/net/ipa/data/ipa_data-v4.7.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
> index e63dcf8d45567b0851393c2cea7a0d630afa20cd..41f212209993f10fee338e28027739a7402d5089 100644
> --- a/drivers/net/ipa/data/ipa_data-v4.7.c
> +++ b/drivers/net/ipa/data/ipa_data-v4.7.c
> @@ -104,6 +104,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
>   			.filter_support	= true,
>   			.config = {
>   				.resource_group	= IPA_RSRC_GROUP_SRC_UL_DL,
> +				.checksum       = true,
>   				.qmap		= true,
>   				.status_enable	= true,
>   				.tx = {
> @@ -127,6 +128,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
>   		.endpoint = {
>   			.config = {
>   				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
> +				.checksum       = true,
>   				.qmap		= true,
>   				.aggregation	= true,
>   				.rx = {
> 


