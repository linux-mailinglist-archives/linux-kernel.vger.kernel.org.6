Return-Path: <linux-kernel+bounces-541638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7223CA4BF5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7BC166EE9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C7120B7F1;
	Mon,  3 Mar 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBZb9jfo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F381FFC5C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002765; cv=none; b=sE+kCWqTPJZlbeEdoUm5KGmpTJ5GxksTc3IIBzPh1/mof4QrztarvjKj3pooHVAwsWGXSqKN77SHbaHTG66RAqaUkoNl9NI0Up1YqZaNSeCMzto/qjKNkynXl6MQ2NxRh7DPKgEYjFGNhymMlC+c+r+a0UaeuPx6Z+VkPtioL1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002765; c=relaxed/simple;
	bh=VIXVy0Vgd4Rql2nTDf98+umBFv9TyoSll23VSHicPPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ca5/8S1IeMZexL0XTLsU/6lgCLI4I8tOVrCKM86SFVqELtp5aLcp2N/S8FuWZUQ9TsU5et+KS980PYORUcj0dtGRc2n5mMwlzrMn+D5X37uIqCskcU+rUwpZrFUR/KBs7jNWY68EPGC/+iypnIIvEA4bCXNIM2/TMrXf2JdfAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBZb9jfo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741002762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WCQNb4Zwl01zkLUWNEjK6UzQKXJ+OotwjxENzLzaBD0=;
	b=JBZb9jfoF/2Jc5pQ8a9qhXwCqOrU0trDt45ccpP72/STdaxHmfWYHMcvCdkRxxSs8BKAxF
	dOe7XcSDb7+ipMQCj2Bq6xyfCjnNU0u6osLDjiSmxMWiBefjedqfJ09DSIu7l0u09Gy99I
	+5dM9nU0t81tchF3SbAwyuO1dPU4qT8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-AfqEjAIUMJ-qLblZpVfRPQ-1; Mon, 03 Mar 2025 06:52:36 -0500
X-MC-Unique: AfqEjAIUMJ-qLblZpVfRPQ-1
X-Mimecast-MFC-AGG-ID: AfqEjAIUMJ-qLblZpVfRPQ_1741002755
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so19207185e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002755; x=1741607555;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WCQNb4Zwl01zkLUWNEjK6UzQKXJ+OotwjxENzLzaBD0=;
        b=hMSJvujD2vm+o2b9+nPuLvn9M+W/Czw67j0D6MeBodPZsyGwrbMJzvO0UeeOteLoxY
         Z8yLxYIUZDR5GB5IvNBKghCGhXVRCto1+XzRkZdsBkfYqOLb/y11gMfIDfGQnJD8ihte
         JbhWvSEyJqtWmDMNXUzPNL40usRE/8Lp4md5l9kJPh8sOI9P/9p/SHLq79Ewiy5H9Fs9
         to6WlW6tiopIlC5JNsk6ffuMPjd7M7b8Hf10Kbc0+UpUEBf7XAQLoeE5ES0tw1Pq4ltA
         3oi4wswpeU1fmRdmvSijQRg4PUYTY4SNBJkx0SCbxdS+rzBX2JRPW+xq98MuJX5KqLkD
         i+0g==
X-Forwarded-Encrypted: i=1; AJvYcCWTKx8n3TGbaFth34gd58nVnH8GOH6WsKRZDLxYALlPGa1LlwArd8HyKNUXaT8eP4M11pVDsFNaUnxDYuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/ZtmjMvvAah1Vi21wjHKQrKfFJXLi/buCpvyEa9JvJ95xqsS
	kgOBMgRISvItL8O8uTdG6y+akyLArcO8Q+RGjk59YsCBg7SNE6LWZi8ZOy56WBJG1Mk8pN6UE1S
	y/LZ4D2tndJcD3rARmjDFslPK0YS8qj0KYE+BRvJ4OkUY1tGntUE0r++loDwv6Q==
X-Gm-Gg: ASbGncug047qRyIOUWDSySdRuD14/ZFtDR/T601kAQrUZXTPpE0jFWfI1lZxapFVfmQ
	x5p1Eq5Mpi8Zy+HE6/1HM6FQVO21PTMJbep+xb0U+KKa05FRs07dHAvkG9O9DwskLrs1+R/JgAZ
	KzMiyZKD7TpmTCgZ16ht2s1SgZ9sjLaqtoJyfzAKEl4Wfh8tEQDCLzE9HDsnAtPm+YzHeBEt/+e
	rL0SxeE4i5/sWzg8TnxtHae3cXQZ6TmvyJxCDHNpJ8lmBvk5HE8Yrmq6o9EQJ/bJARoR9vxOHIQ
	HGW6H63hav6788m5GEFf4u6NSAPYSv9RmLIjplzm7zGhTMFnmHcozLGPxJCaiGldXaMuWrYjIgL
	KGiprXBVxr6qez7O4kOafHZnNl6ZFiKiGhMw65lGpHzg=
X-Received: by 2002:a05:600c:3ca8:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-43ba6760622mr91900185e9.21.1741002755396;
        Mon, 03 Mar 2025 03:52:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTSfsUTkoO/or2iqdtsglYhk9ASXd3bpPBU2UgU+xONmgHuMQAHjbX/a34a1saMfjcf6uKjg==
X-Received: by 2002:a05:600c:3ca8:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-43ba6760622mr91900045e9.21.1741002755055;
        Mon, 03 Mar 2025 03:52:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5711fcsm193432675e9.28.2025.03.03.03.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 03:52:34 -0800 (PST)
Message-ID: <75031fe1-50d7-48d0-87bb-9c5c88f3b41c@redhat.com>
Date: Mon, 3 Mar 2025 12:52:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] Revert "x86/xen: allow nesting of same lazy mode"
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20250302145555.3236789-1-ryan.roberts@arm.com>
 <20250302145555.3236789-5-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250302145555.3236789-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.03.25 15:55, Ryan Roberts wrote:
> Commit 49147beb0ccb ("x86/xen: allow nesting of same lazy mode") was
> added as a solution for a core-mm code change where
> arch_[enter|leave]_lazy_mmu_mode() started to be called in a nested
> manner; see commit bcc6cc832573 ("mm: add default definition of
> set_ptes()").
> 
> However, now that we have fixed the API to avoid nesting, we no longer
> need this capability in the x86 implementation.
> 
> Additionally, from code review, I don't believe the fix was ever robust
> in the case of preemption occurring while in the nested lazy mode. The
> implementation usually deals with preemption by calling
> arch_leave_lazy_mmu_mode() from xen_start_context_switch() for the
> outgoing task if we are in the lazy mmu mode. Then in
> xen_end_context_switch(), it restarts the lazy mode by calling
> arch_enter_lazy_mmu_mode() for an incoming task that was in the lazy
> mode when it was switched out. But arch_leave_lazy_mmu_mode() will only
> unwind a single level of nesting. If we are in the double nest, then
> it's not fully unwound and per-cpu variables are left in a bad state.
> 
> So the correct solution is to remove the possibility of nesting from the
> higher level (which has now been done) and remove this x86-specific
> solution.
> 
> Fixes: 49147beb0ccb ("x86/xen: allow nesting of same lazy mode")

Does this patch here deserve this tag? IIUC, it's rather a cleanup now 
that it was properly fixed elsewhere.

> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


