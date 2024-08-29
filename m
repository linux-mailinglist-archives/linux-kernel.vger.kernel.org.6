Return-Path: <linux-kernel+bounces-307821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FBA965343
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199951F23CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28BA1B5EDB;
	Thu, 29 Aug 2024 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLJcpcth"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D218B47D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724972831; cv=none; b=JzR6W7w79gO12gAr0Ezv7C4LT2EKLCnVCHvkxQwS+EOQmzw5zwyNlfdHKymkzbO+s2KT0fF/n/XXO/TVPP5I3O2G8jED1GrwW1lBCrZ0rOFfvbbERWYGqm87Iwt6bfNaQuMda/Hc8yd31MjByTeDZwraqmErTUFwY6qcNY14VJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724972831; c=relaxed/simple;
	bh=AVMJUHT8UnAD/R7HmpY0eKf+SJteLEH80MfuqCkT3Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqhy7G0o8VZUs9sZFrxw8FFH6Y37v0Zx+lyKOCvF5Tame9Xn4z9o/dEW9Rz9cS40VoKpkfL/vhs1NOE40AAcBBab5ylDJGqWMwvuh+CuCRisjOx2yOlhIv99hGLH//DmwiV1+eKkuIfisPc4G+eTtz4s5zFm43ecBXfGQebprRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLJcpcth; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86984e035aso152060466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724972828; x=1725577628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IE1sZPv1Wc55CtZJy5IzEWkbJLLw6KHnbAqmMk/YArM=;
        b=YLJcpcthNrJ8Si+gXVE8Kkczqc0zA+cjVkoFAsvaRg5q7RYjFDj2BKGjnbZmxrv6yC
         hOGuX0iqxvpKBDPTlXUd01edxXXE7Ir2qv4etqcEH9oAhkboYWiVHcDx4lwfupENqFn2
         Dw6R7d955qjq8eybUq8ZFMXDkxILe4afqLzkH1grMeOjZGtIukNPZVZqth+223yVHLHT
         pvZMCx/3BYcg5IzxGoAEdjjwV1aWdLrGqAhaGoAneV2pGCQzDlqjI4QefFafBJJkaaBS
         jjZW2t3D6BnL8hCT7TRweGGO9VUtg4Ipg8z6oANYftw1che8OXPuB/xVJlYT7ReMfvzP
         rQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724972828; x=1725577628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IE1sZPv1Wc55CtZJy5IzEWkbJLLw6KHnbAqmMk/YArM=;
        b=ixMARWN+Uu4aI72Yku5044yWX0NMyTrTBJBcRuKq9q79WDJa35s07cafOsJTY2yLsz
         JseDUQOwakNDmM9ErmfBoSjvdBRqTmVXbT14crmG4zxGlyCa4UMaWdy90igwTZwsEa9v
         myexxksvlgj7Nde/PkgenLtpOMhNypvMqgRJi9S2yJ0faCqGbhN7W3Aua266yikQtkvU
         SvQv534lj2S/srNWgxvMW6Z8gveeSHsn3lg7GEPKpPB95mkIB4atql2rJQVY4Ht+QNQc
         TN2lXIedn4rW3L8Q3y+exW4ACedPNxMeAT+sy4X53/z7qqdQCxJeVXMQqop7d+q4Mq3G
         LyKg==
X-Gm-Message-State: AOJu0YyVyd96Edxjr4tmsJMHxuWJwwae6FKk382v8Ht1Wr3Q/26TzUJD
	8wdSFRMKsId6wqHuvizlx+mqPjNaoybZqEOw1oQ9tlf74hP+tAvFX7Xwg87+m/wa8mC2tTN5F2u
	i4q0/X0Ptnaj1PocZvesVJwJlbkPKVN1r03Wx
X-Google-Smtp-Source: AGHT+IG88iTCuGLLGxY8Mp4Ww63+WBxvpC4h/iGsfnx1ufWFs2ff22EPd84RvgFNCoUJUOXuIRlS7ub5Q0qKfPNKXqk=
X-Received: by 2002:a17:906:6a25:b0:a86:b32f:eee6 with SMTP id
 a640c23a62f3a-a89a3820bd8mr17782266b.54.1724972827094; Thu, 29 Aug 2024
 16:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com> <20240829212705.6714-3-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240829212705.6714-3-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 29 Aug 2024 16:06:28 -0700
Message-ID: <CAJD7tkZih11jpzAGM=hVdRtBtjmdynpfSXv6fP8B8gnzoj3G=Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] mm: zswap: zswap_store() extended to handle mTHP folios.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, nanhai.zou@intel.com, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:27=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>

I think "mm: zswap: support mTHP swapout in zswap_store()" is a better
subject. We usually use imperative tone for commit logs as much as
possible.

> zswap_store() will now process and store mTHP and PMD-size THP folios.
>
> A new config variable CONFIG_ZSWAP_STORE_THP_DEFAULT_ON (off by default)
> will enable/disable zswap storing of (m)THP.
>
> This change reuses and adapts the functionality in Ryan Roberts' RFC
> patch [1]:
>
>   "[RFC,v1] mm: zswap: Store large folios without splitting"
>
>   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.robe=
rts@arm.com/T/#u
>
> This patch provides a sequential implementation of storing an mTHP in
> zswap_store() by iterating through each page in the folio to compress
> and store it in the zswap zpool.
>
> Towards this goal, zswap_compress() is modified to take a page instead
> of a folio as input.
>
> Each page's swap offset is stored as a separate zswap entry.
>
> If an error is encountered during the store of any page in the mTHP,
> all previous pages/entries stored will be invalidated. Thus, an mTHP
> is either entirely stored in ZSWAP, or entirely not stored in ZSWAP.
>
> This forms the basis for building batching of pages during zswap store
> of large folios, by compressing batches of up to say, 8 pages in an
> mTHP in parallel in hardware, with the Intel In-Memory Analytics
> Accelerator (Intel IAA).
>
> Also, addressed some of the RFC comments from the discussion in [1].
>
> Made a minor edit in the comments for "struct zswap_entry" to delete
> the comments related to "value" since same-filled page handling has
> been removed from zswap.

This commit log is not ordered clearly. Please start by describing
what we are doing, which is basically making zswap_store() support
large folios by compressing them page by page. Then mention important
implementation details and the tunabel and config options added at the
end. After that, refer to the RFC that this is based on.

>
> Co-developed-by: Ryan Roberts
> Signed-off-by:

This is probably supposed to be "Signed-off-by: Ryan Roberts". I am
not sure what the policy is for reusing patches sent earlier on the
mailing list. Did you talk to Ryan about this?

> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

The diff is hard to follow because there is a lot of refactoring mixed
in with the functional changes. Could you please break this down into
purely refactoring patches doing the groundwork, and then the actual
functional change patch(es) on top of them?

Thanks!

