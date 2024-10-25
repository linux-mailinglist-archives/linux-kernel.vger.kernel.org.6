Return-Path: <linux-kernel+bounces-381132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E889AFACB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6191D1F227D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE511B394D;
	Fri, 25 Oct 2024 07:14:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09651B0F03
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840492; cv=none; b=ESY6BmpxUjNQvWtobZQ8AvRv++JYvjjHqYZ9/hjQ+9pegoEsnW11vwIiPsbb0Y/HB319NQqY1VrQVKGykekZ4IuZjHcbQi4ieyXO+pYSzpLT20PaN1N7tbrXGNhkLGRcBeU17EtGbKRnohUyp16y+qJ/7vvQbXLLv01L3ZWnDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840492; c=relaxed/simple;
	bh=7xeouv90RLyjkxhH0VLz2AL8nPxSakjDhzPqw4ONPTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fn0btWUZ7PAI5fKr7sHFdfo2uSotJFN+XjPqjupFoznhb+LTSz1gNPFjHqpBR1HOgjzHhcTMxUmMHlUIw5DUB2q9aMMu2kBco8HaNv41z41yiBfLJYMC87yAbRdWwiX5layTqW/JSwh3+aX7o7Y1rIPwgofEko0Zu0joxLWLZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1t4EWv-0005YF-D5; Fri, 25 Oct 2024 09:14:41 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t4EWu-000KEa-35;
	Fri, 25 Oct 2024 09:14:40 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t4EWu-00Ctrc-2k;
	Fri, 25 Oct 2024 09:14:40 +0200
Date: Fri, 25 Oct 2024 09:14:40 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: imx@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	linux-amarula@amarulasolutions.com,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pmdomain: imx: gpcv2: replace dev_err() with
 dev_err_probe()
Message-ID: <20241025071440.6tivzdzkkqacm27v@pengutronix.de>
References: <20241024103540.3482216-1-dario.binacchi@amarulasolutions.com>
 <20241024110123.wix35njjbh3nx7kn@pengutronix.de>
 <4vws5lnu4efupunha74pdlgtd754w6n2loymgywrxhwm2rqic2@gz4efozdrpqm>
 <20241024180838.xxhrgmmop75pc7ov@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024180838.xxhrgmmop75pc7ov@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Dario,

On 24-10-24, Marco Felsch wrote:
> Hi Uwe,
> 
> On 24-10-24, Uwe Kleine-König wrote:
> > Hallo Marco,
> > 
> > On Thu, Oct 24, 2024 at 01:01:23PM +0200, Marco Felsch wrote:
> > > On 24-10-24, Dario Binacchi wrote:
> > > > The patch standardizes the probe() code by replacing the two occurrences
> > > > of dev_err() with dev_err_probe(). Indeed, dev_err_probe() was used in all
> > > > other error paths of the probe() function.
> > > 
> > > I assume that this paths aren't using dev_err_probe because these paths
> > > can't return EPROBE_DEFER and therefore dev_err_probe() would use
> > > dev_err() anyway.
> > 
> > Note that dev_err_probe() has advantages even if the error code isn't
> > EPROBE_DEFER. In this case it's mentioning the error code.
> > 
> > See also commits
> > 	7065f92255bb ("driver core: Clarify that dev_err_probe() is OK even w/out -EPROBE_DEFER")
> > 	532888a59505 ("driver core: Better advertise dev_err_probe()")
> 
> thanks for the pointers. With that in mind it make sense to me to
> convert it. Feel free to add my:

that being said, I would like to ask you if you could addapt the commit
message, to point out the advantage of using dev_err_probe().

> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> Regards,
>   Marco
> 
> 

