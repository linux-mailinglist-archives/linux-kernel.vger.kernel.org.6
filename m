Return-Path: <linux-kernel+bounces-406179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0F59C5BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559E81F22764
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596302003CA;
	Tue, 12 Nov 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LP3eNWXu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E6C2003C9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424902; cv=none; b=I4GpB/aQ53FT9bWlgNoFalEav7L6f9glVriyAt4jDAv5MFiFy61lwHTry9IDmPblyNGAOG/82A7/P2BvAEkGCFK+8JbuieM6Rxdsf9m3PHLUPc0Mk/LIV5Cr2WbnhLVIqbHQBZAqDiVhAWqzOMn+UK0sCl8etX55x3RnXZL47Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424902; c=relaxed/simple;
	bh=er4PJTicIYffSe6+e9Td7WCRIaSF+o4AElRrQEg4mLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+/TUMxAwou8IhcB1kc72Ez30pEPEhCbAbtvEE4fq72vjH/nbG9D4rKAtfmWoy2E3kPnYhkJDSybNwNb4quTnNH72+HteMYLRC+71D5Hv+ZQsIE0PWcQ6xYjYpSjIBVxYLKo4akpHbKH0JaFfmMrHo78JCKKitE3oGTqTaw/Zys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LP3eNWXu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731424901; x=1762960901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=er4PJTicIYffSe6+e9Td7WCRIaSF+o4AElRrQEg4mLM=;
  b=LP3eNWXu0aoN6WpF+Yy2ga4djKKhbgjbExQvetA+3sMm8JXA/8nQpsVs
   PIe0ELLgMXIBk42m4tIdJ1veAVNDA6VIFKHr/kEoCPO6NJrQnXfaGRvbW
   pwqFAQJX12f5VLx0EHHN1sO8r06cJBYczEJfw7Rjy2Kswhw++5ZO9Qc25
   O2Cc7XJQ0WpMoEYkoenJs6xmZL6nf1Aorfx1qBh10Nc2BTWKsUvXwabm4
   5dS5lsiz4Iq2GfsFVNbMjvh3Ax414/xZbQGRbFNaKT35HCL+fhuO4UWdb
   jZKV7Kkdvm0YyJjkk4xgKZD7jtMJMNQUOd6Yme4bAb57XnaYbeBT3aKMn
   w==;
X-CSE-ConnectionGUID: Jh/B4WH5SqKzwvOHVtsSeQ==
X-CSE-MsgGUID: sbF0dXP6Qy6tWqhgyYKN8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="41874039"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="41874039"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:21:41 -0800
X-CSE-ConnectionGUID: wMtIHsZ7SGOTjFcfGERlrQ==
X-CSE-MsgGUID: QK23n+MwSyKsgCRvXwTaBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87096546"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:21:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tAshz-0000000E2YE-2izT;
	Tue, 12 Nov 2024 17:21:35 +0200
Date: Tue, 12 Nov 2024 17:21:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] printk: add dummy printk_force_console_enter/exit
 helpers
Message-ID: <ZzNyf6nA8dh_joYd@smile.fi.intel.com>
References: <20241112142748.673772-1-arnd@kernel.org>
 <20241112142939.724093-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112142939.724093-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Nov 12, 2024 at 03:29:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added interface is broken when PRINTK is disabled:
> 
> drivers/tty/sysrq.c: In function '__handle_sysrq':
> drivers/tty/sysrq.c:601:9: error: implicit declaration of function 'printk_force_console_enter' [-Wimplicit-function-declaration]
>   601 |         printk_force_console_enter();
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/sysrq.c:611:25: error: implicit declaration of function 'printk_force_console_exit' [-Wimplicit-function-declaration]
>   611 |                         printk_force_console_exit();
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add empty stub functions for both.

Does it compile with `make W=1` without warnings/errors? If so, I am okay with
the approach.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



