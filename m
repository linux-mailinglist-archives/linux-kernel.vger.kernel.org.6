Return-Path: <linux-kernel+bounces-522181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F90A3C713
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBB9188E7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86245214810;
	Wed, 19 Feb 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjLtBxaW"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738DC2147E8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988604; cv=none; b=Q+uyW+MuQQJBf0m2Pq5pswQYZVOI1eyCl5eVl9/SPcHs3ebhE5Bsc6haWfUcT04Wiu+YeuUDS40vROZBt4yzcIUXTCmELYKXhLeleIyKaEoUo+0Ph9U3nsY+jicO8R80jxazfQTGBYy1tlMRNgpvcoMFem064GMr73YoXZmf4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988604; c=relaxed/simple;
	bh=0QQq27YBG3+AKBQOtcEugn3bVvs8Z0bAKu+xmqQXcMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3cmOYu7dF4xBKDxe+Ml0Ct1gUfw6IctutiXeorYUMpwVtM2q5qZ/Lq4baJADEGmR/URMeyz9T/ITELE0aOMhIuWPUViizzRg2rVGY1KfmFji18DM8z/5JBIBmtywZursmV7thbXBE0k44hzY+ZJauyzmbEMEn3qGtl5dvGD6BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjLtBxaW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-471fbfe8b89so22091cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739988601; x=1740593401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cN2Rqb9pVr1wEbelwivZbg+NdO1vHfBTI3BqVx7m8tI=;
        b=UjLtBxaWaR+fXP4A043gVWuueXciFurX0c0/bBRcabEG1vbh18roNoOhzhtxLjAsEE
         xYO8WBAEwNBR5iez3z9orqHp3DxV38g5u5v6+YRaAaHChsGXepwaRD4dIP1oYd8kd7/y
         kJ8qSTuvfeh54kC7Tsust38Jg9wttJR1mZLkTz1DfFQ3br8O6QDH/tJmpLYNiIZtzb76
         on4dP8EKhmPMjeTGtjZ5dn0hV4so01iqDuYftR2lDVFTikI5n6Yte+xbmBxv1YHsi3lu
         JZd5khTfZ+vUAmr719DYkPIeeMEMr495t4P6otphBXlFv2tRpBrFnRFdOXOKb005u3rs
         +S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739988601; x=1740593401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cN2Rqb9pVr1wEbelwivZbg+NdO1vHfBTI3BqVx7m8tI=;
        b=jr+v2B74OO4uv76fvxbg2ut+BBSSDeyp9A8nc5bAflIMhC+3Ivyz4YQCMn1iYF/1DG
         0DIM0GZFhYrpPnf3mNx+2kIJ/xyNxCZk/098tP6r8J1RjXoGmlDJFicWlW3L0S5BHS+f
         UNTOXkuwuvdjqNhp5uflPJH9CKtLyDujz/8noiYYiw96CrSc06wp9HPSYz+t7U7vWd4W
         Yosc5UJokNPstUVFMCTuf1weUb6ss+gIhN/3w9Hx8xizHVn4vwYgFS0x1ZI5L5P7XNfb
         ZzrimRT1bmf9Y7MBDhFlBXgzV3mSj5zi+NnNYkkJB0FEr9XKw7lMzsnTnzkdnw99uaTT
         RLvA==
X-Forwarded-Encrypted: i=1; AJvYcCXksIYDBwKlGTuK7J2FtT1uG5CSCzgFAuBjt0Dge6ZSSyLS3rIZJhHXvHD98nxOjiYCjFZ9JZahmDwaY2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kuDY6WH/Ar7jbeM8hM74HSy5IvDrIBMld5DxoZDSTMtRLBGF
	vLv489lpSZAUhoe7VzcjQn4UZ2n6GuUDenYfWdLSHEe7APdY9noMuvWHris2Zma2MhxuaoINSe6
	+5PNq+d3J2bpU2+ckvwrFNiRCPJ+qJexUJUrzuHPjGG1XN+X4xA==
X-Gm-Gg: ASbGnctTrjsFbbQC/4W3jx+YGe5M7J74oJhxV6TaP8CCyMSCF5c+6TMtlOIbjN/eVXZ
	r7wzb6PTes2xWWux8H1f1psybyrvySt5Vk0tltRRCpTiQaL3w3PLrSxtvvDtC1jAMdyyGSQ==
X-Google-Smtp-Source: AGHT+IFECn4l0B9qOC1a0Jsue3I+n7DzaMiiOTXZNUAt2jIlFgFxSsUbpq4Nx4VMcy+s7Y4gzhzjGXJZ4X33VbqUPyY=
X-Received: by 2002:a05:622a:14c7:b0:471:f8af:3231 with SMTP id
 d75a77b69052e-4720a541b6cmr3830931cf.19.1739988601038; Wed, 19 Feb 2025
 10:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
From: Frank van der Linden <fvdl@google.com>
Date: Wed, 19 Feb 2025 10:09:49 -0800
X-Gm-Features: AWEUYZlgmyBY-mj3iRaq8vXknIOGgntMAabmV3Q9iZKJkWDq1xSamLvU_YJ7u4w
Message-ID: <CAPTztWY8iGZjYpsESNByt9My9H+YvrLiNVJAe+L_j1C4CUaEFg@mail.gmail.com>
Subject: Re: [PATCH v4 00/27] hugetlb/CMA improvements for large systems
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"

I forgot to add this to the cover letter:

These first 4 are the multi-range CMA support, and can be reviewed as
an independent series:
>   mm/cma: export total and free number of pages for CMA areas
>   mm, cma: support multiple contiguous ranges, if requested
>   mm/cma: introduce cma_intersects function
>   mm, hugetlb: use cma_declare_contiguous_multi

These implement huge/gigantic page pre-HVO, and can also be reviewed
as a separate series if that's more convenient:
>   mm/hugetlb: remove redundant __ClearPageReserved
>   mm/hugetlb: use online nodes for bootmem allocation
>   mm/hugetlb: convert cmdline parameters from setup to early
>   x86/mm: make register_page_bootmem_memmap handle PTE mappings
>   mm/bootmem_info: export register_page_bootmem_memmap
>   mm/sparse: allow for alternate vmemmap section init at boot
>   mm/hugetlb: set migratetype for bootmem folios
>   mm: define __init_reserved_page_zone function
>   mm/hugetlb: check bootmem pages for zone intersections
>   mm/sparse: add vmemmap_*_hvo functions
>   mm/hugetlb: deal with multiple calls to hugetlb_bootmem_alloc
>   mm/hugetlb: move huge_boot_pages list init to hugetlb_bootmem_alloc
>   mm/hugetlb: add pre-HVO framework
>   mm/hugetlb_vmemmap: fix hugetlb_vmemmap_restore_folios definition
>   mm/hugetlb: do pre-HVO for bootmem allocated pages
>   x86/setup: call hugetlb_bootmem_alloc early
>   x86/mm: set ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT

These implement early allocations from CMA, enabling pre-HVO of
pre-allocated CMA hugepages. It depends on the previous two groups of
patches:
>   mm/cma: simplify zone intersection check
>   mm/cma: introduce a cma validate function
>   mm/cma: introduce interface for early reservations
>   mm/hugetlb: add hugetlb_cma_only cmdline option
>   mm/hugetlb: enable bootmem allocation from CMA areas
>   mm/hugetlb: move hugetlb CMA code in to its own file
>

