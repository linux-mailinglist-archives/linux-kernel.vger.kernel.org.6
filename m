Return-Path: <linux-kernel+bounces-188590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49088CE3FE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08247B2207B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39B685937;
	Fri, 24 May 2024 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bzti4vSF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1007185631
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545105; cv=none; b=AgrlpAVS+G6AOY4gsapvcHHf1u/tVzShINR548NBDJqyVk/Jbtij6oCCi6tjYxt7tcUAPOx1VUXkB3qxLvtN8adCQcIcOfoJizp6StZB0Dw0a3/emFGsm3YTMT4AuYzwawvITsntpQt+1bTj1eF1bj7DPwSlT8/qFuJV6ERJg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545105; c=relaxed/simple;
	bh=bgbmxdThfo3OyAMsYkFF5vKnqyMuTR5MnlYqB4DWkwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5O3VQVGHesI7Ii7EUj2GrJiAkDhzOi2CCoI1BO6aq9F4QpctY4mXBq4Z/eoxhlnoCXwwenvp8uue9JTUeit8XoSgYEBZYpHNi/6crCSg9v5H4Ht/fu1NzYVryokQ/9fdu8hs5UcOG/VyUkA5geR6axCVjBZTg3nhsTVdu02dzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bzti4vSF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716545103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0tqPEqXzpdrWLSDfzE9+RYZErKg7lcDK/U8gukkaq3Q=;
	b=Bzti4vSFJzqb/0BUbkbziML94X1Xlv3CfUNp/C2D7lcDckRtSCnm1d7Mw1A0r2lHqP4s2Y
	A1DKVjv81a1+Ww/F4HqwiFl1FvaIvzBWYsvE/mgwEzAFGBnvZHG4so3vLJOw9LuUXANKuu
	5Jaf37dYmYWinkWy6gDY04K/VmVrAfk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-eBZOudeiO9GXpJBbWayCbg-1; Fri, 24 May 2024 06:05:01 -0400
X-MC-Unique: eBZOudeiO9GXpJBbWayCbg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4201248bcd4so452525e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716545100; x=1717149900;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0tqPEqXzpdrWLSDfzE9+RYZErKg7lcDK/U8gukkaq3Q=;
        b=w0EVqjOksWlg8CqG0hJzkJbRSICKkAlZ/CHyp0AcxmVWOGz7iGKrq0rhxmiuyo/Nsu
         8m8FF9Eh+7aK5A2yLmivzRmX05gLWzEg+zrmT1oxF2U4+vjupv4bmm6xZWgcu8A3S69s
         8uR43P10dNxXe7L6O0r0/cKDTQ/iUtoUAQH89mJPjzW/0VkCV5RxXKjMBOqYE6z2OhwV
         hMyIe/YLhkwUwm6VVm9zguyTaj6TreiP9NuqieJmLCnotK6aCN9hLq7LQQc3ap5TmlpV
         cSyFVRUBKt6i7zmwpE0z26G/i6IOq2M3RFaCw+lDOPUBLr0Qh+vbsrSSP+vXToYx80FP
         f1Gw==
X-Gm-Message-State: AOJu0YxBTDazy2JS+/xNgsjxqLm5dZLbh+Lmp23UtWF8N7BZtyU2gjuX
	cIlctBbc7b7PcFRAygdFB32hNSzO822gaHmq+BjzLDD0L5JGeF4ct4n/EoXn9tyrXMd0+eKf9ri
	bpyUOpU+9okM7LR8lDtm8ED4ON1BaOWa5/Ph0KWXWMjo8XvrAk97dw/gxpNK9AXPhi39QEOSaxf
	1ZnQO6D1ui6BUWMUfi3w0zKc5e+qfl+RpbL2QFy9rt0g==
X-Received: by 2002:a05:600c:3552:b0:41b:e406:5ae6 with SMTP id 5b1f17b1804b1-421089f816fmr13306095e9.9.1716545100566;
        Fri, 24 May 2024 03:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJnxxG5qQ6YaT7VBUS6F2j0w0cnfRCjEd+/YfQzE2Xare2Yg22u6sGQVGwlJjKwOKWN8YSJA==
X-Received: by 2002:a05:600c:3552:b0:41b:e406:5ae6 with SMTP id 5b1f17b1804b1-421089f816fmr13305875e9.9.1716545100026;
        Fri, 24 May 2024 03:05:00 -0700 (PDT)
Received: from ?IPV6:2a01:599:31a:f535:61b2:4e2f:ddce:8bf? ([2a01:599:31a:f535:61b2:4e2f:ddce:8bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420fd37d5c0sm32948985e9.1.2024.05.24.03.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 03:04:59 -0700 (PDT)
Message-ID: <ade04ce0-91fe-4773-b10d-f9bb77f4edb2@redhat.com>
Date: Fri, 24 May 2024 12:04:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/6] mm: allow reuse of the lower 16bit of the page
 type with an actual type
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20240522210341.1030552-1-david@redhat.com>
 <20240522210341.1030552-3-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240522210341.1030552-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.05.24 23:03, David Hildenbrand wrote:
> As long as the owner sets a page type first, we can allow reuse of the
> lower 16bit! Restrict it to the head page.
> 
> We'll use that for zsmalloc next, to set a proper type while still
> reusing that field to store information that cannot go elsewhere for
> now.
> 
> Fear of running out of bits for storing the actual type? Actually, we
> don't need one bit per type, we could store a single value instead.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Likely the following might be better if we want to go down that path:



 From 39f198589039451d94166f3893dc939a919f74c7 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 22 May 2024 21:57:43 +0200
Subject: [PATCH] mm: allow reuse of the lower 18 bit of the page type with an
  actual type

As long as the owner sets a page type first, we can allow reuse of the
lower 18 bit: sufficient to store an offset into a 256 KiB page, which
is the maximum base page size we support. Restrict it to the head page.

We'll use that for zsmalloc next, to set a proper type while still
reusing that field to store information (offset into a base page) that
cannot go elsewhere for now.

Fear of running out of bits for storing the actual type? Actually, we
don't need one bit per type, we could store a single value instead.
Further, we could likely limit PAGE_TYPE_BASE to a single (highest) bit.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/mm_types.h   |  5 +++++
  include/linux/page-flags.h | 20 ++++++++++++--------
  2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 532a3030405d..437a62bed277 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -168,6 +168,11 @@ struct page {
  		 *
  		 * See page-flags.h for a list of page types which are currently
  		 * stored here.
+		 *
+		 * Owners of typed folios may reuse the lower 18 bit of the
+		 * head page page_type field after setting the page type,
+		 * but must reset these 18 bit to -1 before clearing the
+		 * page type.
  		 */
  		unsigned int page_type;
  	};
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 104078afe0b1..2f49c8b2f411 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -945,14 +945,18 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
   */
  
  #define PAGE_TYPE_BASE	0xf0000000
-/* Reserve		0x0000007f to catch underflows of _mapcount */
-#define PAGE_MAPCOUNT_RESERVE	-128
-#define PG_buddy	0x00000080
-#define PG_offline	0x00000100
-#define PG_table	0x00000200
-#define PG_guard	0x00000400
-#define PG_hugetlb	0x00000800
-#define PG_slab		0x00001000
+/*
+ * Reserve		0x0003ffff to catch underflows of _mapcount and
+ * allow owners that set a type to reuse the lower 18 bit for their own
+ * purposes.
+ */
+#define PAGE_MAPCOUNT_RESERVE	-262144
+#define PG_buddy	0x00040000
+#define PG_offline	0x00080000
+#define PG_table	0x00100000
+#define PG_guard	0x00200000
+#define PG_hugetlb	0x00400800
+#define PG_slab		0x00800000
  
  #define PageType(page, flag)						\
  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
-- 
2.45.0


-- 
Cheers,

David / dhildenb


