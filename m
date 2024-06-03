Return-Path: <linux-kernel+bounces-198827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AF78D7E02
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A0A1C2080D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7B770F1;
	Mon,  3 Jun 2024 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4X+8xUo"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D7B53392
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405344; cv=none; b=DZF2VGHMYIyhSqiIAUFuFyuV6IHguTmbd7FckrJUnq+lP1m4ieWvaKQfLY18kuLMZGSyUvu4FBQnKoxNUJ8j8ImAUxbuBOlFY2LToUGTo+wEvz0s3l//2azgYcDwakgeJOG+POoDduWlW32YLdApyC8a3tKlFNs7azmqqaxMXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405344; c=relaxed/simple;
	bh=AcydM7QsoGt9wsjKnGfhQXGfHg0USww1QuCKbjHudHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiyIFre0X4rD3ljzEg8RZrLSEgXad/D9gkDRvBo/1++VWkA4hBOKy4gCyN5WoX0NHdr+brOMJA39j2mEQxcsLskRYsJVl6HVD8KtU+S29OP1+6C7Ir7POgYZXlH5fz+ozHP2tS7pE0+dJyADi8xFOxm1szH5XhvvIQMlNwmeuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A4X+8xUo; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e72b8931caso45373731fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717405341; x=1718010141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcydM7QsoGt9wsjKnGfhQXGfHg0USww1QuCKbjHudHs=;
        b=A4X+8xUokr0JXk57wO3Lo3dxNBUuwPKtS3mKsYy3xPmJzSbPgSt4ofBkH2teDZV0VI
         G6cm6B2ztHoLC57IHKeQ9/cLGMTmiTHyXs0xEirJt8A4cRa7pwmZ3hgkACs2DTdIT0yt
         YPdKVO090l00ubcmpWFNWtg6VMiW6EbM9Qiyu7PxTATxbsYoOpoHKQWBX0sBYgwKBaY4
         8mZ9r4Fjut3qTBPNaO/178EkoxLm9koObr6OfXbg5zqx9imLh0D1KBSvSPX2c8icauYs
         HUnwjC5Q0U5g0fvojJ9MmtQZWseFwEI/dCikyq7uPtw1IGwZj/wAP4QNW0tJt0eRg0nc
         AOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717405341; x=1718010141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcydM7QsoGt9wsjKnGfhQXGfHg0USww1QuCKbjHudHs=;
        b=GAkmNxccfaF9+NDt/9bdx6789Brnp8d9nunfw29yNtsnHddvk9StkW11tXEKY7AhZx
         lG4+CP7wImihGfA2RS3ewKA8ETiPCH7WzTvPyBmWTH37FNzEo1q53CtOBUmmBnkXhpqj
         1Neqr2DfhMTdVmmZ8vXHQ+VCzTZcrQY3WUkUS1Vf8mmE4Xzjwx0ZmkAM8ge+8aJ5exW+
         A0IRlm7HwoIac7u1bkHxWMiXyUf5VsmD1nNdC3dzqXyjGSSARQg6rD07mWCGb7ixAess
         VjK0rMGpQomFLkrjP91F1qwj2qpjRW5YK6K0vKZy8/QXzeLylfb+pD6oOVNxSxcC6GAJ
         J2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWNpfiBW3FQX1A7wW+1ZWLV2ies9fen2Y0RV/E11FKCkhEr5iu00SpeucysGWO0V25iEG0aMvhAAYXePy+km5+HAC+uaPorF2eIzgYY
X-Gm-Message-State: AOJu0Ywgn6iwY1MmtLQ8FFQooMB2jdeXhtCcyWMc4jf0LgNbk9Dn7xPE
	ozT1x17K87pR3BDSQNBnlELlkjbjgIMiG6sIebJu/4R8eoo93X2mmUi6kolq0qRc0Wcn+qOebOI
	h3TK2k1DlIdYnLl1p69/WIwFDdVn6qZEifWttpg==
X-Google-Smtp-Source: AGHT+IEVI3F0oXXlsedQRXHnOmAZNvZf/Ix2jmEABaS7X8f8bO9zDtlbkikRksb5ReaaWxEFK9ztgDuFWCd8m7IkxTE=
X-Received: by 2002:a2e:9f14:0:b0:2ea:83b5:40cf with SMTP id
 38308e7fff4ca-2ea950c8010mr49046331fa.3.1717405340591; Mon, 03 Jun 2024
 02:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503162217.1999467-1-sean.anderson@linux.dev>
 <CACRpkdbOAoSDNFhXfz3djUZh1_MQ_T75CC+-LmojRXvyCbUusA@mail.gmail.com>
 <06a4e5fd-3d26-4923-bcbf-0bdd66d756c4@linux.dev> <CACRpkdbSsgxtKqF6ORXubufTaegjysHU7zH-tJfDfKNd=Kdoeg@mail.gmail.com>
 <51d984f5-896e-469f-914d-2c902be91748@linux.dev> <CACRpkdZ19+zUCEBCJJ+MBnnaF+caZKFTDxYiWZ0BRGx+PxN3bw@mail.gmail.com>
 <e4972a07-18d6-4a8b-bb5a-4b832aa2d20e@linux.dev>
In-Reply-To: <e4972a07-18d6-4a8b-bb5a-4b832aa2d20e@linux.dev>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Jun 2024 11:02:08 +0200
Message-ID: <CACRpkdbL63ZWcopgBbANKzr476rO6_cwZL6JLqkvTDXbzzpkpw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: zynqmp: Support muxing individual pins
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Michal Simek <michal.simek@amd.com>, linux-gpio@vger.kernel.org, 
	Krishna Potthuri <sai.krishna.potthuri@amd.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 7:08=E2=80=AFPM Sean Anderson <sean.anderson@linux.=
dev> wrote:
> On 5/29/24 04:38, Linus Walleij wrote:
> > On Tue, May 28, 2024 at 4:28=E2=80=AFPM Sean Anderson <sean.anderson@li=
nux.dev> wrote:
> >
> >> Well, perhaps you should have reviewed the original driver more
> >> closely.
> >
> > Do you want to push me down and increase my work related
> > stress? Because that is the effect of such statements.
> >
> > It looks like criticism of me as a person, so explain yourself.
> >
> > Writing this kind of things looks to me like some kind of abusive way
> > to express your desire and that is what burns maintainers out, so
> > if that is what you are doing, stop doing that, adjust your behaviour
> > and focus on technical issues.
>
> The technical issue is that the driver does not match the hardware. We
> must maintain the existing set of groups for backwards-compatibility.
> But this should not prevent improvement.
>
> Saying that we cannot have both group styles means that the driver is
> permanently stuck with whatever was picked when it was submitted. Hence,
> if you want to have only one style you had better review new drivers
> very carefully.

Actually I did say you can rewrite it to the other style, it's just work.

If the previous approach was wrong, just redo it as it should be,
and rewrite the DT bindings and the existing device trees. If
backward-compatibility is so important, add a new driver with a new
unique Kconfig CONFIG_PINCTRL_ZYNQMP_V2 and new bindings
on the side and select one from a new compatible such as
"xlnx,zynqmp-pinctrl-v2", problem solved:
new driver new bindings, can be used on a per-board basis,
can be compiled into the same kernel image.

It may be embarrassing to have to tell the device tree maintainers
that the bindings got wrong three years ago and now we need to roll
a v2, but worse things have happened.

I don't like the approach
"this was done so we cannot redo it", we can always redo things,
it is even expected as proven by Fred Brooks timeless statement
in "The Mythical Man-Month": any team *will* always design
a throw-away system whether they intend it or not, there will be
a second version.

This approach will be more clean, I think? Also it will be
possible to phase over more boards and perhaps eventually
drop the old driver and the old bindings.

I'd like to hear from Xilinx/AMD how they want to solve this
going forward.

Yours,
Linus Walleij

