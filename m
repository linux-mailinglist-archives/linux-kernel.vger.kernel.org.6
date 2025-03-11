Return-Path: <linux-kernel+bounces-556252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0835A5C32E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA5E3B3079
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332BB25BAA7;
	Tue, 11 Mar 2025 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNdkTVLH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA225BAA1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701740; cv=none; b=eMsKjsjpTQm+Eh0kWb5Hi2sfi/IxkRGwA0TzW+LaLlc2Zv8ToBLZHvPHBoq1RcpXCXUF6I0BPCZKZO19Ei0f2oPtNahkAQz1l9HXN5aMLHPHQI8sXz9ws/+8Fe8tY+h0xCs1HdkEX4t/dV7ktTvWoVE430DyF9DbHAEtBe0jjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701740; c=relaxed/simple;
	bh=w4/4MsuywTM8dKIEtT8CwRyGelvllPmBbieFzdzBLJI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s2jy1tOImMsEh0cjMuBcEznJO8B06zzXPO8CvkGDSpFlnGtG/P/G+yuAiGOg/q7bNwP8Y1HfFRt7/L8YgD7QUCkhkGot2ZB0R40/2mIZY/0iLmjpyzvGZRGT4vi2ZkRZ1uycmWjSQJtWY50we2X6FJPzuYYie7rP9iYFFaIVW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNdkTVLH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741701738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srjZEoMcmsNF1ucfOw62TWPMYLcdnIdIH/Ek8tx9FZo=;
	b=UNdkTVLHpWoHhs0Zky3u9Q2F+ZjF+d72JdOZ7cXJPe0whjaQv/qWZ92wCO7uFstKus1P74
	y0Ha5u99WTeJG+Q/bBDMEsTR2fXt3pGrc5gg7BKLD2NV56zRhXPSZXk4YtVgCajfF+hmjD
	4g9/rYMkUF8EMyP6d4fg/FL8WecOGa8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-O3VIieRrPrqdlkVDWLeZdA-1; Tue, 11 Mar 2025 10:02:16 -0400
X-MC-Unique: O3VIieRrPrqdlkVDWLeZdA-1
X-Mimecast-MFC-AGG-ID: O3VIieRrPrqdlkVDWLeZdA_1741701736
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3b8b95029so841997785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701736; x=1742306536;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srjZEoMcmsNF1ucfOw62TWPMYLcdnIdIH/Ek8tx9FZo=;
        b=jhcDVrVSAf5BZ3Gg1VT1iLmo1oKhclwfZ4ekynWkIZoEQmnifVAuTQw9A5Jt5PmUsG
         wxAA9digVCBZ+HwOawBzI9HQQt4awKvpYoYDpT94x+pLrMmz2RxaO74+jQjd+S1Vvp41
         +SptI1oGW6KdbmnO7ucMqvAFt3yOFZH/4SoAIGY/KjHSGl2EnBT3ppRylwtZZZZgpmnk
         aQk0CTuC/KWCzq89RsWBZXWSjhZmDaLK12IshXRxmcn1FFjQ+rXop5RSDdlFvG2AxIMC
         cwPq5xxdb7veP0HiPT9FIdzR3aRigzVl/3/Wu82g+Z5XBxpHr7MEhd0fl/H1yv8yxPdw
         N8jg==
X-Forwarded-Encrypted: i=1; AJvYcCVbow7fO2WlMw6l8FdMCmet+UDWjp+aLAafveSXwNhFrFBDqBJQl0ytRygp1CntjTAY1c1+TivIqo21zMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOcquvMVmeKRUXirIz3eqDGe3ZOfy+6adcksa7ApVyuem1iMi4
	bib2oNEKrAYbcnkR3R53NB1hi8hixkXaR3vmw8ybCjo13Mn9ygc8UiZlSLy0FLJC6Esf7jHeT2L
	90XzWSj0aRLPUH8UZn+i5ICzB2pVpJK59hm12dPxDQ2TEWyC+yZ4+WhZ0s1pFKg==
X-Gm-Gg: ASbGncu1QnyY6f9X2OYPkd9C3SOUL97J9sM/jkdIGA2jlvUQxX5xuLSDrPdMDCHY1WJ
	gHznAhPr0TqUEXhczQi2col5iKTtFv8Xs1G7digw+d36AMhV95XqdggVJ0XC9JiJDv6rfj+smx1
	YULj/JwzJdSKfURj+8D/ddGQW9DGxufvl5ZjsufkNQKELJKovMb5G+6nxRuffZXPQixicLTYZ9z
	OeFDnuqOaufk72Wj59V9AMEIt1HKuaVugNay4M2L3XcJxa9IgbCXDASMV75tJPaRTeDY3z8NxRN
	dO+9lbLLfoReLFwK3uX7hcV/My0U/HweIVGPbix/TgOIot+X00LZaQ/s2op+Nw==
X-Received: by 2002:a05:620a:8707:b0:7c5:5670:bd75 with SMTP id af79cd13be357-7c55670c019mr929100585a.46.1741701736044;
        Tue, 11 Mar 2025 07:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRg+L8adczL3Foi2AAcnsKmOHEJwYXqihA5sf9EJSRouLY4pSX3Hx4mbey3OW2QQT9tXALaQ==
X-Received: by 2002:a05:620a:8707:b0:7c5:5670:bd75 with SMTP id af79cd13be357-7c55670c019mr929097085a.46.1741701735738;
        Tue, 11 Mar 2025 07:02:15 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c558a2f92asm248542785a.33.2025.03.11.07.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 07:02:15 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1959b178-5c3d-4564-beb3-f411cb9efe77@redhat.com>
Date: Tue, 11 Mar 2025 10:02:14 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] cgroup/cpuset-v1: Add deprecation messages to
 sched_load_balance and memory_pressure_enabled
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
 <20250311123640.530377-2-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-2-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 8:36 AM, Michal Koutný wrote:
> These two v1 feature have analogues in cgroup v2.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 25c1d7b77e2f2..9d47b20c03c4b 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -430,12 +430,14 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
>   		break;
>   	case FILE_SCHED_LOAD_BALANCE:
> +		pr_info_once("cpuset.%s is deprecated, use cpuset.cpus.partition instead\n", cft->name);
>   		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
>   		break;
>   	case FILE_MEMORY_MIGRATE:
>   		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
>   		break;
>   	case FILE_MEMORY_PRESSURE_ENABLED:
> +		pr_info_once("cpuset.%s is deprecated, use memory.pressure with CONFIG_PSI instead\n", cft->name);
>   		cpuset_memory_pressure_enabled = !!val;
>   		break;
>   	case FILE_SPREAD_PAGE:
Acked-by: Waiman Long <longman@redhat.com>


