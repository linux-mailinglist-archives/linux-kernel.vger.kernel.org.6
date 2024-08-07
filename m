Return-Path: <linux-kernel+bounces-278587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B5994B236
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BFD1F2235B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3471494DC;
	Wed,  7 Aug 2024 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PstDa8uM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E012C53B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066460; cv=none; b=iNdM0c+yQ3eKdLgJPhx7A97JO+RBiOxyzyu7TF1l3epHbleDNIBanPHdwxD/NoOC5L3+HIJzl3dC9z6XlfJiPhf72+0jQ4af1RQ679XpDjO224CkzAfpzq+/M6/CaZtJ4gKk3X/mlNbBLSUgqxu0znz/1tMUXDrh6ZdSX03HtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066460; c=relaxed/simple;
	bh=tTiqkpVERj+cdfKwgAtqvgFpmL7Ee63F2ksjkJvS6cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thzintUn92QU0zJTmM/OyXrILPEFNTnhiSAeOGlaLO5QE+NdIyDS0zQYxTlISwR450s9rO0dfOf6Ite7ykWPqEqc4wH0WpQstWHs06q4RghV9fxxGQ2EMduMF5PWqFA5fwjKucqLL+U0vYomKdWEw2cQgJ5gK/Y2UD41vId/uVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PstDa8uM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723066456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b8A4Mtfk/rFhpacRxxv8Vl2NMxtodppFf5jwJTCX6+c=;
	b=PstDa8uMomEVBp3opLu0E5KFkaoVyeI61MjzxVwz9UwtqdhfXuELLEmu/2FsLL0ZX5AEfX
	CHL+PYdVhM/6GYzXelVtL2tZVXHuiQH5GuVetwjdi389SCMItTFlpeA/Me8Ky9F3hygFw8
	JlBIIxBrakrmWjmLOJxx5KlfThvmbJY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-3Qx4jHoGOSyLZiCuN5n9NA-1; Wed, 07 Aug 2024 17:34:14 -0400
X-MC-Unique: 3Qx4jHoGOSyLZiCuN5n9NA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44fe28cd027so602591cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723066454; x=1723671254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8A4Mtfk/rFhpacRxxv8Vl2NMxtodppFf5jwJTCX6+c=;
        b=tCFjV7U/yvaqcjywwxuVte8un0acNFY7uBnnJ+ipc+x/DJGBAAeQuYL9IKmiR0AQVc
         sJ8R3VZu00WWvfQWQOOv/M6RN+2Y02MIH47C+uopKBqTDqogtu2TwsGKNwPwJWfGmJgY
         i9dK2GaorgvdODbQWFcN8z/uN14f7dvI/NsSStBXBdED/RGlpv+pnzW7YyTdryTnFbFS
         rbjf/u+CtRKo9ZTzIhLeSADemD/hYqD4ArtIPfw3jFvjgn4Q15r5zDuaryvfLVDYU7hf
         yCpkzLfUeJezstbRYFBYe0I7i35UhbGivaWDNejRmJEpsVE3mAha6UoZNF/1SWePC4Xo
         U8pw==
X-Gm-Message-State: AOJu0YxBXZGd+KYkV0Cj3GYUd86TBm/HU0r12uaqUktCUP+56oR0IIta
	WeNBPd4J1+3S/6qxNaSq2+mbWaacI7Zs2aagnciQTin1e4ZawSn2WLCLA/dCcphnrvEGV7MWKYo
	rPMvLhwgONenlHStswWvDGfmlkRIj6SELClfcv/NSOL/xnmBxDMlS32mfv/MgYg==
X-Received: by 2002:ac8:578c:0:b0:44f:c953:290d with SMTP id d75a77b69052e-451d41f93b4mr22881cf.2.1723066454048;
        Wed, 07 Aug 2024 14:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0CdcvmJB1BOi53T58FRUCwR8qSSqwKPnnvElG8RvK5pkhn8YV6iabdWDMHLRrifpAyIPmjA==
X-Received: by 2002:ac8:578c:0:b0:44f:c953:290d with SMTP id d75a77b69052e-451d41f93b4mr22631cf.2.1723066453583;
        Wed, 07 Aug 2024 14:34:13 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87db12asm7735661cf.73.2024.08.07.14.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:34:13 -0700 (PDT)
Date: Wed, 7 Aug 2024 17:34:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oscar Salvador <osalvador@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	James Houghton <jthoughton@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Rik van Riel <riel@surriel.com>, Dave Jiang <dave.jiang@intel.com>,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Mel Gorman <mgorman@techsingularity.net>,
	Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v4 0/7] mm/mprotect: Fix dax puds
Message-ID: <ZrPoUgISLqlF-iEQ@x1n>
References: <20240807194812.819412-1-peterx@redhat.com>
 <20240807141703.d641001ee14177ccf80a31d8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807141703.d641001ee14177ccf80a31d8@linux-foundation.org>

On Wed, Aug 07, 2024 at 02:17:03PM -0700, Andrew Morton wrote:
> On Wed,  7 Aug 2024 15:48:04 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > 
> > Dax supports pud pages for a while, but mprotect on puds was missing since
> > the start.  This series tries to fix that by providing pud handling in
> > mprotect().  The goal is to add more types of pud mappings like hugetlb or
> > pfnmaps.  This series paves way for it by fixing known pud entries.
> > 
> > Considering nobody reported this until when I looked at those other types
> > of pud mappings, I am thinking maybe it doesn't need to be a fix for stable
> > and this may not need to be backported.  I would guess whoever cares about
> > mprotect() won't care 1G dax puds yet, vice versa.  I hope fixing that in
> > new kernels would be fine, but I'm open to suggestions.
> 
> Yes, I'm not sure this is a "fix" at all.  We're implementing something
> which previously wasn't there.  Perhaps the entire series should be
> called "mm: implement mprotect() for DAX PUDs"?

The problem is mprotect() will skip the dax 1G PUD while it shouldn't;
meanwhile it'll dump some bad PUD in dmesg.  Both of them look like (corner
case) bugs to me.. where:

  - skipping the 1G pud means mprotect() will succeed even if the pud won't
    be updated with the correct permission specified. Logically that can
    cause e.g. in mprotect(RO) then write the page can cause data corrupt,
    as the pud page will still be writable.

  - the bad pud will generate a pr_err() into dmesg, with no limit so far I
    can see.  So I think it means an userspace can DoS the kernel log if it
    wants.. simply by creating the PUD and keep mprotect-ing it

But yeah this series fixes this "bug" by implementing that part..

Thanks,

-- 
Peter Xu


