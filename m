Return-Path: <linux-kernel+bounces-383466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C2B9B1C2D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 05:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D981C20DBC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 04:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716132BAEF;
	Sun, 27 Oct 2024 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZlQBDDHy"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064C822F1C
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 04:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730004203; cv=none; b=oLdFbSkKf9FJtSzWY23x+bd6w7ZdiyXLJFKvPEQCR1FF+X8LsVFq2cQakUZO//d5cB/4dwPk6SBnnKD8DEscfCj14T+rX5iHOm3k+8TMgxDF18AleVm9GkRV/fadSLsdeXNjRowUy45XZDP25PWAVX7Sulqy3Eph/RgikPA1fEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730004203; c=relaxed/simple;
	bh=1pm4DpTKXFFG1e38UC1ev5/Q43kxORvmneZ5l2b57Kw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E3BI7pJryKsB64vor1gL1u7tzmsoQshq8pfVrPwN3/2MGL7QpY7/xbkp3S4Uf6P8f0Z0Buu63IZz2QaEAKxF5vYepzs4b+1g0i9tYBEBW2EVtpi09IuiwNBrs/Xo3p9zbjWOS+EDklk5F3Ett5+8qJajquNLku4PiqEroLFxuto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZlQBDDHy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20caccadbeeso34295655ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 21:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730004201; x=1730609001; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxJ7jTPYF7MJ+n+x+vALmSMEUZ0wIVJqL5CFxRxgP8A=;
        b=ZlQBDDHyJ6qSSHS1sZKOZIZN1rx2qzaJCxhfRDzpqFzs5/HYiVQAfCoxpBN/1ZgObj
         WL1R/FE+KYlXCkoyGCn6ybg8DESCR1iz2/pkb90n66WLlqUCBWxDnzMem96zsnRPvwQX
         i+O9NeL9L5lzoo3RfueWyP7N6Y4XqlH4gAWaSHokgARj5LuvrU28hwrh3y+BGiWbueAR
         mdzlVie3qOVNW9VmuNh49aacHtWjaKOFd2ZpT0ta9YXkd33LJfUBzHmLtXCtcKyuhike
         3YL0uaWa0K0shio/6q9E85jQYw5GgYi+8EFLDQzWU8vRJ8WLOv518btQkxWu3CnxcIjD
         rLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730004201; x=1730609001;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxJ7jTPYF7MJ+n+x+vALmSMEUZ0wIVJqL5CFxRxgP8A=;
        b=mLtEso1KLt5eTdMTr0HlAtcczkwBfcsTeflU/F5yWs/A0eleVlP4fza+ZABL6MgnWy
         lpnR2IsoaeefIhRETBNI+iUG/Ys4P7WVCiISBxRUHgchoOZxD+US/jETJos5E8N1w0cc
         FUSqFVq/Mhqkg/Q+GuMgstVV093Z1sxol+7kQB2Ldoco0XFjMOZGscFlb1cCHnC1Vn3Y
         /Y2kQSH7QIM/1Qby3sQp7xCO7aGD3j0tyR/AnAgpwju6gd1uoui51qexb2AbDN80FAAc
         hPPXYppA1ggVQvE1KwEl52unBkN9RzecZBte1adRgUqTd1LPm4RAKbB5DnT/R3oDPx5W
         nNFg==
X-Forwarded-Encrypted: i=1; AJvYcCVELqJXj66PkP5+uWwTn51px7ue4qeQVkD+CFsw6fkQ9ncEFsD9p5hu5Aiv3VheI8JdbL3lann8CKqCkog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg3K78xuvoqVsjPwoW+rWqi1o9sd5BVw8YfuK216RUmqBj5bPe
	tLjcm6tBwM5weW48UIibUnMKTB6tS0Exv/MiaGddXubOaBLfUaketGxWWlcSkg==
X-Google-Smtp-Source: AGHT+IFoimWn5iWOVL+r7Tuqqyu0INnrIinhsFyVKabz7kFPstUFS6IMfI3GNvN+lNKp/poVnkhlRw==
X-Received: by 2002:a17:902:d4d0:b0:20c:a44b:3221 with SMTP id d9443c01a7336-210c6c08b12mr52868115ad.15.1730004201071;
        Sat, 26 Oct 2024 21:43:21 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04b8bbsm30616895ad.244.2024.10.26.21.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 21:43:19 -0700 (PDT)
Date: Sat, 26 Oct 2024 21:43:09 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Zi Yan <ziy@nvidia.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>, 
    Wei Yang <richard.weiyang@gmail.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>, 
    Chris Li <chrisl@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH hotfix 1/2] mm/thp: fix deferred split queue not
 partially_mapped
In-Reply-To: <E5A75697-55C7-4335-8D86-EE5CB6A99C4F@nvidia.com>
Message-ID: <947f23e2-c817-b714-57d7-c893aad5002f@google.com>
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com> <3A1E5353-D8C5-4D38-A3FF-BFC671FC25CE@nvidia.com> <966a4aff-f587-c4bb-1e10-2673734c2aa0@google.com> <E5A75697-55C7-4335-8D86-EE5CB6A99C4F@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 25 Oct 2024, Zi Yan wrote:
> 
> Thank you a lot for taking the time to check the locked version. Looking
> forward to the result.

The locked version worked fine (I did see some unusual filesystem on loop
errors on this laptop, but very much doubt that was related to the extra
deferred split queue locking).  But I do still prefer the original version.

> BTW, I am not going to block this patch since it fixes the bug.

Thanks!  I'll put out the same as v2 1/2.

> 
> The tricky part in deferred_list_scan() is always the use of
> folio->_deferred_list without taking split_queue_lock. I am thinking about
> use folio_batch to store the out-of-split_queue folios, so that _deferred_list
> will not be touched when these folios are tried to be split. Basically,
> 
> 1. loop through split_queue and move folios to a folio_batch until the
>    folio_batch is full;
> 2. loop through the folio_batch to try to split each folio;
> 3. move the remaining folios back to split_queue.
> 
> With this approach, split_queue_lock might be taken more if there are
> more than 31 (folio_batch max size) folios on split_queue and split_queue_lock
> will be held longer in step 3, since the remaining folios need to be
> added back to split_queue one by one instead of a single list splice.
> 
> Let me know your thoughts. I can look into this if this approach sounds
> promising. Thanks.

TBH, I just don't see the point: we have a working mechanism, and
complicating it to rely on more infrastructure, just to reach the
same endpoint, seems a waste of developer time to me.  It's not as
if a folio_batch there would make the split handling more efficient.

It would disambiguate the list_empty(), sure; but as it stands,
there's nothing in the handling which needs that disambiguated.

I can half-imagine that a folio_batch might become a better technique,
if we go on to need less restricted use of the deferred split queue:
if for some reason we grow to want to unqueue a THP while it's still
in use (as memcg move wanted in 2/2, but was not worth recoding for).

But I'm not sure whether a folio_batch would actually help there,
and I wouldn't worry about it unless there's a need.

Hugh

