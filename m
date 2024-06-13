Return-Path: <linux-kernel+bounces-212813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B82A9066B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D896B28183E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528AC1411C9;
	Thu, 13 Jun 2024 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1P4D2lq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579813FD62
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267243; cv=none; b=n1KiLtLBm1sgCOaygU1zdeWypEsa/v8FA1z49QCQjhItM3JYtmpKMcBnNkBBTcfxtFro2T+52uJx79OMXq5THBqltcbIDdBsIlhaToT1vOTEoXDF/HA5VomangRPJV+Ffja/ma/c0SGED9Jo7ijlmnM71N2AX7re2hYO6uTxNks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267243; c=relaxed/simple;
	bh=ZiTfm7/eJ2eyw+0nKfltvTpsR2zfA9whPvntBhMJaYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Od34GLdDO8dy57zpCx1cWbJN5R8T6AkGbEtPXlQJkfF6Amgskr6NGBdJIQr9CoJyeLjH2TSZJwZK5HWsKRHREmQ1N70TSg2Qiy7YuFGpxungoDI8AzdauJZHUzocB8bYbYDEKDXHaienbtihIckaEz3mIHqq+jXxMAV9w+wj0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1P4D2lq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718267241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mVWbEwLkmTG3QxviBeXZ0j8iNWtBX8pqTS6OYMhDmzI=;
	b=C1P4D2lq84bX8jMgnHRz1C6XYVr0cW6dldauH+P6FwXcheFL4wycNHUOXJ5CovUq8OdHy7
	0cYFhEvxRnmz7b+j1vJs5tq4W8kpSZBYvSikR4lwyTB8N5Byu1C7NjwMf7c/ThkQB5VULn
	WQrBIwR4sRlZJq8xdct1fbVbYNFUzfo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-pC2wnjM1MBybBatoMSHrBA-1; Thu, 13 Jun 2024 04:27:19 -0400
X-MC-Unique: pC2wnjM1MBybBatoMSHrBA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f271c5b17so382573f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267238; x=1718872038;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mVWbEwLkmTG3QxviBeXZ0j8iNWtBX8pqTS6OYMhDmzI=;
        b=ozPRr3FFI9xvoJ6DFFcp15fjq09R4Q8Y5bGbSqsH03YpQkPqMyYP5oT83oYQa0RMcf
         V07Pmddr0UziEXf23wxagCoZVTw0BIIQ+SfG9Dp+ZtyMNC7dp5UbTv+GSGlhZtKxlKkm
         gfk7bec9424XUQeLynyZw5EGp+Cdk3AHnYPUPAfdoXObV7Vu8GcvwbyFpEtUrVRz0pAr
         +tT7LUxx/ox6OLhj7cNH48ueAWhzGcCFYNOq04nRoRTh0wxMkHNCNtGKm94AL+qZBaS/
         TOzldC/CY17+agWZ5r4oQ+HS4oIZsn4oeDzdqGZ92xkx76a8AbLuWXDypCRA6msBWd/A
         Pi2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvBXpKI9EbWB7hjsNnwc9DVZ45t7R1v5WQzwbLqQbvGVlHnSZXrf55VZ6Y8ohYF4ynXMNAoCv7l46JWM9/e7oUBxHZu2wo7EQD3AT8
X-Gm-Message-State: AOJu0YyX6SEHN8rd9yAR1A3PPwGo2kdPTVNPd8odHNLlLLadv8Yq9qD7
	DYUt1Lsz1bP1NnokjQMQcmVMKgrMS7RGJy2vRGsoFY586dNL8X852VAPcz7XBDPldB34ev92/ia
	GfLkUOhY30eTDMXweblHsAter3O//1yZa9xR1lg9TqcvM5IF6EH8OUlDdo8emdw==
X-Received: by 2002:a5d:4a4a:0:b0:35f:6bd:e5bd with SMTP id ffacd0b85a97d-35fdf7886e0mr3331019f8f.28.1718267238117;
        Thu, 13 Jun 2024 01:27:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDUhe1bL30rQmXpqr/MZocb4PwSZe7VvtVDrLJh4moreiNqON5efdkqCl2GrLvnkyKLDNAUQ==
X-Received: by 2002:a5d:4a4a:0:b0:35f:6bd:e5bd with SMTP id ffacd0b85a97d-35fdf7886e0mr3331006f8f.28.1718267237726;
        Thu, 13 Jun 2024 01:27:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:fe00:10fe:298:6bf1:d163? (p200300cbc703fe0010fe02986bf1d163.dip0.t-ipconnect.de. [2003:cb:c703:fe00:10fe:298:6bf1:d163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2271sm976489f8f.85.2024.06.13.01.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 01:27:17 -0700 (PDT)
Message-ID: <be85ddcc-88ee-4f8d-9f73-b388f4d47b71@redhat.com>
Date: Thu, 13 Jun 2024 10:27:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] mm/rmap: remove duplicated exit code in pagewalk
 loop
To: Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 baolin.wang@linux.alibaba.com, maskray@google.com, ziy@nvidia.com,
 ryan.roberts@arm.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240610120209.66311-1-ioworker0@gmail.com>
 <20240610120209.66311-2-ioworker0@gmail.com>
 <CAGsJ_4y4sKXbq4_ra9tTD-LWgB-x-HECyouxm_9r_N7Kw2We4g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4y4sKXbq4_ra9tTD-LWgB-x-HECyouxm_9r_N7Kw2We4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.06.24 09:52, Barry Song wrote:
> On Tue, Jun 11, 2024 at 12:02 AM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> Introduce the labels walk_done and walk_done_err as exit points to
>> eliminate duplicated exit code in the pagewalk loop.
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> 
> I don't think "return false" necessarily indicates an error, so
> "walk_done_err" doesn't seem like an appropriate name.
> However, this is a minor issue.

Agreed. As we only have a single walk_done user, should we instead 
remove "walk_done", keep the "page_vma_mapped_walk_done" for that single 
user, and rename "walk_done_err" to "abort_walk" ?


-- 
Cheers,

David / dhildenb


