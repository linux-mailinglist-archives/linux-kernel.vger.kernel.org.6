Return-Path: <linux-kernel+bounces-264974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E3F93EABE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD93B21395
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C545A3A1BF;
	Mon, 29 Jul 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ON7AZgE+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DAE41C6A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217738; cv=none; b=mnlK9AHpi3GL0K7U199k60N2F5LJVXHdvvkuEksa9m4V8+oABR7fCYpD31J9aV7GOB7G2Z5J0avu4W2o7s15Lo5trh3bwGryBjzezmkVNqygaq7wwcc5AWNsP6BgFG/oGXpJtC5sq+ikUoNiGQGEkOrT03rO9y/mtNNKpqeU9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217738; c=relaxed/simple;
	bh=RxPpaHkg/g40G9ygRudAv8dMRFtwDVwsiNsb3+77QEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BApaTIPO9FOvEb/r/XVKdAxOazoEwu+nBgHp1ZYtsQO07JeJBVMDnPXpzzTeGdb8wIKbLB/sRqlsBxwTjTndaZPBWmmAzd35fCQEIoXgsL2+fldhik/CGShAQlg//w1Cn2aP1Z0bXM+ob61vHcA2UrwM4xtT1dyaPLjPafQeh+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ON7AZgE+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722217734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSsERxOF6wJ/t/7TQvseMpYRU+ggIxZpcTX5SMQ5AG0=;
	b=ON7AZgE++ZABdNKbyMloNbG65sJRx+dVgc7aXTJAiR8Y6NG4HVVdzIN8ufkVxoloB1Ohws
	PCvhMUQtGGCkIFIo3s/9dABi3Eemb+oQA4Xqf5ZOCZPulyNtgC+m7F0ImGdgvCWcsU5rWG
	CEASWAxRVPCaszKz9qdTn58LsSW886U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-Vk5V_TZrM7Cxr3VNAnqZ_g-1; Sun,
 28 Jul 2024 21:48:50 -0400
X-MC-Unique: Vk5V_TZrM7Cxr3VNAnqZ_g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 616AA19560BA;
	Mon, 29 Jul 2024 01:48:47 +0000 (UTC)
Received: from localhost (unknown [10.72.112.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56BA33000198;
	Mon, 29 Jul 2024 01:48:44 +0000 (UTC)
Date: Mon, 29 Jul 2024 09:48:40 +0800
From: Baoquan He <bhe@redhat.com>
To: Barry Song <21cnbao@gmail.com>, Hailong Liu <hailong.liu@oppo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <Zqb0+L/21/AKUagd@MiWiFi-R3L-srv>
References: <20240725035318.471-1-hailong.liu@oppo.com>
 <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com>
 <ZqMKZ67YhzhbqYg9@MiWiFi-R3L-srv>
 <CAGsJ_4z0AYTVoCJjTyZsku24kPfOTnu1KCms_NPevdNKW+6sdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4z0AYTVoCJjTyZsku24kPfOTnu1KCms_NPevdNKW+6sdg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Barry,

On 07/26/24 at 03:53pm, Barry Song wrote:
> On Fri, Jul 26, 2024 at 2:31 PM Baoquan He <bhe@redhat.com> wrote:
......
> >  mm/mm_init.c <<alloc_large_system_hash>>
> >  table = vmalloc_huge(size, gfp_flags);
> >  net/ipv4/inet_hashtables.c <<inet_pernet_hashinfo_alloc>>
> >  new_hashinfo->ehash = vmalloc_huge(ehash_entries * sizeof(struct inet_ehash_bucket),
> >  net/ipv4/udp.c <<udp_pernet_table_alloc>>
> >  udptable->hash = vmalloc_huge(hash_entries * 2 * sizeof(struct udp_hslot)
> >
> > Maybe we should add code comment or document to notice people that the
> > contiguous physical pages are not guaranteed for vmalloc_huge() if you
> > use it after boot.
> 
> Currently, the issue goes beyond just 'contiguous physical pages are
> not guaranteed.'
> The problem includes the likelihood of failure when trying to allocate
> 2MB of contiguous
> memory. That's why I suggest we allow fallback to order-0 for
> non-nofail allocations with
> your proposed changes.

I missed this part of your comment, I agree with you. I think it's doable
with below draft patch combined with my earlier draft change.


diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 260897b21b11..9ae85342d337 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3581,11 +3581,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		else
 			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
 		if (unlikely(!page)) {
-			if (!nofail)
+			if (!nofail && !order)
 				break;
 
 			/* fall back to the zero order allocations */
-			alloc_gfp |= __GFP_NOFAIL;
+			alloc_gfp = gfp;
 			order = 0;
 			continue;
 		}


Hi Hailong,

Please feel free to collect them to post formal patch, maybe two
patches, one is to allow non-nofail to fallback to order-0 in
vm_area_alloc_pages(), the other is passing out the fallbacked
page_order to vmap_pages_range() if it's OK.

Thanks
Baoquan


