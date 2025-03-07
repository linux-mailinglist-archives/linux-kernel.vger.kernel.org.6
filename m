Return-Path: <linux-kernel+bounces-551377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EA5A56BD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6DC7ABA5C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2D9221D8B;
	Fri,  7 Mar 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOErcNBD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3021CC49
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360575; cv=none; b=AkJBEhk/4CUcaWI+Z+952nZ6l32bJWxdsNMLrE5wg/gnBwt2VXdYxP1JN8Q1WAbbiZo9bW7omc6CtGru3xfNqC3X8GifwSxLr9qkaz3Vuwiy0cSUuDwpd1ihgxIqQYUXYZLJeTVbz5Nj0RfhJyswQyIqgK5rYyym5VKdU5zTpNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360575; c=relaxed/simple;
	bh=KlNfDr+cGyfO/N8Vp7xlIWFUUZyQjc+9mUFizVFZ3Bw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b86RqTIPjCsSWQjIIbvxVaoXDGvfoXvxpMxL4P3IMXkE/pMsoOqXMcHhrkogeaTjE1vJALcGw2ZsCu8slSwLeh47D+JeTahydWP9nEsS13k8vSxIh9oVgjQbLxQjRfEmiC2sQRir0yv529WHT1MrNDcWW74z2LhakfJGvJ+7iuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOErcNBD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hvg56giKQi3Vw+cc9vr8B4QffnxQgjZaVaW3ou0m+jQ=;
	b=IOErcNBDHGT18kAQsBnSdvVOf4oFWFtAzORdMTmM7jQL6h6fGJ0DdV6S1AHQ+kTf7iHnnY
	kFI//R5oIcATYsGlZfMjSvmYeIi1F2kxgjwg7Y8DLeX6CEL1rcaLCKSaLmuP0ii5kDdMCV
	tXCeN4K2wpya9rIxE6zcD1WS3bbudWc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-FCAoAM4aMf6R06OEbu1Xyw-1; Fri, 07 Mar 2025 10:16:11 -0500
X-MC-Unique: FCAoAM4aMf6R06OEbu1Xyw-1
X-Mimecast-MFC-AGG-ID: FCAoAM4aMf6R06OEbu1Xyw_1741360571
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e6bb677312so37200996d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360570; x=1741965370;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hvg56giKQi3Vw+cc9vr8B4QffnxQgjZaVaW3ou0m+jQ=;
        b=EWxj25+bspe4EHcoWtXp8eHwQVlhBtQLwSqTidN3L0qDM5U5gOdCaJbhwmn6cc31vt
         vOefnZX5neu90YHxOiIwNQLvsDLWytxMvt6v6lZWjlzo8CYJcR8xo09Yatl5J43Hjrbg
         OVg+TtppDbA/fbTy6JA5TaNY79V0LPhkMxxlnyg8JayBhFg3q7vX1HLPxPFhPRQ8hnlq
         OsWgAzFCL6UDhljzowxc3DY8jLfvIeFVvIw9ot7yk0hQD7EKP+pIknU+u5vgQ3O2WmAw
         JMdhuPKQ2913nVK9c+XykLCPQ1R+u9IyCbWebXtjzzV9G9NlFdfadF4k11AZYcmO2YT5
         vGiw==
X-Forwarded-Encrypted: i=1; AJvYcCVzZpNibWLUAfYITwPkXdLtfmY0gn74KZLqklSqD9Dfzy/g/vgwwkkS2NVUvzHN/SPtDCd+Jd36e7k/aM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwJhK/ia3qm65vjU5n2OjQL2JkNNJyM1V2jmoTY7fPbUscsEF
	eDj5ml6IrbenBKlSqUQ8ypLqWetS/adYnPoc5aF7+TvBRM4OlTXCGlkqoDUSPm8kWA9ysw2vTaK
	nU0CoRwt35VjGIaPprbfqqBoi6UzQyqFWiuf4CBwjAadRZchwPCLrV9Yqk5/oipkFwYLjxg==
X-Gm-Gg: ASbGnctwwbJeVcaAmTkh2cGw7JjHINYl3DFwQewcNXFmXKFn8EprOzGJBZmiCNu7o6a
	0ti5BpeMsBOIPISMSnDG6UNt4uZMWAbKFRMqn+nunJlSdo79elI1bIY8PAN5vSuZ94ilzE1SXLL
	d6Icr3nYzPvWR0XE7tmzyDOp0TiMjRb1OE7cxFbalengZoQBm89vt5N474ke3tl8IILIE8yT0h9
	nioRF6p87iNiDYqMOVAO56wgx85u+aToDyREJPO3/GtydDjHj0SAvxGenPio0F9BC52wBIwhrmV
	oYUqIl6jJdEYaSA6XtqvGiPiklUjQX2Tnv6ABIv19UEqg8Oa59kwwU0yNdo=
X-Received: by 2002:a05:6214:20cf:b0:6e4:4484:f357 with SMTP id 6a1803df08f44-6e9006adc5amr38428386d6.30.1741360570529;
        Fri, 07 Mar 2025 07:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw/b2w6u//qoeC41l/SCcWWsldDpFpfYXf8Z2PBj1QJkAjmh013a2A8GgLukVtjv9HzHJESw==
X-Received: by 2002:a05:6214:20cf:b0:6e4:4484:f357 with SMTP id 6a1803df08f44-6e9006adc5amr38428076d6.30.1741360570246;
        Fri, 07 Mar 2025 07:16:10 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b6acsm20373116d6.74.2025.03.07.07.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:16:09 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <820ce062-ebce-4482-93f5-cc618a0c3c41@redhat.com>
Date: Fri, 7 Mar 2025 10:16:08 -0500
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


