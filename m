Return-Path: <linux-kernel+bounces-556374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A1A5C51B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D32E179835
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1B9249F9;
	Tue, 11 Mar 2025 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5zYq44x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C28632E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705764; cv=none; b=OW6ji+Z0DZL04dz5ytyYFINLHkDEKgDSAOYg4f3Fg3d6LpWNwyU9rRyYFU52hOUZ01GcQbbUd+FqsvsbnzMQb2yspsD/+ENjpDJUHMpDD32mtEMIadbmH8DaHT+Sbv3jXG7VfiseaUbMeGLZlw99KeweWG1O8jNunBmRY09CoWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705764; c=relaxed/simple;
	bh=vb9WVjdXujyqG9HdkP9fDFqYDOXfh1MwdGvNDloJU5k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c+VvZzmwBfEuzkYD2Kv94wscsSijh2tehlWSJ1h38oDE3UMnjCu5mPnnqatx7A5Ju/TihJzX4MKsPXgKwodNzv9zAQaKoeXxbm2Fn++hre1EAzogw1ky8KhtooG6Fb0/LAYHp17U5MKNvO+Ix68TAkCmmRrp1uXtFYb3NQz6a2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5zYq44x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741705761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jm5p6f/MWK5U7DpW+NpwXR9aqI/JKbBrooREb2Q78R8=;
	b=P5zYq44xbxy2cVT2aVemQ9QqXgIUuNU/gM6CV1+uoZLkOzU1atJMX27aOCWVkwYVJd0zKw
	gNHWfD3hVe7i0TFFdZVKjLxtOB1OS9xpUkJDb54RFxCBhbvby2wU8OhTDqmu7HSKPK6LuA
	mbGnF7d4B49q05ORECEMB5t5N2Pa3pQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-87KPsg12MzmGfCvNoAXC2g-1; Tue, 11 Mar 2025 11:09:20 -0400
X-MC-Unique: 87KPsg12MzmGfCvNoAXC2g-1
X-Mimecast-MFC-AGG-ID: 87KPsg12MzmGfCvNoAXC2g_1741705759
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c54005ee2dso595285085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705759; x=1742310559;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm5p6f/MWK5U7DpW+NpwXR9aqI/JKbBrooREb2Q78R8=;
        b=SZwks365qTSE5Gv6HPyXxJn0y2yqUgM/tDHIU9Ri5pZOq8i5fgq/PCXIwJo9gNFMYH
         LahYQfUUngkA6EKCDXyYybwQWjDIPHJH3S2xq1lptBSA9yA0mPOl2f/S41VA1l5haxNT
         yWFEl8kBfuP6izwpZgSKs4+fHSs7PB7Y/cIdibVVTulJFjMSLEa9cHKtadpmbsZxyHI5
         2LAb2/InBniF8Kx1FLIo+7rm9CBjFNxAVld2pVdptz+z76Yxy3I95oTfqKC/9LA+x+C7
         2PtuwTg30W+16GRfi1Bi8yoxv3sDRHGqXqUwxzu+I/sRGePKT2licIkRZOxtxB6ER2+f
         U1yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD0FcR7rQH40KEs9mxMHyx2paMqyqdf/jPLBp5XOKY6CZ5lWgcTDfYypeoZNljXPCOBVmfOtG5IhV/aZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwexWCamFgPwDSkNjI5VFL4VYiHTw0bUhXPhgcdK7Yj/rAdbPRk
	R15Y62p9r4Jv0qZGb6oTn6spl4tJ8TF7OXfwC0eaJPNu/9o753pT6oJx22VLEcs/YOZSVdXe08G
	t6qBMNd0gFvOr8FQrOdjAp/kzMHLGYu8U3eH7CCsTTCgPRaVpLJxP96S/o18IqA==
X-Gm-Gg: ASbGncs0fwZmhu8022m2JfhkafuMKUvQLAa0dSMSpmbv0Ko8yvot6LdFeFKqS9tlcqZ
	59Q3YYmThlCJUlQziW+uf/OCRZH+HYx5TTeV5YeMxrhrcpzun7/+VeJ4rW+ks5mIwgZmDoyIibN
	alvlSByD37vU/YYGyDPZLssHhGeaQWnbSxqgxVDwqFkry0iaXdnB+58VaYF9lrq0FyPA9JVSe3V
	bRn3FLmCNO+vGvCVIH1Te8/tzO1648jjPuUUxKCYEqBrC6enb3M5FZwT+kl/gK/qTVw5B18irxw
	njdpFou1r9gfhrLwBLbuU2ohD6YQBgN2qeSkveGeL0EhiAK5bWLdBCFHPaHSDw==
X-Received: by 2002:a05:620a:2856:b0:7c5:65fb:fe0e with SMTP id af79cd13be357-7c565fbfffcmr271088585a.6.1741705759555;
        Tue, 11 Mar 2025 08:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgw7eoIv2Vhl38GQs/MzX9nIqjX6y3ka9V536jOtKWJtrjsXcbVnJyTgSX7O+tWt6UW0RICQ==
X-Received: by 2002:a05:620a:2856:b0:7c5:65fb:fe0e with SMTP id af79cd13be357-7c565fbfffcmr271085485a.6.1741705759324;
        Tue, 11 Mar 2025 08:09:19 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c553a1e421sm349610085a.116.2025.03.11.08.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:09:18 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c4570dbe-77de-40e2-8fce-b672e014ac57@redhat.com>
Date: Tue, 11 Mar 2025 11:09:18 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] cgroup/cpuset-v1: Add deprecation messages to
 memory_migrate
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
 <20250311123640.530377-7-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-7-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/11/25 8:36 AM, Michal Koutný wrote:
> Memory migration (between cgroups) was given up in v2 due to performance
> reasons of its implementation. Migration between NUMA nodes within one
> memcg may still make sense to modify affinity at runtime though.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index b243bdd952d78..7c37fabcf0ba8 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -436,6 +436,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
>   		break;
>   	case FILE_MEMORY_MIGRATE:
> +		pr_info_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
>   		break;
>   	case FILE_MEMORY_PRESSURE_ENABLED:
Acked-by: Waiman Long <longman@redhat.com>


