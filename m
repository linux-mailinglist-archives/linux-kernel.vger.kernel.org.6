Return-Path: <linux-kernel+bounces-449170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2379F4AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24A61695D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9E31F37C9;
	Tue, 17 Dec 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nn5ey3/s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E331F37C6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438359; cv=none; b=gWFmIUn/zrSAa3Nla4OYEcOeqK0NDN+Pixh027Nygv7bhWIXhv8mTY1tdrmA9nQTy/5B64CsOQmu6OW2qwuAoEd4qM9LaUmuS5vjN/5g0jxJa1C95Hymo4QUeLgbC7SNA4RsHxtMd3/UKCRvVS889v1yu6p70n80E1BHbjlt6m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438359; c=relaxed/simple;
	bh=irWJtZet4nlk1elBNcwjR/8G5fL9vEkmSHNUYwPwAiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsxniEVEWa0oaPIll3DSv/k24eRMSHJwypAL49QIrwaZMz4Ktm/ZtelDgfHNAm7WUv5uAk+5W1wpWu6mMbZQwKDYSVM4Qiot1avTGt2c/l8CnDWSU8becljEImqd2pRKL/zHoNj2vAzGsJ1fnrMtwDtBFiSS+RDI33N3KSEG1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nn5ey3/s; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734438358; x=1765974358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=irWJtZet4nlk1elBNcwjR/8G5fL9vEkmSHNUYwPwAiU=;
  b=Nn5ey3/skgEAmvNmNlxjIxdn9ryCbFPQB+IYsqAnme95fA2IAMODhicI
   blo/eBFyHLc1zsA8dux+aKdSFlMqEqyzsgO7dtd+4Hh0EOznT6Vnx8IzH
   uiqerr06gyuKTBBAWAR+YnZ+ofAncYxDmg32tn7+Mt4YzGqnHztNYBwhx
   D3sWTGMN1V4kNNNh4Z7d+cjuNxxsee7+wHIJdQ4xRfe5r2t/pKnyjjGiE
   ETd6GHAzb/adK9MIrTuvVVhIfSCvI9DsvKkUWK5MFMwPn0oQGg3gtFwCF
   r77zSjmW6G6u4Oi2vNCElS45uhI3/7jZuiOGlvbiPk3l8Fp4pId1G0BHs
   w==;
X-CSE-ConnectionGUID: ifL031mTQmaDVW43XYNiOQ==
X-CSE-MsgGUID: 1Bd73N2YRu+QXyFQ4zaBnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="22450905"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="22450905"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 04:25:57 -0800
X-CSE-ConnectionGUID: QYHr+ej4RxOao6V6hGXinw==
X-CSE-MsgGUID: UNAwxd+fTq2kNQwoGSFrpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101661627"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 17 Dec 2024 04:25:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E99273B7; Tue, 17 Dec 2024 14:25:48 +0200 (EET)
Date: Tue, 17 Dec 2024 14:25:48 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, 
	David Kaplan <david.kaplan@amd.com>, Tao Liu <ltao@redhat.com>, Kai Huang <kai.huang@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Subject: Re: [PATCH 1/9] x86/kexec: Disable global pages before writing to
 control page
Message-ID: <tksesvqt266x6a6mnoi5aqa3fhsoyo7mbp277elrrft5eieoba@7ospdizq22y6>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
 <20241216233704.3208607-2-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216233704.3208607-2-dwmw2@infradead.org>

On Mon, Dec 16, 2024 at 11:24:08PM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The kernel switches to a new set of page tables during kexec. The global
> mappings (_PAGE_GLOBAL==1) can remain in the TLB after this switch. This
> is generally not a problem because the new page tables use a different
> portion of the virtual address space than the normal kernel mappings.
> 
> The critical exception to that generalisation (and the only mapping
> which isn't an identity mapping) is the kexec control page itself —
> which was ROX in the original kernel mapping, but should be RWX in the
> new page tables. If there is a global TLB entry for that in its prior
> read-only state, it definitely needs to be flushed before attempting to
> write through that virtual mapping.
> 
> It would be possible to just avoid writing to the virtual address of the
> page and defer all writes until they can be done through the identity
> mapping. But there's no good reason to keep the old TLB entries around,
> as they can cause nothing but trouble.
> 
> Clear the PGE bit in %cr4 early, before storing data in the control page.

It worth noting that flipping CR4.PGE triggers TLB flush. I was not sure
if CR3 write is required to make it happen.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

