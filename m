Return-Path: <linux-kernel+bounces-272477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481FC945CB6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B5F2856F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB501DAC68;
	Fri,  2 Aug 2024 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J1fIIrGC"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD8A14A4E0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596514; cv=none; b=sGNp/tmTdH4+EU2iHhHYrI5oW1ciiVwjYAfGCXfhbnhHc1RXGGXSLxuCJr86lqBc9KD3D+CykPz3E90HlayiyYwIKrtLMSTNX3wm+b+EZWWgsxAE72152FT87I+uirtH2ZssfHpHzTJ7Uer11s23aSkjsGKMxL6KPiqOcj1s3BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596514; c=relaxed/simple;
	bh=4jgnMbYB3FniXg1lxribVNfZsl17DeBITBImIWuoYXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqwX5q3Q2waUtvQBFPVQiiF/xjTnph7pV4DFBW5h3sJjiqSWqtrNKJf/cwAUI4bNYRDBhxMvNXcXswART9NYRJOiH+LBli9Q1Vf6vXJLQFkUsY92W1BFUMJIukkJG0vUL7hBgMa19kfxl4gjq6VTLFN8F2UvGE1PTRWpq8V9oyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J1fIIrGC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nw1iqQVMOzq+ioAn1MHFepdFcLn2HlKNyKqm4YBYshw=; b=J1fIIrGCP9dpDOdQ00BA0t3cp5
	/0qw8Bk3QxrxAXYcAub5QMMbCBCuQujhVJ2JidL20HeCD6qfGZITx09EynUB2ceGeJRFI9ouAw5yN
	DXqJs8MTddn2C5FHyM2tg/yLvXST2uRL4CwBlMFdB0F6ZRmSUdIf9wb1gLzPi9Z+d0H9YgRwFUTOq
	Q+z9ik+ZnSCKm4/r/jUzpgLluwh6Jcw3iNFlL8j5c1uLJpXYL1Zvit28JU8peTZNzGoVbq7QwSlg7
	21uidRezn5a13HCNSyhxep5yZBZJAf0ZN7RQwSoTNEvWX53tbWib9mr8xOMEH4MbfCeGZNQh96T5G
	hDK2ibKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36616)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZq2W-0006WZ-2O;
	Fri, 02 Aug 2024 12:01:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZq2Z-0007yZ-7U; Fri, 02 Aug 2024 12:01:43 +0100
Date: Fri, 2 Aug 2024 12:01:43 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bhe@redhat.com, akpm@linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ARM: Support allocating crashkernel above 4G for LPAE
Message-ID: <Zqy8lwZM2Z6RlV5H@shell.armlinux.org.uk>
References: <20240802092510.3915986-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802092510.3915986-1-ruanjinjie@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 02, 2024 at 05:25:10PM +0800, Jinjie Ruan wrote:
> As ARM LPAE feature support accessing memory beyond the 4G limit, define
> HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH macro to support reserving crash
> memory above 4G for ARM32 LPAE.
> 
> No test because there is no LPAE ARM32 hardware.

Why are you submitting patches for features you can't test?

I'm not going to apply this without it being properly tested, because I
don't believe that this will work in the generic case.

If the crash kernel is located in memory outside of the lower 4GiB of
address space, and there is no alias within physical address space
for that memory, then there is *no* *way* for such a kernel to boot.

So, right now I believe this patch to be *fundamentally* wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

