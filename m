Return-Path: <linux-kernel+bounces-390142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83929B7618
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9A91F22992
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEAF153BE8;
	Thu, 31 Oct 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YkTGwZd6"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B1152166
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362371; cv=none; b=q4XRZ1hH1Eq/7Oa+BJEpdR3LuZQNOvu+9X3mO4TmU6j3huJVk2GHxWAkriuMF6m8/3teVv/MGAOzzbCMlElg3TVdeQR7CdaiH+TZyeCUXdXh7iQCs8qkiO0sIgUvX3Utc6yfPcf9tARo4SUlo+a78Tg9fMxOS+NvHxLbgvj4/wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362371; c=relaxed/simple;
	bh=dklUTvxcoZQ19Ejb/he4j0SPUhxKOWxWCHjH3frzbvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaabO0UBw7llXxPvp589mmEHTnuOicbpfk8NycwFhK2FkHJmtu6ewDAAVP2Y1e+UQf+ZzxGemb8bnDip7WrpdtO9pVu2xzyelV3QB262BS0zCGc4w2UzL1u9/a0/RbYX5/u8xG5QAnh5bXqnGY//hnNUbx2vbGqaUH3ChypEMuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YkTGwZd6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0f198d38so96384466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730362367; x=1730967167; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1NsFGdhFHt7vNHkeF4Op7bN0bdu6mqlOlf3mw5K16Yo=;
        b=YkTGwZd6OwFKvJ90DPsrAQ9v2fHOG4UyzuZuqAhFFkdF3RCSV9y5fefzSDGAkLN4Ow
         UAdSohUG+O+iCPUwUJGnTRbdHad9ACB6BvVQoGl6MlISBrvKZKM9Lp2XhUWbKJJJYY/o
         uuzLNOTxUj3s1flyPn383Sehy6EJli/6V7GdT8w1QRKlvQE+GIpAaM2hd6FoTfHYJ1kT
         iLouf9O8ByTMMkaEUucHcsLlrxVIIwjCMBuy/Po95A7v4j4rTcr6bT/J/rTlP1ApwO+g
         B2S1/2PZbPrRZmU+Iy2+q4jv9KuzjvbNzrxXcqzlqeF4X+fg5pVtz7B4FQYYK5DzojgQ
         flmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362367; x=1730967167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NsFGdhFHt7vNHkeF4Op7bN0bdu6mqlOlf3mw5K16Yo=;
        b=Ebyot5LCFuOzSk3k+g5vP8nU3sWPjZlzxI7pPykCLozw6PWnAIH7njhuDFMCFUhUp5
         l4HnltQVpgvXNPtfyOXz6AeLA+oHRdKmTB2SuXGuZD7RkssJmKNMUxlv/CAjgzCA6qVC
         X3a2sXAnthfw/xbSWzsQFfQFIX0i6hOgaYfiWHXN9I2UG2+4juAA9YnvI2Aas7EdRkLQ
         Mnvs1oyV1h+dq+psjUrBdRqH5SwFoLbtQjMhpHkigIRKfsXlKcMCXzwGjI58vVUgSw99
         GrrBsmoLVehF01KA6pJOJeHEdKQ+A+Egdd4MDh6Zu15lqvUBG2YVGA1dOnFHLdr4LJf9
         uq3g==
X-Forwarded-Encrypted: i=1; AJvYcCXYTCi+0FEtfTTdNrWVqLYL2uA5zRMuQSY2NCsu8qDO6WMDYIaWorgc0/KTuKWmbRYj9Okxc9iTHgq+cRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTalkGRpgTBPENx2yYMFOD/wjo7wTBTX3VUJLQX2jBhdQ9sad3
	3VJD6sAJTQXnyR220KXuvWH9+P2ReROzOFZd6nqwp1MGdslmkNidolt/Nz5pJOk=
X-Google-Smtp-Source: AGHT+IErqAcDPZr221CAovWq14T0+yAWNPysXadW1rVCxC28+QsDk01at4oQ+oc4iW1WxHhAWm19ug==
X-Received: by 2002:a17:907:94c1:b0:a99:4ca4:4ff4 with SMTP id a640c23a62f3a-a9de5d98002mr1492014866b.23.1730362367461;
        Thu, 31 Oct 2024 01:12:47 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c55ffsm39587566b.59.2024.10.31.01.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:12:47 -0700 (PDT)
Date: Thu, 31 Oct 2024 09:12:46 +0100
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, nphamcs@gmail.com,
	shakeel.butt@linux.dev, roman.gushchin@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
	mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <ZyM7_i1HFnFfUmIR@tiehlicka>
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
 <ZyIZ_Sq9D_v5v43l@tiehlicka>
 <20241030150102.GA706616@cmpxchg.org>
 <ZyJQaXAZSMKkFVQ2@tiehlicka>
 <20241030183044.GA706387@cmpxchg.org>
 <CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com>

On Wed 30-10-24 16:43:42, Joshua Hahn wrote:
> On Wed, Oct 30, 2024 at 2:30 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Joshua, can you please include something like this at the end:
> >
> > lruvec_stat_mod_folio() keys off of folio->memcg linkage, which is
> > only set up if CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING is switched
> > on. This ensures that memory.stat::hugetlb is in sync with the hugetlb
> > share of memory.current.
> 
> Hello Andrew,
> 
> I saw that it was merged into mm-unstable earlier yesterday. Would it
> be possible
> to add this block of text to the patch description right before the footnotes?
> 
> 3. Implementation Details:
> In the alloc / free hugetlb functions, we call lruvec_stat_mod_folio
> regardless of whether memcg accounts hugetlb. lruvec_stat_mod_folio
> keys off of folio->memcg which is only set up if the
> CGRP_ROOT_MEMORY_HUGETLB_ACCOUTING cgroup mount option is used, so
> it will not try to accumulate hugetlb unless the flag is set.

Thanks for the update and sorry for being pitbull here but this is
is a bit confusing. Let me try to reformulate as per my understanding

In the alloc / free hugetlb functions, we call lruvec_stat_mod_folio
regardless of whether memcg accounts hugetlb.  mem_cgroup_commit_charge
called from alloc_hugetlb_folio will set memcg for folio only if
CGRP_ROOT_MEMORY_HUGETLB_ACCOUTING is enabled so lruvec_stat_mod_folio
accounts per memcg hugetlb counter only if the feature is enabled.
Regardless of the memcg accounting, though, the newly added global
counter is updated and shown in /proc/vmstat.

I would also add the following

The global counter is added because vmstats is the preferred framework
for cgroup stats. It makes stat items consistent between global and
cgroup. It provides a per-node breakdown as well which is useful. It
avoids proliferating cgroup-specific hooks in generic MM code.

I will leave up to you whether to add above paragraphs but I believe
they clarify the intention and the implementation.

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!
-- 
Michal Hocko
SUSE Labs

