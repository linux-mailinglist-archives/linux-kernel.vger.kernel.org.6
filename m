Return-Path: <linux-kernel+bounces-255088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F655933B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D721F23D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC09317E8FA;
	Wed, 17 Jul 2024 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjtEnEAZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58957179A3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214066; cv=none; b=nnX5Nn9gUQESItc4FTf/tI7eneKWr4+hRMbGw0QetRUFAozkqxNOy/2v0LEvCtpWemVAgkApmcfAouc0JVX0M2wngmyG3vvP2tZRouL99fvT6/ZeyaBQtEo7pevwTFayXeLazmK72TP+6ZzMMNy2j9YKu+RjUF6IjmYgVKa6JiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214066; c=relaxed/simple;
	bh=AChy2hQDV00OusYvLxpXqArAsWpgGwK8GFoWsKMnWu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGk9IZAM45cjBlonWCtYNTOfrZooCOPIsDgZz8oiw/zDVTemsD1N8/GhW5AqsJyrj6O+WNGSXOWMPbpwPtK0KKHVlEtqxIbvd7pAYO7KKSUMhnlrbWHsg1IqHKCa4gL5F8FNRSOPEw4HhqLjtrpbYzvLu/VaH5AQkdh/HNPrp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjtEnEAZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721214063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3dokGBRJNRPX4aDNhf96lE0TemV8Sinj+IipwlZ/PiA=;
	b=UjtEnEAZcsV2/y4rwXlMlowTc7q1ptcWXufr3Neq33zB/G2CuvCjUoauN36BnCNvDH7rqe
	scGuSo3m2Uk5hQESDHvVq9f7SGw414/7Obkno+WcK/xLCp2E1Kmpm5TDC3tJycN4lcG0zT
	Mm/3MI5e/j/TYXTCncPQH+f72MbjmM8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-xFgvzIccPAOTkKYFQgrlww-1; Wed, 17 Jul 2024 07:01:01 -0400
X-MC-Unique: xFgvzIccPAOTkKYFQgrlww-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee87d500caso65413131fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721214060; x=1721818860;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dokGBRJNRPX4aDNhf96lE0TemV8Sinj+IipwlZ/PiA=;
        b=eF47EuqnLYMbTfeviFV504rl3OXHl4Ag/5yLYjaYL5K2TzwhL39caD3ZEfFgHlMhZC
         5S1wd8hIvF7qNVpZrFJQaZ9I9FNWmPXQXwBPP9gmACJd7Ebo4YPAamaWFv2svI02kGob
         SD7n+zZ8PUJGNNi9Hc/LtGxNxtSI1a/BFL+jnU4U45Dw31kiAhbl37c2qrIBrurD+h3f
         Bi21hltRmWClmiJp/iud5MmybYQSWUuELmHoFaSJnIse67dr+iwMDy6Fogf5FZ1ilHfW
         OueXziycxyJPoGfylI/iZlwyDallyOO4qT408Tv4JeYTVOr4HV0n8n8l2AHrizQioiXL
         TBDA==
X-Forwarded-Encrypted: i=1; AJvYcCWP0A+Ua4EQ6hgK72ZCjxVO0hb3q/++R+ZiBusVjbbb8XnUZ4KYyl6naHy+p58wEGWxtHguunGz+k5yz27afqaK1H8s+s5cCWTVwzL2
X-Gm-Message-State: AOJu0YzKQy7lqdIlkoBmVAzQTiJo0ACIjFlnhiI9A8MTSjHTfpKBJAfg
	nZOa/hu07/0OJN51LZwh5WWjjtUgmP0kofDixYMEKZNTno9bc7MWLOT/5oxUQi0RKeedeDG7IAl
	GRpQK5eTdskduwRK56FWqYDuleemLda3mHDnMKh6RgJYntr2eJi/26iEocYSKjA==
X-Received: by 2002:a05:651c:201d:b0:2ee:bcf3:2686 with SMTP id 38308e7fff4ca-2eefd0ae355mr8730161fa.21.1721214060339;
        Wed, 17 Jul 2024 04:01:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcZ9Od4wgDKc6WEeGi24L5FDxYMjC4X23trcMFTV8Ot8EMEAEMHaFlb/NzL91WTKBaTxT4ww==
X-Received: by 2002:a05:651c:201d:b0:2ee:bcf3:2686 with SMTP id 38308e7fff4ca-2eefd0ae355mr8729881fa.21.1721214059803;
        Wed, 17 Jul 2024 04:00:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:c00:b08b:a871:ce99:dfde? (p200300cbc7140c00b08ba871ce99dfde.dip0.t-ipconnect.de. [2003:cb:c714:c00:b08b:a871:ce99:dfde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e77488sm169682395e9.9.2024.07.17.04.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:00:59 -0700 (PDT)
Message-ID: <e3c17dad-a93f-4885-8f14-69874be76482@redhat.com>
Date: Wed, 17 Jul 2024 13:00:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression on linux-next (next-20240712)
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 "peili.dev@gmail.com" <peili.dev@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "Nikula, Jani" <jani.nikula@intel.com>,
 "Saarinen, Jani" <jani.saarinen@intel.com>,
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SJ1PR11MB6129A77D51B206E29E242B95B9A22@SJ1PR11MB6129.namprd11.prod.outlook.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <SJ1PR11MB6129A77D51B206E29E242B95B9A22@SJ1PR11MB6129.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.07.24 07:37, Borah, Chaitanya Kumar wrote:
> Hello Pei,
> 
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
> 
> This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
> 
> In version next-20240712[2], we saw the following regression (currently being masked by another regression)
> 
> `````````````````````````````````````````````````````````````````````````````````
> <4>[   14.530533] ============================================
> <4>[   14.530533] WARNING: possible recursive locking detected
> <4>[   14.530534] 6.10.0-rc7-next-20240712-next-20240712-g3fe121b62282+ #1 Not tainted
> <4>[   14.530535] --------------------------------------------
> <4>[   14.530535] (direxec)/171 is trying to acquire lock:
> <4>[   14.530536] ffff8881010725d8 (&mm->mmap_lock){++++}-{3:3}, at: unmap_single_vma+0xea/0x170
> <4>[   14.530541]
>                    but task is already holding lock:
> <4>[   14.530542] ffff8881010725d8 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x6a/0x450
> <4>[   14.530545]
>                    other info that might help us debug this:
> <4>[   14.530545]  Possible unsafe locking scenario:
> `````````````````````````````````````````````````````````````````````````````````
> Details log can be found in [3].
> 
> After bisecting the tree, the following patch [4] seems to be the first "bad"
> commit
> 
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> commit a13252049629a8225f38a9be7d8d4fc4ff5350e8
> Author: Pei Li mailto:peili.dev@gmail.com
> Date:   Wed Jul 10 22:13:17 2024 -0700
> 
>      mm: fix mmap_assert_locked() in follow_pte()
> 
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> 
> We also verified that if we revert the patch the issue is not seen.
> 
> Could you please check why the patch causes this regression and provide a fix if necessary?

This is know.

There is a discussion along the original patch [1] on how to do it 
differently. But likely we'll tackle it differently [2]. So this patch 
should be dropped for -- which I think already happened because I cannot 
spot that patch in mm-unstable anymore.

[1] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/

[2] https://lkml.kernel.org/r/20240712144244.3090089-1-peterx@redhat.com

-- 
Cheers,

David / dhildenb


