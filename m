Return-Path: <linux-kernel+bounces-224915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0EA9128A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759A21F2680A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DEF383A5;
	Fri, 21 Jun 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6nwqOYW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6AC383A2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981867; cv=none; b=oRGJYYBmsHxlGEPb9roAcINbqEazo5oNLh2k17JYVPrBjV04EWnpqJ3TA3mYR3wbmQIMHKP3LFWQnGkddDaoGuq54HOpQLiPLvpbjm31s4645V0jNa6mIHyI6Ufrwf+7sELRGNwtAFV5zBkrisXDwsrozHTpYKW3a3HhO8jTi38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981867; c=relaxed/simple;
	bh=f+FI8F/RVw+kmJ2lzU7rBzGsP7+oH8tGfXkDtW06Y4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrnMcpZlbZUNCEXhLuXvnBwF1k8gMA/oUf+eLNlN/42Mi6Pjajl3yAhNNqboXo/uyMhx7OwG8+jMd+jwdzbeVMFTSK8tnAGU4jku0cng7KE3aQNu3D83pnL7FhVlyjybcdwQSRis9zZRPtKStaA00NQS8y+hsWmugNt5m8T/D7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6nwqOYW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718981865; x=1750517865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f+FI8F/RVw+kmJ2lzU7rBzGsP7+oH8tGfXkDtW06Y4M=;
  b=J6nwqOYWkYINcZ4ktVZYdR7i80EQOJy2a6//5s6rhm9D1CLugZJWeDdE
   IcBF4ugQbKPg/nMamKz7mAg8CwbHgZ8nsxnyyLw/gQ9ZrgIqU/5hP72NI
   NsABhRQCLHKOIGmYTFAmSBHlhwqnFCl6D4WBZ3btD5w2bRpDzCe3qy3QM
   5q6GhG1q6xclVTEpJSSE1r3oGHZdY5imnIoAC9zbkIAphR8aH9MIOafCT
   0XIUHu/Ff9MCjU83JhrffdmOBVdQHV5n46hr5Pfxb3nmNvikva1tp7Kti
   D8HmnJtxFKddwWJ2NgVXOJ+ddkbXQnmv2pu6806FTqhIFTbHp3CTAg2ab
   Q==;
X-CSE-ConnectionGUID: UEX4QxXITWSNDWv1NpZfZA==
X-CSE-MsgGUID: UKE64xNyQuqFChWqto3SXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="19901453"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="19901453"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 07:57:44 -0700
X-CSE-ConnectionGUID: hbo5rgyHTUKD0mlS+syVgA==
X-CSE-MsgGUID: FfylbZ6vQaaFX1yW3aDQMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="43296381"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 21 Jun 2024 07:57:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4CA2E1D6; Fri, 21 Jun 2024 17:57:40 +0300 (EEST)
Date: Fri, 21 Jun 2024 17:57:40 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexander Potapenko <glider@google.com>
Cc: elver@google.com, dvyukov@google.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, akpm@linux-foundation.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/3] x86: mm: disable KMSAN instrumentation for physaddr.c
Message-ID: <pi2i2qtsrip43yjji3ao26oqazplbkelma7hv24onxymkisqzm@ee6zflgdgmrc>
References: <20240621094901.1360454-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621094901.1360454-1-glider@google.com>

On Fri, Jun 21, 2024 at 11:48:59AM +0200, Alexander Potapenko wrote:
> Enabling CONFIG_DEBUG_VIRTUAL=y together with KMSAN led to infinite
> recursion, because kmsan_get_metadata() ended up calling instrumented
> __pfn_valid() from arch/x86/mm/physaddr.c.
> 
> Prevent it by disabling instrumentation of the whole file.
> 
> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Closes: https://github.com/google/kmsan/issues/95
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

