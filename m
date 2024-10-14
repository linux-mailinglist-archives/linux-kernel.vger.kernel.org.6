Return-Path: <linux-kernel+bounces-364232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390B899CE45
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23D8285C14
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171B1ABEC7;
	Mon, 14 Oct 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcsgqAGP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3271AA7A5;
	Mon, 14 Oct 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916913; cv=none; b=nf1Yg8+4+vgOu1I8bVJ8fhWK3+AzO9KPkM6r5eYDxgwIPbnjOgSagquqCW7TmEEPoQRKLYTfQgpJXyLd5IgNaVOTgkLNfTj4/nBtSLCG9kxfGbofsS002NuK7JoDVpAVCLVww8Opakw2532gBhVIYBKJJMaSpCOBRmecNl4UECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916913; c=relaxed/simple;
	bh=rY79BUgN/CM94jWFNT2ZlFSCTcGsA4bn1sRBiJL2Rpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHELJCtK3qV1o6RBL4TcfiFoevZg1IOoCa+O8Hi+HjdQpOI8yOLD+T2uoHl6+jAreTonuCqI1I1IRxbx/BBiib15GR518xmFUfOpgXHrNDfaElwmWl0l+AOaKiDL/fI9NvgvTVHOAqLXOGuX/9lHylEoB7dKIZjZAI+D4zE5nL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcsgqAGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105AFC4CED4;
	Mon, 14 Oct 2024 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728916913;
	bh=rY79BUgN/CM94jWFNT2ZlFSCTcGsA4bn1sRBiJL2Rpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XcsgqAGPN4aV8UNs4VooexXNpBSjGq1WdDtdt2s+B/8OKnMKH24/WoPrd+ktoauhe
	 6fZePnK65u0+sgqU6CX2eJi+wofJ12WeINGEZoL49DpHjvG3oXUbbbfb0M4Diy5/Ju
	 nSpCL6UeWTEphr3fXcsET4dSMFeFtXu3zlvgkmtSade8Ur8Y8+ag3uNUWO7eA96WWr
	 igI7dqYnFxYSJDxEFuqab06aLBtyis//8I2okdF4wSogH+PbPvxYw1oLQrTALinuq8
	 jcBiH0kmidrUw7pgiEiTNHVGHgr12pvFLqyd000qGxn+uUrINJlouTQaawEX4cOBZA
	 LcdzbfnnZos4Q==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539983beb19so4675902e87.3;
        Mon, 14 Oct 2024 07:41:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6qPlMzMPRbRrPiy/iNGbOBRGqjJHv17jPuXBIZYfFF8jJwlO4XvuMhMRXpe0CB6Rytb4gzeBfiWorAuMe@vger.kernel.org, AJvYcCUbuYYlaLoBHmLtSR/4qGEDTOPH3u9iAk2jXlNC1ttDvPuc6C6VGlBTiI3B/QRbMoPvybKHlYN+0TWv@vger.kernel.org
X-Gm-Message-State: AOJu0YzktDvGkSxadaEja2OojtcTviJjWE+T3a1kGhaEUgg6mSgkTkdV
	jM/Sjv/Z2OXbvNBUZE1Y9POC+PeIeFbdWHx9PtTcphx6/6UC+ef3PzTOV1VuWdtmljEWJBXEuEE
	eXgdczTbIFP4JWJfQMw2+rZgm6Q==
X-Google-Smtp-Source: AGHT+IFIr+RKLmlCBPzIpUAU5sgJpFk4qmvwBGFFQfHfWEInjzOGd25FCcWiN2Rh205ppryrUv13+0Wq5bSjDYLzBp4=
X-Received: by 2002:ac2:4e03:0:b0:536:553f:3ef9 with SMTP id
 2adb3069b0e04-539da4e0b9bmr5115879e87.27.1728916911416; Mon, 14 Oct 2024
 07:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013200730.20542-1-richard@nod.at> <7aq4nedii5jgrlg54kzyi3plri6ivheeo2kpxxg7q6ofr3wfsc@acsrg5rzzmzg>
 <3247761.5fSG56mABF@somecomputer>
In-Reply-To: <3247761.5fSG56mABF@somecomputer>
From: Rob Herring <robh@kernel.org>
Date: Mon, 14 Oct 2024 09:41:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLJ9+cd9En051uRW0=r_NtXgh11KNEqys538Hsg3wcTmA@mail.gmail.com>
Message-ID: <CAL_JsqLJ9+cd9En051uRW0=r_NtXgh11KNEqys538Hsg3wcTmA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] of: Add debug aid to find unused device tree properties
To: Richard Weinberger <richard@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org, saravanak@google.com, 
	linux-kernel@vger.kernel.org, upstream+devicetree@sigma-star.at, 
	Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 3:51=E2=80=AFAM Richard Weinberger
<richard@sigma-star.at> wrote:
>
> Krzysztof,
>
> Am Montag, 14. Oktober 2024, 09:49:14 CEST schrieb 'Krzysztof Kozlowski' =
via upstream:
> > On Sun, Oct 13, 2024 at 10:07:30PM +0200, Richard Weinberger wrote:
> > > This is a proof-of-concept patch that introduces a debug feature I fi=
nd
> > > particularly useful.  I frequently encounter situations where I'm
> > > uncertain if my device tree configuration is correct or being utilize=
d
> > > by the kernel.  This is especially common when porting device trees
> > > from vendor kernels, as some properties may have slightly different
> > > names in the upstream kernel, or upstream drivers may not use certain
> > > properties at all.
> >
> > In general I don't mind, but I have a comment about above rationale.
> > It's just wrong. The point of DT is to describe hardware, not the one
> > given, fixed in time implementation.
>
> I agree with you, sorry for being imprecise.
>
> > What's more, writing bindings mentions this explicit: make binding
> > complete, even if it is not used.
>
> Yes, with this aid, it is IMHO easier to find bindings that need attentio=
n.
> Just as an example, lately the device tree of a vendor used the property =
"timers",
> but in mainline it is "ti,timers".  With this debug feature, it is easy t=
o see that
> "timers" is not being used, and somebody has to decide whether the proper=
ty is
> really not used by a driver, or if the binding needs more work.

Paying attention to the schema warnings would have found this issue.
Assuming there is a schema for the node...

That's not to say this type of run-time check is not also useful.

Rob

