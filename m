Return-Path: <linux-kernel+bounces-211178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0795F904E15
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF3D28A074
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152216C87F;
	Wed, 12 Jun 2024 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mm5prvdn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8D156228
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180673; cv=none; b=OZI56VT6kHQ5eC1oMYg41JhYlPZOPbTnE3iGrhjiAQGe61iILXAFuGVfsG6t+RNDBLSV6wzx3uJePBJSKFyqD4KYXRFYhzLadX5KSPy4R/ctcdst6TTaolre7TOfwMZNvV8VVe0J7ESGjEMwKaHLrOh2tcRDLkQ+VPQECHOQkj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180673; c=relaxed/simple;
	bh=te1Q20Vth9MWwmn9a+KpPufbUwhGd2AwZ3ZB/0nsgxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMDJROy8I2DqnIbzhrSIA+985fg1zP8OkNbt6XQJyWy1Zt0o2WxLrzDL6NOEJwPSb4Hfgv2vH/wbIagoTXc9oGWEs6Tq+3bHmO9QhKczto+jSAKnI00B7a5ha+njw+aNEzDjWvkLiwAQB/vg1U4zDdxPixWWHw4L5DZNpWveNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mm5prvdn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718180671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x4SAin/ZbIr0LKUcDWptj03+6GW7XfZLpNKJdBjC5OY=;
	b=Mm5prvdn+1W5HcmqAYoPl/RX8gmi+IO7wGoErYa9sUjjx3SsYfC5xPIGVAQu1A2AxNhT/1
	HE/id+XmH3T7y03tctBa99FwToOrguUQRTYzxrLzLXgJKN37QiXa//5RV6ho6upGRLXOyk
	EhzUacJ3hGcGTO0d8too9H4pavz6IMk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-hI4RDzfINkynBFf5p0NtJw-1; Wed, 12 Jun 2024 04:24:26 -0400
X-MC-Unique: hI4RDzfINkynBFf5p0NtJw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6f2662cfd8so102757166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180665; x=1718785465;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x4SAin/ZbIr0LKUcDWptj03+6GW7XfZLpNKJdBjC5OY=;
        b=jAhUOcJPsb/NRB5lNrd7aNsb/wbbdpZXXmJNUEEoT8CS+48n5IGportjfh6OcggdUI
         vXQtiKFeao4wE1SuazIdEBPA9I1k3t3oXeXwUNU9xuLr5kUqQUzzCeZI6iaUvmXx5rcA
         aOpfUv/8sQYsOP4oWRyqIGKWxAfFhRuWWvdesTztQBexPiVDZLeU5QQjVqtLSBXN4vpR
         K0msNUMtDzzLZXEN6usHbv5XX5q/8ptgJHsttNW/sPoqkLh1r9Bazn5pyY/hRn7K9Fnl
         C5N+68MTA/ZAknNqrfoJeBvmZFnRTy8XfWLbyPUG4Jg3ssnB6OxL+Yx7m2XsACJQIYco
         Rr+A==
X-Forwarded-Encrypted: i=1; AJvYcCV3c02NDPZEeZKn9yRIWIveHCTmUyOiUq3xZY1s+BljZOP/5w31VIbnZf9RmJeNYoyLUr1UgPyLJPH35CpHMZeSNjHLXPWHK6C0Hpbk
X-Gm-Message-State: AOJu0YwJttDvSXvFxQaH6zPjXGy9yKVWEJ8DO93PvtwN42x8UN2bAZSd
	fgD7WyLGkIbp8YGvzTDtK/vgsZ4bSsEEnJ9KdW0Sykyyfs/wQEe/s8VhHPdrM3XT8AuQ+6KgCFL
	5WFeqa69WyEHMXmR2o4f2vohEJosKrnbYLbyS0a0JnzLNIY1b77Eh+A7HAvJ9yw==
X-Received: by 2002:a17:906:394:b0:a6f:230:b73e with SMTP id a640c23a62f3a-a6f47c9e0edmr58641666b.20.1718180665205;
        Wed, 12 Jun 2024 01:24:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA1q7iuoA2WDuKe96aglvJScAbJcl9LmxJfQ259oiHHm3zp6kG7M8iBlW3Pg+ABx1QAfqvBg==
X-Received: by 2002:a17:906:394:b0:a6f:230:b73e with SMTP id a640c23a62f3a-a6f47c9e0edmr58640066b.20.1718180664753;
        Wed, 12 Jun 2024 01:24:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:bf00:abf6:cc3a:24d6:fa55? (p200300cbc702bf00abf6cc3a24d6fa55.dip0.t-ipconnect.de. [2003:cb:c702:bf00:abf6:cc3a:24d6:fa55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2169fc45sm8386092f8f.10.2024.06.12.01.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 01:24:24 -0700 (PDT)
Message-ID: <17b503f8-5d0c-48a3-9eeb-85b01583f9bb@redhat.com>
Date: Wed, 12 Jun 2024 10:24:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make
 headers"
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
 <b5dd99c7-866b-467c-9f76-d043e887394c@redhat.com>
 <c1277bf6-a211-49eb-80af-726f16ca1802@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c1277bf6-a211-49eb-80af-726f16ca1802@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.24 22:54, John Hubbard wrote:
> On 6/11/24 2:36 AM, David Hildenbrand wrote:
>> On 08.06.24 04:10, John Hubbard wrote:
>>> Eventually, once the build succeeds on a sufficiently old distro, the
>>> idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and then
>>> after that, from selftests/lib.mk and all of the other selftest builds.
>>>
>>> For now, this series merely achieves a clean build of selftests/mm on a
>>> not-so-old distro: Ubuntu 23.04:
>>
>> Wasn't the plan to rely on the tools/include headers, and pull in there whatever we need?
> 
> Yes, it is. You are correct.
> 
>>
>>>
>>> 1. Add __NR_mseal.
>>>
>>
>> For example, making sure that tools/include/uapi/asm-generic/unistd.h is updated to contain __NR_mseal?
> 
> Well, here it gets less clear cut, because the selftests pull in *lots* of
> system headers. In this case /usr/include/unistd.h gets pulled in. If we
> force tools/include/uapi/asm-generic/unistd.h to be included, then we'll
> get many many warnings of redefinitions of __NR_* items.

I think, there is a difference between unistd.h and linux/unistd.h. We 
want to continue including unistd.h from the distro, but might want to 
stop including the linux one from the distro.

My thinking was that we start maintaining our own linux headers copy 
in-tree, and start converting our tests from including <linux/> supplied 
by the distro to include the in-tree ones.

For mseal_test.c, that might mean stopping including "linux/mman.h", and 
instead including the in-tree one.

> 
> So what's really going on here is that we have this uneasy mix of system
> headers from the test machine, and newer versions of some of those headers
> in the kernel tree. And some of those are easier to combine with system
> headers, than others. unistd.h is clearly not going quietly, which is
> why, I believe, the "#ifndef __NR_* " approach has flowered in the
> selftests.

Right, these mixtures are not what we want I think. But I have no idea 
how easy it would be to convert individual tests.

Maybe all it takes is updating the in-tree headers and then including 
"TBD/linux/whatever.h" instead of <linux/whatever.h>

In QEMU, we maintain some (not all) kernel headers ourselves, and 
include them via

"standard-headers/linux/whatever.h"

> 
>>
>> ... to avoid hand-crafted defines we have to maintain for selftests.
>>
>> But maybe I am remembering something outdated.
>>
> 
> You remembered correctly, but the situation is slighly muddier than
> one would prefer. :)


Absolutely, and I appreciate that you are trying to improve the situation.

-- 
Cheers,

David / dhildenb


