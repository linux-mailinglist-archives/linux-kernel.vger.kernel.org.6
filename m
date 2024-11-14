Return-Path: <linux-kernel+bounces-409200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ADB9C88F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC74EB2ED38
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9B1F8EE1;
	Thu, 14 Nov 2024 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O26GHGAT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACE1FA267
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582979; cv=none; b=ZKeLieEkzStRhdGNBMMJpoGQQGDenA2UFAfinwBe+F9mT3+EKc1ZPyJUGyArwPo0KltcSnRuHd10V7WX0Dqx4i0fSUb0hs3tywO3BIrKJSHIRV9DHRVwM5A6GM0ehCnuA8mlGur2DJt0QcTphAs7ZyMstgBzjMrcEmtRyCPfGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582979; c=relaxed/simple;
	bh=gk2l5sQFFKnhaG1D4gYES9olyQ8lhf5lWKrvLozEITQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLO8+zZN8etRYOK3CkB+Hqt1fCHBJndCv+DtYSJtxNqs2uZTsmCUKx2bZZw9aSsd7sRK4D5pHQSOhfCFlIJ7n7xBa2f17JZ+bdTCrruabcH4+wZMDxb4E4vbIeWeyFNT4wv1dI9teCcs4ZTAp7iOVGNGMleGluQngEc6tSFtYLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O26GHGAT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731582977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLq3a7+mKSraWJiNtbJpeO3G7vZEMjGcLidVBCyH6BE=;
	b=O26GHGATTEq2BbqyGFs2Rz9+A6jMq5nUx5l2nDF3cwLi2Xuqo8MOVDpBFXb5IozGwQn/DA
	Moc4p0a83QPhZD1frM9+OP0kD/myLJQ4RtpFyXyD+nAD9nUZ2H6LCq+78SV8QIidrBfr0K
	zfmf2JyGtkiJgF6OQAm7ENEFpzyaIXg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-XZEd1dV8N4efVuG8QzrbYQ-1; Thu, 14 Nov 2024 06:16:15 -0500
X-MC-Unique: XZEd1dV8N4efVuG8QzrbYQ-1
X-Mimecast-MFC-AGG-ID: XZEd1dV8N4efVuG8QzrbYQ
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3e6587f103bso392542b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582975; x=1732187775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLq3a7+mKSraWJiNtbJpeO3G7vZEMjGcLidVBCyH6BE=;
        b=Gx00s1t9/2+gvpRGu+vt3X9zgm7677Vbe+oZiOBOq/Jx2+8YBFI2ZSwHt4hzICQ9Wx
         Wt8c99XNQivF5upWns+QcTinoDbocxG8MGATGY1t2vcAcs4OdL2J08JKKNotVfHKrqEz
         +hR5y8NLhpMGyA9QSlnwhvpHPUyygOfOluzpZtN1kgCUEW751xqyVESSnyV1yXR13Vme
         0iqyQfm5vauXA2kusOBxWKIqS2EJTsYzHDRxEqJuSBdrynf2IpqRHkrYtR0EyQbciQAR
         gVteMFf24/EQk3YXEADzvIyYAorw+wqi91JdZNONzW/Xaja3flxX05iuQc2dstykW1H8
         yGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlQMWp4omUcMi13P0pSzyRyWL3JrbBhLB/axiTUVV2dUf2fBvFJE0LCXlGc6TNLm6dpYOzpjMd2sF1wlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/E/Gw1zie/Vj+1k+e3RA1YfPYz5Ugfv392U+MDsVQLZLwFljd
	A5uosXaC6kDHomHtEZMXFLW6G9t9soNuytf1gBRTYhaLFR8RjhyolVGUVUBMQHpouEp7lZG/d4c
	ou0RNgXUTeDpXYoXIjJkxrSBL5F3L8NV3VaEAu5cVBiM5KUluaRp+Gur75eNfmA==
X-Received: by 2002:a05:6808:1910:b0:3e6:3777:76a7 with SMTP id 5614622812f47-3e7b7b7c5acmr1841165b6e.23.1731582974987;
        Thu, 14 Nov 2024 03:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4pAxUMKrHi9s3UrZnkGK2XpTHT3Y6BDqRKhAS2gb8zkg4dLyu8qzcBRI0Gp9UnRDRh8BwGg==
X-Received: by 2002:a05:6808:1910:b0:3e6:3777:76a7 with SMTP id 5614622812f47-3e7b7b7c5acmr1841151b6e.23.1731582974700;
        Thu, 14 Nov 2024 03:16:14 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee7ce954sm4244376d6.60.2024.11.14.03.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 03:16:13 -0800 (PST)
Message-ID: <93a2d882-022f-47fd-a17c-e4d45b182cea@redhat.com>
Date: Thu, 14 Nov 2024 12:16:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ipv4/proc: Avoid usage for seq_printf() when reading
 /proc/net/snmp
To: David Wang <00107082@163.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241111045623.10229-1-00107082@163.com>
 <406c545e-8c00-406a-98f0-0e545c427b25@redhat.com>
 <5db8d6bc.9fe1.1932a2f5ce9.Coremail.00107082@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5db8d6bc.9fe1.1932a2f5ce9.Coremail.00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 11:19, David Wang wrote:
> At 2024-11-14 17:30:34, "Paolo Abeni" <pabeni@redhat.com> wrote:
>> On 11/11/24 05:56, David Wang wrote:
>>> seq_printf() is costy, when reading /proc/net/snmp, profiling indicates
>>> seq_printf() takes more than 50% samples of snmp_seq_show():
>>> 	snmp_seq_show(97.751% 158722/162373)
>>> 	    snmp_seq_show_tcp_udp.isra.0(40.017% 63515/158722)
>>> 		seq_printf(83.451% 53004/63515)
>>> 		seq_write(1.170% 743/63515)
>>> 		_find_next_bit(0.727% 462/63515)
>>> 		...
>>> 	    seq_printf(24.762% 39303/158722)
>>> 	    snmp_seq_show_ipstats.isra.0(21.487% 34104/158722)
>>> 		seq_printf(85.788% 29257/34104)
>>> 		_find_next_bit(0.331% 113/34104)
>>> 		seq_write(0.235% 80/34104)
>>> 		...
>>> 	    icmpmsg_put(7.235% 11483/158722)
>>> 		seq_printf(41.714% 4790/11483)
>>> 		seq_write(2.630% 302/11483)
>>> 		...
>>> Time for a million rounds of stress reading /proc/net/snmp:
>>> 	real	0m24.323s
>>> 	user	0m0.293s
>>> 	sys	0m23.679s
>>> On average, reading /proc/net/snmp takes 0.023ms.
>>> With this patch, extra costs of seq_printf() is avoided, and a million
>>> rounds of reading /proc/net/snmp now takes only ~15.853s:
>>> 	real	0m16.386s
>>> 	user	0m0.280s
>>> 	sys	0m15.853s
>>> On average, one read takes 0.015ms, a ~40% improvement.
>>>
>>> Signed-off-by: David Wang <00107082@163.com>
>>
>> If the user space is really concerned with snmp access performances, I
>> think such information should be exposed via netlink.
>>
>> Still the goal of the optimization looks doubtful. The total number of
>> mibs domain is constant and limited (differently from the network
>> devices number that in specific setup can grow a lot). Stats polling
>> should be a low frequency operation. Why you need to optimize it?
> 
> Well, one thing I think worth mention, optimize /proc entries can help
> increase sample frequency, hence more accurate rate analysis,
>  for monitoring tools with a fixed/limited cpu quota.
> 
> And for /proc/net/*, the optimization would be amplified when considering network namespaces.

I guess scaling better with many namespace could be useful.

Please try to implement this interface over netlink.

Thanks,

Paolo


