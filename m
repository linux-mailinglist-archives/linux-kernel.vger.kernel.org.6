Return-Path: <linux-kernel+bounces-336807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE8098411C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A581A1C21F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06831537D9;
	Tue, 24 Sep 2024 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHhtrd3U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4100914F9F7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167957; cv=none; b=OdZRkqDW8zXlO/DGX4mGE512/hyxxtWWHSu1mjg2Hv9W/Sz64QypU2JHrKBcxgVpEloJivhVdUfeCxWSC9m6HXhmvTLoS33+Fbd9fanbB4yNsXD01VAjvZ0UfQ3givqOYb41g9PeXjhsjQBwPcQt3+jy3fBEoVnPoAq/Ryr9CBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167957; c=relaxed/simple;
	bh=mhoYgap/uQb6bEf0N8US2RqeLX6LS7eZQ3c9qsLcGbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDoTUPfMucpUiT/DH1tSqEh0Vw0IBEilA3L7+g9zN9pSCXI6Gka6f6LKuyQySUxQOykSEwaj4SZz1ylxIB/gmk0tSs7vpkzOE+3SOmrHpoM7NYKaGi7Pup1TgMqCRVwJC2Ep1sh1dP4Pd/em2nl/XD0Gi7Uq4IL8vt1HgenW9u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHhtrd3U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727167954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuF0COWCDOedTqZ8WH1SOFXABRHGiPKF0L4U6ddrYnM=;
	b=VHhtrd3UG/0UVJUAoJTvgMnZvAUfKSrOICjEbKpbiI1RDEGbB/ale0OJIPTQDJNOPO9qNO
	PNcfQrOXSF+saZjB41jbkjMF33VJOCegM7AwNYfe95V00woc6wgb+REKh3hkpnbIRB6u/a
	xVe6MLG1+i9JjECaviYX0oPbKXBTiis=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-a86kHaf5NsqeK5iDdiQ9qw-1; Tue, 24 Sep 2024 04:52:32 -0400
X-MC-Unique: a86kHaf5NsqeK5iDdiQ9qw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb830ea86so37122695e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727167951; x=1727772751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuF0COWCDOedTqZ8WH1SOFXABRHGiPKF0L4U6ddrYnM=;
        b=OzcCeDqTm/SsjYMMvDyrQ71rdIW/J82yZgmJpA7qxFyJsMWf0TXjfGqn7jKgNvqBhi
         mCOyW2C2Ux+bomyuxxpfEnQD8ovko8tVpaQDD57abnHsXhGsnvOSRRYPhbajunXUnr8D
         5X57UmQgs+52QzUcYO4Z6dz1ffwR2rYWrkwjQx46K/9Qn5EQyq9Jar2h3zNuFs3SmmGN
         p4VuoSa+aeHZyr1QcWCLWhpTXFQyHX3jwpzAfGFl5WN3vle3ZjGn9+0hvZY3XFeNs/lD
         fKSvjwRAhpP9i269+CbttsPvak4UP94BddfN/CYEKMke7eJW+q0U+7UU7h/1YFYuLV0i
         WYOA==
X-Forwarded-Encrypted: i=1; AJvYcCVsAeAT39Wm7kLVQRfRqemmzCGUQMbYyEJjODWNf+Dw30TAy6Y0rkyPddPAn+bzxpBUynkJX8rnS4XA3GY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoykbyix48M8wEYJskXBJQ2KuFpAOlYjuiDRV90lSTwiR/LIVf
	wct+TfXj3zwkcG2HArTAl4o+mX/23cQhGd3HYSZcOCqf7AsY0Pe31j7SL2BPQx66R4i48kt8ajt
	DXOjRAlYrh1UVP4nUsecHJVg0ZEcm3J3i6zR92BeCvY+CrS/gs5Y2VP3Zsj8EuQ==
X-Received: by 2002:a05:600c:3b17:b0:426:6710:223c with SMTP id 5b1f17b1804b1-42e7abe7aebmr88588085e9.9.1727167951512;
        Tue, 24 Sep 2024 01:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoKrqXcktYLKzPCztLzPu3d8E5Ix28prsE1km48zvvajtpLmXWAuO42NmtIZH+YjNJEWExwg==
X-Received: by 2002:a05:600c:3b17:b0:426:6710:223c with SMTP id 5b1f17b1804b1-42e7abe7aebmr88587915e9.9.1727167951060;
        Tue, 24 Sep 2024 01:52:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e902b6804sm14815795e9.33.2024.09.24.01.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 01:52:30 -0700 (PDT)
Message-ID: <34366741-a472-4ebd-90cc-07c8447f06b9@redhat.com>
Date: Tue, 24 Sep 2024 10:52:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: improve shutdown sequence
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 linux-kernel@vger.kernel.org
References: <20240913203549.3081071-1-vladimir.oltean@nxp.com>
 <20240924084343.syhmwim5swcgppha@skbuf>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240924084343.syhmwim5swcgppha@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 10:43, Vladimir Oltean wrote:
> On Fri, Sep 13, 2024 at 11:35:49PM +0300, Vladimir Oltean wrote:
>> Alexander Sverdlin presents 2 problems during shutdown with the
>> lan9303 driver. One is specific to lan9303 and the other just happens
>> to reproduce there.
>>
>> The first problem is that lan9303 is unique among DSA drivers in that it
>> calls dev_get_drvdata() at "arbitrary runtime" (not probe, not shutdown,
>> not remove):
>>
>> phy_state_machine()
>> -> ...
>>     -> dsa_user_phy_read()
>>        -> ds->ops->phy_read()
>>           -> lan9303_phy_read()
>>              -> chip->ops->phy_read()
>>                 -> lan9303_mdio_phy_read()
>>                    -> dev_get_drvdata()
>>
>> But we never stop the phy_state_machine(), so it may continue to run
>> after dsa_switch_shutdown(). Our common pattern in all DSA drivers is
>> to set drvdata to NULL to suppress the remove() method that may come
>> afterwards. But in this case it will result in an NPD.
>>
>> The second problem is that the way in which we set
>> dp->conduit->dsa_ptr = NULL; is concurrent with receive packet
>> processing. dsa_switch_rcv() checks once whether dev->dsa_ptr is NULL,
>> but afterwards, rather than continuing to use that non-NULL value,
>> dev->dsa_ptr is dereferenced again and again without NULL checks:
>> dsa_conduit_find_user() and many other places. In between dereferences,
>> there is no locking to ensure that what was valid once continues to be
>> valid.
>>
>> Both problems have the common aspect that closing the conduit interface
>> solves them.
>>
>> In the first case, dev_close(conduit) triggers the NETDEV_GOING_DOWN
>> event in dsa_user_netdevice_event() which closes user ports as well.
>> dsa_port_disable_rt() calls phylink_stop(), which synchronously stops
>> the phylink state machine, and ds->ops->phy_read() will thus no longer
>> call into the driver after this point.
>>
>> In the second case, dev_close(conduit) should do this, as per
>> Documentation/networking/driver.rst:
>>
>> | Quiescence
>> | ----------
>> |
>> | After the ndo_stop routine has been called, the hardware must
>> | not receive or transmit any data.  All in flight packets must
>> | be aborted. If necessary, poll or wait for completion of
>> | any reset commands.
>>
>> So it should be sufficient to ensure that later, when we zeroize
>> conduit->dsa_ptr, there will be no concurrent dsa_switch_rcv() call
>> on this conduit.
>>
>> The addition of the netif_device_detach() function is to ensure that
>> ioctls, rtnetlinks and ethtool requests on the user ports no longer
>> propagate down to the driver - we're no longer prepared to handle them.
>>
>> The race condition actually did not exist when commit 0650bf52b31f
>> ("net: dsa: be compatible with masters which unregister on shutdown")
>> first introduced dsa_switch_shutdown(). It was created later, when we
>> stopped unregistering the user interfaces from a bad spot, and we just
>> replaced that sequence with a racy zeroization of conduit->dsa_ptr
>> (one which doesn't ensure that the interfaces aren't up).
>>
>> Reported-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>> Closes: https://lore.kernel.org/netdev/2d2e3bba17203c14a5ffdabc174e3b6bbb9ad438.camel@siemens.com/
>> Closes: https://lore.kernel.org/netdev/c1bf4de54e829111e0e4a70e7bd1cf523c9550ff.camel@siemens.com/
>> Fixes: ee534378f005 ("net: dsa: fix panic when DSA master device unbinds on shutdown")
>> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>> Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> ---
> 
> Andrew, Florian, FYI: this is marked as "Needs ACK" in patchwork.

FTR, some additional slack was guaranteed for reviews, given we are in 
the conferences season ;) (and some/most people are traveling)

Cheers,

Paolo




