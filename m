Return-Path: <linux-kernel+bounces-234962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E6191CD89
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FD01F21EF5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C824B5A6;
	Sat, 29 Jun 2024 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuTOzR5t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A54C99
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719669855; cv=none; b=uxBSu5qQC1/XlEbQcwUi7TM+qRrlYOzmn6v/x1TwFtK5etWXVrjIHsfzyIf03rjP2uvy5T7RRV6dm0V7/r2SaMR5Fn3zycBTLuJ+7JTbifq6KZQYrZEhsqEaVlkpDapMbvCNWq6PPbp1hsKOD+NmVJAu3sKw36Od9zIV3PT4sFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719669855; c=relaxed/simple;
	bh=5BmhQ9F7ttoYPRCcC0d8Lj6aXmR+zf4vxXS4iJbiM18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grAkJt0Tp+Y33m6G5YUylOR2+DxA5qJ8q0R44QqUUqgXc+DyD9AxViwkKqUJq/KzcbeTbSemyWWNTa/Dm2FLhQbHVpKjiyS/xnrXX9/LzISLKr1UZg+Wfy+j1VB+kUKhe3tBfbeKjHN9PMVKi3gzlBZZAmaB76IgmrT3w7CdXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuTOzR5t; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719669853; x=1751205853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5BmhQ9F7ttoYPRCcC0d8Lj6aXmR+zf4vxXS4iJbiM18=;
  b=FuTOzR5tQFCRRP6ZSlViN+A4dY8dcxdj2Gp3UJ+89O1m/5p6ZKq5CJJb
   LKBOy0n42GcMcPpYUk5t+PH2nw792wbsN6XgUReBhH88A78cPPNHUKZdZ
   mZcD2H3ymxGf2dK0ez3QXQop/qZ7wtx888Vbo7IWbk9gcLsK9zw4quftD
   Iw1sqsYzgIAVqLATq4Xa5yflMak283leRlTifPcUGF1W2x0yCotIdzcuZ
   6wm827yLOnFZfOFaYJXak3E2qcpMSqaU77O0ZR4ixeSRoNddIC3DwN0Ts
   jyIMCYcnswuEAlbk6UfncWnLv0QW1jf469MTVgUjJWmRzolbScpwPRFGd
   Q==;
X-CSE-ConnectionGUID: cAJ2s/KeRQGxEkoWaxGRUw==
X-CSE-MsgGUID: GQl4HNlXQmGBOEz9xIAvpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="34379461"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="34379461"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 07:04:12 -0700
X-CSE-ConnectionGUID: OmsxdMKDTLCVoCHsvhNQeA==
X-CSE-MsgGUID: 2osVXlujQSCPsSppXIL39A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="44915433"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jun 2024 07:04:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 78317215C; Sat, 29 Jun 2024 17:04:08 +0300 (EEST)
Date: Sat, 29 Jun 2024 17:04:08 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Michael Kelley <mikelley@microsoft.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec
Message-ID: <poxeykijyqrz5hxrey46s6hh2qd6byirbevwuwec2gtbfq266c@npegk7sn3ot7>
References: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>
 <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>

On Sat, Jun 29, 2024 at 03:59:33PM +0200, Borislav Petkov wrote:
> On Sat, Jun 29, 2024 at 04:06:20PM +0300, Kirill A. Shutemov wrote:
> > The function tdx_enc_status_changed() was modified to handle vmalloc()
> > mappings. It now utilizes slow_virt_to_phys() to determine the physical
> > address of the page by walking page tables and looking for the physical
> > address in the page table entry.
> > 
> > However, this adjustment conflicted with the enabling of kexec. The
> > function tdx_kexec_finish() clears the page table entry before calling
> > tdx_enc_status_changed(), causing a BUG_ON() error in
> > slow_virt_to_phys().
> > 
> > To address this issue, tdx_enc_status_change() should use __pa() to
> > obtain physical addresses whenever possible. The virt_addr_valid() check
> > will handle such cases, while any other scenarios, including vmalloc()
> > mappings, will resort to slow_virt_to_phys().
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: e1b8ac3aae58 ("x86/tdx: Support vmalloc() for tdx_enc_status_changed()")
> 
> I'm going to zap this one from x86/urgent and give you guys ample time to test
> thus stuff better and longer.
> 
> Also, what is this e1b8ac3aae58 fixing and why is it urgent?

Daxuan, how urgent is this fix for you?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

