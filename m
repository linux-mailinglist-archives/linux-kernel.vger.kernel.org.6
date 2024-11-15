Return-Path: <linux-kernel+bounces-411421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE5A9CF91C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1331F229B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9B1FF054;
	Fri, 15 Nov 2024 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbNCqz4a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A8D18C03E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706631; cv=none; b=I644ZvVrsTzwKiMwB4Qd0NiRqWip+a95rGtHfu3d9ViJLPTLTL9WVTg8A4CJC/xZxLcJQ8NLjYJz79S2lXDcoCmvn5QU+R8yUU/kjdUjj8BcyAcHi1q2OgVn+1gpkS5zsmYv6ThH0ni5T8nekdBjRBkXJbUuTTNMNwzDfnL/S08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706631; c=relaxed/simple;
	bh=Oeuk4NT8mGLS78CfxbKlyUY850mOCryg7B/6qGI60DI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cJrDUpcPaWGnfXsbf2a4UaYeMEz4RE8dVpE+TBihjhrc+KElna31HQbzj6DWLfL+18Us6gvMuiFkc6+G6P6FXEidgg8qN2KAGqTg3zJC5ljxz3FyNamwcac9+h7ugFY1dGOCAd1nhxxhJmK3EvZghfWBs18zd20unWHCdurSjjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbNCqz4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731706628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ivw2cPuuJQRwyJNSHiIw+Pyk/jnELW2tJEH2/eI89rI=;
	b=JbNCqz4am0kknk+bQhGkXrktRQq+nhveVKVAv8KHsiOcWipstriZ1zBFqzHORmXm+64VAi
	rleSPj0Kst1DmYmJXw00y0AutVpk9T0kTGEfgl3Q89VY68bjtUGFDfOZBihzMWDsQc5SYG
	1iiXZYrC/+03zMv/iH+thrHpFKiDFKU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-n2GgCxStPhKkf7myOkNHEA-1; Fri, 15 Nov 2024 16:37:05 -0500
X-MC-Unique: n2GgCxStPhKkf7myOkNHEA-1
X-Mimecast-MFC-AGG-ID: n2GgCxStPhKkf7myOkNHEA
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d407522108so9186796d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731706625; x=1732311425;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivw2cPuuJQRwyJNSHiIw+Pyk/jnELW2tJEH2/eI89rI=;
        b=EmAs9+Gwyn+R/myPwcR32tDISbxmfAM8htQwEsOlfLl1Tjhe1iUMcI8XBeP3w2VU4a
         wJzcMTGuHX54/t1NTz8MJ2Igko/S+yVOlH4NYZ/R0bBnhLvSGrkGhuMvvqnSlUAmKBl9
         Inn6+q9x7EJybNnUvj6juwrHtGbxyIIDJ6nhN7jXf/N5RFxcXqxtjZMciACRqJiIDukI
         csmgGkxVBDEea2+fXbZfDw6UdJUPWKzV5RKtLUoLgSTDNJv1miZjUlaIGRsgSkjeoxxl
         iVGlpCGk7rejIUMyRncRuoX2jOnc2Ca+PLZt464/kGUIijA4cuw+FPh9vv/FFSYrEPvZ
         3t2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8td0hamvR4B8KaysRUrduJTnrhU1idGM946bDZT42ndILVuYIuYAW1xBv8CiD5HXTFhw8HOAclwZ9YE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/yED/Kkcrs840QOVGSyYOHizFKKLci2MzgxbME74p8tUztvDo
	QYUR06QOb3QgNnTEVvl6gQT8hFvI4qoDUFY1Ijvcui5sM9Y3baxBiteYLZWHBaRQKCU2jp/eSAj
	4+/OL8nAqXmRkHAGGLyOouW8rs40CndzCDurGh9+l3MwPDhexmTHpo/5U18Oeww==
X-Received: by 2002:a05:6214:5690:b0:6d3:f984:1a82 with SMTP id 6a1803df08f44-6d3fb858e8bmr57294556d6.31.1731706624178;
        Fri, 15 Nov 2024 13:37:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXgGPocZvxQ5d5NSN9sIHyVoelbF9oeCyFH1sagwzbxZngNT5v49ggcBb3EADnzAeGx3RMzg==
X-Received: by 2002:a05:6214:5690:b0:6d3:f984:1a82 with SMTP id 6a1803df08f44-6d3fb858e8bmr57293356d6.31.1731706622468;
        Fri, 15 Nov 2024 13:37:02 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984691sm203656085a.2.2024.11.15.13.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 13:37:01 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <67e8e089-4df2-4175-851a-4b49b964eca4@redhat.com>
Date: Fri, 15 Nov 2024 16:37:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] blk-mq: isolate CPUs from hctx
To: Costa Shulyupin <costa.shul@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: ming.lei@redhat.com, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
References: <20241108054831.2094883-3-costa.shul@redhat.com>
 <qlq56cpm5enxoevqstziz7hxp5lqgs74zl2ohv4shynasxuho6@xb5hk5cunhfn>
 <CADDUTFwYKjbPnzdzQA0ZjW4w3pHBsoZBQ6Ua5QbFp=X2-GfGtQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CADDUTFwYKjbPnzdzQA0ZjW4w3pHBsoZBQ6Ua5QbFp=X2-GfGtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/15/24 3:25 PM, Costa Shulyupin wrote:
> Hello Michal.
>
> Isolation of CPUs from blk_mq_hw_ctx during boot is already handled on
> call hierarchy:
> ...
>          nvme_probe()
>                  nvme_alloc_admin_tag_set()
>                          blk_mq_alloc_queue()
>                                  blk_mq_init_allocated_queue()
>                                          blk_mq_map_swqueue()
>
> blk_mq_map_swqueue() performs:
> for_each_cpu(cpu, hctx->cpumask) {
>          if (cpu_is_isolated(cpu))
>                  cpumask_clear_cpu(cpu, hctx->cpumask);
> }
>
> static inline bool cpu_is_isolated(int cpu)
> {
>          return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
>                  !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
>                 cpuset_cpu_is_isolated(cpu);
> }

cpuset_cpu_is_isolated() can be removed once the cpumasks can be changed 
dynamically.

Cheers,
Longman


