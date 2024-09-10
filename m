Return-Path: <linux-kernel+bounces-322246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C08972644
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5981F24B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4EA1CAB9;
	Tue, 10 Sep 2024 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsQDtm9K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9554538F86
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725928857; cv=none; b=NcS24CY1+eg3At1rjLSDgHPRo+qrNcBxtZ2AQN5wZIdeS7fyWzs/00TEZeyobg/Ea1rp5Cig0/dtDlPrdGHSi1TwcJuPUoauM/g2PJCb031/zu9ZulPhcBi0ehDWy4KuuxAEJKiC+nuAP5lRBpnWo5L4C6D0/E0hAyLDllrR0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725928857; c=relaxed/simple;
	bh=oMe27apIRwPqjvrrTmBrblosf78pmtpsDcb6EAJO+is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiGjN0nweRg8OB/2vNGlB1F6vuafk/LBO7Lq/39zzyJp6T71jjWM6y310SgacUA1xqOe2CNYXKyomlHgLzDSV4aplKX/WhtK7GZGJfr+FUbz4JgXCjVlEdH9uj2rr36w8k66byndEV3FMz8KZ9igI24CjM66TbYIOCH8R6J+u3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsQDtm9K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725928854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZskKqrKp0wbir+h8HFNXShTsEGcgzC7sQ4EikqVlHM0=;
	b=DsQDtm9KY500njjGCEBIlCmeM/YJaNE4a5P84TPjWHv4YotRjcoo79HN+6KLf38hClBjhd
	l9VNKp26yOl79zRPeMHf1Ip5Dw3q/dS7436vJIw3kiJdrRECi8IUYofup/QmO91cbMSyeq
	ya62aXZ/gigDcAFnjZkhUUQ+UaImto4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-lSGu7297Phyw44JRTjrQPQ-1; Mon,
 09 Sep 2024 20:40:50 -0400
X-MC-Unique: lSGu7297Phyw44JRTjrQPQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E58BC19560B8;
	Tue, 10 Sep 2024 00:40:48 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C5B019560A3;
	Tue, 10 Sep 2024 00:40:47 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:40:42 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] mm/vmalloc.c: Use "high-order" in description non
 0-order pages
Message-ID: <Zt+ViveH9q1F+ShB@MiWiFi-R3L-srv>
References: <20240906095049.3486-1-urezki@gmail.com>
 <Zt5j+c/SUNvCMY/+@MiWiFi-R3L-srv>
 <Zt815f8dHOKdAeiY@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt815f8dHOKdAeiY@pc636>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/09/24 at 07:52pm, Uladzislau Rezki wrote:
> On Mon, Sep 09, 2024 at 10:56:57AM +0800, Baoquan He wrote:
> > On 09/06/24 at 11:50am, Uladzislau Rezki (Sony) wrote:
> > > In many places, in the comments, we use both "higher-order" and
> > > "high-order" to describe the non 0-order pages. That is confusing,
> > > because a "higher-order" statement does not reflect what it is
> > > compared with.
> > > 
> > > Suggested-by: Baoquan He <bhe@redhat.com>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  mm/vmalloc.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > This looks good to me, thanks.
> > 
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> > 
> > By the way, do you plan to clean up the rest of them in other places?
> > 
> urezki@pc638:~/data/raid0/coding/linux-next.git$ grep -rni higher include/linux/vmalloc.h 
> urezki@pc638:~/data/raid0/coding/linux-next.git$ grep -rni higher mm/vmalloc.c
> 493:     * nr is a running index into the array which helps higher level
> urezki@pc638:~/data/raid0/coding/linux-next.git$
> 
> What am i missing? Didn't i do it?

Sorry, I didn't make it clear. I meant those places other than vmalloc
related files, e.g mm/page_alloc.c, there are a lot of [Hhigh]er-order
mixed with high-order. I can continue the cleaning sometime if it's not
in your TO-DO list.

mm/page_alloc.c:551: * Higher-order pages are called "compound pages".  They are structured thusly:
mm/page_alloc.c:716: * of the next-higher order is free. If it is, it's possible
mm/page_alloc.c:720: * as a 2-level higher order page
mm/page_alloc.c:735:    return find_buddy_page_pfn(higher_page, higher_page_pfn, order + 1,
mm/page_alloc.c:2750: * split_page takes a non-compound higher-order page, and splits it into
mm/page_alloc.c:3587:   /* The OOM killer will not help higher order allocs */
mm/page_alloc.c:4811: *  within a 0 or higher order page.  Multiple fragments within that page
mm/page_alloc.c:6516:    * page allocator holds, ie. they can be part of higher order
mm/page_alloc.c:6790: * Break down a higher-order page in sub-pages, and keep our target out of


