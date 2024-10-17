Return-Path: <linux-kernel+bounces-369467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB27E9A1DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52926284243
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C241D63F2;
	Thu, 17 Oct 2024 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWY6+bPP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E35C1D619F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155405; cv=none; b=lV/dUJT6o+CcMPH2cQZ0zVKUeyLs2tLLqb5V3fAKvpGkwFIxZER9G0DEfJZnEg20tKWIivod9Vv+LxMcOC2M1Nqy6aV1PVGZ4rIeH2gEQhZO07NBIipL6vTOzVXvFtJVRRal5adrPmMkD8kQsjH7whmHPzKLIrAD3Dy1kDXiQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155405; c=relaxed/simple;
	bh=0QWOubG/WuA61pVYtbUtwR5Fnidt8JdTr4ouJ136/xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Que5x56TBXL32aoNvIDeSTpdD+oI7ojFdIZC4FreH9UZVR5AE+vxf5qMVz2rlLZEYUAgIkGnGdGNGjUeYwiiPj3o/Q0xFgoD6sqN3+gBzA6YuXau997luhsPlEzjEudoHB5+1vYk7g8BmFMGTXCJpQHARDPOWBn1gnGpx7qdTpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWY6+bPP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729155402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UrxwD9IPoa0hW3esM+SzEvUX3D4adUtDilN4qp1rChA=;
	b=KWY6+bPP+tl2tD651ln9dODBvbtdjTlbocX4s/cWUnuBZLurX0ueKUfaa9Z4mA62eeD/Aq
	nU68BlCOeB/sxbeOLk852yRJ56R1CQb1lr3kacPcHRPHWaLH4TeZWLrBifJvnfsr3MXMBe
	AGoEqZEoL/4JVZ50OmN8x8ivHVMbdts=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-YikKUMimNsCg_4JmCI-PYA-1; Thu, 17 Oct 2024 04:56:40 -0400
X-MC-Unique: YikKUMimNsCg_4JmCI-PYA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d603515cfso238950f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155399; x=1729760199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrxwD9IPoa0hW3esM+SzEvUX3D4adUtDilN4qp1rChA=;
        b=ASSmQmav1FhzP2TIbvTIjYRyLR1Go6gFoYXnnFy3C3hVKvJTOox1NScMNtJcOV8rJC
         91sgt8FegTUNgr4kt7W0CvH9i+oqO/9ZWOGJ91Q8FHFsOQFoQdEf1ORg84mOkIo/1Wmj
         IvAva4wAw477XC+mNMoNIS8le8rnH1J2rYBHHY2dHCUSeoAi57ks1AKKLNe+6Sp8CTw8
         7vjKgApkOVUtLcMlXFUkfwAyOo1gyZSY/qSvjdVVK5ghJGvA/aHx5kwjjLDr5U26/id7
         seVqpCpu9liVfnUdSEMRgVnNKry5LbxSkBwXNhp7Ex1msjPkX2CIE1wHAzBxZ7pctXQ9
         vtxA==
X-Forwarded-Encrypted: i=1; AJvYcCXpy07sSdvgs0ya49pqCmsQKzxWb/uGcRxpUFJ5+8KzOfxhkn+D95XcM5hKdCUIMLHMy6pGHRVrM3lI5vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxctKM10l18AD3gB/vv/2TRYGgNo5hQRgYXhTqWxbWOi3rjUOCf
	dhqXPt3oXPVh0Ic4wGgru8hbhp1iM7d8KoZ+WWIfOzKu9R9yZww4wokIVuaIa8TmyT8hJoNGOUB
	llWdlhw7fNJAKmvpWg1xnT0D/T2hf+uYun+wy6bDP3EAhUvQsRKlmBtUou9PqUQ==
X-Received: by 2002:a5d:5234:0:b0:37d:4ebe:164a with SMTP id ffacd0b85a97d-37d5ff9d34fmr11719247f8f.50.1729155398970;
        Thu, 17 Oct 2024 01:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhrSlHYpBwf2V7vPOdSMSWDh7j+UkXMjx0aSd2wqLti5QLAw6usc5GisM3cNHvTruB/I0Nqw==
X-Received: by 2002:a5d:5234:0:b0:37d:4ebe:164a with SMTP id ffacd0b85a97d-37d5ff9d34fmr11719227f8f.50.1729155398510;
        Thu, 17 Oct 2024 01:56:38 -0700 (PDT)
Received: from [192.168.88.248] (146-241-63-201.dyn.eolo.it. [146.241.63.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c4071esm19199775e9.27.2024.10.17.01.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 01:56:37 -0700 (PDT)
Message-ID: <cf656975-69b4-427e-8769-d16575774bba@redhat.com>
Date: Thu, 17 Oct 2024 10:56:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] octeon_ep: Implement helper for iterating
 packets in Rx queue
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Veerasenareddy Burru <vburru@marvell.com>,
 Abhijit Ayarekar <aayarekar@marvell.com>,
 Satananda Burla <sburla@marvell.com>, Sathesh Edara <sedara@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, Simon Horman <horms@kernel.org>
References: <20241012094950.9438-1-amishin@t-argos.ru>
 <20241012094950.9438-2-amishin@t-argos.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241012094950.9438-2-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/24 11:49, Aleksandr Mishin wrote:
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> index 4746a6b258f0..62db101b2147 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> @@ -336,6 +336,30 @@ static int octep_oq_check_hw_for_pkts(struct octep_device *oct,
>   	return new_pkts;
>   }
>   
> +/**
> + * octep_oq_next_pkt() - Move to the next packet in Rx queue.
> + *
> + * @oq: Octeon Rx queue data structure.
> + * @buff_info: Current packet buffer info.
> + * @read_idx: Current packet index in the ring.
> + * @desc_used: Current packet descriptor number.
> + *
> + * Free the resources associated with a packet.
> + * Increment packet index in the ring and packet descriptor number.
> + */
> +static void octep_oq_next_pkt(struct octep_oq *oq,
> +			      struct octep_rx_buffer *buff_info,
> +			      u32 *read_idx, u32 *desc_used)
> +{
> +	dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
> +		       PAGE_SIZE, DMA_FROM_DEVICE);
> +	buff_info->page = NULL;
> +	(*read_idx)++;
> +	(*desc_used)++;
> +	if (*read_idx == oq->max_count)
> +		*read_idx = 0;
> +}
> +
>   /**
>    * __octep_oq_process_rx() - Process hardware Rx queue and push to stack.
>    *
> @@ -367,10 +391,7 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>   	desc_used = 0;
>   	for (pkt = 0; pkt < pkts_to_process; pkt++) {
>   		buff_info = (struct octep_rx_buffer *)&oq->buff_info[read_idx];
> -		dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
> -			       PAGE_SIZE, DMA_FROM_DEVICE);
>   		resp_hw = page_address(buff_info->page);
> -		buff_info->page = NULL;
>   
>   		/* Swap the length field that is in Big-Endian to CPU */
>   		buff_info->len = be64_to_cpu(resp_hw->length);
> @@ -394,36 +415,27 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>   			data_offset = OCTEP_OQ_RESP_HW_SIZE;
>   			rx_ol_flags = 0;
>   		}
> +
> +		skb = build_skb((void *)resp_hw, PAGE_SIZE);
> +		skb_reserve(skb, data_offset);
> +
> +		octep_oq_next_pkt(oq, buff_info, &read_idx, &desc_used);

I'm sorry for not catching the following in the previous iteration (the 
split indeed helped with the review):

build_skb() will write into the paged buffer, I think you should unmap 
it with octep_oq_next_pkt() before the skb creation.

That in turn will have side effect on the following patch (the 'do {} 
while' loop should become a plain 'while' one).

Thanks,

Paolo


