Return-Path: <linux-kernel+bounces-548700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2EDA54857
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFDB3AEA0D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F98204F63;
	Thu,  6 Mar 2025 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeFH/08g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C62204699
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258050; cv=none; b=Cw4HHtgIPTnY/fLVOvCVtxC3q+aVdTNE4UjJ02f4SUtN+U4JdyUqjBVJX4UxrTSgrrQFSOqia5BBCEsPLlZ5xvPKoRCMD7ex3MOvKEgK2g6ws5QPFT5q0KK4aVpRPMoRqtTa5p0JeIRCRWF0q2UVF3w9keOCKxS7hGedfaibrrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258050; c=relaxed/simple;
	bh=ZeRw7Ajeju4Ra7AoF300wbpqRFfKh4bBlkQEykUHr/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ro8S7dlhV+UkJUcuV6xvASm6QvWbz9FJcWqno6OSfZ2vg3vm4vo+M4Hr9OXYSO43mxHD9EUNTcdO2wC11w6Pk6Nf5Yd9d4Afa5GU/U4u83PJPjEFxQ+PG25zrhSi3wq/qiuPF2mXm0Sa+/7x81vSDiInRXxdqs9/cmeytOSTNIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeFH/08g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741258047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjRt78Dq2s+uI5+AwqEfT+jWVL8f1Spro5dG2E/jNI0=;
	b=IeFH/08gtjAKpCpow7v1kV/ANTrlMRm2Y9Em1g4hzpp9pvUsjmzIWbgXaaLRgwMpfju0RW
	AeG3kLlRj65XoQo87SI83LZqJupjOBnCoFLjrRQJM+jZtdbcoMZ7JmJb/oSfSDAa83PpbE
	CrOZzDdQ0sbrKSzBhdtTRK3PGrbYsw4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-K129ieRDN92ZXb5BA7-7KA-1; Thu, 06 Mar 2025 05:47:26 -0500
X-MC-Unique: K129ieRDN92ZXb5BA7-7KA-1
X-Mimecast-MFC-AGG-ID: K129ieRDN92ZXb5BA7-7KA_1741258045
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bbbb00891so1994375e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258045; x=1741862845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjRt78Dq2s+uI5+AwqEfT+jWVL8f1Spro5dG2E/jNI0=;
        b=Isw/5Fi57rYUIPl+dJ+4pw1Stt4X0Ecm5BD3fX2WlIEXvSkpV3xDKg6yEFuzbyADif
         suEDspI5zr/+4JN6txvOsgwiQuxgt3nxRaEpJTZFoJLRYINLu3z5xL7K2D4BceyPKjMV
         0NQTzCFwOc6x8QVR+ruqN2cJTDfOP2pZUMfAUuSyZgW6sBMvIh9vpJwv2h6sItPr8eM1
         jaq+dkceerrTjwd/hA0BBNy/xqtLlG1RBgUAjqDclSnrBGEcCjDJrdUFXXx/YYyUEY2V
         2GE8+4pSeUnNqocQRN4C1ZHSxPA/WgqcthcCqoRsMD+agC2Ez5tg9A2NnDD9fyFHlBXC
         Xsig==
X-Forwarded-Encrypted: i=1; AJvYcCUBaF6qkv1F/dezM5rzB0IEkG7UE92aU3KLb5BrsVUQgFzUz5Oz3s38NlDUcXS0pkYq3fb+pQF5ghjnIJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPyIi8oJFknAFtqtOjgpEheHP1ZQJnZX4ySfzOkWbxS21IgOF
	PKzhohgr7f2PUQn7F4fYMiS/9LKXho9lokT6UtNiHUAqu5hDLlVJ29Cmpr8eruJv4YrtieOGZHL
	kQTF96NUTGQgSJ21mbi+yZGIp0vjncdJlmmmO6x320ayFg9Nm9da+G+wRRjnKtQ==
X-Gm-Gg: ASbGncv8dql4iYajBbk7xwiYSwAyR3tXHPebu7v/l/orrSeQKDSo4wMxP0zGhWvs+Hr
	mCvhvHbIHsIPrm1mC6lJIYw/gvixSP7ADS7NNhuFdAINK6AxpfQEKEZ8tlI3FUJ5h7pNFZxdBhP
	rGhZD+/djQ2GyRz3E2pWoxZTSXfh2jkSlwPEcSL62+PpvtFkwla/A4OXxaL/FCqCIKfptH+4HYy
	q3+1HG77rI6NVyJ51WxVf4CI81NVluveSTgiEjE8dlOAak4J2rMqbyYSXym5dxjjsaxSA7aGcfb
	QWkFZDsu6G4T4iUNHKHqk9sVQEOSsXG2ZDJ8c6Fs34CevA==
X-Received: by 2002:a05:600c:474b:b0:43b:caac:5934 with SMTP id 5b1f17b1804b1-43bd2940d7fmr64405975e9.10.1741258045161;
        Thu, 06 Mar 2025 02:47:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMjHLrijI3JnQ9/rTJXDsThbCAGg6S1g+aRd1hhWjvbEr7MYhP077xwT5HmEDiJR4B8678IQ==
X-Received: by 2002:a05:600c:474b:b0:43b:caac:5934 with SMTP id 5b1f17b1804b1-43bd2940d7fmr64405645e9.10.1741258044718;
        Thu, 06 Mar 2025 02:47:24 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42920a5sm46021545e9.11.2025.03.06.02.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:47:24 -0800 (PST)
Message-ID: <5d0b952a-ec07-4ebf-8228-a424fc0de4cd@redhat.com>
Date: Thu, 6 Mar 2025 11:47:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 02/13] net: phy: Use an internal, searchable
 storage for the linkmodes
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
 <20250303090321.805785-3-maxime.chevallier@bootlin.com>
 <738bd67c-8688-4902-805f-4e35e6aaed4a@redhat.com>
 <20250306095726.04125e5f@fedora.home>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250306095726.04125e5f@fedora.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 9:57 AM, Maxime Chevallier wrote:
> On Thu, 6 Mar 2025 09:30:11 +0100
> Paolo Abeni <pabeni@redhat.com> wrote:
>> On 3/3/25 10:03 AM, Maxime Chevallier wrote:
[...]
>>> +/**
>>> + * phy_caps_init() - Initializes the link_caps array from the link_mode_params.
>>> + */
>>> +void phy_caps_init(void)
>>> +{
>>> +	const struct link_mode_info *linkmode;
>>> +	int i, capa;
>>> +
>>> +	/* Fill the caps array from net/ethtool/common.c */
>>> +	for (i = 0; i < __ETHTOOL_LINK_MODE_MASK_NBITS; i++) {
>>> +		linkmode = &link_mode_params[i];
>>> +		capa = speed_duplex_to_capa(linkmode->speed, linkmode->duplex);
>>> +
>>> +		if (capa < 0)
>>> +			continue;  
>>
>> Or even error-out here.
> 
> Good point yes indeed. Russell raised the point for the need of keeping
> this in sync with new SPEED_XXX definitions, I'll add a check that
> errors out.
> 
> I hope that's OK though, as higher speeds are introduced and used by
> NICs that usually don't use phylib at all, so there's a good chance
> that the developper introducing the new speed won't have CONFIG_PHYLIB
> enabled.
> 
> Is that still good ?

I think so. New linkmodes should be added on net-next. Booting the
kernel with phylib support on any device should catch the error. I think
even the CI should catch this.

Thanks,

Paolo


