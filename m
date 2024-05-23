Return-Path: <linux-kernel+bounces-187336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754198CD064
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6BC28134B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BAF13E3F3;
	Thu, 23 May 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlvA35zl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBBF13C9CF
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460414; cv=none; b=UuWtjrKB/vsRk2QOh6yIW86D2p9iCP/6CwRSKkdslfnh9uq4XX2Fzz7c4UU3mqQIZc3nm0w0wAU3gs1EYi1WN/OwaKWrHaPPvfdOiF/A/paFgMbRAOeyRvG3Fsms3BYX/ajIzoTybJ5z7qNPOhF2UMyI4Y743NvdtmbuuxXsNMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460414; c=relaxed/simple;
	bh=ovtncC1hsFhWkdiTQiooWf8UqXsASjxSdh/HMVDCFRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSRbrkUI+ZPRs6wF6jQV0R/aETumyi/kcwVUzuCwr9IYT2FV7fgQQ78VaS4RnobxqodXvx7F1cCJ2WCOaxYIHCTErQY9gbPZUMAghuPRkW1FT4cFu65brG/jciSHFYMAhPRPPN6H4SooePbViPBSu0hjIsyODl2S+t2K8U7ky7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlvA35zl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716460412; x=1747996412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ovtncC1hsFhWkdiTQiooWf8UqXsASjxSdh/HMVDCFRQ=;
  b=AlvA35zl2MxwJ5ixYRbV2WIpT2uAMbaAJ9W7Iykc8Y3Paus2jpW2aChk
   eLEU0B2tPLmMN9vXVCKcqI/f3T5NS7y2TVo4XyRc2FJiB1hPVCJF4lzVI
   /kGfImOlcpHGxR9KKl2azvgHayUsDIFk0ClUjQp/XpVE45a+cmyIvrka4
   2+Y35s8DhZZJ6J6OjlwxgzfIzxR6iIlVhhF+C1pBDXzlrdcAcRg11jpYU
   v1vQFmt8n4irOGkLMA6/eFnoXy4ZFoP/Cdl8oc59FnfW7pyjeo6bIReNc
   RrglkW0YzybhJX0AobW07MNuqlfjAOILiKLCk8UcOw+jsjw8V4un3vsoA
   Q==;
X-CSE-ConnectionGUID: zVCk9TEjTUWAiF1mOzNUQQ==
X-CSE-MsgGUID: k+KU97RbRWKfzaW748/M2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12943320"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="12943320"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 03:33:32 -0700
X-CSE-ConnectionGUID: FtUu+GXVSQyvzoXivF7NpA==
X-CSE-MsgGUID: Y5c0myN4Sz+GWX3W6QEigw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="33467268"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 23 May 2024 03:33:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2083B3D1; Thu, 23 May 2024 13:33:28 +0300 (EEST)
Date: Thu, 23 May 2024 13:33:28 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [Patch v2] x86/head/64: remove redundant check on
 level2_kernel_pgt's _PAGE_PRESENT bit
Message-ID: <fej5k6ikc3biecm5xadxgwv2pflktpjmvrxjhzmhia4p5kipun@ny3swf6kcqwi>
References: <20240523083752.11426-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523083752.11426-1-richard.weiyang@gmail.com>

On Thu, May 23, 2024 at 08:37:52AM +0000, Wei Yang wrote:
> This patch tries to remove a redundant check on kernel code's PMD
> _PAGE_PRESENT attribute before fix up.

Tries? s/This patch tries to r/R/

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
> Since we have compiled in _PAGE_PRESENT in this page table, it is not
> necessary to check _PAGE_PRESENT again before fixing up delta

level2_kernel_pgt compiled with _PAGE_PRESENT set. The check is
redundant.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov

