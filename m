Return-Path: <linux-kernel+bounces-355824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F70F995796
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C72E28A4C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2902139D7;
	Tue,  8 Oct 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b="hxhCIkhy"
Received: from mail-m92232.xmail.ntesmail.com (mail-m92232.xmail.ntesmail.com [103.126.92.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1658F6D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415636; cv=none; b=j2mnzbjaDWwxOphvF5/vEYnQZrQsXcXdri5r4hTRkhepTWv3nSmqQTz9fCUMbEASAfPaWp/B7HNaNaGv4iGxK1GGkhM8SsdoRa7tM0VORsRkChg4oyofP9XgXZEfnrW/HzBqk5kXMxsholLDk4APOwX0usLIZrFBRoD8BGuBiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415636; c=relaxed/simple;
	bh=jaAEurf11Ey+LMVJHDiESXWMEKeIPw2/6unQu/wy4gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKgUulq742oYRXPLivUbe+Y1l0TrXnCruUC+IquP2uzjvYiMtOMSSIfGo20BnjrDIqfZn7w7LulRG5RuuSDli+M3zf9e/isH6JSX06pX0rPRtRy+0rQCTnE+GLdtFC88nom8V5qefrG5Kd9OxuT7BgM4XTlatUwGqRmk0kwgrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=none smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=hxhCIkhy; arc=none smtp.client-ip=103.126.92.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ucloud.cn
DKIM-Signature: a=rsa-sha256;
	b=hxhCIkhyNUKaVYde9F06G3xikS2rQezbLx0Mm3EAQa4KncofOi+LpK+mofKXPjOw6GAc8nskpUBWFsBqjPQq52Nq6J3Kam4mwK4GZbD/1bxtElC9/DTxc94xKqnWj5WJ8X9PvNBaZQU1szLf6DR3AIZYLcMhY4PkKr2fbMkoy+s=; s=default; c=relaxed/relaxed; d=ucloud.cn; v=1;
	bh=m4tWzm+SyevbhfLfc936todUhq/nd7Hx+cEqmEzUlhY=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost (unknown [106.75.210.166])
	by smtp.qiye.163.com (Hmail) with ESMTPA id ACADB7405DC;
	Tue,  8 Oct 2024 21:28:41 +0800 (CST)
Date: Tue, 8 Oct 2024 21:28:41 +0800
From: "yuan.gao" <yuan.gao@ucloud.cn>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	akpm@linux-foundation.org, roman.gushchin@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/slub: Avoid list corruption when removing a slab
 from the full list
Message-ID: <cx3ogasgljkytwb3zwf4qtaujupch3qnyfzr6fvr5anqxdzhfh@eqts4gzr5uvy>
References: <20241007091850.16959-1-yuan.gao@ucloud.cn>
 <b304fe39-4fcc-4b2b-a95f-1bb476c94a01@suse.cz>
 <CAB=+i9T4nGJAQGpYSbAvyyfgceLmO6ih=gS7bPpvCdMMetTurw@mail.gmail.com>
 <916bea8e-0e79-c561-f8e8-b3c7fa026161@gentwo.org>
 <006695cb-368c-9afc-80b5-29338e85ab99@gentwo.org>
 <49469e9f-ca42-4250-b949-66247f623c3d@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49469e9f-ca42-4250-b949-66247f623c3d@suse.cz>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0oaVhkaT05LHxpIH0hMGVYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUpLVUpNTVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
	tVSkJLS1kG
X-HM-Tid: 0a926c5151f20236kunmacadb7405dc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NiI6Njo5KjcuCkItDzQ9Ak41
	HFYwCTxVSlVKTElDSEJPSklJSElIVTMWGhIXVQIOGhVVHBoUOw4YFxQOH1UYFUVZV1kSC1lBWUpL
	TVVMTlVJSktVSk1NWVdZCAFZQUlMTU03Bg++

On 24/10/08 11:17AM, Vlastimil Babka wrote:
> On 10/7/24 18:40, Christoph Lameter (Ampere) wrote:
> > 
> > list_del() in remove_partial() sets poison values for next/prev so there
> > should no list
> > corruption but a failure showing the poison values.
> 
> Yeah that's what is reported, but there's still a mention of list corruption:
> 
> [ 4277.385669] list_del corruption, ffffea00044b3e50->next is LIST_POISON1 (dead000000000100)
>  
> > static inline void list_del(struct list_head *entry)
> > {
> >         __list_del_entry(entry);
> >         entry->next = LIST_POISON1;
> >         entry->prev = LIST_POISON2;
> > }
> > 
> 

Actually, if panic_on_oops=0, kernel will hang on my x86 system. The
task(kworker here) that triggers the bug dies in the #ud trap handler.

Thanks

