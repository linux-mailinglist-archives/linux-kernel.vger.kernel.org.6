Return-Path: <linux-kernel+bounces-185510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036358CB606
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 00:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C18282976
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FA7149DE5;
	Tue, 21 May 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wu69B4iV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537EF2AE6C
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330970; cv=none; b=KbEpllJ6/9aTe9Gn2NVYmJrguPPHO6+WZPeDHHwSwkk7HUvMY7RYn1CJDh5QRrFdw4i/3K6raW50DXVwGAscDiWkz0Vm6lgTVkC8N80mgaizXtsMK2BFqbLKhv1bcQUaN/eECPsAb5ohhGY3BdGOxoY8vd128+kP+rZg+EmOlRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330970; c=relaxed/simple;
	bh=ayDPkBz4fuCHUkYAJZRynPr42K5/21e3I+ovedbiq9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJxP+hKq5e501lmMK0BnEk+PMoC7B2IXzLVJAUiIvmC/HSiAIQzGshsJCp7Rix/JaaHMGUE2gsWEPrUFGBuF3FvBYfK/UODygv9XbuNFoDIaCGCzcbvxO8u1xQqnvEkTj9u+xDWCy4mgQ6/tnxzH2+W3ebcrHlybmpW0kmbQqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wu69B4iV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716330967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pVKJNSWNWZ1vgxIz4pu8U802ZIUK1JxE+9Cwhknulk=;
	b=Wu69B4iVGuFgBvmath5tj8Qbtdea5dBh72acgrToRwNgtpf1/rubogrRmxSe28cge9OsBD
	bSiwzMFzKKg2RMXluuByb8mxxl+3L7weFjbACuJcI6DZZoTiayyEOKT0HnwVKtwFQvDdCA
	dXPZqHa6wWOco1S3MEP0lEs5seqjlZM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-JmqQ1io6MUqM0rDLTezm8A-1; Tue, 21 May 2024 18:36:05 -0400
X-MC-Unique: JmqQ1io6MUqM0rDLTezm8A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-792c8f9c4f5so276612285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716330965; x=1716935765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pVKJNSWNWZ1vgxIz4pu8U802ZIUK1JxE+9Cwhknulk=;
        b=PCaO4TZ1nfZLlOS7g77k/7MZC1MFfUSJZQhTCP+f2UzZ/VjzU2PG+DFD60BtooMUPJ
         loIbX+z5lCxnrfiWDxPEqQflVfaI7j7XA0LwMaa/m+du34UtayNg+Z80HnkJTQroUFEy
         h9j4BhKUzM33hlks0SDgFIFTCgYnHUmSCC+rZgKOqHjN0plE9COr1Gcq1kysx5O5ycBv
         Sn3m0k2ZI7ZpRFUF0GY6PouAq2Cmo3zvfU+MvHOjCwTlku/Q9yjMtmPde2LDd17nFhDR
         72RZMZgSQqtKlDgUdTT66WPabg5s0UWQJEGBPfw9J377H3+GGw1RuQfnc5g4aXaIxERq
         u9DA==
X-Forwarded-Encrypted: i=1; AJvYcCVGYuoaPVWz2MJ4rDR44mvRWm+SCBbHeaO4kXosivw6kECgbZBnsEnZM0h4OjdT6qZQYNHUvdyKbEuxxGKsyGTZcyYb+5mOEUB6Glui
X-Gm-Message-State: AOJu0YxiRNuzLIE1zbSEIvE1dYKavwlSLIuu0rqtrWIpc1BmdD+DIOkr
	3mofLL0O91jsmGx0KPE9TUKjeGJf+1i1DBd4mlQHUcUab/MO0bZNuReGTKwt1Qx63jMmWRwVOsT
	OTfQ20LLkDmwGRmcs6rw5lFBYl6aN05Xt0Q9bcecdWHHGCVd+aoVOVhBjnXHlPQ==
X-Received: by 2002:a05:622a:1912:b0:439:9b56:42fb with SMTP id d75a77b69052e-43f9e1f1d05mr3634831cf.5.1716330964624;
        Tue, 21 May 2024 15:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5et9vU8jTmYA9yIWZrymeYSOINju+fcIISS4mqA2uxUbMcRGnMNAk5cJzm9+gKx/Xn06Qng==
X-Received: by 2002:a05:622a:1912:b0:439:9b56:42fb with SMTP id d75a77b69052e-43f9e1f1d05mr3634611cf.5.1716330963970;
        Tue, 21 May 2024 15:36:03 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e144a98a2sm125879561cf.16.2024.05.21.15.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:36:03 -0700 (PDT)
Date: Tue, 21 May 2024 18:36:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>, axelrasmussen@google.com,
	David Hildenbrand <david@redhat.com>, nadav.amit@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: 6.10/bisected/regression - commit 8430557fc584 cause warning at
 mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
Message-ID: <Zk0h0V8kvZRKu6F4@x1n>
References: <CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com>
 <Zk0HxVODITGKqYCw@x1n>
 <CABXGCsNbcMn0Z0RudFrBW78rZPE+cDY+f9r+yKf_AZwJZUOrQg@mail.gmail.com>
 <Zk0UA6wABOB9X_Dx@x1n>
 <CABXGCsOZnxrSHd0y6QrFhzAiY-uTJiRSmo__C_P8Y2qjFV6bRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsOZnxrSHd0y6QrFhzAiY-uTJiRSmo__C_P8Y2qjFV6bRA@mail.gmail.com>

On Wed, May 22, 2024 at 03:21:04AM +0500, Mikhail Gavrilov wrote:
> On Wed, May 22, 2024 at 2:37 AM Peter Xu <peterx@redhat.com> wrote:
> > Hmm I still cannot reproduce.  Weird.
> >
> > Would it be possible for you to identify which line in debug_vm_pgtable.c
> > triggered that issue?
> >
> > I think it should be some set_pte_at() but I'm not sure, as there aren't a
> > lot and all of them look benign so far.  It could be that I missed
> > something important.
> 
> I hope it's helps:

Thanks for offering this, it's just that it doesn't look coherent with what
was reported for some reason.

> 
> > sh /usr/src/kernels/(uname -r)/scripts/faddr2line /lib/debug/lib/modules/(uname -r)/vmlinux debug_vm_pgtable+0x1c04
> debug_vm_pgtable+0x1c04/0x3360:
> native_ptep_get_and_clear at arch/x86/include/asm/pgtable_64.h:94
> (inlined by) ptep_get_and_clear at arch/x86/include/asm/pgtable.h:1262
> (inlined by) ptep_clear at include/linux/pgtable.h:509

This is a pte_clear(), and pte_clear() shouldn't even do the set() checks,
and shouldn't stumble over what I added.

IOW, it doesn't match with the real stack dump previously:

[    5.581003]  ? __page_table_check_ptes_set+0x306/0x3c0
[    5.581274]  ? __pfx___page_table_check_ptes_set+0x10/0x10
[    5.581544]  ? __pfx_check_pgprot+0x10/0x10
[    5.581806]  set_ptes.constprop.0+0x66/0xd0
[    5.582072]  ? __pfx_set_ptes.constprop.0+0x10/0x10
[    5.582333]  ? __pfx_pte_val+0x10/0x10
[    5.582595]  debug_vm_pgtable+0x1c04/0x3360

Would it be possible that e.g. you recompiled the kernel so the vmlinux
didn't match?

> (inlined by) pte_clear_tests at mm/debug_vm_pgtable.c:643
> (inlined by) debug_vm_pgtable at mm/debug_vm_pgtable.c:1392
> 
> > cat -n /usr/src/debug/kernel-6.9-10323-g8f6a15f095a6/linux-6.10.0-0.rc0.20240521git8f6a15f095a6.10.fc41.x86_64/mm/debug_vm_pgtable.c | sed -n '1387,1397 p'
>   1387 * Page table modifying tests. They need to hold
>   1388 * proper page table lock.
>   1389 */
>   1390
>   1391 args.ptep = pte_offset_map_lock(args.mm, args.pmdp, args.vaddr, &ptl);
>   1392 pte_clear_tests(&args);
>   1393 pte_advanced_tests(&args);
>   1394 if (args.ptep)
>   1395 pte_unmap_unlock(args.ptep, ptl);
>   1396
>   1397 ptl = pmd_lock(args.mm, args.pmdp);
> 
> -- 
> Best Regards,
> Mike Gavrilov.
> 

-- 
Peter Xu


