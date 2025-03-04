Return-Path: <linux-kernel+bounces-544925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7191EA4E653
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8227A4240
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10290290BC0;
	Tue,  4 Mar 2025 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBAF3P6j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB926280CFB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105147; cv=none; b=EW4Uet7NCZSA2q754+7ZWQ4yoqqB0H6K/ew1GbOZENtZwSwLy8CY2JwXqwcQJIMg5MjtNYHUy9M8Nc0dG316UQw7kuW5ULc8j86Vbja7i6xG34tpZ0yyPypT3QUFeKdpyCsN6wtuZnLGM8Fe7YiEbJ3kyuq1WRFURxtv6uhKDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105147; c=relaxed/simple;
	bh=Y6IhqAMyuypLmPTH+Xshl5PBsPx3QPOHwZtDka96QGE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pql1AgqxtZQlbiJsr4gmt+dS2G85wPLtG6jdKO84w53Q4a0ZpAYw5N1E+BqOO41EPALk73g8bM6DmdgxY1b9Ef8mCX7iZsTc0mGtKpDH15/7VET0V9w6MJt2mhhf4TV0SUotmQK621Iwj+SwQ6BGWcooEO6UdfOzY50vWUnYhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBAF3P6j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741105144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkY1q4GVy/AgzNXZlr3UCoSg7uwWVuhY86KyHkjXAyU=;
	b=IBAF3P6jST2LlBK6PNJiDrAsSJjEqbRhJygjKVm0NbYc070OWWGpDhJB2MuyTFYSgAS4XO
	n1t5ey42f2Gk3wKAT+ek/B1SV0QPjtwPcZnkmtQG4xohh3wqf23njQJb6hHLlrjpDzJ7aA
	VkrtZZ0is7/isDNYUi/77ao0aWpZDGc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-KXQm385cP7uMquX0ZFdnqw-1; Tue, 04 Mar 2025 11:19:03 -0500
X-MC-Unique: KXQm385cP7uMquX0ZFdnqw-1
X-Mimecast-MFC-AGG-ID: KXQm385cP7uMquX0ZFdnqw_1741105143
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e88964702cso126304236d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105142; x=1741709942;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkY1q4GVy/AgzNXZlr3UCoSg7uwWVuhY86KyHkjXAyU=;
        b=I7pZBMqK4kculsQSc31Zb+qXimlJer6sE7/PvFCa4USbVChhfvfMGIyFPT2HkhYbUF
         yfI+bzLSywR4vtFYU/mSKIbhtPyjL2nEKbYKpdXhCzve73diusa4dwEHY1uGzM6h5lmM
         qFj7Y5xdcZ8MmkBDKVAeHdpY38jjI5z2Jt/FzLkGqSKBokVxMV0S7LoJFlpl4v1B7xmN
         9bX6IbI4XyhavTOTUPCooPv8GaJvBDtVbN1gFQXDHgB8WClg0reBcoUy4hue7q9b5smY
         MnrqnO50ENSxCxRUr8sKTcO3/cUOplwBMuDXUK+ScCxpd0EOyDM/uV2BKe2LbJKAX54W
         Z+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA80rgLJLj0ql1QhIotYuDYo4OW7X6VgZCwk8ZAB/7jb1Hwsb/WRmi4547lr1e5EPucx8mHVckdPTMg58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8H9u6a5rzjl27qx86PVX5YP7PAjpXDRFv5NaX1o+PrfmaYMP
	nj6vwwe47IHj/ucK5TchFYophRYh4yYCCMTj2QvPS+9njtkaRFFZO3k1urAPkIYekh/zZJ3j9Ao
	IM9FARr40otUmidD1TmpbMWafvDNN/ype6UEHW5QS5LTM6HVQrNJwYauDY8+c5Ss8cxGOkQ==
X-Gm-Gg: ASbGncv/nhJu2X/y9Iw47Xd6bPVsYrR09E/MveNNLQW4UaEnA+en/Vy3SAln0FAME1Q
	qGHBFxCItUkgSK9maUX+ws4/6naWKla3SVVn5VkBpoVAK353qdbaRdKpnTuNZOSmQUacd5ms4ZN
	odQURguWINDlJPnY9Km9i8fgac62tQhtFzhrdNjLWqm40josJtcU+tXoiDbNd7GU+5G1gx6cwsL
	nnEwf4KqkVkEH27LEUPWBxwlgG30DQUjPJ0MB/rMoUy2U4gJvfIiK05t6Fmg2vK1raaSBYQSt2C
	facMbBwY7rN2Yw7SI/HhIgKNYG017TSBkvivpmFhBMwlh7CFhj7WE1dc6Dk=
X-Received: by 2002:a05:6214:d0a:b0:6e2:4da9:4e2d with SMTP id 6a1803df08f44-6e8da86c4e6mr54175546d6.9.1741105142537;
        Tue, 04 Mar 2025 08:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf9Lkg6ASc/ykDXkK6Oa+0eE2cY96omReERphGYblNYllL/ZY1FB1NRS0/OnykdtBdUDLs1Q==
X-Received: by 2002:a05:6214:d0a:b0:6e2:4da9:4e2d with SMTP id 6a1803df08f44-6e8da86c4e6mr54175276d6.9.1741105142174;
        Tue, 04 Mar 2025 08:19:02 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976608e7sm67966136d6.51.2025.03.04.08.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:19:01 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8b8f0f99-6d42-4c6f-9c43-d0224bdedf9e@redhat.com>
Date: Tue, 4 Mar 2025 11:19:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] cgroup/cpuset-v1: Add deprecation warnings to
 sched_load_balance and memory_pressure_enabled
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-2-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250304153801.597907-2-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/4/25 10:37 AM, Michal Koutný wrote:
> These two v1 feature have analogues in cgroup v2.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cpuset-v1.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 25c1d7b77e2f2..3e81ac76578c7 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -430,12 +430,14 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
>   		break;
>   	case FILE_SCHED_LOAD_BALANCE:
> +		pr_warn_once("cpuset.%s is deprecated, use cpus.partition instead\n", cft->name);
Should you use the full name "cpuset.cpus.partition" instead?
>   		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
>   		break;
>   	case FILE_MEMORY_MIGRATE:
>   		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
>   		break;
>   	case FILE_MEMORY_PRESSURE_ENABLED:
> +		pr_warn_once("cpuset.%s is deprecated, use memory.pressure instead\n", cft->name);

memory.pressure depends on CONFIG_PSI, so it may not available in some 
cases. My suggestion is to add a "if available" suffix.

I do have some concern with the use of pr_warn*() because some users may 
attempt to use the panic_on_warn command line option.

Cheers,
Longman


