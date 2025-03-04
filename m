Return-Path: <linux-kernel+bounces-545195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321FBA4EA32
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE4C188BFE4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219132063E9;
	Tue,  4 Mar 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ks5bRvIu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C99293450
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109622; cv=none; b=nrkP28xsUxoDHFJIjROGIl31hX+2TZR44fRQzAHq4HskivD2E1CP74IcgwyAM4prIFIbIMinRsoYgsBN57F/td5gx4DuqWqMaJFYfUA+egKC9VXnF78/X7lT8G9XspCXATn8QMO/j8A8qUCgXhcU+y10phHMG+TdfveRa9/N4fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109622; c=relaxed/simple;
	bh=bNdSqKlXHjCnildLaWJjGpSWWKI5F2WeOXv0PLvCCFg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MZV3AgfZ/+RuRdcIAjF724w/Nh2hE2hHaJqjJvTXTKQVQWMC0z7+a+gb/y4uxU6epi/DFYfKktph94edSaVd9fxg72X04OOGvnuG9KoAHuc03gKezVV2Ku57zBAmUu+TD9r3qVRmqTOwKvjUP9vMSqKc5YtK+o2zluAA3+hLfis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ks5bRvIu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741109619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/gloNWENauCZr2RKyu+Q4jT9a16xZQ906Rg5zjtKlo=;
	b=Ks5bRvIuhBSJwOvd0n3BSokEM+EHNmj4gRM1arzGzcfsI4a3ye7yhyRERMLqTuqm7VQd8T
	F/D4b8DtwNK2gJUqNCs3K7+VM33+HiegzQDzzGat+SyNwGV/+HRWs93ppgmpzRGhbMLDEy
	UJN+sVzCmyaAIvo88GRJkyN2aiM/uNM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-yqvgT-3uMset1TUnGmCiOw-1; Tue, 04 Mar 2025 12:33:36 -0500
X-MC-Unique: yqvgT-3uMset1TUnGmCiOw-1
X-Mimecast-MFC-AGG-ID: yqvgT-3uMset1TUnGmCiOw_1741109614
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c3b6450ed8so439858885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109614; x=1741714414;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/gloNWENauCZr2RKyu+Q4jT9a16xZQ906Rg5zjtKlo=;
        b=a6yo93L5Gjdd1ItR80XCuGpTJZPo50iTYlqCu2PDbOqcnAWTiRgX1ZWrpGZaawz2Af
         urOf8bwAsMhAGlupls73suahyzyJh+t4nGtiq0AgG8OVL35Xya01ZtTiyXmRhQnN6YGU
         +iPGdZUdqFJGBRVpasKZrYORkHrw65KAXHYUvZoL8BBXFGw18dYRK6vBVZmBGk+cYl/G
         rW2pHk+hDjbrF/kgo/WAm0gP4PBoU7qPGoVlIG5Xm+KnlsikE4qA+mgeEgsjXR1WW12z
         GNz9isV9GS+F2SiCNZEWDIYecNX6JGBr4AmT5rHOBW+YbHzRn5wiwltyQBKqutXji7Bz
         wQCw==
X-Forwarded-Encrypted: i=1; AJvYcCXcipuQH1S+SnesuhKX0vT+Vr6IOj02GrOSPCiKMA74ltcUdW2meGdIlrPKk8qXElnTk1zTflnsbS+UdbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2R0g9hdP7XtJ+BK6CY3eL0EWOqZ288GTPv4MjSJ7aqGep0cE
	ioNyg0IWXETGwCXpJ1YG7y3ORtUIQ/Y9JPV+r2Dx0FQxsiQ8ekqPWP8j9AcppruBwhrwnkLK691
	zzSPSd+eG08CUsBiAWAYznTTC257c2ACuWglDnjeB2LupPIg6KxCrZ/EJUUb2hA==
X-Gm-Gg: ASbGncsNl2OF+X8vfL3DH4WFmMjR2nlL+8JiPZh4dd4raYL+G6yly3nFJw7heJcD/0u
	wZX3I3sp2vFvPsVgiWWXMI0TpzEtGPqVNkhqZ+dS/oJMR5bBkAd4GH8x3bSApZK7VHZzTKeLeYM
	kCoFDHDFRqIuTUiKe/N0vvLiCfq0Z5TM5fjI1N4n5wqijC1wf9bTCBGLbEObsuiMw7C6PNp21vP
	uhre4QhMoy+SYliuI7ZYa1T2UbiAf6zEjX8YMikBc3YaOcsDA9VNsmj0ftPXzDj/hz33OPjp/Hx
	26CGC2Fn3YKGZmXdz2KXA5hkHlMPmMbmP8reEwRgvarW/3TclkyPD16GrCY=
X-Received: by 2002:a05:620a:8908:b0:7c0:b523:e1b6 with SMTP id af79cd13be357-7c3d8e15ce7mr23061685a.11.1741109614491;
        Tue, 04 Mar 2025 09:33:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmWg+hzZenzZ4mRN1NfTFISPU5M4QS3jH+9tCASNEau0B50X9pJfy2Hegsf7Yzo9avT0yhxQ==
X-Received: by 2002:a05:620a:8908:b0:7c0:b523:e1b6 with SMTP id af79cd13be357-7c3d8e15ce7mr23057985a.11.1741109614183;
        Tue, 04 Mar 2025 09:33:34 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fef4bbasm768017685a.40.2025.03.04.09.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:33:33 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <123839ed-f607-4374-800a-4411e87ef845@redhat.com>
Date: Tue, 4 Mar 2025 12:33:32 -0500
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
 Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-2-mkoutny@suse.com>
 <8b8f0f99-6d42-4c6f-9c43-d0224bdedf9e@redhat.com>
 <Z8cv2akQ_RY4uKQa@slm.duckdns.org>
 <n2ygi7m53y5y4dx5tjxhqgzqtgs5sisdi27sk7x2xjngpxenod@7behfsvlzhxi>
Content-Language: en-US
In-Reply-To: <n2ygi7m53y5y4dx5tjxhqgzqtgs5sisdi27sk7x2xjngpxenod@7behfsvlzhxi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/4/25 12:10 PM, Michal Koutný wrote:
> On Tue, Mar 04, 2025 at 06:52:41AM -1000, Tejun Heo <tj@kernel.org> wrote:
>> On Tue, Mar 04, 2025 at 11:19:00AM -0500, Waiman Long wrote:
>> ...
>>> I do have some concern with the use of pr_warn*() because some users may
>>> attempt to use the panic_on_warn command line option.
>> Yeah, let's print these as info.
> The intention is _not_ to cause panic by any of this this.
> Note the difference between WARN() and pr_warn() (only the former
> panics).
> Warn level has precedent in mm/memcontrol-v1.c already.

I think you are right. The pr_warn() function should not cause a panic. 
I have the misconception that pr_warn() will be affected by 
panic_on_warn before. In that case, I have no objection to use pr_warn().

Thanks,
Longman


