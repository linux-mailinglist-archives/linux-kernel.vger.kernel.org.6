Return-Path: <linux-kernel+bounces-518365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F23DA38DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 22:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B783A141B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630523957F;
	Mon, 17 Feb 2025 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="io7/zqsM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7811A3A95
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827740; cv=none; b=DqOQ7nazXsDbK9QzALYGSS5wD/cNTcV2ySrL3+EscxX2jNTCn5l2CF2PgjoNdJH6wHvpxb2kZAlp/3kJb6+4g6E0JuQ0hpqcfpRlu3QfRQ3PBEyjT/peQMrZaI0S62i9W9tXnUEJmppRlb9B4f8onW0zSywop5I2iGtZ0aVibdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827740; c=relaxed/simple;
	bh=QtKyl08g8BnbaK9peAQyWqZuLQDnDswA9FYAXJMqPrk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hRPy4o1a17UOX/honwYLWDANe4bjLUV0zzJU9kYO4jS9O81HGHUyhsR8ijlQ48Y/b8urFukxtmD6nMmlk8wDsMNN3DeT2KFjbAGEL742y6+nhWxNw93bHsllBwYJTeVrRY+RqQXRIGLo6cCUdz0lgfwtKhZz03sR4Px6ugX4rzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=io7/zqsM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739827737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRPNL2JvEqbDKfhkAqEwBHvR/TzRoQvQNFnzm4XpF+I=;
	b=io7/zqsMCDXR6tzB4LA53B6Rl56HsgAjZGPzFyzQXnPfnJ1pIz+h9owr/ImoA/rIRr0SAz
	zsx9gR3OmntKwYDX5wEzXF7T9TKDq7QvYKFA9qT6j26ciw4w0ngerSnQB81bzXrQY4xrWm
	3fgx2/1ZlXIhBRtt4HJuBcWndVfFg1U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-lcgMVEF5MxmsJkAg2MiH5w-1; Mon, 17 Feb 2025 16:28:56 -0500
X-MC-Unique: lcgMVEF5MxmsJkAg2MiH5w-1
X-Mimecast-MFC-AGG-ID: lcgMVEF5MxmsJkAg2MiH5w_1739827736
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c09f91e480so194010885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 13:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739827736; x=1740432536;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRPNL2JvEqbDKfhkAqEwBHvR/TzRoQvQNFnzm4XpF+I=;
        b=OJB+tiVEb9Gqu1graYEytR48v7fP+GUrv3LnC46XMzhfktwxMN3nm46Vm3SD21sT/8
         71jHpYgSgq6baWRR+y98m/+i1A4jfxw8mbQD4cY+fZOKZLyTGTnn7rbYJP7751CMyjv2
         6VCdjojTvJGdTzWqq+WXcoD3acCcbnRo6ReOgvUv2KYq9++XFWPkbFrFqqQvZxxMhqBo
         jJgPtfSdy5atmtMP0okvtBR4imvjwaSqSQYTbW2xWcOYBab0IWae4pttLa3Tse1A3dos
         WFfk5z9jAbqK86Ki8lii5HDGBPwqSmMtu4dQaEkEkln1BaayQuDszUNG/R4cSsaRNGes
         PjEA==
X-Forwarded-Encrypted: i=1; AJvYcCWebWfPMk5AN9b0sxzGKBQRJIrEJG/K6laghjTSscNVXh1IG+29QfJFjp/xQ1PIAV+imSa4iNSmtcoEunA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEP1I4lj7iuL1WQCLxYsVPy8PEmTPmb4UE6mw94k3tlaImXgZV
	uDEk3VqplajTmSttTQwrWU1HcHmTS13XTLZtaaHw0VH8QW6+2daadAbIGVGwt+zKgaGNaDx35CY
	4mkd2cH2ADQyi9zIASpJZkKMynjlYb+E010p0kVKTivR0p7LENl+Agulr84SyDQ==
X-Gm-Gg: ASbGncuLWHSdU2Q04dxo9FZ10sylbtuO+d0pKZKdf+zp36EljRq0gZ1FJMsjG44P5AF
	ZqDtGNNRxzw8aqh/yzodM7tUxtNe3gUBPZxAvulo1vVA+TkGClOqn3eATW6WsfqXo4zZqE7z70N
	b1eH5dKzlyojfGsFy5EBufM74mXDlqkfmPwVLFFEKKsrEqUkuaQ0xL6eoHC3b5NlLgq4MkZNmYU
	yKqWVxpKTTSzb4Hy9Tm0I71GRnY6JpxHSd5igVq5sqs1dfMX8xalYpRCfMX6fLSjEol6eJqLgEB
	5ofrgJuQCWNjzC0aRFM6QQF4XOrFMXpRhwbHcCeDTIujDf9e
X-Received: by 2002:a05:620a:4410:b0:7c0:7fe2:876f with SMTP id af79cd13be357-7c08a890278mr1362195185a.0.1739827735903;
        Mon, 17 Feb 2025 13:28:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHi/jts7+uZJ/1+kCDGDpjV3iqqy1fQ1AX0PcIJtSBYvw+d9gZ58RWXBqgfZ4eZmxAKm/RIPw==
X-Received: by 2002:a05:620a:4410:b0:7c0:7fe2:876f with SMTP id af79cd13be357-7c08a890278mr1362193585a.0.1739827735627;
        Mon, 17 Feb 2025 13:28:55 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c5f36d2sm579580985a.14.2025.02.17.13.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 13:28:55 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3722eb57-1108-46e5-908b-66dd7ac0126b@redhat.com>
Date: Mon, 17 Feb 2025 16:28:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cgroup/cpuset: fmeter_getrate() returns 0 when
 memory_pressure disabled
To: Jin Guojie <guojie.jin@gmail.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20250217071500.1947773-1-guojie.jin@gmail.com>
Content-Language: en-US
In-Reply-To: <20250217071500.1947773-1-guojie.jin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/17/25 2:15 AM, Jin Guojie wrote:
> When running LTP's cpuset_memory_pressure program, an error can be
> reproduced by the following steps:
>
> (1) Create a cgroup, enable cpuset subsystem, set memory limit, and
> then set cpuset_memory_pressure to 1
> (2) In this cgroup, create a process to allocate a large amount of
> memory and generate pressure counts
> (3) Set cpuset_memory_pressure to 0
> (4) Check cpuset.memory_pressure: LTP thinks it should be 0, but the
> kernel returns a value of 1, so LTP determines it as FAIL
>
> In the current kernel, the variable cpuset_memory_pressure_enabled is
> not actually used。

That statement is not true. cpuset_memory_pressure_enabled is used to 
determine if __cpuset_memory_pressure_bump() should be called in 
cpuset_memory_pressure_bump().

>
> This patch modifies fmeter_getrate() to determine whether to return 0
> based on cpuset_memory_pressure_enabled.
>
> Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
> Suggested-by: Michal Koutný <mkoutny@suse.com>

What Michal suggested is the approach you used in v2, but it has problem 
as I mentioned previously.

Other than that,

Acked-by: Waiman Long <longman@redhat.com>

> Suggested-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 25c1d7b77e2f..14564e91e2b3 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -108,7 +108,7 @@ static int fmeter_getrate(struct fmeter *fmp)
>   	fmeter_update(fmp);
>   	val = fmp->val;
>   	spin_unlock(&fmp->lock);
> -	return val;
> +	return cpuset_memory_pressure_enabled ? val : 0;
>   }
>   
>   /*


