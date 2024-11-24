Return-Path: <linux-kernel+bounces-420293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC4C9D786F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 22:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2761B22831
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 21:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EA8175D5D;
	Sun, 24 Nov 2024 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QUX35lIG"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4142500BB
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732485442; cv=none; b=UBkF9cbLdvAeWydGFxCWdMbOc58mnume0AAL9Zl1sgZ0GzPIbZR0NYjdMJPrX+EkQB8x17+/h+2WGFY7Wy419pv0dplWWwYsSvrLixJP4XHSmGk7wyPoIgo7LE1EimdCdy0fLBa6PAFM7+WXmjPXtTdCqAynFeijnBELxShSX54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732485442; c=relaxed/simple;
	bh=NpHCbf62av9/PPK7BaTpxt0lk/75DwEWPCY/Tnu2xKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWMkyE4LGUmnNlbwx8G8cxniW1CoimWOecVt0F0LGh4Dl/A6R3Y+IOkggrv9eE5RSfim2KCmr1RR08JX2V2jiPUdoupo4JIEVtri+JP+MnEzPSUg5Dc4X2K/9UP9izdsD9O6c9KegVxo5tt6YBWZbVDl3pSNubnCj5CTpqDTcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QUX35lIG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3825a721ae5so2017005f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 13:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1732485439; x=1733090239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5yrXMRtai5EAywu8wJpj+bkyRvZoed7ZFVKBNaw1x8=;
        b=QUX35lIGU4J90gAPqLGLpeslC5TYJlOtSifIrHfxjg52X/c6vNNQ5Bb06n5KIoo6GZ
         sOXpuFtVVTD8WZmUnz1JTOGpaOuCE4zp2Q8KL/4RjddPVXeq4QoSreubkg1tN8o2BbGJ
         g2d29LmZz0/vR2TT1TnnYi/4ZnJ7d2u9sbF0ecnEHHjgNToZJoCsC6CsAvJFD7Fctmqf
         eCvSByJxoK70ewVNDQ0EC0p6HLS6PNGbIG32SQxMT2jTZ86HadgBa4izydFQ03ld7YPk
         oRQJaWFna7UXA3uk5f4OiWPhKB97Es6K4VA+WIWHntBQkpaL66U8YeAyBHaAVrK61eHq
         x7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732485439; x=1733090239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5yrXMRtai5EAywu8wJpj+bkyRvZoed7ZFVKBNaw1x8=;
        b=rD1wMXygQYekjJhovf01Fanmc/HnvDLzseWVrMpn+Tdt8yZtVkfFXskpdFhvihD11m
         xcx4MX4VQdOrI+9U1WH2Yqq58FVpb2pM41wwWOn+VQK+ou10PYKMB8y93wFi7jTkFUCZ
         k33uiKErkc8rgdtyoOpWW5KSP2EDt+qudtgC6CWlE9yDDxrT+8mo5vt07pQ7LA2o8Anj
         n2hoSGa5j2QOsfYBHA6i5n3w7o/ICDswba2j65VSBJ40oPpmGajascqPNpjt/twaWsz0
         WIQQJRCsFzrNzxSH9vBSU/f2V5bgl4u3I4G5hCdzaMZAg4V1r7B/+3xveFJdinL5cyb+
         jGaA==
X-Forwarded-Encrypted: i=1; AJvYcCWq67FsRapQv3TA0hvGB/RP4f6eD79ASaI7vpUhnsJfYjvCbafEnqFZWKN/mxpFd6JCkdcFXE2JOo9knIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQ6/uER1ID+ArpQED7sPiT0cVcyafKmv4Rce+59yQKhIgaXXG
	IX18MAdcXl1tYKSX2n6m2qPYuG5+g2Q8cab86VC/7H753fl1aJpaOI8VoB8paNE=
X-Gm-Gg: ASbGncth3FiNkvpzEHo5oZAB9karr7eMOfZ5lJL0dx10s3Rxj8dSUxfaX+nPKTS05jG
	p3cd0lg/ePN0pp/iAvylzJ4Bl6UA11qCWlBjxZopqy3Mkm+z315+1sEJ0IDg6qHIU+g4QO0q9A9
	jxxJUXBD4oSjon+b+hz8G/GnJLET8tF9kqkDGLlhXZAcTe6IVMGnuqpiVCdG6izPSfcnVs4X5Gp
	3ClmJ5cihid7ZYHuscwKHWiD0mJ+0fAqLZd6YZKU3vwPKI+uoF/
X-Google-Smtp-Source: AGHT+IGMAOqJMIhmfSxPxSLsMr48gcoyUhLJuaGrSWiRPA3cEqIM0EpifqKQyZ89S0Tan5CyBkK6Tw==
X-Received: by 2002:a5d:6f1d:0:b0:382:49c0:131a with SMTP id ffacd0b85a97d-38259cb7f74mr12568969f8f.1.1732485439448;
        Sun, 24 Nov 2024 13:57:19 -0800 (PST)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5fa2sm8876697f8f.1.2024.11.24.13.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 13:57:18 -0800 (PST)
Message-ID: <c09bb2f0-2aff-4dc4-bf9b-53f97fd2d878@blackwall.org>
Date: Sun, 24 Nov 2024 23:57:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next (resend) 2/4] net: bridge: send notification for
 roaming hosts
To: Elliot Ayrey <Elliot.Ayrey@alliedtelesis.co.nz>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "roopa@nvidia.com"
 <roopa@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bridge@lists.linux.dev" <bridge@lists.linux.dev>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
 <20241108035546.2055996-3-elliot.ayrey@alliedtelesis.co.nz>
 <e562704277f5d64a37ea67789b8e7d13d2cb12a4.camel@alliedtelesis.co.nz>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e562704277f5d64a37ea67789b8e7d13d2cb12a4.camel@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2024 23:23, Elliot Ayrey wrote:
> On Sat, 2024-11-09 at 15:40 +0200, Nikolay Aleksandrov wrote:
>> No way, this is ridiculous. Changing the port like that for a notification is not
>> ok at all. It is also not the bridge's job to notify user-space for sticky fdbs
>> that are trying to roam, you already have some user-space app and you can catch
>> such fdbs by other means (sniffing, ebpf hooks, netfilter matching etc). Such
>> change can also lead to DDoS attacks with many notifications.
> 
> Unfortunately in this case the only indication we get from the hardware of this
> event happening is a switchdev notification to the bridge. All traffic is dropped
> in hardware when the port is in this mode so the methods you suggest will not work.
> 

I see

> I have changed my implementation to use Andrew's suggestion of using a new attribute
> rather than messing with the port. But would this also be more appropriate if the
> notification was only triggered when receiving the event from hardware? If not
> then do you have any suggestions for getting these kinds of events from hardware
> to userspace without going through the bridge?
> 
> 

We want to have the same behaviour (or as close as possible) between sw and hw.
Since this can cause many notifications to be sent up for current setups, maybe
make it optional so we'll get notifications for roam attempts only when we
explicitly enable them, with default off. You can look into bridge's bool options
for this (e.g. link-local fdb learning option).


Cheers,
 Nik

