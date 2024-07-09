Return-Path: <linux-kernel+bounces-246080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D4692BD5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1F1B223FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E815D5C1;
	Tue,  9 Jul 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Krt9HOdh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868A153BF6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536447; cv=none; b=Lta+SSyNqnryCCQd7P90qkOV1Vdkw5uSw6qgkxMd7y7VxiKB1FCEfc+bdWbtSxKC1nKe0/IyF6xqZYBELbKSkgIxQIaypdoid58v8JS9Xjzrf++fWNv72yG0gJ0VOQjkT8zu9X3hWaNPIrdRJ8AzK0Zr/+dPZBerKUr+FvVK0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536447; c=relaxed/simple;
	bh=4gG7uoBq+g7zMGR9BvYIowB5Uq/qCJIp1Lk3kVs7qVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxundLuSRtyvDPsr7Hj6LP1DvtpzhlzVLXhkoHTuRhMpTajGIE7LXOo0RfVsLGV529Dngk9fNa2mldQ20t/otDFYAylHJ3uszig4wEh26qEGemoXF5OZHj0T5pGEK/707RBHqBFc1b+L0N6ux+GWzZ/NgqmCAA2vEO8LJu09gP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Krt9HOdh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720536444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKGd0chfjLmpZEKHuB5xY93IQv++EQzmLr3G/RewAEU=;
	b=Krt9HOdh4GWClnyIS8TeN9E3Kd4K1zcrPiKyKIihfGOQNVsbvduJ5/qOnpiQqY+w3PcOfr
	kqHnAmAEPNd2/NEmMCN1HEJ3qGmr+Hkq51g8YOLQkNTp1E1+MoYaxaIIm2THUHIXKOKn76
	ExZTkdmbUWPbCVMoL6TwzIYfAQWZsu8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-LVT0ypHkNruhKtrrzxnOqw-1; Tue, 09 Jul 2024 10:47:23 -0400
X-MC-Unique: LVT0ypHkNruhKtrrzxnOqw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43e39de4d18so14841101cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 07:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720536443; x=1721141243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKGd0chfjLmpZEKHuB5xY93IQv++EQzmLr3G/RewAEU=;
        b=rFCyrIl+ZtFTGAJBW6L/xATvujgEl7C+AsoSMIecY4qGSSCrzjtyJSDrk5a/xr4P9N
         xsiz3ooL0sfRpdLF3jIx4agaN3EnTrDZMHVUcyPr/Z1XG7/7o8ngJsLUufUoQ+o5F9la
         bd6Eh9U8YxYqloaGUdtI5PgehPDZbeolFSYchI/Xfw+V4+4PaeUTXDwliFCj2Qx/qRWn
         i0GylY4BzGvu5mna0tCXlVlOk+Fk5mk4RVFEnLrnPHmT9Px+pwM/ajfb1Jg0UmuOsGYl
         KYjlHp7YHel5vB6YNx52OtoQJrtDQX0MoFkViKxRA8VjOubh7TiArPzw03zK24TxesNq
         KBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkxbItwgs2DL8LomMEOyRAvjheJmsWE/JeygnKwN2jAx2JiZzIV2aDahkYA2m3ZfCmo9FAm8dFtM0PWDWPyca6viluZhFoENkbdnMq
X-Gm-Message-State: AOJu0Yw9S7uQVEia++lVPpYokh/UVNerfeULhozKHEPjWiUmI+7q2d6Z
	qPvgPDNZHf/thl9fKxV7UdD54T0DBCxCA0e4YwJAQlqE6OHWWdIdzoBBgHwpsESPXih6FfZZ+CE
	whFFNS68l5ZBVcvkoYjwwFfH2B3rEc4axDSqzGo8fPEnUls/VnFdBifAimakBqA==
X-Received: by 2002:a05:622a:253:b0:441:37b:cd7a with SMTP id d75a77b69052e-447faa36adcmr30704831cf.3.1720536442880;
        Tue, 09 Jul 2024 07:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH33tWcjk0dogYvuKLhNnpaD7fne2RM4hSuNLuyLxvJvMIraT3PNRf7HOzpBuCDwNyB6CiAuw==
X-Received: by 2002:a05:622a:253:b0:441:37b:cd7a with SMTP id d75a77b69052e-447faa36adcmr30704541cf.3.1720536442426;
        Tue, 09 Jul 2024 07:47:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b2c011sm11115401cf.19.2024.07.09.07.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:47:21 -0700 (PDT)
Date: Tue, 9 Jul 2024 10:47:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Huang Ying <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/migrate: Putback split folios when numa hint
 migration fails
Message-ID: <Zo1Nd_aLq_tFDMoc@x1n>
References: <20240708215537.2630610-1-peterx@redhat.com>
 <20240708160407.a0c51eb11d0403c161d27540@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240708160407.a0c51eb11d0403c161d27540@linux-foundation.org>

On Mon, Jul 08, 2024 at 04:04:07PM -0700, Andrew Morton wrote:
> On Mon,  8 Jul 2024 17:55:37 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
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
> 
> mm/migrate.c: In function 'migrate_misplaced_folio':
> mm/migrate.c:2624:13: error: unused variable 'nr_pages' [-Werror=unused-variable]
>  2624 |         int nr_pages = folio_nr_pages(folio);
>       |             ^~~~~~~~
> 
> Worrisome.  Which kernel version was this tested against?

mm-unstable (and on top of a few of my other totally irrelevant patches),
and I thought it also applied to mm-stable.

Totally missed this warning when still with WERROR=off locally when
building against this patch, my apologies.

> 
> > Don't need to copy stable if this can still hit 6.10..  Only smoke tested.
> 
> Also worrisome.  Are we to take an only-smoke-tested patch which
> doesn't apply to mainline and which doesn't compile on mm-unstable into
> mainline based on "only smoke tested"?

Hmm so it doesn't apply to mainline..  For the smoke test part, I was not
confident to reproduce it, and I just stumbled over it when looking at the
real BUG_ON we hit.  I thought it might be a good idea to send a patch
before everyone forgets about it.

I think it is easily overlooked probably because the issue wasn't
obvious. IIUC the sympton of hitting it should be that we leak a few of
those tail pages even if they're freed in the future from the mappings.  I
am not sure how much an issue with keep being !lru for them besides the
leaked refcounts, perhaps only vmscan won't see them.  After all, all these
is based on the chance of hitting this case and it should be rare.  I don't
think I know well enough to say.

Considering that nobody yelled after rc5 until now, and this is only
something I observed when looking at the more severe issue Hugh fixed..
maybe we should target this for next release, then stablize it and wait for
a backport to 6.10?

Thanks,

-- 
Peter Xu


