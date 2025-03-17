Return-Path: <linux-kernel+bounces-564438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CC7A654F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34A6189141F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C837E2459FD;
	Mon, 17 Mar 2025 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q+olO4wK"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170B62459F4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223915; cv=none; b=o4wt6yT77+8oFq2jn+lkBay8MVL1xlCgq6zri3SKz+s7nAtBJWkIIHqBa3gXnUyp+elpW5LDI1dqlkJCLjLCz5Ra5EBiyPFqQir8hy2QZkayhZIQOJcHq6lkoS47EaSdxH0pT/w1NIlPSLwQ/jDyZMf9/NL/TbSSfZMz44AEHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223915; c=relaxed/simple;
	bh=F0jwFdV2ejOVm4uU3dUp/mvCHLK4IO5vrf2d/BcRhjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIHpv0V3wiBl0lEdhJnt94hPERLAIyo0dG/M4posJj234FmFDumieyX+C/QiC06anHEYnYLB3pefIVz/9FgkNJJOTtUfv8+1lZXpxn8Wqb5onYvY9zud2LgCTcyL6fw2OU0ABkOgL5jUV7ICh+qGWhtvHoBXkwo5+1xOVbPzU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q+olO4wK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c55500cf80so343459585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742223912; x=1742828712; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Do4PfAhRjN1ZE9q+tkrUXzMGcEKWLaXah+vytV6rKAI=;
        b=q+olO4wKymjfzWWOfBll+YHD0OKT0JhQZDpD7nVaWFQeMOlVaRVqQn0/YIfbsigiVt
         AlixVC099814U+ac47Oot6mzPC8F75fVHs1h9JJok3rFWomp4uZtK3h6gu1LXYIHC0dP
         aau6f6FiD2q+LEnf5X/6V+EIQiwAWZpxXQuTtq0lEOoJUyQQU1alVqLO4kgxzNhPFBKF
         x8O0S2RAo0WdBf56xCsKGpuNOJ7bOYLGnTds5AIj0FY6YvYc7Lmg4ysge0/OgqsiNs5j
         5n3ISP2hg+zKzlvkbck2rSc38Ik614asethLHrm5hm+m2lsnvHoROrSAYlkzKdokmC9q
         XjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223912; x=1742828712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Do4PfAhRjN1ZE9q+tkrUXzMGcEKWLaXah+vytV6rKAI=;
        b=Q1E6gvmX813j5CCztWH7vv94+JyLsQGHzggRTzm2psntw6QdrLHGprdFa0fCFeFgDw
         3rOLpsEkcWLcGU7KOwCJzSPJOieMQJjmQmKarnYECN3EUAv4qzfuxdnhtEMb5X3rnuk/
         4zFRT9IO9BEh4WXApEOowaO3JI9uObLPmR0OdYp1pHDqmwYIYn3bpFrQH1Z1dYmwYFy9
         yVPN+CrWSY/jOj9IP5zcl7eykKrFKqSSDvA3a0o0v0InmkbJygEHHJ62NBQvdSmESSED
         ZpMjP/5GdoWBL0Gdjr53AdY13jyzQ1UCCCjVIuGbX7mkwL5+3XFUXy5NYaAiJ6CaRK+o
         naUg==
X-Gm-Message-State: AOJu0YwcrjyChDst3qx83Va7yewTrAapn88VM8bUt8fVe281qd+YUqiY
	Q08EkQ5l8y4eEROuhUBi5nvvr3QcBEy1xDYhPlDA0JI331sH5rnkaGES2IEEx7K+dE1wAr23Z1a
	5
X-Gm-Gg: ASbGncuZ9/2QYzZQm6JTmaFhiLatoWcKjOEkjjoAemydR49LvgEYRasPAOSBdWB4eNM
	6hkOLjcGsjG6H4A++iUSOx+bKhYR4v4PF6ZCFaoqq2USkogTPERRLAcg+tC3voH1Kn6Zn2M8AV5
	8HH48XT054xahUHtzRw4FZ8+Ah5usZxnmQOT3YD64Ofj5laDun6aVEidglaqWKnUD69sNEck0Dq
	T+m94vZFHF0ISyUXDtLhCIdM8j3CWUQZd75nt++GTa80cXDZ0AZAcXcxPB1QxQXpBEzlUq+49Ow
	Y/6v/vCjwle4ceWHEIJEibHupHmDOCaQpMHocdsVVBRpl1JtxQJBpFtqC2BbG7vbsUV6HaeuNeo
	IsB3lFU36qb5cFfoZa8FW3wcZuI4=
X-Google-Smtp-Source: AGHT+IG21+kCqbdPsFmlT3qZ0Ku1ARmrjRaphX6XmemOTmyDUqobP8hrLzB24w1nkifNUyeEnm3Lvw==
X-Received: by 2002:a05:620a:1d0d:b0:7c5:4711:dc54 with SMTP id af79cd13be357-7c57c5acf88mr1721265485a.0.1742223911830;
        Mon, 17 Mar 2025 08:05:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573da47ddsm593190685a.117.2025.03.17.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:05:11 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:05:08 -0400
From: Gregory Price <gourry@gourry.net>
To: Bharata B Rao <bharata@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
	Jonathan.Cameron@huawei.com, Michael.Day@amd.com,
	akpm@linux-foundation.org, dave.hansen@intel.com, david@redhat.com,
	feng.tang@intel.com, hannes@cmpxchg.org, honggyu.kim@sk.com,
	hughd@google.com, jhubbard@nvidia.com, k.shutemov@gmail.com,
	kbusch@meta.com, kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com,
	leillc@google.com, liam.howlett@oracle.com,
	mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
	nphamcs@gmail.com, peterz@infradead.org, raghavendra.kt@amd.com,
	riel@surriel.com, rientjes@google.com, rppt@kernel.org,
	shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, yuanchu@google.com
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
Message-ID: <Z9g6JIAPZof2eFbJ@gourry-fedora-PF4VCD3F>
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-3-bharata@amd.com>
 <20250313164430.bzkfyqmx6a5dj7d2@offworld>
 <b9965654-af90-42c9-8e4b-b29621d11ea7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9965654-af90-42c9-8e4b-b29621d11ea7@amd.com>

On Mon, Mar 17, 2025 at 09:09:18AM +0530, Bharata B Rao wrote:
> On 13-Mar-25 10:14 PM, Davidlohr Bueso wrote:
> > On Thu, 06 Mar 2025, Bharata B Rao wrote:
> > 
> > > +static int page_should_be_promoted(struct page_hotness_info *phi)
> > > +{
> > > +    struct page *page = pfn_to_online_page(phi->pfn);
> > > +    unsigned long now = jiffies;
> > > +    struct folio *folio;
> > > +
> > > +    if (!page || is_zone_device_page(page))
> > > +        return false;
> > > +
> > > +    folio = page_folio(page);
> > > +    if (!folio_test_lru(folio)) {
> > > +        count_vm_event(KPROMOTED_MIG_NON_LRU);
> > > +        return false;
> > > +    }
> > > +    if (folio_nid(folio) == phi->hot_node) {
> > > +        count_vm_event(KPROMOTED_MIG_RIGHT_NODE);
> > > +        return false;
> > > +    }
> > 
> > How about using the LRU age itself:
> 
> Sounds like a good check for page hotness.
> 
> > 
> > if (folio_test_active())
> >     return true;
> 
> But the numbers I obtained with this check added, didn't really hit this
> condition all that much. I was running a multi-threaded application that
> allocates enough memory such that the allocation spills over from DRAM node
> to the CXL node. Threads keep touching the memory pages in random order.
> 

Is demotion enabled by any chance?

i.e. are you sure it's actually allocating from CXL and not demoting
cold stuff to CXL?

> kpromoted_recorded_accesses 960620 /* Number of recorded accesses */
> kpromoted_recorded_hwhints 960620  /* Nr accesses via HW hints, IBS in this
> case */
> kpromoted_recorded_pgtscans 0
> kpromoted_record_toptier 638006 /* Nr toptier accesses */
> kpromoted_record_added 321234 /* Nr (CXL) accesses that are tracked */
> kpromoted_record_exists 1380
> kpromoted_mig_right_node 0
> kpromoted_mig_non_lru 226
> kpromoted_mig_lru_active 47 /* Number of accesses considered for promotion
> as determined by folio_test_active() check */
> kpromoted_mig_cold_old 0
> kpromoted_mig_cold_not_accessed 1373
> kpromoted_mig_candidate 319635
> kpromoted_mig_promoted 319635
> kpromoted_mig_dropped 1599
> 
> Need to check why is this the case.
> 
> > 
> > > +
> > > +    /* If the page was hot a while ago, don't promote */
> > > +    if ((now - phi->last_update) > 2 *
> > > msecs_to_jiffies(KPROMOTED_FREQ_WINDOW)) {
> > > +        count_vm_event(KPROMOTED_MIG_COLD_OLD);
> > > +        return false;
> > > +    }
> > > +
> > > +    /* If the page hasn't been accessed enough number of times,
> > > don't promote */
> > > +    if (phi->frequency < KPRMOTED_FREQ_THRESHOLD) {
> > > +        count_vm_event(KPROMOTED_MIG_COLD_NOT_ACCESSED);
> > > +        return false;
> > > +    }
> > > +    return true;
> > > +}
> > 
> > ...
> > 
> > > +static int kpromoted(void *p)
> > > +{
> > > +    pg_data_t *pgdat = (pg_data_t *)p;
> > > +    struct task_struct *tsk = current;
> > > +    long timeout = msecs_to_jiffies(KPROMOTE_DELAY);
> > > +
> > > +    const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
> > > +
> > > +    if (!cpumask_empty(cpumask))
> > > +        set_cpus_allowed_ptr(tsk, cpumask);
> > 
> > Explicit cpumasks are not needed if you use kthread_create_on_node().
> 
> Thanks, will incorporate.
> 
> Regards,
> Bharata.

