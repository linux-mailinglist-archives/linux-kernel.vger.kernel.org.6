Return-Path: <linux-kernel+bounces-307509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30B6964E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586FD2832BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144F81B86D2;
	Thu, 29 Aug 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF3zUyUq"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2B1B8EAD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958024; cv=none; b=VTW8oLxZvoQWEirF8aD8bQVkxSWEJ0V+FWywue2ujizD+5i/Y77yPIFMkUZbSA+c+RXFyK0ttzzAbfDPuBva3+Bf6cQ2XWfiHD6dR61D3wKHrm/8ZpHVk5ZK3zxzU2zZY+5VIyFYNT67QlrXP+SIcwz2YmQWwnJTlJCRnmwGATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958024; c=relaxed/simple;
	bh=hdkJjU2bVyvZGaoM5qzbcCysZVfEmlT4bLEDykDe588=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeqicC6VhZDeYY+KO6huf97Oij0WNxvMJnY4a+AnCblVNnGc18JvUmh++61Rh2SsDqhx48D7TB5+PuccjzcDOOJGTx8mbqhE/XJ26McNmqS0QKgkDePzg3Ua9+vdO0rdaOGoHcoXtZ3mKLPC2bj5ICdQ7CGGQJEzQs6zZIPgk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF3zUyUq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5353cd2fa28so1257588e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724958020; x=1725562820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGK7eMY9Zj/tIqpAUX9qRhLNxPL21zjXLvtek+CF4Oo=;
        b=lF3zUyUqwGqZ1tvqLTipKD/BXJXRpFtqU7HnwdIns4Tpon4OxYEBXM8SDPc15zeJzz
         ObdrNvpaOqspy57ecfbYzX4SyrjWs3Fe2yibYRZBcOAohhQrTIYAIFF1gprjCuIP5evA
         kIP6Cxx/XRDu4BLCRD4poc7a0eWLJV6iARUJWO2qv/2MEjS8ID4uWqkyHUBPWVK1mdsm
         iq2Gol/a9fBhlExtRVrNAQXL2sgyT4vZPVeS9KDDOcvdSbMDbrrojyD1QhtDmuqxdrk+
         sGI/j0y/NDv1GnnHXtOO2cSPNNPPmyxsnvNN4BEA1UG6y+s7nMtQudHUH/bLmHgCviaB
         krdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724958020; x=1725562820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGK7eMY9Zj/tIqpAUX9qRhLNxPL21zjXLvtek+CF4Oo=;
        b=sd0TrGY2SwaaujqjJPhhd/pyJA75gvB4MB5Wgo0bhTLdmWh7xSi5Fb+9+quZCuq37l
         I/SLpGuo7OUbvddtsFL9bDB7LPVrFG8+X8nCmZO0FAjWms6K4co67ooyPhik0YCY6Ou4
         Dz2a+ZwyHUJ3Se3ep2DPZmcNeBRyA2n6086LN4t7QNyUOVVsyGl2uCpRqtT58jqiyroi
         dBEDmvkYaWEMWuNmRZlPkrWqGyMIQ2EeioHcRdIwWktFe6W6BEU3LD/o/3lNyDT8JQ4K
         CH1fbFGRTBUvhuUsQB5gvp9uiQDBY1NPGnkUrvpcjekVpIQurhDUYeZCIP5vQkfPucvu
         vyBA==
X-Forwarded-Encrypted: i=1; AJvYcCWjQor/NjgC/hbqePXlwGgwHGkc4q6Ren2cn0U49Lysb9j8qDfojKFrDnhm72sEUGzrXRANlSGASelfSnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8l4hoca3Qxg4Me17p+Y6QByEd4aOT48M+ACCXcmLUfhiBmpmX
	S5jBqt15YoFxzyJSMro7gfvy1ryG2TShBn5NyitaHdYAxMqhFJ7K
X-Google-Smtp-Source: AGHT+IED3UvWdS3LUGeMKBT0q4MRSQkckAiakMvnDj76PzAoFQvzNwmQAXegGpdZF8gcKKhdM2pVqg==
X-Received: by 2002:a05:6512:2383:b0:535:3d08:5844 with SMTP id 2adb3069b0e04-5353e545de9mr2747725e87.6.1724958019237;
        Thu, 29 Aug 2024 12:00:19 -0700 (PDT)
Received: from pc636 (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354082750fsm223528e87.123.2024.08.29.12.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:00:18 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 29 Aug 2024 21:00:16 +0200
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Optimize vmap_lazy_nr arithmetic when
 purging each vmap_area
Message-ID: <ZtDFQHGHMq6TfbKA@pc636>
References: <20240829130633.2184-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829130633.2184-1-ahuang12@lenovo.com>

On Thu, Aug 29, 2024 at 09:06:33PM +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> When running the vmalloc stress on a 448-core system, observe the average
> latency of purge_vmap_node() is about 2 seconds by using the eBPF/bcc
> 'funclatency.py' tool [1].
> 
>   # /your-git-repo/bcc/tools/funclatency.py -u purge_vmap_node & pid1=$! && sleep 8 && modprobe test_vmalloc nr_threads=$(nproc) run_test_mask=0x7; kill -SIGINT $pid1
> 
>      usecs             : count    distribution
>         0 -> 1         : 0       |                                        |
>         2 -> 3         : 29      |                                        |
>         4 -> 7         : 19      |                                        |
>         8 -> 15        : 56      |                                        |
>        16 -> 31        : 483     |****                                    |
>        32 -> 63        : 1548    |************                            |
>        64 -> 127       : 2634    |*********************                   |
>       128 -> 255       : 2535    |*********************                   |
>       256 -> 511       : 1776    |**************                          |
>       512 -> 1023      : 1015    |********                                |
>      1024 -> 2047      : 573     |****                                    |
>      2048 -> 4095      : 488     |****                                    |
>      4096 -> 8191      : 1091    |*********                               |
>      8192 -> 16383     : 3078    |*************************               |
>     16384 -> 32767     : 4821    |****************************************|
>     32768 -> 65535     : 3318    |***************************             |
>     65536 -> 131071    : 1718    |**************                          |
>    131072 -> 262143    : 2220    |******************                      |
>    262144 -> 524287    : 1147    |*********                               |
>    524288 -> 1048575   : 1179    |*********                               |
>   1048576 -> 2097151   : 822     |******                                  |
>   2097152 -> 4194303   : 906     |*******                                 |
>   4194304 -> 8388607   : 2148    |*****************                       |
>   8388608 -> 16777215  : 4497    |*************************************   |
>  16777216 -> 33554431  : 289     |**                                      |
> 
>   avg = 2041714 usecs, total: 78381401772 usecs, count: 38390
> 
>   The worst case is over 16-33 seconds, so soft lockup is triggered [2].
> 
> [Root Cause]
> 1) Each purge_list has the long list. The following shows the number of
>    vmap_area is purged.
> 
>    crash> p vmap_nodes
>    vmap_nodes = $27 = (struct vmap_node *) 0xff2de5a900100000
>    crash> vmap_node 0xff2de5a900100000 128 | grep nr_purged
>      nr_purged = 663070
>      ...
>      nr_purged = 821670
>      nr_purged = 692214
>      nr_purged = 726808
>      ...
> 
> 2) atomic_long_sub() employs the 'lock' prefix to ensure the atomic
>    operation when purging each vmap_area. However, the iteration is over
>    600000 vmap_area (See 'nr_purged' above).
> 
>    Here is objdump output:
> 
>      $ objdump -D vmlinux
>      ffffffff813e8c80 <purge_vmap_node>:
>      ...
>      ffffffff813e8d70:  f0 48 29 2d 68 0c bb  lock sub %rbp,0x2bb0c68(%rip)
>      ...
> 
>    Quote from "Instruction tables" pdf file [3]:
>      Instructions with a LOCK prefix have a long latency that depends on
>      cache organization and possibly RAM speed. If there are multiple
>      processors or cores or direct memory access (DMA) devices, then all
>      locked instructions will lock a cache line for exclusive access,
>      which may involve RAM access. A LOCK prefix typically costs more
>      than a hundred clock cycles, even on single-processor systems.
> 
>    That's why the latency of purge_vmap_node() dramatically increases
>    on a many-core system: One core is busy on purging each vmap_area of
>    the *long* purge_list and executing atomic_long_sub() for each
>    vmap_area, while other cores free vmalloc allocations and execute
>    atomic_long_add_return() in free_vmap_area_noflush().
> 
> [Solution]
> Employ a local variable to record the total purged pages, and execute
> atomic_long_sub() after the traversal of the purge_list is done. The
> experiment result shows the latency improvement is 99%.
> 
> [Experiment Result]
> 1) System Configuration: Three servers (with HT-enabled) are tested.
>      * 72-core server: 3rd Gen Intel Xeon Scalable Processor*1
>      * 192-core server: 5th Gen Intel Xeon Scalable Processor*2
>      * 448-core server: AMD Zen 4 Processor*2
> 
> 2) Kernel Config
>      * CONFIG_KASAN is disabled
> 
> 3) The data in column "w/o patch" and "w/ patch"
>      * Unit: micro seconds (us)
>      * Each data is the average of 3-time measurements
> 
>          System        w/o patch (us)   w/ patch (us)    Improvement (%)
>      ---------------   --------------   -------------    -------------
>      72-core server          2194              14            99.36%
>      192-core server       143799            1139            99.21%
>      448-core server      1992122            6883            99.65%
> 
> [1] https://github.com/iovisor/bcc/blob/master/tools/funclatency.py
> [2] https://gist.github.com/AdrianHuang/37c15f67b45407b83c2d32f918656c12 
> [3] https://www.agner.org/optimize/instruction_tables.pdf
> 
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  mm/vmalloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3f9b6bd707d2..607697c81e60 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2210,6 +2210,7 @@ static void purge_vmap_node(struct work_struct *work)
>  {
>  	struct vmap_node *vn = container_of(work,
>  		struct vmap_node, purge_work);
> +	unsigned long nr_purged_pages = 0;
>  	struct vmap_area *va, *n_va;
>  	LIST_HEAD(local_list);
>  
> @@ -2224,7 +2225,7 @@ static void purge_vmap_node(struct work_struct *work)
>  
>  		list_del_init(&va->list);
>  
> -		atomic_long_sub(nr, &vmap_lazy_nr);
> +		nr_purged_pages += nr;
>  		vn->nr_purged++;
>  
>  		if (is_vn_id_valid(vn_id) && !vn->skip_populate)
> @@ -2235,6 +2236,8 @@ static void purge_vmap_node(struct work_struct *work)
>  		list_add(&va->list, &local_list);
>  	}
>  
> +	atomic_long_sub(nr_purged_pages, &vmap_lazy_nr);
> +
>  	reclaim_list_global(&local_list);
>  }
>  
> -- 
> 2.34.1
> 
I see the point and it looks good to me.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you for improving this. There is one more spot which i detected
earlier, it is:

<snip>
static void free_vmap_area_noflush(struct vmap_area *va)
{
	unsigned long nr_lazy_max = lazy_max_pages();
	unsigned long va_start = va->va_start;
	unsigned int vn_id = decode_vn_id(va->flags);
	struct vmap_node *vn;
	unsigned long nr_lazy;

	if (WARN_ON_ONCE(!list_empty(&va->list)))
		return;

	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
				PAGE_SHIFT, &vmap_lazy_nr);

...
<snip>

atomic_long_add_return() might also introduce a high contention. We can
optimize by splitting into more light atomics. Can you check it on your
448-cores system?

Tnanks!

--
Uladzislau Rezki

