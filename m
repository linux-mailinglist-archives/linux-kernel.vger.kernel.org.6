Return-Path: <linux-kernel+bounces-296595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C370795AC95
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E2D28211D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625403BBC5;
	Thu, 22 Aug 2024 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v+ZgCF6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E7381B8;
	Thu, 22 Aug 2024 04:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300849; cv=none; b=DRTJnp7pAhigz4/7BTlp0ECb6soLmJEyuIIh7wVwcr2zZ4SAQZJF6sEQ2XP5/VNwy9SH/4m96mXKLPUWXFQU3hhtZzjnGY6Qzf37LqdOR10J8XtOEzucSBaldtS+QX2mIH2RsgW6xdaNhbU1EmwIpxdMCJnbmekG6VIGytEWWPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300849; c=relaxed/simple;
	bh=7V+H9aiy6Hmq4hq9uhSZuA59Ro8lxYpKbAXrcA3sXLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX6eypBhfZbwIHodLQlEw9aNRixWv0q6dFPNAi9uI97CLPXXqPK6DE35EVYqp/bjJ1mqnHSHCUgOss9cjAJbFxIIsfjfrRc8uWOYO5o/X2aIgidCoh5ODxYTlzSTZOkIQvL4kDR2+Xp6PYJWwuDgrX6epnlrP7HZWYSMfCnIuvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v+ZgCF6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABF1C4AF09;
	Thu, 22 Aug 2024 04:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724300849;
	bh=7V+H9aiy6Hmq4hq9uhSZuA59Ro8lxYpKbAXrcA3sXLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v+ZgCF6eGa392JfISoJqCnTuDfcClAdh4ysQ90tWOJT9KwmDps2Ub8yXHB8VBfEt9
	 gNm4EtxXR0XFMPuBd3fS7RWPUvFAoIt55q2o82p/TP/yq2vaQjH7uS3t9fbsq+VMv7
	 CFVcp8RUFyDabTFc+aKR7xr/50PvrmGpZ4Joa0EU=
Date: Thu, 22 Aug 2024 12:27:26 +0800
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
Message-ID: <2024082210-stadium-sly-cf06@gregkh>
References: <20240822040734.29412-1-liulei.rjpt@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822040734.29412-1-liulei.rjpt@vivo.com>

On Thu, Aug 22, 2024 at 12:07:25PM +0800, Lei Liu wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids calls to clk_disable_unprepare().
> 
> ---
> The files ux500.c, mpfs.c, and pxa27x_udc.c have incorrect usage of 
> certain interfaces due to the lack of synchronization during the 
> commit updates. These issues have been corrected in the v1 version.
> 
> version 1 changes
> 1.ux500: Incorrect usage of clk_prepare_enable() should be corrected to
>   devm_clk_get_enabled().
> 2.mpfs: Incorrect usage of devm_clk_get_enable() should be corrected to
>   devm_clk_get_enabled().
> 3.pxa27x_udc: Incorrect usage of clk_prepare_enable() should be
>   corrected to devm_clk_get_enabled().

Patch versions start at 1, this should be 2, right?


