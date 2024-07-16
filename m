Return-Path: <linux-kernel+bounces-253579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C19B932349
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2921C22662
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF53198A2A;
	Tue, 16 Jul 2024 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtK4eel8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F4197A88
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123176; cv=none; b=ZHFrI5/y0SjcyWcBXAfinRsnkjFWgqQKdSmPIKKN9jgrwfBxbJd+TcB6+z3BwgnExY5rPLTg8PYrx2ScgF5yx4rMOWsLAvSEL0v/4vepfxtfVUlRnEeQQa2T388QpMgg45gpNRVY9YuBl7Vx7GbimhjnshuT8YEiLUz/7Hgjf94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123176; c=relaxed/simple;
	bh=MuJNU1T3c+rq29kKQ/IzwJetlpRBmyymvehDVeTlyUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jVTkaWbgo/ORlF/mkbiVXBVx0mQwntcpo0Hrx5Qx+zUXchSfg7piSqvcv38sRgTlQkZQNNIpi1ELGMzUlGSuiCIf7pJOY/QGHxNzuyogU9EnS1g680T1U7TFcYwE0S23Ah2hAspCTX6lX5dBorF79Lo+IOBDDhby8p706huCeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UtK4eel8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721123173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVTAsXyhEhNtCMOyvfccNfT6abKfoWaC2WG7+Z3JHng=;
	b=UtK4eel8tcStoSvlsBAxkq7/Qb13xGsGW306i0ha0VUNhj0UtcP3ufg5iTqIaEkym+ZlKd
	Tooevn86W1cnokphtvAJIdoLMncJYeU5lQ9dlUI/hnjbxH6rJi1hjF9/v/6dTxkNSbPNxb
	6j+bDIUQys57zuf5+czXgIB7oGRf6ig=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-9LKzmmUKOReWqoUtvdZJgw-1; Tue, 16 Jul 2024 05:46:11 -0400
X-MC-Unique: 9LKzmmUKOReWqoUtvdZJgw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4266a5c50fcso9958935e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721123170; x=1721727970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVTAsXyhEhNtCMOyvfccNfT6abKfoWaC2WG7+Z3JHng=;
        b=xRz72IJyJApeZWBKRFkcI/CTkGdlAX07t4BSSwQlXVFZZcIG9wCwW3VpIkG1qP/5IO
         SWf0SjiqDJUhz2kTtYwbiMs7eZMILXJCKrSbOj7rWvS1fbHjISvRhEsOhQ1IfDV6hyxp
         Rm6era5U+pK0/WEZNiNbYeFwFZsuGE6mkfQ+ggsBEz/pPLHpwPAA9ilsoSLlgqnrtGlV
         FiT75qm+RyoQP8RN6t7itw700W/Zd0aIwcl+WxAXx9X+f59AFGxqtn6WWKLdiMUSAaZV
         xlmUiVJFYLfNID7tbDSr/lA3CGi/HWaRJAAZfbSbzXBv4KrIHXoTMnz819pbU/Jcnt8J
         6HIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVub8kp4suU+CJnIaMaM8pHK93rYC3+F+9DCZ6qjAW7iY8nyaonua9EgqBilN4JYBqsfziZSTWvndizPIOlkI3hkvaW3Xx9d5LMgPlL
X-Gm-Message-State: AOJu0YyEGlyr5+HQqDiaKv+LVH7E5dqH9xusYbHylwV5kFf75b5LfZKy
	EHMkIjXNlHB4iDyidnBNnPHMCqG5gLfr40S4rp+EZtZA2ob0FDIYwgIVi+3D/WIcAN4u/ijxFFZ
	BzUkKZPBRRebGu5jD90Q354FxMrGsOg2HQJOYYgCONgjfkq8xFTHklv59BdKEmg==
X-Received: by 2002:a05:6000:178c:b0:360:872b:7e03 with SMTP id ffacd0b85a97d-36823e5933bmr1052623f8f.0.1721123170614;
        Tue, 16 Jul 2024 02:46:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5xQI8nA3bO4/vGaWiWPyzzVJObEGcNTe+htH+LhWyGA1wvfDs8jCXpBBEiX25SDN9niA1hA==
X-Received: by 2002:a05:6000:178c:b0:360:872b:7e03 with SMTP id ffacd0b85a97d-36823e5933bmr1052615f8f.0.1721123170269;
        Tue, 16 Jul 2024 02:46:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3? ([2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5edb449sm116993465e9.35.2024.07.16.02.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 02:46:09 -0700 (PDT)
Message-ID: <b5a2f43e-790f-475c-bb63-539af91513ac@redhat.com>
Date: Tue, 16 Jul 2024 11:46:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: lantiq_etop: fix memory disclosure
To: Aleksander Jan Bajkowski <olek2@wp.pl>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shannon.nelson@amd.com,
 sd@queasysnail.net, u.kleine-koenig@pengutronix.de, john@phrozen.org,
 ralf@linux-mips.org, ralph.hempel@lantiq.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240713223357.2911169-1-olek2@wp.pl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240713223357.2911169-1-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/24 00:33, Aleksander Jan Bajkowski wrote:
> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
> index 0b9982804370..196715d9ea43 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
> @@ -478,11 +478,11 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
>   	struct ltq_etop_priv *priv = netdev_priv(dev);
>   	struct ltq_etop_chan *ch = &priv->ch[(queue << 1) | 1];
>   	struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
> -	int len;
>   	unsigned long flags;
>   	u32 byte_offset;
>   
> -	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
> +	if (skb_put_padto(skb, ETH_ZLEN))

You may want to increment tx drop stats here.

Thanks,

Paolo


