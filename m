Return-Path: <linux-kernel+bounces-362204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA3E99B212
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DCFE1C215B2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2F614601C;
	Sat, 12 Oct 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hkHYWU4A"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEEC13213A
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728721450; cv=none; b=n54l/Ei36nQaKGVoKp+KB67c1fObrxTX2BNScK/zG9Ta0QyV1phuqcnecQfrm3YIxuCSCD+UCjQIcPf7oQpdog+AQMNJyAcRN38aJRaTQaAvCkWK7lLbo0pbc/exzECSsSeMMvVhpzX6GjedNByVCtU7lWrsDLuS3vNGMbyACYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728721450; c=relaxed/simple;
	bh=O1XrseMxKPU3CSygOcpj6EQy4x8ye3XrJ2wkPTMw+Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHtix7CzzoOMkE36LUWikOi9WWBlXj3EReYeRsEBMHshIdAhx0O97dDnABjEB3D97oqH3G7bC08XA5FiWyGzF/Seb/e9tskhQl6p3O13aj2aiYB95u/xZEfRLmAHwkEWrTnNGaveVE5RO4a79847VQFz9H+kjeiPZgFn3qoQV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hkHYWU4A; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e52582cf8so75945b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728721448; x=1729326248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQ0uJFCIUzT5iNpWEa5laAuFLJ9LFFMlsGAFCSG8b8k=;
        b=hkHYWU4Avxi60h+/2Xexun7J3RCvyIwGHDUyXbjJ3kFPqSEPTLbzIOU/Wkhc8uO25V
         wYeaqoF4QqDFZNQK2qctaINZl7hc376LqAgWMmBp0/kmZ51z3AIcSmB9HQXXXIdxHhop
         hQ+oMZA2CN5b5MCRzAK/N3CUN1B2XltOyxOQXX4SIy4Uc/lS2Ja4/gnWxeIh8ZxmVdBs
         F3O+QcN4WGUGBL2XqOTkB864gINGgCykEPi+70tliIx8+6vo7MIMh5t/NKqs++BJIBMd
         GMkwRJdZOhHheNkbC5heiNibxOoNDD1M9ku5fmdcBmm4MMWfEvgle7FeVw0W6lZNWOPM
         lmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728721448; x=1729326248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ0uJFCIUzT5iNpWEa5laAuFLJ9LFFMlsGAFCSG8b8k=;
        b=hH1v6p6qHVHesp0kTd+RCh7zsWvPiNMK5WnSbIC7U1IyturtdAzDpmiLbP/mWPH9BX
         nds2Ka+jWY892/dGIz+efnwJRVa6aNaqriDmRon6ICl+197axmUVNgHpGbeK5AejOo2G
         Or9dTE0t1yYD4iMQRCfgLIRwMx9wEFH838z2/TBMJKYI//8y30oFkObnK3m9mC22CTyh
         b1cALu1i1QoFwH+T1hSYPqhb5HnEXnptXmKc81dxGpZdfE3RL93XVbvjzzjCb9kt9SvB
         YdTwpIfT4AaNFdGy8IOrLjH++LQ9JgdRPk3jpUZyD+WDFDyIpkpGo9NnpwAtW7v5MmVR
         dpHg==
X-Gm-Message-State: AOJu0YxnAj/Bp/taHf9g+f6YeNpHDz8dHk5xvXVmCT/p5OJ4Z/vhuj6G
	cesffsEPP2Kw/mjYP1pMDAWfNqySEhihuTwKImvsu2OdQzgUTJtAxzfc4HFkhqM=
X-Google-Smtp-Source: AGHT+IGIAD2RleNINJaOlV1Ndb7siGou9hMwoYmXRnCufbaqLw2AzkPv1vfWjneW5pepG/UvMddXsg==
X-Received: by 2002:a05:6a21:1304:b0:1d4:e56e:93b5 with SMTP id adf61e73a8af0-1d8c9594fa2mr2733839637.16.1728721447658;
        Sat, 12 Oct 2024 01:24:07 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f6982sm3764098b3a.77.2024.10.12.01.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 01:24:07 -0700 (PDT)
Message-ID: <870327e4-2391-4f42-82ad-2d9593a70ebe@bytedance.com>
Date: Sat, 12 Oct 2024 16:24:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: virtio/akcipher - Move a pointer assignment in
 virtio_crypto_rsa_set_key()
To: Markus Elfring <Markus.Elfring@web.de>, Gonglei <arei.gonglei@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-crypto@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Nathan Chancellor
 <nathan@kernel.org>, virtualization@lists.linux.dev,
 lei he <helei.sig11@bytedance.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <80b91321-138c-41de-95c7-47c3be07fe76@web.de>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <80b91321-138c-41de-95c7-47c3be07fe76@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/12/24 16:06, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 12 Oct 2024 09:51:58 +0200
> 
> Move the reset of the data structure member “n” to a null pointer
> into an if branch so that this assignment will be performed only after
> a key parsing failure.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index 48fee07b7e51..56557d4778b0 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -355,7 +355,6 @@ static int virtio_crypto_rsa_set_key(struct crypto_akcipher *tfm,
> 
>   	/* mpi_free will test n, just free it. */
>   	mpi_free(rsa_ctx->n);
> -	rsa_ctx->n = NULL;
> 
>   	if (private) {
>   		keytype = VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE;
> @@ -365,8 +364,10 @@ static int virtio_crypto_rsa_set_key(struct crypto_akcipher *tfm,
>   		ret = rsa_parse_pub_key(&rsa_key, key, keylen);
>   	}
> 
> -	if (ret)
> +	if (ret) {
> +		rsa_ctx->n = NULL;
>   		return ret;
> +	}
> 
>   	rsa_ctx->n = mpi_read_raw_data(rsa_key.n, rsa_key.n_sz);
>   	if (!rsa_ctx->n)
> --

Hi,

This change only reduces a single assignment on a key parsing failure, 
however it breaks the original "free a pointer, and set it to NULL".
I prefer the original style.

Lei, what's your opinion?


> 2.46.1
> 


