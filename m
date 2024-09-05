Return-Path: <linux-kernel+bounces-316785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E8A96D579
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648CAB2314A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45D197A92;
	Thu,  5 Sep 2024 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="SBXP+IbJ"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD81494DB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530769; cv=none; b=Im6jo7pOgVxW+EqvM8YBUialDM35j2naTqiinL6qtRu+3iIaQOgBXdfs+2yTmf2jz5uWl3qLF+TP4vih59FdHhqaGc7endIcSiyKxvZEwA6J3HEuuVm1F4+XiOypV+klw6PeVtSb22LjxDiTr6gNGJaSQXr3KN4g0arMwUYWEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530769; c=relaxed/simple;
	bh=ZlbdctOsUdrPdNxFA4u0cAuMT1cQ038QEqSiHn+sz3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2hZYRLFThpVYiUeyYwgqKDXxHjMiqWeoo9OxbmyJuXbyQZ0NgZu+QVFoWW0DPerow3ErwKMBGMi5dxUYFwUehJ4Tr7cYlDLYYe6xY9PSPnlou3Me0o8zquO8eMBkLHlUbcKntywDMzekNjtT762HALctmvlZ4yGt3ln6RkmJcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=SBXP+IbJ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a7fd79ff63so37115685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1725530764; x=1726135564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FssOZMkL4EI9Dg7029SIMlcBVh5AI88igqnT1wzgpi8=;
        b=SBXP+IbJUp6CeEohBjE1ADW+TQEp2OuN/oPdNWChJ268u1dSaav4VMQSk0BL3AZZ7N
         nIGB/tGqnb/BGrILayOetq7akoS0jMahQpVVHvMsHp8GNbJfeNERxIYw09heO8mQaT6q
         FuFcQ2O/8OuRFPzo4K5NMfLM+heTLwJX1GIX7lzWSC9yGFuJ+P8srZvjLNlZS2lIdNEY
         CjrubTRDeP/tQpuy0bikP6hXja06d4lzv7DLQoFvDLC/9pFApnc3SRGBnvr4vh/93OZL
         jTN3eE2/x46L0diAOesVpe19QtBSHex6gOjTl4hX1fGtCv5/joK3VUpOS7m96CmYy21F
         wZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725530764; x=1726135564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FssOZMkL4EI9Dg7029SIMlcBVh5AI88igqnT1wzgpi8=;
        b=o82hd4HeN7RahHrakisL+oI6jf3fypRwOdCN+nGpsBs79Aj8gDze3vgsZgOhkcGtDu
         sOwcKIfoMDvE5TXP+2z+qnE0G+ia7xGWV8zdsSTbDrC3LT9jZCLP5QtRSt3alQnUHa8c
         PMarSe/h7qtcBAZik1Nnrcse0Nu0nbMLapruUPfYA/PzNhvbhAZpfZc4tWPW8xJNrvEr
         oGaw2IHhBp0TV/dsJqxDAvif9IC0VrV1/j1QmyyKoD1UNX3/YwVVQUqMBdGAYQE2ECis
         gNlYmwPUzW4WAlxKeTTMgxGU7a20lqMLZn/9UwBv2mva950IvvBPtYPfP+Zuq+xk6nGT
         hhPA==
X-Forwarded-Encrypted: i=1; AJvYcCV0JYrxcxYA+sQvn1jegCvJM+GnO81wWPscRDESclWZu7JDDTgWN6v77w3gdHu3zFWz2iPZOv2qYoeIX5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+xg+Z+E3UE9LJPjK/Q/g6ZR8P/gMnS84O9m47y4v+mvgJVoU
	UBXIZo3QNjIL++w5CtTgD4b6dTvo3dVF0+kds5+unU2mTE0Z2K05ge7RBT20Kik=
X-Google-Smtp-Source: AGHT+IFqlUnb0R4Tnf7fLDfR9u43Xt0rwLhVu8SYQjcg8VJmKtyiXjLAvjhl0Q1+nPJDIOI+VCzqpQ==
X-Received: by 2002:a05:6214:5b09:b0:6c5:1707:7159 with SMTP id 6a1803df08f44-6c517077d53mr70665036d6.33.1725530764171;
        Thu, 05 Sep 2024 03:06:04 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c52019407fsm6350906d6.0.2024.09.05.03.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:06:03 -0700 (PDT)
Date: Thu, 5 Sep 2024 06:05:57 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>, Nhat Pham <nphamcs@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Down <chris@chrisdown.name>, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: z3fold: deprecate CONFIG_Z3FOLD
Message-ID: <20240905100557.GA2748692@cmpxchg.org>
References: <20240904233343.933462-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904233343.933462-1-yosryahmed@google.com>

On Wed, Sep 04, 2024 at 11:33:43PM +0000, Yosry Ahmed wrote:
> The z3fold compressed pages allocator is rarely used, most users use
> zsmalloc. The only disadvantage of zsmalloc in comparison is the
> dependency on MMU, and zbud is a more common option for !MMU as it was
> the default zswap allocator for a long time.
> 
> Historically, zsmalloc had worse latency than zbud and z3fold but
> offered better memory savings. This is no longer the case as shown by
> a simple recent analysis [1]. That analysis showed that z3fold does not
> have any advantage over zsmalloc or zbud considering both performance
> and memory usage. In a kernel build test on tmpfs in a limited cgroup,
> z3fold took 3% more time and used 1.8% more memory. The latency of
> zswap_load() was 7% higher, and that of zswap_store() was 10% higher.
> Zsmalloc is better in all metrics.
> 
> Moreover, z3fold apparently has latent bugs, which was made noticeable
> by a recent soft lockup bug report with z3fold [2]. Switching to
> zsmalloc not only fixed the problem, but also reduced the swap usage
> from 6~8G to 1~2G. Other users have also reported being bitten by
> mistakenly enabling z3fold.
> 
> Other than hurting users, z3fold is repeatedly causing wasted
> engineering effort. Apart from investigating the above bug, it came up
> in multiple development discussions (e.g. [3]) as something we need to
> handle, when there aren't any legit users (at least not intentionally).
> 
> The natural course of action is to deprecate z3fold, and remove in a few
> cycles if no objections are raised from active users. Next on the list
> should be zbud, as it offers marginal latency gains at the cost of huge
> memory waste when compared to zsmalloc. That one will need to wait until
> zsmalloc does not depend on MMU.
> 
> Rename the user-visible config option from CONFIG_Z3FOLD to
> CONFIG_Z3FOLD_DEPRECATED so that users with CONFIG_Z3FOLD=y get a new
> prompt with explanation during make oldconfig. Also, remove
> CONFIG_Z3FOLD=y from defconfigs.
> 
> [1]https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com/
> [2]https://lore.kernel.org/lkml/EF0ABD3E-A239-4111-A8AB-5C442E759CF3@gmail.com/
> [3]https://lore.kernel.org/lkml/CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=nxUveLUfqVsA@mail.gmail.com/
> 
> Acked-by: Chris Down <chris@chrisdown.name>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

zsmalloc's CONFIG_MMU requirement was a concern in the past, but
z3fold appears so bitrotted at this point that it's simply not a
usable option anymore.

> I think it should actually be fine to remove z3fold without deprecating
> it first, but I am doing the due diligence.

Yeah, you never know for sure if users exist. Deprecating it for a few
cycles is the safer option.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

