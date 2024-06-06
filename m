Return-Path: <linux-kernel+bounces-203623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA148FDE37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD08F1C23A7A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1843AC36;
	Thu,  6 Jun 2024 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xe81ExtG"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BDF12E5D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 05:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717652621; cv=none; b=RHWxkyc40B2jsuYu1nXzQKWttoyCRUFf7sHKIipl4ZbLbFfi+ceFr+nJPMeYg2ET8EWc7wqyWN6QMVwJ06qTYLyyOl3yNcTRkDE0AXi2EH+ySUltQSlcB/j7VDwZLYHtiU8vmDt8uyGQT5UaDHNX4M89l8Tk7oAN2101p3TJZ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717652621; c=relaxed/simple;
	bh=D0UBVmB/Wisia8yB+Ax4EGrr3xyjgE6JG3BGUTVTR9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnIDLjediwYZ0OJXmV2pKf/g+Ax9357RCrbxp0T/eTgan5CRrfGpO/JZtkk+kcb6trZHttFjym+jOgskwEUP5AQaFL7JZvSCBazCAceGzHSkHYbLi9kRwkWyhNNiMkgAN+B8/HjwRA1ObweXLA0pL4JMv35jqolY5VIeyuYHOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xe81ExtG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7024426c75dso535065b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 22:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717652619; x=1718257419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9evaiRpo0K0MKjvHd6Fu6tPQEBbm84cbZFPUlgH+U/c=;
        b=Xe81ExtGsK4QrCrK1tzjD29XR8l4ve5qlJcrQenS6hKpBkILbKilLSrg0+T8O1YTpL
         RLVOJ90uooKtbgYgYi5aDy8wIOrvKLD5XVMOpiYdOUlGOoL3QCLGF1oWMihOwPviWMbs
         KTwrHuZUDIk4QzM3zBiyvVBDzQ/7O0/kCX784=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717652619; x=1718257419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9evaiRpo0K0MKjvHd6Fu6tPQEBbm84cbZFPUlgH+U/c=;
        b=n+/RJSC5Tcmk4Uu+aGcmAjoXtFBziuVNleecFZmq16K72GFN6nRlxBqdJqbZvVMhXt
         3sfT1D8oYPLusUPgMXqLeJgfh8DDJNjdQfu557ElOZuPum5+kEaoTKwrFc5JeohC6grn
         Tk/iwWwzVxXoJ+6j3LjRkVJl3IrJLii3CMXrAvMKuEL2NDZ8AHILdFRC9ckJmbjuVcBK
         2oDPO44UuoF4zW5c0+GC3iqbADtbQJtNw6tpFgyfdwdNTu1lGNdopMoBswJKQ4GJw74h
         75xwsJw+DgFb685Bhzlqth/G95Sf4K/cMHxTh1u1z/C7EqJ4X6dc9UvCraqat1ljUMNj
         itKw==
X-Forwarded-Encrypted: i=1; AJvYcCW+4Kf00Ruj+KFc+ETzz0V5so1R8BTPF/lMt+Z4xJzT2YObhxa69ozijQRTDsM5UBZ1ZkPmHMxp3TBimqWKjH6MJz1ZrAmjFQiUTGt8
X-Gm-Message-State: AOJu0YxipN0kUuWZjmg86a4ru6kYz1pmTQXxmi9jB79bxbgjzNGfUgw0
	lu5uNvKZPZkKqx1KrKC9lIhPB9h7/c+oB8G0TBrPLXaPJf2AMe3ZhulXpZ9vVw==
X-Google-Smtp-Source: AGHT+IFy7hjyNVNxBD93ScL0gjQe1sK4zEeKhq1Mmbs2AmOIwNZ2Z1Ekq4heMJmewPkxaRSXKcuUxw==
X-Received: by 2002:a05:6a20:430f:b0:1af:dae8:5ea2 with SMTP id adf61e73a8af0-1b2b710b40fmr5480556637.48.1717652619298;
        Wed, 05 Jun 2024 22:43:39 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:22f8:8e4a:7027:de56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7f28adsm5220295ad.265.2024.06.05.22.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 22:43:38 -0700 (PDT)
Date: Thu, 6 Jun 2024 14:43:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Erhard Furtner <erhard_f@mailbox.org>, Yu Zhao <yuzhao@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>, Minchan Kim <minchan@kernel.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: kswapd0: page allocation failure: order:0,
 mode:0x820(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0 (Kernel
 v6.5.9, 32bit ppc)
Message-ID: <20240606054334.GD11718@google.com>
References: <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea>
 <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea>
 <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
 <e68bcc6a-25b1-42aa-83b3-5d457b254cbe@linux.dev>
 <20240606043156.GC11718@google.com>
 <6335c05d-9493-4b03-85a7-f2dd91db9451@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6335c05d-9493-4b03-85a7-f2dd91db9451@linux.dev>

On (24/06/06 12:46), Chengming Zhou wrote:
> >> Agree, I think we should try to improve locking scalability of zsmalloc.
> >> I have some thoughts to share, no code or test data yet:
> >>
> >> 1. First, we can change the pool global lock to per-class lock, which
> >>    is more fine-grained.
> > 
> > Commit c0547d0b6a4b6 "zsmalloc: consolidate zs_pool's migrate_lock
> > and size_class's locks" [1] claimed no significant difference
> > between class->lock and pool->lock.
> 
> Ok, I haven't looked into the history much, that seems preparation of trying
> to introduce reclaim in the zsmalloc? Not sure. But now with the reclaim code
> in zsmalloc has gone, should we change back to the per-class lock? Which is

Well, the point that commit made was that Nhat (and Johannes?) were
unable to detect any impact of pool->lock on a variety of cases.  So
we went on with code simplification.

> obviously more fine-grained than the pool lock. Actually, I have just done it,
> will test to get some data later.

Thanks, we'll need data on this.  I'm happy to take the patch, but
jumping back and forth between class->lock and pool->lock merely
"for obvious reasons" is not what I'm extremely excited about.

