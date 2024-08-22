Return-Path: <linux-kernel+bounces-297068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF8295B296
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF88B24463
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574B17E01D;
	Thu, 22 Aug 2024 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idDRPCRy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F621CF8B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321125; cv=none; b=WyKUfTpwJLNbyTj09F+KiTM7lMFOzuT0XYkcOqnFJBaVamTjj7yuY+dFct/ZJxikKv8+qsqOAPOD1VHeusv/qN9jBE3SWTg0aPT/BvUecay7SojHrakHw8OmjfscCkCwNzywqwi3XmAqIwOYCbCZiqV0tifWoJqpNN112JSmhlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321125; c=relaxed/simple;
	bh=qAUbTDOzk0zhiqxb6tWLJqxN1kgzvrXx4lodHtPt7WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxTIWS6zFtUtKiEJTxQTmn0xEdX08RoDmg97+NEgIo9YIhNM7zrui6pQlvKSZSeXk7Xsw/QHYURfGuyGyuxOde5DlIx1e/ZKhgjYqasWdWgWIw4Wp3WZJsvIvNntFXGk8g0EpWyquB1r24OAIbyq9C3guAIdlTbHbDP3aHXF7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idDRPCRy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724321122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MmsvyI30nD2zCrXLKRcTPe+eQYAntSELOFpP0acs7lU=;
	b=idDRPCRy6EUHF3wyIurVYWXLHotiD9iVT5BEXCVE4SHf5TLO7gAPOSj249EgKxNcdGPyku
	1KubgIDf9TwCJ+Zv8mDpE3r1C6YdQqt/1u9YU7cDOjwlPAANsX7zB0w5RnIlxwDkRcFS8J
	j0L7OCvgCFGIw8WG38Pz3kVZtZOeli4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-oLM8cyxFPU6MD71gtgq2-Q-1; Thu, 22 Aug 2024 06:05:21 -0400
X-MC-Unique: oLM8cyxFPU6MD71gtgq2-Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280d8e685eso4992255e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724321120; x=1724925920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmsvyI30nD2zCrXLKRcTPe+eQYAntSELOFpP0acs7lU=;
        b=JSexFBkadvD4EVqDQBpTMzKcVfuiapBj4PUfy4msXZp4Y0BIb23RWAFJ2laQVRURwV
         q94GaRVk4H0+ejwcXSF8pDppTk6aFC6oceQEpEO7OrM6ZKTylSgtyz97ZKZaT5tC/06A
         5ZZIKpgn6C04XDzekEQfO+StPkBpi/f3x+oMolb75VQU3npqw2b8xhOaEytKmmwxU4K7
         jmPK7NZs0OdxOMjQ+6vaHt0hWaPXqlFkC7O1uZ9QSK7M/qtsaTuqNDZUMnCLLe+eW0uq
         b6bTqhgvwkb+FxnQ2yRCHQ8bwOXq2FDNm1PtwLXV8vZrjyd7vFv5+o/p/LmQHxH4DSlr
         M2gg==
X-Forwarded-Encrypted: i=1; AJvYcCXa/is6KBA8k9uhTFP3xtUB1rJt6p+/vuOQyOt8IGvA7MiHYxrUcy9RlLIiHIR8AjcZxYTWOy0gydc8fYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6TjOGfUMDG9CXUGjBsFwQW5ltgLHYu8Yyfcr/pQ5fMzwG45+W
	gThtlwLM3uUvY+1Cz3Sb52jLHrLEJn4/HQegZ/EE1rGFZ3BRhr3TCfO2RLtieTPa5lTu/ziE0tS
	1q4lF0QhE1TUooF2VCWyVrhdA+OJNxqecRWC4IqvXX5z1gsiop9WTc83RddpY8w==
X-Received: by 2002:a05:600c:4755:b0:428:d83:eb6b with SMTP id 5b1f17b1804b1-42abf05917fmr35122995e9.15.1724321119901;
        Thu, 22 Aug 2024 03:05:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQwgmm9FuBsRBptjyF/Blm1gjCVTKlIsWCF4aU18+UfJb/reUv4GyHZYUqE7kfqsR+XjYeYw==
X-Received: by 2002:a05:600c:4755:b0:428:d83:eb6b with SMTP id 5b1f17b1804b1-42abf05917fmr35122815e9.15.1724321119435;
        Thu, 22 Aug 2024 03:05:19 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5? ([2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8d1d9sm56753095e9.22.2024.08.22.03.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 03:05:19 -0700 (PDT)
Message-ID: <0540a49d-40e2-45a7-a068-fd14b75584f0@redhat.com>
Date: Thu, 22 Aug 2024 12:05:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fix csum calculation for encapsulated packets
To: =?UTF-8?B?5rKI5a6J55CqKOWHm+eOpSk=?= <amy.saq@antgroup.com>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240819111745.129190-1-amy.saq@antgroup.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240819111745.129190-1-amy.saq@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/19/24 13:17, 沈安琪(凛玥) wrote:
> This commit fixes the issue that when a packet is encapsulated, such as
> sending through a UDP tunnel, the outer TCP/UDP checksum is not
> correctly recalculated if (1) checksum has been offloaded to hardware
> and (2) encapsulated packet has been NAT-ed again, which causes the
> packet being dropped due to the invalid outer checksum.
> 
> Previously, when an encapsulated packet met some NAT rules and its
> src/dst ip and/or src/dst port has been modified,
> inet_proto_csum_replace4 will be invoked to recalculated the outer
> checksum. However, if the packet is under the following condition: (1)
> checksum offloaded to hardware and (2) NAT rule has changed the src/dst
> port, its outer checksum will not be recalculated, since (1)
> skb->ip_summed is set to CHECKSUM_PARTIAL due to csum offload and (2)
> pseudohdr is set to false since port number is not part of pseudo
> header. 

I don't see where nat is calling inet_proto_csum_replace4() with 
pseudohdr == false: please include more detailed description of the 
relevant setup (ideally a self-test) or at least a backtrace leading to 
the issue.

> This leads to the outer TCP/UDP checksum invalid since it does
> not change along with the port number change.
> 
> In this commit, another condition has been added to recalculate outer
> checksum: if (1) the packet is encapsulated, (2) checksum has been
> offloaded, (3) the encapsulated packet has been NAT-ed to change port
> number and (4) outer checksum is needed, the outer checksum for
> encapsulated packet will be recalculated to make sure it is valid.

Please add a suitable fix tag.

> Signed-off-by: Anqi Shen <amy.saq@antgroup.com>
> ---
>   net/core/utils.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/utils.c b/net/core/utils.c
> index c994e95172ac..d9de60e9b347 100644
> --- a/net/core/utils.c
> +++ b/net/core/utils.c
> @@ -435,6 +435,8 @@ void inet_proto_csum_replace4(__sum16 *sum, struct sk_buff *skb,
>   		*sum = ~csum_fold(csum_add(csum_sub(csum_unfold(*sum),
>   						    (__force __wsum)from),
>   					   (__force __wsum)to));
> +	else if (skb->encapsulation && !!(*sum))
> +		csum_replace4(sum, from, to);

This looks incorrect for a csum partial value, and AFAICS the nat caller 
has already checked for !!(*sum).

Thanks,

Paolo


