Return-Path: <linux-kernel+bounces-568333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E86A6940E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50349188C442
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879D1C1F02;
	Wed, 19 Mar 2025 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="tS+DbH+/"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC841CAA8A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399077; cv=none; b=VDGRdWWzu/USt2WGjQhL2U25Zqg+saVt2/PMkQCvDzpxqBDx5zW33RHLKSW2oqAz2+RDTNU5LLEKjtjK+jPGT7eaOygXMJfXe1fkfdUi98DA1pasgD39XTDX7WgtkUBB2XLB1gITJAoY1/toyeYPb4ZLQ5K5PtrJPOsfrcgwDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399077; c=relaxed/simple;
	bh=ijx4QVA6cu7/bppMn4qjyQgrq7PDRcrE8h4ApLxVMGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV4Iugqh4mxRUDFomdWqCfv5FxLLT082+ef0iMKXFBkGQBHl/RevyVoGQAD+d3rCZ91Y/H5xAwS6g5upWDoTGcOLFLSGmojZJRr248Z9PpiSGHzCXl50YPLQj4nG43ShUWU6y6oxt6I2yKyNmwU5UuO7NHDDqIiSI1esiN4u2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=tS+DbH+/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47686580529so58585121cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742399074; x=1743003874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9si6QKET998u7WyNlD/oIsbCSW0xvxa41wWw0Ozqipk=;
        b=tS+DbH+/UZlkS/aF4DyezYHorNb/pFwXbKo/UvY4EVdZSx/jbqOVyIYd+CGgx8rLvo
         1A3YrAzGY0AC0BNb6LYD/99322ufTOIkGMxSXN3xbcKoQuveAh9CvEdKiDKIcRlj58XE
         xNk8BiJFfp3ZI0fZwMAf9AmRGcMc8dnZH1ZiHV4YZg3tkNDvQksIye2al2pAzgrmr2Sg
         nAs/qua4G+YBw+Xp64j39s8orrFOsmFkZnTlQm9Okp91Zm0gf5W/6ealoTKFtGavAbYY
         vA8NTnCI5m+fqKyU5IfgmAhJ6fANAHkHkoTJOUIu7Ka9xYe6t0psukdYy2Xw7cukP+n0
         03Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742399074; x=1743003874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9si6QKET998u7WyNlD/oIsbCSW0xvxa41wWw0Ozqipk=;
        b=FItse2H40ClWpsRzUWPnA3MS/vSDJS0I/unQGCZFxnUEYKTVFTNWRo9bZ8sqhO367J
         ReULjLPCnupBPckrEVI9srxZDID8r6uCWFiD4mbhKQapWfrlbfJeCPv+4Q7iBYS+CW+e
         do38s7mBAHL3bwkk7AyJ2vbM10fuK3NHf1ljoWJsKIISIM2Yg5taQHx8Oxml5urEY6ew
         nRJd014IKxgB/KVzEqqD8Wkm4yAO1IT2KpiFIJqPESQsIHCPRzPiw9y5pOXB3xLaPoJk
         T87y2Vv+V5XW8/pptwReLE3Jd1S/ejRzkvpRpHaunIJoDyLS0ODbrqzjifTDuXhO5Qmq
         0/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR3Pdqh1tch8oIW3oXUcnIPkv8Daa9GJp2znO2dylv+KelwYhJ+OoaSHwDG7XqE0Aj4GqCDb+8NJCq3r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmnkvTRrg9K+1vUEEMjyBC9t/NsNY2nWq2fNIb6W10nVmsa7uk
	wTyI/JX9tp87Zyqo+LVpdYCpkztZDShB5FRhjr6rerPyNu756YESC5096xrN7B8=
X-Gm-Gg: ASbGncvOgwX8X0Z/lTde+xq0u/e38qcSg9k0sGN8i5RcFkATQq8PvgJmpsFKm1hHaDJ
	omPnA6P4PY7MVk0HLQAMdvLPmomVNxYjagAI87YWcTp3o1+D44IzoSZxoIfoOvM4oGVH9zu/ITL
	Dga1EdpvZCYfvCBsh/BfstVnWUFQydRCe/cgqIGYJ1iELRWQinR2MhIsYt8rn2V+QP3x4op3HU+
	N9mWsDg3vF6/SlRssg2NlXpAJFi+9Ggt+FGLbPw72a7Bw+o96wXhGGUGWcdfhQu8Ov+sX+BfiaU
	gFzIK7vuAT2NAxU9FPii79Gg4k3FZ97wppgnP4iX8lc=
X-Google-Smtp-Source: AGHT+IH2ElysGznDqaVkF9K0dG1j3qwf6OVzHoFCKXB3QMfIF6k7b3yKuQfRi9aAY26/yEo88wfixQ==
X-Received: by 2002:a05:622a:2b4a:b0:476:8296:17e5 with SMTP id d75a77b69052e-477082f00f2mr50488621cf.17.1742399074007;
        Wed, 19 Mar 2025 08:44:34 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb7f3c86sm81158871cf.54.2025.03.19.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:44:32 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:44:28 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Hao Jia <jiahao1@lixiang.com>, Hao Jia <jiahao.kernel@gmail.com>,
	akpm@linux-foundation.org, tj@kernel.org, corbet@lwn.net,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
Message-ID: <20250319154428.GA1876369@cmpxchg.org>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
 <qt73bnzu5k7ac4hnom7jwhsd3qsr7otwidu3ptalm66mbnw2kb@2uunju6q2ltn>
 <f62cb0c2-e2a4-e104-e573-97b179e3fd84@gmail.com>
 <unm54ivbukzxasmab7u5r5uyn7evvmsmfzsd7zytrdfrgbt6r3@vasumbhdlyhm>
 <b8c1a314-13ad-e610-31e4-fa931531aea9@gmail.com>
 <hvdw5o6trz5q533lgvqlyjgaskxfc7thc7oicdomovww4pn6fz@esy4zzuvkhf6>
 <3a7a14fb-2eb7-3580-30f8-9a8f1f62aad4@lixiang.com>
 <rxgfvctb5a5plo2o54uegyocmofdcxfxfwwjsn2lrgazdxxbnc@b4xdyfsuplwd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rxgfvctb5a5plo2o54uegyocmofdcxfxfwwjsn2lrgazdxxbnc@b4xdyfsuplwd>

Hey Michal,

On Wed, Mar 19, 2025 at 11:33:10AM +0100, Michal Koutný wrote:
> On Wed, Mar 19, 2025 at 05:49:15PM +0800, Hao Jia <jiahao1@lixiang.com> wrote:
> > 	root
> >   	`- a `- b`- c
> > 
> > We have a userspace proactive memory reclaim process that writes to 
> > a/memory.reclaim, observes a/memory.stat, then writes to 
> > b/memory.reclaim and observes b/memory.stat. This pattern is the same 
> > for other cgroups as well, so all memory cgroups(a, b, c) have the 
> > **same writer**. So, I need per-cgroup proactive memory reclaim statistics.
> 
> Sorry for unclarity, it got lost among the mails. Originally, I thought
> about each write(2) but in reality it'd be per each FD. Similar to how
> memory.peak allows seeing different values. WDYT?

Can you clarify if you're proposing this as an addition or instead of
the memory.stat items?

The memory.stat items are quite useful to understand what happened to
a cgroup in the past. In Meta prod, memory.stat is recorded over time,
and it's go-to information when the kernel team gets looped into an
investigation around unexpected workload behavior at some date/time X.

The proactive reclaimer data points provide a nice bit of nuance to
this. They can easily be aggregated over many machines etc.

A usecase for per-fd stats would be interesting to hear about, but I
don't think they would be a suitable replacement for memory.stat data.

