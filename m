Return-Path: <linux-kernel+bounces-556373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E228A5C521
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43E91888AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D8325E82F;
	Tue, 11 Mar 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQ4c9YhE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB0C2B9CD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705734; cv=none; b=BTq0FoLd26KjqK1tEXYaoko6p+xQRPqV1kbxIGK9LZwXCAad65U3MWNZxCfkWpO2CylSv69jd1cLutshOK0SXWKixIk5eDQIf3bRZzDoeOIbB6GP31QojoRfH7Z8UBhSM498Oz6MRgzf6zGxGxDYykfYUxhMYufqDY5GjWlZr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705734; c=relaxed/simple;
	bh=Rn265ygkkN+2iuftadXyt+dK+wEgVPQ1nkSFXLpUNS4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=vEQwj/zgjio933/L/qKrQE9+Eq+1FIzEkphg/76Bagq/zgZEt0/BUhnEahWid+//YiSew1r7Zy/rb1jQaOEGn+QdbvdaKHkTJXG19bepKwBsBHQBsRaJa1hUD5bpXIluqUy9SF1B946AX67vZKz2oKm0JmEsMfSfrRj6AYPKIt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQ4c9YhE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741705731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lq8Rh0gX8/DY3brLdpGabT9QXg7lPk4cEtKLUbOwV70=;
	b=XQ4c9YhE/+XcQd7k7KpQdb97K34N4sMm/UeK7tEqeeyGDZdpsEM/xuy0oxB+gsumSp7qeM
	J5FCP8jHJ92uUedJObEiEzlDdgq4SKZdG9v+7cG9Y6IC3ESaspTG+FZknYynK792A+Nzcj
	smK9rji7wqr+J3HsQF303ZQgqDAzOUs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-ijEdTfEGPkeTowjE68gNAw-1; Tue, 11 Mar 2025 11:08:50 -0400
X-MC-Unique: ijEdTfEGPkeTowjE68gNAw-1
X-Mimecast-MFC-AGG-ID: ijEdTfEGPkeTowjE68gNAw_1741705730
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c54a6b0c70so300296085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705730; x=1742310530;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq8Rh0gX8/DY3brLdpGabT9QXg7lPk4cEtKLUbOwV70=;
        b=A7Bsb4ggccObvxRz4nrVymrh9Ekst5yujy0uKfM1IhJgcYnreCV1D++TcwDxOnTATd
         B5uPprlbZNPvcA/mNYobj685LUugtBl3nV8JYLa52NkkKaQECn6b0uWoyoZTq3pzvkgz
         fF8e2sH1wbLT5yjEIAUSQhBsX723CFmljdjyQfxQH8L9IBfN65nIGK2gsOkAbJO2DjCT
         vLL8Yn7ViTkUc3FoyqLXyQToJbUOndBmjoqa7ho17TzkDZx+Lo6g6g5tZKMMbO22wH6k
         PfbS7Mawc4vlXoPj4DXzm001NFqSaIvTUrc75omztjjMyqmI9iJt260Ja6DyUxNtS1nP
         ti6w==
X-Forwarded-Encrypted: i=1; AJvYcCV2yJ4OHK07ecMclXzfBQ1T44VVxDijG9H881eqYDuG+xdVX1zrzZjZc7gehYdHo7oeHM/WmpBa2UlB9Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqhyIknpOKcMAMMn2AYpE6Mm4ohLKmRlzNJ2vE3Sp2kKaey2Uk
	ZaEJm7fuf0ePzxKJAtu34VOFNnechoLTq9BO27GuXSdL7K7k7d+pGzR94Cdvr23KLVt0RJRJFTI
	5smwA4vPdrUNOldlNtjq1f/UnMczNThYYefOUiP7m8qIR/VFu26L9gzIiVDOp1w==
X-Gm-Gg: ASbGncusFk0c4q1Tdz5MTCtlUMcLMVvOZY6+W2elr0OsGlu88zsKHXIBinC7Mb/4uGO
	JFA9rJfz2k2tCPlK7Gip+j2dz0aowdXRIcZGperYwN67jLNdFAC36fHnV6tuFT0uDphjFmJoA4n
	O9VdvBqvD2gpXE89RSCkpaZDLvZqPtU7LGO9P3vd2XKcruhdnv0ZlxNCGzgI96KCfJ3Z5o7ETvJ
	OuienVW63TaATGH8Sqb4u9VS3DiRc2XXF6BwN1wdfKNQEWxXXoL7IroWfdrAPEcmd2txuqEOmqh
	Se+CpQ8jdKMLY1IVcsPQ8kiSEKxYAabIWWaTEtg5uDFiPeRtmkgO1Qpdx3iFfw==
X-Received: by 2002:a05:620a:27c6:b0:7c5:4b37:ae49 with SMTP id af79cd13be357-7c54b37b078mr1475834185a.48.1741705730051;
        Tue, 11 Mar 2025 08:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCZpXwTz3aonaP+NP1Ws4RaI/fF9Qw0N6b4g6rosPBjPZA2B5suuDkHjzezbTIXIIiVSllDA==
X-Received: by 2002:a05:620a:27c6:b0:7c5:4b37:ae49 with SMTP id af79cd13be357-7c54b37b078mr1475830685a.48.1741705729750;
        Tue, 11 Mar 2025 08:08:49 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54bb78fe2sm426862885a.94.2025.03.11.08.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:08:49 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <130b167a-7fc7-499d-bb5f-a06638c3c1db@redhat.com>
Date: Tue, 11 Mar 2025 11:08:48 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] cgroup/cpuset-v1: Add deprecation messages to
 mem_exclusive and mem_hardwall
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
 <20250311123640.530377-6-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-6-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/11/25 8:36 AM, Michal Koutný wrote:
> The concept of exclusive memory affinity may require complex approaches
> like with cpuset v2 cpu partitions. There is so far no implementation in
> cpuset v2.
> Specific kernel memory affinity may cause unintended (global)
> bottlenecks like kmem limits.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index fea8a0cb7ae1d..b243bdd952d78 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -424,9 +424,11 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		retval = cpuset_update_flag(CS_CPU_EXCLUSIVE, cs, val);
>   		break;
>   	case FILE_MEM_EXCLUSIVE:
> +		pr_info_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = cpuset_update_flag(CS_MEM_EXCLUSIVE, cs, val);
>   		break;
>   	case FILE_MEM_HARDWALL:
> +		pr_info_once("cpuset.%s is deprecated\n", cft->name);
>   		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
>   		break;
>   	case FILE_SCHED_LOAD_BALANCE:
Acked-by: Waiman Long <longman@redhat.com>


