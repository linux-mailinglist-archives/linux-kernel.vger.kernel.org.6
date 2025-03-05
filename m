Return-Path: <linux-kernel+bounces-546994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4FBA50191
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773A7189538F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505DB16D9DF;
	Wed,  5 Mar 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NP1rP8ZN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC73FB31
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184186; cv=none; b=MrfJZwAmcIWJ+b5OyDI7yx+59OrtrCroLy9Mb4I1WNu8ravCb2CVrSeElwxdzrHSNxbimaqHv4LBUI+vpT7ppsXwhgLw/5VhC3PvtbKP6bZ7sb6ZYN4pSWOmxAqx7p/SKXFno9/HjM5UerwH+FjeqdEKDe8SAa+vxS0KlO/3cnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184186; c=relaxed/simple;
	bh=c5S7J2OYn+W4nZXQktdFwa61cTc7CLqDBEHPAvczxP0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=r69j9OKt+kjYd9fmHrX3suC/9ZMgYcPCIkASVE1LdWnwfGV1R6y/Q7lizPHqJ35z60yTUubqGykEqTMk6p9gXvJL6qa4Qm1Q5UBAqqgdacGyERekGq/Ujx9eM8Nj2VJRddxAiLXeqcUz91VyHxLqs3BIljr6PHR04xOQY03PuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NP1rP8ZN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741184183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFZHoZfRPZOBrtp2NMgzlZKzHBYfeJpoTJgjAjPn8dw=;
	b=NP1rP8ZN/hBT5TbdNJKoQvqc/XCC9BrzgWl/QWgCq/kMPIBGX+nS3txI5Ry+vKQx21i7F0
	qnjg3e1GtNA+qLiPTsI6mUK2HapjO4vNWMAe+uhm86zjkMJyBfXHzJvOTsj7uWwdfnoTL5
	eSMoArehM6ZgRLXOURO2yk2kNcA8Iqw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-xwtxNtA4N8K3P8s_McC8sA-1; Wed, 05 Mar 2025 09:16:17 -0500
X-MC-Unique: xwtxNtA4N8K3P8s_McC8sA-1
X-Mimecast-MFC-AGG-ID: xwtxNtA4N8K3P8s_McC8sA_1741184177
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-474f8bac6e0so109471151cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741184177; x=1741788977;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFZHoZfRPZOBrtp2NMgzlZKzHBYfeJpoTJgjAjPn8dw=;
        b=nyD3pKowFpEc0vg/Lwy0PtyZbbu28QYbdL3XwtjfMxgahm7S4UUMhYxUiK067cyghr
         onzoTlDm+L4y3lspHDXgEXuwFPbt7RmdiBuBAFQrgfeekwkUjs/ZVWRwTydjGGP9rzK/
         6nM4KALibd6PTWC660BncM1ySjC6pZ00i1MXIHimvaIeyZUedi+0OYjwJOTYwJsXKjn8
         0CTSECiBxjUv4U7/FoZ0lXQnGFbwn8BE6PvhfF/0cS21coSqqdHCkpmYfw5R0aaMHubH
         B3+fIEF7a1o9uIqJyNlaR8q2T/uKuj7OKWIFj20pvUoMEDD/X7r4X9vGQQ4WqxnB3OeT
         e6gw==
X-Forwarded-Encrypted: i=1; AJvYcCUzxH5U8YnXK5qZyP02fW7bIQ8zD7ilauwatT5Z6oOHN2vIp63w78lIIQ65jOTR870ZQ6vlrvOirgVAGnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDMnZQtAJwogo2WlOKHnyJ4pIgf6Kpg2fMFvofKBLIkImZemGD
	ynezSYxQKwZp/FqYpB4JVqTlk4zmnkt3xll+y4EDShj0PWiMpZ0zW51j/Ql0ZUODFFNTDiIw5s1
	WL/Wpembjb8JzTiMMcuE/qADEEBxFG/iYV6wSplHuCLXqu6IBLOJD/juxzSXtUw==
X-Gm-Gg: ASbGncuOPnGhRu+qYs0t+285YO/7z3XZdn67cJPP+s3EGyO1wi6UG0QBdA6COyEnnDk
	S4Sjmx/DFcNULSeZ4d+PG5Mu4AXytz17+JHk+rqeThoyebVFlLfc8a+8VNnXsX9QlJfvs1Hqaq+
	29Wa7msx60AjIWSqe35x4CsOqdljZ5xaZMou1PKtwkcE740TD7Y+y5A0+IEDoPJWSEdu4ftkwow
	jBMH6iCZ5s7F9GmUeBkeZuIE05wtBzRS3ABdZPfPgRG9Bl2oFe7RNS/m1KWYsAnSHGH9ZarIYFU
	SibJpYCRrqJ4jaqY9ELnu9rim7Ez4Cw8puOJMNQnVQgKR1JhiL/hK3bdvbw=
X-Received: by 2002:a05:622a:13c6:b0:475:946:9af9 with SMTP id d75a77b69052e-4750b45e28emr32102851cf.24.1741184176951;
        Wed, 05 Mar 2025 06:16:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2i6+NphVWLPKdROQD50Ji33QODfr+ufF7lxzb8Gx6bZBnBo6QU8mu8fpca6ltBNDLR/ASYw==
X-Received: by 2002:a05:622a:13c6:b0:475:946:9af9 with SMTP id d75a77b69052e-4750b45e28emr32102521cf.24.1741184176589;
        Wed, 05 Mar 2025 06:16:16 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm389412085a.1.2025.03.05.06.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 06:16:16 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d259ba35-a4a5-4e01-b539-85f2080fdd33@redhat.com>
Date: Wed, 5 Mar 2025 09:16:15 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
To: shashank.mahadasyam@sony.com, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>
Content-Language: en-US
In-Reply-To: <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/4/25 11:12 PM, Shashank Balaji via B4 Relay wrote:
> From: Shashank Balaji <shashank.mahadasyam@sony.com>
>
> If the cpu controller is enabled in a CONFIG_RT_GROUP_SCHED
> disabled setting, cpu.stat and cpu.pressure account for realtime
> processes, and cpu.uclamp.{min, max} affect realtime processes as well.
> None of the other interface files are affected by or affect realtime
> processes.
>
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index f293a13b42ed69e7c6bf5e974cb86e228411af4e..2c267f42e5fef9c4e2c3530ce73330d680b9b2dc 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1095,7 +1095,9 @@ realtime processes irrespective of CONFIG_RT_GROUP_SCHED.
>   CPU Interface Files
>   ~~~~~~~~~~~~~~~~~~~
>   
> -All time durations are in microseconds.
> +All time durations are in microseconds. Only cpu.stat and cpu.pressure account
> +for realtime processes, and only cpu.uclamp.min and cpu.uclamp.max
> +affect realtime processes.
>   
>     cpu.stat
>   	A read-only flat-keyed file.
> @@ -1115,6 +1117,9 @@ All time durations are in microseconds.
>   	- nr_bursts
>   	- burst_usec
>   
> +    The runtime of realtime processes is accounted for only by the usage_usec,
> +	user_usec, and system_usec fields.
> +

Alignment problem!

Anyway, I am not familiar enough with these cpu control files to give a 
review yet.

Cheers,
Longman

>     cpu.weight
>   	A read-write single value file which exists on non-root
>   	cgroups.  The default is "100".
> @@ -1158,8 +1163,9 @@ All time durations are in microseconds.
>     cpu.pressure
>   	A read-write nested-keyed file.
>   
> -	Shows pressure stall information for CPU. See
> -	:ref:`Documentation/accounting/psi.rst <psi>` for details.
> +	Shows pressure stall information for CPU, including the contribution of
> +	realtime processes. See :ref:`Documentation/accounting/psi.rst <psi>`
> +	for details.
>   
>     cpu.uclamp.min
>           A read-write single value file which exists on non-root cgroups.
> @@ -1170,7 +1176,8 @@ All time durations are in microseconds.
>   
>           This interface allows reading and setting minimum utilization clamp
>           values similar to the sched_setattr(2). This minimum utilization
> -        value is used to clamp the task specific minimum utilization clamp.
> +        value is used to clamp the task specific minimum utilization clamp,
> +        including those of realtime processes.
>   
>           The requested minimum utilization (protection) is always capped by
>           the current value for the maximum utilization (limit), i.e.
> @@ -1185,7 +1192,8 @@ All time durations are in microseconds.
>   
>           This interface allows reading and setting maximum utilization clamp
>           values similar to the sched_setattr(2). This maximum utilization
> -        value is used to clamp the task specific maximum utilization clamp.
> +        value is used to clamp the task specific maximum utilization clamp,
> +        including those of realtime processes.
>   
>     cpu.idle
>   	A read-write single value file which exists on non-root cgroups.
>


