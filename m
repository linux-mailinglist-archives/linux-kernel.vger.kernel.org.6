Return-Path: <linux-kernel+bounces-322791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0503E972E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E991F2577B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807541891A5;
	Tue, 10 Sep 2024 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnZDZxpm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB45E1885A6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961142; cv=none; b=JRkMQEWctwt467iMa/ERLK3ezxekKatiTc14MHqX1VLd7P8D58Y/3VFSB02sJ11tDM3+YZaZ50Ye2aZWyBAuRtSioKW1K94P/Yr8l4+hrB9QlOMqTNVruWYHUuGvJ8jelF/anODKD6thN3cRF4vzCZJ4AVmLcZcJLcQxq31bM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961142; c=relaxed/simple;
	bh=mhu/u1HMMstptnhA0enUqMKgUpzMKA7vjix+p5byYmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ1Nf4EKvhW9AUpitBQPFII4D0ywzKr43MzeP7nNu0IkNrYw5abPGEoi3tFiMhFoVxztj2XKKAU0949BRdovaPmVyEak9rNOnVrIEB6B3nqFgMETgR6BfU/7QD4du4MKkIRp7WkggrCwZkUiyNsKfdjjjJpJeRIz3pJAuFABDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnZDZxpm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725961138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jg80v2sHYr9jxVuH+ZibnLi+74iJM1iXUQ8iFd11kAo=;
	b=UnZDZxpm86wc/MiN7N4pAjCLvac0d6iidLkmzajVdgMnawJ3rg3HvZqyr6pJi4RSa1QY2x
	9AY4GI3w/vl4j/eWIQDxjuWj/vt8g4cT3OgT5KSAdjVbugjvcQCg3J4xd0YMLZiIizV5JH
	66View48aPLFk86I/mQXfPLmspg7SDA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-2G_Q7nXqOuOwOzjcoc0RYQ-1; Tue,
 10 Sep 2024 05:38:55 -0400
X-MC-Unique: 2G_Q7nXqOuOwOzjcoc0RYQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9359919560BF;
	Tue, 10 Sep 2024 09:38:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 351951955D44;
	Tue, 10 Sep 2024 09:38:51 +0000 (UTC)
Date: Tue, 10 Sep 2024 17:38:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] mm/vmalloc.c: Use "high-order" in description non
 0-order pages
Message-ID: <ZuATpy6mPwX1C0/K@MiWiFi-R3L-srv>
References: <20240906095049.3486-1-urezki@gmail.com>
 <Zt5j+c/SUNvCMY/+@MiWiFi-R3L-srv>
 <Zt815f8dHOKdAeiY@pc636>
 <Zt+ViveH9q1F+ShB@MiWiFi-R3L-srv>
 <ZuAJ3lHh7XCC4M3w@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuAJ3lHh7XCC4M3w@pc636>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/10/24 at 10:57am, Uladzislau Rezki wrote:
> On Tue, Sep 10, 2024 at 08:40:42AM +0800, Baoquan He wrote:
> > On 09/09/24 at 07:52pm, Uladzislau Rezki wrote:
> > > On Mon, Sep 09, 2024 at 10:56:57AM +0800, Baoquan He wrote:
> > > > On 09/06/24 at 11:50am, Uladzislau Rezki (Sony) wrote:
> > > > > In many places, in the comments, we use both "higher-order" and
> > > > > "high-order" to describe the non 0-order pages. That is confusing,
> > > > > because a "higher-order" statement does not reflect what it is
> > > > > compared with.
> > > > > 
> > > > > Suggested-by: Baoquan He <bhe@redhat.com>
> > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > ---
> > > > >  mm/vmalloc.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > This looks good to me, thanks.
> > > > 
> > > > Reviewed-by: Baoquan He <bhe@redhat.com>
> > > > 
> > > > By the way, do you plan to clean up the rest of them in other places?
> > > > 
> > > urezki@pc638:~/data/raid0/coding/linux-next.git$ grep -rni higher include/linux/vmalloc.h 
> > > urezki@pc638:~/data/raid0/coding/linux-next.git$ grep -rni higher mm/vmalloc.c
> > > 493:     * nr is a running index into the array which helps higher level
> > > urezki@pc638:~/data/raid0/coding/linux-next.git$
> > > 
> > > What am i missing? Didn't i do it?
> > 
> > Sorry, I didn't make it clear. I meant those places other than vmalloc
> > related files, e.g mm/page_alloc.c, there are a lot of [Hhigh]er-order
> > mixed with high-order. I can continue the cleaning sometime if it's not
> > in your TO-DO list.
> > 
> > mm/page_alloc.c:551: * Higher-order pages are called "compound pages".  They are structured thusly:
> > mm/page_alloc.c:716: * of the next-higher order is free. If it is, it's possible
> > mm/page_alloc.c:720: * as a 2-level higher order page
> > mm/page_alloc.c:735:    return find_buddy_page_pfn(higher_page, higher_page_pfn, order + 1,
> > mm/page_alloc.c:2750: * split_page takes a non-compound higher-order page, and splits it into
> > mm/page_alloc.c:3587:   /* The OOM killer will not help higher order allocs */
> > mm/page_alloc.c:4811: *  within a 0 or higher order page.  Multiple fragments within that page
> > mm/page_alloc.c:6516:    * page allocator holds, ie. they can be part of higher order
> > mm/page_alloc.c:6790: * Break down a higher-order page in sub-pages, and keep our target out of
> > 
> I see. I appreciate if you go ahead and improve it further.

Ok, will do later.


