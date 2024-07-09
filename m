Return-Path: <linux-kernel+bounces-246098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDD492BD8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EED91C22493
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35BB19CCEC;
	Tue,  9 Jul 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCDaN2ki"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C17E18EFD7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537018; cv=none; b=GH3rzrrBlalfgJUyRcrG0czc8nD/4l6roaADsKs8/aqFzTl9tvMveMhm4UDHecS9NWD5SLUnmbJEnO2YdaIbZgcxelgF+CwDs7yIY/BN5eXAjJmsVvgrfxz0gX9IBIKL8eJdIu9j56boWhOkAlXpYexkEt88DPZZNjsbJQYVv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537018; c=relaxed/simple;
	bh=YMS+v6rXSievY27KGBXW/rkG0H/qBIVa+2VzXENRVBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZm4+4110FoniJdqIroPKsOLOhEFVS6vCnGdOUtANr7mmP3Aifj6skt59SO9OtLP0BCM8F8VywgQDx+iFAsWPZlq1kt6iOnG0unzklbRvwbf6ldSmT3Pyed4fftNU6geO/0sU/PsTnZpDQI8A53CNn9A6BLpvQY4lWhPahYmi/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCDaN2ki; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720537015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9M5uL+NQK8IPvoRvEPBKrWSCAqph9q8uCZdOp0LlX4M=;
	b=iCDaN2ki6ADBTOiVKUZ8vEoqDB2Hz5pwfuYb9wGJTl2X/IvOAqy5utiuUJQ+l0t8sNx6ne
	u5lDuI8sjmk5w/M/f+gumfseY3WYotrv2Pl1brS7KH2hfR+sucIrMIPPaGVknuJlfSBJfy
	Jhka172blOUFEreoBBebe7dJZgO1SzE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-fpQ3Bd1aM3a1o_UOwE7zBA-1; Tue, 09 Jul 2024 10:56:53 -0400
X-MC-Unique: fpQ3Bd1aM3a1o_UOwE7zBA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-447e66bbc62so3191361cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 07:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720537013; x=1721141813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9M5uL+NQK8IPvoRvEPBKrWSCAqph9q8uCZdOp0LlX4M=;
        b=S1uvZ9KnGiWNOfx5ZKzTH8TzK6nxFb1MycZL0ClNDGElVmQruRmQ/5US5PoAgP6MQh
         GzBwUyllrrIBsDlqXjqtvzM0+ad/kcX4HtHeycCGHth8EiDN+S6bn2OcLkpMgJxyBr8m
         5S87xrLa6ufjzpqTBNdkgahR91K6lazpaNtVzkaSzpq4gyOfMwhXSmGtW5RjanxZHUFC
         zkkE4OwBwM95PgCCDK9SCss2nrZ4K8zry4Zu/Fd32VxQJh0EsLFcfnIRP0yeHD5p8bcE
         iG0ewnupPuFuS30MHpgb0Y0j90ACsMIrKN6mRfVwFymlHmdTTl3k+5pV+QPMgx458UrV
         kpPg==
X-Forwarded-Encrypted: i=1; AJvYcCXJr8kpOzZM+6WW1MU4m/SgCrmP8UT46I8FEo36z4gc+O68k3weXYchbs53C2elw2X1nVG98B/8DSOi59lyjtGUBJbwI86kvz86XPmZ
X-Gm-Message-State: AOJu0Yz2SXv2oUDlZx9ofkyzrK0dN7gbph2IY6DSM5q8lWruV5ioJ1l1
	ArTx/3bN4gwyLgJTOZj6V5fSS5Kihw1QQ9i6fcRdL1R2lBqpg4AhGFHFFz03ACJ2qwRdghzQULA
	uQ0wT6yQ5K1i16Lpa625DcIRYsmTLLlXljilcXqo++TywPW1XWlllhJVU7ijyiA==
X-Received: by 2002:a05:622a:386:b0:447:f8ba:950d with SMTP id d75a77b69052e-447faa8baebmr26765621cf.5.1720537012803;
        Tue, 09 Jul 2024 07:56:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXzNOmg6Ox8t81ifrM0kRb2gLNom9uCDivVoUTOhP2aPDzz/ZqeFUWYbQR/GyWnA+1c2I8iA==
X-Received: by 2002:a05:622a:386:b0:447:f8ba:950d with SMTP id d75a77b69052e-447faa8baebmr26765411cf.5.1720537012443;
        Tue, 09 Jul 2024 07:56:52 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bf2292sm11148421cf.81.2024.07.09.07.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:56:52 -0700 (PDT)
Date: Tue, 9 Jul 2024 10:56:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Yang Shi <shy828301@gmail.com>, Hugh Dickins <hughd@google.com>,
	Huang Ying <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/migrate: Putback split folios when numa hint
 migration fails
Message-ID: <Zo1PsXQIA9Jr5k0x@x1n>
References: <20240708215537.2630610-1-peterx@redhat.com>
 <4e30c29c-e310-4391-9d3c-09753f173770@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e30c29c-e310-4391-9d3c-09753f173770@linux.alibaba.com>

On Tue, Jul 09, 2024 at 09:48:54AM +0800, Baolin Wang wrote:
> 
> 
> On 2024/7/9 05:55, Peter Xu wrote:
> > This issue is not from any report yet, but by code observation only.
> > 
> > This is yet another fix besides Hugh's patch [1] but on relevant code path,
> > where eager split of folio can happen if the folio is already on deferred
> > list during a folio migration.
> > 
> > Here the issue is NUMA path (migrate_misplaced_folio()) may start to
> > encounter such folio split now even with MR_NUMA_MISPLACED hint applied.
> > Then when migrate_pages() didn't migrate all the folios, it's possible the
> > split small folios be put onto the list instead of the original folio.
> > Then putting back only the head page won't be enough.
> > 
> > Fix it by putting back all the folios on the list.
> > 
> > [1] https://lore.kernel.org/all/46c948b4-4dd8-6e03-4c7b-ce4e81cfa536@google.com/
> > 
> > Cc: Zi Yan <ziy@nvidia.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: Huang Ying <ying.huang@intel.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Fixes: 7262f208ca68 ("mm/migrate: split source folio if it is on deferred split list")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> Good catch. With fixing the building issue pointed by Andrew, please feel
> free to add:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> > 
> > Don't need to copy stable if this can still hit 6.10..  Only smoke tested.
> > ---
> >   mm/migrate.c | 10 ++--------
> >   1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index e10d2445fbd8..20da2595527a 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2615,14 +2615,8 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
> >   	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
> >   				     NULL, node, MIGRATE_ASYNC,
> >   				     MR_NUMA_MISPLACED, &nr_succeeded);
> > -	if (nr_remaining) {
> > -		if (!list_empty(&migratepages)) {
> > -			list_del(&folio->lru);
> > -			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
> > -					folio_is_file_lru(folio), -nr_pages);
> > -			folio_putback_lru(folio);
> > -		}
> > -	}
> > +	if (nr_remaining && !list_empty(&migratepages))
> 
> Nit: you can drop the '!list_empty(&migratepages)' validation, since
> putback_movable_pages() can handle this unusual case.

Sure, considering that it should normally be !empty when the first check
passed.

Though to make this simple for now, I assume we can keep what has been
queued in Andrew's tree.  It isn't so bad either to double check the list
to avoid a function call if possible, I think.

Thanks for the comment,

-- 
Peter Xu


