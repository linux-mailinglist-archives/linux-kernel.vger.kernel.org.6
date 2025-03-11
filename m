Return-Path: <linux-kernel+bounces-556376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC10A5C51A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A5A7ABAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906625E82D;
	Tue, 11 Mar 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBWHYq0U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B125DD06
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705829; cv=none; b=iOqOX+9hoZB/weGs+mrbHSE+9vTVvNekFQsBJped6R919q5TBEXEwewRv1hcdE458cIOJjWq7ceLLEavhOQCjhwqmht/9lkJ6wMHxmxoJp09GrFtnZs/VYE6FxUK4BgMPf65Gay4OnOdiK9iRqgSb8UrpuxkhuXG51MAfLjhJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705829; c=relaxed/simple;
	bh=6xUFOUJbj+bIkDKDzKhMcdc7H38Tyf5InLjfqu2UsAg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j2U7bF9TNlUJV7/wE5Ojv6mQ5MKrIX1jSMTPwMn/L+A/t2xpwLY3cgxZVimwqUg869ovqydqbIxVjbPF2XMHgb21HndzAv4gN2+CdpqewhPP37RyU8fYxqmvXJWs6WqTU/DNwm6G2JcMPwZJCO9ckgp12LIlzYOaYW5fyh8YSLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBWHYq0U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741705826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IG++bO0r6VtJdGQv/NPOpw3HuEvvlwn3OEQA9ottqtk=;
	b=PBWHYq0UM3vBe+N7cFsnkFXl+aIBc9rVNBhnDcGQRQVs4eWpa6IVhDsAatGLnRAWBnuZD2
	+c8TWz1FU0vE5SrwkAxGKuIQ2rhmszJsXkN6KP2ln6ERvxjcdsdg0MEwMWCVgWAfjMohMF
	aFcC26g0KuX6n/V4p77N97qp9HTBMDo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-Ub9tzdr8PK2-XQFZ9LHU3w-1; Tue, 11 Mar 2025 11:10:25 -0400
X-MC-Unique: Ub9tzdr8PK2-XQFZ9LHU3w-1
X-Mimecast-MFC-AGG-ID: Ub9tzdr8PK2-XQFZ9LHU3w_1741705825
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c54e8ad9b3so447940585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705824; x=1742310624;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IG++bO0r6VtJdGQv/NPOpw3HuEvvlwn3OEQA9ottqtk=;
        b=GA14kD03t/BWgjHgO0S1r4mIljwHt9a3kk8D9XPYN34kJJBMpOnmBs9OCcL2G+2faV
         XDAPijR7SzgPC3jCbqtngjgB2aLbYph7sy/fEaZK565YCgqFexnYqDEFp5tCiSRPYZIZ
         Wf/eQOj6q/ySx2lQgtCqVyiWlnsIjkPlWGTmsgMpMGBXeQCFI25HPTrHzmzGoUvK9UMF
         ZlsWxrqJeTXHBcQ4OjVAbLZZjlFwEHzbJgq/269ThFTl7Yc2g4U4hXHZHhvUULSDmxFu
         cZqFRRIJO3/Y2vvbi0Dh8tF8MIGHiqftfx+NEN7exUSyL4MRCeGQY3mSBAvBOMMon+Ys
         OzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGtvXtm0ZlOLyGlDiuYnihwLuugHp1MYADjCfQSozMMJPb/nEIHV/pdjfljn4F0MNm5DDl+uVweKxDRoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5EwgQbOPiV7GRdvNCoZbIJOmvphqCGh84Qq8Vh5mBokHBIqth
	nPGbR778yTiFbkhJDuPPudiV9N8zw4Vyu+HvVqLWe2O0PRgR+sZsn7DejGOherYGQvWkuEKSoza
	1nKaHqr+c/Cw0RL/aB/2yNK14pG1eG1M4dicu1v+lW7Sq5XLrRNmvoeLo7bPoQs0YPBoRcQ==
X-Gm-Gg: ASbGncsGzFfLYQF6j9EIDfPgJCSGHbbf6S6MLsL02SVx1/GpBV/d+4ybu7XlrjwQwLH
	90zjYZVylCM8w2hFPKM5a/VwZ7JKPi0n+XuDp+3fXu2KfjJv/KtqxXCt6oUW/bggkWvtHXhyhrH
	jLAvirvmeRNPEMC+Zv5JJqVXABWARmRrnxW1zc3cTUK5MJLvTPBfVrcyB2b9l59TzgbhwWQt4q4
	h5hPiW1ZLGAzgT7w0fq32TuIV1R904teri/8sZ2Vs6SHioPNxZlmBe8I3I+72CN0XmxDRiVcLz4
	QiEa2tJ96wzcpTI2l4m3GlaHLkyoW7oK9vBffi48JBYT/dC9v9pT3/dTV0YvTQ==
X-Received: by 2002:a05:620a:8399:b0:7c5:4147:bd2 with SMTP id af79cd13be357-7c55eee86famr538354285a.15.1741705824568;
        Tue, 11 Mar 2025 08:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG+YTrdakBVNbURXSBwemJBviHEvSKu6PP1aPXAK59tAzIZqh/c6bXA7okUTbxXTNZ7MHeLw==
X-Received: by 2002:a05:620a:8399:b0:7c5:4147:bd2 with SMTP id af79cd13be357-7c55eee86famr538351085a.15.1741705824291;
        Tue, 11 Mar 2025 08:10:24 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54c54f384sm415455385a.115.2025.03.11.08.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:10:23 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9d8dd342-4c88-4d4c-96c2-d6fa489a2de1@redhat.com>
Date: Tue, 11 Mar 2025 11:10:23 -0400
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


