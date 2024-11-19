Return-Path: <linux-kernel+bounces-414194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4119D2497
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF960B239DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E541C4A30;
	Tue, 19 Nov 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwoDrutp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9161A9B24
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014632; cv=none; b=OzH3OTj9akyi7HmpgJ2TGkxvCXHoPk9QtDsBZQ6visbjSZFiOpea9WRC8L3z3259GUiAp5yrVZ9mm2smFzwQ9ZStyIHo2T7lyfMHOj8jdAEcp7AuU6GGB2BX5YKoezihwa3BU/Vq1oK95GceEniqSmsXiPGtElYaisP3BSVQ5oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014632; c=relaxed/simple;
	bh=LcXG10pkY4nJM0gRxEgW3Cpwhu0tG4XCMdI71du9r88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSxKEMlpOEL4fSWSkdTjq1Xq5Sgn0bu8U3v286IYkAQ5d7R1+X/LcMM0eWvnt3sJO5b0qQPbfER7X7CEZYilib/cXVenH9DhRINbbaAMrM5hEv0v6yLpL3kfTmhvQi0Caa9grw7FhguQytHd6I+ppfwjoX/4M40Prxri8eie7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwoDrutp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732014629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3CEd+clgPFVRk8eaz+5YffYgqV7UVBEYHjaZLke59o=;
	b=gwoDrutpystL+Sls6h0aQqbtwsWagS0FFrWpXBiJmoMDFf04rNRJTKGKPXF43z+EIBITwa
	TIuxcShikWVTW3yBX56WA8Vl2R1aEHou420VEKoLZ9/xDajYFDxbOnlPSAM9wKzDTo8kPl
	ea5f/qDDA4d9XqxEvgoJiPIsjMOoYnM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-lYogYme_PWWw-BqaQ-AckQ-1; Tue, 19 Nov 2024 06:10:27 -0500
X-MC-Unique: lYogYme_PWWw-BqaQ-AckQ-1
X-Mimecast-MFC-AGG-ID: lYogYme_PWWw-BqaQ-AckQ
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6ee7856bcf2so46964987b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732014626; x=1732619426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3CEd+clgPFVRk8eaz+5YffYgqV7UVBEYHjaZLke59o=;
        b=aYq1oRzRa4WOpcOgDiib79JUdB5pwAe5Pcfwy9eQQKWyxtzumZUILGebPd+90ccKFA
         wmOL6fM73EpJQZ8m5HUt+a75NFSaU/9j/MhhdhUSakElgEGTUAYpStu1XhE4GVQoyE6Q
         o/Kae3o2DhMq+IVS/eFkmD4eD5NjjVw70bhdenyFIbs2Dxij/+U+8RkgwucI0DEALqA8
         auOeaskVzhA+uYMkARZW8grgiCU8lqGaNKWwIu+ZchQO/GP0+Pp3KBDydw9YOtJxgKjb
         725/fDG82HSOSRHP64Y6PDiIxfh+qnX5F+rNs6hVP57FNjwHy0fUAjWJxBqWV7ZKLpGX
         7xLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7S+Xw7wcSaGeC9KFPAHMZ7/wurIoTj6uDkBbLgp0IC3DeBGpf+YTUVgn43fp/vyZ6TCFp+UJDFN394dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlnxljE+YwytIL4rLJ0xPGE4gJ7R/WD67WSTQRHAxiK3n3WJ5
	gLai+7u6JQoznxg12x+imXoNg93FVaWK8n1OnN6AH0DqhfKLo4KKalW0E0leZL++R7bwsfprjRU
	IJKSi9ZB5TuQ5OuRWjvYG8fa1zsI46UkATJFB6wLLilYWf+5TlFWZfpPNk1w86w==
X-Received: by 2002:a05:690c:610f:b0:6e7:e76e:5852 with SMTP id 00721157ae682-6ee55ca37dbmr168937357b3.32.1732014626638;
        Tue, 19 Nov 2024 03:10:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3hEKXZ8OIPdKHggBClCMhzsNt9PMcc+Km1iy5ohzxrmKycu0tAz1+EM1Xgg8AqAsOXJIVGQ==
X-Received: by 2002:a05:690c:610f:b0:6e7:e76e:5852 with SMTP id 00721157ae682-6ee55ca37dbmr168937077b3.32.1732014626354;
        Tue, 19 Nov 2024 03:10:26 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dd205ffsm47067066d6.84.2024.11.19.03.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 03:10:25 -0800 (PST)
Message-ID: <f8c50ee6-a3d7-45eb-9c11-8018cc4043cb@redhat.com>
Date: Tue, 19 Nov 2024 12:10:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v7 0/4] net: dsa: Add Airoha AN8855 support
To: Christian Marangi <ansuelsmth@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
References: <20241117132811.67804-1-ansuelsmth@gmail.com>
 <20241118144859.4hwgpxtql5fplcyt@skbuf>
 <673b88ea.5d0a0220.17b04a.bc4b@mx.google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <673b88ea.5d0a0220.17b04a.bc4b@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 19:35, Christian Marangi wrote:
> On Mon, Nov 18, 2024 at 04:48:59PM +0200, Vladimir Oltean wrote:
>> On Sun, Nov 17, 2024 at 02:27:55PM +0100, Christian Marangi wrote:
>>> This small series add the initial support for the Airoha AN8855 Switch.
>>>
>>> It's a 5 port Gigabit Switch with SGMII/HSGMII upstream port.
>>>
>>> This is starting to get in the wild and there are already some router
>>> having this switch chip.
>>>
>>> It's conceptually similar to mediatek switch but register and bits
>>> are different. And there is that massive Hell that is the PCS
>>> configuration.
>>> Saddly for that part we have absolutely NO documentation currently.
>>>
>>> There is this special thing where PHY needs to be calibrated with values
>>> from the switch efuse. (the thing have a whole cpu timer and MCU)
>>
>> Have you run the scripts in tools/testing/selftests/drivers/net/dsa/?
>> Could you post the results?
> 
> Any test in particular? I'm working on adding correct support for them
> in OpenWrt. Should I expect some to fail?

Unfortunatelly this landed on netdev too close to the merge window. I'll
unable to apply it on time and process the net-next PR as expected even
if it would receive ack from the DSA crew right now.

@Christian, you will have to repost it after the merge window.

Thanks,

Paolo


