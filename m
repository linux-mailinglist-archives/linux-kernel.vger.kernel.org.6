Return-Path: <linux-kernel+bounces-409124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4589C8882
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8E8B2B4CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA5C1F81B1;
	Thu, 14 Nov 2024 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQ6flye1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370631F7566
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580474; cv=none; b=dSPW1U0KAU/vVNVzmsyQ+l/oMzvEwUKOJvDiXDKOtx+nuo1QhmJ5vbU6LU2txITTPXInXm4Jqaskae2H5PZrXXK8tiBYzaA9YvEm4FzcdN8Q8FYR453csLmawznkl0WBOtRAWhLqaDELaxsI1KKAEkjHyojl9jMmPCvTPnHt1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580474; c=relaxed/simple;
	bh=9NSyV8J37zkgSfT8SSmvC9IvYLYLgSb5DtAfbz6Q0DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J6rYu1Bjmo844QXRN6fVgHlLXzbyEWuLsfONMh7Oo7/qZJc7LseGFUu0yjG4yHu5SAOkYTQvXOCTGsFZBC1aQC2WGGYiX1O/VlZ9JWXDvcA4VYZMBa6pgoMtp6MVL5MUkPfTVtBxUqwMya4aHC/eUE7zoYhRuT6Oz+ZKCQNPbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQ6flye1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731580472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bL1TDm7rZCPU5Kay9rqCq9qcbgcAxYuCQTRJOnYP6n4=;
	b=iQ6flye19UEAkXWgvf5L1mYlyfdOpItdLEFy45m3bwlghAmhu1Obh0BMWizU2vyceahTEC
	fTNgqaGAQ6LTey5y1RxSJpzapJfDRBKPEm3laOCcki4SowQFFBiLbIq9eGMZdViVI7ZGin
	3WyjMtRAkfqXEAn5iVgiuVO455RjTrI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-hdRFRAVpPX2kPCFANef5Mg-1; Thu, 14 Nov 2024 05:34:28 -0500
X-MC-Unique: hdRFRAVpPX2kPCFANef5Mg-1
X-Mimecast-MFC-AGG-ID: hdRFRAVpPX2kPCFANef5Mg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4316655b2f1so3809705e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580468; x=1732185268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bL1TDm7rZCPU5Kay9rqCq9qcbgcAxYuCQTRJOnYP6n4=;
        b=mhU8hwk3MkQrqqm+GDhCl0A0Oi+Ef2ozIL3AYBMQWfzcN40mFBOXg5LdDSv8Hdd1O5
         U0Bqx6MeP3w9GhOmaRpMm0tLsiIaFXGx52nzzljYQjrnuOHuzjixfBuQe8wdgQea7Dud
         +B4jTtJCO3aI64doKf9du1I7DjqPS6pO5aQTfWvoRpayep1vA2BcKQX6ozZ0ImUTSB3E
         wXd7u8B9HcOslJlU/QxjljwbqvehsSVUZ3uvtp0QYMi/lF4sj5lKIA5LtHQSqY7GN74Y
         /IlunHm5S/+/ckvQs9d+yE5MRpi09G787VO2ai8HSkg1NX5eTmS8gedxT6ZQa6Y9Kxrn
         gqAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Qz10/TtHZNNmJqAq5GlAhZk/wfiX2vqs/BuiZiyhp7XzCoImXVsODk3qMko6oqdjX3i9z1hWaAi5TQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIycZn+ppu8v5+8dJj3KdxNCyPrzR5xwm1WnT3ImucOy8ga5Bp
	G+cVJjHcJJwhZ9zdyvAKvIuL+UL4mHRCVr93cYd/PDZvdb1bQYCbsd/zfa5hReYirGNMYzSFu9O
	Bwjux3TeGUotWxZpl+v2PldQz6joSape6RIFOulSIRXGoUHmqz2APaSxnps2h7g==
X-Received: by 2002:a05:600c:3114:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-432d4aae479mr58575515e9.8.1731580467704;
        Thu, 14 Nov 2024 02:34:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7QUd4COsmqD7s0A3KVqaPte+ZWjxjNIuWILigzUy4UQb3+ONujlZta3QocdY4DXgTqnCCCg==
X-Received: by 2002:a05:600c:3114:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-432d4aae479mr58575275e9.8.1731580467295;
        Thu, 14 Nov 2024 02:34:27 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0ae25sm15396975e9.35.2024.11.14.02.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 02:34:26 -0800 (PST)
Message-ID: <7914fb1b-8e9d-4c02-b970-b6eaaf468d05@redhat.com>
Date: Thu, 14 Nov 2024 11:34:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xfrm: replace deprecated strncpy with strscpy_pad
To: Daniel Yang <danielyangkang@gmail.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 "open list:NETWORKING [IPSEC]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241113092058.189142-1-danielyangkang@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241113092058.189142-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 10:20, Daniel Yang wrote:
> The function strncpy is deprecated since it does not guarantee the
> destination buffer is NULL terminated. Recommended replacement is
> strscpy. The padded version was used to remain consistent with the other
> strscpy_pad usage in the modified function.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
>  net/xfrm/xfrm_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index e3b8ce898..085f68e35 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -1089,7 +1089,7 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
>  	if (!nla)
>  		return -EMSGSIZE;
>  	algo = nla_data(nla);
> -	strncpy(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
> +	strscpy_pad(algo->alg_name, auth->alg_name, sizeof(algo->alg_name));
>  
>  	if (redact_secret && auth->alg_key_len)
>  		memset(algo->alg_key, 0, (auth->alg_key_len + 7) / 8);

@Steffen, @Herbert: I think this should go via your tree despite the
prefix tag.

Please LMK otherwise!

Thanks,

Paolo


