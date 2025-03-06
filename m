Return-Path: <linux-kernel+bounces-549007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADF6A54C15
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8D018948B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A149D20E6E1;
	Thu,  6 Mar 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vw2pCUUh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB920E30A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267510; cv=none; b=KiPSAoIxRduPy9EZc4jlu5WENv4E3YeiGZPf7N7KJhxKnC9hq0cZmefBi7NlLFw/pz7urClIeh3Gtk0vzW7dRLZyWopMq30mGQdvQoT7QGIv6OJUHlWXA/ICD1I0IScpzRO5PNWgeKH+CUJjrxzYBVJVQRkKOAnhzw+p3q6HNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267510; c=relaxed/simple;
	bh=BaUEKFsnt/oGux8kiRaCu0JFUJtBvq84zkV5ZqVRACA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmKrhz5+xoRfdF0cTfhdG2Kl80DZIqoz6OxuQ8Q7RTE5tyEqQPJzcusJ1P1/C/TzdVPzpk9qibgV5TmbGEDP+Vfrpmu4MgCXo0ZiIg5YzhnPMlWdc8daEQg3N6ufGkIOBADJ+EUlPE/DKD328c7qSpfQgtkPIUxRIhNgJk/ULcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vw2pCUUh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741267507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMe2L544kp/d38WLjn3xMcZvhSWCOUekm7mNyssXwXc=;
	b=Vw2pCUUhjY8aXJ6JGkj6HVUbkga7b7M6e3g8LRAh4To14aoxmGjO9q1IjBNVNtPylaW1Ub
	GMo8VESZL8cYobIWOqyrNfYDceK1A6HX4lHw1UHrOvB7zH6i/9RXoX02lvRwgumv8UMJO7
	t9oEx1Q9+px1VkbIss2lg83fggLjel0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-lVVALDmNMKqwxf9GqNZxjQ-1; Thu, 06 Mar 2025 08:24:56 -0500
X-MC-Unique: lVVALDmNMKqwxf9GqNZxjQ-1
X-Mimecast-MFC-AGG-ID: lVVALDmNMKqwxf9GqNZxjQ_1741267495
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-391079c9798so310643f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 05:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741267495; x=1741872295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMe2L544kp/d38WLjn3xMcZvhSWCOUekm7mNyssXwXc=;
        b=fow3kR5xNjHGwdkYmmUqqG2xdUqePallkWU+1f4uLtT1wAsWvKNZWRN44ygHAmyNbx
         1yCSVMnobrBRJVUxeB+IUT5AiCAhiTaVp75Z8jsiuuXQmPNxDCdBdkrJZDAWyt3QV3BG
         YJxvOr78UE068y6bEu9zcfYvr5SMQ7kNMQ5yid+4bvKhwXmUm4P52OpuF0tNg9HT+low
         oeIgYNt7v1LdNzMZOkyQhUULPkin0QudkfU0C8aFMt0S6YiRwQBfpjjrh1JweqnzIDA2
         +8QodC0oM0dJExCknnOHRYRj2EAPNYqGKAQcdVIqKdO2uFN5GXAHkxGWiKbQzFCz6mwH
         V4mw==
X-Forwarded-Encrypted: i=1; AJvYcCV9uMNcArIfBq9XxJH952x8tYZTQ1eXX0w3G5/8Vz+4/R8+sYS883NShhycKi3iL0d5DsTZGN0sbZU1tks=@vger.kernel.org
X-Gm-Message-State: AOJu0YytVXxFEptZOY8kG+DBrV8KCKLZ+mayx4I4ZQ/j4lRTFP3Ieo0W
	Qz7Gu4sEo+obXT9snljFCoG4TMDur7EGBY8TrQ29Sa+T3uMU1jRnIftMORivOYDl43HkOlJC0Pl
	MYa8CMq/TYBzMf1o6PVWmVg7FJ075PxunqlqmKEsOmmHsDnq00oAV6qh5PCSBBA==
X-Gm-Gg: ASbGncsf+seqJYT9VokEztEb3SgB0jv5bICsjLocTqnsndeCVv9D8IcLBN7xFyRyF7j
	+W+d4a6VuasaPP08nWsh2q6HsHP3BFZ1SOb54yRI7uPcjj4EjNlwp48JZtlvVPGZToNOu6fEKAN
	LpS2euihj8458m8v+strRUy5qc+9hPlRa16bX863MreCgB0lWLGoo063xljEPlUXWuHgPFodP3T
	NQDOK3DWphkQrbXPyACqsOskQtwOCAV6/e5tuGQGvhaprowtUyNeMomyiuIIp766TVEyDMawQW3
	+gB986Kg0AdESIeLeAIJBvaFHNZbFZnG0sW1Nj/WKclplzooNohix30=
X-Received: by 2002:a05:6000:42c7:b0:390:f9d0:5e4 with SMTP id ffacd0b85a97d-3911f741261mr5096853f8f.21.1741267494952;
        Thu, 06 Mar 2025 05:24:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIwqvoLsZ7nWE/oVtc7eKMKzGDa6NvX7GYnOgsSJBfK4lxmD7NxGmoi2sk4zoXn8lH+Jx7Gg==
X-Received: by 2002:a05:6000:42c7:b0:390:f9d0:5e4 with SMTP id ffacd0b85a97d-3911f741261mr5096838f8f.21.1741267494530;
        Thu, 06 Mar 2025 05:24:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdfdsm2117782f8f.34.2025.03.06.05.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 05:24:53 -0800 (PST)
Message-ID: <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>
Date: Thu, 6 Mar 2025 14:24:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
To: Matthew Wilcox <willy@infradead.org>,
 Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, kraxel@redhat.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com, akpm@linux-foundation.org,
 urezki@gmail.com, hch@infradead.org, dmitry.osipenko@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-mm@kvack.org
References: <20250305152555.318159-1-ryasuoka@redhat.com>
 <20250305152555.318159-2-ryasuoka@redhat.com>
 <Z8kp9Z9VgTpQmV9d@casper.infradead.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <Z8kp9Z9VgTpQmV9d@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2025 05:52, Matthew Wilcox wrote:
> On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
>> Some drivers can use vmap in drm_panic, however, vmap is sleepable and
>> takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
>> requests pages with GFP_ATOMIC and maps KVA without locks and sleep.
> 
> In addition to the implicit GFP_KERNEL allocations Vlad mentioned, how
> is this supposed to work?
> 
>> +	vn = addr_to_node(va->va_start);
>> +
>> +	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
> 
> If someone else is holding the vn->busy.lock because they're modifying the
> busy tree, you'll corrupt the tree.  You can't just say "I can't take a
> lock here, so I won't bother".  You need to figure out how to do something
> safe without taking the lock.  For example, you could preallocate the
> page tables and reserve a vmap area when the driver loads that would
> then be usable for the panic situation.  I don't know that we have APIs
> to let you do that today, but it's something that could be added.
> 
Regarding the lock, it should be possible to use the trylock() variant, 
and fail if the lock is already taken. (In the panic handler, only 1 CPU 
remain active, so it's unlikely the lock would be released anyway).

If we need to pre-allocate the page table and reserve the vmap area, 
maybe it would be easier to just always vmap() the primary framebuffer, 
so it can be used in the panic handler?

Best regards,

-- 

Jocelyn


