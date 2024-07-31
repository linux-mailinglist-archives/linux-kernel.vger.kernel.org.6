Return-Path: <linux-kernel+bounces-268775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D46942924
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F324283CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDDA1A7F9D;
	Wed, 31 Jul 2024 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DL2oTxkw"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D31A1A8C00
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414493; cv=none; b=icmHJ+cflqmeDpU8u0UX0Dff4DNXPWh95IwSv4u+oJnuJPWyV/0RAwm2dQuxkELOlbtduEMOQAn8iw2biEr7Mu3e5J/ye2c1qhYQJzTMokOuTbA9S8LQRvIu5ws+isVOzK3N7kRLrGFCyqy/fkmW9Fxu1bThiocVgK3vTSS/4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414493; c=relaxed/simple;
	bh=Av3OORvo/fp0NBEfS461Tz0A6J3kOYedGnuGFjcVt7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1YbEGyyOV4jkTFOZhoM86UE+fIsBzvrmMyJ9bMjhMOQfDpFZHubFFvSKG3ZDrWYG3JpDK02ebYW/4AYLzMcQ0r1G96f5LlMDfCD39P7Y7tTwgjm272PG4Cpp7ilrSsA/XJ1jayWhlVUmPWISlSoycz34fLz24zGdz8VvIWKmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DL2oTxkw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/fcqze2vkAObsFYGy2QrciDn6/xJntMtoVf4Cew1w3I=; b=DL2oTxkwW+T8Unq5n7OiqklutK
	mCX477EF0JkeGN6q+nIr7W7JDWXCh6n+S5oRJwRJkZiSEStGDjewC2jO5ZnqEWW00oEUjLK+Z+W9p
	5awf29db0NOK+hEMRdbKiO8fhbxPiVXe/WIG01vG98m+GrPqPn2mNux61+v18aRp3u3lEKqe/qbJu
	4SkhCfIqKqwJR+M16GHPr/lschIHcYPDvrmM44vUf+68Clnv8FeVCjsKfMm9xCpIL2A3dzlBKNLux
	3joJjWPepIsl+WmOeK9244dad1tPOwTfnoMT9BCrVZm8GGE5EfdEUNP4l7puRAHvXeMcxeVCr62os
	syCyVoGQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46600)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZ4gU-0008HA-2V;
	Wed, 31 Jul 2024 09:27:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZ4gX-00063z-Ks; Wed, 31 Jul 2024 09:27:49 +0100
Date: Wed, 31 Jul 2024 09:27:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	linus.walleij@linaro.org, eric.devolder@oracle.com, ardb@kernel.org,
	gregkh@linuxfoundation.org, deller@gmx.de, javierm@redhat.com,
	bhe@redhat.com, robh@kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND 0/2] ARM: Switch over to GENERIC_CPU_DEVICES
Message-ID: <Zqn1hVHUdsDjhtT8@shell.armlinux.org.uk>
References: <20240702075742.945768-1-ruanjinjie@huawei.com>
 <1309c436-4e7f-89a3-3b33-abddaaac410c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1309c436-4e7f-89a3-3b33-abddaaac410c@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 31, 2024 at 09:52:07AM +0800, Jinjie Ruan wrote:
> On 2024/7/2 15:57, Jinjie Ruan wrote:
> > Currently, almost all architectures have switched to GENERIC_CPU_DEVICES,
> > except for arm32. Also switch over to GENERIC_CPU_DEVICES, which can also
> > make the code more concise.
> > 
> > Jinjie Ruan (2):
> >   ARM: Switch over to GENERIC_CPU_DEVICES using arch_register_cpu()
> >   ARM: Convert to arch_cpu_is_hotpluggable()
> > 
> >  arch/arm/Kconfig           |  1 +
> >  arch/arm/include/asm/cpu.h |  1 -
> >  arch/arm/kernel/setup.c    | 14 ++------------
> >  3 files changed, 3 insertions(+), 13 deletions(-)

I think it's fine, but it needs to end up in the patch system to be
applied. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

