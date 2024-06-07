Return-Path: <linux-kernel+bounces-205806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555B90008E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2473C1F24550
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B0D15D5A5;
	Fri,  7 Jun 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfDtFfM2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E7515B14A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755602; cv=none; b=nUhM8MxHSIlp3C47rhP0kHjvFACRAUU56dWBpUGdPiVAl6ytCzKsWwqfdznlRTYTztJBQ3hhZxnNohYPDb3/x2+zW5MBD2zQWUcfJJqgeWaCP8KT2YOKRR3m2oXemhVaAcoWqwYAD8pL7Ems2qCqWEFDigPQ7lqoDMBB1KYExuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755602; c=relaxed/simple;
	bh=vTEZCukUMXcbXJO9IWA8dOisP930Ku2NFFH6hnITE2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXqWU01hozoU1Qi3y8eA1k/gmLL6kPizbsI0CbyTqniJgN3dS+znDYelkf6HYf6jZoDil4za/IVwQj6YIeJXw3drARVJMdh6kB5F9kS5n8YH5GtYADanC7fQ6LiCBPkl4SUCvYaVFtkOMpFTC3D5uyE42cstAgDT3xu0D18XkR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfDtFfM2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717755600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/k0UOD2XzT93LwcNZDcZVp/aAS4aZSAyvm1MCnMlto=;
	b=PfDtFfM2eG+cuDutfDMP6KR7ZkH5nt6fQIE4Nptr7BcITM0+QIjW4MbQ/9mWWQdq4ZsiIo
	oRe6Ot2HC+7z8ToHKybl4xOg5OZXwMY0nwrfwwik1hnytlAoXX5+oxYzfB1FULWfcIJY7z
	JAPrlR4l+swxMPzhD3pQcd14h/tPpcE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Ggh4ah1cNOWCfa-n_i2gpw-1; Fri, 07 Jun 2024 06:19:59 -0400
X-MC-Unique: Ggh4ah1cNOWCfa-n_i2gpw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6c82d264ccso89255366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 03:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755598; x=1718360398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/k0UOD2XzT93LwcNZDcZVp/aAS4aZSAyvm1MCnMlto=;
        b=KCOwPN7kC3hJH60dHOrTk04mHUJRJ3C+PcLNIctn7IBeuYHyB4Y7kAA8Fjv2fAkoO5
         AN6WMuE2v1GcJYq9hS49a8ffn6xaIW9xsnZIhQzh4sZD1JgJyKQu8J6kSoeY8LX00MwC
         NXahbzPjxNvlifIim8rcjwljIyI1DJeMogy53zA3SyNyekc+eC5MOWjk6MhVgwYP8925
         LR8fZ+HuRRg2b4av3KGcw31PtN/Y1RkRJp3QQzBW+uGmCHQ9zmTEBQ0oBLBs0NmyZs+Q
         jjAGhkUeSpxkXyvB/LXmTbTqOCXDxmIKUZ94C8PlK5WXYW0qPNqJk8L83ZVJPZsSJdXG
         CY9A==
X-Forwarded-Encrypted: i=1; AJvYcCX6SVFmvuH2rs7r5+WfYDZTcORooaKh8lHFPEY9wIoDSdU2OGM9wxZ1yFatC7gLN/QR6PztSrGR4n5imZXb7VFF3PkG72tVj+wUUP40
X-Gm-Message-State: AOJu0YwZWryTZrViO+TxcPXMxikWR8s2BIiGfnfvWXQTts2f7YULC9rW
	uorCFZfRVo+st+ocsNXDFxULl4sjO+T1GqA2kRfQZ1zcx4af2aZgMsAESWowO/zQlNvO4VThUcU
	8zBBU7ilAcOsODMhqpp/YcJGqk8NDKzM+coAI5vhAIdVeJef6lxQiB2rO32yJ2A==
X-Received: by 2002:a17:906:1115:b0:a68:c6e5:3574 with SMTP id a640c23a62f3a-a6cdc0e40cemr136190066b.75.1717755597983;
        Fri, 07 Jun 2024 03:19:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpxxlwVPDRCJiZJv2Ua4GosyAN37/Sah9MwXT24eqOxTcjruBidwO3ep0dAi45T+RHQ8P8dQ==
X-Received: by 2002:a17:906:1115:b0:a68:c6e5:3574 with SMTP id a640c23a62f3a-a6cdc0e40cemr136188466b.75.1717755597601;
        Fri, 07 Jun 2024 03:19:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eaedesm223566166b.119.2024.06.07.03.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 03:19:57 -0700 (PDT)
Message-ID: <5d037003-a90b-4607-8eb6-6fdd5824e373@redhat.com>
Date: Fri, 7 Jun 2024 12:19:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hung tasks due to a AB-BA deadlock between the leds_list_lock
 rwsem and the rtnl mutex
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Linux LEDs <linux-leds@vger.kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, johanneswueller@gmail.com,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Genes Lists <lists@sapience.com>
References: <9d189ec329cfe68ed68699f314e191a10d4b5eda.camel@sapience.com>
 <15a0bbd24cd01bd0b60b7047958a2e3ab556ea6f.camel@sapience.com>
 <ZliHhebSGQYZ/0S0@shell.armlinux.org.uk>
 <42d498fc-c95b-4441-b81a-aee4237d1c0d@leemhuis.info>
 <618601d8-f82a-402f-bf7f-831671d3d83f@redhat.com>
 <01fc2e30-eafe-495c-a62d-402903fd3e2a@lunn.ch>
 <9d821cea-507f-4674-809c-a4640119c435@redhat.com>
 <c912d1f7-7039-4f55-91ac-028a906c1387@lunn.ch>
 <20240606063902.776794d4@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240606063902.776794d4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/6/24 3:39 PM, Jakub Kicinski wrote:
> On Thu, 6 Jun 2024 15:12:54 +0200 Andrew Lunn wrote:
>>> So it has been almost a week and no reply from Heiner. Since this is
>>> causing real issues for users out there I think a revert of 66601a29bb23
>>> should be submitted to Linus and then backported to the stable kernels.
>>> to fix the immediate issue at hand.  
>>
>> Agreed.
> 
> Please submit..

Done: https://lore.kernel.org/linux-leds/20240607101847.23037-1-hdegoede@redhat.com/

Regards,

Hans





