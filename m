Return-Path: <linux-kernel+bounces-365540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 258D799E3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFD0B2151F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4811E6311;
	Tue, 15 Oct 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brVGufr9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EED1E491B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988114; cv=none; b=RnfbU4OjtDhTLWv5Bak517ZCtaLP9vWojVawC2dvt0QEaV2thfw6queWbzdgmWwCt/SGd0NalJd+CUsvKZ6490lw4h3doJqtV43tknVg3odHAq7zQjSLjCJ2tFVszvwy5kp36d9CNzhqqv2Kf6gvzVEtEENwbbB1hkN0+l40L4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988114; c=relaxed/simple;
	bh=VgJvuDkJACz+nKbm3fgGpAqb49d91mYdGlKdFuQGhR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YavXw8JVzFPRqKsq/ucyEomykmtVHSgZVhdGTZJR1KCBovv+e+xRQyW7qFjxNVoIReKFWWYWqhxZhtmSW/Bm4Zyj7R0giCrU+/SoHoO+sI5AJbOY8MOqO20NMeffYdyTAur97cs2a5cRGCZ3atNDCn6nyfNyTOszS1E1NL9yReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=brVGufr9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728988112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cps/LOuop4Pu5oc4Vsr3y8b/IN0J5M76l5RtraQo7R0=;
	b=brVGufr9Y4DwoVHwzP3oiM6btrumXzmIIBV5oQlfQUAedSXAaenkX47WFXTd5yIKUwmmE0
	pCrbBMF+rRrUCvY3Fh6iJicPuovOEggTI5hdsvSGWn74m6dw1jN5Xu367rslZZlZDTDYuA
	v34lYf7o8B5ZWLpyMgbXJIpCI2f18W4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-1MhcBy4GPHyRQ1D-8z0V_w-1; Tue, 15 Oct 2024 06:28:31 -0400
X-MC-Unique: 1MhcBy4GPHyRQ1D-8z0V_w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d4a211177so2632650f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728988110; x=1729592910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cps/LOuop4Pu5oc4Vsr3y8b/IN0J5M76l5RtraQo7R0=;
        b=vYPltlmFZtCZ43HYMUt6NG3SptUA5PMEE2veztMrKh30nVSu9U7lLzDzLdpJqK4bxi
         9O0FWAbPIPf8hQCMsfsblRK6YWaTl9J6zM92dFhq20fNfDW5Wq9sjlu5MXg5UcFxqam6
         JUFfWx9azlw+MlJHG/8Ea8WVQh0K3Y1/oquc+l4Q3eQcvj0voC3CW9JIHPVfKugEzX0q
         goQLR9FKNLdjq/KMXdPS2ExvR3dYaIOdeXUe2v2HaOC3OgLHWpiFnUkijUjveWzo69re
         wPIFhaDTsDfWci6jaMRab+GVp3Vh3kLykc4l4MmoxacNTETNtYE5gc1RQj/mn8XQLdns
         NuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuZFJYQPwQMld0mhHKdY+mEDuMQeUuVA4Zix9GLkswQoUH6ZmgL+85C9Y8i60xyUi2kDPZAFuPlcnO66Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EbGbaiN2GbVh8/0A1rN/DKJdnYYBOtC8Bta7q8oU8Y4s8Gfb
	l2szM69t4timk4vmQaxTLrt2Dvd8L5O9MOeHQtCyQyU6gAq9B6WGcUsFxOMA8vae7qlZ6cmlAde
	OWN7fiAetdOsnnRiO1aQqgBawsPNIAUbgE4F8V2FsY5Y2nVCFusgveQ7zTAXl4A==
X-Received: by 2002:a5d:4c43:0:b0:37d:5496:290c with SMTP id ffacd0b85a97d-37d551aac20mr8651071f8f.7.1728988110009;
        Tue, 15 Oct 2024 03:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExTzwbPKlTTkRpsnClYF7+R/Tjm4icbAPJb2joq7lD1QZdO9fKsuHcYHIuJ+ORRD3Pk1H9WA==
X-Received: by 2002:a5d:4c43:0:b0:37d:5496:290c with SMTP id ffacd0b85a97d-37d551aac20mr8651040f8f.7.1728988109542;
        Tue, 15 Oct 2024 03:28:29 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc41154sm1194674f8f.108.2024.10.15.03.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:28:29 -0700 (PDT)
Message-ID: <2dd71e95-5fb2-42c9-aff0-3189e958730a@redhat.com>
Date: Tue, 15 Oct 2024 12:28:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 net-next 07/10] net: hibmcge: Implement rx_poll
 function to receive packets
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 christophe.jaillet@wanadoo.fr, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241010142139.3805375-1-shaojijie@huawei.com>
 <20241010142139.3805375-8-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241010142139.3805375-8-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 16:21, Jijie Shao wrote:
> @@ -124,6 +129,20 @@ static void hbg_buffer_free_skb(struct hbg_buffer *buffer)
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

It looks like I was not clear enough in my previous feedback: allocating 
the sk_buff struct at packet reception time, will be much more 
efficient, because the sk_buff contents will be hot in cache for the RX 
path, while allocating it here, together with the data pointer itself 
will almost ensure 2-4 cache misses per RX packet.

You could allocate here the data buffer i.e. via a page allocator and
at rx processing time use build_skb() on top of such data buffer.

I understand it's probably such refactor would be painful at this point, 
but you should consider it as a follow-up.

Side note: the above always uses the maximum MTU for the packet size, if 
the device supports jumbo frames (8Kb size packets), it will produce 
quite bad layout for the incoming packets... Is the device able to use 
multiple buffers for the incoming packets?

Thanks,

Paolo


