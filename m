Return-Path: <linux-kernel+bounces-561050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DA7A60CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68AA16D891
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1611EA7F7;
	Fri, 14 Mar 2025 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmlPQqeV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029E61EA7CE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943854; cv=none; b=GNCQJ3Z78lq1/qIc5kdMsHUd4pbv7yi2HIMpsjDCpRG0SzpZ22qAcGUCCsB/M50CKwJbKBd58K7nY6fmWqkNv3gYDcyRNGqa+9ISHtrssFzMOPJ7LP6kZyIbdC/e9YQyBmh4OcwM1Igkndw1QVQCjwdy4cNXeFQ51k/3Ipl/zsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943854; c=relaxed/simple;
	bh=THKc6cgHXq5tQBfM0ia6/nxqt6XmnTZvE0u0Xd1Fcts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHYWw1SEjYiwb0VSGK4U87TL+m/1q7ZhdrTBysTcwcLLR8AuL+8bLWbAbvzbqkwUL7nVhqd1OGwRon/v+QjCaZsI42wKjbElK+Hti8ZfnU3oLDX3O+ha7W/KZAQCF3sOlyi61fEQkwyn86Ue5IsdUABWa5Z3bVIajWADSrrCCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmlPQqeV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741943851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5GkIi/IBN7pjP/tiBHlr+TqrboTW/gmpAApzoIpz2Y4=;
	b=QmlPQqeVSwfyXVPNyn3PQvc/FDm6GQ/A4vJND93FF+ETPQGtWH+VfAP/e4CeEQLAZPrNzD
	ltFFx9OtTeTKW2rzFbvWLeHnsonKSEpMTorOi9KxN00V3hdzi7uQUnga72OQjabYmhwqd2
	MCImOVn/xpJQ1x/Wmr+/eWFMO0HoMao=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-9y0PqY7YM_mg_OUhYfrsRA-1; Fri, 14 Mar 2025 05:17:29 -0400
X-MC-Unique: 9y0PqY7YM_mg_OUhYfrsRA-1
X-Mimecast-MFC-AGG-ID: 9y0PqY7YM_mg_OUhYfrsRA_1741943849
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so9723965e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741943849; x=1742548649;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5GkIi/IBN7pjP/tiBHlr+TqrboTW/gmpAApzoIpz2Y4=;
        b=dS2CmuQ1Xrl5nAHNRrrUcqQzA3jOT2GNCPxFX+V96p0IluRKVDX6BsJxxnGEmIoZrf
         GXNvTh/CdnOonbSuNgj4TUMyyAJ19QU1ziji2bh4u7KlIA4jvST8GnOtEuiadldTOHgX
         WeD+AXp7Ge3yRbYhKedqjeD2OQ6CCQREiO1DUHPs9CFkVow20dJzurHRwLFgjMg3qqwV
         bgbkvMy1J9pTc2cRh9kPSJVnFL5UbDqca1PjdPQwe5VKQlyNUbJTNJMBcKU8Pvgc/sG4
         LExsZv1Kj3BjofUfIO0ErjX+C0Z5Sj8goxCABCuA3YAgXv4z8d/ixRM2RN5TQRZpZrLD
         c0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXfAra1x8srfGdkxHvcoaMpEwyipjr8n5/SRmi/S53G52MZ25DvN2T+xv7NQKel0ZI9erDlcQ1+smcf8rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxdTl2zluYzWG9m5McsAKDXACPKUho1p6xcb1Qk5QxdEW8pmnc
	Ns4L3r5ps1LFPmFID5Ph/H98ts9RilOAGIEgswNjHGSKQ/ifdagDSe7e1e9x4VBLfqC0F5cUQ6G
	ZJgKlUqcXgsI8zGzavjHUmXseTGzGzPflhTgmWREHHX0g+s9U0QxY+DsFF+rgpA==
X-Gm-Gg: ASbGnctraH45hebje4n4N75vDdqixvmsLJDNT72pfqfmRC9zsMTbarMseU7HGIyFZ0s
	Fj4jaEJvq6COAZQgui4fjXjkLcdpfmsSdERnIj5Ptuf9gaWrJKjDdqVw0TbjpnudjpF0+As7LLg
	e5YsiUHNUlZ2b8ulHbmWPntM+ntPFRLulo9RiNOQC5EEaIl/EItIZLi8zZhmEsXi3N+OzZjPd2t
	0ko0gfpYlJRjEYHbBwLJUmRCq3f4rnTjZ20ZfI3a3rPiwZq6XDAkyI7tetoQ7T8f+TEG+1sW+Yo
	YoGeqYEK9zdKXLEmyWl0VfRUoSbryuhskg9PkYOYZu7o2d6Dwt0lnzr2OI3QcNvC+ve6i9Xe4S5
	xE04ON/h/kv+/9q/2neGrRWQqejNwly22gQsbpqmWmyA=
X-Received: by 2002:a05:600c:35cc:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-43d1ec8a189mr23259845e9.16.1741943848672;
        Fri, 14 Mar 2025 02:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQw+v0SMabSLz19VLawX8kszX1kZdwIqWnI3N7UPWe4ntjqoIjN5xJY70fAlq8M24DA+rbgA==
X-Received: by 2002:a05:600c:35cc:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-43d1ec8a189mr23259575e9.16.1741943848308;
        Fri, 14 Mar 2025 02:17:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:2000:5e9f:9789:2c3b:8b3d? (p200300cbc74520005e9f97892c3b8b3d.dip0.t-ipconnect.de. [2003:cb:c745:2000:5e9f:9789:2c3b:8b3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffc450esm10909335e9.23.2025.03.14.02.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 02:17:27 -0700 (PDT)
Message-ID: <e29293fd-b81a-4133-800a-875dcd252d67@redhat.com>
Date: Fri, 14 Mar 2025 10:17:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/mempolicy: Support memory hotplug in weighted
 interleave
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, kernel_team@skhynix.com, honggyu.kim@sk.com,
 yunjeong.mun@sk.com, Gregory Price <gourry@gourry.net>
References: <20250314060053.743-1-rakie.kim@sk.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250314060053.743-1-rakie.kim@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Hi David,

Hi :)

> 
> I am currently working on adding memory hotplug-related functionality
> to the weighted interleave feature. While discussing this with Gregory,
> a question came up. If you happen to know the answer to the following,
> I would greatly appreciate your input.
> 
> I have added the following logic to call add_weight_node when a node
> transitions to the N_MEMORY state to create a sysfs entry. Conversely,
> when all memory blocks of a node go offline (!N_MEMORY),
> I call sysfs_wi_node_release to remove the corresponding sysfs entry.
> 

As a spoiler: I don't like how we squeezed the status_change_nid / 
status_change_nid_normal stuff into the memory notifier that works on a 
single memory block -> single zone. But decoupling it is not as easy, 
because we have this status_change_nid vs. status_change_nid_normal thing.

For the basic "node going offline / node going online", a separate 
notifier (or separate callbacks) would make at least your use case much 
clearer.

The whole "status_change_nid_normal" is only used by slab. I wonder if 
we could get rid of it, and simply let slab check the relevant 
zone->present pages when notified about onlining/offlining of a singe 
memory block.

Then, we would only have status_change_nid and could just convert that 
to a NODE_MEM_ONLINE / NODE_MEM_OFFLINE notifier or sth like that.

Hmmm, if I wouldn't be on PTO, I would prototype that real quick :)

> +static int wi_node_notifier(struct notifier_block *nb,
> +                              unsigned long action, void *data)
> +{
> +       int err;
> +       struct memory_notify *arg = data;
> +       int nid = arg->status_change_nid;
> +
> +       if (nid < 0)
> +               goto notifier_end;
> +
> +       switch(action) {
> +       case MEM_ONLINE:
> +               err = add_weight_node(nid, wi_kobj);
> +               if (err) {
> +                       pr_err("failed to add sysfs [node%d]\n", nid);
> +                       kobject_put(wi_kobj);
> +                       return NOTIFY_BAD;
> +               }
> +               break;
> +       case MEM_OFFLINE:
> +               sysfs_wi_node_release(node_attrs[nid], wi_kobj);
> +               break;
> +       }
> +
> +notifier_end:
> +       return NOTIFY_OK;
> +}
> 
> One question I have is whether the MEM_OFFLINE action in the code
> below will be triggered when a node that consists of multiple memory
> blocks has only one of its memory blocks transitioning to the offline state.
> 

node_states_check_changes_offline() should be making sure that that is 
the case.

Only if offlining the current block will make the node (all zones) have 
no present pages any more, then we'll set status_change_nid to >= 0.


> +       int nid = arg->status_change_nid;
> +
> +       if (nid < 0)
> +               goto notifier_end;
> 
> Based on my analysis, wi_node_notifier should function as expected
> because arg->status_change_nid only holds a non-negative value
> under the following conditions:
> 
> 1) !N_MEMORY -> N_MEMORY
>     When the first memory block of a node transitions to the online state,
>     it holds a non-negative value.
>     In all other cases, it remains -1 (NUMA_NO_NODE).
> 
> 2) N_MEMORY -> !N_MEMORY
>     When all memory blocks of a node transition to the offline state,
>     it holds a non-negative value.
>     In all other cases, it remains -1 (NUMA_NO_NODE).
> 
> I would truly appreciate it if you could confirm whether this analysis is correct.
> Below is a more detailed explanation of my findings.
> 

Yes, that's at least how it is supposed to work (-bugs, but I am not 
aware of any) :)

-- 
Cheers,

David / dhildenb


