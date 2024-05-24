Return-Path: <linux-kernel+bounces-188702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFA08CE583
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619971C20EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0127986647;
	Fri, 24 May 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="zfaJR4yw"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487C85640;
	Fri, 24 May 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555076; cv=none; b=FBpH7U7Tgh2uzmT53lDX+OPCj0e8JxJBCXnPkpu25jRcixbisi43PFePCY3ZNY0lK7ut6LzSW7t0KRk4XNQSMR5V0lkVhMtknm8RFf52wGdZSLrsLhL8paU2ERbQqL4gkbeWeo2YsdEM6li6bQMiYqCpc7/BgklhcCImVrBFu+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555076; c=relaxed/simple;
	bh=JwjqONGEZD9m35VNHftWFl/8SV4bLxXpT8LuBhIOxBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDIcAvgi98V1stZG+MqMBXCYrJN9M9DDFEfr7QbKqMdvYioU1zU8dwFqDwV7+dbnI8qO+1DbcL50//oOBZhq6P8K9hLPeuN9y5HHwQpQ+DEhl0OZ7Mew5ZmyYozTcULALQS/cDqD9nxAIpl0VoiEoZsclWjjYvhSs/05qWsFoNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=zfaJR4yw; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 4B3AD20234;
	Fri, 24 May 2024 14:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1716555071;
	bh=qDP8cRI/5qtHYgYuFlaak2vCfnTE2IhepeW5hOhXj0E=;
	h=Received:From:To:Subject;
	b=zfaJR4ywn9eBBxnPWl5eKvyTv28K2In7JStDJ2B6zR6mV+vsLTYM33TnHxPIJJzbD
	 ZR3RXVi1ejNX+TMl01HFc7wB0UY768JZISvVc+Ym8O0Ei9ZwJCkRgx4OvZRdbSoQp9
	 k2ppI1BtRJOXamaT/RN9QfLnMTjjHCGT9NNUu6Osy4sYwvelP0BDnJ8SCgkM6eMywI
	 6RkV/NjZloO1vQuegu0t5JkiPMbgS117xov7hKGy9tH9JO7ZYzvzXLfTJ3AT6TMh7k
	 iGWKxbprw28P8GxXIv++PBdDdJFXnqIjPwn1Opcj/C1wTce8cXs9eg3NmLQ1oNMChl
	 2fVR1eCBWosrQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id E297E7F963; Fri, 24 May 2024 14:51:10 +0200 (CEST)
Date: Fri, 24 May 2024 14:51:10 +0200
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
Message-ID: <ZlCNPg2iuvSTpVJs@gaggiata.pivistrello.it>
References: <20240524071034.4441-1-francesco@dolcini.it>
 <20240524071034.4441-3-francesco@dolcini.it>
 <5of64nmgpotr7fu66urgko5gfvr4ffhmff4dgkagkdvwh2dywk@etlw6rsmhki6>
 <ZlB6ruZ8j2rVsIio@gaggiata.pivistrello.it>
 <3z3gi2s2dxlflmfpcirutvesnj6gsxyriijl2jrc2udaqucoyb@6scxw5hb2nv7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3z3gi2s2dxlflmfpcirutvesnj6gsxyriijl2jrc2udaqucoyb@6scxw5hb2nv7>

Hello Dmitry,

On Fri, May 24, 2024 at 02:42:04PM +0300, Dmitry Baryshkov wrote:
> On Fri, May 24, 2024 at 01:31:58PM +0200, Francesco Dolcini wrote:
> > On Fri, May 24, 2024 at 12:56:15PM +0300, Dmitry Baryshkov wrote:
> > > On Fri, May 24, 2024 at 09:10:34AM +0200, Francesco Dolcini wrote:
> > > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > 
> > > > The enable gpio is not required when the SBU mux is used only for
> > > > orientation, make it optional.
> > > > 
> > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > ---
> > > >  drivers/usb/typec/mux/gpio-sbu-mux.c | 11 ++++++++---
> > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
> > > > index 374168482d36..cf44259980a1 100644
> > > > --- a/drivers/usb/typec/mux/gpio-sbu-mux.c
> > > > +++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
> > ...
> > > > @@ -66,6 +66,9 @@ static int gpio_sbu_mux_set(struct typec_mux_dev *mux,
> > > >  {
> > > >  	struct gpio_sbu_mux *sbu_mux = typec_mux_get_drvdata(mux);
> > > >  
> > > > +	if (!sbu_mux->enable_gpio)
> > > > +		return -EOPNOTSUPP;
> > > 
> > > Can we skip registering the mux if there is no enable_gpio? This can
> > > save users from the unexpected errors during runtime.
> > 
> > Yes, I considered this option.
> > 
> > The rationale for the current implementation is that if the device tree is
> > correct (no mode-switch property, when enable-gpios is not present), nobody
> > will call gpio_sbu_mux_set() so no runtime error is possible. If the
> > configuration in the DT is not correct you get this runtime error.
> > 
> > With your proposal in case the DT configuration is not correct there will be no
> > errors from the kernel, but the functionality will not work.
> 
> I'm slightly biased maybe, but I prefer an error from probe (or
> dependent devices being deferred). On the other hand, current motto is
> that 'the kernel should not duplicate dt-validate's work'.

I am in favor of "the kernel should not duplicate dt-validate's work".

Now the question is if you are ok with the current implementation or you want
me to change the way you suggested.

Or maybe there is a third variant, not doing the return -EOPNOTSUPP and
registering gpio_sbu_mux_set() even if the gpio get returns NULL. This is a
one-line patch and everything will work just fine.

Francesco

