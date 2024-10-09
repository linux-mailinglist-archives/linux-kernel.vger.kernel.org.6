Return-Path: <linux-kernel+bounces-357136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A0996C40
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7A91F22025
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01D8198E61;
	Wed,  9 Oct 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cx4zIR+/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534727462
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480957; cv=none; b=qzxLM88zJzYSmlldygZfl0iNvbasn28N/YMdqJXT7EEftr1U+hDTqK7bU5vNABH4CA04q8ZPzNtGk8+HSOY3mP0Ixk3JHhD11z0eZ0GXqprjep3F+f6oOEKGl+9KRJPjEhEaywFD6fUAfMFQvna29Zohr+/2p7vLU0ni6IWGrKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480957; c=relaxed/simple;
	bh=LTn9Q1UNSWj7OlHWyAZrNKUkL9Mk+IyYUH2jvXbnwFE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UfRvp+mCe1xK4VEhZnBzi9oH1odAjTbKhSbIdLgtL5bVt10cGlPC8o398vWlKFctUHYs6qo0sJIpoJFimQ8buzxIUQzR9w7XSHnrC+ZMirewx7LvyjrI2GPD9HM/mEfiJSoeBSjGooX8iVqg+oPONBgDoOZX+Eb6clZ+goCsrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cx4zIR+/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728480954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJQzvy49Hn1kMmcTf5nPqycKWVWVnY3L+6/8l4CtbzQ=;
	b=Cx4zIR+/UKSCqDQ+vUuxgHhDseLUROHLtLrF6nN23y3blqQkr6WtX6MXY1Ivr/JSaOF1nK
	jyc9TrNNF1eUwkszcgrNWEOebnwlsK1AfNNpYtNVu16C83ymNyuIT8jN3dSZ0Q0DC6umIT
	hhiA3cKc+0dPnLxrhL6CJEsNw8qkyRM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-ivqIbnzzPNiZ_K9J8oecww-1; Wed, 09 Oct 2024 09:35:53 -0400
X-MC-Unique: ivqIbnzzPNiZ_K9J8oecww-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e291d608feso1279453a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 06:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728480952; x=1729085752;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJQzvy49Hn1kMmcTf5nPqycKWVWVnY3L+6/8l4CtbzQ=;
        b=sdhxWAHQ8U9DbhxFft4ZuOR2qQ+v5ViN9kwXUx02FaGvOa7IoiaaGrBmrfeWq76az8
         lyhJkw3QFmVh+9jJ0r162s5r3bvuUFO/bHXNCiP7IQEOlG4PzigRsWwPu0SasGCVtacg
         tS6HhZ+cf2PMee9/QJXjT983dH4ht/D2Z2/rgn2R/00dhMkVeLZ3Z0P5XbjVd9qyBSMe
         VqPWXmhN+DJB+PaAr0GfJPz/nXc68chQ3R5OhG6/YMrCZpbbcMfESj8Mp7AGP3Bd9DiW
         zkkwTj7pMSRyz4oMB1YIevh0SWYTgDNu1UcubT5zmfcn2M1IzMsTLuyDEriwgJZeNfiF
         S3+g==
X-Gm-Message-State: AOJu0YypHHN6yKK1Q4+udBexr3QPGpb33JYCwapsVVRs/SpQX0Hp/TOw
	/CsYMPE6lCzysBqYP/az+Dkj6rL4XPsrYDQDs7bg6fEPzlLGr2mQkVqJp6+flNHUJ7LTZ1Q8UWI
	RXXPGsslJCDbBjcvY7pInXFtnz1FyDKOeQtDHaupVfhX6YuEjBLZD74LrHlfWUg==
X-Received: by 2002:a17:90a:e518:b0:2da:505e:77ad with SMTP id 98e67ed59e1d1-2e2a22e5140mr2795634a91.6.1728480951949;
        Wed, 09 Oct 2024 06:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlF5Zvq2yt8/Ei5PZUf7UA6Z2KNSSSvIfcbnTnbi53v9SI3VdTdEvm/KwCcTzr5zQztIcCPg==
X-Received: by 2002:a17:90a:e518:b0:2da:505e:77ad with SMTP id 98e67ed59e1d1-2e2a22e5140mr2795615a91.6.1728480951607;
        Wed, 09 Oct 2024 06:35:51 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a55f9855sm1649695a91.2.2024.10.09.06.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 06:35:51 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ea3ebd17-981f-4269-aa22-a4ca31be335c@redhat.com>
Date: Wed, 9 Oct 2024 09:35:48 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] sched: Miscellaneous isolation related cleanups
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
References: <20240921190720.106195-1-longman@redhat.com>
Content-Language: en-US
In-Reply-To: <20240921190720.106195-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/24 3:07 PM, Waiman Long wrote:
>   v4:
>    - Make "isolcpus=nohz" equivalent to "nohz_full" as suggested by
>      Federic.
>    - Update the scheduler code to use HK_TYPE_KERNEL_NOISE.
>
>   v3:
>    - Fix incorrect housekeeping_nohz_full_setup() flags setting.
>
>   v2:
>    - Remove HK_TYPE_SCHED and related dead code
>    - Change consolidated name from HK_TYPE_NOHZ_FULL to
>      HK_TYPE_KERNEL_NOSISE as suggested by Frederic and update
>      isolation.c as well.
>
> This series contains a number of miscellaneous sched/isolation related
> cleanups. Other than reducing the number of cpumasks in the housekeeping
> structure, there should be no other functional change.
>
> [v1] https://lore.kernel.org/lkml/20240818234520.90186-1-longman@redhat.com/
> [v2] https://lore.kernel.org/lkml/20240904171441.1048072-1-longman@redhat.com/
> [v3] https://lore.kernel.org/lkml/20240904183650.1053708-1-longman@redhat.com/
>
> Waiman Long (4):
>    sched/core: Remove HK_TYPE_SCHED
>    sched/isolation: Make "isolcpus=nohz" equivalent to "nohz_full"
>    sched/isolation: Consolidate housekeeping cpumasks that are always
>      identical
>    sched: Unify HK_TYPE_{TIMER|TICK|MISC} to HK_TYPE_KERNEL_NOISE
>
>   .../admin-guide/kernel-parameters.txt         |  4 +++-
>   include/linux/sched/isolation.h               | 21 +++++++++++-------
>   kernel/sched/core.c                           | 12 +++++-----
>   kernel/sched/fair.c                           | 19 +++-------------
>   kernel/sched/isolation.c                      | 22 ++++++++-----------
>   5 files changed, 34 insertions(+), 44 deletions(-)
>
Peter, are you fine with the changes in this series? I got the acks from 
Frederic, but I haven't receive any comments after that.

Thanks,
Longman


