Return-Path: <linux-kernel+bounces-241722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86402927E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 23:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452CC1F2247E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACFD142E76;
	Thu,  4 Jul 2024 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N15e8AiR"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D213D246;
	Thu,  4 Jul 2024 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720128157; cv=none; b=jDF+1alUft5gwRKWdJhQgK9Oz9vVwEEbD9Fs+IBHN95HrG65IRnN1FVggheE6Cn97x4de+wETaq933XOHL+1E+jjgHs+b0bs3Q7dvtHDHM2CLvjwzkDwFEITVHhDpv8K8um/gU5Xj9DiR2b0cOIdMohEy8IfJ3JnamlBctj7wN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720128157; c=relaxed/simple;
	bh=1Zu1gGORmacWVfCT7ud6HJOjHdkKGR/FUkFzDZWk0nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGCacnIfwK6F3ZG9kyWzX0MHnpThgjkYibkv9lCaky/REmd2y2y5ljrUQG/u5M+xhS4yqgcZp73b3ih4RIGeVHgZVLLUmEKiWsmuLMB40JD5EvYglXSucxQA83Uct8LQ/DvfOj6tFqXV9dWQVPQ4XGrA/JLHTXgz1Pqlrvzeb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N15e8AiR; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6636E20004;
	Thu,  4 Jul 2024 21:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720128152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onBW+se5+BtMcp5qnhtubaXPDp7r6YYWbW0Ehl7rFLo=;
	b=N15e8AiRH0ck0gvHomMZjncrDUfKX8k8UDXEbIU2gqQROhfMLvrFLmTw4w+v2uNzi2cZqM
	vvjsN5J3bcs276CI1Ma6CDZ8KyQig8vjWTOQshOeC2buQ5UrITxSceJdAuKxa5GCjNsY9x
	Hh/45ZNrK8L3NZnnjq5ExkGHI0qTM2Fgv8eLQ518h9V+YDoAEQniusQulGIYM/Ch0fE5+P
	ubjwFjdGD06kgpQuCi4ujm4VOCuRrmkpU9EeMUvZR/9hc7cA6Abd0Y1IPsi1EcY3G1MqvB
	blGmmhdj+OC0BzMHr5gRIBcbGXpvDN2DW/pIisMpfOhmJCY+vDJ/8EJ3wZQzNw==
Date: Thu, 4 Jul 2024 23:22:22 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley
 <conor@kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Saravana
 Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org, =?UTF-8?Q?He?=
 =?UTF-8?Q?rv=C3=A9?= Codina <herve.codina@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: Fixing property memory leaks on device tree overlay removal
Message-ID: <20240704232222.7557dfa0@booty>
In-Reply-To: <CAL_JsqJ1aKP=9VdAxjWvjZdyD0tYPhKSZKa1kAnQwPv4sBpbtA@mail.gmail.com>
References: <20240624232122.3cfe03f8@booty>
	<CAL_Jsq+=mGEJXsjq1UZFMJtHko_z+doiFMXnx9K7exDuznymSA@mail.gmail.com>
	<20240627145741.77ddccbf@booty>
	<CAL_JsqJ1aKP=9VdAxjWvjZdyD0tYPhKSZKa1kAnQwPv4sBpbtA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Rob,

On Wed, 3 Jul 2024 15:08:11 -0600
Rob Herring <robh@kernel.org> wrote:

> > > I need to study this more, but a notifier is never a great design so
> > > maybe we can come up with something better.  
> >
> > Do you have specific ideas in mind? I'm very interested in knowing
> > alternative options.  
> 
> Like I said, need to study it more... Perhaps just remove notifying on
> properties. I think properties changing at any point in time is
> difficult to support and we just shouldn't support that other than a
> few exceptions like "status". Or we could have a "node changed"
> notifier and then it's the client's problem to figure out what
> property changed.

At first glance it makes sense. And, reassuring, I'm not using property
notifiers in my code.

> > > > Once all call sites are updated to the new API, the old API can be
> > > > removed entirely along with the deadprops list and the
> > > > CONFIG_EXPORT_UNSAFE_OF_ACCESSORS Kconfig symbol.  
> > >
> > > I don't like the kconfig symbol even if it is temporary. How does it
> > > get configured for a multi-platform kernel?  
> >
> > First of all: this kconfig symbol is useful only if the goal is to
> > remove all property-leaking APIs.
> >
> > The idea is to use it as a guard: if a defconfig builds with it set to
> > 'n', then all the code enabled in that defconfig is not using any
> > "unsafe" accessor. Meaning: we haven't removed all accessors from the
> > whole kernel, but from the subset of the kernel that this defconfig is
> > building.
> >
> > For multi-platform kernels it is not much relevant in the short term.
> > If/when at some point we will be able to set it to 'n' in one of them
> > (e.g. arch/arm64/configs/defconfig) that would mean a large percentage
> > of call sites have been removed, and (even more important) _no_ call
> > sites will be added anymore or the defconfiig will fail immediately.
> >
> > And I think it should be a requirement for any driver loading/unloading
> > overlays, so that one cannot even load an overlay without fixing all
> > the call sites. I think this is the most relevant usefulness in the
> > short term: either you call unsafe accessors or you load overlays, not
> > both.  
> 
> Sure, but that can be runtime. If you load overlays, then you'll get
> warnings for calling unsafe accessors on the nodes associated with the
> overlay.

I got your position, thanks for taking time to provide more details.

> > > > Note there is no "convert all call sites" in the plan. The amount of
> > > > drivers alone is huge, and converting all of them would not be doable
> > > > entirely by us both in terms of amount of work and for lack of hardware
> > > > to test the changes.  
> > >
> > > That would only be necessary if we allow any change everywhere in a DT
> > > on every system. IOW, if we accepted the userspace configfs overlay
> > > applying patchset. If things are constrained to specific systems and
> > > specific parts of a DT (e.g. under a connector node), then it is a lot
> > > fewer pieces to fix. If powerpc is excluded for example, that alone
> > > eliminates a bunch of code and drivers to worry about.  
> >
> > Bottom line, I think the takeaway is that in your opinion removing the
> > unsafe property accessors is not a requirement for accepting a driver
> > that loads/unloads an overlay. Only having zero warnings for the
> > specific overlay is a requirement. Correct?  
> 
> Right, assuming unsafe property accessors warn or we can deem it safe
> in some other way. For example, we've had fixup overlays which fixed
> old bindings to new ones in tree. Those were safe as they are never
> removed and are applied before the affected driver probed.

I see, good to know.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

