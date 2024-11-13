Return-Path: <linux-kernel+bounces-408403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D379C7E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9691F220E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0C418BBAB;
	Wed, 13 Nov 2024 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0BRTHVH"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADF815444E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537752; cv=none; b=uQCXK/SDo9Add8PwBApX6IZtRVFGTUPwi4TZWMs/fHrWytZvPqNrVZr31zJu/uZ15HnUP7GKHWgrwFmHgLh49RDPC4ztyzhwOjpZKi93O/DXC/IzqxSkPVDBnU9fyQT2tR6we1bLH5T1DxBDHAcQ5mA90u/gnULzrTDmmZZtbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537752; c=relaxed/simple;
	bh=9pNOROf7TWR2JtIXPLrhkgnISjLpTD0sYz1c27sb9UA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qUABcjZhwYcUV719HVXqbLK5FtsfI39mLkPbRspN77+QPWSqDCVRxYFC8b+POPE/E6gyihRM228J7MaG4vI658N2YoCpurfpsph0cZZHnkp9xP1YNV9JOhU6LbVfkWS+87btuEtREgc/443GwjCTd7G0cqazR9yo/NQd9tpYJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0BRTHVH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c87b0332cso7215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731537750; x=1732142550; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieehf+E6LMEA4ReJKxyD53FpolrCogZOFJkea/91AC4=;
        b=r0BRTHVHu02TqFQJqMnM+Lp6+CmD4WMpnWf53BBgInVK8eT6ZTYA8dHAKEJcwn9d1O
         BvacqPRgFhppIAfv2aZIe2DAoQ382H2d5b3sIwRlNLWETbBxM39WVaaboCv7VUJtrYor
         EPawi+T6kqzzT3Dhl8kmOj6Hu1AJArMcyV+mq04lxuyPnF+7Q6yyALN7QEIEq3N121yP
         Ukip6eVMO2+OjQUduGztBiPTSja4wHqbs95vAKrMRVcl5f+mFAvc4twFNwenKPNedg+Y
         ZDptKrHOTvCAJcMYb70X1LwOAlymme5zz3L0LUNBv20FRZL7+41Po7bHNstY6EFnwpmG
         3XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731537750; x=1732142550;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieehf+E6LMEA4ReJKxyD53FpolrCogZOFJkea/91AC4=;
        b=eLID6t6YMoLv4wxeuLaWMw5S3Wpr34R2vwUdB6/Yzy7oVy+ueUffppsxMoT3X0O5og
         SXAr/JKa1e08uv6mqGt1EBKCKK7n+Hz7Ly/4afz/Eonq0qssPm2fk2YFu9GkmIGVGRVi
         1kcuPUhYX+hPHb61MXkfeTrBn04Wbz5c3muiqMB5rrfeRxVqemjhthGa+PV/IyoEAAkM
         tLO3NHOE0tLj1LUt0UaQPf+YupcqnKzFxEgtoi49pkGMiPGJT0NCHrYvpO6v9jCJK6YB
         MYLNhfUF1nBaaw1Y1Xpxyb25nHD/1m0eQ3On5TPZvMHk54ickdtLEPekm+EmklAzavLM
         5p5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXth7ZafYhdHYNdi0CECzSD650oJpiCReuZecrOmnHru7uvW/P+9LFKIBIi04JR6Gp/xOO3NQxHjVIEowY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXzJxPKzqBuIHIPcQV2bjxLEMsshMRjTbnjelf0RH8c+U2S7M
	4BVVQULBfEGXNc41a87SFTrz7RfHECg6Gb5LyY9rDiT97EQGUYhVMR8vCWRayQ==
X-Gm-Gg: ASbGncte5bKd+Lrqln08wXm3+l8vxBHywdvOKGnWIywQJ2AzxSPcrlv6ih7X9Jlhv3b
	DfwcQn+p88SWhXPoGJGbnpwABmzGk01FwwdkoRIKFun+6/WmhweUizMHIxD/+Nk5tAv4n3CqA3d
	KZaflMyIOgAIQuq9dsm4UQK3XfYEuXPo/NICfLcc/dFUjuAIY4O2Vl04baWv2XfqTq6FPY/LZ5e
	FDbZos85kn9kz2QWKYxoqWk1JfRZXid07d6WhAx1IUAfqLz6qZ/RuHgjdMA5o0DPsWXNFQ1mJWk
	Rdmf
X-Google-Smtp-Source: AGHT+IEEnqKMwGy+6M5UqJv9rrrpl3mUiwwjrWvoQVOQqROaho6ADPFiiCjrnLC1sQ4UdZv0xFkCzA==
X-Received: by 2002:a17:902:ea10:b0:20b:6c3c:d495 with SMTP id d9443c01a7336-211c369658amr254265ad.25.1731537750084;
        Wed, 13 Nov 2024 14:42:30 -0800 (PST)
Received: from [2620:0:1008:15:93ad:2d94:6e99:1a3c] ([2620:0:1008:15:93ad:2d94:6e99:1a3c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a18f51sm13753218b3a.155.2024.11.13.14.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 14:42:29 -0800 (PST)
Date: Wed, 13 Nov 2024 14:42:29 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
    shakeel.butt@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
    chris@chrisdown.name, tj@kernel.org, lizefan.x@bytedance.com, 
    mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, cgroups@vger.kernel.org, 
    linux-mm@kvack.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 1/1] memcg/hugetlb: Add hugeTLB counters to memcg
In-Reply-To: <eb4aada0-f519-02b5-c3c2-e6c26d468d7d@google.com>
Message-ID: <c41adcce-473d-c1a7-57a1-0c44ea572679@google.com>
References: <20241101204402.1885383-1-joshua.hahnjy@gmail.com> <72688d81-24db-70ba-e260-bd5c74066d27@google.com> <CAN+CAwPSCiAuyO2o7z20NmVUeAUHsNQacV1JvdoLeyNB4LADsw@mail.gmail.com> <eb4aada0-f519-02b5-c3c2-e6c26d468d7d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Nov 2024, David Rientjes wrote:

> > The reason that I opted not to include a breakdown of each hugetlb
> > size in memory.stat is only because I wanted to keep the addition that
> > this patch makes as minimal as possible, while still addressing
> > the goal of bridging the gap between memory.stat and memory.current.
> > Users who are curious about this breakdown can see how much memory
> > is used by each hugetlb size by enabling the hugetlb controller as well.
> > 
> 
> While the patch may be minimal, this is solidifying a kernel API that 
> users will start to count on.  Users who may be interested in their 
> hugetlb usage may not have control over the configuration of their kernel?
> 
> Does it make sense to provide a breakdown in memory.stat so that users can 
> differentiate between mapping one 1GB hugetlb page and 512 2MB hugetlb 
> pages, which are different global resources?
> 
> > It's true that this is the case as well for total hugeltb usage, but
> > I felt that not including hugetlb memory usage in memory.stat when it
> > is accounted by memory.current would cause confusion for the users
> > not being able to see that memory.current = sum of memory.stat. On the
> > other hand, seeing the breakdown of how much each hugetlb size felt more
> > like an optimization, and not a solution that bridges a confusion.
> > 
> 
> If broken down into hugetlb_2048kB and hugetlb_1048576kB on x86, for 
> example, users could still do sum of memory.stat, no?>
> 

Friendly ping on this, would there be any objections to splitting the 
memory.stat metrics out to be per hugepage size?

