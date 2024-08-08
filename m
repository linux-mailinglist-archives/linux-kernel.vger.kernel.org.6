Return-Path: <linux-kernel+bounces-278913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC8B94B686
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5741C22D43
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA969186294;
	Thu,  8 Aug 2024 06:13:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673791850A4
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723097589; cv=none; b=l6QNK7V2DwWSYd0dd9cwmPHfCCml0RnFA+VlmqbTALCz7j9guVL9Yd2GPrpwr5pj8IfS7b6fP0Outd7ruoxdomPvX1HSXz9ZlZ7sNWkJhwWQGwJ731H/P52WLzAhEdleLfFQPGou3/ZzSqi7mhAFWqJvokVPzhR4inm9ih0zSOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723097589; c=relaxed/simple;
	bh=RGoNUZAq1rAxdFEKc7Y+MG0dLsPdw0cpAkDwQDL82uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXu3LG/jHKM++GaUSiw6kq6EFUZmPNXsfuJLHdqUUYv6PgbreyHXuoNWAihJN+0H4pyCUSQ+HAqT38B54qV5P2A+37H/HTKssn0jGHr3GGWZBAUqlD6j2GlFReH86A+WviYf47i82+9Zo1tjuHA9AT9nu1U9QVW6ToSlq3PDrpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1sbwOG-0001TY-8q; Thu, 08 Aug 2024 08:12:48 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1sbwOD-005MVB-Hs; Thu, 08 Aug 2024 08:12:45 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1sbwOD-008kuJ-1L;
	Thu, 08 Aug 2024 08:12:45 +0200
Date: Thu, 8 Aug 2024 08:12:45 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Ma Ke <make24@iscas.ac.cn>
Cc: ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, geert+renesas@glider.be,
	arnd@arndb.de, peng.fan@nxp.com, u.kleine-koenig@pengutronix.de,
	marex@denx.de, benjamin.gaignard@collabora.com, imx@lists.linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: Fix NULL pointer dereference
Message-ID: <20240808061245.szz5lq6hx2qwi2ja@pengutronix.de>
References: <20240808042858.2768309-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808042858.2768309-1-make24@iscas.ac.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Ma,

thank you for the patch.

On 24-08-08, Ma Ke wrote:
> Check bc->bus_power_dev = dev_pm_domain_attach_by_name() return value using
> IS_ERR_OR_NULL() instead of plain IS_ERR(), and fail if bc->bus_power_dev 
> is either error or NULL.
> 
> In case a power domain attached by dev_pm_domain_attach_by_name() is not
> described in DT, dev_pm_domain_attach_by_name() returns NULL, which is
> then used, which leads to NULL pointer dereference.

Argh.. there are other users of this API getting this wrong too. This
make me wonder why dev_pm_domain_attach_by_name() return NULL instead of
the error code returned by of_property_match_string().

IMHO to fix once and for all users we should fix the return code of
dev_pm_domain_attach_by_name().

Regards,
  Marco

> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a1da28544fd ("soc: imx: imx8m-blk-ctrl: Defer probe if 'bus' genpd is not yet ready")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index ca942d7929c2..d46fb5387148 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -212,7 +212,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	bc->bus_power_dev = dev_pm_domain_attach_by_name(dev, "bus");
> -	if (IS_ERR(bc->bus_power_dev)) {
> +	if (IS_ERR_OR_NULL(bc->bus_power_dev)) {
>  		if (PTR_ERR(bc->bus_power_dev) == -ENODEV)
>  			return dev_err_probe(dev, -EPROBE_DEFER,
>  					     "failed to attach power domain \"bus\"\n");
> -- 
> 2.25.1
> 
> 
> 

