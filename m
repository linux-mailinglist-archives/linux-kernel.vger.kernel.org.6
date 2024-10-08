Return-Path: <linux-kernel+bounces-354878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73CC9943E1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D091F221F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A2E18B482;
	Tue,  8 Oct 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OM7wCO67"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DF18B474
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378860; cv=none; b=Rm7bwmVywH1uSaY/cJ2f4SSM/A/TuX/cRz8oK/PDjgjNqu7MgS6ebWJOCJmXfMf05soQtj7e1ITw4IsbOYYQwlEfnvqP9X9XVJIL/v7cUs9oUcRSLvTgh7gKIk+YcfsT3VDg1ObKmx9K2w7vjQElEe/Ck6u/eHyKpo2t2x2pvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378860; c=relaxed/simple;
	bh=h0XoJmnxeuzgLK3XsE5ue6QNSKsebyDFmi/AyV0doeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQCrQPX3D5thFacYWTiifE1+eROcUNw54kx7rvro992+N03KU+xbB+MnKBQS6LdhlQfMXcIQhnrE4gAapv6TT98bg/wq4iU2Djo+rjIPYKYj3u8HNzUdRlCNC0H4dEQCF7o7DSgfmpJFPiDr2VnDudAUgAHUKyJ/TRcNL/0aog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OM7wCO67; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728378857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gjzBqg5gmnyslj1f7FzCfy4oe6l+aeujhqIrttDmUiU=;
	b=OM7wCO675OHsJu1LLpzoknx+RXC/DWmGVw2N81q2wzQuZnguP9f5It0dcmnKWCF/u1VT2q
	eObk7+9opeNibZ2UWbrosJZCULLbNdLl774R2ZZ1oJ7KbfOdjI4/RUD0Ltq9jiyQqh4Awq
	mh3qgJBz3FHYhv3vSdH+cw1wcg9dcrk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Qil3omiHNsefaKb80m2mkA-1; Tue, 08 Oct 2024 05:14:16 -0400
X-MC-Unique: Qil3omiHNsefaKb80m2mkA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43052e05c8fso3128245e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 02:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728378855; x=1728983655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjzBqg5gmnyslj1f7FzCfy4oe6l+aeujhqIrttDmUiU=;
        b=p/PNX74rKKs38mHdKGswU6VBNjRFvvYxP0HD0r44QRpsOeK+MwHXhmAu+JTlIdzthH
         heJDiwmyjjXxNtyGVP+NZYb6e2GYIoYoyRwDV8hUKziI/er8Nfkz4dC4/XYDxgbGicwZ
         wjtwQMYXFZS/vzqB+Pr617Cl5xn3W50Xf7a/eGV0WxcJAKMauta0Eh1xGa1G3YAm4TyX
         sh8sVk78g6c646C6Tl/SHDABoKcbHP9gKHI6mHfQ8jXly3TydRu4A4FvfoWakgFS+xs6
         BBlk6PPqv6u/CiHT1MYejl4w59s4Sa/6X5AaXhpIt/iIuF303zVIwIHVGEFE2mIWmXP3
         4JuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjFnemVnck3xkInZL/AT3cS78vO0xkQ+uaz4KHkjAWJTJsscHGt4t/eNRVnP5rKQErYOTZ/R7dNtxVeqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3CjydluhYU8jcadgWqfKiuy4NHX33te/rdMUQ/UuX9lWX246e
	R6WLn7Z6y2kcXRGIAGI6vGATQC48mZLkNNamGdoskROCyQVrO3H/BEtftkfUfc8pOSbjKB79KUg
	ASEaJiyuilzTUjn1oZFbsM6mRiJJu9eo1M4+iHizPvspdXE7UdVewcsuTXHk31Q==
X-Received: by 2002:a05:600c:468f:b0:42c:af06:718 with SMTP id 5b1f17b1804b1-42f85aea086mr109974425e9.28.1728378855367;
        Tue, 08 Oct 2024 02:14:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEntxED6Ajev+yYqCnvqbFQbY5VYJc60hLz2Tup0O0K/v+7ozifBz2tuAGRqhC6j91M0iDvhQ==
X-Received: by 2002:a05:600c:468f:b0:42c:af06:718 with SMTP id 5b1f17b1804b1-42f85aea086mr109974165e9.28.1728378854940;
        Tue, 08 Oct 2024 02:14:14 -0700 (PDT)
Received: from [192.168.88.248] (146-241-82-174.dyn.eolo.it. [146.241.82.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec63c3sm102594535e9.38.2024.10.08.02.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 02:14:14 -0700 (PDT)
Message-ID: <6db0670f-6a39-4a23-94d2-5b944fea8dff@redhat.com>
Date: Tue, 8 Oct 2024 11:14:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3] idpf: Don't hard code napi_struct size
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
 horms@kernel.org, kuba@kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 open list <linux-kernel@vger.kernel.org>, Joe Damato <jdamato@fastly.com>,
 netdev@vger.kernel.org
References: <20241004105407.73585-1-jdamato@fastly.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241004105407.73585-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 12:54, Joe Damato wrote:
> The sizeof(struct napi_struct) can change. Don't hardcode the size to
> 400 bytes and instead use "sizeof(struct napi_struct)".
> 
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> index f0537826f840..9c1fe84108ed 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
> @@ -438,7 +438,8 @@ struct idpf_q_vector {
>   	__cacheline_group_end_aligned(cold);
>   };
>   libeth_cacheline_set_assert(struct idpf_q_vector, 112,
> -			    424 + 2 * sizeof(struct dim),
> +			    24 + sizeof(struct napi_struct) +
> +			    2 * sizeof(struct dim),
>   			    8 + sizeof(cpumask_var_t));
>   
>   struct idpf_rx_queue_stats {

@Tony: I'm assuming you want this one to go via your tree first, please 
LMK otherwise.

Thanks,

Paolo


