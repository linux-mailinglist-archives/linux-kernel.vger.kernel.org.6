Return-Path: <linux-kernel+bounces-265351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7835693EFE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E9B1C21C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A31353FE;
	Mon, 29 Jul 2024 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9Jpp6Sq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C185E091
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241853; cv=none; b=OS7Eql/y8r8+u4zvlR/ED7bscNuULMr3Ukryg2V0ZCO5N3BabxOpVIBB/Ez4u4y6nr+62Z+xfCJrUD7OPewCPACRYVmdc0Ybsd1r4OLr+p6tdctE3M9tr0YApmfMWSV+mffvLXnBfW45iv1xGaShzX0qvvaorBn5/SllujRWajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241853; c=relaxed/simple;
	bh=KeXFv/CyfID6eslo/AuwDRbpvQikpvEwe43DE7qvXZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/09vTzYIlAupxakFnyoWoo+CnVk/iYjqrSNknEdid7SXZJDavWj8gzst85BGyTdE3oAqQDMeYWk4gC+quTE5qlDlmo/ITIZeu/JA4g0LjkV72UK9BfYZ61XZQz5r2CDl6qWrHePef9eDjnDo/D/OQsn4ghI43nDwFRhK9wA+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9Jpp6Sq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722241850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BXyPUaLFEwtL9HdgLuVBIuBGMnXshUe7E68g55fuMDY=;
	b=g9Jpp6SqLJ972ha3PnB//402Cpl82+Zq6MFLSlbxppa4eMWQyc4pJeTpatczgy43aexy+w
	N7gqsShgt4bWVSvQmuAeRGyrMJAPnanLhk9kU3uwfiDGYoLW7mT4XBvUQSfxC2rwfGT4ln
	ktZEJOkceDPjkoThCpk1Oiqi13iyQo8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-wb0pl83oPHywSPCvyvl9Vg-1; Mon,
 29 Jul 2024 04:30:44 -0400
X-MC-Unique: wb0pl83oPHywSPCvyvl9Vg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AF4F19560A2;
	Mon, 29 Jul 2024 08:30:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.54])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38D701955D42;
	Mon, 29 Jul 2024 08:30:39 +0000 (UTC)
Date: Mon, 29 Jul 2024 16:30:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>, Jiwei Sun <sunjw10@lenovo.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: Combine all TLB flush operations of
 KASAN shadow virtual address into one operation
Message-ID: <ZqdTK+i9fH/hxB2A@MiWiFi-R3L-srv>
References: <20240726165246.31326-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726165246.31326-1-ahuang12@lenovo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/27/24 at 12:52am, Adrian Huang wrote:
...... 
> If we combine all TLB flush operations of the KASAN shadow virtual
> address into one operation in the call path
> 'purge_vmap_node()->kasan_release_vmalloc()', the running time of
> drain_vmap_area_work() can be saved greatly. The idea is from the
> flush_tlb_kernel_range() call in __purge_vmap_area_lazy(). And, the
> soft lockup won't not be triggered.
              ~~~~~~~~~~~
               typo
> 
> Here is the test result based on 6.10:
> 
> [6.10 wo/ the patch]
>   1. ftrace latency profiling (record a trace if the latency > 20s).
>      echo 20000000 > /sys/kernel/debug/tracing/tracing_thresh
>      echo drain_vmap_area_work > /sys/kernel/debug/tracing/set_graph_function
>      echo function_graph > /sys/kernel/debug/tracing/current_tracer
>      echo 1 > /sys/kernel/debug/tracing/tracing_on
> 
...... 
>   The worst execution time of drain_vmap_area_work() is about 1 second.
> 
> Link: https://lore.kernel.org/lkml/ZqFlawuVnOMY2k3E@pc638.lan/
> Fixes: 282631cb2447 ("mm: vmalloc: remove global purge_vmap_area_root rb-tree")
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Tested-by: Jiwei Sun <sunjw10@lenovo.com>
> ---
>  include/linux/kasan.h | 12 +++++++++---
>  mm/kasan/shadow.c     | 14 ++++++++++----
>  mm/vmalloc.c          | 34 ++++++++++++++++++++++++++--------
>  3 files changed, 45 insertions(+), 15 deletions(-)

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>


