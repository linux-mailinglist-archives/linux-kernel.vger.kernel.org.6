Return-Path: <linux-kernel+bounces-296892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD86A95B03E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3FE285FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97616175D3D;
	Thu, 22 Aug 2024 08:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hdlez5cI"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820CD170A27
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315150; cv=none; b=rRWDA16plw6ujRsP5oxUCMPupib/n4nlKSqayHki2OptZjqs0OFPpOdBH/3m9YoAYEZmnZR7fJLij7+2KkzMn1XkcLXWNVRueaiKhmVE0bwoM02F60vfMTrP2nXujc0sFuKCn+9pCx/R13UcR5BrLLMvq6meyXWzvK0EC+MOo5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315150; c=relaxed/simple;
	bh=loryYtIRejTvQXqCiQ+6T2F0TRbLEqx6TT8pqfhBHWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMduXK222MAIfTx0dnEw4baq5t9JmXSLB91u3kf/hdjwKxAq/9aH7aVXkjLUbTBPEM4C4ZIPFCCrjvnj23q/9I51VFvN0bdxDlnw4lQvXe3YsbapeGoO8/xgNvqV87RuX3mLgRTgpTah9JDehOUYWIAKVs6n7cNRsd4SMjhx/uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hdlez5cI; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd8afc9ff3so1073303a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724315148; x=1724919948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXfLX67xydWXFofQKkNhVZ5m+kGg8DeUVnRTn9LVrTg=;
        b=Hdlez5cIdN3gHIZH6V5LDaYZCHXRqcvWfXVvVxHkXtaP9C4lEh1skxWCNitf7gB9+b
         Z9V9PWDvcNYcueuQoKDwwO8JrPcwic2PkTNmyIqWwJRXW261vYbkMQcybpaTgSW4BCys
         jab1VpTwWEOjcfb3v5GYpL8mt4Jl32vlDLLidkNRASJvWf2Q+30yqY2nKOvjKd1mBKMU
         SkZbzjevn4HyffqTWJdJ6pz9/blRGTxMexef1c7vyxYk3j1e7PUdYuVZg2REuCw90/4z
         VRC8WbmdwLKbD78YHaS2qqQDaF5lz1ldhnk/bpTVF5pT74jC1D1FA6+tSV2GncxDOKBp
         349A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315148; x=1724919948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uXfLX67xydWXFofQKkNhVZ5m+kGg8DeUVnRTn9LVrTg=;
        b=TSDBt/jGoARJ0ybOqkObcpuuTD610G0zS8yORuHUwjsNA1S3ye70QNaAw9WZcfhYBQ
         0/v3G3coWK1ujkV6pwWwJJJ13z10auRAvb2ztIF3/vjmZ4MVJ6PFUVk4hMDYAvLwTaag
         jkdIcsWUgiiZVPr+hDgs6OREseHg/zq/OYkJXRIer4swLCOrO+rqISZHLo4cfL75jnyM
         U/maXu85hIxdz/bA7j6kwF5gJFe1+FsL6ZXY4UlHc7pOsA0t1mS74IV5BA/FpWLajieR
         pbE7R5XO5UNDjbPWUgz/30ACHgJSuzoWnPpNAzRURJYgFpH7Vcj5Ow2b6YdgfeDQTQ1O
         2fSA==
X-Forwarded-Encrypted: i=1; AJvYcCV5NdJsjJ/ecqbHZ9B6vYMdsjgXW6ZHKfNlZi9hwa1PYTkkbYLQZpUvZHkSaAcADPYv/E5xqziMLVr3m2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1VTOIlYLzaHcMcAIHWsZe7D2OUiskGTQloH8nnIkJ/wpec0Pw
	24mFvwQR9Vpa2X6Srhjq0M2nKBJf6o0vFK0p7PvLnhXN3p/wiNx3Nyft09WsN1A=
X-Google-Smtp-Source: AGHT+IGavGubutSE27H+Qqx47oXi5pTvlaJldryUCjPUVdX6faZcAT7o8WBJLpBwcHa/BpiQ3qPC8Q==
X-Received: by 2002:a17:903:1cd:b0:1fd:6ca4:f987 with SMTP id d9443c01a7336-2037f9d95f0mr30636175ad.15.1724315147604;
        Thu, 22 Aug 2024 01:25:47 -0700 (PDT)
Received: from [10.68.122.106] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fc69ddsm7575335ad.293.2024.08.22.01.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 01:25:47 -0700 (PDT)
Message-ID: <3bf84d23-a561-47ae-84a4-e99488fc762b@bytedance.com>
Date: Thu, 22 Aug 2024 16:25:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] net: Don't allow to attach xdp if bond
 slave device's upper already has a program
To: Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, bigeasy@linutronix.de, lorenzo@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20240814090811.35343-1-zhoufeng.zf@bytedance.com>
 <fd30815f-cf2b-42a0-9911-4f71e4e4dd14@redhat.com>
 <Zr32ZZ8e4RhYN1xd@nanopsycho.orion>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <Zr32ZZ8e4RhYN1xd@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/8/15 20:36, Jiri Pirko 写道:
> Thu, Aug 15, 2024 at 01:18:33PM CEST, pabeni@redhat.com wrote:
>> On 8/14/24 11:08, Feng zhou wrote:
>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>
>>> Cannot attach when an upper device already has a program, This
>>> restriction is only for bond's slave devices, and should not be
>>> accidentally injured for devices like eth0 and vxlan0.
>>>
>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>> ---
>>>    net/core/dev.c | 10 ++++++----
>>>    1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index 6ea1d20676fb..e1f87662376a 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -9501,10 +9501,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>>>    	}
>>>    	/* don't allow if an upper device already has a program */
>>> -	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>>> -		if (dev_xdp_prog_count(upper) > 0) {
>>> -			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>>> -			return -EEXIST;
>>> +	if (netif_is_bond_slave(dev)) {
>>
>> I think we want to consider even team port devices.
> 
> netif_is_lag_port()
> 
> 

Will do, thanks.

>>
>> Thanks,
>>
>> Paolo
>>


