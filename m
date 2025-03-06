Return-Path: <linux-kernel+bounces-549786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D32A5573F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6774B1896B7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FC626E976;
	Thu,  6 Mar 2025 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iKLvFsIX"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C8742A8C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291432; cv=none; b=LMFt0oiV+NQiwx2P5U0P1uGvpdAwbKacldHTCOCw3O2QYn4K44hUg5o2sQKO3YrfumE9GeJL56AX1O+VYVU06CS+0s3dIfhodCbIutLZY3z7IlrhYj6TXIwRaSrhqbWIKQs+sGnaoBUf+0+hUfpObzzpCDs4/ZQIBFyTexxWlhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291432; c=relaxed/simple;
	bh=p3mEiT69hY7Z3a6igK2ww7wQ55pRqxW3KmPL+9d5HFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsXHmDMF0f9NSIrnIVEYmx62A4iSy3aGXEVEUvacxd2k1jq9K1zepdsu/1kdB8FLBxi/io4nzR+T2tPZaAFzHnHCbIS5i8mgXiYravRekG9xtMxsAyIIAsEuqTkJpEk8XPw3+hC1N5uqddqsfUqilQ/av588pOYsfX87MNg2V+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iKLvFsIX; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c3b63dfebfso115220085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741291429; x=1741896229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MbNwuefREW0z/A6atfnqBSiJwlp+t2aCSqE0SODKX0=;
        b=iKLvFsIXNBxJiULlvjlJnWVt6kVnKiKuV9Lu6W4r+XdwPv7qL7HCR8lM3YmGdx64XN
         0tjPTBw2jrJX9hnPphZGL6haIflpp8ynJaZOEhXNRXSzyU0c0wit/Gq5YXFCLC9UrwNz
         bknrLrMkog6MRQAtMtDxjQ9qIy3gk1WoOuqCfnBPydQ5EjWf0YxFNBASCks2Vr9At4pZ
         2qn1X6RZ2Gbpib5ZPD+RGzM4PEJ79i/NXL/9eYzLHer8/00RaVDVtyGIsIUfxIAXPf7Z
         LddhdKAPawZcQT+WFY3Sjp6XaW7K56FOtbyyJbXO9RQf40JWSjCXwlR0td2Rf/Cr7iEH
         613w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741291429; x=1741896229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MbNwuefREW0z/A6atfnqBSiJwlp+t2aCSqE0SODKX0=;
        b=Yi+eA7J27h47k0i5t+8ZEceBKTjm82EWnaZw5qazBCDYmpySan8+OFHmYEiZAvHRmd
         c6QmZjjTxbShTiBbAlWx5sGEslBhFPK/8jhWMRHCXadLw+qqXfBISzBOt+cJkzJvbGhR
         cE4vyDZucwrPQCEvb6WvHTk2FiwAOO0u4UcFAkXMsw8NFhPUTUu4Ay/kXlsvp3IagEs1
         NdY/0jBUJZxAMw3B7qniNxoLX8JUyfHyjRQPbs7V+bE5efPw/qPJ5vnCxLRgKYZsm2lj
         uI4EFXJmb4b2Jw8xJyfWoS+H7Iq37o8rEu0MnYujReBgxulovhAWxIKZXqwb1rfektqC
         RSZg==
X-Forwarded-Encrypted: i=1; AJvYcCW1WQwdiyeDlY3UFJE8GO6Im1H+f/pmqHya8g6JO2OS3ok6VCf5mJ68duLXXIjeEZpA/t3Lm8+Le6mLjpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQAMTNRnPROFOix1jHURmQSEcrIkNMDv5c/qGYiA+Aa6Ka6gl
	Fnio28jW8qMvMF2mwLW7IYZOAVPx2pswftoSNTXJOkeLH43VFzWfjnT+ooDz4IU=
X-Gm-Gg: ASbGncsCs1Sp96+Vn14DsMXQVbnEHTpsJPxEcXkcsKLrBsy8GAhgwD8Hz1Z5qqkPw8l
	djrbHQPlO5l1d25JJvc1sC9c79MCd8fFzKPyZVx3bKVB27WM2HgPjFVZcKWEXcp4mk54bhEjeeR
	jEm0EH2hA9G/U8JqtcM4bIl1+qRDJT6ydduZnTBcR5DkkCaEhV2mrF3CughjEnwYlziamleo1Sn
	TWF8xMhp0mSxwMXt6im/8etc660+kWsCoNxhIl8I/2NWSAfuwyXIxNCnm1nA1vgpJJEOpHI4FNU
	Of6aod7un1Wh6EBaUc6rfduz2ljJNBhicsaXTx3EDSBex+EODGR/xiyxfClrT9h94TdRgBOd+gC
	2aOaRco3CuRJT/M1PGt/necU2AB8=
X-Google-Smtp-Source: AGHT+IGhkQOOVMenfM3GitVhl69x4GBmyzWsOGMbhpZQZQyGPXd6L9GExsMzBcxeUvicNsCSpoFPIg==
X-Received: by 2002:a05:620a:8017:b0:7c3:c1b4:c8f5 with SMTP id af79cd13be357-7c4e168267fmr80757785a.15.1741291429597;
        Thu, 06 Mar 2025 12:03:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534bb1esm130728385a.31.2025.03.06.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 12:03:49 -0800 (PST)
Date: Thu, 6 Mar 2025 15:03:46 -0500
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, AneeshKumar.KizhakeVeetil@arm.com,
	Hasan.Maruf@amd.com, Jonathan.Cameron@huawei.com,
	Michael.Day@amd.com, akpm@linux-foundation.org,
	dave.hansen@intel.com, david@redhat.com, feng.tang@intel.com,
	hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
	jhubbard@nvidia.com, k.shutemov@gmail.com, kbusch@meta.com,
	kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
	liam.howlett@oracle.com, mgorman@techsingularity.net,
	mingo@redhat.com, nadav.amit@gmail.com, nphamcs@gmail.com,
	peterz@infradead.org, raghavendra.kt@amd.com, riel@surriel.com,
	rientjes@google.com, rppt@kernel.org, shivankg@amd.com,
	shy828301@gmail.com, sj@kernel.org, vbabka@suse.cz,
	weixugc@google.com, ying.huang@linux.alibaba.com, ziy@nvidia.com,
	dave@stgolabs.net, yuanchu@google.com, hyeonggon.yoo@sk.com
Subject: Re: [RFC PATCH 1/4] mm: migrate: Allow misplaced migration without
 VMA too
Message-ID: <Z8n_ovXcdAzcUNrw@gourry-fedora-PF4VCD3F>
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-2-bharata@amd.com>
 <Z8naQNirs4HfTX0O@gourry-fedora-PF4VCD3F>
 <Z8nfPlJu8kxUvB8m@casper.infradead.org>
 <Z8nnPYldSXs5TYND@gourry-fedora-PF4VCD3F>
 <Z8nsgr46eVH7W7SJ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8nsgr46eVH7W7SJ@casper.infradead.org>

On Thu, Mar 06, 2025 at 06:42:10PM +0000, Matthew Wilcox wrote:
> On Thu, Mar 06, 2025 at 01:19:41PM -0500, Gregory Price wrote:
> > Divorced from the tiering mechanisms, is making misplaced migration able
> > to migrate unmapped pages not generally useful?
> 
> The only thing I can think of is if you have a process or set of
> processes on node A calling read() and the file is cached on node B.
> But in order to decide if the page is on the wrong node, you'd need
> to track a lot of information about which nodes the page is being
> accessed from.  Which is probably why we've never bothered to do it.
> 
> This is not a large patch for you to carry as part of your patchset.
> There's nothing intrinsically wrong with it; it just has no users in
> mainline and no real prospect of any being added soon.

That's fair, I'm just tracking 3-4 different RFCs that are going to butt
up against this, so wanted to assess whether getting the patches out
ahead would save some strife.

~Gregory

