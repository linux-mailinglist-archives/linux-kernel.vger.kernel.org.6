Return-Path: <linux-kernel+bounces-266769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D50C940688
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FEB1F22ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA30156C71;
	Tue, 30 Jul 2024 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="et0QHC8W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BA21465AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722313812; cv=none; b=c+7n+yyLu34dqYqC8Q/5nmxG4xf5GdngJ/ClqiPiU6MMtDTKouYwvO4s2Tx8Wt+odwuEdvTzNqBGBkm6AZL4ayLcdl5denSGzffWYVBGYmbJpphymWcE70N3b77GSDPSM5Ib3w3khAP0Hq848pD2nLd01LBNUgOLvY+ixtrMpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722313812; c=relaxed/simple;
	bh=GqXNcoz76O2D/U/PuQFd1Si2h+SvLnulnjkzIWZ+2QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGDdZyjMjiQsfrosusf/574q2WnBJ14spuaWWIKCIstcXW/ztBO3gT3gE+8MvntGtVCcZVA3tjUO5wHC59RlIrht9zWqsDhJjiBjkQhpxbzIhsVz1lTzEpJU7O5iu2OSLdNcxroEtAPkAEzvs7s6d7GqYLwOygbj3xKMP2sNk7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=et0QHC8W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722313809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S0HIiIL0c9hntOyqR7uQeJp9VmL1xQ5ORLo0IiKZfNI=;
	b=et0QHC8Wo79QJ3nLkWJM3+8gdPOyX5dSHIF0yvzE4UmClHtaxUExcsbay++w1UU6efDs6W
	PUfmk/EfJozGswy6LDkoZR1y8Rm5Vo00A3osToG+hffPN04U1zMarl768YSGII4TEMxXwY
	qmH08OUtOmz2rlbP5PTV3PorI6c9r9E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-Uh0Lk31INByO6bzV24RUDw-1; Tue,
 30 Jul 2024 00:30:05 -0400
X-MC-Unique: Uh0Lk31INByO6bzV24RUDw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6341A1955D55;
	Tue, 30 Jul 2024 04:30:03 +0000 (UTC)
Received: from localhost (unknown [10.72.112.91])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9543E1955D42;
	Tue, 30 Jul 2024 04:30:01 +0000 (UTC)
Date: Tue, 30 Jul 2024 12:29:57 +0800
From: Baoquan He <bhe@redhat.com>
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Barry Song <21cnbao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Tangquan Zheng <zhengtangquan@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect
 __vmap_pages_range_noflush() if vm_area_alloc_pages() from high order
 fallback to order0
Message-ID: <ZqhsRbwyGhQMqR6T@MiWiFi-R3L-srv>
References: <20240725035318.471-1-hailong.liu@oppo.com>
 <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com>
 <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
 <CAGsJ_4z0AYTVoCJjTyZsku24kPfOTnu1KCms_NPevdNKW+6sdg@mail.gmail.com>
 <Zqb0+L/21/AKUagd@MiWiFi-R3L-srv>
 <20240730032447.avaoa5uhcxdkcjzs@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730032447.avaoa5uhcxdkcjzs@oppo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/30/24 at 11:24am, Hailong Liu wrote:
> On Mon, 29. Jul 09:48, Baoquan He wrote:
> [...]
> > Hi Hailong,
> >
> > Please feel free to collect them to post formal patch, maybe two
> > patches, one is to allow non-nofail to fallback to order-0 in
> > vm_area_alloc_pages(), the other is passing out the fallbacked
> > page_order to vmap_pages_range() if it's OK.
> Sorry for late response. I personally prefer to revert part of
> the problematic patch. There are several reasons:
> - Save memory usage if high order allocation failed.
> - If nofail and fallback to order0 in vmalloc huge allocation,
> actually the allocation is alighed with PMD_SIZE or not PAGE_SHIFT.

It's OK, maybe you can post patch to show what it looks like,
we can review and discuss there.

> 
> You might be concerned about performance issues. But IMO,
> - If we fallback to order0, we can make use of bulk allocator.
> - Maybe we can remove VM_ALLOW_HUGE_VMAP in kvmalloc.
> 
> I am not sure if I have misunderstood anything. If I have, please
> let me know.
> >
> > Thanks
> > Baoquan
> >
> >
> 
> --
> help you, help me,
> Hailong.
> 


