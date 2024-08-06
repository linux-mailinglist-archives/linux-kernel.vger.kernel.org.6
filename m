Return-Path: <linux-kernel+bounces-276137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F63C948EF6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74AFB24A32
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B384E1C232A;
	Tue,  6 Aug 2024 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIaX8MjN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C876614B09E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946836; cv=none; b=EBADr+Ia4BiSIiC2SJkfDKCK/2fdkJsLhd2YZ8u1rcK09WN9S4DmTuOMX40Soq6l08Jy0QbZlS0dDtLKWZ5YYEtHJNjS9eI/xRIOu02DkUb6wX1IejGSUq/CeilC5t1/pg8GAGSgtXkya6IpKxFKetlIOxEdKhBnDPmQgmPveDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946836; c=relaxed/simple;
	bh=D+fU/h9Pg+8ffiV+liQ2mr3AusJyO9FzCYZmAp8QDPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNVXyOa2pnKzN+KyqgB30+UWfOxjuyqsvLHgGR2TIwB4dr9mgE3bbhROd7pV947z7MBZFsx9xcyzxbzOMqiBpYdYDn1zm5fW9mPGdB5AHVOahQhM+x2uDF2RIQ0+oiWYyuILxKlOmG96U9Ot7h0uZ6OrYauamed5pvBXylODXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LIaX8MjN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722946833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dYWkviuy0Tt7wZeAYaicO3cGWzRQUVavdPWcWIASrFQ=;
	b=LIaX8MjNM1uk/JnksejKGz99/zoIVb9dg6f9aj0sIEh2/SMesUl7BsMYTW6b8P/EEj7Odt
	aAOzOtdn+1sgJnvfj6UYfVgAhzMR9bd5ztfx3SoE81BEmbztpLvpR1qK8ue2W5DY4ufNhA
	sT39w75keJwlbsTmrKeZz4umJzo3ZHQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-k1in1yo_Na6lNNBMsF0R9Q-1; Tue, 06 Aug 2024 08:20:32 -0400
X-MC-Unique: k1in1yo_Na6lNNBMsF0R9Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-369bbbdb5a1so397010f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 05:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722946831; x=1723551631;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dYWkviuy0Tt7wZeAYaicO3cGWzRQUVavdPWcWIASrFQ=;
        b=FcTm9iJ0qOMn/TK7CoZvaaZjIdtkXX33I+7yXsyXlWb435hAZmChdg/VplSZr2cgC4
         Qs5y1pICYBdk0QwJD6RE41hTJQocV783VcYpPiOS86z393xs1XVvdq8zq7Yta4N/ml7W
         JYtOHv1AfiadPx3JOM4IfmV+z2tsfSCfM774N/zqQw287AhiY5KvMy6akw+qr4Q/+IEP
         aku5BHdsZ0WI7Oy5fU47NJ9HQtdlGHvxXofHZupq2TR9X4kpz+Ojrt6/2sjONCJZrao/
         F4e/9eknHrVC6NAD8R53KkSePjAUWsbkNn4tV58TTkvk6Svd0S1jgHkXZ3aHw/EJnVmq
         0lBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcSPURMoUQY5SOUPQZHtjXzEsEVvgcfFs6tefCRdqATow8YwnF7Y/9RkckBlSj8CSlJj9r3Y6imsYffm6hc3eLQEbVoYp09Z0w4o/H
X-Gm-Message-State: AOJu0Yw1kvWCPD+KL6BmXXABRDXmQ4Iq0xiMM0YFCFF3PEv1QtXJmwN1
	vWo+ha3hJnpMiONu6EQzAc2DdcqIU+zGHkRE62UnVs73xLPpDARPVl1PpOr4lLiqTMVDIZgxnpg
	IGzcsKGjNjgT8T4/y92Nq5xa/jnHfMP4I7NDL6LHg55T0X4rKhtxMjqmYSgfW8g==
X-Received: by 2002:a5d:64ab:0:b0:366:ea4a:17ec with SMTP id ffacd0b85a97d-36bb358466fmr14249903f8f.2.1722946830959;
        Tue, 06 Aug 2024 05:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ0guGiYFvJG0fyTYUADCaSwXT0ljE04MG6NBIh/epGqXZIPPvUCn5qo+2okHKByIrld4xQw==
X-Received: by 2002:a5d:64ab:0:b0:366:ea4a:17ec with SMTP id ffacd0b85a97d-36bb358466fmr14249874f8f.2.1722946830467;
        Tue, 06 Aug 2024 05:20:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d6b8d9sm176440655e9.7.2024.08.06.05.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 05:20:30 -0700 (PDT)
Message-ID: <08f557a8-320f-49ec-b882-9430d27b0185@redhat.com>
Date: Tue, 6 Aug 2024 14:20:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] mm: Add a helper to accept page
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mel Gorman <mgorman@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Mike Rapoport <rppt@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
 <20240805145940.2911011-6-kirill.shutemov@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240805145940.2911011-6-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.24 16:59, Kirill A. Shutemov wrote:
> Accept a given struct page and add it free list.
> 
> The help is useful for physical memory scanners that want to use free
> unaccepted memory.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


