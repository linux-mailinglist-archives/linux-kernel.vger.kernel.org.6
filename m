Return-Path: <linux-kernel+bounces-309158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E769666DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D511282BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94891B3B15;
	Fri, 30 Aug 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYlRZfb6"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D513BAE2
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035214; cv=none; b=Hc8jWnWSFP69HiF18CiBD1vNThKT7Su9b6qAl3K6xcSRae++ZLFDC96bT83WoqFp8MOYvY+Jl57dEcq1VdC0WnKtC2gXhQjhweEYSJkSJ9CEk0Msyup3HHO7fiQHpJhbUhDoX/fmIqK+AGsyRxV5+VzTpM+SFO40NaVG+XpcFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035214; c=relaxed/simple;
	bh=WGyJaCLW8TbJcGflEYvOKuFfc+oAbe03ijD6DWrw1A0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqfVSluepVHaEZdQgvzpO4mKCZm4+2HqT/cDjbjNKANV3Y1dXBzWPCXXkgHnOXBqQg9hKzWATrfbb1ZTONgXcKObJ7mMjtB0q7GSj9lYYzzFQEYSDQdssmF1qkx4955/oC3z70xQkFoRIrAd/px9S75yw2YGVribyUkJNKKXY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYlRZfb6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f401c20b56so26464591fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725035211; x=1725640011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MjdIvVpE9p/+QONCePZXMAOpmCzdJZMhKHA48QmkhTo=;
        b=dYlRZfb6E9NBk88PpNPoM1/jmidcAwMdhI6i0xrnGbN6swpTBlxfwLObP72az0jH4g
         lILg/gWVS092OC2S8Y8JrhWul00hPEfz3NzXfhVa5BVY4EObe+EdpNvzZ2OlJDgCQlAj
         Z/Q/K0SeHAk2AljdUaRYbnjY/OqIzjCxOxRrk7vhJ/l0H8Gpuc+TluU2WnHbtEwlsymp
         X0RK+kvMi6urhv7WCpN+pT3phnkoHpOTr2VciShBW1f9iytH4/Iz+Hr1G1DA2aKEklMm
         AEfbrnXd5/Hpfp1K0I6Ka0UFI4tib2xFNj3UCa/omdkY/o6sNLJU3+pgJ+tmE0gnV+KS
         VPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725035211; x=1725640011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjdIvVpE9p/+QONCePZXMAOpmCzdJZMhKHA48QmkhTo=;
        b=jfWFiZinhjRS68vT+V1gbgdsniGcjqpf/d2P533emxjjgJqYIH4643pIecSPI6Zcz0
         jBZFPNL5enW6eT6n12WX2yPFfjydouI8WfwTBLbDGRdh8jq57q0oaOdaqvIYiI7110Dn
         6r3Y8cF/53BVFoV5vm7pWAXJJcCvmiVOjWz4VqCgeDO/O1ghZAnaJQBXW15r0i+unPfC
         7pR8OVN+uTszpalbNvwT61aGMhEY2zys5yge+TQL/X1GJWOxqtkH7y8zLQ4PzrSJ62pZ
         PheirDHIjJnf8786+kC6hSDgJjQQYLMEhzsy4ViUmtf/FbmncBC79AV0tUvvnC80lzq7
         7B0w==
X-Forwarded-Encrypted: i=1; AJvYcCUEZ8Dy+QbXgNYdJoaWin1vpc6KK8+QKaCJG+YoyKax817IbhI7sz4NO0w5A5v9qRVGEFCJuWtFdzHLGHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjSoiu2dl0SKlo23QCnEnP7KPBuEG+qL6qYKMLScNvNv5EW1vB
	XiLH6XsHE7Xh1syiH5zZqSsQgCKiV3UI8MsvDXkKYn4ullApa0+A
X-Google-Smtp-Source: AGHT+IEcEIz7ZNdDlyBVNUrIYU+O0lhmgPte1yqOLDz+hPu9aN2cML+Lk4mgHz8LTQZcNgLlk+cFww==
X-Received: by 2002:a05:651c:198a:b0:2ef:2bea:69a with SMTP id 38308e7fff4ca-2f61e040552mr11665721fa.2.1725035209762;
        Fri, 30 Aug 2024 09:26:49 -0700 (PDT)
Received: from pc636 (host-90-233-206-146.mobileonline.telia.com. [90.233.206.146])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614f23a93sm7345121fa.51.2024.08.30.09.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 09:26:49 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 30 Aug 2024 18:26:46 +0200
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Adrian Huang <adrianhuang0701@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Optimize vmap_lazy_nr arithmetic when
 purging each vmap_area
Message-ID: <ZtHyxvscMuxHQkaO@pc636>
References: <20240829130633.2184-1-ahuang12@lenovo.com>
 <ZtDFQHGHMq6TfbKA@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtDFQHGHMq6TfbKA@pc636>

On Thu, Aug 29, 2024 at 09:00:16PM +0200, Uladzislau Rezki wrote:
> On Thu, Aug 29, 2024 at 09:06:33PM +0800, Adrian Huang wrote:
> > From: Adrian Huang <ahuang12@lenovo.com>
> > 
> > When running the vmalloc stress on a 448-core system, observe the average
> > latency of purge_vmap_node() is about 2 seconds by using the eBPF/bcc
> > 'funclatency.py' tool [1].
> > 
> >   # /your-git-repo/bcc/tools/funclatency.py -u purge_vmap_node & pid1=$! && sleep 8 && modprobe test_vmalloc nr_threads=$(nproc) run_test_mask=0x7; kill -SIGINT $pid1
> > 
> >      usecs             : count    distribution
> >         0 -> 1         : 0       |                                        |
> >         2 -> 3         : 29      |                                        |
> >         4 -> 7         : 19      |                                        |
> >         8 -> 15        : 56      |                                        |
> >        16 -> 31        : 483     |****                                    |
> >        32 -> 63        : 1548    |************                            |
> >        64 -> 127       : 2634    |*********************                   |
> >       128 -> 255       : 2535    |*********************                   |
> >       256 -> 511       : 1776    |**************                          |
> >       512 -> 1023      : 1015    |********                                |
> >      1024 -> 2047      : 573     |****                                    |
> >      2048 -> 4095      : 488     |****                                    |
> >      4096 -> 8191      : 1091    |*********                               |
> >      8192 -> 16383     : 3078    |*************************               |
> >     16384 -> 32767     : 4821    |****************************************|
> >     32768 -> 65535     : 3318    |***************************             |
> >     65536 -> 131071    : 1718    |**************                          |
> >    131072 -> 262143    : 2220    |******************                      |
> >    262144 -> 524287    : 1147    |*********                               |
> >    524288 -> 1048575   : 1179    |*********                               |
> >   1048576 -> 2097151   : 822     |******                                  |
> >   2097152 -> 4194303   : 906     |*******                                 |
> >   4194304 -> 8388607   : 2148    |*****************                       |
> >   8388608 -> 16777215  : 4497    |*************************************   |
> >  16777216 -> 33554431  : 289     |**                                      |
> > 
> >   avg = 2041714 usecs, total: 78381401772 usecs, count: 38390
> > 
> >   The worst case is over 16-33 seconds, so soft lockup is triggered [2].
> > 
> > [Root Cause]
> > 1) Each purge_list has the long list. The following shows the number of
> >    vmap_area is purged.
> > 
> >    crash> p vmap_nodes
> >    vmap_nodes = $27 = (struct vmap_node *) 0xff2de5a900100000
> >    crash> vmap_node 0xff2de5a900100000 128 | grep nr_purged
> >      nr_purged = 663070
> >      ...
> >      nr_purged = 821670
> >      nr_purged = 692214
> >      nr_purged = 726808
> >      ...
> > 
> > 2) atomic_long_sub() employs the 'lock' prefix to ensure the atomic
> >    operation when purging each vmap_area. However, the iteration is over
> >    600000 vmap_area (See 'nr_purged' above).
> > 
> >    Here is objdump output:
> > 
> >      $ objdump -D vmlinux
> >      ffffffff813e8c80 <purge_vmap_node>:
> >      ...
> >      ffffffff813e8d70:  f0 48 29 2d 68 0c bb  lock sub %rbp,0x2bb0c68(%rip)
> >      ...
> > 
> >    Quote from "Instruction tables" pdf file [3]:
> >      Instructions with a LOCK prefix have a long latency that depends on
> >      cache organization and possibly RAM speed. If there are multiple
> >      processors or cores or direct memory access (DMA) devices, then all
> >      locked instructions will lock a cache line for exclusive access,
> >      which may involve RAM access. A LOCK prefix typically costs more
> >      than a hundred clock cycles, even on single-processor systems.
> > 
> >    That's why the latency of purge_vmap_node() dramatically increases
> >    on a many-core system: One core is busy on purging each vmap_area of
> >    the *long* purge_list and executing atomic_long_sub() for each
> >    vmap_area, while other cores free vmalloc allocations and execute
> >    atomic_long_add_return() in free_vmap_area_noflush().
> > 
> > [Solution]
> > Employ a local variable to record the total purged pages, and execute
> > atomic_long_sub() after the traversal of the purge_list is done. The
> > experiment result shows the latency improvement is 99%.
> > 
> > [Experiment Result]
> > 1) System Configuration: Three servers (with HT-enabled) are tested.
> >      * 72-core server: 3rd Gen Intel Xeon Scalable Processor*1
> >      * 192-core server: 5th Gen Intel Xeon Scalable Processor*2
> >      * 448-core server: AMD Zen 4 Processor*2
> > 
> > 2) Kernel Config
> >      * CONFIG_KASAN is disabled
> > 
> > 3) The data in column "w/o patch" and "w/ patch"
> >      * Unit: micro seconds (us)
> >      * Each data is the average of 3-time measurements
> > 
> >          System        w/o patch (us)   w/ patch (us)    Improvement (%)
> >      ---------------   --------------   -------------    -------------
> >      72-core server          2194              14            99.36%
> >      192-core server       143799            1139            99.21%
> >      448-core server      1992122            6883            99.65%
> > 
> > [1] https://github.com/iovisor/bcc/blob/master/tools/funclatency.py
> > [2] https://gist.github.com/AdrianHuang/37c15f67b45407b83c2d32f918656c12 
> > [3] https://www.agner.org/optimize/instruction_tables.pdf
> > 
> > Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> > ---
> >  mm/vmalloc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 3f9b6bd707d2..607697c81e60 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2210,6 +2210,7 @@ static void purge_vmap_node(struct work_struct *work)
> >  {
> >  	struct vmap_node *vn = container_of(work,
> >  		struct vmap_node, purge_work);
> > +	unsigned long nr_purged_pages = 0;
> >  	struct vmap_area *va, *n_va;
> >  	LIST_HEAD(local_list);
> >  
> > @@ -2224,7 +2225,7 @@ static void purge_vmap_node(struct work_struct *work)
> >  
> >  		list_del_init(&va->list);
> >  
> > -		atomic_long_sub(nr, &vmap_lazy_nr);
> > +		nr_purged_pages += nr;
> >  		vn->nr_purged++;
> >  
> >  		if (is_vn_id_valid(vn_id) && !vn->skip_populate)
> > @@ -2235,6 +2236,8 @@ static void purge_vmap_node(struct work_struct *work)
> >  		list_add(&va->list, &local_list);
> >  	}
> >  
> > +	atomic_long_sub(nr_purged_pages, &vmap_lazy_nr);
> > +
> >  	reclaim_list_global(&local_list);
> >  }
> >  
> > -- 
> > 2.34.1
> > 
> I see the point and it looks good to me.
> 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Thank you for improving this. There is one more spot which i detected
> earlier, it is:
> 
> <snip>
> static void free_vmap_area_noflush(struct vmap_area *va)
> {
> 	unsigned long nr_lazy_max = lazy_max_pages();
> 	unsigned long va_start = va->va_start;
> 	unsigned int vn_id = decode_vn_id(va->flags);
> 	struct vmap_node *vn;
> 	unsigned long nr_lazy;
> 
> 	if (WARN_ON_ONCE(!list_empty(&va->list)))
> 		return;
> 
> 	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
> 				PAGE_SHIFT, &vmap_lazy_nr);
> 
> ...
> <snip>
> 
> atomic_long_add_return() might also introduce a high contention. We can
> optimize by splitting into more light atomics. Can you check it on your
> 448-cores system?
> 
I have checked the free_vmap_area_noflush() on my hardware. It is 64
cores system:

<perf cycles>
...
+    7.84%     5.18%  [kernel]          [k] free_vmap_area_noflush
+    6.16%     1.61%  [kernel]          [k] free_unref_page
+    5.57%     1.51%  [kernel]          [k] find_unlink_vmap_area
...
<perf cycles>

<perf cycles annotate>
..
            │     arch_atomic64_add_return():
   23352402 │       mov  %r12,%rdx
            │       lock xadd %rdx,vmap_lazy_nr
            │     is_vn_id_valid():
52364447314 │       mov  nr_vmap_nodes,%ecx <----- the hotest spot which consumes the CPU cycles the most(99%)
            │     arch_atomic64_add_return():
   45547180 │       add  %rdx,%r12        
            │     is_vn_id_valid():
...
<perf cycles annotate>

At least in my case, HW, i do not see that atomic_long_add_return() is a
top when it comes to CPU cycles. Below one is the hottest instead:

static bool
is_vn_id_valid(unsigned int node_id)
{
	if (node_id < nr_vmap_nodes)
		return true;

	return false;
}

access to "nr_vmap_nodes" which is read-only and globally defined:

static __read_mostly unsigned int nr_vmap_nodes = 1;

Any thoughts?

--
Uladzislau Rezki

