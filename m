Return-Path: <linux-kernel+bounces-565798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B67B0A66F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B7C7A8167
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603AF2063C7;
	Tue, 18 Mar 2025 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqmXqnJS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB7205E14
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288853; cv=none; b=jmt7vmYrAK+AwvM0spghTIUPdbyTe4/y6+461R/7UBT055XLSR8pYr2Z+ZYZdJpYjUEEB1ZOxwqsb5Xm2/bXnkJbxUhH+JPS/H/hajabTqv0hq7HudtKtJrE6M196IE/+VUO+EVjZX7phx/eY84TYQTz1c2xAnp9AhZXAN8qoQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288853; c=relaxed/simple;
	bh=l6B0jqIHL2vDeFSEeY70bKvuB+xpl/z8cjYjqfbVpDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBvD+zbfxMPHhoU/WHx005Gng1oCIN50lz8PLYbJXPYZD1nFeP+BCUWlVYv1xv4ADxcNb3NSTfxjCbE2i1Vw7WoyOmWUG4Df9VK5ha6lmFMcqh81U6AzsZZi0tuPA4nYhAq4DxCJVvTip24AE5lgd/elagv34jHQ1nXGNEHdZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqmXqnJS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742288851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yo+g6Y5JYSvYovYBPUfkeXwiqEKq7sb5tQYJYO0t0so=;
	b=VqmXqnJSHIvKoBf5dsVR7kFJR4KqpPEvGpdNnnHOdJwvVh6n2CMxhqKZcNqDTzBeJLOEfF
	QBiT4fpRMNzPsFPn1n62BgjAWep+MPH5y0swp8XIbCNqfWNm2EUCm+FNWDn07FF7MBjbWO
	Nda/fhGIcBHeC/nZxLOY3YvByMicGOI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-LFDj2D7DOV2c4bUB260pLw-1; Tue, 18 Mar 2025 05:07:29 -0400
X-MC-Unique: LFDj2D7DOV2c4bUB260pLw-1
X-Mimecast-MFC-AGG-ID: LFDj2D7DOV2c4bUB260pLw_1742288848
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso19052875e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742288848; x=1742893648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo+g6Y5JYSvYovYBPUfkeXwiqEKq7sb5tQYJYO0t0so=;
        b=d0CChhIUHZrLs4frdXJgw9nCXFRECmK0RD4Zb7whuNYF8IOg4/m5bfU8Km4KWQOxrN
         tKT6yELU9veftaz76ABnXrz2yjWKbt/ATeSD2/uKBRlmtiFvPSqiD2zREaLYaH5MMcWn
         PfEPWWGD4MtS7el/jfaLdALMjDIk8uWOGVjVH+77FjtpoyGOTD3sD+1lbt+WyvlEkIU6
         GrttmRqHcIUtBzasajWwJc3jSLr9C4aF8r6wzj8YB0CjhjBnQOtsQHaquRswbZSQbnXr
         lZ5KhE+mpL2nEUo2dVm0XvRWCCYiDcBUSyAHVPhhUfNwc3wQCDoFJwntOYO13/5xKJAA
         PZYg==
X-Forwarded-Encrypted: i=1; AJvYcCXZo7YeGzUN2ZBOtOeWxo/fEmioP4Vck3R2BotUQbxl6XJZo+InibuZMfj0Fu3RufU4N9vvZksbwYgF5EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTVo1BUEnUv4CfaxYTUbn1v7YEk0CGvbkQ33ng5ZMlsY0JT9uV
	J8uLUYqFd5BvBxtH5C1wIXiV1Ew3KqVbzKAbdZ9jnVcfs3sa7YWk44o6BRpjtLABdR4QwdquIyZ
	mdIB9q+xaAWkPOxtsy2lqawOZP/GO/1SyfoVetIiFohd1P3lcrcptRhFw8qjbFA==
X-Gm-Gg: ASbGncvc09YMK4bi/fkWD/0v1rb/PcoI31uhhoX/6+ZnTjlu++vV0FsgGq8gyKzYVwJ
	1MElKNFJw3ek/7bnh/edBDq0uItogDIsquu8ka2qNfRPsuFBclQXEI8tYUM66itQCQVr2PaaHxa
	Ptlz1jaPE6DmgF8Dd4xBS0dGPr2naW5jCSNqP9DEa7aPR3nUSnFiAkrV3IWWRdHUzxrw6QAbZqk
	KWbzBF12mKb0GpO8SFFohBJF9ZiZZb8YrwinJt/okAqjiyAahtWk49MGMjrKrTvO7mX0aq2NBqE
	MR/SOveWq6K0KovznOVFmPLV7T53a/5Qcl3KlTIW2Xzgpg==
X-Received: by 2002:a05:600c:3ca6:b0:43c:f8fc:f6a6 with SMTP id 5b1f17b1804b1-43d3b9865c2mr14528115e9.9.1742288848123;
        Tue, 18 Mar 2025 02:07:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAP9H22AYJdj0uDbu4gvGZP7VOolQZFkTSYP0cEoj9MX1qc8v/6DxYVuY8HV3lO4ZO3iRAsw==
X-Received: by 2002:a05:600c:3ca6:b0:43c:f8fc:f6a6 with SMTP id 5b1f17b1804b1-43d3b9865c2mr14527775e9.9.1742288847761;
        Tue, 18 Mar 2025 02:07:27 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe6a567sm130212415e9.40.2025.03.18.02.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:07:27 -0700 (PDT)
Message-ID: <0a221514-c150-4939-af40-220a7aaac1ec@redhat.com>
Date: Tue, 18 Mar 2025 10:07:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] ipv6: sr: factor seg6_hmac_init_algo()'s per-algo
 code into separate function
To: Nicolai Stange <nstange@suse.de>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310165857.3584612-1-nstange@suse.de>
 <20250310165857.3584612-4-nstange@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250310165857.3584612-4-nstange@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/25 5:58 PM, Nicolai Stange wrote:
> In order to prepare for ignoring certain instantiation failures and
> continue with the remaining supported algorithms, factor the per-algo
> initialization code into a separate function:
> - rename seg6_hmac_init_algo() to seg6_hmac_init_algos() and
> - move its per-algo initialization code into a new function,
>   seg6_hmac_init_algo().
> 
> This is a refactoring only, there is no change in behaviour.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  net/ipv6/seg6_hmac.c | 88 ++++++++++++++++++++++++--------------------
>  1 file changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> index 2d7a400e074f..85e90d8d8050 100644
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -380,51 +380,61 @@ static void seg6_hmac_free_algo(struct seg6_hmac_algo *algo)
>  	}
>  }
>  
> -static int seg6_hmac_init_algo(void)
> +static int seg6_hmac_init_algo(struct seg6_hmac_algo *algo)
>  {
> -	struct seg6_hmac_algo *algo;
> -	struct crypto_shash *tfm;
> +	struct crypto_shash *tfm, **p_tfm;
>  	struct shash_desc *shash;
> -	int i, alg_count, cpu;
> +	int cpu, shsize;
>  	int ret = -ENOMEM;

Please respect the reverse christmas tree order above.

>  
> +	algo->tfms = alloc_percpu(struct crypto_shash *);
> +	if (!algo->tfms)
> +		goto error_out;

Could be simply:
		return ret;

/P


