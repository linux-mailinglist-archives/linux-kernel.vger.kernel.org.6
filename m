Return-Path: <linux-kernel+bounces-196717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2787F8D605F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2057282527
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DC2156F5F;
	Fri, 31 May 2024 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTJALI/u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2459156F40
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154036; cv=none; b=OZYJ3UQWwFZJRatNiDVsMsieyLeF485OsSajkwtMt2RFhzXfaZ62ym4JLw74xP1xH2m9TTkPU355Mnc2XWBPcZC3828b3Y2VoLIiU5sB4I/M+YfGnob8lYMErHfKME2CVyzZln0v0ypq1lb1eM5kXjXmdfGx1l9d8JiiBItQpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154036; c=relaxed/simple;
	bh=gc/RLoVMCxPWwJ/KBkyxX2HPIVqFtKFbFTnGwI7yamk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPkCDXjs/bddeMskI6YqX/tVZyGgw8mQSk6bzG4JgYJNJHNXrcfdKI95o39cKIN7oBb0vz7V55Ll/H6WFiGJFmFxhzCqL9BtlhTp9B9gED9cfNa2gor7gCg7MOO+VNYtERjZsMZ8WyDBpY3WlQI94OAv2Xqukivz2t3Zfzy1x4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTJALI/u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717154033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bOi2FA/qKgiWrZ9e6bDr0fZkKN673q8gp4naNipCTKU=;
	b=fTJALI/uDbqhwKS6U6IVPonz25ebWGYb3Z2oVFojTmlDicFnlWSQaWi6ubCbWZIzO86RyK
	0gUDcmIsuSsS36fnSrR6dpOLbevauNqx4NhQxW8muRQYXfszP7iVco0STdhcOlS6UTcAJV
	jQXWCOk66/iv9I7ZLh5NIxnXo6BcCzQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-pQGan78NM_GMktKQG9spJw-1; Fri, 31 May 2024 07:13:52 -0400
X-MC-Unique: pQGan78NM_GMktKQG9spJw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4212e3418b1so3683115e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 04:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717154031; x=1717758831;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bOi2FA/qKgiWrZ9e6bDr0fZkKN673q8gp4naNipCTKU=;
        b=XvXvuEtlE1+slDzB+uOFoqVS8MdA2SVJGirNsg9Wx4Tqfq2SMPtKnriZZTxmL9Bpcc
         sRzOcbN+8gdJzN3SCq0Nrw4egQ7dYvnkRyZ/tBRQbf/BF/2clrFVCadYj7tqd3v87vVa
         lw6G+mULKbg7VBsk7qkE8zuaJboPk607M1Jx2O95n9sxTHKIMscIX1fgfdPoACIkAkE1
         zlpY/SWLp5wAMs08MYeny33tmhcIkx+6J3kRNyK9kQx3jsUb+9PheLbW77dPdPph0OUp
         8gth2vVeuEzPqMqasL2aAiFMSrAnih5tG16abIHB9C+J/DJqG7QPz9IM5nwkaGM+K/KY
         vhCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQHM1L+9r8pTmAzITuWhyXQIro8yPhifSJn5pS7oRBwUzUlZbl5CP8zNET5kMczBzSLN/AiMFNjV78V744Nt2b02QxLU5fo98ylSB/
X-Gm-Message-State: AOJu0Yxs9Bk7mYinz7Z0rRrp+npJO9eBJsoaTZG9EXflZGfF9Q8xdXjI
	DoMreTvlrPhWh4scIaU98L7zHIg22Qt5dw7rwNcZr0xQS+rGwzUOFwHtNaIQ9UxgkkBciWtFhxG
	S9UIv9I1K2h9wHH9dN2rMyMQBKnM0eDfAqkaNw2jgEWkhUialz9X6W8Bw5vlGQQ==
X-Received: by 2002:a05:600c:a46:b0:421:2b13:e9cf with SMTP id 5b1f17b1804b1-4212e0c1440mr14553625e9.36.1717154030832;
        Fri, 31 May 2024 04:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIIbJIF4NYnYGrGuUKItJ8CH5Xz7U9G3ahNIHShZjXoOC/DW3aP9dHsf3qZry7FdVQDt70IA==
X-Received: by 2002:a05:600c:a46:b0:421:2b13:e9cf with SMTP id 5b1f17b1804b1-4212e0c1440mr14553425e9.36.1717154030315;
        Fri, 31 May 2024 04:13:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4? (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de. [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270a30e6sm52501855e9.34.2024.05.31.04.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 04:13:49 -0700 (PDT)
Message-ID: <502fb3df-b42b-4f0c-a98d-348c3d544721@redhat.com>
Date: Fri, 31 May 2024 13:13:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] add mTHP support for anonymous shmem
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
 <f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com>
 <db3517d0-54b1-4d3a-b798-1c13572d07be@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <db3517d0-54b1-4d3a-b798-1c13572d07be@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> As a default, we should not be using large folios / mTHP for any shmem,
>> just like we did with THP via shmem_enabled. This is what this series
>> currently does, and is aprt of the whole mTHP user-space interface design.
>>
>> Further, the mTHP controls should control all of shmem, not only
>> "anonymous shmem".
> 
> Yes, that's what I thought and in my TODO list.

Good, it would be helpful to coordinate with Daniel and Pankaj.

> 
>>
>> Also, we should properly fallback within the configured sizes, and not
>> jump "over" configured sizes. Unless there is a good reason.
>>
>> (3) khugepaged
>>
>> khugepaged needs to handle larger folios properly as well. Until fixed,
>> using smaller THP sizes as fallback might prohibit collapsing a
>> PMD-sized THP later. But really, khugepaged needs to be fixed to handle
>> that. >
>> (4) force/disable
>>
>> These settings are rather testing artifacts from the old ages. We should
>> not add them to the per-size toggles. We might "inherit" it from the
>> global one, though.
> 
> Sorry, I missed this. So I thould remove the 'force' and 'deny' option
> for each mTHP, right?

Yes, that's my understanding. But we have to keep them on the top level 
for any possible user out there.

> 
>>
>> "within_size" might have value, and especially for consistency, we
>> should have them per size.
>>
>>
>>
>> So, this series only tackles anonymous shmem, which is a good starting
>> point. Ideally, we'd get support for other shmem (especially during
>> fault time) soon afterwards, because we won't be adding separate toggles
>> for that from the interface POV, and having inconsistent behavior
>> between kernel versions would be a bit unfortunate.
>>
>>
>> @Baolin, this series likely does not consider (4) yet. And I suggest we
>> have to take a lot of the "anonymous thp" terminology out of this
>> series, especially when it comes to documentation.
> 
> Sure. I will remove the "anonymous thp" terminology from the
> documentation, but want to still keep it in the commit message, cause I
> want to start from the anonymous shmem.

For commit message and friends makes sense. The story should be 
"controls all of shmem/tmpfs, but support will be added iteratively. The 
first step is anonymous shmem."

-- 
Cheers,

David / dhildenb


