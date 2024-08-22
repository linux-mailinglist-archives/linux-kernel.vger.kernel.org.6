Return-Path: <linux-kernel+bounces-296613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E0C95ACC8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8561F229BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AA350297;
	Thu, 22 Aug 2024 05:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bvmPV9NX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882DD134A8;
	Thu, 22 Aug 2024 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724303684; cv=none; b=Z2ZZIUO4gVER5nxIm9u28NEhq6bPuNhzhb9AUTUSoLp3umJGMrjl4ZZzZN6X+3XkRS6S2t4OVqJuQS5/bBpomL1WMK+p4CoPg+41OCSmByL8c3cVr0MRbczYvkfXU/cZ9ci7EAmNKW6LFR7Ria2jgOeK2pUq+hueVWUXfM1XcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724303684; c=relaxed/simple;
	bh=ngDz7AVNJAUvMqiSy4yLF8BEcn3Ug63o03RV0QSI7As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHKNWDz993fyTjPvkWFe439wqH8h+df5IGJdMbRolnGClj7Cy92bQHpSnUdc0RFekbEXjUWyGNVI2xHmr+ARlnWlfcUscivJlSBxaeGYprPEabHHnh7iRnXcU3DRy9IFc9CTvKE2NQGKXGCfYdGcLLnWNt5w0uRjYp0X84pTFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bvmPV9NX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A4FC4AF0C;
	Thu, 22 Aug 2024 05:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724303684;
	bh=ngDz7AVNJAUvMqiSy4yLF8BEcn3Ug63o03RV0QSI7As=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvmPV9NXqdombM0PixL1Rz1L8hnVmLhM/nT7uN//JOYsQ4ikNMF4yIjWioKyAHi7U
	 i1IPgzSne267LhLUlNoDVXZKlNvHax8kXpgU9jOIBr4GZP6TvgTZNiVgQkETYXemrQ
	 oWf4eUnU3vvEMu6Tf16e32MKRtt5lGZ+5sHH+XHo=
Date: Thu, 22 Aug 2024 13:14:41 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Neal Liu <neal_liu@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bin Liu <b-liu@ti.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1 0/5] usb drivers use devm_clk_get_enabled() helpers
Message-ID: <2024082227-sports-resource-9c65@gregkh>
References: <20240822040734.29412-1-liulei.rjpt@vivo.com>
 <2024082210-stadium-sly-cf06@gregkh>
 <b356bdb2-fc17-44ef-b0e5-3868b452a8c2@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b356bdb2-fc17-44ef-b0e5-3868b452a8c2@vivo.com>

On Thu, Aug 22, 2024 at 12:46:10PM +0800, Lei Liu wrote:
> 
> on 2024/8/22 12:27, Greg Kroah-Hartman wrote:
> > On Thu, Aug 22, 2024 at 12:07:25PM +0800, Lei Liu wrote:
> > > The devm_clk_get_enabled() helpers:
> > >      - call devm_clk_get()
> > >      - call clk_prepare_enable() and register what is needed in order to
> > >       call clk_disable_unprepare() when needed, as a managed resource.
> > > 
> > > This simplifies the code and avoids calls to clk_disable_unprepare().
> > > 
> > > ---
> > > The files ux500.c, mpfs.c, and pxa27x_udc.c have incorrect usage of
> > > certain interfaces due to the lack of synchronization during the
> > > commit updates. These issues have been corrected in the v1 version.
> > > 
> > > version 1 changes
> > > 1.ux500: Incorrect usage of clk_prepare_enable() should be corrected to
> > >    devm_clk_get_enabled().
> > > 2.mpfs: Incorrect usage of devm_clk_get_enable() should be corrected to
> > >    devm_clk_get_enabled().
> > > 3.pxa27x_udc: Incorrect usage of clk_prepare_enable() should be
> > >    corrected to devm_clk_get_enabled().
> > Patch versions start at 1, this should be 2, right?
> 
> Hi，Do I need to update the patch from v1 to v2 again?

Yes please, otherwise our tools will get confused.

greg k-h

