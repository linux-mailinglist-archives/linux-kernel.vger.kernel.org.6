Return-Path: <linux-kernel+bounces-367488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C1D9A02EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB0B2882FE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFCF1C32E4;
	Wed, 16 Oct 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnU20OOP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3C18B478
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064738; cv=none; b=e08ngnFXRti3tyC9VcTtqILW9LEDwyfl/f01IsIaG1DamR+CIgfNvbY/ttgthTBPoETF2Xm7rRWZzkeAzJizliTLT+5RtaPqDvpqSrYjlIWWfGVtfHINbtJrg3xhppekaVSRgxM6DxO4Hgk1toFuuR/toqwZcGM6pl9DvcNnmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064738; c=relaxed/simple;
	bh=hvpn7Zq0g7b19gkei2vMe8mTUwIxVVWTIW3821uGK8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/qLuumzjvBDnp8XTS9/Nb59WeLAsFqBI76oXuaSLMtpeqy6UEdhGsnhvT/H0av8S1VewvJb5j3qSSVeE9cpmOl3bOm1v59pUlj3Q3QZgoPUbcjB0cDH1N7eawxs2m/4EYXzeGL9zFHyCWb0EsHHajSp3iP8xHVFEnxSbbvDQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnU20OOP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729064736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZMNDygscP0ApBl6B4+OOT2D1feT61VkI6S/fm7lJGw=;
	b=MnU20OOPJFRnG82c3s1t1x1Srv8emy25akJGHUK4T7Ngl3Y7gebpH4OkoT28dzfZOLSGEn
	yygNh5xtKvAnCxSJ8M2ohTqw1k3Zk+cBihxhwaGWBehDDQ36S2RPGZ5FTtMNaIj828z+la
	zMRcY01gHhzUpz72e3hQRSocMoHg4Tg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-l7lMipOjOi6iq-NnniAiyw-1; Wed, 16 Oct 2024 03:45:34 -0400
X-MC-Unique: l7lMipOjOi6iq-NnniAiyw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43113dab986so54994455e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064733; x=1729669533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZMNDygscP0ApBl6B4+OOT2D1feT61VkI6S/fm7lJGw=;
        b=EMTL94uYp22gcsnDeTlcYHd539cr77libt4esPkvF9sDoe5rfZbbubNKBkM8XRV5J/
         gCk4C5pl8S7N83WRIWZT3aKLwD/MW7DC4eq9dSiUC5wPmALgaHfy56+Oed035GVr5lUD
         FusnKHHI9ckJ1W+YpwcsMPtYFt0aKsE/roo1UdKX+evrthk3+QrAsG2RlveWySaJIp20
         oqfL7P36M4hgyvvH/tl9henT2P+K4u+omLZrKNj1MwqB68BaSKCuyMkzbQyBnRhRrY9D
         0+C/aw0LylHacTlxHVROyyTZSLft0LyePwiRvlzfw3cT8sH34jp0h1yi3xjmRYh5muIo
         tJQA==
X-Forwarded-Encrypted: i=1; AJvYcCVr0SALM5967LA5a+e94Q0vN+KP0cdGRKKPGhe72aMqEQgRzE8Zq1W2yhZ5CXu08rgUZ/53DYhr1BiW+zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1p0FnQCnZAifZAJ5n31ty8oqGhLDEof2ZTW5/w21W4mwdXgv7
	zN1b/Nf/bG3zlwQYmMmUjd9IsbSp223oqqBRT7W3Ic9H3XIjbqEgPGhomrxX8uiVKdts4Itmdj6
	ab7aJvYgX2JVgWnIaETfahyM8kKYbXZ9mYEIe/iE/TlvTvmaZeuneitfXPRLCtg==
X-Received: by 2002:a05:600c:5023:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-431542d2d76mr4845485e9.22.1729064732931;
        Wed, 16 Oct 2024 00:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Grh0K1mhOgL5THYcEeem6rs7BDOGHqVGRx69/tRSiiZTYxkPx1ztq3HHC3X/R3P+Tvm3mw==
X-Received: by 2002:a05:600c:5023:b0:431:542d:2599 with SMTP id 5b1f17b1804b1-431542d2d76mr4845205e9.22.1729064732519;
        Wed, 16 Oct 2024 00:45:32 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4315067a6f7sm13323655e9.0.2024.10.16.00.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 00:45:31 -0700 (PDT)
Message-ID: <7dde23ec-e813-4495-a0ca-6ed0f1276aa6@redhat.com>
Date: Wed, 16 Oct 2024 09:45:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 2/3] net/udp: Add 4-tuple hash list basis
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241012012918.70888-1-lulie@linux.alibaba.com>
 <20241012012918.70888-3-lulie@linux.alibaba.com>
 <9d611cbc-3728-463d-ba8a-5732e28b8cf4@redhat.com>
 <2888bb8f-1ee4-4342-968f-82573d583709@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2888bb8f-1ee4-4342-968f-82573d583709@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/24 08:30, Philo Lu wrote:
> On 2024/10/14 18:07, Paolo Abeni wrote:
>> It would be great if you could please share some benchmark showing the
>> raw max receive PPS performances for unconnected sockets, with and
>> without this series applied, to ensure this does not cause any real
>> regression for such workloads.
>>
> 
> Tested using sockperf tp with default msgsize (14B), 3 times for w/ and
> w/o the patch set, and results show no obvious difference:
> 
> [msg/sec]  test1    test2    test3    mean
> w/o patch  514,664  519,040  527,115  520.3k
> w/  patch  516,863  526,337  527,195  523.5k (+0.6%)
> 
> Thank you for review, Paolo.

Are the value in packet per seconds, or bytes per seconds? Are you doing 
a loopback test or over the wire? The most important question is: is the 
receiver side keeping (at least) 1 CPU fully busy? Otherwise the test is 
not very relevant.

It looks like you have some setup issue, or you are using a relatively 
low end H/W: the expected packet rate for reasonable server H/W is well 
above 1M (possibly much more than that, but I can't put my hands on 
recent H/W, so I can't provide a more accurate figure).

A single socket, user-space, UDP sender is usually unable to reach such 
tput without USO, and even with USO you likely need to do an 
over-the-wire test to really be able to keep the receiver fully busy. 
AFAICS sockperf does not support USO for the sender.

You could use the udpgso_bench_tx/udpgso_bench_rx pair from the net 
selftests directory instead.

Or you could use pktgen as traffic generator.

Thanks,

Paolo


