Return-Path: <linux-kernel+bounces-557808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5ABA5DE14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369001897357
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FFB24DFFD;
	Wed, 12 Mar 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avRbP0H0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB88D24BBEB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786371; cv=none; b=RBPObbsWHAFvurYsjG7RQuhHPUosI9x7UXVP+3+a34TqOVmWVRcHNSC87e9B4lEb7KYO02NDiEJdzNZUiWuHCo9I9HikFNkfBe8eB8rKnvu0TwPWacb7dqx9+3kWbxSFCMsW7smmLNu8yjUiKCK8JS5J0e87svhIXAdVZR7x5kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786371; c=relaxed/simple;
	bh=eaxjNYEh/ReLHdudkyVWfol8j9QiEcSwf1FRBYDA1Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=By8uQnHEtr1KNA6sqpmg7me2WxDLQxQwX13gkvB+l5/Ha3FTbRIJimxbTS0BzLoB2YtHl9ychbwNpyBV1llWr/gxUd9GQF4gBGwOTaW6MygEJdUbQvOu0JB4FmphsBF5K+xHn1/PPdQWAAdUi0mhwZHNxz59XlyHClK+5pGAU5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avRbP0H0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741786368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eaxjNYEh/ReLHdudkyVWfol8j9QiEcSwf1FRBYDA1Cs=;
	b=avRbP0H08GRuRBQGJj4fLBcDlD2k/OuSD3pWVSOpOi8CLoO4aWXIXrBDP+6j5nXsfyal5F
	0KIpezcUNtMgqtPXPcWei+bGwYGU7r6tsP04V4yk24j7RbkaYk1jXH3mlGn21pFMTaYDDk
	wsyoZGIJ7+P20zF+WbOdMzVtEGrz9rI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-6kicWKplPWyL8yAYmOmJBg-1; Wed, 12 Mar 2025 09:32:44 -0400
X-MC-Unique: 6kicWKplPWyL8yAYmOmJBg-1
X-Mimecast-MFC-AGG-ID: 6kicWKplPWyL8yAYmOmJBg_1741786358
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso47372615e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741786358; x=1742391158;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaxjNYEh/ReLHdudkyVWfol8j9QiEcSwf1FRBYDA1Cs=;
        b=w/hQHG4DkrlmrGTqq2K7sq2RVENdMZxmHYnSnillFZpPsMpQ9NxDfHTQXNUlgQ05z0
         A7HSTkQV7nB3JhsEo3iQ7pscDgNdahTAlIleywB3AiKhgd1oqHBXRSnxg2hbKHqgYo/g
         OD+wqZT6oI5tJT53AXaCUxrMa6PNg1u+gGHGMRkqQmqql304xxsCU5XCDihGuVR+SsBG
         5qktQyazbWlSEbY7wUyLTAMvBZzRNm50/S60A7vYLxuQhbao576bD6NwROsD8hXorgMy
         LqpgxKJGPbxJO6nzA7TD5qm6oCHn86l3uJjUczgwgJRTHGyyFJpKpywTGZNGVj+V1/6H
         +oug==
X-Forwarded-Encrypted: i=1; AJvYcCVoSo1KmJkH24+dJ0lQKd7l69yUVf7ID7P8NLviwNXU8f1RZJ5cZJuR7B37QcC+kkz6NDxXXB1yLwjnVmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3bFd7HUwIYej3m3lpfTdNFz9Dqidyr+ccu7jYlagepQRHGoXq
	oboKisjLqWWnks7Q/Uoa5LikgWx53NiQFUUP5+MfPL93IDE7LUSIwYOiDv9twKRVy5snnRmpRdE
	h9h9Xu9rotUr/TEEIFooiN3jOMGcIld7cGQPEvnsf3uovpC0pWKS1dfbmSdr/Gg==
X-Gm-Gg: ASbGncubsOIawqQaJyV7py+P+r7ibD9oL5JR8Cf2A5lukO0GaoLcuEywPGvq0gsmleR
	jP8/iIrAKu+E51A/CYXxf3LKE3CHsDK8XrQDUg9d4LaBcnJ7jixhcK2Dw7k4Rnl9kRc9XBH5IZL
	7dsoNl1Yk391/IwdEaLLVN4Qucr58EM/IuLOpMccoDEcSmSZ3iC9TXR4Hh8Qvh7CMQdiZ45VC3J
	KBFas3wVJEAC2hQVMu/5zikU/ZexlrFTqPPzp5INTW2CO5gIE81T4HFcl/SHtLCwn/jQBBqIT7j
	PfeOMYF3ISO3p8wd9cGvS9Jq+/XVqsrdndL0Hn62kabcuR656OTN0QANGuHjh1jYwG+tVIh/97V
	a
X-Received: by 2002:a05:600c:4f90:b0:43d:fa:1f9a with SMTP id 5b1f17b1804b1-43d01c22acfmr89314275e9.30.1741786357935;
        Wed, 12 Mar 2025 06:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj/lv00k6O8Z7XqtZVfKnJqf26Eyg9PRGsqMCVAjmTJ26v/rbB0hCn9t0vfRo/tY47QmKkLA==
X-Received: by 2002:a05:600c:4f90:b0:43d:fa:1f9a with SMTP id 5b1f17b1804b1-43d01c22acfmr89313885e9.30.1741786357539;
        Wed, 12 Mar 2025 06:32:37 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8c5d04sm22057175e9.27.2025.03.12.06.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:32:37 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Waiman Long
 <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef
 <qyousef@layalina.io>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it, Jon Hunter
 <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 7/8] sched/topology: Stop exposing
 partition_sched_domains_locked
In-Reply-To: <Z86zci-kj6kNBl8I@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86zci-kj6kNBl8I@jlelli-thinkpadt14gen4.remote.csb>
Date: Wed, 12 Mar 2025 14:32:36 +0100
Message-ID: <xhsmhjz8upe6j.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/03/25 10:40, Juri Lelli wrote:
> The are no callers of partition_sched_domains_locked() outside
> topology.c.
>
> Stop exposing such function.
>
> Suggested-by: Waiman Long <llong@redhat.com>
> Tested-by: Waiman Long <longman@redhat.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


