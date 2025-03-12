Return-Path: <linux-kernel+bounces-557841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5D5A5DE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B077AC76E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67D62459D0;
	Wed, 12 Mar 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxHZS0sN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F53B23E33E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787727; cv=none; b=lQthRNdYJi+4eb8yIigFO55dtZESBj+/7Vm95jjIw0r5yLfoGPj1ucyMF4h6JkRhiES3NW/c9tzZKgE17Og8CUNqGLdjuMvngHOKSjh6pleXLbhL/olVO94QBs8KbcwUNaQ5sGyqWdYFGfwokKiWJoseEzql/YpR+l5SjR2ooHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787727; c=relaxed/simple;
	bh=waGX/WbcYLhodDWdtv3u8VXnMMJPTcIh3lEekoxXXw8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hxix9+VI+rOXMu4Wgvl6L0Tx6be92+uiV+C5x2KTl+iezOE9GWXO8KaDFyogrRb8NuHpu/6UGjIJDduHK28orW5WLAHDjhqan8GwsUgVFd3scGSPko5tS8iooSoka2R6akIDC8nQlv7CrzUX2sgm1CPeR4s1JitfLqj3H7YJ4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxHZS0sN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741787724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beEL7oKIoj4c6NMjJCD6NPtHJyw6jjIiKvhBkjkgQJI=;
	b=PxHZS0sN9QaWyuaU2ki2sQzBnD1o6HZl7BTR6RMaerDsRV0gJnNtnJ4huw1e3cGuKECiZ+
	u7NbZNJaPIa7jAFGeUVOaAWFw+kONLEwStZhQQw8ndlgxDWwuYAYs0s4QE1p7F2STdBCZk
	yiu//7XRgVb4mwE/i6otX7+UzhWM+PU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-BeWOlqTaObmQ890N7Vfxzw-1; Wed, 12 Mar 2025 09:55:22 -0400
X-MC-Unique: BeWOlqTaObmQ890N7Vfxzw-1
X-Mimecast-MFC-AGG-ID: BeWOlqTaObmQ890N7Vfxzw_1741787722
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8ed78717eso111093996d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741787722; x=1742392522;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beEL7oKIoj4c6NMjJCD6NPtHJyw6jjIiKvhBkjkgQJI=;
        b=alZJ0YqgIYg7sSsD3ZBjd/NEzekMOLVlqsiv4t2gDmAE8RdQy/ZHKpTk4iLKbWQLyO
         sNcmrsXodJipkNs2fVLIhoRWmqYTHrDDdbojx/No2pjhIvk7If4tRRRvpsHK8rxQ5IAK
         hLJDnSqOr5ikbdughg9SleT/Mdon6cuCVLZBwmkmvF2R1CI1fp1HaGc4VMpv6pcqZyO8
         b5KatmJoqf8hKKZ+QNMJMBEAkEqNvQkHBEFp6GD+6pZ/IX8Pk0K1t6jXZxMh3g5oKGjq
         wLuDWD+xV6EXF0KOMaAsVuD4bm0GnvYdulBrI+g9LvP1SCH41eBnbUdpokV2I22PqhPw
         22IA==
X-Forwarded-Encrypted: i=1; AJvYcCVni0L4L8cRinqbiHis2G97XemM2PVd4bXS7f2rUZDH4uqLBVponhiAHTcOfptFeD06r4RgdR3q+CPgAas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Qz3gBkEYWEwtQWGeFGFA1jK+6LwHO9sUeUWOtWubP7IHrU4q
	xbTPlQKrcQI9BFTfgbeR5Yo5wv4kkiT6++Dd8SvP0elY1iPSLFk/Ehta+b4MoFuheRrbvYNH8Oj
	hJ78r3v3LJPiItgCU1kme+UKCUlIYDXnIU1BWhs+fMjS+TQGc02ubuz1ccx+Qvg==
X-Gm-Gg: ASbGncsnX7J3PVb48st4F267VgL1IWhWJg3qaVP66Bdx6komZaQGDrEHGeKdq1OBa1+
	G4LC7bqkhcjEy/JrJxqfGA5oyXZ3e3J1jTQweJ8J8vzQz+Xpczo0CxLpCbRBxWI7r9AC75YBavO
	uU8jAjeQearw/UCjRMeOpPyUfht72qUVGdvxTNkjLc2UkkWcrSIvjHr2PTRBoskE2j0ICNyea+V
	hryRcqaKSiZZGGr/mXzZI3n43F+Cl7/2U4kcD8DZZ+oJ1RLzjWj6c7jUQByTUwl/AcHn4Z2HTGE
	mOMXkk1VlLfdaISIM6oW99cx+maYpvcQDB+A8UzDM6vp31u3QJuTiApcPUa9xg==
X-Received: by 2002:a05:6214:2a8a:b0:6d8:b3a7:75a5 with SMTP id 6a1803df08f44-6ea3a6a652cmr90592616d6.42.1741787722400;
        Wed, 12 Mar 2025 06:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcHl07t33fQl/ulieOA+NEsEZUKtE90Y0FLOq+2nBxlUUr7PD4+hO+Dx0rMwUoCKeYdoMyow==
X-Received: by 2002:a05:6214:2a8a:b0:6d8:b3a7:75a5 with SMTP id 6a1803df08f44-6ea3a6a652cmr90592256d6.42.1741787722078;
        Wed, 12 Mar 2025 06:55:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f71709b9sm84932156d6.115.2025.03.12.06.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 06:55:21 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d38df868-bc65-4186-8ce4-12d8f37a16b5@redhat.com>
Date: Wed, 12 Mar 2025 09:55:20 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
To: Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
 <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
 <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
 <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
 <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
 <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
 <7fb20de6-46a6-4e87-932e-dfc915fff3dc@redhat.com>
 <724e00ea-eb27-46f1-acc3-465c04ffc84d@arm.com>
 <Z9FdWZsiI9riBImL@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <Z9FdWZsiI9riBImL@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 6:09 AM, Juri Lelli wrote:
> On 12/03/25 10:53, Dietmar Eggemann wrote:
>> On 11/03/2025 15:51, Waiman Long wrote:
> ...
>
>>> You are right. cpuhp_tasks_frozen will be set in the suspend/resume
>>> case. In that case, we do need to add a cpuset helper to acquire the
>>> cpuset_mutex. A test patch as follows (no testing done yet):
> ...
>
>> This seems to work.
> Thanks for testing!
>
> Waiman, how do you like to proceed. Separate patch (in this case can you
> please send me that with changelog etc.) or incorporate your changes
> into my original patch and possibly, if you like, add Co-authored-by?
I think it will be better to merge into a single patch to avoid having a 
broken patch. It is up to you if you want me as a co-author. I don't 
really mind.
>
>> But what about a !CONFIG_CPUSETS build. In this case we won't have
>> this DL accounting update during suspend/resume since
>> dl_rebuild_rd_accounting() is empty.
> I unfortunately very much suspect !CPUSETS accounting is broken. But if
> that is indeed the case, it has been broken for a while. :(
Without CONFIG_CPUSETS, there will be one and only one global sched 
domain. Will this still be a problem?
>
> Will need to double check that, but I would probably do it later on
> separated from this set that at least seems to cure the most common
> cases. What do people think?

I am not aware of any distros without setting CONFIG_CPUSETS. So it is 
mostly a theoretical problem if there is one. So I would recommend going 
ahead with the current patch series instead of spending more time 
investigating this issue.

Cheers,
Longman


