Return-Path: <linux-kernel+bounces-253261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADA931EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D34FB211E8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F016B653;
	Tue, 16 Jul 2024 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hjl69pKY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E3EAD24
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096499; cv=none; b=jeQ1alWKpepNn9SZYcUM1Dngpq2+/Mh++UA21vYkLLRbIiGiMia0ifNQ7dPXQYsHW1BMo/R4nWecGFLx2yD/3fxFkaZdXcrQyv6kVNMW9lWhAly6QzU9ML+wvI8GQIUpIA6GLNfrwYenqDjTlrTWiKbpYIoAd+zsbk3ky+oqh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096499; c=relaxed/simple;
	bh=gsZ4F80xkqDr34TVXrZpadh2OiEZwsAOu0bsXIODOsg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pLAjZwYUe94AcXQcrm+0Sz24jWOLWPgN9XsuslKWb/PzXUcVTLYnLtaDZW43OjMzx39oworq+dFbLbAlcfQz/KC0W9AGPOYYVMlcdjWTaJNCq+6mnK+Hyq1c6BhWLXmpLRitODPONl29HwKAe86JAKID7nUVfSLVegHkqynu0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hjl69pKY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721096495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7WJQjgXG247dHuENykY6akcz79v6gaC87rfGOvpt/8=;
	b=Hjl69pKYgmlcRnsRynXzN5ifKd0Sm6xqPeFSVfbiIA7wv96bZAUSa1fmsL0X/jYqiS7UrA
	MFf9ynGK+oKyFxwocaoZ2j6HYybS2aDQNvKCkxQbZgY+UT0UjqvczAwb+YDsXq2RsKlyb0
	I2vpIxnwvibX3m/ru5r1/snm9d23rxY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-z3T9yX2oOlKKGKiO6MgcMA-1; Mon, 15 Jul 2024 22:21:32 -0400
X-MC-Unique: z3T9yX2oOlKKGKiO6MgcMA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b5e96477ebso69976526d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721096492; x=1721701292;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7WJQjgXG247dHuENykY6akcz79v6gaC87rfGOvpt/8=;
        b=tl+TJeWc6ewCZvh5Lq++V9neHkAaZeJ1h0iG79HxJApAanQ1UnwJ7e3G3dtCNwOJ79
         xV4usz4Rnxtw+ucRwz9KYCPDxy2AQw6d0hQeyjHXxH/LzJD9dCkgXaDAJZ2WzajXHMS+
         JZnv/Q0vamV/NjlX3jRttdF0UukPpJhZIUn0bwcHyd4jgOgzCfB9IDNigyBrViunyE+D
         AoSM0N5i51sw7xmP14pKaeCFiE8KI5dJ3qzJHBBy7e9Jpo9qKuIhXnhSZ5VrYPyqKTEZ
         +pGyjQqb58T9IRs7sElozcBcjleVFbZUP7oX1Q/YmpPWErZhoFBAtqSH5OsKhHYFWo2U
         ZkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdC/Hf1IwbdyGnt6KVq7qdnzMxMLAJJzl73iQpdhhIk3aCDCnd0GrA3wVnj7i6fngR6yE4n8lp4R62O5Yj0ZdCNKeCbfLPDwenhvIk
X-Gm-Message-State: AOJu0YwIr2K7TQG1Sv/Zk6XSUzlHJnZod3smI1r2ljHIr/O6XFpk1kgD
	yl8CUsFtgjObzFm7AM5WyHfJeIw7AVqF66HxV/j0bfezLN9XvevuJlBwJ52lJOTZ2S6UXFZ4yqf
	QO07qf7Bn0OIeyQXrAwxXl0XRUv5OQpbYe/Ufyuq1BcWCK/4UCw5u1hdP2w+Kf3SPzkwa2g==
X-Received: by 2002:a05:6214:27e1:b0:6b0:63ab:b7ba with SMTP id 6a1803df08f44-6b77f4df9e5mr11171306d6.15.1721096492006;
        Mon, 15 Jul 2024 19:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWEgmVDTEG/7zoYrFa8MTD5wFpyU132+dv2PEWBcRLlCrbgKwAEO07xx+lB9VPrtMKQ/mrsw==
X-Received: by 2002:a05:6214:27e1:b0:6b0:63ab:b7ba with SMTP id 6a1803df08f44-6b77f4df9e5mr11171206d6.15.1721096491736;
        Mon, 15 Jul 2024 19:21:31 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b76197cbbcsm26862686d6.40.2024.07.15.19.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 19:21:31 -0700 (PDT)
Message-ID: <1aafe2de083266a294d98393a6a6692320b7a284.camel@redhat.com>
Subject: Re: [PATCH 0/2] Fix for a very old KVM bug in the segment cache
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, Ingo
	Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 15 Jul 2024 22:21:30 -0400
In-Reply-To: <35aed712-d435-4660-a40a-ace7858218c4@redhat.com>
References: <20240713013856.1568501-1-mlevitsk@redhat.com>
	 <35aed712-d435-4660-a40a-ace7858218c4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sat, 2024-07-13 at 12:22 +0200, Paolo Bonzini wrote:
> On 7/13/24 03:38, Maxim Levitsky wrote:
> > 1. Getting rid of the segment cache. I am not sure how much it helps
> > these days - this code is very old.
> > 
> > 2. Using a read/write lock - IMHO the cleanest solution but might
> > also affect performance.
> 
> A read/write lock would cause a deadlock between the writer and the 
> sched_out callback, since they run on the same CPU.
> 
> I think the root cause of the issue is that clearing the cache should be 
> done _after_ the writes (and should have a barrier() at the beginning, 
> if only for cleanliness).  So your patch 1 should leave the clearing of 
> vmx->segment_cache.bitmask where it was.
> 
> However, that would still leave an assumption: that it's okay that a 
> sched_out during vmx_vcpu_reset() (or other functions that write segment 
> data in the VMCS) accesses stale data, as long as the stale data is not 
> used after vmx_vcpu_reset() returns.  Your patch is a safer approach, 
> but maybe wrap preempt_disable()/preempt_enable() with
> 
> 	vmx_invalidate_segment_cache_start() {
> 		preempt_disable();
> 	}
> 	vmx_invalidate_segment_cache_end() {
> 		vmx->segment_cache.bitmask = 0;
> 		preempt_enable();
> 	}
> 
> Paolo
> 

Hi Paolo!

This looks like a very good idea, I'll do this in v2.

Thanks,
Best regards,
	Maxim Levitsky



