Return-Path: <linux-kernel+bounces-411124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1DE9CF362
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8216285EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C701D61A3;
	Fri, 15 Nov 2024 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM1NEdwj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BCB1D63DA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693356; cv=none; b=f3feP10CCwbsIzTQ1XixvKJlCsCL3iWRxdzlZWff7ndex/u1zBaC0aTvzv9nWpPE6u8squ/HHg1YyCNzUIeXrq4hU2WdPiq8D78exDPOC7cU4DvPkzGxohqKEN78PxIo894UwfYb7zWjmz8+eiTno669kYHrMLxSCL9EbB2FHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693356; c=relaxed/simple;
	bh=1UudV+Y/O2DT7CczE3lBShqjb8KX6ZN8X1AlHzhl9Bs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aXLNQ1O8v4iBHdZrMr3H+vEwzfzj7itKTE8WA8pHk35x0jcRDwlXBV44OyaT7nzKa1Y2x6lthQvrWKxf74LmQynvoZLug6ZtEtylJZHi0wnSMUzSzV6IrLXrPCUfZH+MPKidND6Zqv9x7fc2ptXqdbAaAia7qOPDVhDFMJ1czzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LM1NEdwj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731693353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZ9g+prF726DXSyYrdVv/0vVba01Lxcn9IJr7aD26Os=;
	b=LM1NEdwjotbROG9W66wAkAY2BUEcObCe3O2NyB4rhDbYqfY0H7O2rrxFmvSUrLCro24mtZ
	aXfBYm+oyokGZUAjhcsVClk3pVhZionQsLXJjAozAb9L42CeqUDhKnvlWjXGBWXOhW6dyz
	eeOSDzBSxOtEdE8DZnibiJSBUcT1VbU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-kihfwhFHPeiwmOUJPT5KSg-1; Fri, 15 Nov 2024 12:55:51 -0500
X-MC-Unique: kihfwhFHPeiwmOUJPT5KSg-1
X-Mimecast-MFC-AGG-ID: kihfwhFHPeiwmOUJPT5KSg
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e293150c2c6so1607855276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731693351; x=1732298151;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ9g+prF726DXSyYrdVv/0vVba01Lxcn9IJr7aD26Os=;
        b=T48NymOrpDvvLTWWR+dzaRhoPQAmkFmSYeFMWqQ57ky08WR1yE+MUCLAWWcMpMV3g6
         cBGfospBAb3thQn5GElhdAVE8QyBHDbn1Wqc4D1vFhXc6/nIJvoxIgGaouUXHewGcsuc
         Z7G/ZqW91iTuZEmQt2vB2RsJ4YTx0WJ/uWUxPQtyzwnEzIPutuY3YfeLbTKK9oYmHxRG
         FqxYtJiLP34AiZz9d4X8Q0nrXVCJvm7h60UHpej8f1a6sdAPTiga9WkM0MBOeFsSinWH
         39s8VbsCye5iaOyONTQDGUCXG57ef0IIOephcwxyX5+CDZdUBp9XEEgfOj6sCTyhNDY2
         iikA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+9PxS+UCqR4Y/CBj8bScP7Jn6flcj3zMUQBSJH7ptj6w0q/sSOVMLlw95+3hRnNufOWkRamBhuDpzNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbXc3QcJBD7ATekbKAttNHvniEEoywjdzEzL9HGvGMYAENN4Tw
	0YXFP94WB36GYWT4QTo5S4F8HIBjy6ktS3GD/IFMfCnGTmr9H4afoAC+WPRDgWBJc8Gq0D6+L2l
	SQhS47t9zSmu34aVO9nvyEYGW5uSef3KgSRvINNrQYw7fmPxpEGLw4vm0mFECdQ==
X-Received: by 2002:a05:6902:c09:b0:e2b:ad82:e592 with SMTP id 3f1490d57ef6-e382639f2f9mr4089038276.36.1731693351360;
        Fri, 15 Nov 2024 09:55:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+1QWTBBsRsnWD7xEyBA7Byqtsr7Ze3dfkac9aauUWeB34a97OMqiAOUbZh5+RbEF8hgYARw==
X-Received: by 2002:a05:6902:c09:b0:e2b:ad82:e592 with SMTP id 3f1490d57ef6-e382639f2f9mr4089016276.36.1731693351000;
        Fri, 15 Nov 2024 09:55:51 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3f5b4f2aasm17482756d6.104.2024.11.15.09.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 09:55:50 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1515c439-32ef-4aee-9f69-c5af1fca79e3@redhat.com>
Date: Fri, 15 Nov 2024 12:55:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test
 if not load balancing
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
References: <20241114181915.142894-1-longman@redhat.com>
 <ZzcoZj90XeYj3TzG@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <ZzcoZj90XeYj3TzG@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 5:54 AM, Juri Lelli wrote:
> Hi Waiman,
>
> On 14/11/24 13:19, Waiman Long wrote:
>> With some recent proposed changes [1] in the deadline server code,
>> it has caused a test failure in test_cpuset_prs.sh when a change
>> is being made to an isolated partition. This is due to failing
>> the cpuset_cpumask_can_shrink() check for SCHED_DEADLINE tasks at
>> validate_change().
> What sort of change is being made to that isolated partition? Which test
> is failing from the test_cpuset_prs.sh collection? Asking because I now
> see "All tests PASSED" running that locally (with all my 3 patches on
> top of cgroup/for-6.13 w/o this last patch from you).

The failing test isn't an isolated partition. The actual test failure is

Test TEST_MATRIX[62] failed result check!
C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 . . X5 . . 0 
A1:0-4,A2:1-4,A3:2-4 A1:P0,A2:P-2,A3:P-1

In this particular case, cgroup A3 has the following setting before the 
X5 operation.

A1/A2/A3/cpuset.cpus: 2-4
A1/A2/A3/cpuset.cpus.exclusive: 4
A1/A2/A3/cpuset.cpus.effective: 4
A1/A2/A3/cpuset.cpus.exclusive.effective: 4
A1/A2/A3/cpuset.cpus.partition: root

I believe this is fixed by my other change in the commit to change 
arguments of cpuset_cpumask_can_shrink() to use effective_cpus instead 
as cpus_allowed may not represent what CPUs are currently used in the 
partition.

Cheers,
Longman


