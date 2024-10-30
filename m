Return-Path: <linux-kernel+bounces-389615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A69B6F07
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 935E3B2324E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5B52170B3;
	Wed, 30 Oct 2024 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UG5VqUPM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269831CF7BB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323975; cv=none; b=e+v7GJiEGEM81di3RZ0zz8s9WRA7xVwyTW0meyPKgbeasMxFxECWW6HhbaQ5Y4t8d5vusJLbha1fSRuYYp0w7Va9hYNa1qYTscYcuzga/cafZ4EDK6vUGr+1uPlEqp5qlhYtppANrSxvZ4H9HHK/Ni5cq+sBqzj1ZV15cqRovKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323975; c=relaxed/simple;
	bh=iwp/RjlPFK5lbPzqYmHjlsy5lXJA2HQIqtYrGhNyRRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwJF15A79yjFY0amNnD3S3BcZnef4CNsoZht7tm7RP1cR4DuIMH60YZV40TuGfMxun4gQnMXb9EEg/PC+3mj5Mro76E+HuGzcy5ZJweXnb4aXUn0BqDXrusquD08YisJtnYt0tRZyx2kt2K4x6+XifxthqpyzsqkP/BSftuInjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UG5VqUPM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730323972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9oOkd/Ta3caPUrXJiMZwEtxAvdW01kxki+ZonDRvcU=;
	b=UG5VqUPMKpYbkUQqOD07cIBB0X+5k8gDV34H8CCubowiQYSUCvOcy6x9VL1RA2l0d3wZMq
	aT/YIfLaVcMrErYKoppDdvbp0k3BeaKtnunE4NRPBBCBjLTPM6apB7VvG6wumiStGzKC9O
	wqg6JvIV8gkdkyNEaEuvJp1ZQqiUX9Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-LcUFh54yPSulIAhOcjQYAg-1; Wed, 30 Oct 2024 17:32:50 -0400
X-MC-Unique: LcUFh54yPSulIAhOcjQYAg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b14073eabdso37861685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323970; x=1730928770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9oOkd/Ta3caPUrXJiMZwEtxAvdW01kxki+ZonDRvcU=;
        b=vS3Rz94OSY92UNxKEK4/3wPkT6yL/rClEDctYTq78f9J9u7n+RF8zCtq3juqHcuZiL
         JtLxt6oc6D9FMH/mlOooANrUxPdmQaZCO4ItOsigJeQaX619AkIJ3yrE7HDYSrvqoHBQ
         iGAWsAiNnDQqEocTRkaqIrw/NNkJwSNBjvSIQOlr3C4NqMHRb1TCwEv5259524XYI5yI
         B2oSXkhNVRrP1InkuOVyfbk2hhlEA23azvhgM+DmJYoxcGcint2ZotSNcC/w6uO6JrwZ
         4sgVf6ZpjLz8gYtUZeT/qP3aTnBDwR4YE79nHjyLFvAsb/WJVNd11CNZM+Gn8I+HqNKb
         xwbw==
X-Gm-Message-State: AOJu0YzyG5xs3IWA+hyagTqXkWKrqGvgvC1CzLRz+fDvQHLhgcFR+e7r
	8NR60VKJJ2t45oAtSR8jkQsEsDJhUcBJonwuKqOC3pncEbCmkgEFkaK3j9vqwQqtr2ksqEfEMVt
	lio+k7Cxuk9OIUMhuS2+QWwUwf3MhBTGN3VvfGw0XiX7Neoh9vfP8dbVrRcbZvA==
X-Received: by 2002:a05:620a:4504:b0:7b1:4caf:3750 with SMTP id af79cd13be357-7b193f5d97cmr2407764285a.53.1730323969939;
        Wed, 30 Oct 2024 14:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD668Os7kBM4L/eQ5Q1w2L3HF//ExCrImc44DBAYo/TO9jIl7iyA11psw8cXIMCnhcXJm1Pw==
X-Received: by 2002:a05:620a:4504:b0:7b1:4caf:3750 with SMTP id af79cd13be357-7b193f5d97cmr2407761885a.53.1730323969566;
        Wed, 30 Oct 2024 14:32:49 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a82e77sm5599985a.105.2024.10.30.14.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:32:48 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:32:45 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	yuxin wang <wang1315768607@163.com>,
	Marius Fleischer <fleischermarius@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ma Wupeng <mawupeng1@huawei.com>
Subject: Re: [PATCH v1] x86/mm/pat: fix VM_PAT handling when fork() fails in
 copy_page_range()
Message-ID: <ZyKl_cRRUmZGbp9G@x1n>
References: <20241029210331.1339581-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029210331.1339581-1-david@redhat.com>

On Tue, Oct 29, 2024 at 10:03:31PM +0100, David Hildenbrand wrote:
> If track_pfn_copy() fails, we already added the dst VMA to the maple
> tree. As fork() fails, we'll cleanup the maple tree, and stumble over
> the dst VMA for which we neither performed any reservation nor copied
> any page tables.
> 
> Consequently untrack_pfn() will see VM_PAT and try obtaining the
> PAT information from the page table -- which fails because the page
> table was not copied.
> 
> The easiest fix would be to simply clear the VM_PAT flag of the dst VMA
> if track_pfn_copy() fails. However, the whole thing is about "simply"
> clearing the VM_PAT flag is shaky as well: if we passed track_pfn_copy()
> and performed a reservation, but copying the page tables fails, we'll
> simply clear the VM_PAT flag, not properly undoing the reservation ...
> which is also wrong.

David,

Sorry to not have chance yet reply to your other email..

The only concern I have with the current fix to fork() is.. we started to
have device drivers providing fault() on PFNMAPs as vfio-pci does, then I
think it means we could potentially start to hit the same issue even
without fork(), but as long as the 1st pgtable entry of the PFNMAP range is
not mapped when the process with VM_PAT vma exit()s, or munmap() the vma.

So I do feel like at some point we still need to make get_pat_info() work
without walking the pgtable, so as to fix all possible such issues.

Thanks,

-- 
Peter Xu


