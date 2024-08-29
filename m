Return-Path: <linux-kernel+bounces-307437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8901C964D98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0E91C223A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1791D1B86C0;
	Thu, 29 Aug 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJXXSOlI"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD081B81B8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955685; cv=none; b=jPf1h2CgiYF9GChIwX+8RAZNB+QLhSda3xuKII+0fTLNX5PszTcPehr9BfUOwOApWTa9DgXMH8qRJmUTAHpiJiLmNLwbiDSIMjNjxOVuOFBVIOPuULtn+YGgFpsloX3THYLGlN9w1CS/6dzMRhUqU9eXJiFTnogg9Zg47bGrq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955685; c=relaxed/simple;
	bh=OamhxVc6llfV6oMA6EuDx1uDovmp76ZXtRUdar7KQsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SVKg4fctyJDniN6P4CTKk3OrtPr61MARhieH3q9RA/3dT/NVt547Rf6j4AFvLDliHK7Mwfzcy0aE4jQe3q5/koy2w7u7yvgqB1HvvbEVR+1w9Br6iebPMVZhSwKKWblAQzpmFsetV5QGOyTpJU2Z2JgBInwU+Wrl+vb+v7524sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJXXSOlI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5353d0b7463so1811074e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724955680; x=1725560480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uf/MfXJx2zZsO5b593EnlOHjvzjeAbo67ErqNZOPCMQ=;
        b=gJXXSOlIow654s94QBsHERuEyezl9AoUAIqiMSbjoLXrt5QVOPrbIJK4yKcC1lUv6r
         AaXvRZGMmMEULYEDOUNz8qG1+oe+n6f9olUdGZf8cCO5Y0hRjSylU6JtR8BvcOnYJ+2D
         O7KM9+riNOpdta9HrpSbScA/WlMA5/OMtCYuXhuOhqRG2EeRBK4g2VZoLY8/fT2MDBHH
         TJx9uM8m23cu50XLvuG/ADxCitN2tA4dxQvU+HnvCaN7JOpmZDwkMo7iXg6C37zt6dzQ
         kFQ5AIOLZG+hfN4xIsyv8J2J9hNHeCRvetp3ifiCV18AkTg6gd05pk5BmZ/veJ5Lgb7a
         cRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724955680; x=1725560480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf/MfXJx2zZsO5b593EnlOHjvzjeAbo67ErqNZOPCMQ=;
        b=mWBbP5TlWshQbR/AnaaZFEZ/OvIP/0tKaIPUqD3w+sBUZ6nGRTGMM3W1RrlWirju98
         Mq38Iu/HVw7mTomUqE+fWgL2mez7unH6WCNVa9TBBXgCgg6bqAakDq/8zh4rIgSdqUPA
         ZUNkRH9D3KnC+b6pMMvp6TqKkE7+RZclSLgd7Oc9TR2UMczaTTiGFiRygglRInFyDBSC
         W26XXNFkSFW4tpWwFcWLp2hsa8LjwStJy0ml/FeSQmF62zEJ8je3RRmzVffvs7FEpqvs
         3+AfDSmbpahzGJgfcX+xU2E/F+m29zICf4KRnY6a+pCbGkywZKG82HgGLndMeiBeEV8m
         dVdA==
X-Forwarded-Encrypted: i=1; AJvYcCXki6aDyGNbsisr+829QtZH4MyB/7kDf6dk9+unWGdds4WOqy7hMpeOtnY7xa7fkicczfHT7LuLwbdXouE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4vm4ySDnor34lI0TK92vpwB/KRFhPUaoE8pUH/6r0ZRPmz2gL
	ShmejS7PmqN3/5tcXTTv8TvgK+KSersoXXMJX9Mthu6ve6uD+EtH6UlyxSYK
X-Google-Smtp-Source: AGHT+IGaEU616Nm/G0Jxky2+yZhaeLIq1aCxX4y211muvUdO+GFRfzM+J6bvM1uKLKx8mG2srbpu1g==
X-Received: by 2002:a05:6512:3b21:b0:52f:cd03:a84a with SMTP id 2adb3069b0e04-5353e5acd03mr3832732e87.39.1724955679920;
        Thu, 29 Aug 2024 11:21:19 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8508:ea23:888c:e220:647c? (p200300c78f2a8508ea23888ce220647c.dip0.t-ipconnect.de. [2003:c7:8f2a:8508:ea23:888c:e220:647c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892225dcsm105824966b.208.2024.08.29.11.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 11:21:19 -0700 (PDT)
Message-ID: <a15ff6c2-3f9c-4f1c-ac16-5cba30e22b0b@gmail.com>
Date: Thu, 29 Aug 2024 20:21:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] staging: rtl8192e: Fix multiple assignments in
 rtl_wx.c
To: Alien Wesley <alienwesley51@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 ~lkcamp/patches@lists.sr.ht
References: <20240829113606.76645-1-alienwesley51@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240829113606.76645-1-alienwesley51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/24 13:36, Alien Wesley wrote:
> Separated assignments for pairwise_key_type and group_key_type
> in order to silence the following checkpatch warning.
> 
> CHECK: multiple assignments should be avoided.
> 
> Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
> ---
> V5: Line number removed from subject
> v4: Squash v1 and v3
> v3: Fix typo in commit message.
> v2: Removed two spaces in front of "=".
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> index fc8e7f73b2a4..67c4793e0fc1 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> @@ -526,7 +526,8 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
>   	mutex_unlock(&priv->wx_mutex);
>   
>   	if (wrqu->encoding.flags & IW_ENCODE_DISABLED) {
> -		ieee->pairwise_key_type = ieee->group_key_type = KEY_TYPE_NA;
> +		ieee->pairwise_key_type = KEY_TYPE_NA;
> +		ieee->group_key_type = KEY_TYPE_NA;
>   		rtl92e_cam_reset(dev);
>   		memset(priv->rtllib->swcamtable, 0,
>   		       sizeof(struct sw_cam_table) * 32);

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

