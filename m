Return-Path: <linux-kernel+bounces-433049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A51F9E535F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C44A1641B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05FE1DDA35;
	Thu,  5 Dec 2024 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hy9OhHpI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466E190059
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396888; cv=none; b=ENsfpbIaeYgxcx/0QhCl4dwwb+IcnJeqlXsjUMzmUNdxdhSttvClWCR6aloxYnJ81t5EFQJfrSq6jV1ilnk1ouGzhMVbeN47UIzpO2+6m6GzHjo5DVtVe7mFWG7EtTztuCLc6xNY9OBTJohEOxcQ9qSehF3JKtemt5NT9kPgmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396888; c=relaxed/simple;
	bh=7jzak9MvPN4qRr12LbNBymHBYJIoEDZYDF3D3T6/bmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iVWiNAm9S+QuOlCO3fuG5Pu+MHxJXcMgiG+glKavUSYYP7W9ynkAVcBziD4M3xNNA9guLcr40C9B8JjFmpFhjt6X70rDHnL1B1VHvL9fP+InnKJkF/PGXiFExnGvVhcbioJUDrHLTmv1+yQuhItJ0BWpSjcSksYQOZgNw94ZHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hy9OhHpI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733396885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFy/Xqar4Obttki81CGZmOSw2PSTZcRsLCRsN1Srm5E=;
	b=hy9OhHpIRN3MAdqlCZIYoHnIajZ2//s8zwmbTvCv4mN/lqdbK8F0/UFXvSXX/T0Vf6mh6L
	bHvU8SlBppm+fFmeFoLL5Jz1jm3gx8hpsscLuycZw+k0HAWM1iynUzeY1Ed4DeTn+XKIkx
	qhPanhis2DgG3CkKdidoKYspo5SxyHc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-ZFdyekwSPzCsAIUCflPzmg-1; Thu, 05 Dec 2024 06:08:03 -0500
X-MC-Unique: ZFdyekwSPzCsAIUCflPzmg-1
X-Mimecast-MFC-AGG-ID: ZFdyekwSPzCsAIUCflPzmg
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b66e8dfe04so76579885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733396883; x=1734001683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFy/Xqar4Obttki81CGZmOSw2PSTZcRsLCRsN1Srm5E=;
        b=e1/Q9LNSpZfxz/mf6MqRPxJ/CHP2JL9Kd7AGtrin4MjTsVFwp88CZ2e0MLriQy+Xr0
         nrhlX/MNBeOcA60aLIKU7MeY8nuGgtX2oUaQ7/1xfnHwgya/OMi5II9s0/9p9GZ5OY2/
         X03D/61gry1VP8wasjmdVK1YscP6AieHDkaZ/ALDXxy049kH1FedVhc5Rdbmhndy/6bj
         THIuMhxT5I1QgdBg4rymwNWR0Xft6adny5z6EKUjCk4+hAjkURyBsMe+zUicWszyJpg9
         ztcL56W0K5hB9NN4uMpqZ5lukG5TKtdNY/IOy/DlBEv6t2QzoXCJNlYGowa/NHYPETau
         UZRw==
X-Forwarded-Encrypted: i=1; AJvYcCUkB5nl2ow7VPbtmd6gfqdSH5FBj6OFaRODqXLYUqIH0Ofl7C6W45vR0Z5CnJcnv+Xh43dNaAN936YtkQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5R5tcKQmd730JHbvdEvPUHRhis2AdsdYxZJMntx83QILSBfL0
	Mx8Efb7dmyakxt4ndx6aBhEeyBWHaByRHpgpa96Sw5CWa/fLc2mszyMDxMqd5ZWtWu1lTIxjxGz
	z/KU9G+jd9DS4DIGgs5b/KujCWHDU4ua6ZTLoxeRbG3V4lP+AeTiB8khtq+TO/g==
X-Gm-Gg: ASbGncsO0Z3k2Rf9M2Ro9Beo9HotQzUHRiYERGB/mJ7eMrCYMnswSl4BqI+svFLBqBl
	kNdw9AO0tThx06WLxkRVJwxLUzTO+lnndokzXSO7HpFePXztiNboRQrhGIJYUAHh0BFPaEnxHqe
	URe40jbhX3oVXm26AYDQltPcGaiFMflutt/A02YylZQC5XJSO1AZLV+qb4Hae+opBfyNfWcD5A9
	UVETF4iK2rb3EeNEDX6f5mFP9dMlvdEpOGtliCt9bqTrZ10DBFFroLdtwWUZID2TK+eMFlGJAyi
X-Received: by 2002:a05:6214:1947:b0:6d8:b5b8:702e with SMTP id 6a1803df08f44-6d8b72ceee9mr172147176d6.9.1733396883492;
        Thu, 05 Dec 2024 03:08:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF73BYHYSSO/IIW6W6xOI+A4Bs70aSZyUGPnoMs7ygn24W9AhjOy1ah5mIdbyjBd56P+hybQ==
X-Received: by 2002:a05:6214:1947:b0:6d8:b5b8:702e with SMTP id 6a1803df08f44-6d8b72ceee9mr172146696d6.9.1733396883142;
        Thu, 05 Dec 2024 03:08:03 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da696452sm5392486d6.36.2024.12.05.03.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 03:08:02 -0800 (PST)
Message-ID: <946b59e0-18f9-4e4f-a3c9-3de432db4340@redhat.com>
Date: Thu, 5 Dec 2024 12:07:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
To: Divya.Koppera@microchip.com, andrew@lunn.ch, Arun.Ramadoss@microchip.com,
 UNGLinuxDriver@microchip.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-3-divya.koppera@microchip.com>
 <ec73fe36-978b-4e3a-a5de-5aafb54af9a8@redhat.com>
 <CO1PR11MB477140866E76B0FCEFA05735E2302@CO1PR11MB4771.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CO1PR11MB477140866E76B0FCEFA05735E2302@CO1PR11MB4771.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 12:00, Divya.Koppera@microchip.com wrote:
> From: Paolo Abeni <pabeni@redhat.com> Thursday, December 5, 2024 3:17 PM
>> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>;
>> andrew@lunn.ch; Arun Ramadoss - I17769
>> <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
>> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
>> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
>> kuba@kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>> richardcochran@gmail.com; vadim.fedorenko@linux.dev
>> Subject: Re: [PATCH net-next v5 2/5] net: phy: microchip_ptp : Add ptp library
>> for Microchip phys
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
>>
>> On 12/3/24 09:52, Divya Koppera wrote:
>>> +struct mchp_ptp_clock *mchp_ptp_probe(struct phy_device *phydev, u8
>> mmd,
>>> +                                   u16 clk_base_addr, u16
>>> +port_base_addr) {
>>> +     struct mchp_ptp_clock *clock;
>>> +     int rc;
>>> +
>>> +     clock = devm_kzalloc(&phydev->mdio.dev, sizeof(*clock), GFP_KERNEL);
>>> +     if (!clock)
>>> +             return ERR_PTR(-ENOMEM);
>>> +
>>> +     clock->port_base_addr   = port_base_addr;
>>> +     clock->clk_base_addr    = clk_base_addr;
>>> +     clock->mmd              = mmd;
>>> +
>>> +     /* Register PTP clock */
>>> +     clock->caps.owner          = THIS_MODULE;
>>> +     snprintf(clock->caps.name, 30, "%s", phydev->drv->name);
>>> +     clock->caps.max_adj        = MCHP_PTP_MAX_ADJ;
>>> +     clock->caps.n_ext_ts       = 0;
>>> +     clock->caps.pps            = 0;
>>> +     clock->caps.adjfine        = mchp_ptp_ltc_adjfine;
>>> +     clock->caps.adjtime        = mchp_ptp_ltc_adjtime;
>>> +     clock->caps.gettime64      = mchp_ptp_ltc_gettime64;
>>> +     clock->caps.settime64      = mchp_ptp_ltc_settime64;
>>> +     clock->ptp_clock = ptp_clock_register(&clock->caps,
>>> +                                           &phydev->mdio.dev);
>>> +     if (IS_ERR(clock->ptp_clock))
>>> +             return ERR_PTR(-EINVAL);
>>> +
>>> +     /* Initialize the SW */
>>> +     skb_queue_head_init(&clock->tx_queue);
>>> +     skb_queue_head_init(&clock->rx_queue);
>>> +     INIT_LIST_HEAD(&clock->rx_ts_list);
>>> +     spin_lock_init(&clock->rx_ts_lock);
>>> +     mutex_init(&clock->ptp_lock);
>>
>> The s/w initialization is completed after successfully registering the new ptp
>> clock, is that safe? It looks like it may race with ptp callbacks.
> 
> If I understand your comment correctly ptp_lock in the clock instance is not initialized before registering the clock.
> Rest of the initializations are related to packet processing and also depends on phydev->default_timestamp and mii_ts instance only after which packets will be forwarded to phy.
> As we are also re-initializing the clock ptp4l/application need to restart.
> 
> Initializing ptp_lock before registering the clock should be safe from ptp point of view. 
> 
> Let me know your opinion?

I guess moving the lock initialization before the registration should be
safe.

Please not that the main issue open is WRT code reuse: I second Andrew
opinion about the need of consolidating the microchip ptp drivers
implementation. A library should be able to abstract above individual
device differences.

Thanks,

Paolo


