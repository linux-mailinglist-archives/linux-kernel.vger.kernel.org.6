Return-Path: <linux-kernel+bounces-293547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FDD958129
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007821F243FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D167418A6DB;
	Tue, 20 Aug 2024 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7ss6Qb4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651118E342
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143255; cv=none; b=bgzoGVYciUEU6vcj0E/SVf4X9XniZax/H4RVsNxF4W+sDMabjdLWB3EsLn6vOJ891mcCCy3/EsbrCIKeMb59Cb5Oyy6vwZ5lDBfLSs5aLs1ozdAb1GqsU5DK3zdwYEy5JSLTG90qtvgGkOeJkG/3IcInEdO2mH6qRQsHK/AWBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143255; c=relaxed/simple;
	bh=ljARAaynoP2SyNkejh1KBYHaeFGPkEmlRtmFUEtYfZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rxxn1EwXZxLKZNMhtTD+i7d6XPdbbvQGNhg8PZYy+gu+pRxp5hFjNyhmTKtvm/rX83lttU9Vo1qd4zmUxOpS/WKkdY/lDnOar1lLMw5rpqiOHEkcTOzMOEUPpSIo1NaNth4V8WBLldZTjz6kE04YMKetr+QQ/T5a0tShD7LIeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7ss6Qb4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724143254; x=1755679254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ljARAaynoP2SyNkejh1KBYHaeFGPkEmlRtmFUEtYfZM=;
  b=H7ss6Qb459EjG3FVYPPMSlkmuxrq5KvKzSudG+vWMgu+NvazXdd9OgZD
   kEtuhguUx2B1EPg7kfP3WDhRuXpwhMeAuo0Mvo5yRS+ozQis0UqvTybCs
   YNejFXC0pHukoUJGiGgPvB7x3s6lOf0aeHd4lAOCGyBkaDNfnmBLxWQHK
   GZKGG7s4h7rdStBbua/OlY7wc5N857XzZDFe6tXZl60KDvyxEIXUXa5Hu
   W5N5vhUehGJL9bde48ecbqlizfMESyQEL9+Age0bB3mf3I7tvBvCPYiAa
   Ld5B5UGnRBkHM516yG6/+z8i8ApZxEByxO8BzpQIVMBlDQYZL7AMfEalL
   g==;
X-CSE-ConnectionGUID: zH4FZq+gQz+FT0AOlRo/gQ==
X-CSE-MsgGUID: Ri5OckwlRQiTHLG1rg64kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22565385"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22565385"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 01:40:53 -0700
X-CSE-ConnectionGUID: XaaGH8vsT4G9JiG0oNP+kw==
X-CSE-MsgGUID: Pz4yN6CLRD63BZJnh/xy7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60819638"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 20 Aug 2024 01:40:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 572E0152; Tue, 20 Aug 2024 11:40:44 +0300 (EEST)
Date: Tue, 20 Aug 2024 11:40:44 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kai Huang <kai.huang@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@intel.com, hpa@zytor.com, peterz@infradead.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, nik.borisov@suse.com
Subject: Re: [PATCH 1/2] x86/kexec: Fix a comment of swap_pages() assembly
Message-ID: <q2y5vte3wwn5qde5p4nfmjfqtzxfen3nhjdyafc7nbirfidpvr@ro3djjz3pub4>
References: <cover.1724068916.git.kai.huang@intel.com>
 <d4538576fc5eeab2e4f3ea4c5111dc9597369ed4.1724068916.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4538576fc5eeab2e4f3ea4c5111dc9597369ed4.1724068916.git.kai.huang@intel.com>

On Tue, Aug 20, 2024 at 12:21:11AM +1200, Kai Huang wrote:
> When relocate_kernel() gets called, %rdi holds 'indirection_page' and
> %rsi holds 'page_list'.  And %rdi always holds 'indirection_page' when
> swap_pages() is called.
> 
> Therefore the comment of the first line code of swap_pages()
> 
> 	movq    %rdi, %rcx      /* Put the page_list in %rcx */
> 
> .. isn't correct because it actually moves the 'indirection_page' to
> the %rcx.  Fix it.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Looks like it got broken by 4bfaaef01a1b ("[PATCH] Avoid overwriting the
current pgd (V4, x86_64)")

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

