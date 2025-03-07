Return-Path: <linux-kernel+bounces-551372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110AA56B9C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DADA3A9FA7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDEF220698;
	Fri,  7 Mar 2025 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSHq4WkL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8D21D596
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360494; cv=none; b=n0BEsLp6Sg/PDqcAtL9Hpafy5T+LPOIY72HoytEiS6gSrSTiueXU7m+Cdg8LQ6KB4cRFDQmlbeOKkENNAuFIdCder816fFRt0ENCg3vE57UlCS1x2eYonHUzl0g3kjIwBJZaw2ku6tl4Y8khQ2RnBUXNKLn7e6QXR4dGa/1bsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360494; c=relaxed/simple;
	bh=fA41Y+uCuWDGDV6cfmusKKYNoYIcYlCPGSFe9l+arqg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=th5IMKHTAGZNmBSYgclj6TmU4uBzeINtE0b8xhqnFiyahAZ5NnpKV87i7KZ5YyTZG0qX+zJV130bE5n54pNDGVjt4Ew+n8YZj4ec5d1UifIfCPUGfcj3XyUhj4w895GVFHWXG2yQohNJY9co2RyLaqsKnyWElKwL9wvTllp0B+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSHq4WkL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9vCaAjA10n4eQuZKup3eqGeapTr8OclBkkEU+k0x70I=;
	b=BSHq4WkL7JRI3T61rpRW2yT2zGH6BVvz4sI4AqTw4Gp3VBRDRRLhf2iP7ISmFl98EyJj3j
	c8c6+e+8pKmKSVVrbGUYkR8blnCQEF94a5wbzasWiTXrKvn6LH2VxqyVtzI3wZ2yQ8A+0G
	UfcehB56oFyvqfcXV3ad8B/JOl1NHtM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-jYnHVU-hPwCMu6XXvt6rXg-1; Fri, 07 Mar 2025 10:14:50 -0500
X-MC-Unique: jYnHVU-hPwCMu6XXvt6rXg-1
X-Mimecast-MFC-AGG-ID: jYnHVU-hPwCMu6XXvt6rXg_1741360490
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c3b8b95029so301969785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360490; x=1741965290;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vCaAjA10n4eQuZKup3eqGeapTr8OclBkkEU+k0x70I=;
        b=rf7VcTfohQ4K4fjy9KE9Br8sk39WuwIXUN6HkviapqCgd1ED4DIkJVjboiXlwLiSLb
         J377V8b/KwOg6G167Pp38mzBqgJ+QxRubF43ryDXIc0Ljktr9xibwQemCAq6F/XR3Q9+
         RrmDrR2NxcWh8cq0RdeuG22wAYgV5/+qr2HdVYcneSsiuhJJymhmgo38qE1y26NnS2tp
         9ttAT2FPzeXz6ukkb4+KV9/3lBarSlP1QZay5VWk+7HZgmk8swO4sZ4xaLENwJoTu2HJ
         yc+xY+sdBfD7UfeHysSFddtZYEAYSP3QSrM5rWyiF3adsNZ7Sm64BqoXN3BNtf3ubbNY
         u2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmvWx7JixQXNp/VVJP0ww0FIH9Wxc3zPNIEP+N+nNwJD2Fua+CEvnyga6KIrpkQjdj3sMgpErrfz96Jew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMf5wMrPV+wZLspUH+vtC59QscjAubkX94G0um7yUcuP9uAp5i
	+ZXsKWVVox2V+C5oAfISMfO6ZE7IFYcS64ACph8JjTJiMi/xZInfpjl09Cvj96/JqkthzwnlQZv
	N5972xKRXkpM4iGiiyActNhdUF4A2B8/ygbPPCNEzGNqxgBXUvVXmayBcIDcEhJLg1EhWqA==
X-Gm-Gg: ASbGncvNjxZcYl7UzTFsQe+9+HfyNLjpRt8bQHSKXmjqHEZ8He5o7t+FwBnf3yjK3Oe
	CQc1CTbIqlBz8EmH4oKVBCbabOWHLwTlvoiaCGPh9AQvQpoKFIYYDA8YYKi17xaGBuD2M1vF9FD
	OeqNM9ynwyMJhtF/E71T58G8NpD0bVuFqa0zwjDLc/Ue389JI87Qcc4ucpjZehjpN6Oiri7Rl5u
	zzLrdr8ZmYvP0gRBd+lgvTuOQ4hJxiY06ppUucJnDZ1FltUmGOZb22JpOoV93JZkOOweQhPjlca
	sGpFflYVz21ZiuMiUPmrVA8L7EU+42Kwl68tUFuHfBzagFlGytqUFiP1A/g=
X-Received: by 2002:a05:620a:2612:b0:7c3:c8f6:59bd with SMTP id af79cd13be357-7c4e619e966mr650347585a.54.1741360489761;
        Fri, 07 Mar 2025 07:14:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8Io38CiHNusxosf4AFVfsbGHbOHIccVZXZl4TgpD2GU8x8/XQ3qPW8XavtCzqZIKHkX/I4w==
X-Received: by 2002:a05:620a:2612:b0:7c3:c8f6:59bd with SMTP id af79cd13be357-7c4e619e966mr650342585a.54.1741360489485;
        Fri, 07 Mar 2025 07:14:49 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e553e418sm251280485a.117.2025.03.07.07.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:14:48 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4bc436b2-1667-42a6-9afe-1c51e5b3d131@redhat.com>
Date: Fri, 7 Mar 2025 10:14:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] cgroup/cpuset: Remove
 partition_and_rebuild_sched_domains
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>, Waiman Long <llong@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-7-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20250306141016.268313-7-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/6/25 9:10 AM, Juri Lelli wrote:
> partition_and_rebuild_sched_domains() and partition_sched_domains() are
> now equivalent.
>
> Remove the former as a nice clean up.
>
> Suggested-by: Waiman Long <llong@redhat.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f66b2aefdc04..7995cd58a01b 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -993,15 +993,6 @@ void dl_rebuild_rd_accounting(void)
>   	rcu_read_unlock();
>   }
>   
> -static void
> -partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> -				    struct sched_domain_attr *dattr_new)
> -{
> -	sched_domains_mutex_lock();
> -	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> -	sched_domains_mutex_unlock();
> -}
> -
>   /*
>    * Rebuild scheduler domains.
>    *
> @@ -1063,7 +1054,7 @@ void rebuild_sched_domains_locked(void)
>   	ndoms = generate_sched_domains(&doms, &attr);
>   
>   	/* Have scheduler rebuild the domains */
> -	partition_and_rebuild_sched_domains(ndoms, doms, attr);
> +	partition_sched_domains(ndoms, doms, attr);
>   }
>   #else /* !CONFIG_SMP */
>   void rebuild_sched_domains_locked(void)
Reviewed-by: Waiman Long <llong@redhat.com>


