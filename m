Return-Path: <linux-kernel+bounces-309363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D26966958
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07290285275
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5771BD00C;
	Fri, 30 Aug 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdRyNDFL"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B151BF318
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725045084; cv=none; b=WX5MsdreNHajzD5bU3LneAE8MMVcnpgvyC/qTZYC4uddfPnjbu8wHYGZ+vtia1iSSiz/XJDJG04PZ3L/5kgkRNa/UYbwKhZvKt3h5QHhv58V07AUSrVjUPmy4uyQI2AobIwLgwSykqk+y6q4MUHH5Hx7tQEuNcrRWV0tbPcme9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725045084; c=relaxed/simple;
	bh=nTTilP3oVCZy0LaSd6ZTEG07Kd7VQsLiW26jY7giLqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuVQU3jC4tW50/PGFiMGHJc4i9DXAcolEnP/GuOU77h5AmXhUOc+yEUxM3WhJ6WFGiYBigG3/6hRqy0w9Olpyy3GT2eeYS8FE3vbocpcW9SnZlUxREajazYiTLZoyV+5XobOY0qoTbBVNnKp2j41eTCDKD6PHp9+23JVwAiuo+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdRyNDFL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a86a0b5513aso253814066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725045081; x=1725649881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkZBG3rpBRmlfDuRPWhmuH7VSYrBmmDQec7CX2pdIpg=;
        b=FdRyNDFLwsespwgNtX4EO9UEiVRGbgG4GrJE1Sz6jG72MxROgpTEa8wrq7m5UozADj
         J2/MZXWmWpnXqpU6SQ5CriHP2FhZI4ERUytCe3B1ujeB51WwGAj1FKNwDYWyV1pUbdCp
         jaxvTQgWYbE6is6NqURd3KpXSljcD/H1b2xosao+yQzB425f78zZBnZMuSG/z3Uc5Syn
         NxYD94Jnpx1k6H+2TAyCUVmUw1xDq2X8T/0owKLu0HrhuWe+h6kWb/+AnZr8Hs8TSS5x
         LTExrwV2ek7V3/MSPOufbLT29T49lima1fRIuOeCgHi+vGqhB1tVOpQBpOabk9Xeg9sq
         cA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725045081; x=1725649881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkZBG3rpBRmlfDuRPWhmuH7VSYrBmmDQec7CX2pdIpg=;
        b=p7JY8CSri4RpV4eD9RrwE/sy5wKNpz5BYko/AanUDA2Nk7rbOThkQdEYXkG79VUs0E
         bnNzr0Qlz6E0e5fUkbekq7500bSHfPMq2cck+2fvZildsHBvwa11j5eU0FyiJQrsQ547
         w0iEM3hA8qWyGWgmQSIVlSl6/WnNejAnXN8o/kf3e12B1A+FcWdXTWXLwUSgY6diKKWN
         jE5KIkeH26MPOp+b/jb2IqFpzZjnMDWbgOQDLN7IwoQwTIYMqwSXtqP58/v2Q3UYblSq
         VcA4o5YrlyoZyKX+aie4N5REHMiN4jSThPsecwG1kjx4yC0aZuG9ZkVfY7fhnnTc8tn0
         BfOw==
X-Forwarded-Encrypted: i=1; AJvYcCWX/LBVslnClEko2KUWZcG8nOUQgZijqHQNl43KQ0EqSvC+7fqM+q0pTDVFlzRrDZD9bxgo+LyChL8oFXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdh6Z0qceTpPE4M470KJnh0v+Zpp2iLtC1fCyEfjZWPlqaPSIO
	qmmbCLRi1Z33PP/hQT2s2b03Q8zXvibme3UC+fnJ5at885SscIT02ZJUrg==
X-Google-Smtp-Source: AGHT+IH5pjZ9hybiZdbfPomfDdLM2BZXeH0wztRXDN3lR1j9bQ7w2wpl76IsnqRrFuNaYyZw+bZzKg==
X-Received: by 2002:a17:907:d8c:b0:a86:8863:2bf0 with SMTP id a640c23a62f3a-a897fa74f73mr645436266b.48.1725045080837;
        Fri, 30 Aug 2024 12:11:20 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fef4c3sm242445066b.32.2024.08.30.12.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 12:11:20 -0700 (PDT)
Message-ID: <252c48f2-37f4-4a55-845f-8fa0a046a31a@gmail.com>
Date: Fri, 30 Aug 2024 21:11:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Staging: rtl8192e: Rename variable pNetwork
To: Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
 anjan@momi.ca
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240830020508.532945-1-tdavies@darkphysics.net>
 <20240830020508.532945-2-tdavies@darkphysics.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240830020508.532945-2-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 04:05, Tree Davies wrote:
> Rename variable pNetwork to network
> to fix checkpatch warning Avoid CamelCase.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 34 +++++++++++------------
>   drivers/staging/rtl8192e/rtllib.h         |  4 +--
>   2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index dfdb7a7dc14f..188e1fd9554d 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -559,7 +559,7 @@ void ht_initialize_bss_desc(struct bss_ht *bss_ht)
>   }
>   
>   void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
> -				   struct rtllib_network *pNetwork)
> +				   struct rtllib_network *network)
>   {
>   	struct rt_hi_throughput *ht_info = ieee->ht_info;
>   	u8	bIOTAction = 0;
> @@ -567,32 +567,32 @@ void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
>   	/* unmark enable_ht flag here is the same reason why unmarked in
>   	 * function rtllib_softmac_new_net. WB 2008.09.10
>   	 */
> -	if (pNetwork->bssht.bd_support_ht) {
> +	if (network->bssht.bd_support_ht) {
>   		ht_info->current_ht_support = true;
> -		ht_info->peer_ht_spec_ver = pNetwork->bssht.bd_ht_spec_ver;
> +		ht_info->peer_ht_spec_ver = network->bssht.bd_ht_spec_ver;
>   
> -		if (pNetwork->bssht.bd_ht_cap_len > 0 &&
> -		    pNetwork->bssht.bd_ht_cap_len <= sizeof(ht_info->peer_ht_cap_buf))
> +		if (network->bssht.bd_ht_cap_len > 0 &&
> +		    network->bssht.bd_ht_cap_len <= sizeof(ht_info->peer_ht_cap_buf))
>   			memcpy(ht_info->peer_ht_cap_buf,
> -			       pNetwork->bssht.bd_ht_cap_buf,
> -			       pNetwork->bssht.bd_ht_cap_len);
> +			       network->bssht.bd_ht_cap_buf,
> +			       network->bssht.bd_ht_cap_len);
>   
> -		if (pNetwork->bssht.bd_ht_info_len > 0 &&
> -		    pNetwork->bssht.bd_ht_info_len <=
> +		if (network->bssht.bd_ht_info_len > 0 &&
> +		    network->bssht.bd_ht_info_len <=
>   		    sizeof(ht_info->peer_ht_info_buf))
>   			memcpy(ht_info->peer_ht_info_buf,
> -			       pNetwork->bssht.bd_ht_info_buf,
> -			       pNetwork->bssht.bd_ht_info_len);
> +			       network->bssht.bd_ht_info_buf,
> +			       network->bssht.bd_ht_info_len);
>   
>   		ht_info->current_rt2rt_aggregation =
> -			 pNetwork->bssht.bd_rt2rt_aggregation;
> +			 network->bssht.bd_rt2rt_aggregation;
>   		ht_info->current_rt2rt_long_slot_time =
> -			 pNetwork->bssht.bd_rt2rt_long_slot_time;
> +			 network->bssht.bd_rt2rt_long_slot_time;
>   
>   		ht_iot_peer_determine(ieee);
>   
>   		ht_info->iot_action = 0;
> -		bIOTAction = ht_iot_act_is_mgnt_use_cck_6m(ieee, pNetwork);
> +		bIOTAction = ht_iot_act_is_mgnt_use_cck_6m(ieee, network);
>   		if (bIOTAction)
>   			ht_info->iot_action |= HT_IOT_ACT_MGNT_USE_CCK_6M;
>   		bIOTAction = ht_iot_act_is_ccd_fsync(ieee);
> @@ -609,14 +609,14 @@ void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
>   }
>   
>   void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
> -				     struct rtllib_network *pNetwork)
> +				     struct rtllib_network *network)
>   {
>   	struct rt_hi_throughput *ht_info = ieee->ht_info;
>   	struct ht_info_ele *pPeerHTInfo =
> -		 (struct ht_info_ele *)pNetwork->bssht.bd_ht_info_buf;
> +		 (struct ht_info_ele *)network->bssht.bd_ht_info_buf;
>   
>   	if (ht_info->current_ht_support) {
> -		if (pNetwork->bssht.bd_ht_info_len != 0)
> +		if (network->bssht.bd_ht_info_len != 0)
>   			ht_info->current_op_mode = pPeerHTInfo->opt_mode;
>   	}
>   }
> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
> index 7a1a68317a49..82fef04e5784 100644
> --- a/drivers/staging/rtl8192e/rtllib.h
> +++ b/drivers/staging/rtl8192e/rtllib.h
> @@ -1733,9 +1733,9 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee);
>   void ht_initialize_ht_info(struct rtllib_device *ieee);
>   void ht_initialize_bss_desc(struct bss_ht *bss_ht);
>   void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
> -				   struct rtllib_network *pNetwork);
> +				   struct rtllib_network *network);
>   void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
> -				     struct rtllib_network *pNetwork);
> +				     struct rtllib_network *network);
>   u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
>   		       u8 *pMCSFilter);
>   extern u8 MCS_FILTER_ALL[];

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>


