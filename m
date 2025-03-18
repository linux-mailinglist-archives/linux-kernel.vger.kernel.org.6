Return-Path: <linux-kernel+bounces-565758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B96A66EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B75C3B47C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433C3205AD2;
	Tue, 18 Mar 2025 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNAoOac+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A70204C34
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287386; cv=none; b=jMvCVsKHQYz00wyBRd2/7/UUN6igTJMIo1vUB0mXt4Yt9cRBEDEssuF49vPzbBTiy68CQ1oS4rcOnnLuP3LmjI028e0E/DD0qaAS2En+6ct9KbB6yv68WdMxkZe1W18dooLhot9CIuOhRj/Ck8IbAM+vp0khjN8YOrfAEZlV4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287386; c=relaxed/simple;
	bh=aVuqaNznx/5mZdLJC0vjrOwYEAxdll74BF6plXLxd1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukwVzzDlZ1T6+rG5gIv/pqgHVUO4Sa13CS4Zf7qvGVuuN1A/nAaI1d81xGtjqqlyJFkwvhfKtnl54AG0Qa+HIGVQKHhQWOVlRxRpn/3YGvyfO2H5AIjqJZq7Y88lURofCOXLiOshi4PvboRDsy/09E+WOV03TdZp74Z4wR/fD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNAoOac+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742287380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+9EOSMwZ0yperbosZq+EsQ8tvp7eSF9vKmD44NR3ec=;
	b=ZNAoOac+ui15git0iI76lBEcpnJE0gLehfb1wWXOnKt2YSqc2lbkcsDkZnIalOyF49SFJb
	NjcfA0SWQKKlpcpibjcP8+CaLXfL2+pC1o/7rL8+oud7n7nAZX0l/fE762uc+Yq0XvLrEG
	vR30CKGN1oS3MRU2jyPvGOIS+rn/W0k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-M3z_kWVlPhCmv-D-1-CWXw-1; Tue, 18 Mar 2025 04:42:58 -0400
X-MC-Unique: M3z_kWVlPhCmv-D-1-CWXw-1
X-Mimecast-MFC-AGG-ID: M3z_kWVlPhCmv-D-1-CWXw_1742287377
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so18777105e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742287377; x=1742892177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+9EOSMwZ0yperbosZq+EsQ8tvp7eSF9vKmD44NR3ec=;
        b=B4C1Gq/VVOERiQNXGS7LIkgdTqdOO1VaJxBxsLy36BCw7Zfsp5xjpUeDWxktqc2GX0
         rMLycwTEubup3dlSledV406aUY9JFExL40V+7V0nPZPHFhv5AnKjGMUbAq1mhpSiw0vB
         DeW119SGWURZB1eVTXTuFY8sHah9SYT24cXWaofTfIg+cL11bZg5njKJRsdwiGv44Bvu
         R/vuIeK3EssYJxO1y7rk+MyA6PJ6LdYb/5VYbMjxMamnTCsbMPr34fr9LPJQGrkvtr6u
         RBUhlC17fpiTagNdJD4ceYTCaXTsagsekivg1Od53bAQeNKICUW6FzN6K/mAzskkf5rp
         BNig==
X-Forwarded-Encrypted: i=1; AJvYcCVgqPNDWxq1fta6iiSh+7r7iPQA4kl50UyOTTOwcjMW/obdoUAJDpL7DVHCn8ZlMPLeV5i/fNnmByMg5Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6cfJqZiZNG9ng5Pw4Zs+6esWv8BuIyckCPGDAQFqOqQSNQqjI
	gHwnuC9EtC+PgkLjgkjnmRwMFaoukkcJXONIhICx96j/tWzp9N1f4OnJtP4QWzDgD6L7Ibr7zbD
	G6dkvIjXb8h1NJDTVNfDEKeWGVGZafKeIcM/qfSTUfP1bGDefh+CkdljKdl1EPw==
X-Gm-Gg: ASbGncsO3SxnYt1Xf+SokzkbpTqryaiNw/Qh+PXu1/9UlWkrNpxAOzC/HmiNgd3wA0V
	Y2V307TPXLKoH4Gz8RpaUws08fzXGYKOX32InNnm68pxebcRHYPiJ2i1s2p8aCAzAjI4Srlkl8o
	tJrwgyCufUEVb8cvxfaP5cxI9g+fPKVTYUjgSLJXTiHM2g+j8iubvisUwk+drNKbAfj7IS+g/mo
	gSqGVihYNeSzGAYq9CdNNiefEWpArlDvpobfuGvxmco+J1YGwDz260+s6+8K6pHbWTYDQf4edDR
	3B7MO9Mqfy+qoCnO8EugLwnH7pdyuKaTyUv+Z+CCRdfDrg==
X-Received: by 2002:a05:600c:1d84:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-43d3b9d2769mr10024075e9.23.1742287376836;
        Tue, 18 Mar 2025 01:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHILQIoNqyHItwOTFUtVNmBDSJea3jYt34PUTdt08Ok/vxBredo4KmYrx3e6SVCEbItbB4gdw==
X-Received: by 2002:a05:600c:1d84:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-43d3b9d2769mr10023915e9.23.1742287376480;
        Tue, 18 Mar 2025 01:42:56 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb62ccsm128436605e9.7.2025.03.18.01.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 01:42:55 -0700 (PDT)
Message-ID: <cb9294c1-1d3c-4fe0-bf84-63a2fed1e96e@redhat.com>
Date: Tue, 18 Mar 2025 09:42:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 6/9] net: enable driver support for netmem TX
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
 asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-7-almasrymina@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250308214045.1160445-7-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 10:40 PM, Mina Almasry wrote:
> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index 6327e689e8a8..8c0334851b45 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -10,6 +10,7 @@ Type                                Name                        fastpath_tx_acce
>  =================================== =========================== =================== =================== ===================================================================================
>  unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
>  unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
> +unsigned long:1			    netmem_tx:1;	        read_mostly

Minor nit, but since a rebase is needed... pleas use only spaces to
indent/align the above fields.

Thanks!

Paolo


