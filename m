Return-Path: <linux-kernel+bounces-220874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BCC90E871
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825261C2266A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7E112D1E7;
	Wed, 19 Jun 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMiBtqbr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F53012D758
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793474; cv=none; b=bLnLSX6esB+/v6/KzM2wRf1iQYKV7kY+qygX79BVWLcjfDAnJj8JjtAZwIYXPdWxQMUkAZ7ZoUIrWwfhEQiQMtWVGbiqiGg0IxZNPWIWD775N/LyqjDshdUdSBQ+rx206VSubxmuNAn9OGD8nnzLIrhD8RPJTnV/yU2ekZjuiK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793474; c=relaxed/simple;
	bh=6+ZzL6rs2GfKv3zWcepskLbzkzrPZs+F7QCln1TKk/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxAQBCKZo38bjTr/Zgx2MiFjlSEzaiZfQfJo57FRsd0ceTYQ8Hq/2aCTySu7yM+z3iRLC4tgnQF/HiNxjY6t0WIHlNLFnmbwRgvaXpD5AbqlXYuRmgdEv05R8VxsPGm3/1yfudKfz45MI4SnKH4hSyLC+mKacgKfSg+4eRmG0fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMiBtqbr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718793471; x=1750329471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6+ZzL6rs2GfKv3zWcepskLbzkzrPZs+F7QCln1TKk/c=;
  b=cMiBtqbrlq8yNLeV8HaJfSLbEI+uWNJP16tDYflqWjPq+QSLV6eQi0x6
   7sKSG+r1bhaBFgytDupTByimDttV/0d5+bDy6PtFi7QuXmNMs8RB15SEV
   YVMzcUADuxsr6okSTHEwT+AECb4ggiiFHDLiBpDN+xTRXOJrFty8/lADE
   OQ3xRaztNGu2zE4ylmaGk2Ov+sUfKnhm2+/2U42Uius+TwET382zum4pJ
   Q4cbeBlc0hW1c85Dh0zBcCyHg1evUC6q9bPnV5uJ1xuqaBIC/MqZN7U5Y
   8TVL7aUs9GEAC2KIyNVSwm5Ru3L6ynsLi6JKkL6vguE32ynxNueSwO2lQ
   g==;
X-CSE-ConnectionGUID: H3P73Um/SUC7JR5A4UW3dA==
X-CSE-MsgGUID: pBzD9F/zQJq8b67Y+K0YTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15691564"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="15691564"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 03:37:51 -0700
X-CSE-ConnectionGUID: 8Vpr9nH1TsWxW/5cZ2/IkA==
X-CSE-MsgGUID: wyO5WjNOSV2v72V2AJeNGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="41832687"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 19 Jun 2024 03:37:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 24F5A241; Wed, 19 Jun 2024 13:37:48 +0300 (EEST)
Date: Wed, 19 Jun 2024 13:37:48 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: dave.hansen@linux.intel.com, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH][v3] virt: tdx-guest: Don't free decrypted memory
Message-ID: <uggd72vugduczhkifii57aflkv4hxsija5iwyqvxdr24tbysus@nq4xx7putbxg>
References: <20240619084750.9207-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619084750.9207-1-lirongqing@baidu.com>

On Wed, Jun 19, 2024 at 04:47:50PM +0800, Li RongQing wrote:
> In CoCo VMs it is possible for the untrusted host to cause
> set_memory_decrypted() to fail such that an error is returned
> and the resulting memory is shared. Callers need to take care
> to handle these errors to avoid returning decrypted (shared)
> memory to the page allocator, which could lead to functional
> or security issues. So leak the decrypted memory when
> set_memory_decrypted fails, and don't need to print an error
> since set_memory_decrypted will call WARN_ONCE.

Add "()" for set_memory_decrypted() and WARN_ONCE().

And put the solution into a separate paragraph:

s/ So leak/\n\nLeak/

> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Otherwise, looks good:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

