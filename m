Return-Path: <linux-kernel+bounces-184756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 346B58CAB87
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D35F1F22865
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FA96BFA3;
	Tue, 21 May 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D54Y9xHE"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6854F88A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286224; cv=none; b=madMJuNQHU9fjwL8ajdGruyUCJsunsQCiqisrYTk8FNmW/eDsbe2SXPdu/NGeGYdoAmd4SBOnCJygu5ormMpsfk8vFsvH6fmyV5dfGRlk4oLv553CBdxLDpfKr/tfBmu4OFSHR1EP5H2xa7KWcNfwdl3VEdJU4QxERE8Mp4zMsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286224; c=relaxed/simple;
	bh=lzP6WVfGnZ2gRAVw3Iw9YAiEUFJTomWHX1OVcSfqHoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pemHT8aO889Ato8LPmPRHPhmOoiMtpDF5v+XoN5kAxgPfNgjEafbG/ILZiqBRz3YH3vGZeQDPP9t5yNhQeTYe18ddQvFKjxhSXTyyHgxTHgxHqPpjGgFBwhMIcLQNg5omoJJmG2kfGH8OW4YEGi17CFGSbcm1nrrQ91Pi6IYTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D54Y9xHE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3504f34a086so2755813f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716286221; x=1716891021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uqy/BrI0+zdFA8alFTtjRQNHBs3pPPaugw1diVg336k=;
        b=D54Y9xHEgI0t0VCnnK/xk14UbrZCUHScdtld/LwLRO4Znoh55VGoYL6v5PwwgCAnnZ
         yCc+Qybo2Q0P4B+XL3/mbkQAGqu9moo6gLFanhkyZRbLvezIr+bj0x9/Vi5T4/SZnX5V
         bqCFyzcZLWdqWWBcCOZPRs2PnMSkPQAdmOpOluorQH7/N67YOG887jNetz2ODtL7SF30
         7KrTWpxgUgPaObdGn1oiblHGwj0bJuLs37WVDEPbILJU4sjExSljr37NDwpjyN0/fxef
         RrWm8g/ausKlydAh3F33Eymadfi0Jk02NkWK8QYf4u16x1tsniZC6xp7cy9gSm97WNEC
         NoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286221; x=1716891021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uqy/BrI0+zdFA8alFTtjRQNHBs3pPPaugw1diVg336k=;
        b=KCUkRbjrIKSQd62U5AbrblwQw4D25X+gD52zPquyMo2OajWeXOZKE/0cdDXHnOd4NE
         9YPCBUiyVHYxgRayYYcQeIcjPQz5uXkXJOQiJZFYBepp4VHypiqANHL5lUCafYWqG6Eh
         igVIDHktY3FgPiPhyCRHk6OXQN2jZbFsb219mxAy2E19zCjOmEuslNYB3HxOEY1yeSH9
         MT/jlg+N1X3jRYerGVBLC8tAsqwjPu+uUgk1fw6rRVX99sZm4ltDKDwpebVIAZ3qiUVb
         ES9+bYlZ/W++KMwojnrYXkktZD3eimvYLvDood57wYnPdoMgF4Hf/IiN/VXA315dZVe4
         iocA==
X-Gm-Message-State: AOJu0YyIvQ/FGBTyHorTgzfDnRqh3l/aFRgCLXsbdGh1fGeaNO+zDmdB
	cQdyWubDQFAHAf5McbGq5BH2oTEvGggj45b1v1+rujEtSHM7LI4An409Z3wemA==
X-Google-Smtp-Source: AGHT+IEdiaPzj2fVXiCyAzh85qZvLoxFo3FQ3i9W9ds24I0Tn1nGrmo7cQoNrmxaf/0G40TEJfoY5A==
X-Received: by 2002:a05:6000:e8d:b0:34a:5d79:dfe2 with SMTP id ffacd0b85a97d-3504a632e5emr22499956f8f.13.1716286220800;
        Tue, 21 May 2024 03:10:20 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc3bsm31525781f8f.13.2024.05.21.03.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:10:20 -0700 (PDT)
Date: Tue, 21 May 2024 11:10:16 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, rostedt@goodmis.org
Subject: Re: [PATCH v1 1/2] mm/memory: cleanly support zeropage in
 vm_insert_page*(), vm_map_pages*() and vmf_insert_mixed()
Message-ID: <ZkxzCJBihAddyb4D@google.com>
References: <20240430204044.52755-1-david@redhat.com>
 <20240430204044.52755-2-david@redhat.com>
 <Zkdys7YKC5pe1vAu@google.com>
 <3decc6c8-9035-44d6-89c6-8d42a5e0bc40@redhat.com>
 <ZkxkDPnPiQzPEm-0@google.com>
 <dde2f22d-c57f-44ac-9f2c-4a1790de084b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dde2f22d-c57f-44ac-9f2c-4a1790de084b@redhat.com>

On Tue, May 21, 2024 at 11:18:41AM +0200, David Hildenbrand wrote:
> On 21.05.24 11:06, Vincent Donnefort wrote:
> > On Tue, May 21, 2024 at 10:25:43AM +0200, David Hildenbrand wrote:
> > > On 17.05.24 17:07, Vincent Donnefort wrote:
> > > > Hi David,
> > > > 
> > > > [...]
> > > > 
> > > > > -static int validate_page_before_insert(struct page *page)
> > > > > +static bool vm_mixed_zeropage_allowed(struct vm_area_struct *vma)
> > > > > +{
> > > > > +	VM_WARN_ON_ONCE(vma->vm_flags & VM_PFNMAP);
> > > > > +	/*
> > > > > +	 * Whoever wants to forbid the zeropage after some zeropages
> > > > > +	 * might already have been mapped has to scan the page tables and
> > > > > +	 * bail out on any zeropages. Zeropages in COW mappings can
> > > > > +	 * be unshared using FAULT_FLAG_UNSHARE faults.
> > > > > +	 */
> > > > > +	if (mm_forbids_zeropage(vma->vm_mm))
> > > > > +		return false;
> > > > > +	/* zeropages in COW mappings are common and unproblematic. */
> > > > > +	if (is_cow_mapping(vma->vm_flags))
> > > > > +		return true;
> > > > > +	/* Mappings that do not allow for writable PTEs are unproblematic. */
> > > > > +	if (!(vma->vm_flags & (VM_WRITE | VM_MAYWRITE)))
> > > > > +		return false;
> > > > 
> > > > Shouldn't we return true here?
> > > 
> > > Indeed, thanks! I wish we would have user in the tree already that could
> > > exercise that code path.
> > 
> > I have a patch ready to use this path from the memory map tracing! I can either
> > send it once this one is picked-up or you can add it to your series?
> 
> Whatever works for you! To debug, it would be good if you could send me the
> patch and simple instructions on how to test it (do we have a selftest as
> well?).

Of course, I'll share something with you today! It includes an update to the
selftest to make sure we check the padding with the zero-page.

> 
> > 
> > > 
> > > [...]
> > > 
> > > > > @@ -2043,7 +2085,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
> > > > >    	if (!page_count(page))
> > > > >    		return -EINVAL;
> > > > 
> > > > This test here prevents inserting the zero-page.
> > > 
> > > You mean the existing page_count() check? or the (wrong) vma->vm_flags check
> > > in vm_mixed_zeropage_allowed() ?
> > 
> > I meant this page_count() here. As a quick test, I removed that check (also fixed
> > the vm_flags above) and the zero-page was properly mapped!
> 
> That's weird and might indicate another issue.
> 
> The refcount of the shared zeropage should be initialized to 1, just like
> for any other reserved pages
> (mm/mm_init.c:__init_single_page()->init_page_count())
> 
> Hm ...
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

