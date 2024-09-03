Return-Path: <linux-kernel+bounces-312037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F260596911B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43259B226B1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39A1CCEDD;
	Tue,  3 Sep 2024 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1FPn8WrK"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A701581F8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725328400; cv=none; b=CxJtMlHRj45fCabxpICflkdS9+byuy0Dx7hVaG8VN87lGLbqNZgyFT+xNgoIEbp+TyY8FW7s18LvssKXDqYzkkrApp4yUUrVZlaa7w2dpuMIDXojyC//ugyaThuT2YNCeBWL3YaLGz4n02yhmkZSPY9FOgp+TtqZjUEltgK0z5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725328400; c=relaxed/simple;
	bh=fkxm6iC7ztmIiMJhRW39ZHvuvClsWNEbzax9c3tQp0c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M98qqqg1eMBeBpM0eORt3fHzSG5o52icw4itNy1k0mKvmINjLL8Gik1nS/eR6BCogsTrAccpJ0tjVSo7ih85O5jbw4aQeWQqHFN07lacXt/DJCLflPZMQk+mxV5E7R64IoVdKHlPtVI93FYRYfWifnz31GihrRArNlf3kaXYFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1FPn8WrK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2056aa5cefcso302795ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 18:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725328398; x=1725933198; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa5rtkcqTKo2zYhIyQDpkUbrotmaYMsM7bl9Xg4sY14=;
        b=1FPn8WrKi2zgVP3IhRbo441gf7nD9OQCVWoTWr8s0mN95pgBN/+fnjXOajqrER/DUV
         YYN6SHwVi0KFOXbMhPGpqWN8QzQgbjr9CftuykmICpcsKUrxB3wPvFjo4EjksNpBZkZs
         ZF627kkVpcz9+zw1zK717UCBEtInzhL4+24mRJkjeyC4RqZfN1GAJBvxv1WuOXZVbbm8
         f0V2I5hthcl38nYUbtp8AhIaD8G5b8QrX0mSj+rYARfDwllFzm48u+4Q7J0QixKnViUC
         /vCzwX4c2AoX5yrBNhFlUQ/RFHk0hMJM53uqfm0Fr3oYK87B/QUO6x9KBntIZuTTljDn
         VQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725328398; x=1725933198;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa5rtkcqTKo2zYhIyQDpkUbrotmaYMsM7bl9Xg4sY14=;
        b=H9R/uikTBWsyR9GraAby42lcfm+dZ7OvkoqH0DWiHT6uDtR6hGM0ToguhcEkpF71To
         62POQRV1TgP9hEWdRItt/24EY+LdxeWkOh0Kcre/WimTNABN+rTqPuOv5DHMHJD0psCR
         K5HIuq/QPk4BxS7aLjqXdQUtF1nwnJcFxbH5zp6NcZSixwrRLq7EvH9mEiyKfWugaWfN
         wn2kapyGTFSX6bZz6KyEECaFXzfzvWcz1LBYnk7Uq4S29kSAiMkmKfF5xVSxQbO22bP8
         p/Df+gJhRRb/8jdx5ionV2QXYUNx5OaglFsgdH1lj7ZqDYEcl4pONR1Nf5VViwWeu62M
         8svg==
X-Forwarded-Encrypted: i=1; AJvYcCVhKYyzDKI8qBqmSi10pnGFzReuq/tu6/FKgXhkCVvAQxGNTqnPAiML3OMoB4wYf5Gunc/zOkwDsGZSdD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqlWBvcd2lZFRrl02Ipk5sIwQGYJZI+O0yPF3doNg2QGjqRN5
	O6MZibi0gu/ir26fFhnXBXao9V/ZM+R6onbiuc0XPSG+flsCsW7lhU7A8QcRTA==
X-Google-Smtp-Source: AGHT+IGDQJviICqG8bzc9DeFAVvSmJK6ShP9hGVeUCTgS+t0sDI+6Q3vyH4V+VJA5A7u6K8sZJldmg==
X-Received: by 2002:a17:902:c947:b0:1fd:8c42:61ce with SMTP id d9443c01a7336-20549b895b1mr5165455ad.27.1725328398008;
        Mon, 02 Sep 2024 18:53:18 -0700 (PDT)
Received: from [2620:0:1008:15:69a5:b87c:3c08:3343] ([2620:0:1008:15:69a5:b87c:3c08:3343])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d6ecasm7679373b3a.142.2024.09.02.18.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 18:53:17 -0700 (PDT)
Date: Mon, 2 Sep 2024 18:53:16 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>, 
    "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>, 
    open list <linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] mm, slub: avoid zeroing kmalloc redzone
In-Reply-To: <20240829032911.2801669-1-peng.fan@oss.nxp.com>
Message-ID: <889f1f51-4c57-6833-ab79-bcc9674c3e76@google.com>
References: <20240829032911.2801669-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 Aug 2024, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> Since commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra
> allocated kmalloc space than requested"), setting orig_size treats
> the wasted space (object_size - orig_size) as a redzone. However with
> init_on_free=1 we clear the full object->size, including the redzone.
> 
> Additionally we clear the object metadata, including the stored orig_size,
> making it zero, which makes check_object() treat the whole object as a
> redzone.
> 
> These issues lead to the following BUG report with "slub_debug=FUZ
> init_on_free=1":
> 
> [    0.000000] =============================================================================
> [    0.000000] BUG kmalloc-8 (Not tainted): kmalloc Redzone overwritten
> [    0.000000] -----------------------------------------------------------------------------
> [    0.000000]
> [    0.000000] 0xffff000010032858-0xffff00001003285f @offset=2136. First byte 0x0 instead of 0xcc
> [    0.000000] FIX kmalloc-8: Restoring kmalloc Redzone 0xffff000010032858-0xffff00001003285f=0xcc
> [    0.000000] Slab 0xfffffdffc0400c80 objects=36 used=23 fp=0xffff000010032a18 flags=0x3fffe0000000200(workingset|node=0|zone=0|lastcpupid=0x1ffff)
> [    0.000000] Object 0xffff000010032858 @offset=2136 fp=0xffff0000100328c8
> [    0.000000]
> [    0.000000] Redzone  ffff000010032850: cc cc cc cc cc cc cc cc                          ........
> [    0.000000] Object   ffff000010032858: cc cc cc cc cc cc cc cc                          ........
> [    0.000000] Redzone  ffff000010032860: cc cc cc cc cc cc cc cc                          ........
> [    0.000000] Padding  ffff0000100328b4: 00 00 00 00 00 00 00 00 00 00 00 00              ............
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc3-next-20240814-00004-g61844c55c3f4 #144
> [    0.000000] Hardware name: NXP i.MX95 19X19 board (DT)
> [    0.000000] Call trace:
> [    0.000000]  dump_backtrace+0x90/0xe8
> [    0.000000]  show_stack+0x18/0x24
> [    0.000000]  dump_stack_lvl+0x74/0x8c
> [    0.000000]  dump_stack+0x18/0x24
> [    0.000000]  print_trailer+0x150/0x218
> [    0.000000]  check_object+0xe4/0x454
> [    0.000000]  free_to_partial_list+0x2f8/0x5ec
> 
> To address the issue, use orig_size to clear the used area. And restore
> the value of orig_size after clear the remaining area.
> 
> When CONFIG_SLUB_DEBUG not defined, (get_orig_size()' directly returns
> s->object_size. So when using memset to init the area, the size can simply
> be orig_size, as orig_size returns object_size when CONFIG_SLUB_DEBUG not
> enabled. And orig_size can never be bigger than object_size.
> 
> Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated kmalloc space than requested")
> Reviewed-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: David Rientjes <rientjes@google.com>

