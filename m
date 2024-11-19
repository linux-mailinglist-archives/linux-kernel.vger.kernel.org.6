Return-Path: <linux-kernel+bounces-413795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 036F29D1ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08C4B21025
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19B1144D1A;
	Tue, 19 Nov 2024 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVveFqwG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5D1422B8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731986926; cv=none; b=jZt7kSX/z2He1t34v2slFLJTF+YKcRL9qaQNJx9s5T5AhfnE9E+O0kWjBk8G+f88oRtz01QzFi9gRyuEzdu1eZDlqm6WH4kR/ey2kJCKxiRrJHMje/YaBs+DxGM47Ls5JJpAiSAFD3Wu7fr94njUf95wEfo8qJhAueCSJX8ZS7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731986926; c=relaxed/simple;
	bh=xRS4+hfrg3gCeRdM/kgrY9Q/qqbZgYGs1w5s9hrk8iY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S+Cb1pXZq8E22mqmd8krOqj8BnIkS1Qaww+j+oswzS1NHQi+ZQ9uBrgRI69yLsZE8dFgsDo9HWow8Ppuq0zjI+5Cji2JoC6k1upWnSKZ6S8SNhArM1vAAjKgPjmFUM/dBzseXwhN6yNYa+RKS9J4pnh4JvEYRwi/OCA2eUIb1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVveFqwG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731986923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8PlemWAggT45hfxEfheUGm2fsh9572BEWCOzq6YZBo=;
	b=MVveFqwGkZoUkh6ME4JfOw5aQx00UHOJYM23hl5jdui4I/Ncn5mrRm1UcmUbYzZuThKebh
	8pUbsY7+PCd5JIQkYqOpdFuoIEbCJRYi6ZHRvgLdgahuKO7kqrCBv2c16Ow5FUXPCjV4rq
	snJj4NhJguqJMIcdK46cuQU0hV0uY7c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-aQ7YAlGXMWi3uX_yhGZY0A-1; Mon, 18 Nov 2024 22:28:40 -0500
X-MC-Unique: aQ7YAlGXMWi3uX_yhGZY0A-1
X-Mimecast-MFC-AGG-ID: aQ7YAlGXMWi3uX_yhGZY0A
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-460aca6cd0bso6031711cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731986920; x=1732591720;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8PlemWAggT45hfxEfheUGm2fsh9572BEWCOzq6YZBo=;
        b=UJLjxAjP6DNfvrz0hBCQ9S191VadG1sS1Lwmt3d/JET2EZP10tStsNGOVH4SiEI9yr
         z/RR5RLDUjNbjfZ4qBfvtp9dlMmUdkSBQHIb4IsW1m9HRRXfNXN+GYTyx3Uv8Pjn4Gf/
         bHXySJTjgay6UN/JqK+r7C3TpYAlfpERhHMG5lD6yOK1KX4BB6dvqpJfvSUKSxW8hwaH
         7j4aNacwi8p9P9D4qC4ZuA5/oCuvrIn8EmU2qZvNYlzb2abgMtu5dMzjoALg2WTsCI1F
         K3z55Le5jVaJ9l5GuSeRznbQnhcl/YLiVWJ3tzg8crFJDjsdqvvd4e+JLTHBPuUJERSK
         zVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlj9e9oEzvzAZPwHP0ncijqc/1/QnfCaaCKGQYAgtdCBbS0aCktBguPfRL9806SV/l+OK/oryieS+hUkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZua13tOwi27ZTNufDN3kzhAPGsHbWlbbVFtPP8OYO7oy2JtW
	D39n5I3eX+1JJeyrUmPtF7ealY/alzAr0eVs6C5WHgHHR3yMDgGMqRuoWU0LnYW+YDmfmwmwzLh
	EnoBb7f8ZKj4MGfr3JNKGvJs7x7TcQzHP0073qfdQI4FnsSCd1k0XwPhCKM4IVg==
X-Received: by 2002:ac8:7c55:0:b0:461:20b0:9909 with SMTP id d75a77b69052e-46363e3504dmr199036141cf.29.1731986920148;
        Mon, 18 Nov 2024 19:28:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdAeoC11ngzyylbKnDevm2EAHvD6G1i4Vrhlv5MIh5VT/D/Pe5FLQLw+zX3Y6Y55RoNo7Ozg==
X-Received: by 2002:ac8:7c55:0:b0:461:20b0:9909 with SMTP id d75a77b69052e-46363e3504dmr199036011cf.29.1731986919788;
        Mon, 18 Nov 2024 19:28:39 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46392bc364csm6120171cf.48.2024.11.18.19.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 19:28:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c3354d87-a856-421b-a03e-cda2f1346095@redhat.com>
Date: Mon, 18 Nov 2024 22:28:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test
 if not load balancing
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
References: <20241114181915.142894-1-longman@redhat.com>
 <ZzcoZj90XeYj3TzG@jlelli-thinkpadt14gen4.remote.csb>
 <1515c439-32ef-4aee-9f69-c5af1fca79e3@redhat.com>
 <ZzsLTLEAPMljtaIK@jlelli-thinkpadt14gen4.remote.csb>
 <5a878687-9d08-472e-a387-02b2a150d2df@redhat.com>
Content-Language: en-US
In-Reply-To: <5a878687-9d08-472e-a387-02b2a150d2df@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/24 8:58 AM, Waiman Long wrote:
>>> The failing test isn't an isolated partition. The actual test 
>>> failure is
>>>
>>> Test TEST_MATRIX[62] failed result check!
>>> C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 . . X5 . . 0 
>>> A1:0-4,A2:1-4,A3:2-4
>>> A1:P0,A2:P-2,A3:P-1
>>>
>>> In this particular case, cgroup A3 has the following setting before 
>>> the X5
>>> operation.
>>>
>>> A1/A2/A3/cpuset.cpus: 2-4
>>> A1/A2/A3/cpuset.cpus.exclusive: 4
>>> A1/A2/A3/cpuset.cpus.effective: 4
>>> A1/A2/A3/cpuset.cpus.exclusive.effective: 4
>>> A1/A2/A3/cpuset.cpus.partition: root
>> Right, and is this problematic already?
> We allow nested partition setup. So there can be a child partition 
> underneath a parent partition. So this is OK.
>>
>> Then the test, I believe, does
>>
>> # echo 5 >cgroup/A1/A2/cpuset.cpus.exclusive
>>
>> and that goes through and makes the setup invalid - root domain reconf
>> and the following
>>
>> # cat cgroup/A1/cpuset.cpus.partition
>> member
>> # cat cgroup/A1/A2/cpuset.cpus.partition
>> isolated invalid (Parent is not a partition root)
>> # cat cgroup/A1/A2/A3/cpuset.cpus.partition
>> root invalid (Parent is an invalid partition root)
>>
>> Is this what shouldn't happen?
>>
> A3 should become invalid because none of the CPUs in 
> cpuset.cpus.exclusive can be granted. However A2 should remain a valid 
> partition. I will look further into that. Thank for spotting this 
> inconsistency. 

Sorry, I misread the test. The X5 entry above refers to "echo 5 > 
A1/A2/cpuset.cpus.exclusive" not to A3. This invalidates the A2 
partition which further invalidates the child A3 partition. So the 
result is correct.

Cheers,
Longman


