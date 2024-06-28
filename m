Return-Path: <linux-kernel+bounces-234610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FA891C8A1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6791F22456
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C351180624;
	Fri, 28 Jun 2024 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nrVVFn8K"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2778C9D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611764; cv=none; b=rUx70+JQ8PG46Z6fAmN7nkHHeenOtuVOaivWh0QbDD26K3TbyB2oq8K6yhsRtCU+lx5rnw6Z9wyTU3CpnhjVUv8CbjL5MrPc7yEsRzzIsCj0u8P3Nu61z97dKMVuEnq5/27T71pE+fWdErYT1KW4hvb299ViTkyU4ZWLFKo7LIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611764; c=relaxed/simple;
	bh=O1ACOLEzbgJkv3hF8uDDssoICGLyodWuiq9rELIVgVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXhM7XsUKMtGg0rga4J8NWcIQ1KyoHSgxz7ZCI9w4707vZY8AyF4SHiSuFq9J9WqtcLelepc2sRgROKuR5x8hvRXfdwieJM9oDo0DDNlab2LQbcexjmOsjZscZ8GUG27ACn56ozu218cpKdhzKShEsdG+Bkdl6OziQyovPd64H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nrVVFn8K; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bcLWSIe52sGLdEKTBdAQolHpPpJtK55zL5ImUo+lw7M=; b=nrVVFn8KPcUmP6gGPax+zt0zjX
	SSgbQWkl/aH34+jC0q3O8thp4VONsZLPp9RU2PYpZEzMk1SQKUjNyJC+CFtI90YozUwiScUWMVlxr
	Py9qXbhaEy/OeaOaDI/7ehcng4pHblPPpgFsFDeZVuC5oU1jjEu4Riinmm1O/iDxdWdPg+VAfmArl
	atOXnSuIkFWBHVBoHzOy0cuJC3hKGhXhY7fmCtgCxHWCw6lL/24pgpVSXmjZvj1XkyOaafQ43bTWM
	aSKbfHmFvWayQ6Q3v3jSNveVMxXUTtv8EXN9NIMDdbwRom1eyU07qjE0ejt6T9798jNkQ643TUQda
	Ani9vf+A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43222)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sNJZO-0007Xj-2x;
	Fri, 28 Jun 2024 22:55:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sNJZS-0006pf-0x; Fri, 28 Jun 2024 22:55:54 +0100
Date: Fri, 28 Jun 2024 22:55:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: mingo@kernel.org, sshegde@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM, sched/topology: Check return value of kcalloc()
Message-ID: <Zn8xae/b6lNaWcKq@shell.armlinux.org.uk>
References: <20240628194350.542376-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628194350.542376-2-thorsten.blum@toblux.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 28, 2024 at 09:43:51PM +0200, Thorsten Blum wrote:
> Check the return value of kcalloc() and return early if memory
> allocation fails.

If we fail this allocation even with your fix, how likely is it that the
system will boot and manage to run userspace?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

