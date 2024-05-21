Return-Path: <linux-kernel+bounces-185117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72EA8CB0B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730E51F235AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F09A7EF02;
	Tue, 21 May 2024 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiGJhf24"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4601CD32
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302876; cv=none; b=UQh8E2WooFPXp2nj9ew/cx4XRSCBDFKUcjSWbDZ2yhtGohrWnufk8FrnbztV8hjHrQBbBbsMYqXmw43IG+0pRDaMFl376Ypr2N2NKaTAHer691FKMMtyTU7mgPdFmk14hoZmJbdZJXUI6ZWDdUL2JeIEjrsyf6AY+o9BXc37SIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302876; c=relaxed/simple;
	bh=8RjIHIRy05YNlY6wzjQTN4uDGH/wp3L0vBIoPBxibv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5rX7FVooFIRx+xioqTvi1/dDKYei7tJtRBjjljajDjGiazFIDwh5hbOpxPAt4oHMeihQq2fEuOc8MB1MRMjoex2i4r6MS3x/6cD64CN5aR/cbGXwc8vo8vWZOhOUrGZUen1eipe+iZIZnQbadBknUYjghiwT1e5xBHpLoi8aSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QiGJhf24; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716302874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6rlVQj7o2xHqikPOD3/lh2xGlv7yRjX/lAkh0YjzPMc=;
	b=QiGJhf24suPtynYr8LOeU1+44J+E1WQbkd1quBvmmuP22OGMXBbQI+9GjEiqP0HdXz9kC5
	cAG8doy5bBqM62l3gmEy2TLEYt0FtSY20BdH2Q0MtH8BGa4qO4KJOWevLK5GJkjYIHSOhJ
	K8L5N3sAY5jOTnqTHQyoeHPKvDTGDcQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-Ly-6srLsNUmtRT95Eod9nQ-1; Tue, 21 May 2024 10:47:47 -0400
X-MC-Unique: Ly-6srLsNUmtRT95Eod9nQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFF31101A557;
	Tue, 21 May 2024 14:47:38 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BDB2FC15BB1;
	Tue, 21 May 2024 14:47:37 +0000 (UTC)
Date: Tue, 21 May 2024 22:47:34 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Zhang Jianhua <chris.zjh@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: init: override deferred_page_init_max_threads
Message-ID: <Zky0Bl+H8aWCVP3m@MiWiFi-R3L-srv>
References: <20240520231555.395979-5-echanude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520231555.395979-5-echanude@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 05/20/24 at 07:15pm, Eric Chanudet wrote:
> This was the behavior prior to making the function arch-specific with
> commit ecd096506922 ("mm: make deferred init's max threads
> arch-specific")
> 
> Architectures can override the generic implementation that uses only one
> CPU. Setting DEFERRED_STRUCT_PAGE_INIT and testing on a few arm64
> platforms shows faster deferred_init_memmap completions:
> 
> |         | x13s        | SA8775p-ride | Ampere R137-P31 | Ampere HR330 |
> |         | Metal, 32GB | VM, 36GB     | VM, 58GB        | Metal, 128GB |
> |         | 8cpus       | 8cpus        | 8cpus           | 32cpus       |
> |---------|-------------|--------------|-----------------|--------------|
> | threads |  ms     (%) | ms       (%) |  ms         (%) |  ms      (%) |
> |---------|-------------|--------------|-----------------|--------------|
> | 1       | 108    (0%) | 72      (0%) | 224        (0%) | 324     (0%) |
> | cpus    |  24  (-77%) | 36    (-50%) |  40      (-82%) |  56   (-82%) |
> 
> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> ---
>  arch/arm64/mm/init.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9b5ab6818f7f..71f5188fe63d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -158,6 +158,13 @@ static void __init zone_sizes_init(void)
>  	free_area_init(max_zone_pfns);
>  }
>  
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask)
> +{
> +	return max_t(int, cpumask_weight(node_cpumask), 1);
> +}
> +#endif

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> +
>  int pfn_is_map_memory(unsigned long pfn)
>  {
>  	phys_addr_t addr = PFN_PHYS(pfn);
> -- 
> 2.44.0
> 


