Return-Path: <linux-kernel+bounces-287865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C57AF952D63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B61ECB24F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144367DA87;
	Thu, 15 Aug 2024 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOFFhxwc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28817DA7E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720983; cv=none; b=B6I8VIY8i1NsnyKwFfYuX/yg8t0YLANsVcoSEo38Vkve7ig2g2xGYZLjPkJVZuqdriP7WuBUjp05OlwVE5tq7NJ3b4YGL9N62FrwcKKMXFRzp0KB2YWrJRwG9AvHkRRJkjpw7VhkpX6hUWVaLpLCKKO9+UzHJLF5jHDS1BLbaWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720983; c=relaxed/simple;
	bh=oHkaD3Mk1Glf1237vxBvqGVWP0H7gRbQ1W8PhzqPpoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bson0hI0k+ePn4oULxGZVoDrNxRf9cwpC12x+59Wk2s1wjdt/oMQxHnpHqliMJZrG45OadGiiMhkFU+urIcrlr5HSsQEqFY/b1oaIVYNFGSbTUP7OuwoAIVUrntP7zzL5czrlcRkSL7/TlQXeHR1YHCgl4SzvS2Jl3Y7Sr9RZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOFFhxwc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723720980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPJdIbPZUO+te2AGhX4vVGwGwmVO3a2Gs7mmB0QUjdI=;
	b=FOFFhxwcmcaECZ1L0Bfw4EwZI4wi9h1q3L2qGD3+WpAhWIQS+duQFEjeIndOfgorfYjDqI
	du6ToC7F83V6sHyWkZyu58yymq3M05NWmVgGAFJwhkWwkATdhxRlbm5KDxnDxO6eoacQ03
	DNsLEI27Ij1m001unJAl0QZTSRWjh2Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47--CW6sZfyNOmtPKecFZMJtQ-1; Thu, 15 Aug 2024 07:22:59 -0400
X-MC-Unique: -CW6sZfyNOmtPKecFZMJtQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428fb085cc3so1620165e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723720977; x=1724325777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPJdIbPZUO+te2AGhX4vVGwGwmVO3a2Gs7mmB0QUjdI=;
        b=Upm6hkYv9VcKtChIjoRo+InPtmRrXC8ksySzkkaimg7zZygxEU9OqbIajt0BlRK6Xo
         oxHmm5TYKyghXt66Gn2z++m6UasP3KIUskJfIS5sES/MdN9PdyPk4CTB5cOI96i0tGD6
         RUGnMv0Sj6mtVSbFooRkx34XCPxv3wbKcaT2O8pYKO2s/kIInH/nzlBHfBRZfIyGWriL
         SJPo47/f/v3DFA1pQzbfcArcK+0M+9rEjpCx66oqCHszIYesmwh1RMZ7jP8RQ9En8XbR
         /5MAk3gQl5GBvHf4LXELuLyl0qp4PecfgUQzOu8x/kq7D7PEaMYfJ8F2XRLXsT35k0z0
         GttQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpc7Iq7KhZYF3wegwUz1+Jx3Lcrvr24h03qxMsxc1j4DmJJmkXtMCeAaSNXT2LVjyz52qlAQz2lRl3q0BrUH+e4TWM4tCIBsjyX8EV
X-Gm-Message-State: AOJu0YxWT8wAZ1a5vmmH5jQiwKAZWg1gLzLWIqJXjS4Oz1hxPn5lgUHP
	nI1KDu9EvYJmGd0BuO32vszIuRT2uPyEPo4ExSwolt9jvursK6rNYrHIXxzM87ru40ljwcNEXh0
	J75LLlcqY2iYPLqIviqHkIkttoCXg3rLKcndcZCaWNuEqfl88X2x5DfbG//Y+Vw==
X-Received: by 2002:a05:6000:2a8:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-3718779c4c8mr994088f8f.0.1723720977469;
        Thu, 15 Aug 2024 04:22:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsio00dWucXBWDAiGRCOt/NvsJLb8l46U2SH15tjbdNJe1xD0OFM/KHZ9vwKjvoHuQxEzSRA==
X-Received: by 2002:a05:6000:2a8:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-3718779c4c8mr994077f8f.0.1723720976773;
        Thu, 15 Aug 2024 04:22:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a311sm1260410f8f.23.2024.08.15.04.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 04:22:56 -0700 (PDT)
Message-ID: <dc46f9de-641e-4b38-8661-4efd4859f49b@redhat.com>
Date: Thu, 15 Aug 2024 13:22:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: remove release/lock_sock in tcp_splice_read
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: sunyiqi <sunyiqixm@gmail.com>, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240815084330.166987-1-sunyiqixm@gmail.com>
 <66bdb158-7452-4f70-836f-bd4682c04297@redhat.com>
 <CAL+tcoAiOwWEsbkqSJ3kpwLxd8seBBUOAODeBideFdQYV7LfWg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAL+tcoAiOwWEsbkqSJ3kpwLxd8seBBUOAODeBideFdQYV7LfWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/15/24 12:55, Jason Xing wrote:
> On Thu, Aug 15, 2024 at 6:40 PM Paolo Abeni <pabeni@redhat.com> wrote:
> [...]
>>> -             release_sock(sk);
>>> -             lock_sock(sk);
>>
>> This is needed to flush the sk backlog.
>>
>> Somewhat related, I think we could replace the pair with sk_flush_backlog().
>>
> 
> Do you think we could do this like the following commit:
> 
> commit d41a69f1d390fa3f2546498103cdcd78b30676ff
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Fri Apr 29 14:16:53 2016 -0700
> 
>      tcp: make tcp_sendmsg() aware of socket backlog
> 
>      Large sendmsg()/write() hold socket lock for the duration of the call,
>      unless sk->sk_sndbuf limit is hit. This is bad because incoming packets
>      are parked into socket backlog for a long time. >
> ?

Yep. To be more accurate I was looking at commit 
93afcfd1db35882921b2521a637c78755c27b02c

In any case this should be unrelated from the supposed issue.

Cheers,

Paolo


