Return-Path: <linux-kernel+bounces-223766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063C09117EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97632281FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584B34EB51;
	Fri, 21 Jun 2024 01:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REZrggHr"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD84F20E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718932516; cv=none; b=HfxcrkVkhASDDkSTgn5Cvw+nKc5MrVXC2rtE/XHphkuAz8eaYXuDsa5wUAb63dgwoW0D08dgQVhvAK6u7QMLmY4R24EiInCvqj+etyw/w9NM1DRSKBtP/1yjAVO53mWlFfe75SAAjVXqzk0SkpL93wmPPjglZ8rktjo465tYw5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718932516; c=relaxed/simple;
	bh=dP5H6qBbk1iavBRVuO/Fa0MMLNSkVNto1SbBSAK/9tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk27aKO3K+22YVdHvgv8XQOiYfqPeEZJ/WS8JSRxSGsT8078zamxF2I4cA3Ck6Pw9de/sPICo5US3SKwtJP6dzkN98ci1rFyykckKbsb5M4iEQYXS4hwwB2qcy+hIPnG9mZ/PAo/a/qx91+eT/elhcmObRnnciEz2Xr7yy1QgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REZrggHr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f7b785a01so151063066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718932513; x=1719537313; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0HioJEgb52y6kNsnjrGnWJVH+QgjZY5aiRZggthoQA=;
        b=REZrggHrz/xURCawwiMetCc3yA7fIEQKmB+WlAQVFcPANCNEBLHVch+b0wk7j76YwV
         eMc+iQBpT7H/bK1pP9wHQMJTF/Sk78OvjjTgbkK2nUHHTFkwe670+VCvQlzgEq++kNMJ
         gESS/EAXnvpmzTMS6fWMf53atzun8gJgVsSInqWV0TTi6KIsXfwGDt5/T4OWQkxiX/gv
         Rg5C++VeDCxOf983B0tC74uToyrgmqSuU1fBRvv8OCGA6YyPbx59dA+4fGGJq4b0/8Nh
         w6p/fHFckqfNhTxa4RIFYetBYhtBnTtYXnSd8Pf3CGIKo3/R2LCSRcvwENp5ZujTW+pR
         D8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718932513; x=1719537313;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0HioJEgb52y6kNsnjrGnWJVH+QgjZY5aiRZggthoQA=;
        b=eA1WAIiY6cjqcqrwzKm12LQgFSJ8hg7gJawL3QLE/lBqguSxgnPtcEDc4I9QBqSBoO
         Buj0S93ltODsvx/XJmbPg+MFGciOrw1PD9Au5+5UIF8O9OoHFc9+kt+hjh0w/rbds9Nd
         Lmxot/NblaIC8j+DXDUcCq1btTf0NTmkZTWDm6FHKcYzrVEO9oQ7EThy8M+7qJuXrtgl
         UG2tLN+6DYMBeBJ+SY7lu3WIZkpgBgd+/k8knWlluFQL1o6EPIAxqRnNe0C8AL9riz9E
         wrI2cgbFEU482WkuLLY+IMY7wX4LzlM+AijBjPZZUv+UKfiwvoXUMnXK82JZ7s4SPO/z
         T2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXchENwOedx5DIuESsbqX8ewzdSAVFult6P+F5CY5YZxBEYTykPb7KTh9j9xaFxOO1+/w9AvQNaAs2olSj3ou5Ilgod+B1CG3cCry4z
X-Gm-Message-State: AOJu0Yxq6YdDf+b5dOrZxfBsIEd1dTjhjgi3NzVbxGJjZyATdCDiGVNS
	X27sqK3QWr9ACF54ABMQY0RFIVRIy/Kegjd5yYEPAQqVaRJXuEF+
X-Google-Smtp-Source: AGHT+IGocGm8/x+41NHJd0UZXu+J5R8ZBdYrEpq8injFk7LbQd5A1xcy5xfyQ2WU6S3RK+Pt5tKWOQ==
X-Received: by 2002:a17:907:6d08:b0:a6f:5b98:bfa5 with SMTP id a640c23a62f3a-a6fab7724f2mr433353366b.52.1718932512919;
        Thu, 20 Jun 2024 18:15:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b47fsm26243366b.59.2024.06.20.18.15.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2024 18:15:12 -0700 (PDT)
Date: Fri, 21 Jun 2024 01:15:11 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: James Gowans <jgowans@amazon.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Alex Graf <graf@amazon.de>
Subject: Re: [PATCH v2] memblock: Move late alloc warning down to phys alloc
Message-ID: <20240621011511.cveqjhnpauhze4jl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240619095555.85980-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619095555.85980-1-jgowans@amazon.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jun 19, 2024 at 11:55:55AM +0200, James Gowans wrote:
>If a driver/subsystem tries to do an allocation after the memblock
>allocations have been freed and the memory handed to the buddy
>allocator, it will not actually be legal to use that allocation: the
>buddy allocator owns the memory. Currently this mis-use is handled by
>the memblock function which does allocations and returns virtual
>addresses by printing a warning and doing a kmalloc instead. However
>the physical allocation function does not to do this check - callers of
>the physical alloc function are unprotected against mis-use.
>
>Improve the error catching here by moving the check into the physical
>allocation function which is used by the virtual addr allocation
>function.
>
>Signed-off-by: James Gowans <jgowans@amazon.com>
>Cc: Mike Rapoport <rppt@kernel.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Alex Graf <graf@amazon.de>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
>
>Notes:
>    Changes since v1: https://lore.kernel.org/all/20240614133016.134150-1-jgowans@amazon.com/
>    - Move this late usage check before alignment check
>    - Replace memblocks with memblock
>
> mm/memblock.c | 18 +++++++++++-------
> 1 file changed, 11 insertions(+), 7 deletions(-)
>
>diff --git a/mm/memblock.c b/mm/memblock.c
>index d09136e040d3..dbb3d700247e 100644
>--- a/mm/memblock.c
>+++ b/mm/memblock.c
>@@ -1451,6 +1451,17 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> 	if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
> 		nid = NUMA_NO_NODE;
> 
>+	/*
>+	 * Detect any accidental use of these APIs after slab is ready, as at
>+	 * this moment memblock may be deinitialized already and its
>+	 * internal data may be destroyed (after execution of memblock_free_all)
>+	 */
>+	if (WARN_ON_ONCE(slab_is_available())) {
>+		void *vaddr = kzalloc_node(size, GFP_NOWAIT, nid);
>+
>+		return vaddr ? virt_to_phys(vaddr) : 0;
>+	}
>+
> 	if (!align) {
> 		/* Can't use WARNs this early in boot on powerpc */
> 		dump_stack();
>@@ -1576,13 +1587,6 @@ static void * __init memblock_alloc_internal(
> {
> 	phys_addr_t alloc;
> 
>-	/*
>-	 * Detect any accidental use of these APIs after slab is ready, as at
>-	 * this moment memblock may be deinitialized already and its
>-	 * internal data may be destroyed (after execution of memblock_free_all)
>-	 */
>-	if (WARN_ON_ONCE(slab_is_available()))
>-		return kzalloc_node(size, GFP_NOWAIT, nid);
> 
> 	if (max_addr > memblock.current_limit)
> 		max_addr = memblock.current_limit;
>-- 
>2.34.1
>

-- 
Wei Yang
Help you, Help me

