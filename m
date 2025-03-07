Return-Path: <linux-kernel+bounces-551379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C25E1A56BB5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF57016E742
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090D21CFEA;
	Fri,  7 Mar 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWcBSsbK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97AD21CC7C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360630; cv=none; b=MTxxqZrxIuPAkUco10SvYhhG9vHXXK7Cnui34RUxe+WpKkT28tpH0AC64nZ9kwpZvMBt7o/tD1Z/vd8dZDu9YNSJexsb6ZA7sMp5bSJ6EuBjrCQQW39az37LqvUJLAXwMZdeMnrwn1Fn/e9oDadsdaND2SmOExgkrbFl9y/1nVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360630; c=relaxed/simple;
	bh=u1ia+jgdTy6SEy3Z41USO6FQmaZmpeo4fLS9jAxShW0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nfyDQPsX0SoNqEhPB5/pbWMFpIqb9U3bSQzzSmELzBgGomtWmJ+NzH2PnkYFwfD+3blXxLjX0EtaAQO4cjGEFOKMrBTXz8XJawjhVHfNNWe8Vx7FxznANEXkn0O1++Mv9ifUWZi3me17gCcexmjhTsYhvhRt0dfoINYS1iDO9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWcBSsbK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSf6oeIJqNd7y0EfyhKwRUYW2AS0darN35r1LLf0w2A=;
	b=hWcBSsbKGe6Sh495dI/ML//F1e4Lcg8sHK1AQpHO2x0StLYep18JH95txX2Y8wwo33Gis4
	7Tl1+1zlJMJFmU7dFfbkbi5bAQ5r4M4Un0THI2CUrnDfTIHcFXd7WVPLKvULyVMIU28aS8
	6fnghiwbJwKYpqBPEwm1flUksLrnEmI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-JCqRoPtCMrS8TjA2X3JoOQ-1; Fri, 07 Mar 2025 10:17:06 -0500
X-MC-Unique: JCqRoPtCMrS8TjA2X3JoOQ-1
X-Mimecast-MFC-AGG-ID: JCqRoPtCMrS8TjA2X3JoOQ_1741360626
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3c0ccf1d3so650840485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360626; x=1741965426;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSf6oeIJqNd7y0EfyhKwRUYW2AS0darN35r1LLf0w2A=;
        b=svr9c+HsIlUAnW+BrZ5QQIUdzPcu4KGsVjl+0BFK06yt2k9YvIW+fuEBsEPQA+RoS1
         MTo7WToR/FRC3v+330orKETvUEHQmwx0bOvgZ1WuSVItTyDJbuegUPsX6Bjhki1YAe/O
         8MrEVPLx0oNTv9sdpW1k939aXtYeJ7S/cxKQgkyprnsesLQq1+4oxfjMgNSj/Awz2frN
         Y4JvGRMPSLStQz2tcgjp+oCp9wtEW1yPQK7WmEdLDLj39djt5/JlS8/tyO+o/Enibfmm
         aLIIp0FEv6VyWdHVs+nTC3nYVaRpdysgb97GEAX1AEv4D7R0AUNmL9qC8LucQS5fhKKi
         x+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlqB7jlpAhXTosaMyfc8891cMVSyNH8mH8RmxBsbZaJ/bXB5wlHPlJ25bkdflPpZ5yoQ26kmxeQQURRFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC46WKxj15TJjomP4jiTCuj81SMiNJzWkM3MChAUgOa/wb2epo
	fSiWT6bb2cr1IDTWM/58MgDIajHSlDiYXRjuTqj7tUB8Sw3oQcI9KwlOY5i2wcVBiap4+OSkqqe
	ykQot7IB05CpmKLdVqJM6xoLA5qwkpkVSKbobTI+bSsfHxe9FaSImoVjMAH9xog==
X-Gm-Gg: ASbGncvbG2UBCKbUmLOGfrxh/Vdygk+sSmOcgf4sOzJzYdrqB33G8rm3gsfpunT2ByY
	yizzRHG59BnMNj7tYPdU5NnaWrZDZ/cwQx5adtVfhuPcqtJKC3Lk2YBlfohem8j+b2sc0SWnqWu
	Rphj6vDLmfEdn+dK19lTXENh3W+5pjzZRHXPHaBbx+PFi5MInmXbL0PQk+65MLdv0O4E6HWXzP0
	3G1M6gTR+ZGEDVk9HU+PeybDgB1M00Sm7jR/vuRx2AUU48yjY1iLOM2F4EgKHmYJd8fhXMHDKzR
	jqUgOkjxq8oMbabdI8EFGgSEbXAXvv+c6iuY1QXYzMyL//0ceDeilY99MFU=
X-Received: by 2002:ac8:7c41:0:b0:471:9dd6:b51a with SMTP id d75a77b69052e-475c677efa5mr54669301cf.21.1741360626201;
        Fri, 07 Mar 2025 07:17:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7evF0XJq+z5QXXPTC1cKhMgQOZY905OvJ26UXCPt4pNptuMXkQbcvcKa3pfRIHeSjuvtbHw==
X-Received: by 2002:ac8:7c41:0:b0:471:9dd6:b51a with SMTP id d75a77b69052e-475c677efa5mr54668161cf.21.1741360625415;
        Fri, 07 Mar 2025 07:17:05 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751db2f961sm21123951cf.62.2025.03.07.07.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:17:04 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <234d750d-cd2e-43b2-8133-43ca1fd889de@redhat.com>
Date: Fri, 7 Mar 2025 10:17:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] include/{topology,cpuset}: Move
 dl_rebuild_rd_accounting to cpuset.h
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
 <20250306141016.268313-9-juri.lelli@redhat.com>
Content-Language: en-US
In-Reply-To: <20250306141016.268313-9-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/6/25 9:10 AM, Juri Lelli wrote:
> dl_rebuild_rd_accounting() is defined in cpuset.c, so it makes more
> sense to move related declarations to cpuset.h.
>
> Implement the move.
>
> Suggested-by: Waiman Long <llong@redhat.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   include/linux/cpuset.h         | 5 +++++
>   include/linux/sched/topology.h | 2 --
>   2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 835e7b793f6a..c414daa7d503 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -125,6 +125,7 @@ static inline int cpuset_do_page_mem_spread(void)
>   
>   extern bool current_cpuset_is_being_rebound(void);
>   
> +extern void dl_rebuild_rd_accounting(void);
>   extern void rebuild_sched_domains(void);
>   
>   extern void cpuset_print_current_mems_allowed(void);
> @@ -259,6 +260,10 @@ static inline bool current_cpuset_is_being_rebound(void)
>   	return false;
>   }
>   
> +static inline void dl_rebuild_rd_accounting(void)
> +{
> +}
> +
>   static inline void rebuild_sched_domains(void)
>   {
>   	partition_sched_domains(1, NULL, NULL);
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 96e69bfc3c8a..51f7b8169515 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -166,8 +166,6 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
>   	return to_cpumask(sd->span);
>   }
>   
> -extern void dl_rebuild_rd_accounting(void);
> -
>   extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>   				    struct sched_domain_attr *dattr_new);
>   
Reviewed-by: Waiman Long <llong@redhat.com>


