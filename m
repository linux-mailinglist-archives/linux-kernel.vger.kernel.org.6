Return-Path: <linux-kernel+bounces-568960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE90A69CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF0388730C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED5522259E;
	Wed, 19 Mar 2025 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPmk9Qwg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F04215073
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427047; cv=none; b=Xp8nqln8m07w5Xxg65bx/nlx0vNu7+6aF6ubwY9jtogwXfRlW9Plkk3FnbhQRIxTw304KkUkJBtozXBtAbl3mlsy9nYBOTizc6D95I6Hpag2aYm7JJKTEKC1fo5/PuOZuhfUgVfJEVL9p1B6oOYlmf/a/B8KG1Egk8s1tLxYIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427047; c=relaxed/simple;
	bh=899czMqiE4bNmGcMXC7wRnQxngCGLJj3jqjxDUjUn58=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gT8Xdajl8YnpakHzbjCSIWXOH6UdSXi7M6FUbIgEj+VtcNNS9P0JiM4qVP1yOT1xFJZfWaVUEq31rF5f1g5ENZxGJlDGDQPBli/xnLz5qcPnz1jU9WU+BizGqbk49kFp2rUqoaXry1QWSqXaODCk5RvPOWeRL2rkMxXYKi/YWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPmk9Qwg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742427043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AdS7FLVx5vWQEjep5ijpHift5baLZ1L+Dub51QJXBpg=;
	b=QPmk9Qwgr3GJFYrCdTQKFQe2Ft4epgehy6vzIkpvGUOXYLnUrIVYdfY4YnfMcvrtJSWEuk
	tvod8udy8EheEDBUNyGQsTiTmXtAAExmmw1Kp+0/F226sb0nJQG+lvRYqsDOW/3KIcnNk6
	W7qh+NDj/t6PWLq7Xah69IIkGD3pk7s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-z6o4bOSsMEOAN3XN792pkw-1; Wed, 19 Mar 2025 19:30:39 -0400
X-MC-Unique: z6o4bOSsMEOAN3XN792pkw-1
X-Mimecast-MFC-AGG-ID: z6o4bOSsMEOAN3XN792pkw_1742427036
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso311178a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742427036; x=1743031836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdS7FLVx5vWQEjep5ijpHift5baLZ1L+Dub51QJXBpg=;
        b=pSGhakd6gQsYHQeVPPMxjCWiDjgLV2pAWWQojavcAwc4fkSRkZNnGvoKCt783b50QA
         ssilJwliTgbRgEpHv8UcOZnEr6pJGGq/+RXwLSd2DiAaWgzYMDdiRGQPo8bLc2fP9H60
         iIdjuyPPRHsT8F47iSKpK3aGFp4XJMcCIiklJV9/GcKPg2ehLTUix8eRoe9x7dPhczPL
         6GxgngcGEVFhXzz0QPXcC7UgL7iGMf9jOrBD46tzUY5uWtTyHS4t5dOzEHRbHBfaKd5A
         V3UNa6lLC0aSFN9/oCi7X8ElC0AXiJ7KPy28liBpMRrG2t25kqsqi8MDg6djcGz2pmjj
         fNyw==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZwB4iDCQvkLGIXN38CSj4X1hSLAvZG0kjwg0W9tD7hw853itw5/AX1kGKB674PVrUb1GeRD/MQV8HSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwarIiEPL4PmmcX7ydCB1kfkUlRymh+I0thqn+5ZUsbztS3TLA
	GsbDVd7rpn6u20+WS8DXP0UX2Twt9YqQlHK9mtqJrpZEOV9TtZbS/xyXQmQ0GStD3CLkolpEG9I
	04NMdcqh2qQ2efku0SEAQSKT5CCpm08zJxLnV5csP6/D7EcMPlwxaKdeGLRimCxj1aLxkMw==
X-Gm-Gg: ASbGncttmWxXKH7yHvF8Gwvqv5U5RRskTDH8KZ9Q3dZssvA4GcFiQDtfJ+gxGoiJust
	MzDLq72avdiayC7BwqUFLhK+T9QV8wbJk1DS2CTjdHJ/YOTSP8FBGxZtLwCZbNe0f8a09u4pHz4
	SRlKHGOP/7adeRX0431P/7egfzAcC58zTUuDd/Fkjrb3vOghE4Ov37hO3jOZxA0NaJ0mSJs7Oa6
	AikpL8kXNf5t6fQrUpC658RrKPAM4JBl9hTdFBm9QjbE9m8VqeF23Xg5KT0xI44XNAVTNL/yl46
	BlqBOSrcNOPJ/46eyw==
X-Received: by 2002:a17:90b:3805:b0:2ee:b875:6d30 with SMTP id 98e67ed59e1d1-301d50b4d42mr1546781a91.9.1742427035821;
        Wed, 19 Mar 2025 16:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfGpU5/Zo7T40O8hlX1URy075Hogo7VH/jVO2K2J+g+NugytWfq459WPEgAQ6GAnakfdnuvQ==
X-Received: by 2002:a17:90b:3805:b0:2ee:b875:6d30 with SMTP id 98e67ed59e1d1-301d50b4d42mr1546755a91.9.1742427035497;
        Wed, 19 Mar 2025 16:30:35 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf5b809bsm2548637a91.36.2025.03.19.16.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 16:30:34 -0700 (PDT)
Message-ID: <c69921bb-79a0-4644-a19d-9693d1dd638e@redhat.com>
Date: Thu, 20 Mar 2025 09:30:30 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: psci: Fix refcount leak in psci_dt_init
To: Miaoqian Lin <linmq006@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Will Deacon <will@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250318151712.28763-1-linmq006@gmail.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250318151712.28763-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/25 1:17 AM, Miaoqian Lin wrote:
> Fix a reference counter leak in psci_dt_init() where of_node_put(np) was
> missing after of_find_matching_node_and_match() when np is unavailable.
> 
> Fixes: bff60792f994 ("arm64: psci: factor invocation code to drivers")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/firmware/psci/psci.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

With the fix tag corrected to the one, suggested by Mark.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index a1ebbe9b73b1..38ca190d4a22 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -804,8 +804,10 @@ int __init psci_dt_init(void)
>   
>   	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
>   
> -	if (!np || !of_device_is_available(np))
> +	if (!np || !of_device_is_available(np)) {
> +		of_node_put(np);
>   		return -ENODEV;
> +	}
>   
>   	init_fn = (psci_initcall_t)matched_np->data;
>   	ret = init_fn(np);


