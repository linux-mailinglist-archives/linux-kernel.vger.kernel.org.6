Return-Path: <linux-kernel+bounces-170079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845F38BD19C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A856A1C21EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F337B15538A;
	Mon,  6 May 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BU5s3pTv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BBF1DDD1
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009849; cv=none; b=C0O7Cjy1E+ComYU2Pk+6c5pkK1dhfumP02aPXFu2Xr8tqpfwBHnqpt+PhKqEI8r5y5A7+6AI4rc/xPRKwFdMBzzZ0sGdrJTd7bOQJ7lqzY+8X9cGQEUJEtd+vZU8ZN3dey6Rg1rSSztZdAZL0z6Wrlh8/ILAuXxQgp74gCjc7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009849; c=relaxed/simple;
	bh=u4Wbi+kWAVVOkhZHAsKkhw70PBDqYs/mFsVXLQcsk3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMZl8txZHo6GQ6cDVWxjT4oZrLLmg9DB8u21hogdtjbbgyoL91EaTF++0vNKryjSxURd0YMRit01yU+lFvWo/evc055X29HDHNAr0ThZXhaTcvOV0DvhSHzhTZMAcuYrGKx68MSCdbCgdBXaE6sI5sSyHXVgm54BtZl+PUhrSo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BU5s3pTv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715009846; x=1746545846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u4Wbi+kWAVVOkhZHAsKkhw70PBDqYs/mFsVXLQcsk3I=;
  b=BU5s3pTvTQbvLxo13/pKxVagcRlA+QY6JLZ74zpPHpL5XcQggQczNvVv
   pgBZ2tFuqUhhhWAUmRCPeiGMCAGqVoxqcbCVTYOtGOqzKebwCIze8bufS
   q3e8WrUweySQBGxYgYaYbym23o5ycUdhszd6TcgxEDNheekGqY/LZfyYc
   2Z3put3m3QJTyJXaUGnjfq+V4F89MVfP8t0kI+opoxBWTwqty4077bjMa
   qj6UmdFQ8nhoHZGJVvyW1G9ZJ5bHBAoKWwL6ngUeCnxWBhOao39Gzf3ZD
   gCwmLaeRgWxmLramyBsMp2N89kwn4A1WKJ25cDk+hTW4XvzZqRUAc/VLw
   Q==;
X-CSE-ConnectionGUID: /4zh8ZKkTlSpWN/Khr8dEg==
X-CSE-MsgGUID: WV4HnkVDRuObGl7iATKYKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10608288"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="10608288"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 08:37:26 -0700
X-CSE-ConnectionGUID: 3HZKYHL6T1iq+bktUHzxsg==
X-CSE-MsgGUID: Qu6O7tEHQ1+L0dn0IGA/aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="59384212"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 06 May 2024 08:37:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9D7D9161; Mon, 06 May 2024 18:37:19 +0300 (EEST)
Date: Mon, 6 May 2024 18:37:19 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 10/18] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <bpmagk7v6swftzjjpchplzjwgx3pbdqzklcxybrmrhprqizk45@lxmvva42z36g>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-11-kirill.shutemov@linux.intel.com>
 <20240505121319.GAZjd337gHC0uhk6aM@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505121319.GAZjd337gHC0uhk6aM@fat_crate.local>

On Sun, May 05, 2024 at 02:13:19PM +0200, Borislav Petkov wrote:
> On Tue, Apr 09, 2024 at 02:30:02PM +0300, Kirill A. Shutemov wrote:
> > TDX guests allocate shared buffers to perform I/O. It is done by
> > allocating pages normally from the buddy allocator and converting them
> > to shared with set_memory_decrypted().
> > 
> > The second kernel has no idea what memory is converted this way. It only
> 
> "The kexec-ed kernel..."
> 
> is more precise.

"second kernel" is nomenclature kexec folks are using, but okay.


> > @@ -831,6 +833,73 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
> >  	return 0;
> >  }
> >  
> > +/* Stop new private<->shared conversions */
> > +static void tdx_kexec_stop_conversion(bool crash)
> > +{
> > +	/*
> > +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> > +	 * conversions to finish.
> > +	 *
> > +	 * If race happened, just report and proceed.
> > +	 */
> > +	bool wait_for_lock = !crash;
> 
> You don't need that bool - use crash.

Dave suggested the variable for documentation purposes.

https://lore.kernel.org/all/0b70ee1e-4bb5-4867-9378-f5723ca091d5@intel.com

I'm fine either way.

> > +
> > +	addr = PAGE_OFFSET;
> > +	end  = PAGE_OFFSET + get_max_mapped();
> > +
> > +	while (addr < end) {
> > +		unsigned long size;
> > +		unsigned int level;
> > +		pte_t *pte;
> > +
> > +		pte = lookup_address(addr, &level);
> > +		size = page_level_size(level);
> > +
> > +		if (pte && pte_decrypted(*pte)) {
> > +			int pages = size / PAGE_SIZE;
> > +
> > +			/*
> > +			 * Touching memory with shared bit set triggers implicit
> > +			 * conversion to shared.
> > +			 *
> > +			 * Make sure nobody touches the shared range from
> > +			 * now on.
> > +			 */
> 
> lockdep_assert_irqs_disabled() ?

Yep.

> > +			set_pte(pte, __pte(0));
> > +
> > +			if (!tdx_enc_status_changed(addr, pages, true)) {
> > +				pr_err("Failed to unshare range %#lx-%#lx\n",
> > +				       addr, addr + size);
> 
> Why are we printing something here if we're not really acting up on it?
> 
> Who should care here?

The only thing we can do at this point on failure is panic. It think
it is reasonable to proceed, especially for crash case.

The print leaves a trace in the log to give a clue for debug.

One possible reason for the failure is if kdump raced with memory
conversion. In this case shared bit in page table got set (or not cleared
form shared->private conversion), but the page is actually private. So this
failure is not going to affect the kexec'ed kernel.

> > +static DECLARE_RWSEM(mem_enc_lock);
> > +
> > +/*
> > + * Stop new private<->shared conversions.
> > + *
> > + * Taking the exclusive mem_enc_lock waits for in-flight conversions to complete.
> > + * The lock is not released to prevent new conversions from being started.
> > + *
> > + * If sleep is not allowed, as in a crash scenario, try to take the lock.
> > + * Failure indicates that there is a race with the conversion.
> > + */
> > +bool stop_memory_enc_conversion(bool wait)
> 
> This is a global function which means, it should be called:
> 
> set_memory_enc_stop_conversion()
> 
> or so. With the proper prefix and so on.

Sure.

> > +{
> > +	if (!wait)
> > +		return down_write_trylock(&mem_enc_lock);
> > +
> > +	down_write(&mem_enc_lock);
> > +
> > +	return true;
> > +}
> > +
> >  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> >  {
> > -	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> > -		return __set_memory_enc_pgtable(addr, numpages, enc);
> > +	int ret = 0;
> >  
> > -	return 0;
> > +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> > +		if (!down_read_trylock(&mem_enc_lock))
> > +			return -EBUSY;
> 
> This function is called on SEV* and HyperV and the respective folks need
> to at least ack this new approach.
> 
> I see Ashish's patch adds the respective stuff:
> 
> https://lore.kernel.org/r/c24516a4636a36d57186ea90ae26495b3c1cfb8b.1714148366.git.ashish.kalra@amd.com
> 
> which leaves HyperV. You'd need to Cc them on the next submission.

Okay.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

