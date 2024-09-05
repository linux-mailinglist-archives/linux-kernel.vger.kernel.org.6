Return-Path: <linux-kernel+bounces-316791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F15E796D58A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA5B1F293F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40919939D;
	Thu,  5 Sep 2024 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYrl0NrH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877891990C1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531053; cv=none; b=Nqs6oh2BjfMhTLdU6WCMElPqHVb6svxzUhOX5E8m9jyiSyGq4t45FdC+Q9+jqu21pATg4v6q9Vghfytt0rkop8YMYw48CSGg0dl4pmMP4iyhp+tMmKduIt9tTeqkupQVIkhPYb1pju8uC+6adfofUkaqWiK0NV2TLS5E+AblYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531053; c=relaxed/simple;
	bh=cBe8sSpkzIPUNbYdTQ9Y4CF5l4pTJfe4EnCGYPSCLxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2jxBrX+vTNTQALUPkJGJ5+0sliKu5EZllOzoGaM89jeDU5kcPnrRUBdiBTb/yONdXOFfGV3vTJxL0RJmDIA6W1D3/IJdirr3TH8mBw/aSlLGlYZPhNEfpSlOqit/OIdrMt6Hgwq+E9TgWyQfr/e876ADGs2aoxjkQSgyiaWcDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYrl0NrH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725531050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0teAkyIxaQF3tqPPR/0rHNjidomC+KXZ12snZ/y5XOg=;
	b=JYrl0NrHSv7NHyVLkG1G6cYmqxhRpPeWFRz3Uj4I8BFgmsYCW+HgUV/fNTi5PiRIVMKg0T
	YFmnmUwxnZHU7Qy6H9mhO7suFd69ye4P5ijukKEYO6N+EC5LhhCqOWJ5z4WNQkmC4cIKl2
	ewInUfTyjjz3YOgixyL73L8IGIKSnsU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-zdvRA1ZyOziECWGvSbNvlw-1; Thu, 05 Sep 2024 06:10:49 -0400
X-MC-Unique: zdvRA1ZyOziECWGvSbNvlw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3756212a589so436460f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531048; x=1726135848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0teAkyIxaQF3tqPPR/0rHNjidomC+KXZ12snZ/y5XOg=;
        b=S/ybyqe42B94fJ6O7RgBgNpZN///5BHrqKvF4FMVp3WavNFKorWqZRvMRvTGxHFWfO
         3hhlFwVWE4ZyNuJIOFAYjoXqM2IPMO1M3ViwEo31Qg8qqqHhUIi3mBFEKLU6lB/iHDg3
         ScSZUvhIzXFdLl5rkgZcI3Pnk5KkaDfk+vEslK6MwfYPVVe4ulqPw7v4mLchqUzMC80W
         bDoCtYVAtECwPsvdPI6UIkJVMQzzbDwDuwzMMViC+CasRoUjpC2LMeIm6aI1dJpyANlb
         /akPvOtAwgERO4KrZd/jsdreRVJ+shEsATRYDHVla9kjn2IkQl/NBfoOS9vrP8U+OyIB
         +Ohw==
X-Forwarded-Encrypted: i=1; AJvYcCUdV4fN6f8TGOmR6rXpvaewH8gwFp3QPZIxPm92tkg1lrTVKObIyF4aNullh+Ei8zBuscGMxyel+Je4w/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0f4VQlphliPGibABYoCTLcin8+Onqudf5Et/SOVNvQdX0yYCy
	RQlPYyHK70u3U0gcyf+JgAXOhBBNrE9npCDKY1GQSIFcinm/y8lrC1Vy9IAjgvg6THiXKSMVrBz
	hP/QBQkh8anHh/xwmF8Ghy1YKwsHpIcSpzz7jrdiJgM5zkXxh/KdxIqA8y+FHnA==
X-Received: by 2002:a5d:6d05:0:b0:374:c231:a5ea with SMTP id ffacd0b85a97d-374c231ab35mr14568277f8f.5.1725531047893;
        Thu, 05 Sep 2024 03:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFowkwDiPwaM9wpYpfNUi84o0mhCVB4P3QbkABbz603ypTH6pars552aw4N0k7UTIUaCxxNOw==
X-Received: by 2002:a5d:6d05:0:b0:374:c231:a5ea with SMTP id ffacd0b85a97d-374c231ab35mr14568233f8f.5.1725531047372;
        Thu, 05 Sep 2024 03:10:47 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4d391sm19083130f8f.3.2024.09.05.03.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 03:10:46 -0700 (PDT)
Message-ID: <b5da52e7-6715-4f94-ba95-5453972d9f8d@redhat.com>
Date: Thu, 5 Sep 2024 12:10:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 6/8] net: ibm: emac: use netdev's phydev
 directly
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org,
 sd@queasysnail.net, chunkeey@gmail.com
References: <20240903194312.12718-1-rosenp@gmail.com>
 <20240903194312.12718-7-rosenp@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240903194312.12718-7-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/3/24 21:42, Rosen Penev wrote:
> @@ -2622,26 +2618,28 @@ static int emac_dt_mdio_probe(struct emac_instance *dev)
>   static int emac_dt_phy_connect(struct emac_instance *dev,
>   			       struct device_node *phy_handle)
>   {
> +	struct phy_device *phy_dev = dev->ndev->phydev;

The above assignment looks confusing/not needed, as 'phy_dev' will be 
initialized a few line later and not used in between.

Cheers,

Paolo


