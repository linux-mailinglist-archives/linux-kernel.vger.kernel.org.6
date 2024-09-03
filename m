Return-Path: <linux-kernel+bounces-312880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F71969D01
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44E71F25A7B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB9F1C9854;
	Tue,  3 Sep 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K32E9Fg+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6731C9841
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365316; cv=none; b=NVxPTY6f18d4HG19KiWvqgP5fOFmEWRXbOh4kTlxjW5pAh6SdompskZFWQvAe43g5bHFQxbF/6qfIG//ApTTfiE4iEds9MLJ25n7wXv3052JbgQMTBw4sgfmE2LdYLX7itFlyb3rZ6uod0jVZWqof7eiTc2RgECc54eeBoU82HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365316; c=relaxed/simple;
	bh=BsZ1n0bOcMMHp87eIkC1zg9ceFjqaILO25XZebbY6Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VD1VaLCfX/S158EvBx3x/EXZgqO1AuWiCooITEdk4zOFuocUugswVWHTDQ89YbcTdrSdmFWWdCEQfm4mdopDms1QDxOuJzvxFtVX8VFym80bPHVXn8VUaN9cmWD7I4JoOiARk8bWIOgvqgD6PCuvKReKd2VKp7aPpp/0CLklWt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K32E9Fg+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725365313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9aYRYgG0kixSIOydeenongC/DRL5RnTOeLQrTKXisEc=;
	b=K32E9Fg+vcGTIt5kmZB2CAX0PraKQyk7DCri+mtm6FmAJagnQLjAlUp42SQ90zlGpSkPZL
	oZrkm5Ok0DGgBv6zG96s/fey1h5I/gWNuwHwXD5naBCylMNinU/K4jqsNvD7zI5vAFZ8+e
	wYbU+raeeg7w34jWY04ZThh9Hel+H3c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ZPCH39mrPhCIvyjpM4U2ZA-1; Tue, 03 Sep 2024 08:08:32 -0400
X-MC-Unique: ZPCH39mrPhCIvyjpM4U2ZA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428040f49f9so48979545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725365311; x=1725970111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aYRYgG0kixSIOydeenongC/DRL5RnTOeLQrTKXisEc=;
        b=qe36owQD3greb2LjZox61I5ALD7eoGlqPCyzdMqGbIGgKH3u/m2XhAQMVYRGCzduui
         /6ry2eAnCGe0e+RAW25+Wa0xi0qYndNoPm6E/K9WSUhw8kU92Mb6ELqgXbLUDIPrZU7l
         5NI0WE6t8qMPHgajTAy0ibfF3V6Ww9GT2MhJUqX+b2X8VSv+eMtNiSGTRpKOENzomXWV
         LMoCwsAEqsd3ZermLje3Z31h2MiWwksGtR1FomhsHorHnGXXyBezjXEDF7IxQZQ7qgMv
         a3gQ760KS2ERHGpVBxd9acLbfkDnkow73Y4ACGeqonP2+2Gz5tv9EW3JDtCQ+H6bf9ga
         TxQg==
X-Forwarded-Encrypted: i=1; AJvYcCUVo4iqPce6GUFgbkC/dRdbOmKwyzw+Kh4qz2PVLIV0bIJe/QeAndeP9gT6HC7D1T2akrKvaDStRneOucg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPn95h5uo6eSzPcygTepd0Eed33mve4mY/IO6kgi2xZcR3B0Gx
	J9z3v4lECcQNbY1FS3fdDEisxNfTkvqzK0s8R6Atvj5OHR3D5ZANEJbg/LT7WvPMxYGYjVeByaC
	YUDX/t8C1fP0bQK4TrywNgRjX6loS5SuMGNpSyc+oiSRbG1P7/FjIgB6PBG7kHw==
X-Received: by 2002:a05:600c:470f:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-42bb02c0727mr129293705e9.5.1725365311435;
        Tue, 03 Sep 2024 05:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYuACYFYmdeRau/l5pNATI4VMioGx45q1slOGtbAH3lBc6r4xbg0dCcuR4/N7ge1VOuo7FrA==
X-Received: by 2002:a05:600c:470f:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-42bb02c0727mr129293435e9.5.1725365310883;
        Tue, 03 Sep 2024 05:08:30 -0700 (PDT)
Received: from [192.168.88.27] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb3efsm170510925e9.6.2024.09.03.05.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 05:08:30 -0700 (PDT)
Message-ID: <0f3cf321-3c23-43df-b6eb-55dd0a1fec64@redhat.com>
Date: Tue, 3 Sep 2024 14:08:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 net-next 07/11] net: hibmcge: Implement rx_poll
 function to receive packets
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240830121604.2250904-1-shaojijie@huawei.com>
 <20240830121604.2250904-8-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240830121604.2250904-8-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 14:16, Jijie Shao wrote:
> @@ -119,6 +122,20 @@ static void hbg_buffer_free_skb(struct hbg_buffer *buffer)
>   	buffer->skb = NULL;
>   }
>   
> +static int hbg_buffer_alloc_skb(struct hbg_buffer *buffer)
> +{
> +	u32 len = hbg_spec_max_frame_len(buffer->priv, buffer->dir);
> +	struct hbg_priv *priv = buffer->priv;
> +
> +	buffer->skb = netdev_alloc_skb(priv->netdev, len);
> +	if (unlikely(!buffer->skb))
> +		return -ENOMEM;

It's preferable to allocate the skbuff at packet reception time, inside 
the poll() function, just before passing the skb to the upper stack, so 
that the header contents are fresh in the cache. Additionally that 
increases the change for the allocator could hit its fastpath.

> +
> +	buffer->skb_len = len;
> +	memset(buffer->skb->data, 0, HBG_PACKET_HEAD_SIZE);

Out of sheer ignorace, why do you need to clear the packet data?

thanks,

Paolo


