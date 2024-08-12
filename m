Return-Path: <linux-kernel+bounces-282653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB0B94E6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD0F2837B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858215C12B;
	Mon, 12 Aug 2024 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laXWViRi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED0152199
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444798; cv=none; b=oHvwPf7q+ILhi9A9nxXYIbywIvMr+QaWymrdPRQpS4i3fpoCQ/l0YXBxbvP4yaDCsLPzM6rwBDepmTpPoJVB0wL/ctxw3j6PmtRAb0ppyxVXnausDwyzShmIR6jwfiDnq91Is/HhRL4KV06zfa1Ou7kEDmrGsSYTmJWXV8Qp0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444798; c=relaxed/simple;
	bh=UOuFB5eh/iaMWzI/UeZaKQ7ZMMjmM4pqc2zT4gMg6zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMdI9CwVF7n1RKCF7+24c3BzGkYOXcweHurY5oZFNJkE6B1cyRJk8/qa763CMgIH1tcbOMkKKlYGb9idPK5ELiRPpuHDob32OhLlXheW1BvXac9RY7i+d/2eiahX6lP+vOzCwJBgJDdppKMkgSq9yRc7TOnH/iypS45axGibB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laXWViRi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723444797; x=1754980797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UOuFB5eh/iaMWzI/UeZaKQ7ZMMjmM4pqc2zT4gMg6zg=;
  b=laXWViRipxUId2GCJ882UYxLFYiPcBsNIq6oNSI2j4d0llaZziFEdI7a
   pKbwOCNMgs+q8mh3/Ob804/WaqBtjKjzRg5C7CB9zx9B/LlKrg8X+b1jY
   MQZ0qVFCW0mCXTc70QE6Ubl1shMS76z/oFbCrRfR3o9x7sNYVomuDuq9g
   Gy9FO/eGtZY0EbDBKvqmTFgr5Wkz3wxUESjhdHntUeQYiPSzJuoMuHaJ8
   /Lp7zLDZklky5nCYeqWkUlDrErDz0mnQCl5jLRQQ6m5nas/LCK8T+Elek
   xh6FFrK58u3BAJXRiyRRjvo+lxeCZxnAtL4YSqZGywHeieVSe8ibE4M9Q
   A==;
X-CSE-ConnectionGUID: u3W9JCeKSbCbDioNte9rUw==
X-CSE-MsgGUID: yPAjfoOIRZGNsvQh80Li9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32211197"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32211197"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 23:39:56 -0700
X-CSE-ConnectionGUID: 3++LnOBFQKa4joaI92Baxw==
X-CSE-MsgGUID: dSJGNwtaRciH+Mhnymhtzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58721949"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 11 Aug 2024 23:39:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7E35F1F8; Mon, 12 Aug 2024 09:39:51 +0300 (EEST)
Date: Mon, 12 Aug 2024 09:39:51 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: remove unused CR3_HW_ASID_BITS
Message-ID: <kyuxup4aoeuewrisn4smwaw2gmi7zupgcjgj2vhm4t6pxbbalo@y26e7sdih3zq>
References: <20240425215951.2310105-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425215951.2310105-1-yosryahmed@google.com>

On Thu, Apr 25, 2024 at 09:59:51PM +0000, Yosry Ahmed wrote:
> Commit 6fd166aae78c ("x86/mm: Use/Fix PCID to optimize user/kernel
> switches") removed the last usage of CR3_HW_ASID_BITS and opted to use
> X86_CR3_PCID_BITS instead. Remove CR3_HW_ASID_BITS.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

