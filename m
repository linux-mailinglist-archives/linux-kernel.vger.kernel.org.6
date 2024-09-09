Return-Path: <linux-kernel+bounces-320915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D4971200
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC031C228FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0451B2516;
	Mon,  9 Sep 2024 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNZ0J2Mw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5F175D25
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870431; cv=none; b=BLz5eo78F9rW43Lu+kd79MYNvc6K3gR8pS5YP6i5GCbsP6NhkEZKqUA2QHvHvR0RG3ep4AVIAuA6C1PYWey48O0Us7bD2cjInsYAdeM7toM8oo4GjFB5PGIa4I2hRI/fKD2r/dBtKp1ubswIeSRznMqmfbdXW2utsX6mNZhtkUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870431; c=relaxed/simple;
	bh=YRo9UcMzpC7O+kL2mc1cZ00e86NiB2aYWXwH+YHJEkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ9z7RlmGZWh4+CF2n6KlxM3XmulMXe8SLdO8SNfbacDXgQqQXXo9oRWCHKtNTJZaFdxMKd//gRhCFFSLWM3rXFoifpFK9Vn3qwYm9geB/vvIGunpw4X5i+nt7OsNNvETrT8IoMCenbKhwoopgO6Hb9iqpH1WmwbFhgdnUJAsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNZ0J2Mw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725870430; x=1757406430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YRo9UcMzpC7O+kL2mc1cZ00e86NiB2aYWXwH+YHJEkA=;
  b=TNZ0J2MwRzoKmMzqvrN/yikF+iLAjqaSNaUqEWVXP01an0dgXeIxsQT+
   99Of4ZG16IEtpoCQQRy3k5i0VFwyFjAbiRQPfHiQlD+11s0HWH1yngCYU
   dJImcBqfzzlVjuEJFHY80gUqEs5UHJiLyCDzAAxhurLVTO6Hvcj9sosf/
   ZFvIQS1pPrkCQxHySiCzPviYBeId4OS/s+DLvQaV+2KWgo+O/IoDQt+zb
   CZ32v58//VlA7E94fqW1FD1xh92zPPSS+cCLFq9nDDxHm4JagOPL7v8HP
   XD609u0Hfw0bR8XDnJEdM3FX023R/fJS2D1sH8hmTcFQMYZmcoXPJdIdV
   g==;
X-CSE-ConnectionGUID: lpJVgxrLSsOE6t/4bYhKiA==
X-CSE-MsgGUID: 1jlC05kXTCSbBLFWK3hUdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="35694994"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="35694994"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:26:07 -0700
X-CSE-ConnectionGUID: RPWTSUH7SJCMByC1kQbBXg==
X-CSE-MsgGUID: SNSwyQZqSpmxvwws2a1+KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="71168054"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO tlindgre-MOBL1) ([10.245.246.140])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 01:26:02 -0700
Date: Mon, 9 Sep 2024 11:25:58 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Yu Liao <liaoyu15@huawei.com>
Cc: pmladek@suse.com, liwei391@huawei.com, rostedt@goodmis.org,
	john.ogness@linutronix.de, senozhatsky@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] printk: Export
 match_devname_and_update_preferred_console()
Message-ID: <Zt6xFlLyBgLhIlDU@tlindgre-MOBL1>
References: <20240909075652.747370-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909075652.747370-1-liaoyu15@huawei.com>

On Mon, Sep 09, 2024 at 03:56:52PM +0800, Yu Liao wrote:
> When building serial_base as a module, modpost fails with the following
> error message:
> 
>   ERROR: modpost: "match_devname_and_update_preferred_console"
>   [drivers/tty/serial/serial_base.ko] undefined!
> 
> Export the symbol to allow using it from modules.

I think the issue is with CONFIG_PRINTK is no set, and serial drivers
select SERIAL_CORE_CONSOLE? And when serial_base is a module, there is
no kernel console.

I replied earlier today to the lkp error report along those lines, but
please let me know if there is more to the issue than that.

Regards,

Tony

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409071312.qlwtTOS1-lkp@intel.com/
> Fixes: 12c91cec3155 ("serial: core: Add serial_base_match_and_update_preferred_console()")
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  kernel/printk/printk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index c22b07049c38..6ff8d47e145f 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2620,6 +2620,7 @@ int match_devname_and_update_preferred_console(const char *devname,
>  
>  	return -ENOENT;
>  }
> +EXPORT_SYMBOL_GPL(match_devname_and_update_preferred_console);
>  
>  bool console_suspend_enabled = true;
>  EXPORT_SYMBOL(console_suspend_enabled);
> -- 
> 2.33.0
> 

