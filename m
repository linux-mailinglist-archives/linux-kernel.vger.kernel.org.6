Return-Path: <linux-kernel+bounces-187483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA808CD262
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B04A1F22ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28084148834;
	Thu, 23 May 2024 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuS+e5JH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC01E4B3
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468063; cv=none; b=svUf4/YRUUrQKLZhCz+3mB2PHnKRKacmrE0t/lbQf5W8474VzGK8aRxIT6618mD8XIFhDrHEI7ah7F9IhEAVzxSdLctrS6+hEcyF9eLhJ3sVB161ztRXpvg5VDkjmQW+hLA5h/Vyo+C3vOPuCrnnGp7Q34cjHzN/WBFghgLEgG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468063; c=relaxed/simple;
	bh=TACJdT4OuSHZHHTmCDOU5pephYt4f6iNsHPpUY1BkX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFJWSmbM6n8tqrPl4ZdJ5f/PcO3n4hpX1z4CypUOWXhr71qDl1PhVF1TvlVUuSwqGI9IV7e/wzP5HqmMA/gVF+cRTw5WOVkIOiB71JJLtE/HWWB3KD0N3vgOM0JTvraPMcB75WUaBZ5B9ywWqRouOp/mDXGpv3qp4iPFZBMyM2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuS+e5JH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716468060; x=1748004060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TACJdT4OuSHZHHTmCDOU5pephYt4f6iNsHPpUY1BkX0=;
  b=fuS+e5JHvi3d+yVlpEY6oZuRBzoqGd9gWyRQxXBsrDrJcoUj6btrq4KC
   YQ2XsRLi4INOgvPRzRbmRS5uFSXearIBOErEJQZcSyO+RPTPR6Lcl0Exq
   PZEQwH4LuFfAqsrnirr63KlEOSuvEOg3x1oitI6webXITmChMrCOo8Fi3
   aqWSY1bZa0bgZtSr2BastHup6mL9c7/m8G9usWcnQJH8x8IQqa8ONfTF4
   NA74F9N04ny1QrbJRjMoeZd97EahASC3prWuqViDPNchgDnCxKlUU+cMX
   8SKHdRSFv8i/W5UmbmzFgpovpO7rX7ByZuTn33Bs30XiONat0A+TSHQHP
   w==;
X-CSE-ConnectionGUID: BetmY28SShKMU8D8jRIMCw==
X-CSE-MsgGUID: 7Nggqdh+TUqNAfPUoRrrmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="24191185"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="24191185"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 05:40:59 -0700
X-CSE-ConnectionGUID: 09+nUypJTuqZaMuj77Scsw==
X-CSE-MsgGUID: 3oFoL+ayQF+Oxc1jncHy0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="71067955"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 23 May 2024 05:40:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CD271E7; Thu, 23 May 2024 15:40:57 +0300 (EEST)
Date: Thu, 23 May 2024 15:40:57 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [Patch v3] x86/head/64: remove redundant check on
 level2_kernel_pgt's _PAGE_PRESENT bit
Message-ID: <wwmqtzeukfrzriysxe3b5ueo5iehqnaf55puaok33cbu56pemb@rzq2m7naja4q>
References: <20240523123539.14260-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523123539.14260-1-richard.weiyang@gmail.com>

On Thu, May 23, 2024 at 12:35:39PM +0000, Wei Yang wrote:
> Remove a redundant check on kernel code's PMD _PAGE_PRESENT attribute
> before fix up.
> 
> Current process looks like this:
> 
>     pmd in [0, _text)
>         unset _PAGE_PRESENT
>     pmd in [_text, _end]
>         if (_PAGE_PRESENT)
>             fix up delta
>     pmd in (_end, 512)
>         unset _PAGE_PRESENT
> 
> level2_kernel_pgt compiled with _PAGE_PRESENT set. The check is
> redundant
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> CC: Ingo Molnar <mingo@kernel.org>
> CC: Steve Wahl <steve.wahl@hpe.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

