Return-Path: <linux-kernel+bounces-300890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8112795EA28
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6C71F21697
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8712CD96;
	Mon, 26 Aug 2024 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wmetVni3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21D22071;
	Mon, 26 Aug 2024 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656499; cv=none; b=AhuPeIDoS5Y8skhPCG+e7Fx7crv29VKm4Ply2rKGKAjqy0U8YbbUG1JlGJ6yFNVR87VYM2m0MELNaPRwF9i1nGjNYE6W8b9YgBobBjfXqLyvgS2K4JeJdhMepzYuYN+G5GcUo5IDO2NmyNb6IE+Wupu8YP6rpVD23LREaQ9tl40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656499; c=relaxed/simple;
	bh=5BefvIr/PUt8DwHXKIJx2BOdAE6F9zDv394OpNPF09Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyLdmmkhtXcfP3zi8qAG6QN8d0vbcLdhiKivJEMwpLlAzkj9x6ucV/gf5Hvehwn+FA7CdLaYvTfw+fn2etr7ivZC4rtTYx+kyYMln9WTkYDeOeoCAd8swYHvAZ40T1q2UkdZBIEZusqe8kOgewSc2D2nVjyUyQo5KK4geuOBhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wmetVni3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D350BC8CDC4;
	Mon, 26 Aug 2024 07:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724656497;
	bh=5BefvIr/PUt8DwHXKIJx2BOdAE6F9zDv394OpNPF09Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wmetVni3AbNIihEBPks0uvPVPpkKIqa1TSUhn3Ken93TpqWKBKSYzaFWsv4ID2bW0
	 XShVTZWSVqKIWmVysFjorOt9ICVHSrhJyhDzxKAkvE7q2szVWXdgtd26nz0/e8h+NS
	 IjwEUCVMSFrQyUiphvXB/eAVexAsiqKeysUHwmKc=
Date: Mon, 26 Aug 2024 09:14:54 +0200
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
Subject: Re: [PATCH v2 0/5] usb drivers use devm_clk_get_enabled() helpers
Message-ID: <2024082621-mortuary-gazing-20b5@gregkh>
References: <20240826070244.1835-1-liulei.rjpt@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826070244.1835-1-liulei.rjpt@vivo.com>

On Mon, Aug 26, 2024 at 03:02:38PM +0800, Lei Liu wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids calls to clk_disable_unprepare().

Your email threading is broken for some reason :(

Please fix up and send a v3 series.

thanks,

greg k-h

