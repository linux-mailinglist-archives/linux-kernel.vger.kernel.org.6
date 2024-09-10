Return-Path: <linux-kernel+bounces-322747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2559972D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9C71F262DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E951885AA;
	Tue, 10 Sep 2024 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9JbmmWW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2FD187870
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959754; cv=none; b=Z5rULlOUI+r+x03EhPp87pWhEZpX4hGXvpleyzesxBBqylb/En02xRS3v7ikDeDkUJFXgXFLXObrW+lAlnqRg+NZT6HKKPgn+52kpElws2NH1FeNYOLCBgJFviuJHsSTRR85/OHS5Nc2E1QAtehntTZJWI7JvMcgkwvMklGpBFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959754; c=relaxed/simple;
	bh=eGyGPmj8qP4a1HJ7icwsHB0lz2Y8kobW0ucA08xti3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngzytRJsobERnzxyfnCG9EdkijEhGSy+Oe9vUZQcZ7A4WGSPm0/6T7Z7/XFoP/Kg2Xn1RGvrQgmyCzVl46E63wz/hQMH/VHK4eXdc8+ReX2SSKxxXBPShF05aHAB7gUc2V5xcg06uQw38Ze9zZhKdl6voScwzfTitZLlxNx5Lp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9JbmmWW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725959751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOrTsaC9yhyU98rc48UtcdzEBQ3VCVbDacgXHoEqlXI=;
	b=G9JbmmWWkClTsGi1J4DxEqH1wiEXR0RdY/qLfaGKzuWuuMgfmrkXOnB8MOIMsnSUy75qTI
	3NODqa/pDvMu9bNt7+zo2cpzr5ebQiVfQxiF7yoF5gkeAGQ11cJ9V9UgrAxMysmuLLmyQk
	DXv7u2IUbKW6UGBtMkZcdq+JyuyZ9U8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-iJrVVgn5MaWc-p5xkBsykA-1; Tue, 10 Sep 2024 05:15:49 -0400
X-MC-Unique: iJrVVgn5MaWc-p5xkBsykA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374cbbaf315so2828199f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725959748; x=1726564548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOrTsaC9yhyU98rc48UtcdzEBQ3VCVbDacgXHoEqlXI=;
        b=c7W45Geag2BF18Dutb8pvMW0Xh+IVSVYJmOTMjzlXYthUpsStgWuEVgX9RB6Alyhb1
         GQMoDYehCgWa8QWkym7AERuVTIGPZNQtGsNjyB8SSH2rKtoM0T4gjlwPmGzf4DXL5DmH
         aE44ooiQcmwKLo8PZctt6nuuqK7j0PHbw0nA/w6OHBzr2sK3g9vKTlt7MqjLMMlwyK/7
         zLeXRL5QiXJe/wUkiA72tmzetQBUqeBrBeQvJjuY6Tp6SbaAnssWwMgUuulqB3CUeQQ4
         sXFKgKAPSQ/WZrSaSiBbQUG+LlsA5Pkn063/EIsOBbAmIHLDkZjKTz25/EW5bY2xpY1u
         z/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcq6QCy+3a8TEHyMNKcjUopPv/Lh7/eQr7kQpCwJz70OcDRQBonj5jNk3x13SdsR5lhFzTuZwidHhJdz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpYYnewdpqwThwvlSZ0Xicmnndg97ADPK75T/n5RTxUXlK0jp
	rdhQBUdoQH+SJibJFOrz2Q+CEEzmqQpdQDCY7LnFAhy2ubrAes1usH+YFfNyjbDF+ZpWu46BteP
	nW+fYdwfCIQUd3POKc7htpQf0bVcmoPFXnQzHZ+/kyw2Dzg5sKHFWr821TF6uJurPr1n/CaOu
X-Received: by 2002:adf:e805:0:b0:378:8b56:4665 with SMTP id ffacd0b85a97d-378a8a5a250mr1421992f8f.24.1725959747760;
        Tue, 10 Sep 2024 02:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDlVz9KnKxoBPJUs8BJvknxY3Fteh43Ykemjb+fUuzFfRMvSS6AWG+AceJowT+ugSPw6DlDA==
X-Received: by 2002:adf:e805:0:b0:378:8b56:4665 with SMTP id ffacd0b85a97d-378a8a5a250mr1421962f8f.24.1725959747193;
        Tue, 10 Sep 2024 02:15:47 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a52csm8331824f8f.11.2024.09.10.02.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 02:15:46 -0700 (PDT)
Message-ID: <f8b58d30-cd45-4cb6-b6ca-ac076f072688@redhat.com>
Date: Tue, 10 Sep 2024 11:15:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/12] net: lan966x: use the FDMA library for
 allocation of rx buffers
To: Daniel Machon <daniel.machon@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20240905-fdma-lan966x-v1-0-e083f8620165@microchip.com>
 <20240905-fdma-lan966x-v1-4-e083f8620165@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240905-fdma-lan966x-v1-4-e083f8620165@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 10:06, Daniel Machon wrote:
> Use the two functions: fdma_alloc_phys() and fdma_dcb_init() for rx
> buffer allocation and use the new buffers throughout.
> 
> In order to replace the old buffers with the new ones, we have to do the
> following refactoring:
> 
>      - use fdma_alloc_phys() and fdma_dcb_init()
> 
>      - replace the variables: rx->dma, rx->dcbs and rx->last_entry
>        with the equivalents from the FDMA struct.
> 
>      - make use of fdma->db_size for rx buffer size.
> 
>      - add lan966x_fdma_rx_dataptr_cb callback for obtaining the dataptr.
> 
>      - Initialize FDMA struct values.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>   .../net/ethernet/microchip/lan966x/lan966x_fdma.c  | 116 ++++++++++-----------
>   .../net/ethernet/microchip/lan966x/lan966x_main.h  |  15 ---
>   2 files changed, 55 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index b64f04ff99a8..99d09c97737e 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -6,13 +6,30 @@
>   
>   #include "lan966x_main.h"
>   
> +static int lan966x_fdma_rx_dataptr_cb(struct fdma *fdma, int dcb, int db,
> +				      u64 *dataptr)
> +{
> +	struct lan966x *lan966x = (struct lan966x *)fdma->priv;
> +	struct lan966x_rx *rx = &lan966x->rx;
> +	struct page *page;
> +
> +	page = page_pool_dev_alloc_pages(rx->page_pool);
> +	if (unlikely(!page))
> +		return -ENOMEM;
> +
> +	rx->page[dcb][db] = page;
> +	*dataptr = page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM;
> +
> +	return 0;
> +}

Very nice cleanup indeed!

Out of ENOMEM I can't recall if the following was already discussed, but 
looking at this cb, I'm wondering if a possible follow-up could replace 
the dataptr_cb() and nextptr_cb() with lib functions i.e. operating on 
page pool or doing netdev allocations according to some fdma lib flags.

Cheers,

Paolo


