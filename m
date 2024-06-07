Return-Path: <linux-kernel+bounces-206462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A8B900A1D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81857289600
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CD819A2A8;
	Fri,  7 Jun 2024 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/4so7ck"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3607E194AC2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776870; cv=none; b=b8tiuZwbSZxIe8Uieko+GN8/YQte+AObJViRv8yMVOPQu5FFAjvqq9CqTpgJbkzqgiFh2kuGPAmn5GuPXfIIxGWs1oMMqDDVcRsFcRmOuNH8hHbiPDP/ld+bU2xaER9bHWXxa0VEzY0HYdEV4NMAj7ZGW5CrW/cfbZXHuxVTXOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776870; c=relaxed/simple;
	bh=pJ07az6GcOatd4pamv+fMw1u3exfxGhAmj31Mj6GTiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu+alC6MBYqNlpUENdOvsZOc1mtbqM0n3wh7BgJstHuAJu3fD3DCR+lwRTrwTe9bsU/5XCfWmWYiYQ0NHlAto2FTJgfAQOQP+thFExb7xJNZ+gUkxeIe13Ws63cw+PJN12GhIrNO53xZjRVBQGBDy3yzMBkDpcnPo2hP11ckG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/4so7ck; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f4603237e0so1462430b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717776868; x=1718381668; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZmv+QIj4qVktftXDjS1d3Nkl+uCdFMuajR2qDI1h+o=;
        b=I/4so7ckKUYResIMnbYu+J5Yez/eCHFmxdQG/haGjkDN0Bu3HL+QfVdU/efUYItfM6
         I90IOeKMYuoz7cFP+AbIj2NZyjbeDWtktiyemGYJBFOhnuCtcR+W3kh+IdxpGjgEF8/U
         QJDBjv3D33bM70kUDO190EZkcVt06TFVWHaKwz2eQV05aO9uW45YLAwlfur+sEhd6qxc
         j2LuAfCDSOCTMxrwqGzuUFQeJ0GE8DqXQ1s7lVQ3h5gEVpzyNBVYjkVm5irlcIWJ+FhR
         HrwuPRm/pnQCN2g583U73gaBbdXlN9PhUlqMltY3/BiYD4IQmBUgMzLYB8UlTThHHUqI
         ZMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776868; x=1718381668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZmv+QIj4qVktftXDjS1d3Nkl+uCdFMuajR2qDI1h+o=;
        b=vsE6nlqKRzNkC0O0rEhsDfC+G4PRdLXcyzHDyceiXQgCzEC+plDmdwvX76I9bdeZzj
         JIey3Jl1jqnnI5ThsIZuliOTOADUx5fiXATRvNk6tOkO06ucCDRxM3aUqX6BVpE3Of1U
         fNllXQEC6YS0qzh2ru+h7OYapyYblnC/DOOrQEMeXcH751Pya919t+E1n0xK4ju99mQb
         ts4tU6znt6+DRQGciGaeAToA3qBfuidh7oKdDu4c5OVq55jNzlf+Kxwk5j6neLaTJCIs
         8C2XmHSlo4MTUrmm2ynUlsavX0IemTKgROsMjZRIGEzjTEBW4Hq/vhqY96xgtVLVyjQI
         /w2A==
X-Forwarded-Encrypted: i=1; AJvYcCXFsI3qmrGkqS4J9EgKIkke1V5s1PMFIB3mSufc/Rm10mDmGW8nqaKPDHSz87liELPNWJIfUaW3nJJru/jzshVyL1Ermorn6HjDmJDj
X-Gm-Message-State: AOJu0YzXtm29ZyB+RbFlXGlBa6CnnnwCurgB48Mg5IuXP/uCLdJCRDhH
	R8apbBnM6XMSb7Q0GifitX4+v/4dlV7MtuY4YAH/XEGRDHdPK3ju
X-Google-Smtp-Source: AGHT+IGcbY/L1VLhL5JeOdeeuFfaV/TM4GOpeK4LrneaBGGHtXwUkFpcuqqFHZOSAgOT1iP2pHl50Q==
X-Received: by 2002:a05:6a20:244f:b0:1b2:cd79:f41b with SMTP id adf61e73a8af0-1b2e781a5b9mr4585109637.25.1717776868386;
        Fri, 07 Jun 2024 09:14:28 -0700 (PDT)
Received: from google.com ([2620:0:1000:8411:1225:d298:7d81:144c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fde38722sm2700932b3a.215.2024.06.07.09.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:14:27 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Fri, 7 Jun 2024 09:14:25 -0700
From: Minchan Kim <minchan@kernel.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Christoph Lameter <cl@linux.com>,
	Erhard Furtner <erhard_f@mailbox.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] mm: zsmalloc: share slab caches for all zsmalloc zpools
Message-ID: <ZmMx4f1V9lBlctiw@google.com>
References: <20240604175340.218175-1-yosryahmed@google.com>
 <ZmI573n9-SoK4dIg@google.com>
 <CAJD7tkbO+ZLdhs-9BpthztZX32i8C4=QEnoiXGS7bM399nqwzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbO+ZLdhs-9BpthztZX32i8C4=QEnoiXGS7bM399nqwzg@mail.gmail.com>

On Thu, Jun 06, 2024 at 04:03:55PM -0700, Yosry Ahmed wrote:
> On Thu, Jun 6, 2024 at 3:36 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Tue, Jun 04, 2024 at 05:53:40PM +0000, Yosry Ahmed wrote:
> > > Zswap creates multiple zpools to improve concurrency. Each zsmalloc
> > > zpool creates its own 'zs_handle' and 'zspage' slab caches. Currently we
> > > end up with 32 slab caches of each type.
> > >
> > > Since each slab cache holds some free objects, we end up with a lot of
> > > free objects distributed among the separate zpool caches. Slab caches
> > > are designed to handle concurrent allocations by using percpu
> > > structures, so having a single instance of each cache should be enough,
> > > and avoids wasting more memory than needed due to fragmentation.
> > >
> > > Additionally, having more slab caches than needed unnecessarily slows
> > > down code paths that iterate slab_caches.
> > >
> > > In the results reported by Eric in [1], the amount of unused slab memory
> > > in these caches goes down from 242808 bytes to 29216 bytes (-88%). This
> > > is calculated by (num_objs - active_objs) * objsize for each 'zs_handle'
> > > and 'zspage' cache. Although this patch did not help with the allocation
> > > failure reported by Eric with zswap + zsmalloc, I think it is still
> > > worth merging on its own.
> > >
> > > [1]https://lore.kernel.org/lkml/20240604134458.3ae4396a@yea/
> >
> > I doubt this is the right direction.
> >
> > Zsmalloc is used for various purposes, each with different object
> > lifecycles. For example, swap operations relatively involve short-lived
> > objects, while filesystem use cases might have longer-lived objects.
> > This mix of lifecycles could lead to fragmentation with this approach.
> 
> Even in a swapfile, some objects can be short-lived and some objects
> can be long-lived, and the line between swap and file systems both
> becomes blurry with shmem/tmpfs. I don't think having separate caches


Many allocators differentiate object lifecycles to minimize
fragmentation. While this isn't a new concept, you argue it's irrelevant
without a clearcut use case.

> here is vital, but I am not generally familiar with the file system
> use cases and I don't have data to prove/disprove it.

The use case I had in mind was build output directories (e.g., Android).
These consume object files in zram until the next build.

Other potential scenarios involve separate zrams: one for foreground
apps (short-term) and another for cached apps (long-term). Even
zswap and zram could have different object lifecycles, as zswap might
write back more aggressively.

While you see no clear use cases, I disagree with dismissing this
concept without strong justification.

> 
> >
> > I believe the original problem arose when zsmalloc reduced its lock
> > granularity from the class level to a global level. And then, Zswap went
> > to mitigate the issue with multiple zpools, but it's essentially another
> > bandaid on top of the existing problem, IMO.
> 
> IIRC we reduced the granularity when we added writeback support to
> zsmalloc, which was relatively recent. I think we have seen lock
> contention with zsmalloc long before that. We have had a similar patch
> internally to use multiple zpools in zswap for many years now.
> 
> +Yu Zhao
> 
> Yu has more historical context about this, I am hoping he will shed
> more light about this.
> 
> >
> > The correct approach would be to further reduce the zsmalloc lock
> > granularity.
> 
> I definitely agree that the correct approach should be to fix the lock
> contention at the source and drop zswap's usage of multiple zpools.
> Nonetheless, I think this patch provides value in the meantime. The
> fragmentation within the slab caches is real with zswap's use case.
> OTOH, sharing a cache between swap and file system use cases leading
> to fragmentation within the same slab cache is a less severe problem
> in my opinion.
> 
> That being said, I don't feel strongly. If you really don't like this
> patch I am fine with dropping it.

How about introducing a flag like "bool slab_merge" in zs_create_pool?
This would allow zswap to unify slabs while others don't.

