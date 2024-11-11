Return-Path: <linux-kernel+bounces-404457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85039C440D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C08B29F75
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19911AB52B;
	Mon, 11 Nov 2024 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1MnQIPV"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9D1A7AE8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346872; cv=none; b=DhhYY3T6CcyEwV5IWZvxFxpwfR2eJKvnRs2o7PxPQIhQ/Nt1st+Iu/L0qGMASDqHAbIIbr4kZpuUZ7ObcHvoqVz0GhurCZ83I8mhttW7sPAgYB/WLdWAldbqyETWZgDJxMnFVAI7AV/WILO2pxcqtfM1JfYMEIDFibV5QEbUCvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346872; c=relaxed/simple;
	bh=WE626Jhme0ym7/q8fggm9jaQXx4lOcP4ZRcFhn00/PU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ivBBq+SAxc0KmBSbnFgF1oMWVcPtt3XpX83F3lS7HSVQH939v7SMy7nXbY+eC/crekX/BxTNnnL84uPqO1nLu6e/phFuSMcdye1oTSmSY0h51hNkJTKr0FYQEYYuDcmnbSKs6HGX3uSrbW8BVGM+zfvYJCFZpSXIdKVCFmSCmfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q1MnQIPV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca03687fdso2595ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731346870; x=1731951670; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=spB5wl1urQkI+7B+IPtWDDKj9S/WJUklG9CxIStging=;
        b=Q1MnQIPVS7F2oJA4F+M/9PKEYdh3yaA+H+cHuer6HOalSuZKrsURYy03ic8CEvwwGK
         DvJnIgEAnFAiqZVehHNuJ3OEe+4qnqeGpJPhb/eQ1G+7EfVLyXK52aooe+DqgaUnkhtn
         dmaNQLWFZ7Pmsf8jB2USj9mdu4LyYZoAm42VRYFFazT/tEvPsW6+6kg6zDTJt+NgKWS0
         wG5axKeZ1InEXeVTmxT5AcMMKJE2EdfFv6ZHUwKuj4AHahBRlPj53RzhLFL9CtLLuV/m
         FrYjnLcE9nY1jVEV4BlHHWYteIccUrKRTUSUu5i26ELmwtcuClivdNQE2cxALe8eCUwa
         +Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346870; x=1731951670;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spB5wl1urQkI+7B+IPtWDDKj9S/WJUklG9CxIStging=;
        b=ozgEBpYJI/BG9EonGG/mdeok7BJjjQv1262pnQhsdS909hppr6KSTIvuxAqNGaj+aP
         G0I0wewAoybdGR34IyjC9sRb1NKE+n/bQYxgCZtCOFqVrwqA4jWgFmWB7IjIwZMdnPlY
         UFN2kx45nU1XA3LLGPZxMxuLjVLokya6b06xbn28N23nu1HO2B/fatU8l6EPPq2WhKcY
         7ySbI3SolyvRvLoJnnvQ48bZRqOghUIgVJ9fTj8028vAkXiychO5Ob9VHgiSZIt/6ql/
         TkceZUp96eFe8HXSqRyO2im6ZXGStW7g00gbppEGZZJUqm7ooDU/YpOlcySJNjRZFkpE
         BVxg==
X-Forwarded-Encrypted: i=1; AJvYcCW9u1lC/31oJK6RWBS4Z/oXHKsBrlWxoJzlFn5wRRlR9L5BIzThAvhT9gs88yyC1E0qV299Ca/V2W4wzak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbx0rplA89dpBH2pCZ+qC3CUA4/NVb8Wn1CoVZiJiP+cxmkYdT
	ElLQ/SfpLHaXRZfGwDbmasRC/P52UowPGBvwy0uRe6TLisFeA0xE/Y328X/B0Q==
X-Gm-Gg: ASbGncuNa8zGZcvG/+4utPR+3Ssoosaa3VoFguXqJ04wIyc+RePHnQrzVOORMbwAAzh
	QvGQ5JisFK5VsN73nBMQvm7sDxOmvRV3cEeqV7S0QcV5ew3Vk3bxWnSYZszQc7A2PU+h35kVALs
	di944m/tLQVHGHfGT9xyJDaYVaLLNLlyKcA7/XxO78XN8562/oQTdrWE5nEVgC72uzuQ7LFb72F
	GmMaq7XZv+E6pD/HEi3RVCDKeBYxIf4rxsrcvjCNb1lYONvh3PpNmv+BVhuNkbb+fP8hXmmCNd2
	62PP
X-Google-Smtp-Source: AGHT+IHi97GLH/TqT3OzZu+s1FpiP4ABTo0w4bQUtXQTxsCqbBljDo6Rmx3Z4cy0o9PUG5WKfE9Bkg==
X-Received: by 2002:a17:902:db0a:b0:20b:13a8:9f86 with SMTP id d9443c01a7336-2118df842dfmr4318285ad.28.1731346869501;
        Mon, 11 Nov 2024 09:41:09 -0800 (PST)
Received: from [2620:0:1008:15:ae3b:d774:6c29:d63c] ([2620:0:1008:15:ae3b:d774:6c29:d63c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e4196asm78754925ad.162.2024.11.11.09.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 09:41:09 -0800 (PST)
Date: Mon, 11 Nov 2024 09:41:08 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
    shakeel.butt@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
    chris@chrisdown.name, tj@kernel.org, lizefan.x@bytedance.com, 
    mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, cgroups@vger.kernel.org, 
    linux-mm@kvack.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 1/1] memcg/hugetlb: Add hugeTLB counters to memcg
In-Reply-To: <CAN+CAwPSCiAuyO2o7z20NmVUeAUHsNQacV1JvdoLeyNB4LADsw@mail.gmail.com>
Message-ID: <eb4aada0-f519-02b5-c3c2-e6c26d468d7d@google.com>
References: <20241101204402.1885383-1-joshua.hahnjy@gmail.com> <72688d81-24db-70ba-e260-bd5c74066d27@google.com> <CAN+CAwPSCiAuyO2o7z20NmVUeAUHsNQacV1JvdoLeyNB4LADsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Nov 2024, Joshua Hahn wrote:

> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index 69af2173555f..bd7e81c2aa2b 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1646,6 +1646,11 @@ The following nested keys are defined.
> > >         pgdemote_khugepaged
> > >               Number of pages demoted by khugepaged.
> > >
> > > +       hugetlb
> > > +             Amount of memory used by hugetlb pages. This metric only shows
> > > +             up if hugetlb usage is accounted for in memory.current (i.e.
> > > +             cgroup is mounted with the memory_hugetlb_accounting option).
> > > +
> > >    memory.numa_stat
> > >       A read-only nested-keyed file which exists on non-root cgroups.
> > >
> >
> > Definitely makes sense to include this.
> >
> > Any reason to not account different hugetlb page sizes separately in this
> > stat, however?  IOW, should there be separate hugetlb_2048kB and
> > hugetlb_1048576kB stats on x86?
> 
> Hello David, Thank you for reviewing my patch!
> 
> The reason that I opted not to include a breakdown of each hugetlb
> size in memory.stat is only because I wanted to keep the addition that
> this patch makes as minimal as possible, while still addressing
> the goal of bridging the gap between memory.stat and memory.current.
> Users who are curious about this breakdown can see how much memory
> is used by each hugetlb size by enabling the hugetlb controller as well.
> 

While the patch may be minimal, this is solidifying a kernel API that 
users will start to count on.  Users who may be interested in their 
hugetlb usage may not have control over the configuration of their kernel?

Does it make sense to provide a breakdown in memory.stat so that users can 
differentiate between mapping one 1GB hugetlb page and 512 2MB hugetlb 
pages, which are different global resources?

> It's true that this is the case as well for total hugeltb usage, but
> I felt that not including hugetlb memory usage in memory.stat when it
> is accounted by memory.current would cause confusion for the users
> not being able to see that memory.current = sum of memory.stat. On the
> other hand, seeing the breakdown of how much each hugetlb size felt more
> like an optimization, and not a solution that bridges a confusion.
> 

If broken down into hugetlb_2048kB and hugetlb_1048576kB on x86, for 
example, users could still do sum of memory.stat, no?>

> I have not had a scenario where I had to look at the breakdown of the
> hugetlb sizes (without the hugetlb controller), or a scenario where not
> knowing this causes some sort of confusion. If others have had this
> problem, I would love to hear about it, and perhaps work on a solution
> that can address this point as well!
> 
> I hope you have a great day!

You too!

