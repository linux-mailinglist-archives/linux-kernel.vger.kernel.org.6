Return-Path: <linux-kernel+bounces-170955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DE28BDE6A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523791C2319C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F51C14D71D;
	Tue,  7 May 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PziktTF1"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476345B1E0;
	Tue,  7 May 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074490; cv=none; b=F75cbIW8OD/CRvYw+6dM84BCdOQMakwZcUUf/BxhCqUL2Z4dd6qLKfgpMYrff3bUnImd8ha+wX+TXX2xbXBCpTokGqhknj48OySLQ7SdXrBbWfIBngQPYYaawt8AAuZxAxdq8cN35dIjDKw6Uj9ElgmXu3Q7pDR/AELq4oxE79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074490; c=relaxed/simple;
	bh=ohWuVrllZ49t4dkKQwrO5nd7MUNrk39VX+83CHV8kf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvskUdRX+RmvHNDeTrKyi8UtdaF7Gkkng3DV+krEUlJ7b05uswW605uGDz9hybnr0eppkadHvaLUlL62aoTPv4ffAJ0D5JukwZiDgtm6AGCjo1Kohug+2O/c5K12fHEdHA1V7Lz/wx8xEiZ2l/T1Wl7dz+zL7kwiXMleEdmEFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PziktTF1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uarDHQ+a07tcRKI28LofQYYCslRlvc1XjILv15IA6C8=; b=PziktTF17Jc8u09/HMPR5DU/yy
	zsrmYUqA5oWzK7ZXjFEDfMSDi9mTS9r/VZuTc/Nmg6YvkyLNcaPCsO7RToY6boQVSm0Zr5665Op5d
	xQIGFlpmsEmgs4Vjo70G32RTwxNTDY7rQAznZ76/NlJOd7Jo09ese7Py2HSAEP3SYJxfnE5sQqSyw
	1ENVU4Tv8sD0poPrbuBmD3yZmb/8UrWg0UMmHhuuAcOwX1dS8wa57sY4Jn5qZWMZDS8NrDiL5OP7T
	UfIRvmHYa8ILi911uHTFxX/uK3gcoqHaVb6eM+R1FcOZy42XV+llzS856N2PY6T/DBgNvlQ0dQmjw
	CCFuvLaA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46068)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s4HDe-0003VG-1C;
	Tue, 07 May 2024 10:34:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s4HDe-0000Da-Sh; Tue, 07 May 2024 10:34:42 +0100
Date: Tue, 7 May 2024 10:34:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clkdev: fix potential NULL pointer dereference
Message-ID: <Zjn1spDSBOkUD+qh@shell.armlinux.org.uk>
References: <CGME20240507064445eucas1p1bfc17da4f824ef46567774634482f12f@eucas1p1.samsung.com>
 <20240507064434.3213933-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507064434.3213933-1-m.szyprowski@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 07, 2024 at 08:44:34AM +0200, Marek Szyprowski wrote:
> dev_fmt argument is optional, so avoid dereferencing it unconditionally.
> 
> Fixes: 4d11c62ca8d7 ("clkdev: report over-sized strings when creating clkdev entries")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Please put this in the patch system so it can be merged along with the
change that created the problem. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

