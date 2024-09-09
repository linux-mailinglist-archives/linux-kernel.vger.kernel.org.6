Return-Path: <linux-kernel+bounces-320831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D477D971128
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9F6282C45
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C075C1B1500;
	Mon,  9 Sep 2024 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNTzMZat"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C5E1B1424
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869090; cv=none; b=NM+aW9GJ+8oY9awD0nP/bisw7jYJYMHDCGxc+pKkqQ3IUQ4OBABPgZ5P8TEr9X3J3OIhi8dQyEpWwO7Mbb/9NjcvrOxE9h9XMiNzAKzREX5GLmPPcTO9pU9Nn014Yuntp+6oBZ2ywkLTB5foE7R0uCqnoQdnFAa2yzpL7ygPLbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869090; c=relaxed/simple;
	bh=3+TJ8qVxjJytrnvPbKuUSyCh5qj1d3qPasNk4OSQPw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7+EGCBYisLCt3L1Mz2jzxCfUCsP1dnUw5fevJGOI6YJFBIDQGNfF9gkb2MS+wmn4uSExLUB/fIpHrE0GfovLWv1ZzbIb/wgQGLqDrl53O7JbAAE1G9AmcczVr5oPKy452SpdA0wCu3fdqKveYDLMrwCe/JxHlQAUm6Dk9NossA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNTzMZat; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725869087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e8IHWWpBLJwFTy83f+891OGYQEfwFLVAklDrVSkaYV8=;
	b=fNTzMZatgDNeaTCV+bcTh0KyUKgkqqJIVWjkEcMYjlbimM9kUdQ5VRHwmBVI5ghA1tex7L
	mqqecIt+whkapkrKL6CmcbdsS4MQ1M4yHMl+mQcShr6ZWm7Kuto9ego8yosdMXyOjZBsT1
	io91sl/h8znWVoKrp7lVCXlaQGBnpI0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-_--U6TR4PW2nlDbySDQoZg-1; Mon, 09 Sep 2024 04:04:46 -0400
X-MC-Unique: _--U6TR4PW2nlDbySDQoZg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb827e9b6so5198725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725869085; x=1726473885;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8IHWWpBLJwFTy83f+891OGYQEfwFLVAklDrVSkaYV8=;
        b=Is1EQ7rLb4/Hdp/gFaSby0SsUTiNmj9ijsHZm4/C7fF+Ug7UO7lAfcO04Kc8Rm9HDJ
         qK2/1i4elxs/p7RzCoPaJS5B4YT+GCXtmKR17Tw4AbJLCEQW4cGd4+e10Dg0AoUrg0bg
         wWc4cX4QmPSDaqO7/iK4qPWb3BuHaFq9k8Oagq9DH5Z+BnRKlTveDPK/uKJUbrYJqVF9
         vtZZPxoUAhh8LCVgXZBNu8tN8krSRGe73XdFih521Ml4t6dqwwmRKhCH/Qp4LZzl05By
         IN2785TSnncv4qQ+y/A0nsQZmGl54Q9GkAndmAgNrRUDlmt0BLswegqt2aJxM41R8UKh
         FffA==
X-Forwarded-Encrypted: i=1; AJvYcCXeRYx9eroN9cykBJlHf1hrxOSE1qJo8p3slGrGLNPoETEDlEZEFrAfpPW3/EyFCrxzKlYJiLgoAKISTbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/vMM0i0/OJztqCslJEwnGMU4Re6NBmgiF14iK8hO9TGMd98h/
	Xf8JpOMZ7c4dP34Zjuf0AmZ3sQ3vNAMjDWUxaRZJJf5SglBQIOYAqgnImkFFN7aYANww8DBj6I6
	4gdwLvxUhkeGOSO7no4rx3cLdujJRevSPC2ihOG9n2xBb69SRCiSlMtVxFK70Wg==
X-Received: by 2002:a05:600c:4494:b0:42c:acfa:9cae with SMTP id 5b1f17b1804b1-42cacfa9f20mr42778785e9.35.1725869084962;
        Mon, 09 Sep 2024 01:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/AIWHe/2+xDVD/F8b5G2rMIWdA0lV4swL3L7hBBzDZj3/R53uAWzXa9IYybbWmNrhoio2WA==
X-Received: by 2002:a05:600c:4494:b0:42c:acfa:9cae with SMTP id 5b1f17b1804b1-42cacfa9f20mr42778295e9.35.1725869084003;
        Mon, 09 Sep 2024 01:04:44 -0700 (PDT)
Received: from [192.168.3.141] (p4ff2397f.dip0.t-ipconnect.de. [79.242.57.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca3a3cc31sm94306155e9.24.2024.09.09.01.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 01:04:43 -0700 (PDT)
Message-ID: <2bb87247-9212-426b-aaa7-e101f25d38ca@redhat.com>
Date: Mon, 9 Sep 2024 10:04:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v3 2/3] resource: Make alloc_free_mem_region() works for
 iomem_resource
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
References: <20240906030713.204292-1-ying.huang@intel.com>
 <20240906030713.204292-3-ying.huang@intel.com>
 <28bbd51b-cc47-4468-9523-45dab25d20dd@redhat.com>
 <878qw11f05.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <878qw11f05.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.24 09:07, Huang, Ying wrote:
> Hi, David,
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 06.09.24 05:07, Huang Ying wrote:
>>> During developing a kunit test case for region_intersects(), some fake
>>> resources need to be inserted into iomem_resource.  To do that, a
>>> resource hole needs to be found first in iomem_resource.
>>> However, alloc_free_mem_region() cannot work for iomem_resource now.
>>> Because the start address to check cannot be 0 to detect address
>>> wrapping 0 in gfr_continue(), while iomem_resource.start == 0.  To
>>> make alloc_free_mem_region() works for iomem_resource, gfr_start() is
>>> changed to avoid to return 0 even if base->start == 0.  We don't need
>>> to check 0 as start address.
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>> Cc: Alison Schofield <alison.schofield@intel.com>
>>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>>> Cc: Ira Weiny <ira.weiny@intel.com>
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Baoquan He <bhe@redhat.com>
>>> ---
>>>    kernel/resource.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/kernel/resource.c b/kernel/resource.c
>>> index 235dc77f8add..035ef16c1a66 100644
>>> --- a/kernel/resource.c
>>> +++ b/kernel/resource.c
>>> @@ -1873,7 +1873,7 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
>>>    		return end - size + 1;
>>>    	}
>>>    -	return ALIGN(base->start, align);
>>
>> You should add a comment here. But I do find what you are doing here
>> quite confusing.
> 
> Sure.  And sorry for confusing words.
> 
>> Above you write: "We don't need to check 0 as start address." -- why?
>> To make the code extra confusing? :)
> 
> After the change, we will not return "0" from gfr_start().  So we cannot
> check "0" as start address.  And I think nobody need to check "0", so it
> should be OK to do that.
> 
>> /* Never return address 0, because XXX. */
>> if (!base->start)
>> 	return align;
>> return ALIGN(base->start, align);
>>
>>
>> And i still haven't understood XXX. For whom exactly is address 0 a problem?
> 
> Because the following lines in gfr_continue()
> 
> 	/*
> 	 * In the ascend case be careful that the last increment by
> 	 * @size did not wrap 0.
> 	 */
> 	return addr > addr - size &&
> 	       addr <= min_t(resource_size_t, base->end,
> 			     (1ULL << MAX_PHYSMEM_BITS) - 1);
> 
> If addr == 0, then addr < addr - size.  gfr_continue() will return
> false, and we will not check any address.

Thanks, that makes things cleaner. I think it might be better to just rework
the retying logic, to detect wraps based on the old and new address. That
would require a bit more work, something like that should probably handle all
possible corner case. Dan wrote that code, so I'll leave it up to him to decide
how to handle that :)


diff --git a/kernel/resource.c b/kernel/resource.c
index 9f747bb7cd031..2cd054c8277e8 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1819,40 +1819,48 @@ EXPORT_SYMBOL(resource_list_free);
  #define GFR_REQUEST_REGION	(1UL << 1)
  #define GFR_DEFAULT_ALIGN (1UL << PA_SECTION_SHIFT)
  
-static resource_size_t gfr_start(struct resource *base, resource_size_t size,
-				 resource_size_t align, unsigned long flags)
+static bool gfr_start(struct resource *base, resource_size_t *addr,
+		resource_size_t size, resource_size_t align, unsigned long flags)
  {
+	resource_size_t start_addr;
+
  	if (flags & GFR_DESCENDING) {
  		resource_size_t end;
  
  		end = min_t(resource_size_t, base->end,
  			    (1ULL << MAX_PHYSMEM_BITS) - 1);
-		return end - size + 1;
+		start_addr = end - size + 1;
+		if (start_addr > end || start_addr < base->start)
+			return false;
+	} else {
+		start_addr = ALIGN(base->start, align);
+		if (start_addr < base->start || start_addr > base->end)
+			return false;
  	}
-
-	return ALIGN(base->start, align);
+	*addr = start_addr;
+	return true;
  }
  
-static bool gfr_continue(struct resource *base, resource_size_t addr,
-			 resource_size_t size, unsigned long flags)
+static bool gfr_continue(struct resource *base, resource_size_t *addr,
+			 resource_size_t align, unsigned long flags)
  {
-	if (flags & GFR_DESCENDING)
-		return addr > size && addr >= base->start;
-	/*
-	 * In the ascend case be careful that the last increment by
-	 * @size did not wrap 0.
-	 */
-	return addr > addr - size &&
-	       addr <= min_t(resource_size_t, base->end,
-			     (1ULL << MAX_PHYSMEM_BITS) - 1);
-}
+	resource_size_t new_addr;
  
-static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
-				unsigned long flags)
-{
-	if (flags & GFR_DESCENDING)
-		return addr - size;
-	return addr + size;
+	if (flags & GFR_DESCENDING) {
+		new_addr = *addr - align;
+		if (new_addr > *addr || new_addr < base->start)
+			return false;
+	} else {
+		resource_size_t end;
+
+		end = min_t(resource_size_t, base->end,
+			    (1ULL << MAX_PHYSMEM_BITS) - 1);
+		new_addr = *addr + align;
+		if (new_addr < *addr || new_addr > end)
+			return false;
+	}
+	*addr = new_addr;
+	return true;
  }
  
  static void remove_free_mem_region(void *_res)
@@ -1893,9 +1901,9 @@ get_free_mem_region(struct device *dev, struct resource *base,
  	}
  
  	write_lock(&resource_lock);
-	for (addr = gfr_start(base, size, align, flags);
-	     gfr_continue(base, addr, align, flags);
-	     addr = gfr_next(addr, align, flags)) {
+	if (!gfr_start(base, &addr, size, align, flags))
+		goto unlock;
+	do {
  		if (__region_intersects(base, addr, size, 0, IORES_DESC_NONE) !=
  		    REGION_DISJOINT)
  			continue;
@@ -1939,7 +1947,8 @@ get_free_mem_region(struct device *dev, struct resource *base,
  		}
  
  		return res;
-	}
+	} while (gfr_continue(base, &addr, align, flags));
+unlock:
  	write_unlock(&resource_lock);
  
  	if (flags & GFR_REQUEST_REGION) {
-- 
2.46.0


-- 
Cheers,

David / dhildenb


