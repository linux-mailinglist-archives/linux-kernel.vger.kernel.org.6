Return-Path: <linux-kernel+bounces-238094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F7C924367
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F491F24296
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3161BD01A;
	Tue,  2 Jul 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIipsTNx"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEFFBA3F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936973; cv=none; b=oXNWp5QkY1CTQfGiEgq1yyCgirnWs2RZ+SNEXS9cmgSXq9QmjWJyvqGebf1iOzqaEKJ9A6DqANusaHNFis6CyZ58MF0MC/ndXqhwFULTNKTja/59ADr9iPIvIyj5e3hKbrhf/SO3H7iRbxliV/f4I8LfZtbumZ+vkdoCTAkKVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936973; c=relaxed/simple;
	bh=S/DOl2Ub8vH9Wjr+TUeleAc+pKW+ZpFz94Cg90qILMs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mu3aEIyS2KiVIw5DgIa6k2zlYM97l+S3lvdDLJ/4c9DPW6Yty2SzO557CKp/iWxASxbJ2N6SE7vQT9Cyn46xTWuvBg57Uz3nVXMDxu6V+1NiVRqwWoNg9QmWaddlvZbxJX4B9T1aLcJQFGVF/oJ65nwW54SHnFp0vIofed/WNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIipsTNx; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6325b04c275so44809317b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 09:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719936971; x=1720541771; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8z2/XiGVaBn+uz521Bdia43A7AchOvsj677ZoQYBVYQ=;
        b=OIipsTNxJY2vMCJWtSrxTHszEzVBwtpIaMHNQGrh3PSpuF4BJPdbgmHvS1KMNYutu+
         Zv3oXkYw3EEtoXwOs1I6o7iRYtes6nyJQwFpNoZm7IwT0chwIV6501aeZQAgmhSGnS+9
         f/dzEEQQ7TeoRgAfCbbIlGbg47VDmpklRz7Qc5fhxFaWg06g2FM5rnyWv7HHfrt9P7Rb
         TqDncj02S9xGnhR10ypsUQ9whV9ADMmvQ3m5H3DjHJP1KB43wWieXHl7n+Ps1WnYzTOn
         47GjCpWYBrNfDSVxRTlSwazM29HKTNABpuFyWEZSiQKP3xRfndxa3TyagaBCfW+62l/1
         80Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719936971; x=1720541771;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8z2/XiGVaBn+uz521Bdia43A7AchOvsj677ZoQYBVYQ=;
        b=mQhBcKyreWbzAnQtcquyX9G20EHO4+HgRs5h/VR1Na7vSDTFOAqNSkFD26C/lA8Z7v
         YF1vQC9yru1CauTQue0PrFwSyHVfIYEP4RD9YnxOhLYE4yrJtjDL3GmmPuuhblqMKlgh
         7hV1HeVwXtuRH3H+LeZuv8PQcoKMk5oOuu2CGr9FqlkFUKgXID+bm3zqbl6Z5byhaUSx
         lU8Uapga1ijKYjSqO8fXfG16VJ+SxiaTfd6TDHpkrQJq53Loq33iAJ5rJeOco9Y/ENOS
         hVijWKvTeN7Dxuu+qHxJnS3f3czAROquMBKBzw7tv//H2GvO7nkNuhbDM70BpcFS6tcw
         WlaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGhkQJG/Vxi9KCCWxYfud/xmaiSzG8r25qF6dcPH+I0lPzjhwLdye2p0kGWDrbFy7k1cSsAcjeOh0+2zPjHzrgsSysHpn0ZvB2AflX
X-Gm-Message-State: AOJu0YwCVzLgrCPHf//a7Dro++SzcR60XSU2sU9Z3Q3gVAmbuKei6dKK
	ql4uH9rLM7R6HUP06e8o451lzT2jjFVzWCtdSolZB9Imnn1/MFeQNnDNWqdMMg==
X-Google-Smtp-Source: AGHT+IGMTd9vVYJ9rW41TxRQS96zY1DUsAKyRb/H1VxRHrMUJIA6BK6QEvH+l4zS1pZX4JRx60I/LQ==
X-Received: by 2002:a05:690c:a16:b0:61b:1f0e:10 with SMTP id 00721157ae682-64c70c76528mr87847567b3.4.1719936970721;
        Tue, 02 Jul 2024 09:16:10 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9ba5a19fsm18211047b3.96.2024.07.02.09.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 09:16:10 -0700 (PDT)
Date: Tue, 2 Jul 2024 09:15:54 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Nhat Pham <nphamcs@gmail.com>, Yang Shi <shy828301@gmail.com>, 
    Zi Yan <ziy@nvidia.com>, Barry Song <baohua@kernel.org>, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, 
    David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
In-Reply-To: <da6bad97-18b8-4cd0-9dcc-b60fb20b7a84@linux.alibaba.com>
Message-ID: <ec3a5d94-1985-f66d-1aa8-3783fe498f5a@google.com>
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com> <da6bad97-18b8-4cd0-9dcc-b60fb20b7a84@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Jul 2024, Baolin Wang wrote:
> On 2024/7/2 15:40, Hugh Dickins wrote:
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

(I should have added "isolation and" into that list of conditions.)

> > unmapping and no swap cache left an anon folio unreachable, so no freezing
> > was needed there: but the deferred split queue offers a way to reach it).
> 
> Thanks Hugh.
> 
> But after reading your analysis, I am concerned that the
> folio_undo_large_rmappable() and deferred_split_scan() may still encounter a
> race condition with the local list, even with your patch.
> 
> Suppose folio A has already been queued into the local list in
> deferred_split_scan() by thread A, but fails to 'folio_trylock' and then
> releases the reference count. At the same time, folio A can be frozen by
> another thread B in folio_migrate_mapping(). In such a case,
> folio_undo_large_rmappable() would remove folio A from the local list without
> *any* lock protection, creating a race condition with the local list iteration
> in deferred_split_scan().

It's a good doubt to raise, but I think we're okay: because Kirill
designed the deferred split list (and its temporary local list) to
be safe in that way.

You're right that if thread B's freeze to 0 wins the race, thread B
will be messing with a list on thread A's stack while thread A is
quite possibly running; but thread A will not leave that stack frame
without taking again the split_queue_lock which thread B holds while
removing from the list.

We would certainly not want to introduce such a subtlety right now!
But never mind page migration, this is how it has always worked when
racing with the folio being freed at the same time - maybe
deferred_split_scan() wins the freeing race and is the one to remove
folio from deferred split list, or maybe the other freer does that.

I forget whether there was an initial flurry of races to be fixed when
it came in, but it has been stable against concurrent freeing for years.

Please think this over again: do not trust my honeyed words!

> 
> Anyway, I think this patch can still fix some possible races. Feel free to
> add:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks, but I certainly don't want this to go into the tree if it's
still flawed as you suggest.

Hugh

