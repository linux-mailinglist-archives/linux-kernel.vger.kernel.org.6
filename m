Return-Path: <linux-kernel+bounces-231630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322AA919AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB06B2171E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C341940B7;
	Wed, 26 Jun 2024 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7rQK3uT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28381194099
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443137; cv=none; b=OH0DVqvXB+axrjDUqXFDN/3ZOTn0/D+T8TZ1Rx/bVLV3fKovJaqEnqYmxP/SnJqrIleFz1KJRQGVe/fjmRml/DvxIOvYX+knYFCTCkjoozvtVSJ/DAcc4SNe/n3Dj2/ZlZQ18kRIdMfuKMwmEtOqu10M+TMLtIt7y1flpRnrVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443137; c=relaxed/simple;
	bh=02dctS0qckZI68SmqhrVbWQYyj0bpLZfvmYh8yNKckw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8kHpd3f1Abq4G1NWA8lL4BUL4I8kriOTsQXlmEGmV5BteMnA8BUY5KubB8GLfEIYviY2EqSlSKfxFXIMdlWJ7GotFpcUowexpnkRZG2XIAfC7XFjXKURmvjYx0e5IDSewO4T8kDF56Quq+5pk9OZxBWRo6G70FxfSIv2sdhe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7rQK3uT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719443135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zET5snq+GgANf7Xb88R4H9xS6/00O/Gw6QjosvZEM/c=;
	b=a7rQK3uTrlV1SWwftdBydKrsbgh0qqNfxv5u+9taHInqg//haST+u8RxKzOW+uCw4eE8o9
	FyHN2jByrp6WNZeXdxOO+7DXW3InFFdcuie87UmdhHXxtmmqj7FziniqJh7pLhQ+dqc4+F
	JBn+/xETMhhwyVAnT1EeboQRxdkcBFA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-UzsIiXmtOF-oiZL0qSpGfg-1; Wed, 26 Jun 2024 19:05:33 -0400
X-MC-Unique: UzsIiXmtOF-oiZL0qSpGfg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fa9a618847so7410105ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443132; x=1720047932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zET5snq+GgANf7Xb88R4H9xS6/00O/Gw6QjosvZEM/c=;
        b=AtGPnG7GbnNcZYYY6eMZ7jvdpGcUbfd4v3G5CQZ06EE2pokXv61BJKSa/SncEol4Fk
         J52rz+JmosRSxetxYJSOpLYglBydbTpr6HqgXrgU7FNq8HA3F5CrGacN5kmKYdRWfMbH
         v/1t1ivIXp8oBLHtEkVICbNy80Vb3gxYIuLrXRID8HjXEvd5j7YQwRgvRFG0tkimLvNk
         bm2diGLhwe/RuythS2VQKCcsCrCUCHog84omLvF6BrXSR2jhHOGlPi3xGPFGDB12Fi+C
         dhXmHzWL7slA3joGjOxK1ZG+scAWXMEm6wKM6PNxumZniaMu6LX4OD8/jRp48q2PWD0f
         R4xg==
X-Forwarded-Encrypted: i=1; AJvYcCXz6zqm/aMf8Vx2osJVNZz2g1I2Bca/cJqiG0faj+FtcG3dOoVIael/4fKUmiXBrxJBE3B+enRUKdIUCvHJ57VbkszRGPA9ZUkWJT/m
X-Gm-Message-State: AOJu0YzpBW/0y0UZA2UhZIy6T54QmU3YSN0uU+hykt9yME5kkvUIpba7
	kku1f8Yo+1Bmsx3NJrsBYGUBnBZnuaGBFw5b4Ay9oI/hii2AhdkeWzSfJl/IB1uyRdoxpawWxVw
	rzO4Gc2c0SjK5aVJs1CQIX8/+aEqqEpf7reloKJXCcihxhxGoWfSnoCFEHAJ+KA==
X-Received: by 2002:a17:902:e5ca:b0:1f6:87f:1156 with SMTP id d9443c01a7336-1fa5e4f60d2mr129260825ad.0.1719443132645;
        Wed, 26 Jun 2024 16:05:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDKIiEYrW6qNT/WNZqJ/KyQhMQ1YhNuCJEqPs8rS3lLuI+HG+WIHaP9d24fT9QJEx5DMoibA==
X-Received: by 2002:a17:902:e5ca:b0:1f6:87f:1156 with SMTP id d9443c01a7336-1fa5e4f60d2mr129260565ad.0.1719443132219;
        Wed, 26 Jun 2024 16:05:32 -0700 (PDT)
Received: from [192.168.68.51] ([103.210.27.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac9c545esm250525ad.288.2024.06.26.16.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 16:05:31 -0700 (PDT)
Message-ID: <7891f768-cc4d-44c3-83b0-004536a01a85@redhat.com>
Date: Thu, 27 Jun 2024 09:05:25 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm/filemap: Limit page cache size to that supported
 by xarray
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, willy@infradead.org, hughd@google.com,
 torvalds@linux-foundation.org, zhenyzha@redhat.com, shan.gavin@gmail.com
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625113720.a2fa982b5cb220b1068e5177@linux-foundation.org>
 <33d9e4b3-4455-4431-81dc-e621cf383c22@redhat.com>
 <20240625115855.eb7b9369c0ddd74d6d96c51e@linux-foundation.org>
 <f27d4fa3-0b0f-4646-b6c3-45874f005b46@redhat.com>
 <4b05bdae-22e8-4906-b255-5edd381b3d21@redhat.com>
 <20240626133821.b2bba4fd46278fe1e4903052@linux-foundation.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240626133821.b2bba4fd46278fe1e4903052@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/24 6:38 AM, Andrew Morton wrote:
> On Wed, 26 Jun 2024 10:37:00 +1000 Gavin Shan <gshan@redhat.com> wrote:
>>
>> I rechecked the history, it's a bit hard to have precise fix tag for PATCH[4].
>> Please let me know if you have a better one for PATCH[4].
>>
>> #4
>>     Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>>     Cc: stable@kernel.org # v4.10+
>>     Fixes: 552446a41661 ("shmem: Convert shmem_add_to_page_cache to XArray")
>>     Cc: stable@kernel.org # v4.20+
>> #3
>>     Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>>     Cc: stable@kernel.org # v5.18+
>> #2
>>     Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
>>     Cc: stable@kernel.org # v5.18+
>> #1
>>     Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>>     Cc: stable@kernel.org # v5.18+
>>
>> I probably need to move PATCH[3] before PATCH[2] since PATCH[1] and PATCH[2]
>> point to same commit.
> 
> OK, thanks.
> 
> I assume you'll be sending a new revision of the series.  And Ryan had
> comments.  Please incorporate the above into the updated changelogs as
> best you can.
> 

Yes, I will post a new revision where all pending comments will be addressed.

Thanks,
Gavin


