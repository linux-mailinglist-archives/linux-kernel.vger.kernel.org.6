Return-Path: <linux-kernel+bounces-326288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB5F9765F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B2F1F22E72
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C026199EB8;
	Thu, 12 Sep 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaS7wHx0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384F125DB
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134322; cv=none; b=TEnsUF4Fbo6hCF5KUhJfqgSFTlDY2xe4FOgajPmQlaNli7nwds+Z+z9vVe/pSEizikXeeHxqBIaSw5spCoOVe0brMuYv6l0/Pnf6ulk2r24RzuKZ/sBmLnC33bLLCvk4OGvn9btuMtwcu4aoyEvXkSROGO+0m3DeXIOg9R0djJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134322; c=relaxed/simple;
	bh=H8QEBi3zjs/yjlllv/UUtvRI0TFE+396Z3SAq8oALU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhSxeFuHrJ+HI9dv/EDRNG3e/BCeUC0EckgkZDLj7pN8OWEF5d0eVwfg6XbB6U4g3sQRRjzA5SSOtC9dZuYmA3YSWTXRe0WnG06V/4wTB2Qo6mK97mlnE03LrQsTkY0fYeybUSMg0zBXBwn/UHobHIlVUuyFGNN8o/Fa9TD3n3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaS7wHx0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726134321; x=1757670321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H8QEBi3zjs/yjlllv/UUtvRI0TFE+396Z3SAq8oALU0=;
  b=NaS7wHx0FNhAhz/rbm+HyRG99hWgyPeY5Hq27NImoy2EFTY09dOGMy6E
   sYCU4FJu72afJmpKccenfMy0e7cjHAV6NbYTPc57KuSdrhsSjXG3mUjcI
   fZyQtPpFTLxfUxhsl4vt810lD2IKNPydxd90ghBUa8iGZ1cn6SoxH5hn9
   pj+zZwNRRrxfewl+m05pem3AOePIJfdp3Eb1C3J/xJ14CJaE5nwv0Qh82
   VOkf3N2cndGUvPOr8NejNOb4GPi7SPC/ncoonzPUhJUUio0Ld8TrxzwVy
   5BUMHIDUTgiFUjYQG3np7DGj9Jhv9VQGzH1/xFQl9Z/lmNaBcZroq+g0/
   Q==;
X-CSE-ConnectionGUID: i1QJlqp6T42zVgmnE8HEtA==
X-CSE-MsgGUID: zXHhS/ntSP6pWNbI9NIobg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="42451700"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="42451700"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 02:45:21 -0700
X-CSE-ConnectionGUID: ufw+YWvcTWyWxRrm69udCg==
X-CSE-MsgGUID: JvDa7t9WS+C7ka3cBH+XlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="67888961"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 12 Sep 2024 02:45:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2DB69269; Thu, 12 Sep 2024 12:45:15 +0300 (EEST)
Date: Thu, 12 Sep 2024 12:45:15 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, 
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 0/6] x86/tdx: Allow MMIO instructions from userspace
Message-ID: <h5gp6dgcfazm2yk3lorwqms24c2y2z4saqyed6bnzkk2zhq5g2@rf3lj2a22omd>
References: <cover.1724837158.git.legion@kernel.org>
 <cover.1725622408.git.legion@kernel.org>
 <6c158a14-ba01-4146-9c6c-8e4c035dd055@intel.com>
 <ZttwkLP74TrQgVtL@google.com>
 <d3895e03-bdfc-4f2a-a1c4-b2c95a098fb5@intel.com>
 <ZuHC-G575S4A-S_m@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuHC-G575S4A-S_m@google.com>

On Wed, Sep 11, 2024 at 09:19:04AM -0700, Sean Christopherson wrote:
> Yep.  Based on the original report[*], it sounds like the userspace program is
> doing a memcpy(), so it's hard to even argue that userspace is being silly.

The kernel does MMIO accesses using special helpers that use well-known
instructions. I believe we should educate userspace to do the same by
rejecting emulation of anything more complex than plain loads and stores.
Otherwise these asks will keep coming.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

