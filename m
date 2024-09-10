Return-Path: <linux-kernel+bounces-322993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6F697365E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B7E1C247CA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD18318FC67;
	Tue, 10 Sep 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIT++JcN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2D17BEC8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968356; cv=none; b=LIYceVX3UbSYeeoUlliZIKxMKxQQRhvzfLRPGsGi9hH+cu3zxD7kMJMpalMEhn4Fs0TeEp7A/InL05m+sR9H/r8neMMgzDGo2z3qP2TqurzTKK+v3Tj+8FnRGu2up3x+JdUMoyS/lf33AgPYDsKzSdlNXn5KspDx2tqX2IOIhXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968356; c=relaxed/simple;
	bh=0cX3GH0xXBXVOLY6ArGBCddEcj5mgMvVcSHl7vBZh80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eywiOeGhKqqa8VW/rhDl1tDOmpwoEioy2qCAJ7rXnwTYM00B9+qjtp9y2HlbBA7oovVnppZIkETGmTvtJMHDiaTPQyjURLGAfnXOBQEal+dGbAudqIsqaSR2uLtUgyF7j0veA+N8QX9g+Moenoc19JPIvvs7otezluoiAk0qKoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIT++JcN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725968353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMDE+T5SYbzZ2s2lnJcF8C7qQEF7Xk3SXFs44FfYjgo=;
	b=ZIT++JcNPqJFhaI9AQ3bT403UZVM4zD2KgrdYtlgQ29RrZgkSotUB4Ml1rhNAib6Jh9rlq
	sH1Qc+ir3b0KM/Zo7v8u5L/FN9kfwGbbDyyQ28Uz2INc3lpbO2umGoHEQPYInLUVyVuJNw
	WQGceCauDM4WTj0hGTmpeGHWYQUfV/Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-h71ecW_aNvWjDFgEp_wozg-1; Tue, 10 Sep 2024 07:39:12 -0400
X-MC-Unique: h71ecW_aNvWjDFgEp_wozg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374bacd5cccso2966898f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725968351; x=1726573151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMDE+T5SYbzZ2s2lnJcF8C7qQEF7Xk3SXFs44FfYjgo=;
        b=JU3G6ffNqjjC+sLYdsCtCiahxXnweJedGuxZF+lea/u2Zq5oNsJ4zWN1D4IFHgv3H3
         eh4OhOdg7AvcK1VHG/0D3J4VyfkzzXXkPRP5wzASZbNR8uX2aPzjRLBRap/+w54Zwd2A
         4K7WNhPPX7DHWgwI/RyMiQCgxymkMURDqKhDv4iMq0XKEsE7oBvGDp30owm/VXxHp0PN
         pPrmSk8CoRrBuvAtJn2a23Zcz3HYOezMnJHRnUGj8xxpdMdAzmc367jcQCo/cx0Vflzd
         SWq4IzTRpFyBYVLnKcux000zHfwBGRnmj7eiwZ+7JmDFx08GvWjboUGEsIdRbEMp6UjN
         n5tA==
X-Forwarded-Encrypted: i=1; AJvYcCVtuvVg+EB3/1k0rS/Zjwfya0h3mrv9cImGX2VE+4bbdARPfB8k3fb6aACBIG0B4vB7/jDziCr0EAnt+PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoYmsbZnVVsjohnVK9U5BIZGmd+pWbmeJvpaaIYs+24WosrPvl
	cmGHPLqLotutKQhsJztmk1DKG6RT1F0l80/Hl1lRbLpfe2G+Vdo2lR98Iaeh0wwcgtqkzMsPnm2
	GthDb0/Pn0amopXsuhybtyvreN9EB/FBOpzDVZR+nIkUaW9An5LIXOVPVZjeOlQ==
X-Received: by 2002:adf:f811:0:b0:374:cea0:7d3d with SMTP id ffacd0b85a97d-3788969ff56mr9440989f8f.53.1725968350836;
        Tue, 10 Sep 2024 04:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzz09F/XLDtA7rHhTuAJ5rYOp6SV3GI6mvztmhG9ZtOK7EYoZm27iS4MavxjCEt0DhAgB68A==
X-Received: by 2002:adf:f811:0:b0:374:cea0:7d3d with SMTP id ffacd0b85a97d-3788969ff56mr9440968f8f.53.1725968350251;
        Tue, 10 Sep 2024 04:39:10 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm16800825e9.1.2024.09.10.04.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 04:39:09 -0700 (PDT)
Message-ID: <ba514498-3706-413b-a09f-f577861eef28@redhat.com>
Date: Tue, 10 Sep 2024 13:39:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] octeon_ep: Add SKB allocation failures handling in
 __octep_oq_process_rx()
Content-Language: en-US
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Veerasenareddy Burru <vburru@marvell.com>
Cc: Sathesh Edara <sedara@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Abhijit Ayarekar <aayarekar@marvell.com>,
 Satananda Burla <sburla@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240906063907.9591-1-amishin@t-argos.ru>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240906063907.9591-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 08:39, Aleksandr Mishin wrote:
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> index 4746a6b258f0..e92afd1a372a 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_rx.c
> @@ -394,32 +394,32 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>   			data_offset = OCTEP_OQ_RESP_HW_SIZE;
>   			rx_ol_flags = 0;
>   		}
> +
> +		skb = build_skb((void *)resp_hw, PAGE_SIZE);
> +		if (skb)
> +			skb_reserve(skb, data_offset);
> +		else
> +			oq->stats.alloc_failures++;
>   		rx_bytes += buff_info->len;

The packet is dropped, we should not increase 'rx_bytes'

> +		read_idx++;
> +		desc_used++;
> +		if (read_idx == oq->max_count)
> +			read_idx = 0;
>   
>   		if (buff_info->len <= oq->max_single_buffer_size) {
> -			skb = build_skb((void *)resp_hw, PAGE_SIZE);
> -			skb_reserve(skb, data_offset);
> -			skb_put(skb, buff_info->len);
> -			read_idx++;
> -			desc_used++;
> -			if (read_idx == oq->max_count)
> -				read_idx = 0;
> +			if (skb)
> +				skb_put(skb, buff_info->len);
>   		} else {
>   			struct skb_shared_info *shinfo;
>   			u16 data_len;
>   
> -			skb = build_skb((void *)resp_hw, PAGE_SIZE);
> -			skb_reserve(skb, data_offset);
>   			/* Head fragment includes response header(s);
>   			 * subsequent fragments contains only data.
>   			 */
> -			skb_put(skb, oq->max_single_buffer_size);
> -			read_idx++;
> -			desc_used++;
> -			if (read_idx == oq->max_count)
> -				read_idx = 0;
> -
> -			shinfo = skb_shinfo(skb);
> +			if (skb) {
> +				skb_put(skb, oq->max_single_buffer_size);
> +				shinfo = skb_shinfo(skb);
> +			}
>   			data_len = buff_info->len - oq->max_single_buffer_size;
>   			while (data_len) {
>   				dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
> @@ -434,10 +434,11 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>   					data_len -= oq->buffer_size;
>   				}
>   
> -				skb_add_rx_frag(skb, shinfo->nr_frags,
> -						buff_info->page, 0,
> -						buff_info->len,
> -						buff_info->len);
> +				if (skb)
> +					skb_add_rx_frag(skb, shinfo->nr_frags,
> +							buff_info->page, 0,
> +							buff_info->len,
> +							buff_info->len);
>   				buff_info->page = NULL;
>   				read_idx++;
>   				desc_used++;
> @@ -446,6 +447,9 @@ static int __octep_oq_process_rx(struct octep_device *oct,
>   			}
>   		}
>   
> +		if (!skb)
> +			continue;

Instead of adding multiple checks for !skb, I think it would be better 
to implement an helper to unmmap/flush all the fragment buffers used by 
the dropped packet, call such helper at skb allocation failure and 
continue looping earlier/at that point.

Thanks,

Paolo


