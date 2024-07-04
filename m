Return-Path: <linux-kernel+bounces-240462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A1F926DFE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDC92825CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0362F182D8;
	Thu,  4 Jul 2024 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwXeOmdc"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B960A171AA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720063297; cv=none; b=EOnd2lKuE4SDJcOCGT3tOGovFktCbxIOr/pKNHW45CnujVx34Eo/r1Dw085Iee/fKKLfB6xDCFTpGS/1qxWV/LDJcUzmAKUHmDC3QanNYIDW++3ntf9xc7oGP73YzXHdCWlXbDjhL0+eP9LcWCOZhXgyOBuuqm1CemQ60v3cZHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720063297; c=relaxed/simple;
	bh=Lm7e7bSdY+bRxF6w2oz/kqxztrTpK8p6WiefU+GmyBI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KCf34+ZZAgl8zSoXktVyfAlWsFQ3FAiQUp6RO1t32NwEzrhT07iuhMehdUs9Lg+vB3xsewUrv8hUMTWiKiY8Dz406qzp15OPTVj5Kn75mr4AP6eXacNiwEmTIMpF7pMrEkMpW6fP3UvEXMNjqXUkyOtivVhuIxNG4XasiDX1ydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QwXeOmdc; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dfab4779d95so200960276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 20:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720063294; x=1720668094; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtybbuyYj0RpGRJub+zYJT/1C0NwLxoj7Nw9OPQ82Cc=;
        b=QwXeOmdcYyo5YCM9SlNY3buyrwHT+4GEbMz5mxgye4wfW138D0qCsDlEYhIFTTQjln
         eA9GnXyxjNBvkuXg+qHiG1ogRNgH+xxZKkDVHLxbC3nB/EtBA54L6lGTln1e5DzVEUdS
         ar6RftbS/eVI/f6VQsu1dshecnjeVWvscNz8SYyRKT0/UnHLoKrfR9Fgz2QCjw392AZu
         cFYx5lUobl4D1EGSLbeszqsfhRcfhRajImO4YBwW275qExpdEcEJ3Ykds9cAqZZVL+MJ
         EfLXoZgbybF4CsIyK0ixi4X326NnWhBKimzkI64gKe33+jDqvUuxScha36BqnM9eJNtJ
         E3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720063294; x=1720668094;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtybbuyYj0RpGRJub+zYJT/1C0NwLxoj7Nw9OPQ82Cc=;
        b=WBtS9cnp6naSLLIYWmSIqTAyjfiASRctD4N57ZKxBNkpybYIIB287Zl4eR6e66PgHh
         U6E/iq7xdwtOua34SULeD/f1FHkglP2Hxz8AslJhZiZ41JKaybF4fr2tO1J9YN4Waul4
         MtAcMCXG3clbLELwsSL1YcFmqP62Zr/byOHK3YlE1FS1TNAYN77Cjsd+bqWOQZXZ768I
         ZpcVNx7GtnpJvCC7QB+n3hy5GpGXk7xYtIdhwQYLfAG1vetDDn3T6X1qoj+JWpKzrCDK
         Voo9QkaCZbW+eDYu0pnzY+vYvSBoF4TUAEOB61h8o8GQoKxcKAfQvewb3Wp8ZrXAtZcC
         NxMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYfJlnXHF4LLyaaL9sPgYIwM5t/h6AGFqQKFQ9wMcoP1abaJZXK9BrdS0xkwLTkG77rZlGshOg98UahMI+65cSjZTFXuMc4u+fXMXb
X-Gm-Message-State: AOJu0Yy3VAOFc5KBz81/gcievdSWlihLbXbSC6d5LJTV1EX+CCqFWUJV
	tI7c7eiP0jjm2S8Zhy8FVPM5E7Ub+ZpYYTFU9WdWBdHFsRZjnXTpFLEBHybD0Q==
X-Google-Smtp-Source: AGHT+IHnJ1NbLRUDL+3UZk9Ox3VgOwK38XIyefROX7DwVkkKJ4mohoG+Hsg/LH5OIf0SW21rIhtijQ==
X-Received: by 2002:a25:874e:0:b0:e03:6442:e6a8 with SMTP id 3f1490d57ef6-e03c1907dd0mr419063276.5.1720063294483;
        Wed, 03 Jul 2024 20:21:34 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e03a45f2e66sm681417276.50.2024.07.03.20.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 20:21:33 -0700 (PDT)
Date: Wed, 3 Jul 2024 20:21:22 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Hugh Dickins <hughd@google.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>, 
    Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
In-Reply-To: <20240703193536.78bce768a9330da3a361ca8a@linux-foundation.org>
Message-ID: <825653a7-a4d4-89f2-278f-4b18f8f8da5d@google.com>
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com> <20240703193536.78bce768a9330da3a361ca8a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Jul 2024, Andrew Morton wrote:
> On Tue, 2 Jul 2024 00:40:55 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> 
> > Even on 6.10-rc6, I've been seeing elusive "Bad page state"s (often on
> > flags when freeing, yet the flags shown are not bad: PG_locked had been
> > set and cleared??), and VM_BUG_ON_PAGE(page_ref_count(page) == 0)s from
> > deferred_split_scan()'s folio_put(), and a variety of other BUG and WARN
> > symptoms implying double free by deferred split and large folio migration.
> > 
> > 6.7 commit 9bcef5973e31 ("mm: memcg: fix split queue list crash when large
> > folio migration") was right to fix the memcg-dependent locking broken in
> > 85ce2c517ade ("memcontrol: only transfer the memcg data for migration"),
> > but missed a subtlety of deferred_split_scan(): it moves folios to its own
> > local list to work on them without split_queue_lock, during which time
> > folio->_deferred_list is not empty, but even the "right" lock does nothing
> > to secure the folio and the list it is on.
> > 
> > Fortunately, deferred_split_scan() is careful to use folio_try_get(): so
> > folio_migrate_mapping() can avoid the race by folio_undo_large_rmappable()
> > while the old folio's reference count is temporarily frozen to 0 - adding
> > such a freeze in the !mapping case too (originally, folio lock and
> > unmapping and no swap cache left an anon folio unreachable, so no freezing
> > was needed there: but the deferred split queue offers a way to reach it).
> 
> There's a conflict when applying Kefeng's "mm: refactor
> folio_undo_large_rmappable()"
> (https://lkml.kernel.org/r/20240521130315.46072-1-wangkefeng.wang@huawei.com)
> on top of this hotfix.

Yes, anticipated in my "below the --- line" comments:
sorry for giving you this nuisance.

And perhaps a conflict with another one of Kefeng's, which deletes a hunk
in mm/migrate.c just above where I add a hunk: and that's indeed how it
should end up, hunk deleted by Kefeng, hunk added by me.

> 
> --- mm/memcontrol.c~mm-refactor-folio_undo_large_rmappable
> +++ mm/memcontrol.c
> @@ -7832,8 +7832,7 @@ void mem_cgroup_migrate(struct folio *ol
>  	 * In addition, the old folio is about to be freed after migration, so
>  	 * removing from the split queue a bit earlier seems reasonable.
>  	 */
> -	if (folio_test_large(old) && folio_test_large_rmappable(old))
> -		folio_undo_large_rmappable(old);
> +	folio_undo_large_rmappable(old);
>  	old->memcg_data = 0;
>  }
> 
> I'm resolving this by simply dropping the above hunk.  So Kefeng's
> patch is now as below.  Please check.

Checked, and that is correct, thank you Andrew.  Correct, but not quite
complete: because I'm sure that if Kefeng had written his patch after
mine, he would have made the equivalent change in mm/migrate.c:

--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -443,8 +443,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 	}
 
 	/* Take off deferred split queue while frozen and memcg set */
-	if (folio_test_large(folio) && folio_test_large_rmappable(folio))
-		folio_undo_large_rmappable(folio);
+	folio_undo_large_rmappable(folio);
 
 	/*
 	 * Now we know that no one else is looking at the folio:

But there's no harm done if you push out a tree without that additional
mod: we can add it as a fixup afterwards, it's no more than a cleanup.

(I'm on the lookout for an mm.git update, hope to give it a try when it
appears.)

Thanks,
Hugh

