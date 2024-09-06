Return-Path: <linux-kernel+bounces-318035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE8C96E768
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A61284AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893DC1B969;
	Fri,  6 Sep 2024 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="WYJ7c8H6"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9442232A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587695; cv=none; b=kva0Gjuf39r1bkqmo/MvFbTqv9qcoL4esmoe7itE1UEMWGb8TkOYxojyI3k7ho78DUMUFQAyUyTNEGorp2G2yoiOhZ61+A5py5KWKwMmnzgfVeJ6Ks76+RVyJGORzxiqSFdMX4q0CMPhhsvASPMzW3nsh/0+e1QRAvD/0/MOMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587695; c=relaxed/simple;
	bh=xz3faZOVzxnx/bmV9fsQ3waWqIQagI0CtU/bt6kUiyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKlODNb55D2jiVdp9nXPjsWj+pif6mznRz+OQcW3Le20XXOLp27c0ihA/2wzpeO75MUoGdm6sg0JQNxezvc/ttYLHLs+Oj8zOId+R9bHnrGxItyWE6IzQaoT8fLEyQKZ1f3vHjSBEVllvokqzvj/CUudg03cayd1MozbvGEu7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=WYJ7c8H6; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=WYJ7c8H6;
	dkim-atps=neutral
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id D1A6D6BB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:54:52 +0900 (JST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3df36bd88easo1553053b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 18:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1725587691; x=1726192491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=durTQ7XeNWZjAZ/4AGM8xhjnXE2dEnjAadXy47DRtOw=;
        b=WYJ7c8H6zr3E4bKLEBMHqK3pEQ/Frc3oCC+XGIh6PeTfl9EACyIX9H6KL2bX19inLj
         Iscn/xeWfLoRRDNAywQLzHVJFoAaCA1gtykqAnWDu8FgAujrTwaMF3FDVJ51LdHa4QGo
         B9dR8qs/k1Gmek1t8iuFVVV3jNz17xao5wUapMqj3X5cg1FxGloxfd7Zke0UArkX9lwq
         FIAUmorMkjtQbm6ZIerWQ1YznaXdcmSvnjxu+0w4zlp/QcQJP3dGtP1vA9t7WZS7VexQ
         EMqVvvG3SfYKjw4Teyi4gMRadxwEPdSTc9bVWuKrzUmLypVQc51jmhJ7+i9QnVuDpTg8
         G+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725587691; x=1726192491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=durTQ7XeNWZjAZ/4AGM8xhjnXE2dEnjAadXy47DRtOw=;
        b=ZWQ08sGYShEU4aRQSLwesk3ZgiXqZ1Y/4JJfypavS/gKiz20t1F/+F2im4lyfEzt2Z
         7lCbSsk718zHaNpkg+oZcet3y5E2A9aeAjIIZDwYZkq3TlwuShxa4wR57GRqPzlv59Jr
         d4dw2GqTt+BVmS911b9x8/6EkEu7xBHJrefQuoyXeVBXNfASc1hEtA5z/9eWLuBH8gRb
         S5BMHZM6FH7+Tffcx/f9rXU/zA/BbG3CY5xlg1CUqGGaHqdkYKhH8aHSMPlbFfWc89OZ
         AjmuG0+F6zlYhxOIqSv2osW0JKCKA/b9dMK5EOZNcd8H+Q4VSiU3LqdxuhowC3ZrfSx1
         5UDg==
X-Forwarded-Encrypted: i=1; AJvYcCXfwZFFx2dLSAbDPxJJ+82pd9cMoRpNYqwDmPjBSf0abIhOo/+F6mkQ2lGgb8AzzVIqORYCh7RVSVJOP00=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhpd4yOp90kThhtX819gnELAuJTRhWG9YAX+oTcVqNSJPFEYM7
	s2J6CiBYW3+Mc3mIIQ7BbwOyeCIpD3exJznHCrSHiTHSQv6kJceXAPKkrxUNh0x5bhWDhjpYh0W
	9iTBYXEpBOt8SLYmVL+jmKL21LMZhjLSbohbm5fhJYNWftEcZ3KEiaSrj5mzn7XE=
X-Received: by 2002:a05:6870:a7aa:b0:277:e6fc:4a69 with SMTP id 586e51a60fabf-277e6fc4eb8mr17433235fac.2.1725587691319;
        Thu, 05 Sep 2024 18:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVipTQfUND/FnRqfGq4dI5ZGP/w2h0TeXSOD87mBrBmYVleyYHmbalAOvkXRNmqfOthp2LQQ==
X-Received: by 2002:a05:6870:a7aa:b0:277:e6fc:4a69 with SMTP id 586e51a60fabf-277e6fc4eb8mr17433220fac.2.1725587690879;
        Thu, 05 Sep 2024 18:54:50 -0700 (PDT)
Received: from localhost (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785988aasm3839472b3a.164.2024.09.05.18.54.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2024 18:54:50 -0700 (PDT)
Date: Fri, 6 Sep 2024 10:54:39 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
	frieder.schrempf@kontron.de, aford@beaconembedded.com,
	Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 4/5] phy: freescale: fsl-samsung-hdmi: Use closest
 divider
Message-ID: <Ztpg3_iE2Dbqb4VT@atmark-techno.com>
References: <20240904233100.114611-1-aford173@gmail.com>
 <20240904233100.114611-5-aford173@gmail.com>
 <ZtpMPCHBnEgtkBWp@atmark-techno.com>
 <CAHCN7xLo1RgkUPTdTpCtKjnT7w=gPDCfe_ZEbKj0joVvLG02Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHCN7xLo1RgkUPTdTpCtKjnT7w=gPDCfe_ZEbKj0joVvLG02Dw@mail.gmail.com>

Adam Ford wrote on Thu, Sep 05, 2024 at 07:57:36PM -0500:
> > > Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> >
> > b4 (or whatever you're using) probably picked that up from the patch I
> > included in my reply to this patch, this sob should go away.
> >
> For each iteration, I grabbed the patches from patchwork which
> contained any s-o-b messages, if present.  I didn't add anything
> manually.

Yes, I'm just saying the tool got confused - I replied to an earlier
iteration of this patch with a quote of the 0.5% tolerance patch I
properly sent afterwards here:
https://lore.kernel.org/all/ZtaawD3vb8gmnVmO@atmark-techno.com/

And it picked the sob from the patch, that I hadn't intended to be added
as a review -- from my understanding a sob is something you'd add if you
pick the patch through your tree (e.g. I add sob for patches I apply
through the 9p tree I maintain), but not something to give on reviews.
I'll reply to individual patches with reviewed-by/tested-by once this
thread has settled down; I don't have more comments than what I sent
just now, so I think this is almost ready.


> > > +static u32 fsl_samsung_hdmi_phy_get_closest_rate(unsigned long rate,
> > > +                                              u32 int_div_clk, u32 frac_div_clk)
> > > +{
> > > +     /* The int_div_clk may be greater than rate, so cast it and use ABS */
> > > +     if (abs((long)rate - (long)int_div_clk) < (rate - frac_div_clk))
> >
> > I still think `rate - frac_div_clk` might not always hold in the future
> > (because there is no intrinsic reason we'd pick the smaller end in case
> > of inexact match and a future improvement might change this to the
> > closest value as well), so I'll argue again for having both use abs(),
> > but at least there's only one place to update if that changes in the
> > future now so hopefully whoever does this will notice...
> 
> I can add the ABS on the fractional divider.  I left it out on purpose
> since the LUT table always return a value equal or less, so the extra
> ABS seemed like busy work.  However, I can see the argument for being
> consistent.

Yeah, I agree it's not needed right now; I won't insist on this, just
saying I prefer consistency/future-proofing here.

> > > +             return int_div_clk;
> > > +
> > > +     return frac_div_clk;
> > > +}
> > > +
> > >  static long phy_clk_round_rate(struct clk_hw *hw,
> > >                              unsigned long rate, unsigned long *parent_rate)
> > >  {
> > > @@ -563,6 +573,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
> > >       for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
> > >               if (phy_pll_cfg[i].pixclk <= rate)
> > >                       break;
> > > +
> >
> > (unrelated)
> 
> I don't understand what you're asking here.

This chunk is just adding a blank line that's not related to the rest of
the patch; it's fine, just pointed it out if it wasn't intended.
(these are usually leftovers from tests or something like that)

> > > -             phy->cur_cfg  = &calculated_phy_pll_cfg;
> > > +             goto done;
> > >       } else {
> > >               /* Otherwise, search the LUT */
> > > -             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
> > > -             for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
> > > -                     if (phy_pll_cfg[i].pixclk <= rate)
> > > +             for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--) {
> > > +                     if (phy_pll_cfg[i].pixclk == rate) {
> > > +                             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
> >
> > nitpick: might make sense to print what was picked in case of inexact
> > match as well, but these are dbg warning so probably fine either way.
> 
> I can add the actual values returned.

Note my argument here wasn't about having the values on this line, it's
that the inexact case (when comparing with
fsl_samsung_hdmi_phy_get_closest_rate) doesn't print either line

(having the values can't hurt for dbg though, I think it could be useful
if you rework this)

> > overall I find the flow of this function hard to read; it's a bit ugly
> > flow-wise but jumping in the clock comparison 'if' might help trim this?
> > (and if we're going out of our way to factor out the diff, maybe the lut
> > lookup could be as well)
> >
> > But I'm probably just being overcritical here, it's fine as is if you
> > pefer your version, just writing down this as an illustration of what I
> > meant with the above sentence as I'm not sure I was clear -- I'll be
> > just as happy to consider this series done so we can do more interesting
> > things :P
> 
> Now I am a bit more confused, because above I got the impression you
> were withdrawing your s-o-b, but now it sounds like you want to move
> it forward.

I don't have any strong opinion here: I generally dislike nitpicking
about form, and value the progress you've done more than fixing the flow
of this function (e.g. this function already is good/progress from what
we have right now, we don't need perfect)

withdrawing my s-o-b doesn't meant I disagree with the patch, I just
hadn't willingly given it. If you don't mind reworking the patch a bit
I'll retest the new version, otherwise I'm fine approving this as is.

> It sounded like Frieder was making some progress on understanding a
> little more about the fractional divider.

That's awesome!
I think we can/want to get this merged first, and we can improve
with fractional divider calculations in a later iteration to get rid of
the LUT altogether; it'll be easier for other users of the chip to go a
step at a time as well if they notice a breakage.

> >     // (I haven't given up on that *5 to move inside this function...)
> 
> I wanted to keep the PMS calculator returning the real clock value
> since the calculations are based on equation in the ref manual, Fpll =
> Fref * M / (P*S)
> This way, the calling function can determine if it needs to be
> multiplied by 5.  I haven't fully determined how the fractional
> calculator determines what frequency it wants for a target frequency,
> and using the values for P, M and S from the fractional divider
> doesn't seem to always yield 5x like they did for the table entries
> using the integer divider.

The way I see it is that 5x is an artifact of the PMS calculation:
the caller doesn't want '5x rate', it wants 'rate', and actually setting
the p/m/s values provided by the function gets us 'rate', so it feels
like that's not the caller should have to worry about.. When we add
fractional divider support then it'll be the calculator's job to
determine if/when it needs that 5x.

But if I understand what you're saying, fsl_samsung_hdmi_phy_find_pms()
is not a pms specific to the NXP chip, but something more general to any
integer divisor that is better kept more generic if it weren't for the
few references to our hardware (e.g. limits on m)?

If so then I guess I can understand your position, I wouldn't go as far
as saying it warrants another level of indirection so I guess it's fine
as is.

(In a similar line of thought, had I implemented this I would have had
the function not return generic p/m/s but return the pll registers
directly -- it took me a moment to check why we were setting regs[2] to
`s-1` and confirming we had s>1...)



Anyway, once again I don't feel like I am in any position to be preachy
about all of this, so I'm fine with this patch as is - please take of it
what you agree with/want to rework and we can leave the rest here as far
as I'm concerned.
-- 
Dominique

