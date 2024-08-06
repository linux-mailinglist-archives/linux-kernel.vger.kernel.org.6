Return-Path: <linux-kernel+bounces-276578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EA994958A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C951C212D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288D43987D;
	Tue,  6 Aug 2024 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THClXlqs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19AF2CCB4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961626; cv=none; b=Nljxj63uMxU1r3rkVvLiw0NoQrbwbc76LGQHdNoHWfuXIFXdiwOepdH0V6+L1kjDP28O23TKH8KB9WfD5oFNy++vf3L4TVChV3VchrlJupUTEzVOTyPZvu/JppvT8ChH5ivvht7Y4lbz1Pzi+yLDKuuevTpF4/XYI9v+ofJMlyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961626; c=relaxed/simple;
	bh=94nQgQKla4b4PAfHUhxk/0Ey+I0jSauMrxagRw6hezc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICVmcVMRPt3Dn4ethLS/90S1WBlyAVg5XpJAhmxPYBj2xgw+rdTAH2R9SF5EPWd8DmnHlw30dTQ5sm21VzqxD4b3hQjqDkmfEqjRt891SK8G+WQOo6UG3WR4unofOAt3YSTsp+286c8si7DTzcSY4Mq/afnMuvJ8uubsdfsJJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THClXlqs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722961623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwRzqS6Jrxy/9AqVhW2hvOe8Nx9yRiOYapW2YHF2cyE=;
	b=THClXlqsHi+DT/hXzV4Dl+YA0N5BWhvSIk18PlhY+xd2VbQucpmLIvtOWvbqWhH5ECt0n2
	MamlOJOQ4+NtJ4VnXX8sexcusHyajySnWJ1ar/R3b4etC5uZv5lbJNpXBdOoecQyLGwWFr
	f+h3CEUl3J5W8Q6EKn84yi1UbEIDAh0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-j6X0jou_PbSvPFVC9yxDAw-1; Tue, 06 Aug 2024 12:27:02 -0400
X-MC-Unique: j6X0jou_PbSvPFVC9yxDAw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b79fbc7ed2so2715986d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722961622; x=1723566422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwRzqS6Jrxy/9AqVhW2hvOe8Nx9yRiOYapW2YHF2cyE=;
        b=DH27ckfB/dCun4tu6QvpkqhnNmagdn/aHtslUIaSzmAhERpf5I8I0m1Aed4/BDoqSE
         xnYU2F7LpQQ7ITbq+AjLOM6xPo7GAyqzd7ATJcYoaUhIJ9KMNYQ08WcV4GcA2eosPG1J
         hW5yaYU8MpYmDn4g423ek1UT9Bo6cv0dJHEB2N7mNVkgRQ4esAy+WYX4Y2T+31VTaY01
         GR3d71Er3cqBE3aO5K1T4SI0DoAu0ZS9BwlPNMgwd/RF3H9S1nx3cagVKKpzPHsyzoie
         LJ14OqkbxKJqdljucsnPxh2q2N6ZYc3oXojw4jMZxKSXWbSau62jSauIm1n8PSZk2CL7
         sP2w==
X-Forwarded-Encrypted: i=1; AJvYcCUYvWJrL7Q7e0Dlo+Am0KOU/T2hqTURTDJxTX9fQ4fu5gupllFhwS56AgKxN2oiiD+ShjPOHglWOnWf+YE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzou3Ps4VMrbVlsPnnKx9jbNxM/1OVoksSygP0CKvptTW6SBJ0
	GcCjYj0RnUih4O4RBW+amvzsbqkaWkb9BI4q+TLszoAcCfPUk0DW4YtknVp5xQhbyWTo8JJNjaM
	6EQBwoT/rKgc275nYF67M8aEbf+mOUSKDbt+ywIvophYw6p4++lCMJBbA2TTx4Q==
X-Received: by 2002:a05:6214:20e9:b0:6b2:af3c:f710 with SMTP id 6a1803df08f44-6bb9831ea8emr105902226d6.2.1722961621702;
        Tue, 06 Aug 2024 09:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs199fAKj0/OLiUoJmdO3kvLFiPXK+MPCbBppWbqB/Lo+v3asN98Wu552yOIbw7iXXDStHtA==
X-Received: by 2002:a05:6214:20e9:b0:6b2:af3c:f710 with SMTP id 6a1803df08f44-6bb9831ea8emr105902046d6.2.1722961621365;
        Tue, 06 Aug 2024 09:27:01 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c88421dsm47964496d6.139.2024.08.06.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:27:00 -0700 (PDT)
Date: Tue, 6 Aug 2024 12:26:57 -0400
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
	Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@redhat.com>,
	Alex Thorlton <athorlton@sgi.com>
Subject: Re: [PATCH v3 2/8] mm/mprotect: Remove NUMA_HUGE_PTE_UPDATES
Message-ID: <ZrJO0aLVaeRoo8eo@x1n>
References: <20240715192142.3241557-1-peterx@redhat.com>
 <20240715192142.3241557-3-peterx@redhat.com>
 <added2d0-b8be-4108-82ca-1367a388d0b1@redhat.com>
 <Zq-Y3qs5_PZW04bt@x1n>
 <054324a3-bc77-426f-a751-06700aad394e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <054324a3-bc77-426f-a751-06700aad394e@redhat.com>

On Tue, Aug 06, 2024 at 03:02:00PM +0200, David Hildenbrand wrote:
> > Right.
> > 
> > I don't have a reason to change numa_pte_updates semantics yet so far, but
> > here there's the problem where numa_huge_pte_updates can be ambiguous when
> > there is even PUD involved.
> > 
> > In general, I don't know how I should treat this counter in PUD path even
> > if NUMA isn't involved in dax yet; it can be soon involved if we move on
> > with using this same path for hugetlb, or when 1G thp can be possible (with
> > Yu Zhao's TAO?).
> 
> We shouldn't bother about it in the PUD path at all I think. Especially as
> long as NUMA hinting doesn't apply to any of what we would handle on the PUD
> path :)

Hmm, I just noticed that hugetlb was never involved.. but then how about a
potential 1G THP?  Do you mean 1G THP will not be accounted in numa
balancing too even in the future?

The motivation I had this patch in this series is I want to be clear on how
I should treat this counter in pud path if it won't go.  And when people
compare the two paths we'll need to be clear why there's such difference if
I ignore it in pud path.

Per my current read on this counter, it might be an overkill to do that at
all, and it might be simpler we drop it now.

> 
> > 
> > One other thing I can do is I drop this patch, ignore NUMA_HUGE_PTE_UPDATES
> > in PUD dax processing for now.  It'll work for this series, but it'll still
> > be a problem later.  I figured maybe we should simply drop it from now.
> 
> It probably shouldn't block your other fixes and we should likely discuss
> that separately.
> 
> I agree that we should look into dropping that PMD counter completely.

No strong opinion here.  If we prefer keeping that as separate topic, I'll
drop this patch.  You're right, it's not yet relevant to the fix.

Thanks,

-- 
Peter Xu


