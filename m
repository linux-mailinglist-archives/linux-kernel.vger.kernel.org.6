Return-Path: <linux-kernel+bounces-323033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C139736CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1291F27B78
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB726190679;
	Tue, 10 Sep 2024 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKmcch5z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF92190499
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969913; cv=none; b=kaytoPQ5zeNkEJnU6HOu2tPuywuCy1jFJ9eUxf0J1naHPNhWRrSmUH1JkYZHicKVWYkIbL1RMVtuix3RUfnhR/WKhhHKYM6sDNYG+/E7wwHy77en18pbzjA8vAb0M2ept4CJF78oAhNQM2vILPGhMYzdN7cSm7xLQJhojG99aMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969913; c=relaxed/simple;
	bh=3DV0nP1VJNF2wZ4UZtBbxCoSZtFSbbjgK+rJjtCfInw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gk0QbIwO79gCWaN5lfPrYlCrPhZICFci7x+jwQyb4n8+3KTKe2TUqCL45pF8vKvXXdUIgSFvdVaZtibH8q3S787rvksYIUMG9gNZylQ93CC3boV5jy+qoNrsq189uii/9dnuJ/2GBbAdjMh5ABT5zGj3bmXib/Ljbss/oNeM0jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKmcch5z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725969910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mNVoYR8CnHCdcfhh1/cVrFkmoFx1fp/KKqjSmtszl0s=;
	b=JKmcch5zD43eO51PLh3FBbnRWtwyQ/ADEirEHZ46w94vCU73XT2T7D/hb8P948Bm8l69Q0
	aaAIYDuJbZfTPitLaWd0z57/BNIwyziZ8skqQF232qguTqO3yftvrrsrpyJPg9en4fsfmD
	1binTm3gxaK3/rjUVT+ztEyXQtywncM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-tQzNGHkpMwae0LvpZ-H9DQ-1; Tue, 10 Sep 2024 08:05:09 -0400
X-MC-Unique: tQzNGHkpMwae0LvpZ-H9DQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb5b01c20so17860715e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725969908; x=1726574708;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mNVoYR8CnHCdcfhh1/cVrFkmoFx1fp/KKqjSmtszl0s=;
        b=AtMV7T4PTOJhHT++5Qb601A4w7CiMj1mcbAh6JM6WQJ1qSeRQA7GEzCgdO8+4iYKEg
         YZWC4WdLQaAWQk/6E7tjwXDiyYIyjP28kr1X8lHVTwlCwfozI1mSxrtHMuaGL1DfxCIt
         pj6FstVAO/qv2oMsFoBaWoSiVksIP9lTSdre9OBjhKBAcaY1r0/5pmXclSrqTan1DSJC
         tB3Vc/F6vflhH7/JzE01T7IMbsWVjEwwCqyIUhmIW2tK26rtn1vqeBWHah+gsUzh2Ku2
         TgYPLyV7Ht7gLLVJ336XMgH9+uY7lLSoLUc9vzZNs0ml84FdUp0Zd/GeKZW4iE/eXVuK
         JnmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa9wSpftBUlKpmMNqvewSmSUJ+fUxfliFWCbeEKvx6K3OBlGKnWhqlyDdK+I3jYgblUxHBkc4feKUTrek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWw2OLk5HZy7ChrWB/L2E4JgE3PAmxUWFZV9wbT0gSPydUrdhJ
	4OKheu37bg5YxP+tOXfUdmhzPPu8RYo9zLHs1Il1lEmDsauKyApYRwv88RhN6IUTzxogjine8ns
	UykNOyZf60i05bU8YZQ+HTDP2GdoxZWP9PlZn4yLUpehqMRC2H4swrfnqk+4fRw==
X-Received: by 2002:a05:600c:1d1b:b0:42c:bf94:f9a6 with SMTP id 5b1f17b1804b1-42cbf94fcedmr16164255e9.26.1725969908175;
        Tue, 10 Sep 2024 05:05:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0c10FYhpv3HGodLiSNAY3IPMKMnVVTRQgwkQVAmkCKKnYQbQX2lzkXzvrrJgWQn8rXnUrLA==
X-Received: by 2002:a05:600c:1d1b:b0:42c:bf94:f9a6 with SMTP id 5b1f17b1804b1-42cbf94fcedmr16163995e9.26.1725969907599;
        Tue, 10 Sep 2024 05:05:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:b600:cfda:b383:a116:a940? (p200300cbc706b600cfdab383a116a940.dip0.t-ipconnect.de. [2003:cb:c706:b600:cfda:b383:a116:a940])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8182dsm110447895e9.36.2024.09.10.05.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 05:05:07 -0700 (PDT)
Message-ID: <35021b64-df98-4a43-be48-c454b7a95b93@redhat.com>
Date: Tue, 10 Sep 2024 14:05:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/debug_vm_pgtable: Use pxdp_get() for accessing page
 table entries
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
References: <20240910115746.514454-1-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240910115746.514454-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.09.24 13:57, Anshuman Khandual wrote:
> This replaces all the existing READ_ONCE() based page table accesses with
> respective pxdp_get() helpers. Although these helpers might also fallback
> to READ_ONCE() as default, but they do provide an opportunity for various
> platforms to override when required. This change is a step in direction to
> replace all page table entry accesses with respective pxdp_get() helpers.
> 

Quite some work ahead. :)

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


