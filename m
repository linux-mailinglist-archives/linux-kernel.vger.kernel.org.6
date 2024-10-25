Return-Path: <linux-kernel+bounces-381275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB3D9AFCDC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66424B22C11
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8611C1D356E;
	Fri, 25 Oct 2024 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhwjyihS"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BCA1D2234
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845799; cv=none; b=o5sPzmQt246VwR4URb3rGYME839M4rkajGA5Z2HkZ7Ytol03/KdcciOqUTbRKl/4TOPr7+s7od2eFui7heK5t/d9Ds5Q4n0PbZr6Nw7uhQYqHUXq3rGXPw6/eI2pMNekioYKThPhgUKJqgMeRdMXt0ICjdmG/ycChaVf9HPoBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845799; c=relaxed/simple;
	bh=Is6fCU7r2O627z6txt09DGR3k7pJC1u2UpNlPdCrthw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrSkh3GPRleRirvxji2cNMMBnWC6R482HlySIDwU0d38f7899l19y1AJh92aWo2holj4P7zeDfabnBPd9t3Qlgq2DPy4yYRz1Gcqk0XIpatodktL4FDi4SIkh5TzhnQyDgMnTb1zIQAjmW0DkxHOGnPr2xWBnEoZLONpscGy6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OhwjyihS; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so18218251fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729845796; x=1730450596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bnGk2OAtXC2qhYzxaIFFCqNFOv/GnSjD450ML+33Ug=;
        b=OhwjyihS7PDKATuISukhE/gTsFO0++MeLlAa4En2haUcxfoxt/FJjEfQcp6tpHsPRG
         7+brU8WGJT7nut5a0zitfFNknM3sUwmDLULfkYXkBA5wTlrelX9pgeTYrs7ToABHZH5M
         6dsfINdkySTMkU6LiMGov08QwJwNVo1a4Q72NnSZOw/H+qZbtFVcsv0YFlRc81cw4fgp
         31wf/OR48ES74u5wVKj/ls4itIHZioPXdsl7PAR2c/msYwhpGdN6YbiJlXGgvVn2xkiU
         QpccuriUEQGqLqEMrjr1fXK+sA8CuRjHlJgirow0Q8tzNWNyF1kHorx9ZPy4aRaE9ymp
         2Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845796; x=1730450596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bnGk2OAtXC2qhYzxaIFFCqNFOv/GnSjD450ML+33Ug=;
        b=dV6QTVuwmHCM8SNgJ2ngWncGxVswa1Xr2DbS9Gla08YtsQT9qjVZXs13258TBLcq9O
         EmTCKkC9043dPDVhcLlBBnZHxeCa4HTmKQtGgPOyfUGv3CLwPcjxPHMDE1J9tAgzwVDO
         JietX9FuX2bLXYw/z5XtV5QWveAi5NNDa0QByK7xCkmO6wiRbfUXAxEGbiGtfC3FKPvl
         VIcGD1Td3ep3Py4wIQGczS/YNPBrej+m95BEVac6zXIRMpZMGPpTYSk3+65BGw8Une0n
         uFA4oqrQhkMnrU7TYkrmyNjg0RB+R/ttmJBOCpNI+1VRmXzhiYp90OTQ6INHGcz5ztQw
         Diqg==
X-Forwarded-Encrypted: i=1; AJvYcCXg22OTv4f+sIdHBx/xtB1JKk0n43s6vdg3RvHHaG4wO+huYdvpEZU9WwaxVUrhc8rKiiDJXomykRkiLZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxgAip5V24SCLVTP2rPLvpGzK1oPk23NXNelYHoprH7lrWjtEC
	Q7KYs0UnDi8mkP9banf+c1DqgyfzW/Zd4+7rdKtkNdmhysOrel/dshTHN5hDwgJpNa7JjJxn1yE
	cXd0IJT6m8mXhPz9yJw69u+s1PvljrDmnx+RGpw==
X-Google-Smtp-Source: AGHT+IFTV81QGcolch/8VXee4TeMVNEV9PtzSPTWGGsHdEXX8yJwrIRqHsjgTqxOKepxlFwseluy+FDPbbQYHwW5Z4c=
X-Received: by 2002:a2e:602:0:b0:2fb:4982:daea with SMTP id
 38308e7fff4ca-2fc9d5a992emr39283951fa.32.1729845795871; Fri, 25 Oct 2024
 01:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021230414.2632428-1-quic_molvera@quicinc.com>
 <20241021230414.2632428-3-quic_molvera@quicinc.com> <dnri3nqq2una3atjwl437ujzrl2txl2zdyb2ima5qeeudqotxn@5zdxizip6mhb>
 <d21b259a-1f04-4108-a201-254b44f07529@quicinc.com>
In-Reply-To: <d21b259a-1f04-4108-a201-254b44f07529@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Oct 2024 10:43:04 +0200
Message-ID: <CACRpkdZX1qrMDR-6LuUtc0nqLK3MwrUYQm9bsRZL376Qj6x8XQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add sm8750 pinctrl driver
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Trilok Soni <quic_tsoni@quicinc.com>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:18=E2=80=AFPM Melody Olvera <quic_molvera@quicinc=
.com> wrote:
> On 10/22/2024 8:27 PM, Bjorn Andersson wrote:
> > On Mon, Oct 21, 2024 at 04:04:14PM GMT, Melody Olvera wrote:

> > [..]
> >> +static const int sm8750_reserved_gpios[] =3D {
> >> +    36, 37, 38, 39, 74, -1
> > Any particular reason why these are not gpio-reserved-ranges in
> > DeviceTree?
> >
>
> Not particularly; I wasn't sure whether or not to include in the initial
> dt patch.
> Will add.

Can we also write (as a comment in the device tree) *why* they
are reserved? Such as "used by BIOS/ACPI/secure world"?
Just a minor nit but it's very helpful for newcomers reading the
DTS.

Yours,
Linus Walleij

