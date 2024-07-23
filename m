Return-Path: <linux-kernel+bounces-259900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71601939F55
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187991F230AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9261F14F11C;
	Tue, 23 Jul 2024 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rjvanq9E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960F14D456
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721732739; cv=none; b=j+abWLcslaJTDQ+5X2ubcFcVC0h/Rn7UxktTidFPcznwoT2YvUg6tHs0sDNXV0wIugwWCFpn4FE1VrRJ5AhhyMDG2QRyF+T4qpivFRIfuUt9fjcEfkpnXFZ9ozBmxJoBhXG2BO5OYjqK2s+GeENNHwDj3WDOR4Emr8dkmju21YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721732739; c=relaxed/simple;
	bh=7XXeSul7UB9LBGW7UFEWmEvnnhBGYXJidgRwX+irI1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqvF28ttyC56urTDRGDgyyurfdoBnFhdrey37usisky4PbPed8gNREpeLzLOnGy5aI1Pvc3KjydS8RtcX0FErSasOfiE21YRldJOU7o3oFuPWsc/jkW0aREQmjR6A/8Ijv49HDmrPUl8d/F5ljjkAIs4ySCClZv6pOLibvXIHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rjvanq9E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721732737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3j4jPgv6Hs0fzu6rXE2M7orTiihZ3jZ0T7426KJgLA=;
	b=Rjvanq9EvszONB8ofF9OXh4j9hyob7/i6tfVK4Dixd6rKiNbvvkra2fgOBLvF/HG4gv02w
	gy9UXQxArMcIs6wamwx3iyO5VupjMeRinqo5d0l7SdhklvVXUkC9QN/czxYN+nBVJHuA8L
	C9GZFNX3tG0rs46qOCZL54+6opVnamM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-P_KuDDnPM4i4wDkLOgiIAw-1; Tue, 23 Jul 2024 07:05:35 -0400
X-MC-Unique: P_KuDDnPM4i4wDkLOgiIAw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-427d4b0d412so2557425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721732734; x=1722337534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3j4jPgv6Hs0fzu6rXE2M7orTiihZ3jZ0T7426KJgLA=;
        b=hzYXFDy2jnX96nz5AXRigbnImB2WsWMVdtGcd0T4xWRdjWar32gc4WN5yRw7oZCrCU
         COKuYg1kiOT0D2taZQlwPwH3tTwIpcEuY19LFcd+2j08Nv8eIym7tvj+JnLKCzCP3ZeA
         5zoR1/VuzottdabZm56dWxhgARqfqTelJDSNrt7RSvkSZl8E5XZFpOcgtiR9C5tZNKKU
         YObv3AnILgYK9+EQq/Bo43PbV5qw67CmWDbmG7Zlq+2GjCCRtci0EZAkGw8sDt1Kph9M
         gmnm3JFqoOKEY5VvmmSJckAwTEHuuFiM8iehq2ePvKx9gLIl5XE+FcX8T7OE7knt8MZz
         aozg==
X-Gm-Message-State: AOJu0YxCUUcijdAKqfbYn2bZdTrB1aD1vUeZZXpzqvts6ViRHGio2b31
	/vlqJ+sLIyWfP6KvAK548422T/P47ECd2VSuIj9QUFkIhF2i9hFa5il+n1KNA28OxKGC2dZ9/Sd
	DMSTEKjCkywCxStAxLkDsMEM1RW73n/Bk00Z38Po5ztTIAvOtMaS5MRwvSQRDcg==
X-Received: by 2002:a05:600c:3c97:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-427da9ad357mr45399635e9.0.1721732734661;
        Tue, 23 Jul 2024 04:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtWCl8LDKZyp3574p+r9uVIoAK1epDaa1iQUNezXTrhZGqQRyRF8Ml82x3u3sW7wHj6udkMg==
X-Received: by 2002:a05:600c:3c97:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-427da9ad357mr45399415e9.0.1721732734229;
        Tue, 23 Jul 2024 04:05:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a6fd5fsm194076715e9.22.2024.07.23.04.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 04:05:33 -0700 (PDT)
Message-ID: <0f2ef152-0fbf-492f-a334-89bb700721a2@redhat.com>
Date: Tue, 23 Jul 2024 13:05:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wangxun: use net_prefetch to simplify logic
To: Simon Horman <horms@kernel.org>, Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Duanqiang Wen <duanqiangwen@net-swift.com>
References: <20240722190815.402355-1-jdamato@fastly.com>
 <20240723072618.GA6652@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240723072618.GA6652@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/24 09:26, Simon Horman wrote:
> On Mon, Jul 22, 2024 at 07:08:13PM +0000, Joe Damato wrote:
>> Use net_prefetch to remove #ifdef and simplify prefetch logic. This
>> follows the pattern introduced in a previous commit f468f21b7af0 ("net:
>> Take common prefetch code structure into a function"), which replaced
>> the same logic in all existing drivers at that time.
>>
>> Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
>> Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> Hi Joe,
> 
> I would lean more towards this being a clean-up than a fix
> (for net-next when it reopens, without a Fixes tag).

Same feeling here, please repost for net-next after the merge window.

Thanks!

Paolo


