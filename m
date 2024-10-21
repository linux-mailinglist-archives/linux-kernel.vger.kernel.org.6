Return-Path: <linux-kernel+bounces-374587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3579A6C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1318CB2495A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A1E1FAC37;
	Mon, 21 Oct 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGnwPKS8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA8225D6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521968; cv=none; b=hS2Ht7S1JbGRJO+MXqG4yRWCOHmdfieuX0TKW3raujbPixl39IxuvP9UMMhPYvPg8iYb1WUVezA1AiCGe+amNKfq7fqWZDGlvtPLRetv0QCCVlTW/rQOMJflYPyVlsjWcIKuaRdfnPmLfxkVTjz7G5YfRX6afQjUaRRUQsvUZok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521968; c=relaxed/simple;
	bh=DmQWkn1T9PFoG0NEwWjY8BdpxvZZCy1ZxEjLTxUCtIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdteV6tp5ui3vvJJfVuSGglOseyPIiZUocxOwDeYQS6hBM3LDLM8kwRmy+IueS9xTsC0ekVtio9EOUuh9iQacGkWPOM2NgEUAkjx5Ue3NFJLUzguDpZHV07prZieB/Bmkm10WXTkfKdm0CvBNNsFktYZDEJJGUTEhNf2h9XBzOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGnwPKS8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729521965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pBpP7qLCW9N3cROeVqgUltAMhaWq+ArP+b0NXa5W34=;
	b=jGnwPKS8qS74KD5aFrJHBO6uvcQOyQtH0/KbZmBoUDA62QmnI/x2jTMrYUE3FnVDLfeZyu
	nj3upWYkk+ZNkqmDB1inWNQBhboaUQBmANuj10rtKCldiqKzjKK55+hP5k1Kb4K6/9DPuD
	1Aw6oTzZOgbl6KEY7frrmLzofO0AAb8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-ivkvQPDMOju3erII4yDL8Q-1; Mon, 21 Oct 2024 10:46:03 -0400
X-MC-Unique: ivkvQPDMOju3erII4yDL8Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so36579555e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521962; x=1730126762;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pBpP7qLCW9N3cROeVqgUltAMhaWq+ArP+b0NXa5W34=;
        b=vfCEa9f26clKfng+2SzLbJQt3ULYH6Dqhpa7Onf7mOHgr87vxqLgjaiAKdtcLnmEaC
         ygB6p0EtXeH3Q/+zABSZHqmzJFLtqdZP3fVwA9UDXNF7Ar7G8d9tnd7jBtinS7x05LGO
         FBZG+cdJISeq6NkrJnZYk+pKNHoqVTgzKlTA9+uLYr9Mujn6UIr+CqLu5hWhHe6tySZR
         iHQ2sqY41XXRD5W4tKsh3eRBm3ofT8VR4QAnhAY9l/bxnxklOqpdeEzC9sO6386uDMEL
         EcyTb9qWkv2kNdh+Hkm2CWlT4NemydonxGjLhyYmp36aIefSswtm3QHt6rQz5QchMnOy
         TTEw==
X-Forwarded-Encrypted: i=1; AJvYcCU8kbG33DwX6dT1jCgR9v2tCWqJxqPL21rb1hZRga8Oyuqm6+GmgdYUdGNKjz4b2lqyUc38WqfrPQEVT/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzizCNTp7XuZCZZTJgL+NUX8COnWAce0nmD2VNC5acuGnKNB9lC
	L/J9tBEi/wCQsguPBM5vBY0bObHvYNyYq+4og5EGalIWDNXeuIkzvWsqCMhhQp0ymB7QbR74X3E
	BjXv0UAkScpPWTPglntVctOYih84X2H1s7QZwpIVkES3wbX2PMh93NTFGBU+BEg==
X-Received: by 2002:a05:600c:4f15:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-4316168ffb3mr101784455e9.30.1729521961927;
        Mon, 21 Oct 2024 07:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnIcoVRRXbRUhxXReK6GpWNjdl0oiVGYJ9jq/7PmjHByyOKh4qiRtxhiYigJPvogBLyhVgLw==
X-Received: by 2002:a05:600c:4f15:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-4316168ffb3mr101784205e9.30.1729521961507;
        Mon, 21 Oct 2024 07:46:01 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:36d3:2b96:a142:a05b? ([2a09:80c0:192:0:36d3:2b96:a142:a05b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57fc77sm60419925e9.17.2024.10.21.07.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:46:01 -0700 (PDT)
Message-ID: <64db4a88-4f2d-4d1d-8f7c-37c797d15529@redhat.com>
Date: Mon, 21 Oct 2024 16:45:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] s390/kdump: implement is_kdump_kernel()
To: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: agordeev@linux.ibm.com, akpm@linux-foundation.org,
 borntraeger@linux.ibm.com, cohuck@redhat.com, corbet@lwn.net,
 eperezma@redhat.com, frankja@linux.ibm.com, gor@linux.ibm.com,
 hca@linux.ibm.com, imbrenda@linux.ibm.com, jasowang@redhat.com,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, mcasquer@redhat.com, mst@redhat.com,
 svens@linux.ibm.com, thuth@redhat.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com, zaslonko@linux.ibm.com
References: <87ed4g5fwk.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
 <76f4ed45-5a40-4ac4-af24-a40effe7725c@redhat.com>
 <87sespfwtt.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <87sespfwtt.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 21.10.24 um 14:46 schrieb Alexander Egorenkov:
> Hi David,
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> Makes sense, so it boils down to either
>>
>> bool is_kdump_kernel(void)
>> {
>>            return oldmem_data.start;
>> }
>>
>> Which means is_kdump_kernel() can be "false" even though /proc/vmcore is
>> available or
>>
>> bool is_kdump_kernel(void)
>> {
>>            return dump_available();
>> }
>>
>> Which means is_kdump_kernel() can never be "false" if /proc/vmcore is
>> available. There is the chance of is_kdump_kernel() being "true" if
>> "elfcorehdr_alloc()" fails with -ENODEV.

Thanks for having another look!

> 
> Do you consider is_kdump_kernel() returning "true" in case of zfcpdump or
> nvme/eckd+ldipl dump (also called NGDump) okay ? Because
> dump_available() would return "true" in such cases too.
> If yes then please explain why, i might have missed a previous
> explanation from you.

I consider it okay because this is the current behavior after elfcorehdr_alloc() 
succeeded and set elfcorehdr_addr.

Not sure if it is the right think to do, though :)

Whatever we do, we should achieve on s390 that the result of is_kdump_kernel() 
is consistent throughout the booting stages, just like on all other architectures.

Right now it goes from false->true when /proc/vmcore gets initialized (and only 
if it gets initialized properly).

> 
> I'm afraid everyone will make wrong assumptions while reading the name
> of is_kdump_kernel() and assuming that it only applies to kdump or
> kdump-alike dumps (like stand-alone kdump), and, therefore, introduce
> bugs because the name of the function conveys the wrong idea to code
> readers. I consider dump_available() as a superset of is_kdump_kernel()
> and, therefore, to me they are not equivalent.
 > > I have the feeling you consider is_kdump_kernel() equivalent to
> "/proc/vmcore" being present and not really saying anything about
> whether kdump is active ?

Yes, but primarily because this is the existing handling.

Staring at the powerpc implementation:

/*
  * Return true only when kexec based kernel dump capturing method is used.
  * This ensures all restritions applied for kdump case are not automatically
  * applied for fadump case.
  */
bool is_kdump_kernel(void)
{
	return !is_fadump_active() && elfcorehdr_addr != ELFCORE_ADDR_MAX;
}
EXPORT_SYMBOL_GPL(is_kdump_kernel);


Which was added by

commit b098f1c32365304633077d73e4ae21c72d4241b3
Author: Hari Bathini <hbathini@linux.ibm.com>
Date:   Tue Sep 12 13:59:50 2023 +0530

     powerpc/fadump: make is_kdump_kernel() return false when fadump is active

     Currently, is_kdump_kernel() returns true in crash dump capture kernel
     for both kdump and fadump crash dump capturing methods, as both these
     methods set elfcorehdr_addr. Some restrictions enforced for crash dump
     capture kernel, based on is_kdump_kernel(), are specifically meant for
     kdump case and not desirable for fadump - eg. IO queues restriction in
     device drivers. So, define is_kdump_kernel() to return false when f/w
     assisted dump is active.


For my purpose (virtio-mem), it's sufficient to only support "kexec triggered 
kdump" either way, so I don't care.

So for me it's good enough to have

bool is_kdump_kernel(void)
{
	return oldmem_data.start;
}

And trying to document the situation in a comment like powerpc does :)

-- 
Cheers,

David / dhildenb


