Return-Path: <linux-kernel+bounces-183014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE6F8C933F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 02:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB6F1C20AEE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 00:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C08A8BE5;
	Sun, 19 May 2024 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KY//KQL8"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888422900
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716079641; cv=none; b=azILnpilRKc3if5k9h9DzF5x0PQfQHJRRpOVbPcsqCW6qGBTmow35eqTP+f3t7MC6iXzRmOSBytfgfoebG7nY6lAanBaV08eB3Qq0J/WyMw5nhyIui1PbKXuP60RjhDzaB8FBEkZtqM6bhYuMzfoKTp6LSOQNXjBzn9sCLAbJb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716079641; c=relaxed/simple;
	bh=SNpQ4mbnxwRgNf7F6NglRimOUUsNGWK2lbgVZaIgvEU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lTB80QetqyxWLnpozGImS+nEkzCLCCC/QaOdM5hMC50yCqCx0CNhGxs0+QTDQiXhuvB+Y1Rc+LIDLi2Jd6mUJNGyJ8eRD23zBX+zO2RKVBS9lMvbUM3dI8rE3FKXp682SrpMTWuljOuF72GjvetC67JXnU/971aTl4Qfd4fAaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KY//KQL8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1eed90a926fso73115ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 17:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716079640; x=1716684440; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UX1nBtrrqIgRr44bcjQMv++P2/YYvpyxM8Pb2Eg8Vv8=;
        b=KY//KQL83PRTQCcdxRdzoko0cyOS0QNbb0ZUH8J8rUE64jm8oUA8RY4k1s6M0RluSn
         vYGz0kYSFuCOGmck4fGUhrpQ8w4d+wBwQOrljCFIOEAtlqaAzm4lqAzMVRINNLlcX4N/
         +vLGMqcjm5r2mcQBtqaFuJAgm6xq5jSQJ5FUXQOMjluDF2ffAAMJhufMtApIXKSV2w6C
         KKFYkgooqGG+b+50Em4uBaRDcMvtB3/Qdmndx8zRYBlzt3s9S12QMJNXVhZeLbQsTZBE
         HPp/QGYnRwZmlky4MUetx15LbtAbiw2/zJUCXqNOmF2jo2rj5qZwS2KcdqbEMJFa2aDm
         qYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716079640; x=1716684440;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UX1nBtrrqIgRr44bcjQMv++P2/YYvpyxM8Pb2Eg8Vv8=;
        b=ZcyWDUVlDdZ8L7gMO3CUtHlsWOjFuFzDgJPonkO9kjIDGme2qu7JWXsMTdNLhmzt3H
         71J3eMbQUKmo877rDiQ47ijZKbq66uTFkSdRsPLhATmEiDWer1nFwDn7lAbm53zOrkDQ
         dUT9nybNKdETo05h2pBCEs6cd5E6pVolBOW2lWGjUKA+soMesqYVHZCkBwNc7987tHRu
         EztWIyBXSOKUQZfdotWEOzPzXcTozQ1EH1O9qFfAtiT4EKVK5Y+KXQIDx5+Y3C0bo2QZ
         1hrWCc8YD1RWB3AuZe+uxmciEAvO3dchnsHT4QFaoZIwsiF+fiK4RKRSrye6mTVtjYKN
         /cQA==
X-Forwarded-Encrypted: i=1; AJvYcCVTl11cuuryPH/l6SIdDiNDAnyXhe/kPmbimklbkkZ+SGcq7iXCPu12wj3eUP2ZzQBQPHfFryChffhMF3rMdyAXw7amrH7+WW25XJZD
X-Gm-Message-State: AOJu0YxG8xFPET7AWNDUbKHOSgUPqwJyfiuXsL9ztPoModccxtt/6xxJ
	xRkZBqki5C0T9efbE1HPKOxhd335wS8vV9nr6UWbND6rxLbC0fdxqzSJ4FK2XA==
X-Google-Smtp-Source: AGHT+IF8J6dj1OWr2XdGIAu1kA/WKtIwcErwluJyt9JiHPPvr1R0kOTpnvCHwtIhT2C2Awtmy778NQ==
X-Received: by 2002:a17:903:2ac7:b0:1f0:99c9:ca8 with SMTP id d9443c01a7336-1f2ee0c2bbdmr1382185ad.21.1716079639149;
        Sat, 18 May 2024 17:47:19 -0700 (PDT)
Received: from [2620:0:1008:15:15d8:f72b:f347:b61c] ([2620:0:1008:15:15d8:f72b:f347:b61c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340ca9019esm15042359a12.50.2024.05.18.17.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 17:47:18 -0700 (PDT)
Date: Sat, 18 May 2024 17:47:16 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Sourav Panda <souravpanda@google.com>
cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
    akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
    rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
    chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
    tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
    pasha.tatashin@soleen.com, yosryahmed@google.com, hannes@cmpxchg.org, 
    shakeelb@google.com, kirill.shutemov@linux.intel.com, 
    wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
    Liam.Howlett@oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Subject: Re: [PATCH v12] mm: report per-page metadata information
In-Reply-To: <20240512010611.290464-1-souravpanda@google.com>
Message-ID: <45fb4c94-dd77-94c3-f08f-81bf31e6d6d2@google.com>
References: <20240512010611.290464-1-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 12 May 2024, Sourav Panda wrote:

> Today, we do not have any observability of per-page metadata
> and how much it takes away from the machine capacity. Thus,
> we want to describe the amount of memory that is going towards
> per-page metadata, which can vary depending on build
> configuration, machine architecture, and system use.
> 
> This patch adds 2 fields to /proc/vmstat that can used as shown
> below:
> 
> Accounting per-page metadata allocated by boot-allocator:
> 	/proc/vmstat:nr_memmap_boot * PAGE_SIZE
> 
> Accounting per-page metadata allocated by buddy-allocator:
> 	/proc/vmstat:nr_memmap * PAGE_SIZE
> 
> Accounting total Perpage metadata allocated on the machine:
> 	(/proc/vmstat:nr_memmap_boot +
> 	 /proc/vmstat:nr_memmap) * PAGE_SIZE
> 
> Utility for userspace:
> 
> Observability: Describe the amount of memory overhead that is
> going to per-page metadata on the system at any given time since
> this overhead is not currently observable.
> 
> Debugging: Tracking the changes or absolute value in struct pages
> can help detect anomalies as they can be correlated with other
> metrics in the machine (e.g., memtotal, number of huge pages,
> etc).
> 
> page_ext overheads: Some kernel features such as page_owner
> page_table_check that use page_ext can be optionally enabled via
> kernel parameters. Having the total per-page metadata information
> helps users precisely measure impact. Furthermore, page-metadata
> metrics will reflect the amount of struct pages reliquished
> (or overhead reduced) when hugetlbfs pages are reserved which
> will vary depending on whether hugetlb vmemmap optimization is
> enabled or not.
> 
> For background and results see:
> lore.kernel.org/all/20240220214558.3377482-1-souravpanda@google.com
> 
> Signed-off-by: Sourav Panda <souravpanda@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>

