Return-Path: <linux-kernel+bounces-408101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFBE9C7ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF2FB347D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9D2036F2;
	Wed, 13 Nov 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJpwRD+0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADF202F91
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520605; cv=none; b=k0AEjzkDa1gfYKtrv4s2gxoNjZIz9TwKvCCczzoYFuAKFzI0nROHwl6dV3+el/KZuohQui/6KzQCxetsQP39jhN0mkSdizsIJ8NOf692tvcY4RboiLW5nSX7TdMXLasrkD0wiH/hjo3jW4HxudVavLvvAZKUMa4+C6d7g9Yq6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520605; c=relaxed/simple;
	bh=FEV2hlU+GGeEhstZyQekhJeZok1pVholE2R83wVEZXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5r0jGMvstQsyrBMQt0nDIySGxY3SJcL766DJwgTpoMHAF2ndJGhD+SRWTk+W1fOqzmo8q53IMxCK8ox6Vj2y1DF7YGvT8OhZjUj1OjujXw7eb4oqkWKdvO2IBdqfG3laUWliYXGjAFSBpuzqZzFf6S/kpJG2HHB0WXPK+SdUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJpwRD+0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731520599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ED4P6NsWli087xm4vi4x4cRp52cJJf0X5FBYEB8bznw=;
	b=jJpwRD+0dJib3ALvpe0HMOrSqWeW5QPuOAt0wcaEWjt5JF4Y7XXAvTDvdRrYbXmTDiLNwM
	dLbnX+J56uSK4ZjtNwZ9+VOJnpbIDWiAN8vl0gffomsD/HjZ2poSzIwf7Vvne8oyIAvlzu
	9tYxx3uu64cTIMlsPyQXrpU1CadvXBs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-G-z9g5VYMD2r6Je6OGIpNw-1; Wed, 13 Nov 2024 12:56:38 -0500
X-MC-Unique: G-z9g5VYMD2r6Je6OGIpNw-1
X-Mimecast-MFC-AGG-ID: G-z9g5VYMD2r6Je6OGIpNw
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3e60970ed1dso7178971b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520596; x=1732125396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ED4P6NsWli087xm4vi4x4cRp52cJJf0X5FBYEB8bznw=;
        b=I1oUP+azgCjBaLORu7RhujWsPTM3jkhhokGnmaBfedAeNEYxLMYeKKIURz6kQGUeop
         OfI8tFbsIwx5eHgUIMAHjXqnWl/8XGvCN6npPx8XTalfYqOMsjXYllu5eNvBYhjBsuod
         HYB2Xwz/fp/Dsyg3Tg9Vd7FrC2F+a00qI9sUKiZmSw7LmpVizkU5bRFdIMcxSLUaCD8B
         WzOxeMpl0UrFp5L6k5EBeXOyRe8y+dIwidfSBfceg0mgyPhe2olJNaBuOW6/n5QR7R6Z
         fsZ8SABx8OBL+Y4YX7N5sDSQiQ61rHoLQJdgU/o+rl6FyiBTXiE8OF9HBgi2SmiVTGkX
         kBmA==
X-Forwarded-Encrypted: i=1; AJvYcCU+bKNpMbFZko2oKqdNixHahCeJreLi2o4izx7VX0qc/31FSqqpSSq/SOSi9pZlxnHADGhiZ/Ru0F8CwQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfHSR7qsr7atiPKupiU++C5wKS3gBIbH9CiXoqwNS4MlxqfcS
	V5IuoaUQdKoRSlGJ65zoNL4t3ujxauVaB3wL4lWek5XKn4y2ljnw9sRUhUgO5Bz/whA4LtLMcAI
	neGQTLwpPQA1hp/Sx8gJJ85QOW9qrMRhTQM1H9HWnla8L3q5IDcNLM45p7yTtow==
X-Received: by 2002:a05:6808:210b:b0:3e5:fc09:7f51 with SMTP id 5614622812f47-3e7b0a6ecb1mr3667600b6e.9.1731520596162;
        Wed, 13 Nov 2024 09:56:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4VBL0HBnl2w17tqrXf/BlWXKTcO2I1zi+/iAk9osNVNVd0ENy5K0Fn0z3PGUlANNI5aIeog==
X-Received: by 2002:a05:6808:210b:b0:3e5:fc09:7f51 with SMTP id 5614622812f47-3e7b0a6ecb1mr3667559b6e.9.1731520595819;
        Wed, 13 Nov 2024 09:56:35 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3cf934d85sm24269446d6.33.2024.11.13.09.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:56:34 -0800 (PST)
Date: Wed, 13 Nov 2024 12:56:31 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, "Kirill A . Shutemov" <kirill@shutemov.name>,
	Nicholas Piggin <npiggin@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Huang Ying <ying.huang@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 0/7] mm/mprotect: Fix dax puds
Message-ID: <ZzToT6kkN0kkh-ww@x1n>
References: <20240812181225.1360970-1-peterx@redhat.com>
 <CAG48ez0NNph0Zp2aZ+c1T+U940CvwxcQ+jyEhp3KYZLSWPSrNw@mail.gmail.com>
 <ZzTWQqr-zFQz0HHY@x1n>
 <07ba2a86-f22b-43aa-a542-f1a182656b63@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07ba2a86-f22b-43aa-a542-f1a182656b63@redhat.com>

On Wed, Nov 13, 2024 at 05:42:15PM +0100, David Hildenbrand wrote:
> On 13.11.24 17:39, Peter Xu wrote:
> > On Mon, Nov 11, 2024 at 10:20:59PM +0100, Jann Horn wrote:
> > > On Mon, Aug 12, 2024 at 8:12 PM Peter Xu <peterx@redhat.com> wrote:
> > > > Dax supports pud pages for a while, but mprotect on puds was missing since
> > > > the start.  This series tries to fix that by providing pud handling in
> > > > mprotect().  The goal is to add more types of pud mappings like hugetlb or
> > > > pfnmaps.  This series paves way for it by fixing known pud entries.
> > > 
> > > Do people actually use hardware where they can use PUD THP mappings
> > > for DAX? I thought that was just some esoteric feature that isn't
> > > actually usable on almost any system.
> > > Was I wrong about that?
> > 
> > I did run it with a qemu emulated nvdimm device.  Though in reality I've no
> > idea on how many people are using it..
> 
> I wonder if we still have to support it ... or could disable it+rip it out.

Note that in my previous email, I also mentioned mremap() for PMD on dax
too.  If that's a real problem, it won't be fixed even if dropping dax PUD
support.

And we definitely want to understand whether there're still users on pud
dax to consider dropping anything.. it could still be that both mprotect()
and mremap() are not yet used in the current use cases.

Thanks,

-- 
Peter Xu


