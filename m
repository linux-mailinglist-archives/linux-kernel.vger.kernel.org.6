Return-Path: <linux-kernel+bounces-273221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB499465F3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948922823F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9518120A;
	Fri,  2 Aug 2024 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gA1dJCA5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6007C2C9D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 22:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722638626; cv=none; b=ibMv5oA3Jj8NA5xf7DwkhJE/rB1IAXMp4wyoANkJ1akRloopThJXZSakQOOCJYQioRDw/uIDmpzawO97bBy38MfZzWE2LdEZUcqBiNgW7sl0ZNXqJtwGKsSyArvIjN5rd+KWQGutsHkNnEQuUBe3uq62D/6aiic45GT55ACW/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722638626; c=relaxed/simple;
	bh=TrIiER68cUJthDzL7UpQaHvRkK4+D4hRuZGrGeLPZnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEZqXnrDYnX346I/i1HlScBYJg87NqQGKuozscu63QKT8mvNCw3nh13qWQD4TIkI6EMp3C07S6PLMAD/tsceUijAVD+lCCxdCzejeZtClPxR7/D+lgPDZdCLNa8DZoIKL/HEpjXcYibM/ya7hTlTJqptRuPsa9urdSr22gMtE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gA1dJCA5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722638623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWgeUNWYR4zhRqTU3LJS1HQO1SCauqzxtnFFVDzZSg8=;
	b=gA1dJCA57OD+e/WNJXu9UasGBzzwsNFlBFtBZNtewvWQNVc3zUAvu+UsQikDuJSAyyUXcI
	1uCUm/yNGVbY3lodht1G324EUtEu90HY0HgHWygMdr9sCyJN0y1CDXeIsD8xp+27evLu9k
	5BmvfQDm3HoiTcQFeS2Lo7Flj4Tj978=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-6s9JFuPmN_qqzPzAur1xDA-1; Fri, 02 Aug 2024 18:43:40 -0400
X-MC-Unique: 6s9JFuPmN_qqzPzAur1xDA-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e05f7e320bdso1955251276.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 15:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722638619; x=1723243419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWgeUNWYR4zhRqTU3LJS1HQO1SCauqzxtnFFVDzZSg8=;
        b=KTBMUMnJeC2vkpm2MH4x8p6sqkjPKFpswgUkuD77ANbwr86nIq+Rvb9NA+OorBVmmt
         ldfDxIME10LAZYDBtpFhiPr/1HzCkSA+2oP1PDnTuLirmn3+RAytQBO8HngxYMcMRR58
         14ZEeEoic1K1M0GZTzdbRNcTI2OkVpNG43Qn8L7jH6udprz2v/oF1n1lD34rOoEABO85
         7vmSl+FZQeNTSRMF0MUpAfqFsb5/DH8n3PSC+EdA8YBKAKEM86QbvgjjIGoHUOBcI8uF
         MeokCfxMargGBRz53nuSPiOrA2pnIp66+6zr+RxbGJumiiMAIR43xSgL8Ss4I+o6Z22d
         ZItQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+bHAZWovExD99ha2Miwr/JawyQqzKg+tAruXODCiH5XyGq76a2QrXh7Es8kjD6wQ6qmjG25mtl4qwx/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7HXINq9W/bhayhSwvcVXpo6T3lQHPIPaOQ4cC1x/d+Oh1ubsx
	JXKRYNCATtWFrLrOX72M4hKXYbaFV5NWo7ZEIyhDt9hhHbVB+vsFtks4LPeJjgV7c2+VmYESvKv
	toDe7xq+TMbqUKxGdzssDeKCoSLK0VhczeFbC2EzES1LHgHbIhFIHNPdWIFg5Xg==
X-Received: by 2002:a25:86c5:0:b0:dff:323d:349d with SMTP id 3f1490d57ef6-e0bdddea5a9mr3315496276.0.1722638619439;
        Fri, 02 Aug 2024 15:43:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1AyUDUh3wVU2WkxCi0wv9ZHC79ULJiqW9SIWuRQFDWWk8xWZ+YB+mfabn7aU3YWxCJojoWg==
X-Received: by 2002:a25:86c5:0:b0:dff:323d:349d with SMTP id 3f1490d57ef6-e0bdddea5a9mr3315469276.0.1722638619034;
        Fri, 02 Aug 2024 15:43:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f78b7a5sm123953885a.122.2024.08.02.15.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 15:43:38 -0700 (PDT)
Date: Fri, 2 Aug 2024 18:43:35 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>, Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>, x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 1/8] mm/dax: Dump start address in fault handler
Message-ID: <Zq1hF9tQwLnQhU0j@x1n>
References: <20240715192142.3241557-1-peterx@redhat.com>
 <20240715192142.3241557-2-peterx@redhat.com>
 <bca7a510-4f66-42b2-b4a7-40b3bd37ead6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bca7a510-4f66-42b2-b4a7-40b3bd37ead6@redhat.com>

On Wed, Jul 31, 2024 at 02:04:38PM +0200, David Hildenbrand wrote:
> On 15.07.24 21:21, Peter Xu wrote:
> > Currently the dax fault handler dumps the vma range when dynamic debugging
> > enabled.  That's mostly not useful.  Dump the (aligned) address instead
> > with the order info.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   drivers/dax/device.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> > index eb61598247a9..714174844ca5 100644
> > --- a/drivers/dax/device.c
> > +++ b/drivers/dax/device.c
> > @@ -235,9 +235,9 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
> >   	int id;
> >   	struct dev_dax *dev_dax = filp->private_data;
> > -	dev_dbg(&dev_dax->dev, "%s: %s (%#lx - %#lx) order:%d\n", current->comm,
> > -			(vmf->flags & FAULT_FLAG_WRITE) ? "write" : "read",
> > -			vmf->vma->vm_start, vmf->vma->vm_end, order);
> > +	dev_dbg(&dev_dax->dev, "%s: op=%s addr=%#lx order=%d\n", current->comm,
> > +		(vmf->flags & FAULT_FLAG_WRITE) ? "write" : "read",
> > +		vmf->address & ~((1UL << (order + PAGE_SHIFT)) - 1), order);
> >   	id = dax_read_lock();
> >   	if (order == 0)
> 
> Agreed, the address of the fault is better. Just wondering, would the
> unmasked address be even better? Using the order we can figure out the
> to-be-aligned address.

From my very limited dax experience on monitoring these faults and making
sure huge mappings popped up correctly.. it's so far easier when we see
address properly aligned with order info.  But let me know if you still
prefer that, I'm fine with making that calculation simpler.

> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks for taking a look!

-- 
Peter Xu


