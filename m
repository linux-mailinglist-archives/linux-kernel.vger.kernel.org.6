Return-Path: <linux-kernel+bounces-558535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD956A5E735
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACF53A7749
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791CB1EFF89;
	Wed, 12 Mar 2025 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPAGgbL4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AFC1E230E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817954; cv=none; b=PdViwu55hxkoKsp02L2bW4hYKRKlYqYCAVw52TDIybY3PNPyjZwDKpZv/vNKAOQ1hM0IOkoebZH/iF6YaLEDcXQIHsskqbzitm3grhJ4KObRqjlxyC8cWN1fkyDBBj+1X/au063bIqurRBJKLMmUn6se3x0hB8iEvoY64aQNOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817954; c=relaxed/simple;
	bh=ED08Mt6RpE3YuROU8cM9sysjsMYzGtrc8SaX4I53Zqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJ9jNxww3fMdUOlB/CSVGagbMmipfXOiprYiKBkUt2oVkBO4zTcMxtc9sSwBOSsDvuDAadNQo1TO0U3KkiTLdtOFePY6PAXJ20q35ObrYzKSNohsuQLOneFrC76r1wjme7SOAu9acUg9C0NbPUBxmFXMm/q4DVZih0cE4zhrfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPAGgbL4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741817952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YKs6c5vd6BryHi5UgmvOyl94KmjrndKcyGQFDHLGkR0=;
	b=SPAGgbL4lgLf/4vgPzbzeujZB6UCYUbyDU2dCibDpoLc06lqsAYI/rEMzQwglI/1jQdyju
	fiujoQAAoAHnm2HL3zRlMSwYIrG3aD3Kc3AOZcYT384z44y0v8rKBFHGLCbC5jGtKIzZ0T
	2ewvrZOAs7cGYJwsuFCH0q4ErdTA6Hk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-7PLwL10oPz2RKVkXtV8KNw-1; Wed, 12 Mar 2025 18:19:11 -0400
X-MC-Unique: 7PLwL10oPz2RKVkXtV8KNw-1
X-Mimecast-MFC-AGG-ID: 7PLwL10oPz2RKVkXtV8KNw_1741817950
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so1742705e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741817950; x=1742422750;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YKs6c5vd6BryHi5UgmvOyl94KmjrndKcyGQFDHLGkR0=;
        b=kwm66qBfMtaHEQDGJtu1QdVP+llJFCx0XyLC/3zbRuV+zZEFmV6b8U8rgEfjzvepZ0
         F/EafRcj0BSP3b+pFoIGDT4fQ/tQlS2XILTsDqTqss370/qN5VvptxobFdLitisHfFmX
         5boiccRqNGZh7syEF8J2JJRCA72nBcgRbmtR9I79kLAbQKww3al92PfwSQjqsKHWTP9e
         ojQnC++paAyYAnDFqrk0OI6lKjVejO+qYKAf53/kxq6tK1R7P5717P71t/xHdBvAvoka
         Wb4lxc1T0TIjA7SJpfKz0omRuXkZ0WFjaT0XA9cQKbs64o9FkfYCmhLRYkxJs7i2jhf+
         zAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqCSnJZcue1gx6s6gyK0RsKI/3socdcMqBcqEXMJXYPJb9+0hjt8RGOFFIWxB77cRo29sl4AXOBIh2yLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeRV2voBkh3HpvzJa6BZ4hgdRBK/t7/RL2dAMfWBiBp2sdzLeC
	rlM/W0d6XCMZChDa36DA/UmQeUpHviAKEa6kz7NBbpWgzq7GizEVSxcuML92QjcJMSQAkE4OjKZ
	xqPF2wGziYcfFCp7ZL0mpcNQslpcrerbN0cJXK2EehPNmC72kx/IB2jPMMnpmchCpHRTklQ==
X-Gm-Gg: ASbGncvvjt0CIxdYGO9JF4tv8eh/GWADPYMOK3h5E+fNoIGnmyexfZg7hLUv0xqdL0L
	wncU2Fm+TXXsUQDxoIoiCDPZCOY/b6M27whfLQi2XxW7V6rMa4Deo93jMbAyR5ml2WD/ygR77jy
	sJQj2ShTBEgBaRZ82pM+PWWWlw/vMr/B3v7718wf7ZoRPLv1ayj9+ZmQwEMjsJlqctRV3aaSm2k
	LfqatZXjAYLGfctC6c0HJNx6QBp5GwiCVdo4RhOnQ/rSXa4+W5+PR+gZwn8i+ivrPKfxwFZ94rQ
	mz2jPyCIOyXWqescUA0hgIQmex3n2ThyDPAZi1hebohbgsG5y4wjlH0CyW1a6bZL4BNlLX6z/ic
	bIf517TAcFgpN768JRa1k24Cymd61x2fWaqxpzRnIXa4=
X-Received: by 2002:a05:600c:5687:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-43d186da55cmr561415e9.0.1741817949897;
        Wed, 12 Mar 2025 15:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFCZMzMhDcHcPaUJ7ZYKRB5yd0dTr+9E10/9yIGc6tvXc+O0vqyF/Y1Un5pGyf0sl4Nfe9rg==
X-Received: by 2002:a05:600c:5687:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-43d186da55cmr561065e9.0.1741817949555;
        Wed, 12 Mar 2025 15:19:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f? (p200300d82f1a7c004ac1c2c441678a0f.dip0.t-ipconnect.de. [2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a73127esm34510605e9.8.2025.03.12.15.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 15:19:08 -0700 (PDT)
Message-ID: <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
Date: Wed, 12 Mar 2025 23:19:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: Nico Pache <npache@redhat.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, jerrin.shaji-george@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
 sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com,
 alexander.atanasov@virtuozzo.com
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-2-npache@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250312000700.184573-2-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.03.25 01:06, Nico Pache wrote:
> Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
> expose it through /proc/meminfo and other memory reporting interfaces.

In balloon_page_enqueue_one(), we perform a

__count_vm_event(BALLOON_INFLATE)

and in balloon_page_list_dequeue

__count_vm_event(BALLOON_DEFLATE);


Should we maybe simply do the per-node accounting similarly there?

-- 
Cheers,

David / dhildenb


