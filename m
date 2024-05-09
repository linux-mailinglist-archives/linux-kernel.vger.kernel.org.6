Return-Path: <linux-kernel+bounces-174244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F5D8C0C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AE21C2153A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9FA149C42;
	Thu,  9 May 2024 07:42:48 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C58B624
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240568; cv=none; b=FYTeXUuTI+5r0dtkqAnlpVmZNiuUIyUsIN8UTeDLdRKNkU9eYwhWqL7Hh5X5TpIHfhh03M3+yXCjnejT9Ug5q7GKIFc9sSo2LmrRYWmaIkTpE9Us6DHusxBCUhEupIfEJwUaDN4gqt8r2BZvA8guCzS1GHOnb4x9JBKWaGePgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240568; c=relaxed/simple;
	bh=ewf10vTLz1xYFsLWcMEWRjpSHDEcjsPxr6tQrO1knEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH3SbXR0kLFB0A7OelIwa5QsJrIieUPHkAxPIpMi/Yn1ZG7pdNxbDvX4XdDX4r4+XAeJFpduBKBzn+dIFNx/zGsKg4ASnjWWrSU+r5ZYrostBhl1JGqk7P2UtRUwK+NAuy5ylU72YHXn8lwWknX5jxtHFX14L/wnewac5WeDpZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-36-663c7e701b3d
Date: Thu, 9 May 2024 16:42:34 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
	willy@infradead.org, david@redhat.com, peterz@infradead.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v9 rebase on mm-unstable 0/8] Reduce tlb and interrupt
 numbers over 90% by improving folio migration
Message-ID: <20240509074234.GA77328@system.software.com>
References: <20240418061536.11645-1-byungchul@sk.com>
 <87cyqlyjh5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyqlyjh5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsXC9ZZnkW5BnU2awfUJAhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP4CKT86azOIg4PG9tY/FY+esu+weCzaVemxeoeWxeM9LJo9NqzrZPDZ9
	msTu8e7cOXaPEzN+s3jMOxno8X7fVTaPrb/sPBqnXmPz+LxJLoAvissmJTUnsyy1SN8ugSvj
	aeMnxoI/kRW7F7YxNjBOtOti5OSQEDCRaFu4gQ3Gnn//GiOIzSKgInHg2WewOJuAusSNGz+Z
	QWwRAQ2JTwuXs3cxcnEwCzxnkvj95jc7SEJYoEpi3e27YA28AhYSF3tbWUFsIYFMibv3NzBB
	xAUlTs58wgJiMwtoSdz49xIozgFkS0ss/8cBEuYUsJN4/OUrWLmogLLEgW3HmUB2SQisYpdY
	2rgf6lBJiYMrbrBMYBSYhWTsLCRjZyGMXcDIvIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMBKX
	1f6J3sH46ULwIUYBDkYlHl6HTOs0IdbEsuLK3EOMEhzMSiK8VTVAId6UxMqq1KL8+KLSnNTi
	Q4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYwmEg3zNe40vstRsDrtvLzQV533x4lN
	PtP5XL+4m0+0/Lhh9zvmo+KsB/tDeyU/R7nO3+B8SF5kSdtNxoKlZxZJ/+iel5Foq9Syrf3V
	+7l7jddvMgnW4BZUjZ/8te+emUaTskZT9wznFDXtOzeb9ucs590S3BEx4ZXl9gP3sydtM136
	vvDTshAlluKMREMt5qLiRAAfLLyzwAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsXC5WfdrFtQZ5NmMG87s8Wc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4Mp42fmIs+BNZsXthG2MD40S7LkZODgkBE4n5968xgtgsAioSB559ZgOx2QTU
	JW7c+MkMYosIaEh8WricvYuRi4NZ4DmTxO83v9lBEsICVRLrbt8Fa+AVsJC42NvKCmILCWRK
	3L2/gQkiLihxcuYTFhCbWUBL4sa/l0BxDiBbWmL5Pw6QMKeAncTjL1/BykUFlCUObDvONIGR
	dxaS7llIumchdC9gZF7FKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGFfLav9M3MH45bL7IUYB
	DkYlHl6HTOs0IdbEsuLK3EOMEhzMSiK8VTVAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJ
	QgLpiSWp2ampBalFMFkmDk6pBkZXFgnpBDmZ7vbCbEdr/5a/zjvsvirO4ZsqW1rwxr503fOs
	S6tXq0S/OT7D+35j+CHX0E6n95u/d9fGNTm/VgkINpi32jA3Nm5Xsaot5+Gfh4VceC0mefvp
	vCuM3aWWyLYl6NuFqPcX7KVEqgSrM62u9eUKb5EOEFicavHC0/nSCrm0RVynlFiKMxINtZiL
	ihMBtoXLgKcCAAA=
X-CFilter-Loop: Reflected

On Fri, Apr 19, 2024 at 02:06:30PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > The test envitonment:
> >
> >    Architecture - x86_64
> >    QEMU - kvm enabled, host cpu
> 
> The test is run in VM?  Do you have test results in bare metal
> environment?

I tested it in a bare metal server.  See the result below.

> >    Numa - 2 nodes (16 CPUs 1GB, no CPUs 99GB)
> 
> The configuration looks quite abnormal.  Have you tested with other
> configuration, such 1:4 or 1:8?

I tested with DRAM : CXL expander = 42GB : 98GB.

> >    Linux Kernel - v6.9-rc4, numa balancing tiering on, demotion enabled
> >
> > < measurement: raw data - tlb and interrupt numbers >
> >
> >    $ perf stat -a \
> >            -e itlb.itlb_flush \
> >            -e tlb_flush.dtlb_thread \
> >            -e tlb_flush.stlb_any \
> >            -e dtlb-load-misses \
> >            -e dtlb-store-misses \
> >            -e itlb-load-misses \
> >            XSBench -t 16 -p 50000000
> >
> >    $ grep "TLB shootdowns" /proc/interrupts
> >
> >    BEFORE
> >    ------
> >    40417078     itlb.itlb_flush
> >    234852566    tlb_flush.dtlb_thread
> >    153192357    tlb_flush.stlb_any
> >    119001107892 dTLB-load-misses
> >    307921167    dTLB-store-misses
> >    1355272118   iTLB-load-misses
> >
> >    TLB: 1364803    1303670    1333921    1349607
> >         1356934    1354216    1332972    1342842
> >         1350265    1316443    1355928    1360793
> >         1298239    1326358    1343006    1340971
> >         TLB shootdowns
> >
> >    AFTER
> >    -----
> >    3316495      itlb.itlb_flush
> >    138912511    tlb_flush.dtlb_thread
> >    115199341    tlb_flush.stlb_any
> >    117610390021 dTLB-load-misses
> >    198042233    dTLB-store-misses
> >    840066984    iTLB-load-misses
> >
> >    TLB: 117257     119219     117178     115737
> >         117967     118948     117508     116079
> >         116962     117266     117320     117215
> >         105808     103934     115672     117610
> >         TLB shootdowns
> >
> > < measurement: user experience - runtime >
> >
> >    $ time XSBench -t 16 -p 50000000
> >
> >    BEFORE
> >    ------
> >    Threads:     16
> >    Runtime:     968.783 seconds
> >    Lookups:     1,700,000,000
> >    Lookups/s:   1,754,778
> >
> >    15208.91s user 141.44s system 1564% cpu 16:20.98 total
> >
> >    AFTER
> >    -----
> >    Threads:     16
> >    Runtime:     913.210 seconds
> >    Lookups:     1,700,000,000
> >    Lookups/s:   1,861,565
> >
> >    14351.69s user 138.23s system 1565% cpu 15:25.47 total
> 
> IIUC, the memory footprint will be larger with the patchset.  Do you
> have data?

As I already told you, from version 9, the footprint is exactly same
between patched kernel and vanilla kernel because that let folios go as
is, but controls TLB flush timing only.

There's two things to note.

1. I changed the patchset and will post the next version shortly:

	BEFORE - Defer TLB flush required until the interesting folios
	         exiting either pcp or buddy.  The interesting folios
		 are source folios unmapped during folio migration.

	AFTER  - Defer TLB flush required until the interesting folios
	         exiting either pcp or buddy.  The interesting folios
		 are source folios unmapped during folio migration,
		 * plus, folios unmapped during reclaiming folios in
		 shrink_folio_list()*.

2. I changed workload for testing because XSBench doesn't struggle
   against lack of memory in such a big server.  Instead, I picked a
   very real workload, LLM inference engine, llama.cpp.

I tested with the two changes.  The test result is like:

---

   Kernel version: mm-unstable around v6.9-rc4
   Machine: bare metal, x86_64, Intel(R) Xeon(R) Gold 6430
   CPU: 1 socket 64 core with hyper thread on
   Numa: 2 nodes (64 CPUs DRAM 42GB, no CPUs CXL(expander) 98GB)
   Config: swap off, numa balancing tiering on, demotion enabled

   1 set of test workload:

      echo 3 > /proc/sys/vm/drop_caches
      llama.cpp/main -m $(70G_model1) -p "who are you?" -s 1 -t 15 -n 20 &
      llama.cpp/main -m $(70G_model2) -p "who are you?" -s 1 -t 15 -n 20 &
      llama.cpp/main -m $(70G_model3) -p "who are you?" -s 1 -t 15 -n 20 &
      wait
   
   where -t: nr of threads, -s: seed used to make the runtime stable,
   -n: nr of tokens determinig the runtime, -p: prompt to ask, -m: LLM
   model to use.

   Run this set 10 times successively.  So I got 30 total runtimes since
   each inference prints its runtime at the end of each run.  The result
   is like:

   BEFORE
   ------
   llama_print_timings:       total time = 1002461.95 ms /    24 tokens
   llama_print_timings:       total time = 1044978.38 ms /    24 tokens
   llama_print_timings:       total time = 1000653.09 ms /    24 tokens
   llama_print_timings:       total time = 1047104.80 ms /    24 tokens
   llama_print_timings:       total time = 1069430.36 ms /    24 tokens
   llama_print_timings:       total time = 1068201.16 ms /    24 tokens
   llama_print_timings:       total time = 1078092.59 ms /    24 tokens
   llama_print_timings:       total time = 1073200.45 ms /    24 tokens
   llama_print_timings:       total time = 1067136.00 ms /    24 tokens
   llama_print_timings:       total time = 1076442.56 ms /    24 tokens
   llama_print_timings:       total time = 1004142.64 ms /    24 tokens
   llama_print_timings:       total time = 1042942.65 ms /    24 tokens
   llama_print_timings:       total time =  999933.76 ms /    24 tokens
   llama_print_timings:       total time = 1046548.83 ms /    24 tokens
   llama_print_timings:       total time = 1068671.48 ms /    24 tokens
   llama_print_timings:       total time = 1068285.76 ms /    24 tokens
   llama_print_timings:       total time = 1077789.63 ms /    24 tokens
   llama_print_timings:       total time = 1071558.93 ms /    24 tokens
   llama_print_timings:       total time = 1066181.55 ms /    24 tokens
   llama_print_timings:       total time = 1076767.53 ms /    24 tokens
   llama_print_timings:       total time = 1004065.63 ms /    24 tokens
   llama_print_timings:       total time = 1044522.13 ms /    24 tokens
   llama_print_timings:       total time =  999725.33 ms /    24 tokens
   llama_print_timings:       total time = 1047510.77 ms /    24 tokens
   llama_print_timings:       total time = 1068010.27 ms /    24 tokens
   llama_print_timings:       total time = 1068999.31 ms /    24 tokens
   llama_print_timings:       total time = 1077648.05 ms /    24 tokens
   llama_print_timings:       total time = 1071378.96 ms /    24 tokens
   llama_print_timings:       total time = 1066326.32 ms /    24 tokens
   llama_print_timings:       total time = 1077088.92 ms /    24 tokens

   AFTER
   -----
   llama_print_timings:       total time =  988522.03 ms /    24 tokens
   llama_print_timings:       total time =  997204.52 ms /    24 tokens
   llama_print_timings:       total time =  996605.86 ms /    24 tokens
   llama_print_timings:       total time =  991985.50 ms /    24 tokens
   llama_print_timings:       total time = 1035143.31 ms /    24 tokens
   llama_print_timings:       total time =  993660.18 ms /    24 tokens
   llama_print_timings:       total time =  983082.14 ms /    24 tokens
   llama_print_timings:       total time =  990431.36 ms /    24 tokens
   llama_print_timings:       total time =  992707.09 ms /    24 tokens
   llama_print_timings:       total time =  992673.27 ms /    24 tokens
   llama_print_timings:       total time =  989285.43 ms /    24 tokens
   llama_print_timings:       total time =  996710.06 ms /    24 tokens
   llama_print_timings:       total time =  996534.64 ms /    24 tokens
   llama_print_timings:       total time =  991344.17 ms /    24 tokens
   llama_print_timings:       total time = 1035210.84 ms /    24 tokens
   llama_print_timings:       total time =  994714.13 ms /    24 tokens
   llama_print_timings:       total time =  984184.15 ms /    24 tokens
   llama_print_timings:       total time =  990909.45 ms /    24 tokens
   llama_print_timings:       total time =  991881.48 ms /    24 tokens
   llama_print_timings:       total time =  993918.03 ms /    24 tokens
   llama_print_timings:       total time =  990061.34 ms /    24 tokens
   llama_print_timings:       total time =  998076.69 ms /    24 tokens
   llama_print_timings:       total time =  997082.59 ms /    24 tokens
   llama_print_timings:       total time =  990677.58 ms /    24 tokens
   llama_print_timings:       total time = 1036054.94 ms /    24 tokens
   llama_print_timings:       total time =  994125.93 ms /    24 tokens
   llama_print_timings:       total time =  982467.01 ms /    24 tokens
   llama_print_timings:       total time =  990191.60 ms /    24 tokens
   llama_print_timings:       total time =  993319.24 ms /    24 tokens
   llama_print_timings:       total time =  992540.57 ms /    24 tokens
   
   The difference of TLB shootdown(/proc/interrupts) is like:

   BEFORE
   ------
   TLB:
   125553646  141418810  161932620  176853972  186655697  190399283
   192143823  196414038  192872439  193313658  193395617  192521416
   190788161  195067598  198016061  193607347  194293972  190786732
   191545637  194856822  191801931  189634535  190399803  196365922
   195268398  190115840  188050050  193194908  195317617  190820190
   190164820  185556071  226797214  229592631  216112464  209909495
   205575979  205950252  204948111  197999795  198892232  205287952
   199344631  195015158  195869844  198858745  195692876  200961904
   203463252  205921722  199850838  206145986  199613202  199961345
   200129577  203020521  207873649  203697671  197093386  204243803
   205993323  200934664  204193128  194435376  TLB shootdowns                                                  

   AFTER
   -----
   TLB:
   5648092    6610142    7032849    7882308    8088518    8352310
   8656536    8705136    8647426    8905583    8985408    8704522
   8884344    9026261    8929974    8869066    8877575    8810096
   8770984    8754503    8801694    8865925    8787524    8656432
   8755912    8682034    8773935    8832925    8797997    8515777
   8481240    8891258   10595243   10285973    9756935    9573681
   9398968    9069244    9242984    8899009    9310690    9029095
   9069758    9105825    9092703    9270202    9460287    9258546
   9180415    9232723    9270611    9175020    9490420    9360316
   9420818    9057663    9525631    9310152    9152242    8654483
   9181804    9050847    8919916    8883856    TLB shootdowns                                                  

   The difference of 'perf stat' for tlb numbers during one set of test
   with drop cache excluded is like:

   BEFORE
   ------
   3163679332	dTLB-load-misses     
   2017751856	dTLB-store-misses    
   327092903	iTLB-load-misses     
   1357543886	tlb:tlb_flush        

   AFTER
   -----
   2394694609	dTLB-load-misses     
   861144167	dTLB-store-misses    
   64055579	iTLB-load-misses     
   69175002	tlb:tlb_flush        

---

I'm happy to share great results.  I used a real workload that is super
popular these days, and got good results.  I will post the next version
of the patchset shortly after organizing and refining things.

	Byungchul

