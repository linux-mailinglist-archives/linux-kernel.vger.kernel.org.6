Return-Path: <linux-kernel+bounces-188648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A31C8CE4E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A605D1F2154D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26148625A;
	Fri, 24 May 2024 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="GyyKuxGZ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2BC9475;
	Fri, 24 May 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716550325; cv=none; b=hX1g4v3pzPEquiwCU6ZOgYeNS2q0Dl/YLkGLQQQjAPWCMBoLKpjz3w7vVSmE7L9BCuZ3VI/SKjjldQv4PENxGCyNU18WHbeqKV4cjLBUi60rOrnu0JlRKs0o9xCn1mIKuKx7SrKzGOKbMGB1Hw0r1xOuR9K7LeelhxbqgIMr9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716550325; c=relaxed/simple;
	bh=IlUQDrvlikCtPQHZL17bTPh6Z9sOobbSRi8dQxajFWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuqZKAfAgm5ZVMrLlJ7Lck8EXYBMCvdm8441rAcuFsPsN3Uz4wbHadyZ9br2+QCpxS2uSYtDkOtAEPzPtyrOaxiMWmNIkfiX8F9V+dkAjYycqamNfoRJCWIK2wkzPTXkB7Ey7PAu8ASL7X4TqdsPvckh+xphRVDa+39dOrusZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=GyyKuxGZ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id CACB220232;
	Fri, 24 May 2024 13:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1716550318;
	bh=82c4Czu1Ofgrwin76Gz+pckw49eOGhAz3rJrK16Yv+Y=;
	h=Received:From:To:Subject;
	b=GyyKuxGZ2tIOliFP18R2TXgCqDmRgWASUfwA840XG2LKymLhmQZjiErUKFjbJjaEg
	 hvCFXNP0SSRooL8Cf7ZaZYkcNa2HhMqz26nIyVzSTR79n+YY98NoxvEKa/lOJIg2Vk
	 vhQxShGKkdahRQRf47OAhKc6xD3cZC3YIFBPvDJQ6XcQTMtTeIBvaaShbgxgXLtI08
	 Eo1/vXJ3sAP+6SFsSj/2hS/JyfcagPBBWxzN2v4hdPtEFejG1iVaveWJOUpbMv/RxG
	 iU5WXYtAzhNjuLb5+ki5g/Ts6hZdUOT54RsmBps/noAc17n/j17wjKoGKOd4qIX0RE
	 i3YyMYFoU6+SA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 626617F963; Fri, 24 May 2024 13:31:58 +0200 (CEST)
Date: Fri, 24 May 2024 13:31:58 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v1 2/2] usb: typec: mux: gpio-sbu: Make enable gpio
 optional
Message-ID: <ZlB6ruZ8j2rVsIio@gaggiata.pivistrello.it>
References: <20240524071034.4441-1-francesco@dolcini.it>
 <20240524071034.4441-3-francesco@dolcini.it>
 <5of64nmgpotr7fu66urgko5gfvr4ffhmff4dgkagkdvwh2dywk@etlw6rsmhki6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5of64nmgpotr7fu66urgko5gfvr4ffhmff4dgkagkdvwh2dywk@etlw6rsmhki6>

Hello Dmitry,
thanks for the review.

On Fri, May 24, 2024 at 12:56:15PM +0300, Dmitry Baryshkov wrote:
> On Fri, May 24, 2024 at 09:10:34AM +0200, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > The enable gpio is not required when the SBU mux is used only for
> > orientation, make it optional.
> > 
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  drivers/usb/typec/mux/gpio-sbu-mux.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
> > index 374168482d36..cf44259980a1 100644
> > --- a/drivers/usb/typec/mux/gpio-sbu-mux.c
> > +++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
..
> > @@ -66,6 +66,9 @@ static int gpio_sbu_mux_set(struct typec_mux_dev *mux,
> >  {
> >  	struct gpio_sbu_mux *sbu_mux = typec_mux_get_drvdata(mux);
> >  
> > +	if (!sbu_mux->enable_gpio)
> > +		return -EOPNOTSUPP;
> 
> Can we skip registering the mux if there is no enable_gpio? This can
> save users from the unexpected errors during runtime.

Yes, I considered this option.

The rationale for the current implementation is that if the device tree is
correct (no mode-switch property, when enable-gpios is not present), nobody
will call gpio_sbu_mux_set() so no runtime error is possible. If the
configuration in the DT is not correct you get this runtime error.

With your proposal in case the DT configuration is not correct there will be no
errors from the kernel, but the functionality will not work.

Francesco


