Return-Path: <linux-kernel+bounces-556377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AC6A5C524
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB9D7AA212
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB49025E81D;
	Tue, 11 Mar 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYuE9seg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61041C3BEB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705847; cv=none; b=dWltTleiD5dy2d0RzAr9pxDKNloTsDMGthDgNyjN9T65mPN1pznCd825rj8q9KAQD4ltdNAtHeDGLRjsxtqw/6v1wuLViEAjEgo5/OupyDKBiJhbwZXdhw+Vxk7Os4LjQ12Csx3xbxE3VFk7dzN4j78opI5ONrcJpB7jW5lvmLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705847; c=relaxed/simple;
	bh=lc3UTP0ZxyZIpkj9wcJGmsEjDsGWkzn+ParWIOHIXDE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BrcQ8ny4FAC1KDEW5f16hH0rWxOWkbPLX3HdAb3FCsgDsHDDgKIQNnqpZ7BNko7fOpoV48FJbXx/GI8EgZkMPFvRBoSnnmnCip1wy2uBcJCQiewYiuGwatDNpm2a9kKrL141aOwP+ZVOBkpixKniCj3JaTQw+sh4DvuRbXOOmYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iYuE9seg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741705844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CNFxfNmAhYZ31S10OCFBpFK643stUwCJOknX62r8PZs=;
	b=iYuE9seg+LE8Xv+XmkY8UTytUd713HW4xG6Cjw+//nMli3EbPB5mZl8obDoIG8SvvrTPF4
	SMzkgbT38JUbvi8oys4jtWhps+2cfp1Dm0KAm5nVwd6O+rosfv8+qN21WuYw3EWUBJbqZG
	ad6pBK8sjammt4ON2rKNcwFKdSjP6NM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-XVFLqHnRPaKOA8b18-OM3g-1; Tue, 11 Mar 2025 11:10:43 -0400
X-MC-Unique: XVFLqHnRPaKOA8b18-OM3g-1
X-Mimecast-MFC-AGG-ID: XVFLqHnRPaKOA8b18-OM3g_1741705842
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8feffbe08so127406956d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705841; x=1742310641;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNFxfNmAhYZ31S10OCFBpFK643stUwCJOknX62r8PZs=;
        b=u6qJZLTFnZIx5Wg5pDdA6YwCwtTUVe4kxXa4XjrIQ57pmluZ4GIhBkWPfdEK5M7cWe
         3w41GnrQv6QqY0nWT86cu7yvfmdBiYcKdKQlHRKE7JbWlc0e0IUcA1K5P0cMvfT9lIo1
         6tyY3nBpV+hYsarQFPEQN/hTdH9aZ4FQitKKf200KLdkCtlsVIEzAoRouF2JinUCOYBe
         uiiHSuw/nx1rxpIRwY1NeIQbpxL6nJPaQHkEPJwRff1vVrBljIM9B4wO2y4xSz3tgd8A
         WEZl0usjxGP+82vuOjgHCsxp+viDRlLJQCyU9YIPJ0dK4A1NFXAirARop5u2OuGqWnM9
         AotQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVuJbGKZDGG2Ol7jkXzfyW8I4km8iOg+J3GtpYWklWgb0d3T8WK26/5HlbQrAwn4wkmiAUxPngi3AuSAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8L4LIrpFkNFUxyavwl9caEQV+91PueaA6feLNhhnrbi9CzSIa
	iogYb1GuFDuTFE2Ud/D/442pVjvH1N5fvqxfHIYUUY8baAgqriN74gEwXOQPl4NCRCswTIMvsRk
	9YgvJ2U5obgOtKZfBk6xCg2twsGOA8ucHH0WrSFTZQJrK767lVYWpMMRNM7DtYQ==
X-Gm-Gg: ASbGnctMmgYkyRfRtEb2S5796MQyc3Shja4FOYX9+y3vrT0BxgRqgoUVtsc4MgDzBqr
	iPtxjHWzavaCJhyxRms2x2JuToCtryGQeG1t7of9pqq1L0bitCIBUihMlWRxIJH7qzCQlbX8b6A
	vVPCkLSuhMxrZNwXxcXNdLAovdMB2osCilDe60ZSaVmMr7vj2gH0ub5Ge8WgnYp3iFIun/4Qb9z
	4biNP3OzdLnCYDaIDZc6u71dvvaAvxqW0aKZQFGq1P0HEOljzNXhL5MEffbmvabhyARxQBfrQKr
	fiIRYZHwX33h7OlJJ94RAudjrMIXECd9AjDjMe/rUbqOEDlJVD+qiiQ0Lv+QbA==
X-Received: by 2002:ad4:5f85:0:b0:6e8:9394:cbbe with SMTP id 6a1803df08f44-6e90060978amr285486706d6.20.1741705841767;
        Tue, 11 Mar 2025 08:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENeUdJzLEPf5ux+cN6yT+ztM3rNavCrbq+PEZK5l2/3KSyFaBY3i/mWphwZI9wuuSn6zC4KA==
X-Received: by 2002:ad4:5f85:0:b0:6e8:9394:cbbe with SMTP id 6a1803df08f44-6e90060978amr285486166d6.20.1741705841402;
        Tue, 11 Mar 2025 08:10:41 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a44adsm73179216d6.64.2025.03.11.08.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:10:40 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5b572a4b-a68b-4766-abb3-fb1e964c59b3@redhat.com>
Date: Tue, 11 Mar 2025 11:10:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] RFC cgroup/cpuset-v1: Add deprecation messages
 to sched_relax_domain_level
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
 <20250311123640.530377-8-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-8-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/11/25 8:36 AM, Michal Koutný wrote:
> This is not a properly hierarchical resource, it might be better
> implemented based on a sched_attr.
>
> Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 7c37fabcf0ba8..5516df307d520 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -175,6 +175,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
>   
>   	switch (type) {
>   	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
> +		pr_info_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = update_relax_domain_level(cs, val);
>   		break;
>   	default:
Acked-by: Waiman Long <longman@redhat.com>


