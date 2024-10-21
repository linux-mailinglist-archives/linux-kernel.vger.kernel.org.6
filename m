Return-Path: <linux-kernel+bounces-374848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA59A7105
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AC3281D32
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E71EE006;
	Mon, 21 Oct 2024 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TAMzRuRr"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771D1CBEBC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531561; cv=none; b=qIDbgMv2XYrHVR0Oiccw706eWnHPrtvaaLi8tj+9/81MfjnhUknuJV/8ElQvbOG6IrCNvGpLB8EcrRrDYBzxeTSjOZjIbt8HsU/joCS0BwBUej0eB02w5Jmg0XoOCmQj0ccenbJfzZXEIk7yQk72ccVClwIxkZg8NzYhKd3u11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531561; c=relaxed/simple;
	bh=Tcqm4CiS9liiFsGOBSsaNu4lLtEOPLjH8W7zf5UHea8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvVYsI/ZRXDe+wOjkTnjkr8NLIqyofhGAO81CMFkh9LkExNDAzqm0t6eihh+WaWLEws67VkYibkGxf9RzBcicMi6AZAgPBKRcLFzWhD8MN+KKhpoz+YKdwds0S4UW2y5OxAjyIVyxQshhsoqG+rzMk/mCX5VyTukedZoyiFQXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TAMzRuRr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99cc265e0aso691682566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729531556; x=1730136356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RFxEseBMRL9TJroZfrqPEG15hgUXenLAoHO1VI1TokI=;
        b=TAMzRuRrLwHdKRLtwRpVhlgXmfl/+XvYz5/D9GO4mctM2y25/i9x4CurPO/LIeeMst
         0uOId55rQPs+VMD7Rcea4x8d0sGdeK6+y2yL1qmYmcavMRmLTiYJ9knylZmS1fLh2lgF
         080FQuBduGAOD7Qrbl9xtKMjG1n1mWWLGdeSo0aPkNVwMD7/b/pA/asuC4S0jtwcSoKT
         h8l2HCvY1DJOezFZ2Ow+u3DKxftBbIWaQe1xbs06N2YLfg7B7TI5dX6kyr22ws3zlu7E
         BdTWvhB2I4Z+SSofK54LndLGd4VlXGYSXQOQ4eHkGRzndnOMf+u0V0xEM8Kbz0npQNMf
         5ubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729531556; x=1730136356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFxEseBMRL9TJroZfrqPEG15hgUXenLAoHO1VI1TokI=;
        b=TUqWHLAQOjg+BZR4cFZ4G4UfylY7THDadOLMaX5bFvQavn8PDcsazDPRVX0zkQxZHF
         zP856MpvCISQvOsqSt5iqwKsLRtMh4Tm6fAnUoEeRWfa4suyXNGGvfBUqoGDl0ak3tib
         auvkoKoNVpsn5bBffZ7fEmNAioFLbAAYIq3XZP4FL1TkL1pNquYN9MkfCdTjxzg3kSjE
         hFlJ29HBnIqpIEujpeo2d+ULK9eiMKFStXeDJ81R1dFqMoKTTVVqOOaTQ4gQYAXBv284
         xGEW2dS4M/6HztddpvQ71QnKi4yUNiXYcLBw2ed/GQq1mcYKe4h+CTudx84ceyGxGCTz
         Bfsg==
X-Forwarded-Encrypted: i=1; AJvYcCWLrbrHs/QRe3HeXCWxZKnjzPMrRkgEpa7bEFOZYo1NtQetb8MTfipBep7Gf3zLQA0fEzQWAhv/0DkDhEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUg3zPsWkLEs6MqrV6a5d9GBed3cPY3myAk8CUo3Eko6VmdZQ4
	wnzNCagvIdeK4nHnCGMAHGk7RgRLgWPnzCloW1MwShpyXT83ye1cnextixUf+UA=
X-Google-Smtp-Source: AGHT+IH4n4wPePD3+2JbCmoNPK4uvGmV017SEx6TMLsnKOM7T6k4IpmtJaKQsslH7wxKKLfXYiWQMg==
X-Received: by 2002:a17:907:3ea1:b0:a99:529d:81ae with SMTP id a640c23a62f3a-a9a69ca14b7mr1332721566b.55.1729531556506;
        Mon, 21 Oct 2024 10:25:56 -0700 (PDT)
Received: from localhost (109-81-89-238.rct.o2.cz. [109.81.89.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370723sm230139066b.100.2024.10.21.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 10:25:56 -0700 (PDT)
Date: Mon, 21 Oct 2024 19:25:55 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>
Subject: Re: [PATCH mm-unstable v1] mm/page_alloc: try not to overestimate
 free highatomic
Message-ID: <ZxaOo59ZwXoCduhG@tiehlicka>
References: <20241020051315.356103-1-yuzhao@google.com>
 <ZxYNLb0CiZyw31_q@tiehlicka>
 <CAOUHufZ1fBvj0DgxtuLvwMAu-qx=jFAqM5RaooXzuYqCCTK1QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufZ1fBvj0DgxtuLvwMAu-qx=jFAqM5RaooXzuYqCCTK1QA@mail.gmail.com>

On Mon 21-10-24 11:10:50, Yu Zhao wrote:
> On Mon, Oct 21, 2024 at 2:13 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Sat 19-10-24 23:13:15, Yu Zhao wrote:
> > > OOM kills due to vastly overestimated free highatomic reserves were
> > > observed:
> > >
> > >   ... invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0 ...
> > >   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high:1068392kB reserved_highatomic:1073152KB ...
> > >   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*2048kB 0*4096kB = 1477408kB
> > >
> > > The second line above shows that the OOM kill was due to the following
> > > condition:
> > >
> > >   free (1482936kB) - reserved_highatomic (1073152kB) = 409784KB < min (410416kB)
> > >
> > > And the third line shows there were no free pages in any
> > > MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
> > > 'H'. Therefore __zone_watermark_unusable_free() overestimated free
> > > highatomic reserves. IOW, it underestimated the usable free memory by
> > > over 1GB, which resulted in the unnecessary OOM kill.
> >
> > Why doesn't unreserve_highatomic_pageblock deal with this situation?
> 
> The current behavior of unreserve_highatomic_pageblock() seems WAI to
> me: it unreserves highatomic pageblocks that contain *free* pages so
> that those pages can become usable to others. There is nothing to
> unreserve when they have no free pages.

I do not follow. How can you have reserved highatomic pages of that size
without having page blocks with free memory. In other words is this an
accounting problem or reserves problem? This is not really clear from
your description.

-- 
Michal Hocko
SUSE Labs

