Return-Path: <linux-kernel+bounces-312574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1F6969855
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F751F23CED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCE8131E2D;
	Tue,  3 Sep 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+XCz14s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1319F400
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354553; cv=none; b=MsyzzxQdG8WiZKcmcHjx3vLi89IOSt8HsQDr+RTZHYR4bRaPkA5z/scwU8h7JCjOiJ8SesZ2Bo7V2CbSP8zfBDxshMkfx48y0pKivMXPiceULMe4wQ5ysHpLXlQAKhCb336Byw2Z6u4gOP2AAJohVrh/YDvr4z+AIqX7HP63lM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354553; c=relaxed/simple;
	bh=1e4R+IYDECEe9tAhq3UujNE6N7X5OljGX3s7WihMi+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnBFJiwSL8URScQjvO8ZVGsBKDs2Eizsgj4fE4K8xlkNJPHvy99VODqwgjV6fIFV3DpgoYsBKJrjuZlbaS0TiMiLUt/KSNCYE3ds2TNLEFNWY/+HF/LKHuUYWY8DYh68Q7K3FwLP0XN8qrjXKrKkHisGAvoTNtHhPqbDbw5gURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+XCz14s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725354551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3wZSFTVAkBBwZOhZbgXmk5W4midhZVoWG1SBfmC4Uh4=;
	b=Z+XCz14sziwd7yHb873Eu45eYFonvp1DY6M8tnVeelIsdUiCV4+zIT9eX3nJe+XwLoQ0Rx
	WXndbpiizLSMV+eatz+LPab5Lo/gFwfY+U82jfyJDAm3uHwV8hDbHTQYUkKcZDIqZxgdii
	ChAOjxRArj/Eg9/QOhqof2eo4EGzw1A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-UeqO92NEOPeS0Oogj4V-_g-1; Tue,
 03 Sep 2024 05:09:06 -0400
X-MC-Unique: UeqO92NEOPeS0Oogj4V-_g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81DBA18BC2DE;
	Tue,  3 Sep 2024 09:09:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.38])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 94EDD19560AA;
	Tue,  3 Sep 2024 09:08:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  3 Sep 2024 11:08:51 +0200 (CEST)
Date: Tue, 3 Sep 2024 11:08:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: use vm_special_mapping close() functionality
Message-ID: <20240903090843.GA17936@redhat.com>
References: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
 <20240903073629.2442754-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903073629.2442754-1-svens@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/03, Sven Schnelle wrote:
>
> [   44.505448] ==================================================================                                                                      20:37:27 [3421/145075]
> [   44.505455] BUG: KASAN: slab-use-after-free in special_mapping_close+0x9c/0xc8
> [   44.505471] Read of size 8 at addr 00000000868dac48 by task sh/1384
> [   44.505479]
> [   44.505486] CPU: 51 UID: 0 PID: 1384 Comm: sh Not tainted 6.11.0-rc6-next-20240902-dirty #1496
> [   44.505503] Hardware name: IBM 3931 A01 704 (z/VM 7.3.0)
> [   44.505508] Call Trace:
> [   44.505511]  [<000b0324d2f78080>] dump_stack_lvl+0xd0/0x108
> [   44.505521]  [<000b0324d2f5435c>] print_address_description.constprop.0+0x34/0x2e0
> [   44.505529]  [<000b0324d2f5464c>] print_report+0x44/0x138
> [   44.505536]  [<000b0324d1383192>] kasan_report+0xc2/0x140
> [   44.505543]  [<000b0324d2f52904>] special_mapping_close+0x9c/0xc8
                                       ^^^^^^^^^^^^^^^^^^^^^
Caused by

	[PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
	https://lore.kernel.org/all/20240812082605.743814-1-mpe@ellerman.id.au/

?

> +static void uprobe_clear_state(const struct vm_special_mapping *sm, struct vm_area_struct *vma)
> +{
> +	struct xol_area *area = container_of(vma->vm_private_data, struct xol_area, xol_mapping);
> +
> +	mutex_lock(&delayed_uprobe_lock);
> +	delayed_uprobe_remove(NULL, vma->vm_mm);
> +	mutex_unlock(&delayed_uprobe_lock);
> +
> +	if (!area)
> +		return;
> +
> +	put_page(area->pages[0]);
> +	kfree(area->bitmap);
> +	kfree(area);
> +}
> +
>  static struct xol_area *__create_xol_area(unsigned long vaddr)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -1481,6 +1500,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>
>  	area->xol_mapping.name = "[uprobes]";
>  	area->xol_mapping.fault = NULL;
> +	area->xol_mapping.close = uprobe_clear_state;

LGTM.

but with or without this fix __create_xol_area() also needs

	area->xol_mapping.mremap = NULL;

?

And in the longer term I think we should probably add a single instance
of "struct vm_special_mapping uprobe_special_mapping with ->fault != NULL
but this is another issue.

Oleg.


