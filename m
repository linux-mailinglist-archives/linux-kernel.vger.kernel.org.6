Return-Path: <linux-kernel+bounces-250398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D612F92F767
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0262814A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F43A143732;
	Fri, 12 Jul 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jB/1F2M1"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532B13E41A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774589; cv=none; b=hZ42XecDDoxl31svUX9Fy0szwz8SQHIv8OYiG8nDYRws30OAnRduEUb+kJCIuCURL9KhoVUqq0Uir4/dSfxXIiziyX8f7nIvj3XR0HALe2qfKd5oc+ngOdvrmeO/8Jd+v+LfDBs06rZmPJQDiIi5uUVodtkOTM0i0q6hQt5ewHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774589; c=relaxed/simple;
	bh=8IEUg8/eSlzQvlwuZ/W3Z+vIWwo5Zej2UShiVakZwGM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z4vh09amr5l3jCFE992bkQd+64zVlF1vph7fzdTk05A/izy4mtw/XVaE8sMFV6OrhDRzQRYw8RuB6IM6tPQmq+ZDi8TH8tP1c7qQYKPkG865fSozak0AHsr8GFoExQ6JYLua2Ngyf3opoyy8kX8HW5LlBf34Ot2ivaaneHBdTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jB/1F2M1; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-65cd720cee2so16217537b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720774586; x=1721379386; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKEGbykYk5TZAEolv3veio4AcHQ3n9AaxWALsKzF+q8=;
        b=jB/1F2M1CfrFJrpErj8MWSntgkfWHY7f5jgyfs+34ihLuAUrKTZzs4MoFYe5WcYaO7
         xnUobB4fCm8RGJTB033hV4pixQi4/YA7Ol0X/AyIHvQGyAVzoCbexGKA+QqAbFumwlcV
         GnNjymHqDYOpTXYJdZm7QGPk5DEToXsANsTSeGrW06uhpO910j0GX+caY4X9BUWSg4ZD
         +/aXPLjxg5kIYxJaUddV75cgFbGxREdEuGv+sfzQbI7np/0qRLxMLi9l7o3BTMgjKOQF
         hvIPqNJO/KdfEqwuvAZv3facBuQDENQMQylU9DMqYBmXOguQn80LTa8DUAetOotN3noI
         5Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720774586; x=1721379386;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKEGbykYk5TZAEolv3veio4AcHQ3n9AaxWALsKzF+q8=;
        b=XrPUlGeZ0ZWPex7fFSrwp6b79Z7HcG7udroOXEPgdvcJgygnrgk7M+dJzWnW/LDFUw
         +7adGIxF7hLo1MRwCsbKwwYgvgqUVmlgQBev1tTymsLCewVDPkbYJ4fXvFnReSuwX7r5
         DP8cfUu5Nv2KO49nPM3Wdc5vKQO/2qD4T5UJNXgOM9HlcRXm5P91ZYZtNvb6d1uGelrd
         g9LfDjLk/fXCWghapDwLwMwCqxaoSx1aQONBnzm68mrX8c+i4Ui+pVtpIeIUKdLk4vyR
         p44nHovfvziWgfPvuETAFuDNaBc54+ivt5wVvtEsVXqS75xqZcLEurzzL6y2aMyNuqIh
         cdCw==
X-Forwarded-Encrypted: i=1; AJvYcCU0mvz2yow4esLAFD0htPHfz//4daa33B3j6BHJLGmTLPVYS0z9hVsa0fFZYsOjwEXaB/JoDrKflhyxW05n3olElhN+/dTL7SLofmWv
X-Gm-Message-State: AOJu0YyUxD1Rnt45Qzb40/LYMteXmQ+JS+cZ4dAuRf2nOUgovp3Gszsk
	cYuYTRGA1vrFCVNS3ZptS70AlX9JGC2qij0kwwJn1biGDFrx8/NfDQDI1Ygn8w==
X-Google-Smtp-Source: AGHT+IG42qjdytaoa1iAmt27ZcGzYpIdyY5FTx+R68VeXp1fc8qPNJCDIUt/qzCmpk8baLbEnC/TSg==
X-Received: by 2002:a81:8ac3:0:b0:646:5f95:9c7d with SMTP id 00721157ae682-658f01fda1bmr108621857b3.36.1720774586407;
        Fri, 12 Jul 2024 01:56:26 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e69d9dfcsm14260607b3.118.2024.07.12.01.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 01:56:25 -0700 (PDT)
Date: Fri, 12 Jul 2024 01:56:04 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: yangge <yangge1116@126.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, 21cnbao@gmail.com, david@redhat.com, 
    baolin.wang@linux.alibaba.com, aneesh.kumar@linux.ibm.com, 
    liuzixing@hygon.cn, hughd@google.com
Subject: Re: [PATCH V4] mm/gup: Clear the LRU flag of a page before adding
 to LRU batch
In-Reply-To: <1720075944-27201-1-git-send-email-yangge1116@126.com>
Message-ID: <503f0df7-91e8-07c1-c4a6-124cad9e65e7@google.com>
References: <1720075944-27201-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 4 Jul 2024, yangge1116@126.com wrote:

> From: yangge <yangge1116@126.com>
> 
> If a large number of CMA memory are configured in system (for example, the
> CMA memory accounts for 50% of the system memory), starting a virtual
> virtual machine with device passthrough, it will
> call pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory.
> Normally if a page is present and in CMA area, pin_user_pages_remote()
> will migrate the page from CMA area to non-CMA area because of
> FOLL_LONGTERM flag. But the current code will cause the migration failure
> due to unexpected page refcounts, and eventually cause the virtual machine
> fail to start.
> 
> If a page is added in LRU batch, its refcount increases one, remove the
> page from LRU batch decreases one. Page migration requires the page is not
> referenced by others except page mapping. Before migrating a page, we
> should try to drain the page from LRU batch in case the page is in it,
> however, folio_test_lru() is not sufficient to tell whether the page is
> in LRU batch or not, if the page is in LRU batch, the migration will fail.
> 
> To solve the problem above, we modify the logic of adding to LRU batch.
> Before adding a page to LRU batch, we clear the LRU flag of the page so
> that we can check whether the page is in LRU batch by folio_test_lru(page).
> It's quite valuable, because likely we don't want to blindly drain the LRU
> batch simply because there is some unexpected reference on a page, as
> described above.
> 
> This change makes the LRU flag of a page invisible for longer, which
> may impact some programs. For example, as long as a page is on a LRU
> batch, we cannot isolate it, and we cannot check if it's an LRU page.
> Further, a page can now only be on exactly one LRU batch. This doesn't
> seem to matter much, because a new page is allocated from buddy and
> added to the lru batch, or be isolated, it's LRU flag may also be
> invisible for a long time.
> 
> Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: yangge <yangge1116@126.com>

This is an interesting patch, and may (but might not) be a very good one.

I have no objection to it going forward to 6.11-rc, but I do object to
the Cc stable, and its current placing in mm-hotfixes-unstable (if that
means it's to be rushed into 6.10 final).

This is a subtle change to PG_lru handling, altering how that has been
managed since 5.11 (and before).  I have not observed any ill effect
from this patch, but I'm not at all confident in understanding its
implications - though perhaps braver and quicker minds are confident.

To judge by the commit message, it's entirely to suit the
		if (!folio_test_lru(folio) && drain_allow) {
line in collect_longterm_unpinnable_folios(). And it is attractive
to associate the PG_lru with the unraised refcount.

But I worry that it may not be to the benefit of others: for example,
page reclaim's isolate_lru_folios() will no longer be able to isolate
folios on the LRU while they're on an fbatch.  Which may be okay (in
the dirty case, pageout() loses interest once it finds refcount raised,
so nothing lost there), or might not be.

It's good to try this, but please don't rush it in.
Thanks,
Hugh

