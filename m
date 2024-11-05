Return-Path: <linux-kernel+bounces-395790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0E49BC308
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167721C217E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2893B784;
	Tue,  5 Nov 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFa3V/7u"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A67B1CD0C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772787; cv=none; b=TiRt1ziAE7EwP89qOijAXm7MIA2ziv6Cx1lqNW+BVL4Al9sJmP4Amed6eSHiE9REEne9lr70jsMSJtagplj3/AmUN0/jLMfBcdt/EKD360F74UmGbCWFHalujeMXalx3Y0dGCG3RqWK+apHuXML+n0JwDd1toevYlx+a4lOK6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772787; c=relaxed/simple;
	bh=N9PPYC0zoyQN5L7nheU0SNbV/+LtCnKYYYX0LJ3VkF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6RSwHkvMlejjWWvKdq1zq+fAeowC8tl9IwTvttup+Oe5AUxkJKiVpUKPAk5hdFE4ql/Gk2KxhRKUPxE1e1PD112na5DOhXAlL28G1OrpDhLv7EIdFJAbXTSd3m30tlOUsJlo++MsWFcu41UKbZtMdOamKT5KgibNhCyELZhdgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFa3V/7u; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-210e5369b7dso49034455ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 18:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730772785; x=1731377585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BbonWoEkQjUXoeGhS5FNHSGOgCb+0Y1PGWMA7bjkDco=;
        b=CFa3V/7uKlSC4LXwFw1v3j0XzI0WqawQf8iWOC5ooyqrYHBeMYusYpQ3DxrwZxK0zz
         faT7o8/Uzw/URZdYG1SNI5oI0mwm0rDyX4Cwh7s9y93g2QwovpGAHAoL+IbZah1Xlj6b
         hyUICMDJzSCTk8krIeblYSerBV0eQbseihp5n2r7rzuUW+UQEX2+VJ9cX7BLhC7jPo2w
         U33CL7a7JgTQl/kgYUKDE/+3epxZdk4yOeigINzwBjCEZm+mENvXosRu/RXJtmor7mVc
         kY/Bk/4DKbfXlMzMeG9sb7+ELnbsO71lUNOFGs3tlAoBv618UKe+Lb/0Nn/4lVT+Bnv7
         csJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730772785; x=1731377585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbonWoEkQjUXoeGhS5FNHSGOgCb+0Y1PGWMA7bjkDco=;
        b=RXZa+3Cf1KHm0KroqMycRoBNPDZ9C4b1KiDSTTPsg9xItWgRZ+WcoKfnhjRcXjUvrN
         2qA7wNgx/LsloPJyhqYsVqHtk9gPRhkFRTwp7sc15TfRJfm7NOJsgeKcZ7iXUiO1sOgZ
         CzKIJVkxi6aSjcBKOT6p+1XMbJ+VQCvMzwTpqNUuzZb717sKPZ8Jf12njdpuTmHl2gmW
         UPf/hHZMZQZy2pSmOdp+3N/S9/uLkbyOgBWk2LEZ+p6JWhTeUQtIC16+998FVtSdkxX5
         cDwwgVbv90HJQp9QpPyl1n66e0aO8ZtrBZkC5J5kv6zuyUL5JhPXgdkGRgWEDxLCK5YL
         0t7w==
X-Forwarded-Encrypted: i=1; AJvYcCUqoa++C08pAxd1VyMiMXkK8JRdI8Hu/JKiGvUjBiX+7Kqq3s8LboP4Rj5hX9RWM0O5GOBAJvWXgrzyKHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1B2/tmehFQJ0yTjZKRfJ0h1bkt0MqAAOV6NnsoTf6Yyov8I7I
	HzmTNNemwhOr7ga/WnfD9YxRH+3iGZ4gMUKCx53cWJqxH7vpEzVZ
X-Google-Smtp-Source: AGHT+IF7/LGADLtt0xNUhHFZnoBiiDBZukIxqLtPrSpxBH/qGwD1pj0Dt/AcM8Ofd1m1im4WtWPTYA==
X-Received: by 2002:a17:902:e741:b0:20b:9c8c:e9f3 with SMTP id d9443c01a7336-2111af2ec06mr202034095ad.14.1730772785405;
        Mon, 04 Nov 2024 18:13:05 -0800 (PST)
Received: from z790sl ([240f:74:7be:1:54ee:9253:695b:4125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ee3d8sm67800515ad.20.2024.11.04.18.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 18:13:04 -0800 (PST)
Date: Tue, 5 Nov 2024 11:13:00 +0900
From: Koichiro Den <koichiro.den@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>, Kees Cook <kees@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev, 
	42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: fix warning caused by duplicate kmem_cache
 creation in kmem_buckets_create
Message-ID: <6hnhjpvy5ctblzdikw4njmawf5zdtt4ipxdshzqssv7mp55ypn@spekzsjorj4w>
References: <20241104150837.2756047-1-koichiro.den@gmail.com>
 <9e6fd342-ef7f-4648-afa3-bf704c87bf8f@suse.cz>
 <202411041330.7A0F716E5@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202411041330.7A0F716E5@keescook>

On Mon, Nov 04, 2024 at 01:32:25PM -0800, Kees Cook wrote:
> On Mon, Nov 04, 2024 at 04:40:12PM +0100, Vlastimil Babka wrote:
> > On 11/4/24 16:08, Koichiro Den wrote:
> > > Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
> > > if DMA bouncing possible") reduced ARCH_KMALLOC_MINALIGN to 8 on arm64.
> > > However, with KASAN_HW_TAGS enabled, arch_slab_minalign() becomes 16.
> > > This causes kmalloc_caches[*][8] to be aliased to kmalloc_caches[*][16],
> > > resulting in kmem_buckets_create() attempting to create a kmem_cache for
> > > size 16 twice. This duplication triggers warnings on boot:
> > > 
> > > [    2.325108] ------------[ cut here ]------------
> > > [    2.325135] kmem_cache of name 'memdup_user-16' already exists
> > > [    2.325783] WARNING: CPU: 0 PID: 1 at mm/slab_common.c:107 __kmem_cache_create_args+0xb8/0x3b0
> > > [    2.327957] Modules linked in:
> > > [    2.328550] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc5mm-unstable-arm64+ #12
> > > [    2.328683] Hardware name: QEMU QEMU Virtual Machine, BIOS 2024.02-2 03/11/2024
> > > [    2.328790] pstate: 61000009 (nZCv daif -PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> > > [    2.328911] pc : __kmem_cache_create_args+0xb8/0x3b0
> > > [    2.328930] lr : __kmem_cache_create_args+0xb8/0x3b0
> > > [    2.328942] sp : ffff800083d6fc50
> > > [    2.328961] x29: ffff800083d6fc50 x28: f2ff0000c1674410 x27: ffff8000820b0598
> > > [    2.329061] x26: 000000007fffffff x25: 0000000000000010 x24: 0000000000002000
> > > [    2.329101] x23: ffff800083d6fce8 x22: ffff8000832222e8 x21: ffff800083222388
> > > [    2.329118] x20: f2ff0000c1674410 x19: f5ff0000c16364c0 x18: ffff800083d80030
> > > [    2.329135] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > > [    2.329152] x14: 0000000000000000 x13: 0a73747369786520 x12: 79646165726c6120
> > > [    2.329169] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 0000000000000000
> > > [    2.329194] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > > [    2.329210] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > > [    2.329226] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> > > [    2.329291] Call trace:
> > > [    2.329407]  __kmem_cache_create_args+0xb8/0x3b0
> > > [    2.329499]  kmem_buckets_create+0xfc/0x320
> > > [    2.329526]  init_user_buckets+0x34/0x78
> > > [    2.329540]  do_one_initcall+0x64/0x3c8
> > > [    2.329550]  kernel_init_freeable+0x26c/0x578
> > > [    2.329562]  kernel_init+0x3c/0x258
> > > [    2.329574]  ret_from_fork+0x10/0x20
> > > [    2.329698] ---[ end trace 0000000000000000 ]---
> > > 
> > > [    2.403704] ------------[ cut here ]------------
> > > [    2.404716] kmem_cache of name 'msg_msg-16' already exists
> > > [    2.404801] WARNING: CPU: 2 PID: 1 at mm/slab_common.c:107 __kmem_cache_create_args+0xb8/0x3b0
> > > [    2.404842] Modules linked in:
> > > [    2.404971] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.0-rc5mm-unstable-arm64+ #12
> > > [    2.405026] Tainted: [W]=WARN
> > > [    2.405043] Hardware name: QEMU QEMU Virtual Machine, BIOS 2024.02-2 03/11/2024
> > > [    2.405057] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [    2.405079] pc : __kmem_cache_create_args+0xb8/0x3b0
> > > [    2.405100] lr : __kmem_cache_create_args+0xb8/0x3b0
> > > [    2.405111] sp : ffff800083d6fc50
> > > [    2.405115] x29: ffff800083d6fc50 x28: fbff0000c1674410 x27: ffff8000820b0598
> > > [    2.405135] x26: 000000000000ffd0 x25: 0000000000000010 x24: 0000000000006000
> > > [    2.405153] x23: ffff800083d6fce8 x22: ffff8000832222e8 x21: ffff800083222388
> > > [    2.405169] x20: fbff0000c1674410 x19: fdff0000c163d6c0 x18: ffff800083d80030
> > > [    2.405185] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > > [    2.405201] x14: 0000000000000000 x13: 0a73747369786520 x12: 79646165726c6120
> > > [    2.405217] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 0000000000000000
> > > [    2.405233] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > > [    2.405248] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > > [    2.405271] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> > > [    2.405287] Call trace:
> > > [    2.405293]  __kmem_cache_create_args+0xb8/0x3b0
> > > [    2.405305]  kmem_buckets_create+0xfc/0x320
> > > [    2.405315]  init_msg_buckets+0x34/0x78
> > > [    2.405326]  do_one_initcall+0x64/0x3c8
> > > [    2.405337]  kernel_init_freeable+0x26c/0x578
> > > [    2.405348]  kernel_init+0x3c/0x258
> > > [    2.405360]  ret_from_fork+0x10/0x20
> > > [    2.405370] ---[ end trace 0000000000000000 ]---
> > > 
> > > To address this, alias kmem_cache for sizes smaller than min alignment
> > > to the aligned sized kmem_cache, as done with the default system kmalloc
> > > bucket.
> > > 
> > > Cc: <stable@vger.kernel.org> # 6.11.x
> > > Fixes: b32801d1255b ("mm/slab: Introduce kmem_buckets_create() and family")
> > > Signed-off-by: Koichiro Den <koichiro.den@gmail.com>
> > > ---
> > 
> > Thanks for catching this.
> > Wonder if we could make this a lot simpler in kmem_buckets_create() by
> > starting with the current:
> > 
> > size = kmalloc_caches[KMALLOC_NORMAL][idx]->object_size;
> > 
> > and adding:
> > 
> > aligned_idx = __kmalloc_index(size, false);
> > 
> > now the rest of the loop iteration would work with aligned_idx and if it
> > differs from idx, we assign the cache pointer also to idx, etc.
> > 
> > This should avoid duplicating the alignment calculation as we just extract
> > from kmalloc_caches[] the result of what new_kmalloc_cache() already did?
> 
> Yeah, I was thinking similar stuff -- the aligned stuff is the alias for
> the actual stuff.
> 
> I like the bitmask for tracking the aliases. :)

Thanks for reviewing, Vlastimil and Kees. It sounds reasonable, I'll
send v2 soon.

> 
> -- 
> Kees Cook

