Return-Path: <linux-kernel+bounces-219948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC2390DA9D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A321F23271
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736C413E021;
	Tue, 18 Jun 2024 17:27:19 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB52139DD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731639; cv=none; b=FAMQMpKLwZmIHdKZWIw96+f7rtK9AVMXlNWvpjkEvs3xcHTFX9n0YT0Qy8BtVTpSnpD8kRfO0Pqz3xlgevAo7Q1kGdzYv2ptu3uOc80Gr57IBWoRX0D80URMNaGUYdH+kq6y4mwcYDIryZ95ZmB+hQwglWJyJwWSwKWyU/lsniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731639; c=relaxed/simple;
	bh=8HEh2eyL5BOMLEiQRw7cMUqNTFe17lj0Z/QTnMAyQBE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QJZyDBs4Yvn6M7Di/0HI/RkNRpPRxHoVQx3YedGsvTzCHiYtQ39jEQSiwegk1yH8ELIgniM8NpXmQX8P20YzqhtzkzJL5Od+6wK5to+uZDBR6HNRIqgDC83Vrm3KufSy3DXJlyvCosnQ8JKAu5SZYvqQlPVEs79/AfNQNX3Q36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 2DCE740B10; Tue, 18 Jun 2024 09:57:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 2C9A8401CA;
	Tue, 18 Jun 2024 09:57:07 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:57:07 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Chengming Zhou <chengming.zhou@linux.dev>
cc: Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
    David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    zhouchengming@bytedance.com, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 1/3] slab: make check_object() more consistent
In-Reply-To: <e655405f-92b2-46e4-830e-013586bd0022@linux.dev>
Message-ID: <a98b715d-011b-ce39-0872-2772fc619b7e@linux.com>
References: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev> <20240607-b4-slab-debug-v3-1-bb2a326c4ceb@linux.dev> <63da08b7-7aa3-3fad-55e6-9fc3928a49de@gentwo.org> <8b844d71-01f1-472b-a63a-4c9cdb26e9ef@suse.cz> <e93fc5a6-434f-376c-a819-353124da053d@linux.com>
 <e655405f-92b2-46e4-830e-013586bd0022@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 Jun 2024, Chengming Zhou wrote:

>> One can then put a slub_debug option on the kernel command line which 
>> will result in detailed error reports on what caused the corruption. It 
>> will also activate resilience measures that will often allow the 
>> continued operation until a fix becomes available.
>
> This reminds me that we can't toggle slub_debug options for kmem_cache in runtime,
> I'm wondering is it useful to be able to enable/disable debug options in runtime?
> We can implement this feature by using per-slab debug options, so per-slab has
> independent execution path, in which some slabs with debug options enabled go
> the slow path, while others can still go fast path.
>
> No sure if it's useful in some cases? Maybe KFENCE is enough? Just my random thoughts.

The problem is that some of these options would change the total size of 
the data stored in a slab. Features that do not require size changes can 
be done at runtime on slab caches.


