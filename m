Return-Path: <linux-kernel+bounces-322528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F3F972A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E3DB220CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A3C17BEAD;
	Tue, 10 Sep 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ao5r80kN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011EE13A242
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952243; cv=none; b=WgxHtxTb0EEzeipwXTHKv/i8pYsBHE68XKqh8giWVbpYwxaYgz/WBm3drYV9vjbLG9gZx6G/iDKkmzwCv2YMfGotMN0bRlv2ue8bjyuv0yEuhdRB4jxlU1ridFjpMb8a+HCNR729qA/mAHL5tFTV9LJGXH7IolDRHM4eJvvWQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952243; c=relaxed/simple;
	bh=MkOtBOQnMs1e06jSuyL968m4mS9FLeaQjXti00ia8mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujhMS53nNqRIX8t33CnvTN7rZVIv0xNRBUx3QKirpw14jqlCO/mDctmq7sOsLm0VGROojC7HfcOULvot1hD5y6sYAYfmdTSTwnhb9dlsx4XD36XrV16QyDzXw8Et1maOf/qpIFTIeO+b31V0fkMNXvUUAPQFT8JtzHGxFwWy0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ao5r80kN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725952242; x=1757488242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MkOtBOQnMs1e06jSuyL968m4mS9FLeaQjXti00ia8mc=;
  b=Ao5r80kNTZMtChzKwpn3RANaC4KuaLDIlG0Dq5UvCSxqoVAHhgsdtUCD
   efXzSCKy17s4mTYybtX8eZZHvCbIY4SnqYFB/E/AdmpBZZq3hahL0Z7TR
   22a0GEEcOLg6uMa1S1KQt8uuk0QBwr2AQwC/G5pPZW6Olqqn/V4M3rYmr
   JVtqT1F3J3J+2Wu1j0GGeeLnmnNUCOomJeuIUuBZ1cc07Rya5rJajXhaD
   7InnsT7vRj8VWKOuzrBblZ+l2+hoocayopctAvkL2cHQqoiGbeBO0HG0V
   YGaAgGvW6dR1X6Q8u+CpcSIMuGVtSWkwP+HU6TdmvP+HLC0b2xCKkEGRT
   A==;
X-CSE-ConnectionGUID: H3Q1dABtQzmzSovlZa2xig==
X-CSE-MsgGUID: MSUKNIRkRvOv4Q/QWdP50w==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28572351"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="28572351"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 00:10:40 -0700
X-CSE-ConnectionGUID: y2e6k847SWixdZsMvmlBag==
X-CSE-MsgGUID: MXD+wGr2SbeA0OPYWxBb1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="97639144"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO tlindgre-MOBL1) ([10.245.246.15])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 00:10:38 -0700
Date: Tue, 10 Sep 2024 10:10:31 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Yu Liao <liaoyu15@huawei.com>, liwei391@huawei.com, rostedt@goodmis.org,
	john.ogness@linutronix.de, senozhatsky@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] printk: Export
 match_devname_and_update_preferred_console()
Message-ID: <Zt_w5x4Z-jSillvr@tlindgre-MOBL1>
References: <20240909075652.747370-1-liaoyu15@huawei.com>
 <Zt6xFlLyBgLhIlDU@tlindgre-MOBL1>
 <Zt7UXNZC1UR2t1OJ@tlindgre-MOBL1>
 <Zt_qIssr_jukJ4ey@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt_qIssr_jukJ4ey@pathway.suse.cz>

On Tue, Sep 10, 2024 at 08:41:38AM +0200, Petr Mladek wrote:
> On Mon 2024-09-09 13:56:28, Tony Lindgren wrote:
> > On Mon, Sep 09, 2024 at 11:25:58AM +0300, Tony Lindgren wrote:
> > > On Mon, Sep 09, 2024 at 03:56:52PM +0800, Yu Liao wrote:
> > > > When building serial_base as a module, modpost fails with the following
> > > > error message:
> > > > 
> > > >   ERROR: modpost: "match_devname_and_update_preferred_console"
> > > >   [drivers/tty/serial/serial_base.ko] undefined!
> > > > 
> > > > Export the symbol to allow using it from modules.
> > > 
> > > I think the issue is with CONFIG_PRINTK is no set, and serial drivers
> > > select SERIAL_CORE_CONSOLE? And when serial_base is a module, there is
> > > no kernel console.
> > > 
> > > I replied earlier today to the lkp error report along those lines, but
> > > please let me know if there is more to the issue than that.
> > 
> > Sorry I gave wrong information above. The issue can be hit also with
> > CONFIG_PRINTK=y and serial_base as a loadable module.
> 
> Yes, this is my understanding. The problem has happened when serial_base
> was built as a module. So exporting the symbol looks like the right fix.

Yes agreed.

And, Yu, thanks for fixing the issue!

Regards,

Tony

