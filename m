Return-Path: <linux-kernel+bounces-546991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27FFA5018B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8917F1894BDA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83D24BC11;
	Wed,  5 Mar 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyYfgT5s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4424BBEA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184053; cv=none; b=LloMcpsuHLATkSxhy98nEI54/1jBDJjqCfvrj5u70XXQzTaDyg1xPMbnuPxbcGQ5z2jQhERY4pwBnygQQOScH6bhHZJZDLwPfSsAsBQoaTfKZfR3zN/UgvOmUQp4dpqhoYWXFu2B0nSb/brVnTOYvBqcFpr4GtCKNsRAUn39U3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184053; c=relaxed/simple;
	bh=EDOWiuz48EaOHCMVG5zuO1N25iNFE4iKpu3KXcX0EqI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MPX1fO6lOyOxuxTajlNZ3zB4+1wSXzVsvmY8jPNUiokRc+8l6REpFqc3lBFLhWJTbGFRDBB8emLQcJWcIOz7eUFSUzdnPeY1OVYCvcWdSdMnRHOwmwutHYbvVMm0SfvzYpiPhUwfntMpWQJOSYHxmrGrcYm8ARqRqVO6Jh0psE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyYfgT5s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741184051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0W+VuZVYcnV3HyAvSTpbUUrhFmo350QWrg+wnsTs7g4=;
	b=VyYfgT5s5Ff/3weJNNL9+xC1EYeF65yVBYqtLkseis3PLKKNaAaqD8DpeQsnYN3iTECGSE
	KZ2f3kCLUlP11aezhggi2H0t139ZVPbXKJ9M43JvU+KQAQLDuLvOJMokjTliyOeTCALob0
	ZdvNe/zfT+VCpJQWRTSDRqcqunK4vp8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-gY-QlKw9OjKWezlarNRB7Q-1; Wed, 05 Mar 2025 09:13:54 -0500
X-MC-Unique: gY-QlKw9OjKWezlarNRB7Q-1
X-Mimecast-MFC-AGG-ID: gY-QlKw9OjKWezlarNRB7Q_1741184033
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c0a89afcaaso195648085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741184032; x=1741788832;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0W+VuZVYcnV3HyAvSTpbUUrhFmo350QWrg+wnsTs7g4=;
        b=aWPi5xvcrd4CJjQXty52QCGf69i5a2Qx39Cm93cmE7RMK2aM5UpNnveMnq3ay48LR3
         BIqq3U/k8TllIPmhiPK2shyhwyUkLHjSWfa63NYEHn4MXATnAJ0Dg2k1QYLqCA9lZCyS
         qsMfNLvLdLHq+mB1YZL/pcvySTMGGR39Q+V1bNM/8D0EBwDTYxrdIt8twopqVocQQvhV
         W6SN5o58dPp3QxPrujMlhjeXcbp5tKtcd5L/lXHgqpQOKdnUT61/TqIr7pcCYYtXKLzY
         bH+KIYnVc9EkYk3YeS/pBX8BT1qPsbnHNnb9AQscGL1gJui4ga1xGRL/VNmqvL8OMYy5
         tE4A==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7UlosbiC/mAmXCJlNRWMAgN+B07RKFlwFxQ9AnBiuzAh1aOhyRBmcr040ThtpIuYaKPfqdRSCUmYK0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyRyCup1kuwLuHdzIDZI/u+l+eMdCGUAEBkvZTbX6hiDafAWVl
	Bc2s93VzIyPMZbZxMBBkzzWpVDepaDHVV6DVGfZ/5XwjP864GBKdyICAWcYD/XYwxPqvgQ3DgFF
	/H36nfxnEhAIUv2IovR2X/sMZpnxgqwssy2GLbO1tVxSv2yZeFJ2rxvIPdIziBEpgVYe/Kw==
X-Gm-Gg: ASbGncvwJnpqdM3GAXf87oLalzEiA9lmcWXmOY+Ex5XJvKktxNwAl8dhLdhZzgm/F5l
	VbPBUNBxuPUFZJRobTLsxjircoQoV84N7eCufpAk77TM1S4l7a9hbll7wxkJgE/sLFsmAKNRQyq
	06uolP8IFEq8MNcPXOOxANLpnFqo2FLNGmCZ0/dJ9Q2gfUQCJxkWhfVGWF4VtekMdLbmP0ZojJz
	V8HzWP5Q8R92TAJOXZOhObJ+Ow88iB/zv+0G4kwYumzftemtX3rsH9jTPLOa8Y5lGduLQnDwPPy
	OJKEsVe7f5jXSPXRqxKsHmZYXv5KdBgp2pAeFp4+AtsJ04NUzpSqY3gsULw=
X-Received: by 2002:a05:620a:43aa:b0:7c0:a260:ec1b with SMTP id af79cd13be357-7c3d91e8cafmr444390285a.25.1741184032533;
        Wed, 05 Mar 2025 06:13:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9ffpu0YZWhyUhYlZlVs8VrgC/jNuyM8WRbs000jc8OeU6/te1fV87F/+guN7+iQlwfItbJg==
X-Received: by 2002:a05:620a:43aa:b0:7c0:a260:ec1b with SMTP id af79cd13be357-7c3d91e8cafmr444386885a.25.1741184032217;
        Wed, 05 Mar 2025 06:13:52 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3bfb2a5e3sm392543585a.41.2025.03.05.06.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 06:13:51 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6a6d4c61-a318-444f-b089-1776beb8873d@redhat.com>
Date: Wed, 5 Mar 2025 09:13:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup, docs: Be explicit about independence of
 RT_GROUP_SCHED and non-cpu controllers
To: shashank.mahadasyam@sony.com, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-1-7b6a6f5ff43d@sony.com>
Content-Language: en-US
In-Reply-To: <20250305-rt-and-cpu-controller-doc-v1-1-7b6a6f5ff43d@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 11:12 PM, Shashank Balaji via B4 Relay wrote:
> From: Shashank Balaji <shashank.mahadasyam@sony.com>
>
> The cgroup v2 cpu controller has a limitation that if
> CONFIG_RT_GROUP_SCHED is enabled, the cpu controller can be enabled only
> if all the realtime processes are in the root cgroup. The other
> controllers have no such restriction. They can be used for the resource
> control of realtime processes irrespective of whether
> CONFIG_RT_GROUP_SCHED is enabled or not.
>
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index cb1b4e759b7e267c24d7f4f69564c16fb29c4d89..f293a13b42ed69e7c6bf5e974cb86e228411af4e 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1076,15 +1076,20 @@ cpufreq governor about the minimum desired frequency which should always be
>   provided by a CPU, as well as the maximum desired frequency, which should not
>   be exceeded by a CPU.
>   
> -WARNING: cgroup2 doesn't yet support control of realtime processes. For
> -a kernel built with the CONFIG_RT_GROUP_SCHED option enabled for group
> -scheduling of realtime processes, the cpu controller can only be enabled
> -when all RT processes are in the root cgroup.  This limitation does
> -not apply if CONFIG_RT_GROUP_SCHED is disabled.  Be aware that system
> -management software may already have placed RT processes into nonroot
> -cgroups during the system boot process, and these processes may need
> -to be moved to the root cgroup before the cpu controller can be enabled
> -with a CONFIG_RT_GROUP_SCHED enabled kernel.
> +WARNING: cgroup2 cpu controller doesn't yet fully support the control of
> +realtime processes. For a kernel built with the CONFIG_RT_GROUP_SCHED option
> +enabled for group scheduling of realtime processes, the cpu controller can only
> +be enabled when all RT processes are in the root cgroup. Be aware that system
> +management software may already have placed RT processes into non-root cgroups
> +during the system boot process, and these processes may need to be moved to the
> +root cgroup before the cpu controller can be enabled with a
> +CONFIG_RT_GROUP_SCHED enabled kernel.
> +
> +With CONFIG_RT_GROUP_SCHED disabled, this limitation does not apply and some of
> +the interface files either affect realtime processes or account for them. See
> +the following section for details. Only the cpu controller is affected by
> +CONFIG_RT_GROUP_SCHED. Other controllers can be used for the resource control of
> +realtime processes irrespective of CONFIG_RT_GROUP_SCHED.
>   
>   
>   CPU Interface Files

LGTM

Acked-by: Waiman Long <longman@redhat.com>


