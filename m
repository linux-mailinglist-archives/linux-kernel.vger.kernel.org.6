Return-Path: <linux-kernel+bounces-232946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9F091B058
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041F41F225FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA2619DF73;
	Thu, 27 Jun 2024 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mbG/bkPr"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23D19ADA3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520014; cv=none; b=CwsElGwOplf4QutCNR2QLBQS2i4Ygh5PlN8tmh5suIp8QmoD1KyGr8EX5COf921t3JnXg7jl+ecS0iVGUEcqw5xMHAIsfOFa6lco3JahajGm9XBvfoxNiLoLTK49tfNCbAuDzwXBWykP/SfyeMXA1M9yrBbby71lUnNvBa/VGGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520014; c=relaxed/simple;
	bh=RGVGg8f7DBxYNIjZHq8kWvdX8KI04mlNvh9Z47WtPGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYcZ2RtsRgdaaZNgGRXzYTgyhvG3862avKxn1hbClmRMjxoWe1eq5iy02/IyX1X4KmOA3CU7PiDdIsUQICePGgV0ekHyiKaFruc5RdrRMw2N1dcXwidEXNS1OobcbbCaVWUxNyirBxNfYfv9xtfqTBj6TIpc/5wz4wOCKXtI4A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mbG/bkPr; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cdf579dd2so6098109e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719520011; x=1720124811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGVGg8f7DBxYNIjZHq8kWvdX8KI04mlNvh9Z47WtPGU=;
        b=mbG/bkPr+yabCOxyMSpOwkV38l7aqAbT1S034xAPNppVDr1x4coRm4QA6rwTnNeUi/
         k7wlH2a4aTWxXoMf2L4ol+fMjAmhA/i0yMBh9OEOjxASFxnZjNt5ZuLMIuFaLJg9yX7F
         gPbTU0VL1mHZYx1qH8U4k2A2GxKQh5lCOBNvSlUIX5JTOy2szvVlUNtTyr39mavNfnm/
         HBIht695MYnFC0lKcVPY1Oh8o984jMsNy2Bd/2Sxji9LkZfnsb/CPbvuwFqE00nvv02X
         mHTK2nS7RKFLh7Ny3XQhFVoyck4aCAByotrfR0vV1dwCIi0KbGtPwnBuKU1hL5dMc8Vi
         gtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520011; x=1720124811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGVGg8f7DBxYNIjZHq8kWvdX8KI04mlNvh9Z47WtPGU=;
        b=ldX9k+vbPfQbTJlXBKDFxxFEdGgNLdWwSnroqhvmrnhjcPdyKRE7Be7yXPPUJG72qd
         pa40quPIhW30yBUGPXHU6Z1r79uzY5JqPFPaEheh2BJDWCdkq6ur7ouXwvRvwxAydxKK
         DnF6vJmY3+pPkE6DJlRl7LmU6/bRDPzt4spI1UQ5fCHCj60qtQyeP/HZKYg3HPlTpxHv
         JAtV003YZpZypXqMc+F/9aQU2th2zxO2oQtXka6OA+E6xdku2g0tuANZoeGHI1cUM1Cj
         WN1Zc/Gt3Ju51s1amcmLDkAF9xqcCBDHZBe4vbivdosoatuZM4aYI4KwKrDCWuBUAftU
         PX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTgePE3AGC83ZO7fZWWU9BW5u6LIenuUx/zAPSTHKtpO080SUkPABcFJv0Ud9jQLiOmsuPmlNp+V3sysiJdIno4RMRvRD+nThzaMAr
X-Gm-Message-State: AOJu0YyB02tpruVAHRxelD9g+d1EIdCjGGfDXEMnnorLeNexnrn0G3K2
	zSDAo1CggMS2NdEO2HvjRpY2iS0X0UAZFxsPeHIhuc/Lo+sggo2eS9/EcToKD3HQEveQ2aLN9zQ
	ThtU1dLWHdNwtcvkWLP6sDvN32nVCeJajN3yL85rWhQBwOKReSJA=
X-Google-Smtp-Source: AGHT+IGZmO/lpYnkfdi+ZwB/Zq0xLlJuMNB2u9exwn3vugOCxHcKNeelxSv5hf2+kDzvi8nqjG7Lka9UyeUh50bVpGw=
X-Received: by 2002:a05:6512:2810:b0:52e:6da6:f94 with SMTP id
 2adb3069b0e04-52e6da6100emr3757924e87.60.1719520010802; Thu, 27 Jun 2024
 13:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528191536.1444649-1-robh@kernel.org> <CACRpkdZznuUSAKZx-BLgt+smaTDt8fVtJ-xRzL_0u7uYMDGJog@mail.gmail.com>
 <CAL_JsqKAXnu=CDsOAOoxF0sBnzMxaCDVUU4Z+2k8kseTMvc+eA@mail.gmail.com>
In-Reply-To: <CAL_JsqKAXnu=CDsOAOoxF0sBnzMxaCDVUU4Z+2k8kseTMvc+eA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Jun 2024 22:26:39 +0200
Message-ID: <CACRpkdaCMfpa25Ap3NyeWgiTTsiWJZD5Ui3YPdDB8p05OE_Lxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: arm: Drop redundant fixed-factor clocks
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 9:06=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Wed, May 29, 2024 at 2:47=E2=80=AFAM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
> > On Tue, May 28, 2024 at 9:15=E2=80=AFPM Rob Herring (Arm) <robh@kernel.=
org> wrote:
> >
> > > There's not much reason to have multiple fixed-factor-clock instances
> > > which are all the same factor and clock input. Drop the nodes, but ke=
ep
> > > the labels to minimize the changes and keep some distinction of the
> > > different clocks.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Someone going to pick this up?

I put patch 1/2 into the SoC patchwork:
https://patchwork.kernel.org/project/linux-soc/patch/20240627-arm-dts-fixes=
-v1-1-40a2cb7d344b@linaro.org/

I think Sudeep probably want to pick up patch 2/2 so as to avoid
conflicts.

Yours,
Linus Walleij

