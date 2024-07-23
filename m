Return-Path: <linux-kernel+bounces-260384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D61293A80C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093BB283552
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1171428EA;
	Tue, 23 Jul 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/hFY755"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286613C9CB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721766474; cv=none; b=O/6oYC4ALhSrAKH+Cw2sYnckPNYJi+r9a7dHxmsPjTvGFCojoQnrj1zrnxOrwDcLkvvgWEvjXn4ORubQ4umSEa92jg1xkkzU2iHQ1LY+z+khhgzYB/LcxoApjbefmXIXsV4tVd/z7BmJQlbVZON6Oyzc3R9zykhRn6//r1rtQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721766474; c=relaxed/simple;
	bh=n/vnM1hk2JHwWAnHtQXuifpggdhStuEae5KP88uoSEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRbYBbWFf4xv6wdU92fqRahR5cODFD+xuGaEHlkLmMd2Djs0aEjMR8LrX+m2qoM9nVXmE69jWLhqnkPTNlMcaUNsKaiDkIwqFQylbPSzd2IBry29peFNAXCrLpHLnC9UR/tCU2iIUYaE4SQJ1eW9mP8KUN7qCioGXP8n5iNsyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/hFY755; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721766472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c+64vXUDes+tMpXEff/5UiNspvONTK+6zYGQUtMBn5o=;
	b=W/hFY755kU9Fl1NPKCtO2uj+E2DWrOFlFT/JNq4/wwU1Folo7IE51mzA2OPrZEL1f8Fy5v
	/wSXUjPl5R8/UYlcJsFatfqLHz0mEg96h9Ud537vWVZosUAEEDkQI11WQsmFHnuFLZG7CH
	A0YrNpDvdLu6l4fwl7AHSnFi3NMYcP4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-aYr9wnb6OUuW3b-8r1YIkw-1; Tue, 23 Jul 2024 16:27:50 -0400
X-MC-Unique: aYr9wnb6OUuW3b-8r1YIkw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5c6753756d3so1048687eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721766469; x=1722371269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+64vXUDes+tMpXEff/5UiNspvONTK+6zYGQUtMBn5o=;
        b=UTXr8Rnuq7XYhsY21VpO60BPmB1BibzkUCpJL0BDOx5tXqkvZ8NegiaVrsPVGyg8/l
         Def1YmL4QqQFWIBwRox4lBEI6oaRxPS7v/srahomW1OBKiAkpn60u4nUZziP96LnJvLX
         lX0XdIjrkZ43H1tAWL4GBNq7JTTiT5FD409lH+j9cVjYh++roJhOK2WHQyzywUmmwJlu
         BEmrydVSVXo1+Lc51a06u6FQaeSF9Z7wKbAlsJhRazGGVp/MZEDACW+YgPM/sjHS+MWt
         RIyOBU6zF2Y+CglTNSo22jV7lQoJd3TXjQf8TEbo5nLG+8A8S2k4mN9wPxlgOqCcg9LB
         6tjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGHoPmWAStcZTcuLM10sCeqh7EdM8ROcy0b6GOJKT7b3tUxiZj6eGWJiXKN6ueRCaZrH3NGqhHAqc4O/XHMDAjrfYBZeY6+ekj0/ek
X-Gm-Message-State: AOJu0Yw6j/nleTuztdh8O8bwWoe5JrccFzxj9Yw4dzUCqwmP4k1ucDju
	22JxuEGN5SDe11+hDliPIq93HQybFuhHXIWI6hqSvxXWbRRBR14qDB9FBq7CejXTlbDBXIG2DBw
	MgRl/e77kV9c1wzJi9aLUwymePQzl3JfsYsaA2UyfTgDawo8VSBvQFVGxGWfztw==
X-Received: by 2002:a4a:d2ca:0:b0:5c7:aeba:77a0 with SMTP id 006d021491bc7-5d564cfb7e0mr6619076eaf.0.1721766469493;
        Tue, 23 Jul 2024 13:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVRqz7tnozK6XLrXG3mdS238h8GDYztCO0b10BtIGiBOtTLGZwID+Cy/qmGj7JBgpu+54ZTw==
X-Received: by 2002:a4a:d2ca:0:b0:5c7:aeba:77a0 with SMTP id 006d021491bc7-5d564cfb7e0mr6619053eaf.0.1721766469097;
        Tue, 23 Jul 2024 13:27:49 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7f15d3sm50461336d6.67.2024.07.23.13.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 13:27:48 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:27:44 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"x86@kernel.org" <x86@kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>,
	David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <ZqASQCobvpB_VfCL@x1n>
References: <ZpY5uU2NyOoMVu5A@yzhao56-desk>
 <ZpbDnoQxGubegtu-@x1n>
 <Zpcgmk6wexTKVv2E@yzhao56-desk>
 <ZpfR_L9wtuXhtSGk@x1n>
 <Zph051h5BsSFMpR6@yzhao56-desk.sh.intel.com>
 <ZpkglfpbHH7lQSft@x1n>
 <Zpmi2JWirNDiJz+7@yzhao56-desk.sh.intel.com>
 <1a0884cb-39ed-455e-a505-7c1b2a0e5225@redhat.com>
 <Zp3/ha6IXL5AYA8r@yzhao56-desk.sh.intel.com>
 <56c982c4-9863-4134-b088-8dfb4b94c531@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56c982c4-9863-4134-b088-8dfb4b94c531@redhat.com>

On Mon, Jul 22, 2024 at 11:17:57AM +0200, David Hildenbrand wrote:
> What we do have is a single VMA, whereby within that VMA we place various
> different PFN ranges. (randomly looking at drivers/video/fbdev/smscufx.c)
> 
> These wouldn't have triggered VM_PAT code.

Right, it looks like VM_PAT is only applying to a whole-vma mapping, even
though I don't know how that was designed..

I wished vma->vm_pgoff was for storing the base PFN for VM_SHARED too: now
it only works like that for CoW mappings in remap_pfn_range_notrack(), then
it looks like VM_SHARED users of remap_pfn_range() can reuse vm_pgoff, and
I think VFIO does reuse it at least..

I am a bit confused on why Linux made that different for VM_SHARED,
probably since b3b9c2932c32 ("mm, x86, pat: rework linear pfn-mmap
tracking").  I wished vm_pgoff was always used for internal maintenance
(even for VM_SHARED) so this issue should be easier to solve.

Maybe we can still re-define vm_pgoff for VM_SHARED pfnmaps? The caller
should always be able to encode information in vm_private_data anyway.
But I think that might break OOT users..

-- 
Peter Xu


