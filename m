Return-Path: <linux-kernel+bounces-267330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DC8941047
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35B41C22288
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC9C19CD11;
	Tue, 30 Jul 2024 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZcH3B/o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7418C336
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338166; cv=none; b=UzD0iiecUByMUX3bVYyNjARsqVQ1T99DZqDfWUh5G7dAC2GKzcGMR/6RBnR4AgBYBMKil00Qg/AlitOGgUz8Ekso6M+GVyvUoYYkFxn7m4cSpiIa2uwc1WbzbFfyQaYYrG0WihT9okGJxcddXm3xn4xDA5nwKTZIxXJ0oFhPxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338166; c=relaxed/simple;
	bh=MkxxPoMjfqhKLEyhH9Ijtf5OOpkETT+mNZGQ1OMwT5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alRjy3DEK0xIKuGBoNIDu3gUodKoE+o+l/GXZAcd2WxNboFHnjry+q8I5bhtyDbwXg8LBzANZWVJrSHk4rEYhDBFX0BwLsdBCBcMxk6Ud/D7qXUY3Vj7Evzwqvg/Zru/mlGRd1wG/LAydaWUvVDo9eGWSLI0INBAsrWvy+FScPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZcH3B/o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722338163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8KNEiCYvsNZvR+mh47WuXJq8B09DBw27xXJxl1VGVw=;
	b=eZcH3B/omASV/Fin6kUZoygKKOOwtsVjAitPv0oJh1UnIXEdnVORm/VJXtHOvzZzEIk4cP
	AVyQWvqGnkz7pZmuUNgcI3HrZy8oOiT8KemyqQGbYydwfnGmtaJzNhcaEkarJTuiJrlhu2
	xoSeQGHsrBNOZ7lJxLzAv+BUq3s/F64=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-WJrqH7NSO8SnjNwtA3Kn1w-1; Tue, 30 Jul 2024 07:16:01 -0400
X-MC-Unique: WJrqH7NSO8SnjNwtA3Kn1w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428086c2187so2231315e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722338160; x=1722942960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8KNEiCYvsNZvR+mh47WuXJq8B09DBw27xXJxl1VGVw=;
        b=B/iEyo1zgChj2r9E7iyEZr66mlHtkufalyU9iR0qbRmNyZjvGIHqNPcl7IdRGQieST
         Mu3vVf2KcjoPIjBv47XYZTLC/2WDi8A2L/ZQq6Xg3JPgTAq/mS1NVFBMQZQIwnPDoozl
         /L9nrc15Nl4zdQitOMu7/vU6HX8od+QV4sjO0VxAwpo53Yyd+Ygv/2w9rRUB+z9zwGcW
         UFXpniEn9ui8u2C/rXlI8XQQrBE47mojctwr6Yo/QdL9I2p/wu2HA4kueJxsjS6KU+iG
         8Ac/noJuc6WUHWgqGS8ONI8msKHfMt/GtPqItRHad6/RdkvjuXidDrCe7WHz0JwfsJq0
         aaxw==
X-Forwarded-Encrypted: i=1; AJvYcCWSUTNQCX8u2QMoJN7Pg1vswfhyPBN3nuHInIJt9sM0N0RwBlbBKjLB1It3QbTz0g8ZZNDKD0Xqq/tHd3KjoTBmbd5iJPxtT8X/EbeS
X-Gm-Message-State: AOJu0YwZVjU0Dn5rq9LRS3nCXgt7TKryZWBLMquPdkKH1AOzkFjjTC0O
	NJAHUkrIxEGjd2rYR1laWKiYvVlAcUgVIrmol0I9uRZIzr/455oa9X8Vm5gHOs2nk/ODJVKADBb
	25uDu8pL8lai6U0HQJykOztSGLtKZNef6f335PS4sPliOQxtxQHICId5vFtc5kw==
X-Received: by 2002:a05:600c:3b87:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-428053c9c55mr78959185e9.0.1722338159922;
        Tue, 30 Jul 2024 04:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtjZKmPWqOiG4vceYlHCqZ3pT8uosuEp3MCMM5HkDafP6+ItBTSahc3mBM6jYALW5QNpx/Ow==
X-Received: by 2002:a05:600c:3b87:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-428053c9c55mr78959055e9.0.1722338159396;
        Tue, 30 Jul 2024 04:15:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280d13570bsm155672765e9.7.2024.07.30.04.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 04:15:58 -0700 (PDT)
Message-ID: <c61c4921-0ddc-42cf-881d-4302ff599053@redhat.com>
Date: Tue, 30 Jul 2024 13:15:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref when
 debugging
To: Florian Westphal <fw@strlen.de>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, leit@meta.com, Chris Mason <clm@fb.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240729104741.370327-1-leitao@debian.org>
 <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
 <20240730105012.GA1809@breakpoint.cc>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240730105012.GA1809@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/24 12:50, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>>>    	else if (likely(!refcount_dec_and_test(&skb->users)))
>>>    		return false;
>>
>> I think one assumption behind CONFIG_DEBUG_NET is that enabling such config
>> should not have any measurable impact on performances.
> 
> If thats the case why does it exist at all?
> 
> I was under impression that entire reason for CONFIG_DEBUG_NET was
> to enable more checks for fuzzers and the like, i.e. NOT for production
> kernels.

I feel like I already had this discussion and I forgot the outcome, if 
so I'm sorry. To me the "but is safe to select." part in the knob 
description means this could be enabled in production, and AFAICS the 
CONFIG_DEBUG_NET-enabled code so far respects that assumption.

Thanks,

Paolo


