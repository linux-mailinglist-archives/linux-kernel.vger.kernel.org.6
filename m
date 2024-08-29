Return-Path: <linux-kernel+bounces-307617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6681796506A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19A01F247DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0391BA870;
	Thu, 29 Aug 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNJ5CPdc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896214A0B2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961682; cv=none; b=bI8rxatJRT/MuiKuT5UgHE5WciF45r3y2R/lSnEz1/WdbYISJAFFyQi9uJmOL7lAeAf41hQ0AaA6SacHfrxSokJiPVNkW51/JUNDdzcY57qKCGu5hgMTb0f2P8ISNccSfZYUjZBVVsNVk3bNXu+NjOomyaewS/2lzA2134sozVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961682; c=relaxed/simple;
	bh=PMHLABp3MzC3BY1kwsZKSYYX95t3aAZeY2Evqq7KAMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5a/XLgLD5mX2awwtKZGKDZUDXcY17fOG3RbPx0JpAQX+9E13vv0eouvQ7v3wQALJcj/Ftb1QMKxvLMWdlIZX+YRk8axL6Ab+WHjhVv3XVkTTQ5/HMAmP7YU/xmFXgfXAQ49abKI+Gx7bLBjQFkt7ff1jiatH61gTQvOrDBwqEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNJ5CPdc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724961679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a6YgJDRtCG6NqNHvxBGwLph56rsiY6btQEOiIVWjksU=;
	b=dNJ5CPdc+6sUvDd4NHF+mL7Q6DMtjQ+UODMboqtOyvTxZqF4UakKnCtHcJ+LdXwUr9EgYT
	E2+OCi2C2NNZHD/odLYP2RwonbJYHbUd3Kaa76ZMb2SmyUiP7Rz1O24CJp7ZHUe/EY3mVe
	n5qNXFr3kTJdCn2QIZ/9C3r/fYgzeYU=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-DsrhZO2UMhObV1eIDn54hw-1; Thu, 29 Aug 2024 16:01:18 -0400
X-MC-Unique: DsrhZO2UMhObV1eIDn54hw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5df993bfe56so1098299eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724961677; x=1725566477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6YgJDRtCG6NqNHvxBGwLph56rsiY6btQEOiIVWjksU=;
        b=NLmWyFGfeh6am+TUqhx8fgEzeYz4qHSn3bpJVXJuP4X+yc9Sr1YCRoyXSWS/bbpOyr
         mXCh/dovTETL3jwRMUi/YJAsU/W5ztWPXmQM5nwTCGLWWAsqQn5zObWvOWexRv5wS2KG
         x23Uozq2jWbBGpn2wtthVW/Lb6oX09J3FSdww4qFQj53UrfkmiVkp4xWDyDBTVE4uo09
         NIVYuwsd4OjKC1bCCuJ9H2feCDUq3hVndvy+n7Yhd/VJunwLLhP2hFJTjuO/An6PnKiJ
         V0QXzl6KvE05aRe3p2T8kacGUNuhv8aHqkLQQ9Uqo/qv8+t6zM8CiUYo1IWz+tN/qT3R
         9+FQ==
X-Gm-Message-State: AOJu0Yw6qz/D58UDzh4n6c1jU6kWdRbJwuqt+9CVer/KM+y97a7zp+v5
	j43wa+TGE0Tr5S0W57XySNtmIQsqQdEpx8Ymxlri65Xxd6wZNs0neC2wtYO7YV3TYSQpJkONpBL
	Uh8i9eNlIE0JSVG4ordTFoAMq8huogV6zkS9sj/DC129nYskeDXjctV0ZKB7Gkg==
X-Received: by 2002:a05:6820:168d:b0:5df:81ed:2655 with SMTP id 006d021491bc7-5dfacd7a869mr90154eaf.1.1724961677309;
        Thu, 29 Aug 2024 13:01:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK7ZWE97qlIasXgZMNuMbAVeGSN/jRz09m4SD8T+Wcq60efkSETyErTr9KSiO3wUuWWJ5s/g==
X-Received: by 2002:a05:6820:168d:b0:5df:81ed:2655 with SMTP id 006d021491bc7-5dfacd7a869mr90109eaf.1.1724961676881;
        Thu, 29 Aug 2024 13:01:16 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5dfa04e8aadsm341894eaf.28.2024.08.29.13.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:01:16 -0700 (PDT)
Date: Thu, 29 Aug 2024 16:01:09 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alistair Popple <apopple@nvidia.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>, Borislav Petkov <bp@alien8.de>,
	Zi Yan <ziy@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>,
	Yan Zhao <yan.y.zhao@intel.com>, Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 07/19] mm/fork: Accept huge pfnmap entries
Message-ID: <ZtDThWS16Kv0QKR1@x1n>
References: <20240826204353.2228736-1-peterx@redhat.com>
 <20240826204353.2228736-8-peterx@redhat.com>
 <78d77162-11df-4437-b70b-fa04f868a494@redhat.com>
 <ZtC9ThIs7aSK7gdK@x1n>
 <32a451ee-6836-4d4d-814c-752c15415aae@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32a451ee-6836-4d4d-814c-752c15415aae@redhat.com>

On Thu, Aug 29, 2024 at 09:44:01PM +0200, David Hildenbrand wrote:
> On 29.08.24 20:26, Peter Xu wrote:
> > On Thu, Aug 29, 2024 at 05:10:42PM +0200, David Hildenbrand wrote:
> > > On 26.08.24 22:43, Peter Xu wrote:
> > > > Teach the fork code to properly copy pfnmaps for pmd/pud levels.  Pud is
> > > > much easier, the write bit needs to be persisted though for writable and
> > > > shared pud mappings like PFNMAP ones, otherwise a follow up write in either
> > > > parent or child process will trigger a write fault.
> > > > 
> > > > Do the same for pmd level.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >    mm/huge_memory.c | 29 ++++++++++++++++++++++++++---
> > > >    1 file changed, 26 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index e2c314f631f3..15418ffdd377 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -1559,6 +1559,24 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > > >    	pgtable_t pgtable = NULL;
> > > >    	int ret = -ENOMEM;
> > > > +	pmd = pmdp_get_lockless(src_pmd);
> > > > +	if (unlikely(pmd_special(pmd))) {
> > > 
> > > I assume I have to clean up your mess here as well?
> > 
> > Can you leave meaningful and explicit comment?  I'll try to address.
> 
> Sorry Peter, but I raised all that as reply to v1. For example, I stated
> that vm_normal_page_pmd() already *exist* and why these pmd_special() checks
> should be kept there.

We discussed the usage of pmd_page() but I don't think this is clear you
suggest it to be used there.  IOW, copy_huge_pmd() doesn't use
vm_normal_page_pmd() yet so far and I'm not sure whether it's always safe.

E.g. at least one thing I spot is vm_normal_page_pmd() returns NULL for
huge zeropage pmd but here in fork() we need to take a ref with
mm_get_huge_zero_folio().

> 
> I hear you, you're not interested in cleaning that up. So at this point it's
> easier for me to clean it up myself.

It might be easier indeed you provide a patch that you think the best.

Then I'll leave that to you, and I'll send the solo fixup patch to be
squashed soon to the list.

-- 
Peter Xu


