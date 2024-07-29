Return-Path: <linux-kernel+bounces-265613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC5393F3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C9B1C21C17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C47C145B25;
	Mon, 29 Jul 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wpXzLqRc"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC075914C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251710; cv=none; b=Asm/WfujwSNgGzpgEyw5QId93DqBwPUgmW1XkePdL4b6+QrhVvU6p4aHXyZOsR1kZrrS9xnXNabO6RYS4NgTwTyCjRZjo4nv+lfs0RdXQqgpv1ZVIK+DAjRkayndLT3RBJ/Li43rS3FFWpCxZrzvIC5/f0jTboVXtzrsK4jwKc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251710; c=relaxed/simple;
	bh=BF97mXIMcRg82sLvmqS7RFNne+EAy9xtVjopMTPtmfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaZq/6tT8UO1PL9glJ0Y24BDveFbBJeFWIpHyFYJmnxY/xdPXAkudcHoRich0GjlhJwdXxHtTfZdj4lzZwIyzvI9orzGZ5dXgeCzICVaPaeEc4l/EJa4AZlFzLWeqqVhV4bQKp5dKLap5pdFTocAFi/xZow8eUZZrp0SEpiQGvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wpXzLqRc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hd5f5qnrIZWu7RKgPSX6OOXWMRFjvTGBPlhsF7CF4xU=; b=wpXzLqRcHVgMqa9bTFgUs+s9fo
	7qTLLtiRecHWm4Q3FIDpErkilaSQ6qIfST1F5JYodi1CB6YiQrw3d03v6BBWdy7ukm0jFeo3tv+3o
	IPTRcOUOn4zX3jbvbdOYVdNaDDVO4teviZP3Z46RWFCOek+yqL/vIAX4BwRw+TmcGh79WKiEKPVQV
	asqUZxffJEzLCoW/cR55Y67yWvIewlPTS0H7AXwSfFiiF+YtsRa1gi6rs4BBh/GC3Pd4P//T8RiW7
	JTdhCTpHJYi11CU2qXHdLYkkCBGPT+BeZvXN4iwPWy0TAC2bdgbbN0h7KneO6ukura2PYjQQpcPfX
	/sNczz2A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60836)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYOKe-00040L-2h;
	Mon, 29 Jul 2024 12:14:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYOKc-0004H1-VH; Mon, 29 Jul 2024 12:14:22 +0100
Date: Mon, 29 Jul 2024 12:14:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, deller@gmx.de, javierm@redhat.com,
	bhe@redhat.com, robh@kernel.org, alexghiti@rivosinc.com,
	bjorn@rivosinc.com, akpm@linux-foundation.org, namcao@linutronix.de,
	dawei.li@shingroup.cn, chenjiahao16@huawei.com, rppt@kernel.org,
	julian.stecklina@cyberus-technology.de, rafael.j.wysocki@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] ARM: Fix crash memory reserve exceed system
 memory bug
Message-ID: <Zqd5joQ/hB8wfebg@shell.armlinux.org.uk>
References: <20240722035701.696874-1-ruanjinjie@huawei.com>
 <20240722035701.696874-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722035701.696874-3-ruanjinjie@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 22, 2024 at 11:57:00AM +0800, Jinjie Ruan wrote:
> Similar with x86_32, on Qemu vexpress-a9 with 1GB memory, the crash kernel
> "crashkernel=4G" is ok as below:
> 	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)
> 
> The cause is that the crash_size is parsed and printed with "unsigned long
> long" data type which is 8 bytes but allocated used with "phys_addr_t"
> which is 4 bytes in memblock_phys_alloc_range().
> 
> Fix it by checking if the crash_size is greater than system RAM size and
> warn out as parse_crashkernel_mem() do it if so as Baoquan suggested.
> 
> After this patch, it fails and there is no above confusing reserve
> success info.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

