Return-Path: <linux-kernel+bounces-355451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83418995269
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B0E2882E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E64F1DE4CB;
	Tue,  8 Oct 2024 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MhgcSAsu"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A61DFE32
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399102; cv=none; b=pcam2xHfVm01wU1qpGXI2E9h6J05sgUC64IUjmDHHZ8ckHhsGkd8AhXCRIgOgHl2rxi0OBC5hiwH9SpPvn8cz5QJCw4CSEHof9pGMr40KoAEG8sVPlrJ6OXNefID+HVwIeDWeCizt5TaiA2VjIZ/zagg8THYEOXYOqhuBW5eqSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399102; c=relaxed/simple;
	bh=FdX000BfNXmYUb4opHXMevAqiMWP56/tqAYYlyDF/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3zh750ImMQJPCUKKM3l+5fbAqtJnT91uNewm+xDKSUp2ISx9aOSXlq4YbYN21bYk03QnUrDyPChDsPVeqlvOe0faZN/NOdda7WWBRHFi6i76qGaK0Lm87K+CRIVy/meJCxg8NCibuZ1dXSNaWsJHSY4vaOJjfoLgijfvQ4djjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MhgcSAsu; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7ae3fcec5feso599428685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728399099; x=1729003899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+8u49KVyhPOrweO2lc6eBFQS+Hc6vnffHct6u8Jv+w=;
        b=MhgcSAsuU+jCrZX0l4hWSH5pUs0TMn9rZR9g9vqnKmTJlaAUqcXirI1m91ppzNRdB2
         yBW0ompQ8CCS2isafEyPBA68NaRTDth/Iuv2ZSxib0nglHmssItSMkO2WkgY/3OLGrGO
         ToaWBIPzhzTbIlfJDtUdbqUwsxwnQRDnrlK2ZvKRygTzG+gUq2b9Ex84naglBcpfUoUj
         wKvsgMH9YkY3vCqAeLusFZAh+22QaaBhPw2shOjIhNEYp1uyE6S7uxvAdo12eyF7wU+i
         IMOZpfkMfT4yA830bdiXc1fw5iuXocEb7hT32rTjkJxJvQRilU7FhSao9UNXq3wB8NgH
         E7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399099; x=1729003899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+8u49KVyhPOrweO2lc6eBFQS+Hc6vnffHct6u8Jv+w=;
        b=KE+cDT1feFbj5+1xeNuole636FnruH948pwqMqiZ2yzTwhEWaZO7E/nWyAUcQyCDw8
         JoU3XdnO51gAyq4mB8fOWQXajzJ62rGWkH+6xHne6FwrCSBseshtGRaQs3GeE5NR/SGw
         uEQUl6EUFzLEcbzmLreY39ON0Ab6KyfX7WzUhSzOtvPvVcB73DAAAxcE47L1npm2KXa8
         +hElbRN8pB++pCmFQ6qbkI7Q5yNOWQXnrm7ff5vAzc3tKGwGFQEU8T3Wk9Uhv35IodQq
         Zro2yLN0vsNN312sVwCGrlCY1Ien7YbqO0pNarE4LtwQCt1GXFHvE/CIDRu3d694Yqy0
         kU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP6y4h9mPjUIVtSlUSH7wK9r/lq+EWGY4/6Li7WBYZ4QudGaQLm7soDb+nW603bcyCx3wQYxfQRybpIeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyg91kPi5/Ehj9aZWH2lbibAZrzm/uWNzu1NQM1VfJ9E3DfjS1
	HkUuh/m+rJOSOTW/A0yQkE2HFecZiKWiiKzaf0rnOkLO6w/TSQ9WMASdbjOjxNA=
X-Google-Smtp-Source: AGHT+IFq4ejAZimMFPt1747gCyE+Qz23dQBrY1mL0z6fT+fBj1wX7llJiqwXX1zCd9TNFYGsXrL5tg==
X-Received: by 2002:a05:620a:29c4:b0:7ac:e30e:f6f with SMTP id af79cd13be357-7ae6f48699fmr2414673785a.43.1728399098773;
        Tue, 08 Oct 2024 07:51:38 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75635ca8sm360029085a.60.2024.10.08.07.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:51:38 -0700 (PDT)
Date: Tue, 8 Oct 2024 10:51:29 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-cxl@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
	rrichter@amd.com, terry.bowman@amd.com, lenb@kernel.org,
	dave.jiang@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH 1/3] memory: extern memory_block_size_bytes and
 set_memory_block_size_order
Message-ID: <ZwVG8Z3GRYLoL_Jk@PC2K9PVX.TheFacebook.com>
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-2-gourry@gourry.net>
 <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>

On Tue, Oct 08, 2024 at 04:03:37PM +0200, David Hildenbrand wrote:
> On 08.10.24 06:43, Gregory Price wrote:
> > On CXL systems, block alignment may be as small as 256MB, which may
> > require a resize of the block size during initialization.  This is done
> > in the ACPI driver, so the resize function need to be made available.
> > 
> > Presently, only x86 provides the functionality to resize memory
> > block sizes.  Wire up a weak stub for set_memory_block_size_order,
> > similar to memory_block_size_bytes, that simply returns -ENODEV.
> > 
> > Since set_memory_block_size_order is now extern, we also need to
> > drop the __init macro.
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >   arch/x86/mm/init_64.c  | 2 +-
> >   drivers/base/memory.c  | 6 ++++++
> >   include/linux/memory.h | 4 ++--
> >   3 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index ff253648706f..6086f99449fa 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1424,7 +1424,7 @@ void mark_rodata_ro(void)
> >   /* Adjustable memory block size */
> >   static unsigned long set_memory_block_size;
> > -int __init set_memory_block_size_order(unsigned int order)
> > +int set_memory_block_size_order(unsigned int order)
> >   {
> >   	unsigned long size = 1UL << order;
> > diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> > index 67858eeb92ed..f9045642f69e 100644
> > --- a/drivers/base/memory.c
> > +++ b/drivers/base/memory.c
> > @@ -110,6 +110,12 @@ static void memory_block_release(struct device *dev)
> >   	kfree(mem);
> >   }
> > +int __weak set_memory_block_size_order(unsigned int order)
> > +{
> > +	return -ENODEV;
> > +}
> > +EXPORT_SYMBOL_GPL(set_memory_block_size_order);
> 
> I can understand what you are trying to achieve, but letting arbitrary
> modules mess with this sounds like a bad idea.
> 

I suppose the alternative is trying to scan the CEDT from inside each
machine, rather than the ACPI driver?  Seems less maintainable.

I don't entirely disagree with your comment.  I hummed and hawwed over
externing this - hence the warning in the x86 machine.

Open to better answers.

> -- 
> Cheers,
> 
> David / dhildenb
> 

