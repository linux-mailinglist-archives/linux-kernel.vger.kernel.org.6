Return-Path: <linux-kernel+bounces-279834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EF894C260
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E901C22A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA04654648;
	Thu,  8 Aug 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="onfhlbqq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ljZFLX89"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFBC646
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133744; cv=none; b=jyx9byYqujSYsGNP/QlVrraCdRTQZIFHIP2KHFOBnTUz9xKuot4VpbcuJQAIv4BxD02271oXwNbIQ73MMd+egLMZf/BfEGvIOO5YzQjL/WQ3xGfxQjsemNW0Hcgx6DiHivUp7hECtxku47m+VCiB34V5oPRbPjaoxKeoQPjBing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133744; c=relaxed/simple;
	bh=mc1ZBDROlgcRml/JkZnbhsThg5DAVRtotsTVOXeca/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i19nXO5rNkRTirgB///4/Q7SHmUiOiKtIjj2j38rRTlF0pkgt5l/VlhgJfin6HrmPmiVI/zoWGIGziRcHWK2XYcEpiHzJdQYjPBM70QiqPBp0eeEg87QZXFSEfKXf/vwQ+MKJRQ6uHvE78870u3zDAP2lHvnhHO4h9r9UeZv0YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=onfhlbqq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ljZFLX89; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723133741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5jueLtfL6zJUJUMfOwH8WIejGghnLYJZB42/VMt7lIs=;
	b=onfhlbqquQjwr/hONdKWPxKcsDlt8SVIhruKzNqqzTYrbuCIGq/5mG78eAwfNFLUKEXnpL
	AVuZE7agBqN1yTKhIQcneyWa19SerPpmiw0l7Dy06lBLb7K9w+SQEKT4LyJsp54pB0talR
	znCxAd8Uocw8IT4IIMM1m+wsUwM+EJTAcr0zMoL/USz3LrT2gb4PKGcr/hCDC/hdAlUdrh
	DMgM2JjGRbB0jQpElVEyGVmIaisK3cRd/svrgZifHn8weEuVqgRetUzO9vesJPB/OCV1v+
	eMyIQ9KppsxO0B2Psgg7eZJ71wmHdlYlM/cQDLnIRtVxFQdFowURR5LSdilS4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723133741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5jueLtfL6zJUJUMfOwH8WIejGghnLYJZB42/VMt7lIs=;
	b=ljZFLX895jG3myqLTwu/wOFnXfCddUnp0DBpj9R+9t8G3S0Ov1r9DR5AKqqG10NEDN/vm0
	GUqw0vebMtF4Q6Bw==
To: Dan Williams <dan.j.williams@intel.com>, Max Ramanouski
 <max8rr8@gmail.com>, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org
Cc: max8rr8@gmail.com, linux-kernel@vger.kernel.org, x86@kernel.org, Dan
 Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
In-Reply-To: <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
Date: Thu, 08 Aug 2024 18:15:40 +0200
Message-ID: <877ccryor7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 08 2024 at 08:58, Dan Williams wrote:
> Thomas Gleixner wrote:
>> On Thu, Aug 10 2023 at 13:00, Max Ramanouski wrote:
>> 
>> > On systems that use HMM (most notably amdgpu driver)
>> > high_memory can jump over VMALLOC_START. That causes
>> > some iounmap to exit early. This in addition to leaking,
>> > causes problems with rebinding devices to vfio_pci from
>> > other drivers with error of conflicting memtypes,
>> > as they aren't freed in iounmap.
>> >
>> > Replace comparison against high_memory with is_vmalloc_addr to
>> > fix the issue and make x86 iounmap implementation more similar
>> > to generic one, it also uses is_vmalloc_addr to validate pointer.
>> 
>> So this lacks a Fixes tag and some deep analysis of similar potential
>> problems. While at it please use func() notation for functions. In the
>> middle of a sentence iounmap does not immediately stand out, but
>> iounmap() does. It's documented ...
>> 
>> This add_pages() hackery in pagemap_range() is really nasty as it ends
>> up violating historical assumptions about max_pfn and high_memory.
>> 
>> Dan, who did the analysis of this when the device private memory muck
>> was added?
>
> So that plain add_pages() usage originated here:
>
>     4ef589dc9b10 mm/hmm/devmem: device memory hotplug using ZONE_DEVICE
>
> The original memremap_pages() only ever used arch_add_memory()
>
>     41e94a851304 add devm_memremap_pages
>
> When HMM merged into memremap_pages() I indeed did not pick up on the
> nuance that HMM was wrong to use add_pages() instead of
> arch_add_memory() which updates the high_memory variable:
>
>     69324b8f4833 mm, devm_memremap_pages: add MEMORY_DEVICE_PRIVATE support

arch_add_memory() calls add_pages() ...

Thanks,

        tglx


