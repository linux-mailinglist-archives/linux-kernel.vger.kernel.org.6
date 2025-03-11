Return-Path: <linux-kernel+bounces-556618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2613CA5CC6F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B124178CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCB9262800;
	Tue, 11 Mar 2025 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaFp8NMZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520341D5ADC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714979; cv=none; b=GuEvjJYYAKPNtrXuZhN3HlP4GFr7xfM/XBBuD6YpzeHTuJA533GGE3eYdJZSBFWudKraCVqKKQO1OxhNqEZyTJwNlRllx0XS1Zv0C5/svko8Dwfkd1WnEumLvkCXugo4QfF0KvIwhw6t/Ns9vNZiufAnKw4vTIlAvzRVgKF52fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714979; c=relaxed/simple;
	bh=U0wYOy8nIyoUWWRkX9zLBV6ZqaC3SJYdujCzKBYiThY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NuToE5JCnIjFANWMDh5OSVTsPamEIDu3DXwT8hrZW26RvWENXHODHQl36XRohypDPOADw/eaNPFfdxNFAFA6dxZ7Io7xhiO14lJs2HhM9cMD3M2CfTNVDPjnqZlYcnORdFa+pfe0HXQHUgVDH6StC7ZHyrh2Hz+ITBVR1vmHtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaFp8NMZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741714977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjJN5Ua84fREKDPZZYib+AuzoDJ3MB1bjMV251DsdaI=;
	b=SaFp8NMZQ6vUwx3ThiBqkRfXjdh78Mt2j+YYYRS5NGKVAHtEuRoWWwCMeAeChoXaiwNA+e
	jVQ7VfPNRgKrloo1qoII7EZDwu5X0fEq1IqtcIPz6p6XKnwBieSfXNBr1QWBU1Uv2ky4Gr
	Mc5HPG2P1hN2QS9+cQ2BHEMcvM7RPXQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-vhg5zR4WNt20dn5ECKI2cg-1; Tue, 11 Mar 2025 13:42:55 -0400
X-MC-Unique: vhg5zR4WNt20dn5ECKI2cg-1
X-Mimecast-MFC-AGG-ID: vhg5zR4WNt20dn5ECKI2cg_1741714975
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3c5e92d41so1075861585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714975; x=1742319775;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjJN5Ua84fREKDPZZYib+AuzoDJ3MB1bjMV251DsdaI=;
        b=figQuBmpXTHLoxL91iz4g1KcgweYJG9Cd6PkrFwMwfWXU6GoQ2MCxC7paoXNeZrKqW
         O7b7yFzBhiXYx1Q0Wl/+oppXQ+CcCZAHgb7hR0EDXog081MQQBV2tUc7pGTduzXPc2yJ
         jb6dQ2EdvxR8BB4Sa77LkrZHlox9jXUeseODgL2ARhYj8KzXmfI4AwlYGBa7UpFcOiiE
         KlhSvTvdsZVOc1E3AdJBWadJEDG8szbcO5CySd95F4tF+fswcC8g5OdvLYP8iHuCjJC/
         VlGsv6HTdTSg5CDLnSyJNgEai13rNOggpnypIAFF9dw5fEz9jYFtv0ThVx92QEAAHR5J
         4FPg==
X-Gm-Message-State: AOJu0Yw7YcTqpxSe5OWSE1EJVRu1XV8KPoZJBHFmbCxTMLJsgDzBXyLm
	Db2HEXzlcsWH+zBLP62dB7ct8m/N/w6pF5QDk0NxURJMNDG8m4znKlGD8X2mi8MGM1nEY2TjI71
	5d2jOvSGEPjiFf0k0j8XdLVRMR84rhwSv85HwfGjfGYZ+Tz67x/u/A/tseByl9g==
X-Gm-Gg: ASbGncu4QpG0KJN7Cc/8+djwYGyQF9PXr2FQOw5ZQdqvsOEbhkedCnuqY4tOMZbvBpT
	yCzabnqO8/wTkP+N1pQWiJ5106whqCjAnZQvqTBREkrLc4cqDdWlt4RHiBH5R88qTdeWXEkorcK
	Ff4trWQlRynfAar3RGQGQ7h8JWcldIiBgsRs8JWKJT0t88axLNbUuJdmU8F8G3RxDAuzgWGi/3q
	5Eojy0coSpVmekVebAws7JYeXpVEOqj0UEpJ6K5aZUxQ8h92I64VtoPvuddv29jpgOGmvrRA3XX
	CfQ2tU4OXPO0wqTBzA9ydq7jeXQkvzw+9vB1yTcBWClsJ1MErUBIG3SMdZKgwQ==
X-Received: by 2002:a05:620a:6a04:b0:7c5:4dc4:ae33 with SMTP id af79cd13be357-7c55e96c1d2mr650571185a.55.1741714975332;
        Tue, 11 Mar 2025 10:42:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIe7vrZJHTSV4Bk89jXHOrZpa1Y2CWkaGfBEgZf6DIZP5HbI799cFbIcNOvIM9HGc5h5GmyQ==
X-Received: by 2002:a05:620a:6a04:b0:7c5:4dc4:ae33 with SMTP id af79cd13be357-7c55e96c1d2mr650568685a.55.1741714975043;
        Tue, 11 Mar 2025 10:42:55 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c55e15e86csm187003085a.48.2025.03.11.10.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:42:54 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <825fb8bc-91ca-4de4-9c8d-44590b6c1cba@redhat.com>
Date: Tue, 11 Mar 2025 13:42:53 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/numa: skip VMA scanning on memory pinned to one
 NUMA node via cpuset.mems
To: Libo Chen <libo.chen@oracle.com>, peterz@infradead.org,
 mgorman@techsingularity.net
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tj@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com
References: <20250311160447.2813222-1-libo.chen@oracle.com>
Content-Language: en-US
In-Reply-To: <20250311160447.2813222-1-libo.chen@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 12:04 PM, Libo Chen wrote:
> When the memory of the current task is pinned to one NUMA node by cgroup,
> there is no point in continuing the rest of VMA scanning and hinting page
> faults as they will just be overhead. With this change, there will be no
> more unnecessary PTE updates or page faults in this scenario.
>
> Signed-off-by: Libo Chen <libo.chen@oracle.com>
> ---
>   kernel/sched/fair.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c798d27952431..ec4749a7be33a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3315,6 +3315,13 @@ static void task_numa_work(struct callback_head *work)
>   	if (p->flags & PF_EXITING)
>   		return;
>   
> +	/*
> +	 * Memory is pinned to only one NUMA node via cpuset.mems, naturally
> +	 * no page can be migrated.
> +	 */
> +	if (nodes_weight(cpuset_current_mems_allowed) == 1)
> +		return;
> +
>   	if (!mm->numa_next_scan) {
>   		mm->numa_next_scan = now +
>   			msecs_to_jiffies(sysctl_numa_balancing_scan_delay);

Do you have any performance improvement data that can be included in the 
commit log?

Cheers,
Longman


