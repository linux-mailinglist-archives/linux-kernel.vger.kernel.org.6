Return-Path: <linux-kernel+bounces-321199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52849715BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087DDB23FDB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF361B5300;
	Mon,  9 Sep 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/piXowb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45B13D53E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879397; cv=none; b=N3NTIWnJuCYnm92hYeTO9Vj5WSc4iAK33OuXJ91yTa8byQ3t+DHwzNKbbn8ylvx90SlMvvnAqDNqIK9Fhj6LCBdEKz2jXG2IxSgdpV0lQHMt42FusIipKgh/zmO4OeU2h+vQ3Ae935xfyDSs3azEhr8kF/yObV3oa0J9IPzbad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879397; c=relaxed/simple;
	bh=VlBuGee1rQuy/6yb6OlCxpUmHcR+WQworHeGnlLAgnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyx9Tv/VBDI88Jhn5fKo31FIJ55J2ByY8TBmrYXV908OLX5AX4STGCh75SeX9mJ4fI6bfFRW4p4Mf4qRfUAV4rwf/DSEmd1s3oktYaUzYLmTynhJxLziEK+1jRHLvS8Y+75bfZaoGakzCmp1FL2gbRg87gMtxMdHezdFioB3JKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/piXowb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725879396; x=1757415396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VlBuGee1rQuy/6yb6OlCxpUmHcR+WQworHeGnlLAgnw=;
  b=E/piXowbuTEFuAWY70i+eikaYCusQ1u45ElZxnm1Ta5FH1mfsRZcmdn1
   1dyu2/uvmUICUyBDp5aVhIeeOzCEQrQD+0xxGtq1ErJ0BUEh4N1yGlRTF
   auHSJ9YXRE2UXPhr+4uVP/y9stnKDape43Mi27JiO4HymqqyN7ToHMPBQ
   pDitPnUQh/MA1fgXRVUIf2FV0a05dDUPB47R4Cdqie1pCuOxPP+GpCqBm
   09b6ihxI8my+2jmalB/WXaJPi6SsFgeF/ipPG6jySFKg7Y9P83YMxdMSI
   J0vM/0pzI9Mmx3U27ISdFWR+7ERUCyFPyNMPTL+omVNnRBr29nDw7GxD/
   A==;
X-CSE-ConnectionGUID: r/UpRbD+TPysa5JjLCy2xA==
X-CSE-MsgGUID: u+Tv9h8yTv+6NnOUW2ei+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24368434"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24368434"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:56:36 -0700
X-CSE-ConnectionGUID: ZjmG40B8Twq6NhU+aln42g==
X-CSE-MsgGUID: pEvExqhaTc+ytHInD84WlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="66613220"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO tlindgre-MOBL1) ([10.245.246.140])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 03:56:33 -0700
Date: Mon, 9 Sep 2024 13:56:28 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Yu Liao <liaoyu15@huawei.com>
Cc: pmladek@suse.com, liwei391@huawei.com, rostedt@goodmis.org,
	john.ogness@linutronix.de, senozhatsky@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] printk: Export
 match_devname_and_update_preferred_console()
Message-ID: <Zt7UXNZC1UR2t1OJ@tlindgre-MOBL1>
References: <20240909075652.747370-1-liaoyu15@huawei.com>
 <Zt6xFlLyBgLhIlDU@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt6xFlLyBgLhIlDU@tlindgre-MOBL1>

On Mon, Sep 09, 2024 at 11:25:58AM +0300, Tony Lindgren wrote:
> On Mon, Sep 09, 2024 at 03:56:52PM +0800, Yu Liao wrote:
> > When building serial_base as a module, modpost fails with the following
> > error message:
> > 
> >   ERROR: modpost: "match_devname_and_update_preferred_console"
> >   [drivers/tty/serial/serial_base.ko] undefined!
> > 
> > Export the symbol to allow using it from modules.
> 
> I think the issue is with CONFIG_PRINTK is no set, and serial drivers
> select SERIAL_CORE_CONSOLE? And when serial_base is a module, there is
> no kernel console.
> 
> I replied earlier today to the lkp error report along those lines, but
> please let me know if there is more to the issue than that.

Sorry I gave wrong information above. The issue can be hit also with
CONFIG_PRINTK=y and serial_base as a loadable module.

Regards,

Tony

> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202409071312.qlwtTOS1-lkp@intel.com/
> > Fixes: 12c91cec3155 ("serial: core: Add serial_base_match_and_update_preferred_console()")
> > Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> > ---
> >  kernel/printk/printk.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index c22b07049c38..6ff8d47e145f 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2620,6 +2620,7 @@ int match_devname_and_update_preferred_console(const char *devname,
> >  
> >  	return -ENOENT;
> >  }
> > +EXPORT_SYMBOL_GPL(match_devname_and_update_preferred_console);
> >  
> >  bool console_suspend_enabled = true;
> >  EXPORT_SYMBOL(console_suspend_enabled);
> > -- 
> > 2.33.0
> > 

