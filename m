Return-Path: <linux-kernel+bounces-327595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21166977830
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FE2B22A95
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383BB14D2A6;
	Fri, 13 Sep 2024 05:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6elUj0b"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA914126BE2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726204133; cv=none; b=pDpm0qRdEoCuZRj1Uq64fnw9KJVoM2hlLDm7/YtE9hEHey6zpq91uE4KFoGy7hbyTYl8gcRrmezkjYo0Lw/2/QK7WjtTkTQXi6yLdHzRYuDG8FRSrOhqGU3bP3sPVQkuB24wbUc6qaxoccX8as54RpZRJqh5iGXT9+kYFsmlntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726204133; c=relaxed/simple;
	bh=Mh8vg4bqrIfCB6r+qKE5u434fiJUJULIMn0nj/AbMC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lgHDiR3vckIJjcXfW1Rs2Op1xRhLrsQ9GO3meu4ZCZSC3DE5eiIIzAvitKyRNmNV/f5Wk1qQdMO2sFVA7853bg+ztqGFaS2kztMWeNnaSFDjf1hlWM0zAT1IqiOcyr10U07F+2mav8H3/cxgArMbSL6AWmChOqrOjLBeUkC5dFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6elUj0b; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c3400367so439684f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726204129; x=1726808929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=czxeoqBiPxH3lAOEA6JUJ0nSjswq1mluKegMDz5OxVY=;
        b=H6elUj0bl585gBr1NdZIBQ+o2CEZeGsJlFD1hmeGnxmrDq9YsbMXnO21n+6qtHB8I3
         u00tiDhxbWC+oYEfoy9AkdBsMFQleVy0BADWK+jL9d3hoGMqzShR9l8GU3Z6EJiXFnsy
         opm0WO+/wmrEeA/bQ9Ks9DGaEw5OKwagd7zP1dhgS/yoe206W+itd1RrjsTK3dFS68Pr
         zHbInukSgRHYy0F8QmijVeHlTOJkKU3YMwFXOIw4KjtLBQko7mmPJKWRok8D4jCnWlzj
         dn7uvoGLykglWdQKqEz2Ds5P6+HUj563EUxTvCQ5Q2mR20m0NgpDiVzDnYUAevVsPoYk
         Zskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726204129; x=1726808929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czxeoqBiPxH3lAOEA6JUJ0nSjswq1mluKegMDz5OxVY=;
        b=mO9nJCiJVwg1ZIT+O6UBhBcNa/G4W8wf5lfwgUTZ7TAkrnb9fFRqss38pMYYacT6uL
         NHyhAxLSDRx9bGa4/FKPG6ZTdEvpq84z+ynh5rlKuzDQgpbB9R/p2d90Qvo0llXt3uVc
         EJV1EKV57Nx5hI0Cb51JvzZXzwJkItExieJjQJC6j0GLIhj2LwZ1ZG1UgTEN9ETfNSyA
         KnNJz6JK+T6jRcj7eSsxmGfK01+JQyYfMfsBy4ZBPR/IgSIkTD3i31HTjV5zJ5qe/xKW
         2xLVXUJVE5Gn050y+ChhgYK/oIlFpaRIAToXVqjLDAienPa1H1gs/bCPC6QDcHBk+5yc
         orsw==
X-Forwarded-Encrypted: i=1; AJvYcCUge2G0QjKhviuBfcGWhEFedXhawBdgG8Intv594EY4VfRpYrxH60DATqoY/VHLKV+3i6Q91P3aGdaFwL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQoQz5gstSLnWoYrXEKdQ7PoJgLmGt8Ua9r2P3QgJMbyndPDH
	qiSLId3ayiIB5SLa8dnADvmgQHzKU5U1z2Ns2a/7ee5MUZGAggrm
X-Google-Smtp-Source: AGHT+IEIkLuiyZRvhh61qiXnVKh0feJoQcTwOA1DLs4nf3Ar0hqvqEJl9IVNQGl7Gakj8VFAjyMsww==
X-Received: by 2002:a5d:5f88:0:b0:374:c8b7:63ec with SMTP id ffacd0b85a97d-378d61e2888mr1468686f8f.21.1726204128760;
        Thu, 12 Sep 2024 22:08:48 -0700 (PDT)
Received: from [192.168.0.100] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72748sm823743066b.117.2024.09.12.22.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 22:08:48 -0700 (PDT)
Message-ID: <2ccf9206-50de-41d4-ba7b-ce5a97fdd69e@gmail.com>
Date: Fri, 13 Sep 2024 07:08:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] staging: vt6655: Rename variable apTD0Rings
To: Xingquan Liu <b1n@b1n.io>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240913012343.42579-1-b1n@b1n.io>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240913012343.42579-1-b1n@b1n.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/24 03:23, Xingquan Liu wrote:
> Rename variable apTD0Rings to ap_td0_rings to fix checkpatch warning
> Avoid CamelCase.
> 
> Signed-off-by: Xingquan Liu <b1n@b1n.io>
> ---
> v3: Add change history
> v2: Rename variable apTD1Rings
> 
>   drivers/staging/vt6655/card.c        |  6 +++---
>   drivers/staging/vt6655/device.h      |  2 +-
>   drivers/staging/vt6655/device_main.c | 14 +++++++-------
>   3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> index 688c870d89bc..36bf8cde2e08 100644
> --- a/drivers/staging/vt6655/card.c
> +++ b/drivers/staging/vt6655/card.c
> @@ -388,8 +388,8 @@ void card_safe_reset_tx(struct vnt_private *priv)
>   	struct vnt_tx_desc *curr_td;
>   
>   	/* initialize TD index */
> -	priv->tail_td[0] = &priv->apTD0Rings[0];
> -	priv->apCurrTD[0] = &priv->apTD0Rings[0];
> +	priv->tail_td[0] = &priv->ap_td0_rings[0];
> +	priv->apCurrTD[0] = &priv->ap_td0_rings[0];
>   
>   	priv->tail_td[1] = &priv->apTD1Rings[0];
>   	priv->apCurrTD[1] = &priv->apTD1Rings[0];
> @@ -398,7 +398,7 @@ void card_safe_reset_tx(struct vnt_private *priv)
>   		priv->iTDUsed[uu] = 0;
>   
>   	for (uu = 0; uu < priv->opts.tx_descs[0]; uu++) {
> -		curr_td = &priv->apTD0Rings[uu];
> +		curr_td = &priv->ap_td0_rings[uu];
>   		curr_td->td0.owner = OWNED_BY_HOST;
>   		/* init all Tx Packet pointer to NULL */
>   	}
> diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
> index 32d9cbd55222..32c51d794264 100644
> --- a/drivers/staging/vt6655/device.h
> +++ b/drivers/staging/vt6655/device.h
> @@ -135,7 +135,7 @@ struct vnt_private {
>   	struct vnt_tx_desc *apCurrTD[TYPE_MAXTD];
>   	struct vnt_tx_desc *tail_td[TYPE_MAXTD];
>   
> -	struct vnt_tx_desc *apTD0Rings;
> +	struct vnt_tx_desc *ap_td0_rings;
>   	struct vnt_tx_desc *apTD1Rings;
>   
>   	struct vnt_rx_desc *aRD0Ring;
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index 9ea647aefd60..a8dcd8ad3945 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -550,7 +550,7 @@ static bool device_init_rings(struct vnt_private *priv)
>   		priv->opts.tx_descs[0] * sizeof(struct vnt_tx_desc);
>   
>   	/* vir_pool: pvoid type */
> -	priv->apTD0Rings = vir_pool
> +	priv->ap_td0_rings = vir_pool
>   		+ priv->opts.rx_descs0 * sizeof(struct vnt_rx_desc)
>   		+ priv->opts.rx_descs1 * sizeof(struct vnt_rx_desc);
>   
> @@ -720,7 +720,7 @@ static int device_init_td0_ring(struct vnt_private *priv)
>   	curr = priv->td0_pool_dma;
>   	for (i = 0; i < priv->opts.tx_descs[0];
>   	     i++, curr += sizeof(struct vnt_tx_desc)) {
> -		desc = &priv->apTD0Rings[i];
> +		desc = &priv->ap_td0_rings[i];
>   		desc->td_info = kzalloc(sizeof(*desc->td_info), GFP_KERNEL);
>   		if (!desc->td_info) {
>   			ret = -ENOMEM;
> @@ -730,20 +730,20 @@ static int device_init_td0_ring(struct vnt_private *priv)
>   		desc->td_info->buf = priv->tx0_bufs + i * PKT_BUF_SZ;
>   		desc->td_info->buf_dma = priv->tx_bufs_dma0 + i * PKT_BUF_SZ;
>   
> -		desc->next = &(priv->apTD0Rings[(i + 1) % priv->opts.tx_descs[0]]);
> +		desc->next = &(priv->ap_td0_rings[(i + 1) % priv->opts.tx_descs[0]]);
>   		desc->next_desc = cpu_to_le32(curr +
>   					      sizeof(struct vnt_tx_desc));
>   	}
>   
>   	if (i > 0)
> -		priv->apTD0Rings[i - 1].next_desc = cpu_to_le32(priv->td0_pool_dma);
> -	priv->tail_td[0] = priv->apCurrTD[0] = &priv->apTD0Rings[0];
> +		priv->ap_td0_rings[i - 1].next_desc = cpu_to_le32(priv->td0_pool_dma);
> +	priv->tail_td[0] = priv->apCurrTD[0] = &priv->ap_td0_rings[0];
>   
>   	return 0;
>   
>   err_free_desc:
>   	while (i--) {
> -		desc = &priv->apTD0Rings[i];
> +		desc = &priv->ap_td0_rings[i];
>   		kfree(desc->td_info);
>   	}
>   
> @@ -795,7 +795,7 @@ static void device_free_td0_ring(struct vnt_private *priv)
>   	int i;
>   
>   	for (i = 0; i < priv->opts.tx_descs[0]; i++) {
> -		struct vnt_tx_desc *desc = &priv->apTD0Rings[i];
> +		struct vnt_tx_desc *desc = &priv->ap_td0_rings[i];
>   		struct vnt_td_info *td_info = desc->td_info;
>   
>   		dev_kfree_skb(td_info->skb);

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>


