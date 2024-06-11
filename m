Return-Path: <linux-kernel+bounces-209550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA18990378A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E768E1C22919
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4DE17624F;
	Tue, 11 Jun 2024 09:12:27 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ABC173321
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097147; cv=none; b=O0JGLoNRSYyct3yWBhQD0TsPzFF06j9os8L7jeQQ4cvlkHJVSSGK4X5EcUYeBK3w/u8JguqM2rQCAkApZz4RFHwtOuvhT517yqUK+d1d7jpYtBHy4cndSeJYrCSOJInZ7oV2oPwHozXxulLVlRo3N8NByOFm8bkzaffF7rkP46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097147; c=relaxed/simple;
	bh=tmaThG2K7F+eMYaWfxL06epe0PFlDSwEVgbmq94AgYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhWBsaIIoRjbotzzCGZk89KTGIiMgizvtPal6fLaqHNoOnD1fJOzSwURJ9RnFNYWZa+qr7JQ1BQlFNNfTKVJEO+A1kLMDU1rlxLmUXEfIISjWHUJtpwFoEkuu8T7NFIh1BzC2motkCvoBZDcjPaZ7BhLddBB5MlBHRoX8o03opQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-1f-666814f3c8b5
Date: Tue, 11 Jun 2024 18:12:14 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
	Byungchul Park <lkml.byungchul.park@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
Message-ID: <20240611091214.GA16469@system.software.com>
References: <20240531092001.30428-1-byungchul@sk.com>
 <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
 <26dc4594-430b-483c-a26c-7e68bade74b0@redhat.com>
 <20240603093505.GA12549@system.software.com>
 <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d650c29b-129f-4fac-9a9d-ea1fbdae2c3a@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXC9ZZnke5nkYw0g6V7bSzmrF/DZvF5wz82
	i08vHzBavNjQzmjxdf0vZounn/pYLC7vmsNmcW/Nf1aLo52bmC3O71rLarFj6T4mi0sHFjBZ
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPrLzuPxqnX2Dw+b5IL4IvisklJ
	zcksSy3St0vgyrjR+YStoFet4vGH1ywNjN1yXYwcHBICJhIT+iJgzM9TnbsYOTlYBFQlXtxf
	yQhiswmoS9y48ZMZxBYBsk+tXM7excjFwSxwnFniw8dFYEXCAgUSryZMYgexeQUsJDZsewFW
	JCSwlFli4evZrBAJQYmTM5+wgNjMAloSN/69ZAJZzCwgLbH8HwdImFPAVuJY322wZaICyhIH
	th1nArElBPaxS5y/EwthS0ocXHGDZQKjwCwkU2chmToLYeoCRuZVjEKZeWW5iZk5JnoZlXmZ
	FXrJ+bmbGIGRuaz2T/QOxk8Xgg8xCnAwKvHwnviYlibEmlhWXJl7iFGCg1lJhPdMTHqaEG9K
	YmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBsb5pnXS/DsepJSp
	NS8JUuw/p8s/cY/m7JByT5sTTg48r393BpW8j+RbVfx89Y8DK5pKD949YK5z0zCp9+96+X1a
	tWmtM96q+Mawz+RUb3Mo8vfv/3/hwXGRhVYb7yveM4wq/pp3wFNNyilpnhFX/PKDZlHfX7DI
	q01LnVR+61z6781d8h9d7iixFGckGmoxFxUnAgDq1F/GyAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXC5WfdrPtZJCPN4G2/tsWc9WvYLD5v+Mdm
	8enlA0aLFxvaGS2+rv/FbPH0Ux+LxeG5J1ktLu+aw2Zxb81/VoujnZuYLc7vWstqsWPpPiaL
	SwcWMFkc7z3AZDH/3mc2i82bpjJbHJ8yldHi9w+gjpOzJrM4CHt8b+1j8dg56y67x4JNpR6b
	V2h5LN7zkslj06pONo9Nnyaxe7w7d47d48SM3ywe804Gerzfd5XNY/GLD0weW3/ZeTROvcbm
	8XmTXAB/FJdNSmpOZllqkb5dAlfGjc4nbAW9ahWPP7xmaWDsluti5OCQEDCR+DzVuYuRk4NF
	QFXixf2VjCA2m4C6xI0bP5lBbBEg+9TK5exdjFwczALHmSU+fFwEViQsUCDxasIkdhCbV8BC
	YsO2F2BFQgJLmSUWvp7NCpEQlDg58wkLiM0soCVx499LJpDFzALSEsv/cYCEOQVsJY713QZb
	JiqgLHFg23GmCYy8s5B0z0LSPQuhewEj8ypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAWFtW
	+2fiDsYvl90PMQpwMCrx8J74mJYmxJpYVlyZe4hRgoNZSYT3TEx6mhBvSmJlVWpRfnxRaU5q
	8SFGaQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVANjquC5R0pJu+tyheKZpr85ty91pehB
	pidH1jtMXDU9XWffh9qDPkEWW1Kkt63bwCG+8sZ9X8ZNs/p4d5zY8irg9Y6bGjNbhB5vXXz+
	+xHNOwzJ+XwR7Lnqd3Wkb0vxuTwKtf/ufmt25HG1l1vX392/ir88SoknWG7y8vUbL89jzfo5
	PfhRg4W9nRJLcUaioRZzUXEiAGUAImCxAgAA
X-CFilter-Loop: Reflected

On Mon, Jun 03, 2024 at 06:23:46AM -0700, Dave Hansen wrote:
> On 6/3/24 02:35, Byungchul Park wrote:
> ...> In luf's point of view, the points where the deferred flush should be
> > performed are simply:
> > 
> > 	1. when changing the vma maps, that might be luf'ed.
> > 	2. when updating data of the pages, that might be luf'ed.
> 
> It's simple, but the devil is in the details as always.
> 
> > All we need to do is to indentify the points:
> > 
> > 	1. when changing the vma maps, that might be luf'ed.
> > 
> > 	   a) mmap and munmap e.i. fault handler or unmap_region().
> > 	   b) permission to writable e.i. mprotect or fault handler.
> > 	   c) what I'm missing.
> 
> I'd say it even more generally: anything that installs a PTE which is
> inconsistent with the original PTE.  That, of course, includes writes.
> But it also includes crazy things that we do like uprobes.  Take a look
> at __replace_page().
> 
> I think the page_vma_mapped_walk() checks plus the ptl keep LUF at bay
> there.  But it needs some really thorough review.
> 
> But the bigger concern is that, if there was a problem, I can't think of
> a systematic way to find it.
> 
> > 	2. when updating data of the pages, that might be luf'ed.
> > 
> > 	   a) updating files through vfs e.g. file_end_write().
> > 	   b) updating files through writable maps e.i. 1-a) or 1-b).
> > 	   c) what I'm missing.
> 
> Filesystems or block devices that change content without a "write" from
> the local system.  Network filesystems and block devices come to mind.
> I honestly don't know what all the rules are around these, but they
> could certainly be troublesome.
> 
> There appear to be some interactions for NFS between file locking and
> page cache flushing.
> 
> But, stepping back ...
> 
> I'd honestly be a lot more comfortable if there was even a debugging LUF
> mode that enforced a rule that said:
> 
>   1. A LUF'd PTE can't be rewritten until after a luf_flush() occurs
>   2. A LUF'd page's position in the page cache can't be replaced until
>      after a luf_flush()

I'm thinking a debug mode doing the following *pseudo* code - check the
logic only since the grammer might be wrong:

   0-a) Introduce new fields in page_ext:

	#ifdef LUF_DEBUG
	struct list_head __percpu luf_node;
	#endif

   0-b) Introduce new fields in struct address_space:

	#ifdef LUF_DEBUG
	struct list_head __percpu luf_node;
	#endif

   0-c) Introduce new fields in struct task_struct:

	#ifdef LUF_DEBUG
	cpumask_t luf_pending_cpus;
	#endif

   0-d) Define percpu list_head to link luf'd folios:

	#ifdef LUF_DEBUG
	DEFINE_PER_CPU(struct list_head, luf_folios);
	DEFINE_PER_CPU(struct list_head, luf_address_spaces);
	#endif

   1) When skipping tlb flush in reclaim or migration for a folio:

	#ifdef LUF_DEBUG
	ext = get_page_ext_for_luf_debug(folio);
	as = folio_mapping(folio);

	for_each_cpu(cpu, skip_cpus) {
		list_add(per_cpu_ptr(ext->luf_node, cpu),
			 per_cpu_ptr(luf_folios, cpu));
		if (as)
			list_add(per_cpu_ptr(as->luf_node, cpu),
				 per_cpu_ptr(luf_address_spaces, cpu));
	}
	put_page_ext(ext);
	#endif

   2) When performing tlb flush in try_to_unmap_flush():
      Remind luf only works on unmapping during reclaim and migration.

	#ifdef LUF_DEBUG
	for_each_cpu(cpu, now_flushing_cpus) {
		for_each_node_safe(folio, per_cpu_ptr(luf_folios)) {
			ext = get_page_ext_for_luf_debug(folio);
			list_del_init(per_cpu_ptr(ext->luf_node, cpu))
			put_page_ext(ext);
		}

		for_each_node_safe(as, per_cpu_ptr(luf_address_spaces))
			list_del_init(per_cpu_ptr(as->luf_node, cpu))

		cpumask_clear_cpu(cpu, current->luf_pending_cpus);
	}
	#endif

   3) In pte_mkwrite():

	#ifdef LUF_DEBUG
	ext = get_page_ext_for_luf_debug(folio);

	for_each_cpu(cpu, online_cpus)
		if (!list_empty(per_cpu_ptr(ext->luf_node, cpu)))
			cpumask_set_cpu(cpu, current->luf_pending_cpus);
	put_page_ext(ext);
	#endif

   4) On returning to user:

	#ifdef LUF_DEBUG
	WARN_ON(!cpumask_empty(current->luf_pending_cpus));
	#endif

   5) On right after every a_ops->write_end() call:

	#ifdef LUF_DEBUG
	as = get_address_space_to_write_to();
	for_each_cpu(cpu, online_cpus)
		if (!list_empty(per_cpu_ptr(as->luf_node, cpu)))
			cpumask_set_cpu(cpu, current->luf_pending_cpus);
	#endif

	luf_flush_or_its_optimized_version();

	#ifdef LUF_DEBUG
	WARN_ON(!cpumask_empty(current->luf_pending_cpus));
	#endif

I will implement the debug mode this way with all serialized.  Do you
think it works for what we want?

	Byungchul

> or *some* other independent set of rules that can tell us when something
> goes wrong.  That uprobes code, for instance, seems like it will work.
> But I can also imagine writing it ten other ways where it would break
> when combined with LUF.

