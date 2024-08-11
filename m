Return-Path: <linux-kernel+bounces-282373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4431294E2FA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97568B20CE0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 20:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087971598E3;
	Sun, 11 Aug 2024 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZ1oEPkI"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78FC158529
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407981; cv=none; b=Qr7vGb9CovU+JBcweNe/OgSKkIIWCOj9gg4Vg2bPNp4EzR4tkzuwaNtaw7ek6tmJ8UREh8mk1c0Hhswbs/rgwupvfuKqRJuyd0k8SFdD+HgXbWChybAKi/wpSzTT4ebglGWhDeRW3N8JPh+/yLvm3S4fzGukhL5v6Z+hSGeQx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407981; c=relaxed/simple;
	bh=L5nlxNBJPsreEVgJgyQlqBxEu2DIYkxEXAYEgjfTBIc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t+/E8zTTk7vLzw/BLh3zYa8njYNk9DWp9k2D8QQqpNjG57NRREVruch8/kdK6mOatLsIXKW5FQFygu6EjmPqBzGb2BhPmAsqb53olsfeTLPfDucMA/T3CNeD4iJ/VeKC8z5S075128C0E/pb91OTKQmAQZmj3OONJD4lDsseH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZ1oEPkI; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39c3bf0584cso75755ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723407979; x=1724012779; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YlExk0c05J5NkENFEJVDSS8e9y+ZVkGFZx53tZxGePI=;
        b=LZ1oEPkIOcWRPtd5vDjrlq+H4qN5xAgABcGmZzyQc7oqwYrhtnX+cFlxsONj9ApLsI
         PvJpqFIofN6Y2RKflKq6IMtT5rUrMUZEKsQxf4ysZVlGeV0O4YXb5vKcg1OKpDht8fgH
         BdrfeuYR9ipXM0c2Jeam2FV4TNGFKE6J8ojh7A2fsAaaaa4qzaR8GfiR3MP7kKgeiwpN
         NPxMuBqbnxydQwNOTPnjM6YZb+QMHEKwdmUx4QNY6KqVt7NHG0Sm67U4NqF2ahViO2Nc
         JfYo94S4jp+m9318OOpgywFt4gXYEgF1qRs/fVQazkWYkhwp30/B8q08D9lb9nHJ71Th
         Vz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723407979; x=1724012779;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlExk0c05J5NkENFEJVDSS8e9y+ZVkGFZx53tZxGePI=;
        b=sb30zIf24OcS1NGrgX3PaL3G6m33HbAyQ8GsYvvO/r3lk9rV0SimSHSWFc7JE9Y+yM
         hMsgK9nSfA6OUxHZgXSer0JYJ606ZKgYLBJ0xDPcGlMmlqWHOuZUGlxloBCQ32S5WAqy
         dko4HawXQ2tcaueyZs46nWojKeqQsGpUJbN8QrYSHKf14gp8v/C0ak9PIrXJcstm+/oM
         gDtSY/BwmUuQrUtywTeP69JuZ9p2YrJOnMjjUg/BPVSLKdqA/syyVeqogSCafadUoceI
         5Hbjn6lxt4a5EZ3H5li4f1VgtH9hlFF8CHyizD31mIV2R+DOM19BkSntVVaLlOFXnJiX
         F2oA==
X-Forwarded-Encrypted: i=1; AJvYcCWPsvIpE2mLEjN5gulS6rmE/WYxZ8AK/TuRP0+uMMIJeHp82n5ev1OKKhZw5c4++4tKfNje37PfTkNlXi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLnJa/zTN+QoPG0yvTdk1XQz5FL3V9XBQKHPnkeVA/Felw5ENI
	F2yuxdrEU+Ld2MppaRoVN9LghUa6mkoCViPPW+q6nplXW0+oQVOVGiK1HQ1HaA==
X-Google-Smtp-Source: AGHT+IFNQ0p46pnP6bxX/WTrVF/mvF4EBfHhnSN4CI+EuUQ20mscDwAHHXkGESoFnpmkjNh2iN6wIQ==
X-Received: by 2002:a05:6e02:1ca4:b0:39b:b1f:5be1 with SMTP id e9e14a558f8ab-39c3140c826mr3120085ab.1.1723407978557;
        Sun, 11 Aug 2024 13:26:18 -0700 (PDT)
Received: from [2620:0:1008:15:49ba:9fa:21c6:8a73] ([2620:0:1008:15:49ba:9fa:21c6:8a73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe04bd8sm2895240a12.19.2024.08.11.13.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 13:26:17 -0700 (PDT)
Date: Sun, 11 Aug 2024 13:26:17 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
    hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
    muchun.song@linux.dev, nphamcs@gmail.com, rppt@kernel.org, 
    souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
    dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
    david@redhat.com, yosryahmed@google.com
Subject: Re: [PATCH v5 3/3] mm: don't account memmap per-node
In-Reply-To: <20240809191020.1142142-4-pasha.tatashin@soleen.com>
Message-ID: <d28059a0-25af-6d0c-3f6d-7e7bc208a0da@google.com>
References: <20240809191020.1142142-1-pasha.tatashin@soleen.com> <20240809191020.1142142-4-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Aug 2024, Pasha Tatashin wrote:

> Fix invalid access to pgdat during hot-remove operation:
> ndctl users reported a GPF when trying to destroy a namespace:
> $ ndctl destroy-namespace all -r all -f
>  Segmentation fault
>  dmesg:
>  Oops: general protection fault, probably for
>  non-canonical address 0xdffffc0000005650: 0000 [#1] PREEMPT SMP KASAN
>  PTI
>  KASAN: probably user-memory-access in range
>  [0x000000000002b280-0x000000000002b287]
>  CPU: 26 UID: 0 PID: 1868 Comm: ndctl Not tainted 6.11.0-rc1 #1
>  Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
>  2.20.1 09/13/2023
>  RIP: 0010:mod_node_page_state+0x2a/0x110
> 
> cxl-test users report a GPF when trying to unload the test module:
> $ modrpobe -r cxl-test
>  dmesg
>  BUG: unable to handle page fault for address: 0000000000004200
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>  CPU: 0 UID: 0 PID: 1076 Comm: modprobe Tainted: G O N 6.11.0-rc1 #197
>  Tainted: [O]=OOT_MODULE, [N]=TEST
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/15
>  RIP: 0010:mod_node_page_state+0x6/0x90
> 
> Currently, when memory is hot-plugged or hot-removed the accounting is
> done based on the assumption that memmap is allocated from the same node
> as the hot-plugged/hot-removed memory, which is not always the case.
> 
> In addition, there are challenges with keeping the node id of the memory
> that is being remove to the time when memmap accounting is actually
> performed: since this is done after remove_pfn_range_from_zone(), and
> also after remove_memory_block_devices(). Meaning that we cannot use
> pgdat nor walking though memblocks to get the nid.
> 
> Given all of that, account the memmap overhead system wide instead.
> 
> For this we are going to be using global atomic counters, but given that
> memmap size is rarely modified, and normally is only modified either
> during early boot when there is only one CPU, or under a hotplug global
> mutex lock, therefore there is no need for per-cpu optimizations.
> 
> Also, while we are here rename nr_memmap to nr_memmap_pages, and
> nr_memmap_boot to nr_memmap_boot_pages to be self explanatory that the
> units are in page count.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=CoJkgBGP_+sNu6-6=6v=_L-ZBZY0bVLD3wUWZQg@mail.gmail.com
> Reported-by: Alison Schofield <alison.schofield@intel.com>
> Closes: https://lore.kernel.org/linux-mm/Zq0tPd2h6alFz8XF@aschofie-mobl2/#t
> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>

