Return-Path: <linux-kernel+bounces-437071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4759E8EBF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60D31881E9E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA44E216393;
	Mon,  9 Dec 2024 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNVdNQdw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F7F216385
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736535; cv=none; b=BFpVoeL1Th/0VYnNG/Znq+BRfCsBphygsCkslw4Kp4Ka+ahy7P1SOwDwCGMXYuzuIqzKykYIg+0b2gt12yBz0dUMm5TJ/w66HUk9vucyIvidpgnHEnWNrAibM7BAA7FxENMf2DR3NQX9Fh2Z6Y0Uvq/bXqWumJx6/32bNOk3gSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736535; c=relaxed/simple;
	bh=q+wWR4WZqjyVxsaFM9qESjvqJd2asc/Gxv5V9Snkrp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qV3xWlljOinH/URGjYzYKOD3etjtHi1PFYYQz6C5ZNt57KCJk20d58V7HpQd2LFDip0rob+rkCE+a7VzsSP+hzp1jgfZcWMB96fTEZ4B2+LWS/Z0fDfJs4SffgzM23dWs/fIgazU6VU096HRC0O/saT2QGWtmDd5o2ExsOiZtpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNVdNQdw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733736533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vaT5gfn9YCCT9mCI3bznuvrNlpNkcLS0WsNfgHsX4Pk=;
	b=YNVdNQdwbTje77YN4y00HY509toKrHXdDX+Xqi0HRInnLBttunc/BgoCY9lOaxnZYRlKt2
	vkfcYi21t7Jq5SLIoxuBKZZ6g5047d/t7hqvHtBGXxliyyeiQRTMgYFjoKz8ppZzoEucdC
	ZLaOC7+lC7LDr0xun5ItjBRDOKvD5IQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-RMm2G5IONzmTvUg0rhvbnQ-1; Mon, 09 Dec 2024 04:28:51 -0500
X-MC-Unique: RMm2G5IONzmTvUg0rhvbnQ-1
X-Mimecast-MFC-AGG-ID: RMm2G5IONzmTvUg0rhvbnQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434f5b7b4a2so7635025e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:28:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733736530; x=1734341330;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vaT5gfn9YCCT9mCI3bznuvrNlpNkcLS0WsNfgHsX4Pk=;
        b=PUQFDuDzfV60IhSAIEKAClq4TIy63GPRv4muHWmdjMynd7QPJK5+Oip8MIQ+46X7iQ
         x7hCKcilxySwdfyRLcYscKfYTgMDuKqMpvfBsQbdB8i9dd0U2u1DoMXbMBQMDWyPyF4S
         em1wj8TwuARwymdLywnR7BzQIZnA01TI4dG7qsnnIy2T9Np4nciRCcZu8Zs33MVd7E0n
         w+8sAAGog+lERJm/aPXKq6Y6V/ZTCUAfYexdqhJdqE2bKr4BB92BSvMxeZOxiyN/Qdx6
         WEB8vYc2rtzdM6P7s8vMNSw5w8xuD9MQYtosNOw0f5nU1IvitESO2E+9uXr9xAtE0KoB
         idXA==
X-Forwarded-Encrypted: i=1; AJvYcCWKHF8gRQXwi2D1ce3qi/aO8s/7yWYP9AlSkhzJgFIhPCd4XzBis0tZrbcj6eT09S0Wa2ToUx6HsxdQKss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQNG7zgt3JOIS1MbSMmpTXeOrYf+Oc2KLvop+mf5iV5kQXhLqz
	LvSsANL5kZnR0q90Iw5N2fPUe47OOclLoY+AZvX1aqxDoNa9c9mDaWeiPUGJaj82gjfmjiySTCB
	OX/6onCRMmhG5dhifAC+RuWhxfhY5cGy5RUv9sg9qZEfaQF15u+1zq4JL9Y3AQQ==
X-Gm-Gg: ASbGncvIEd8cj0xM/3JsTk0Iw+JMVdPqlLXrKZ6kK7I9Ra1zEcndx/iwxO/0Pg0m1gR
	rbGcNySBtI1oXbQKcKTLquVZDhhOPK59292nYjHPlH24GX7rmLcCQwldYt2qKbwodj6sl30BNvo
	H8Mkwok/QedbNjzCxLDk60oXiVCnzP1oak5v4yUnbwEPuomwNX0q4nKRb7KLiQz/dHDGgvEURRJ
	QJ31nnp2geiW23/Jp9wVdgIe0EhPinx5uZeSznTad2tg4vxW47hBoSiyGausiA8dRg61i9OKppY
	2KjEgyyP
X-Received: by 2002:a05:600c:1390:b0:434:a19a:5965 with SMTP id 5b1f17b1804b1-434ddead1e1mr88697195e9.6.1733736530258;
        Mon, 09 Dec 2024 01:28:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFD1idEe66RvlQG9GY1g6Kt+9z20m7fh5dm+73gp9BfqFQT588RalzoV5BD9Vzj0/JiZPot/w==
X-Received: by 2002:a05:600c:1390:b0:434:a19a:5965 with SMTP id 5b1f17b1804b1-434ddead1e1mr88696805e9.6.1733736529449;
        Mon, 09 Dec 2024 01:28:49 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da119abbsm152569765e9.43.2024.12.09.01.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 01:28:48 -0800 (PST)
Message-ID: <94d0dcbe-2001-4a9c-a767-b337b688b616@redhat.com>
Date: Mon, 9 Dec 2024 10:28:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove an avoidable load of page refcount in
 page_ref_add_unless
To: Mateusz Guzik <mjguzik@gmail.com>, yuzhao@google.com
Cc: akpm@linux-foundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241207082931.1707465-1-mjguzik@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241207082931.1707465-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.12.24 09:29, Mateusz Guzik wrote:
> Explicitly pre-checking the count adds nothing as atomic_add_unless
> starts with doing the same thing. iow no functional changes.

I recall that we added that check because with the hugetlb vmemmap 
optimization, some of the tail pages we don't ever expect to be modified 
  (because they are fake-duplicated) might be mapped R/O.

If the arch implementation of atomic_add_unless() would trigger an 
unconditional write fault, we'd be in trouble. That would likely only be 
the case if the arch provides a dedicate instruction.

atomic_add_unless()->raw_atomic_add_unless()

Nobody currently defines arch_atomic_add_unless().

raw_atomic_fetch_add_unless()->arch_atomic_fetch_add_unless() is defined 
on some architectures.

I scanned some of the inline-asm, and I think most of them perform a 
check first.


So this currently looks good to me, but we'll rely on the fact that 
atomic_add_unless() will never trigger a write fault if the values 
match. Which makes me wonder if we should document that behavior of 
atomic_add_unless().

-- 
Cheers,

David / dhildenb


