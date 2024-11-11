Return-Path: <linux-kernel+bounces-404643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477B89C4628
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5B41F22524
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5931AA1FC;
	Mon, 11 Nov 2024 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFUcJVf1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1613B58A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354472; cv=none; b=kNgSQRo5ZvfwbRShOocpIO7w0IK8V1MCCwd8x3HcNupzc3bouoXxBlpOvB9t1VLElsX0nvt0IMWBdnJWwUj0U5Na836XcIBNaoyUHwAiqSkg90d4Zs30rYrz02hecQNpYiAnJiSR6p4IxQvRj/oazi3SOIPOiq5XqN7ZHCZojAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354472; c=relaxed/simple;
	bh=4qo6Que+sjBWt2LWpLfsuLVtt2uAHc1d9txYLZM6/OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fq+JnBe7f3WEU1KR+8ihnQBPHt30RVQo1419cSZQHnmIaAvTdgCXHmNyv2lh9OJiSY7w2f6fE5SXY2PEaYQIF2cKTsjnMjnvBZbOdGdvC6W5Y0uiS92nHT53GHzp6psYvfyplpjxadgC1vAeWANYbC/TMsT1oureHWI2wngu8Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFUcJVf1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731354469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MFNHJfTeC9GG1TEdozy+vGwd4DL1R7mc+Hff2axsnX8=;
	b=SFUcJVf1TiVZV75xQB69AHI4vp3gAgP5CYaAwVKjCrH2oajbnPR30S+Of9vVpVGI2IQREY
	szkbxmuPdmVhyXy8rXWbDcFpM5sgOmU8VbzrW3O+B2PWj7oZr22s3SSrMDnJUBFvWAj6GG
	I9ZOtAlg725sR42kpTKm6VQHJ6ADr4A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-YVwLO7LUO5GKEGpCfouRug-1; Mon, 11 Nov 2024 14:47:48 -0500
X-MC-Unique: YVwLO7LUO5GKEGpCfouRug-1
X-Mimecast-MFC-AGG-ID: YVwLO7LUO5GKEGpCfouRug
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4316ac69e6dso37594175e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731354467; x=1731959267;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MFNHJfTeC9GG1TEdozy+vGwd4DL1R7mc+Hff2axsnX8=;
        b=sC/Js8zGpjLiQ2L/S4H6UrYfmsIKsNphrJchUWbJzS9GTDxMcKAMJVJHm3RsFqDc4J
         d2llHXVeVU98jocN8+gMNnU9qNGxZfONSqiKGKLxFmc71LtlWDlTxDZcXvezcZE2GU9+
         avCRwleJ6NFmnDSULIMdyNok+3WrSO3JNCY998WGAwVUlvfe1/OpDqyU3v/upv4VXWmr
         DIMy2pOV0DafLUMV19BkbMwxDX3dMWyvlIdxoUxal9+++cJ3SEhZsA1bDjJkQUFA0LX3
         pNtzhzY5i0vM7jVp31pA8Vug4/JLt/6/oA94e/bIDKO7g2xpHDQSzRUoQq6JFDKEklJ1
         1EhA==
X-Forwarded-Encrypted: i=1; AJvYcCWDwxzoJoG00TRhjQvafqlzfumPb9YV3bQPduL77CgrD+VaxHQMKm+SKpTVnwcckLjP4uPZLSVGaQmDy/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDln+EavgQS/8P9ogsaISBGejgxSYRxnzPDDllInhA+YtBtCRL
	zQvRXKBDF7HZTsW9sRFtHFnoEoPHkXv7oM65zAIJ1w7P4Np9RnW3QX22N0AaTAwU/jb7uWw/gEg
	95Cn5UXESKZ9IrJREKh8sMt8jp10BkYCxy9Kd/na1qnyJ/Vnlw9dJYBXAxWt4tQ==
X-Received: by 2002:a05:600d:b:b0:432:bb4d:cd66 with SMTP id 5b1f17b1804b1-432bb4dced6mr94996995e9.11.1731354467406;
        Mon, 11 Nov 2024 11:47:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEioONBvT5NYFDZb98CjO8Loe4WxhQ9GjJjGWW7JQAFE3vykyOc9hDLu0UHXPhqno5NoGcz1A==
X-Received: by 2002:a05:600d:b:b0:432:bb4d:cd66 with SMTP id 5b1f17b1804b1-432bb4dced6mr94996865e9.11.1731354467027;
        Mon, 11 Nov 2024 11:47:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c730:4300:18eb:6c63:a196:d3a2? (p200300cbc730430018eb6c63a196d3a2.dip0.t-ipconnect.de. [2003:cb:c730:4300:18eb:6c63:a196:d3a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05302e1sm184134455e9.9.2024.11.11.11.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 11:47:46 -0800 (PST)
Message-ID: <d9b23bde-f3c7-4991-8cbe-3915bb9279d0@redhat.com>
Date: Mon, 11 Nov 2024 20:47:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Support large folios for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1731038280.git.baolin.wang@linux.alibaba.com>
 <3d49fbf8-866f-485b-b7fa-a89bbfb3cd7c@redhat.com>
 <fabfc6d6-6693-40ca-b2c6-769882b19178@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <fabfc6d6-6693-40ca-b2c6-769882b19178@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.11.24 08:12, Baolin Wang wrote:
> 
> 
> On 2024/11/8 23:30, David Hildenbrand wrote:
>> On 08.11.24 05:12, Baolin Wang wrote:
>>> Traditionally, tmpfs only supported PMD-sized huge folios. However
>>> nowadays
>>> with other file systems supporting any sized large folios, and extending
>>> anonymous to support mTHP, we should not restrict tmpfs to allocating
>>> only
>>> PMD-sized huge folios, making it more special. Instead, we should allow
>>> tmpfs can allocate any sized large folios.
>>>
>>> Considering that tmpfs already has the 'huge=' option to control the huge
>>> folios allocation, we can extend the 'huge=' option to allow any sized
>>> huge
>>> folios. The semantics of the 'huge=' mount option are:
>>>
>>> huge=never: no any sized huge folios
>>> huge=always: any sized huge folios
>>> huge=within_size: like 'always' but respect the i_size
>>> huge=advise: like 'always' if requested with fadvise()/madvise()
>>>
>>> Note: for tmpfs mmap() faults, due to the lack of a write size hint,
>>> still
>>> allocate the PMD-sized huge folios if huge=always/within_size/advise
>>> is set.
>>
>> So, no fallback to smaller sizes for now in case we fail to allocate a
>> PMD one? Of course, this can be added later fairly easily.
> 
> Right. I have no strong preference on this. If no one objects, I can add
> a fallback to smaller large folios if the PMD sized allocation fails in
> the next version.

I'm fine with a staged approach, to perform this change separately.

> 
>>> Moreover, the 'deny' and 'force' testing options controlled by
>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the
>>> same
>>> semantics. The 'deny' can disable any sized large folios for tmpfs, while
>>> the 'force' can enable PMD sized large folios for tmpfs.
>>>
>>> Any comments and suggestions are appreciated. Thanks.
>>>
>>> Hi David,
>>> I did not add a new Kconfig option to control the default behavior of
>>> 'huge='
>>> in the current version. I have not changed the default behavior at this
>>> time, and let's see if there is a need for this.
>>
>> Likely we want to change the default at some point so people might get a
>> benefit in more scenarios automatically. But I did not investigate how
>> /tmp is mapped as default by Fedora, for example.
> 
> Personally, adding a cmdline to change the default value might be more
> useful than the Kconfig. Anyway, I still want to investigate if there is
> a real need.

Likely both will be reasonable to have.

FWIW, "systemctl cat tmp.mount" on a Fedora40 system tells me
"Options=mode=1777,strictatime,nosuid,nodev,size=50%%,nr_inodes=1m"

To be precise:

$ grep tmpfs /etc/mtab
vendorfw /usr/lib/firmware/vendor tmpfs rw,relatime,mode=755,inode64 0 0
devtmpfs /dev devtmpfs rw,nosuid,size=4096k,nr_inodes=4063361,mode=755,inode64 0 0
tmpfs /dev/shm tmpfs rw,nosuid,nodev,inode64 0 0
tmpfs /run tmpfs rw,nosuid,nodev,size=6511156k,nr_inodes=819200,mode=755,inode64 0 0
tmpfs /tmp tmpfs rw,nosuid,nodev,size=16277892k,nr_inodes=1048576,inode64 0 0
tmpfs /run/user/100813 tmpfs rw,nosuid,nodev,relatime,size=3255576k,nr_inodes=813894,mode=700,uid=100813,gid=100813,inode64 0 0


Having a way to change the default will likely be extremely helpful.

-- 
Cheers,

David / dhildenb


