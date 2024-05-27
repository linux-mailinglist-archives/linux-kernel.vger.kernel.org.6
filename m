Return-Path: <linux-kernel+bounces-190591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6108D0029
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3901C21472
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF8115E5B1;
	Mon, 27 May 2024 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPKZxi1f"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D038FA6;
	Mon, 27 May 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813422; cv=none; b=dmbybSiBjYJNoaeRfUyVoCuy2ukqCKZ7zAMVti3ibYlwU76YTmNYiV4ZyYVKp/kWktNSetO39FyoHblCZ3l68xPQtB+5mhsStvWkUu3sZF0PgkLJbz/0M/CJEJ3cj7ZwxxLsET5fFaYzb++vgY1VQu+Pi7pw/95gx5865P8Nqxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813422; c=relaxed/simple;
	bh=wRFP8S2fE4xivjqQVPOI2HxthRP0YWGnVBSIpwhEIqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDgq6TkBoEHMNlde6Np0YOgaZzouJtGKKYJXHJuQFF47IdTvMe9c+TDGhz9S/BlfVIf087ZOd4puEu0dBumHE/sFVAxSjkmpGbmDsSF74JBnqX19ByzLY2APqYzMG+fuzv8ZaUS+SzyimCUx5g4qRgjBpSQgXGfz8bZYk1R8sm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPKZxi1f; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7e24b38c022so148751939f.0;
        Mon, 27 May 2024 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716813420; x=1717418220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xDxrXBc9LQxklL06A0LeabV2mZ6SgqSB+i2/2QkjT0=;
        b=hPKZxi1fd31tfyGyZoqeuqQxFA9I1Iyi3UWutKdpe8zVX5xeEQikyl93fRjc3R3tgT
         d5hjWDmTMigFWiEtk+Z+XcF1wAAuUODAv9m+F0Y1u6pjqEJmbSyCjsUyuU76O7/O+m09
         yWDCIvhHFnEaV4SQhz3lpFylcchshJMkIs0/2CrNSGBnTeR9dbK7+SijKdxt7aTmEhsT
         JhDtykKjNgouiX8x0NyN5J+I/rYgrP4Lh3a0hbDMT6s5okVkCBDQeww5sMPNb0fwnhZu
         6EvksS/XtOQ0HwhM0tWz21ja9me9PbXq/tkvAlsIbFVoYdbarEDabKgQx1tU6RsVgpNW
         TqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716813420; x=1717418220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xDxrXBc9LQxklL06A0LeabV2mZ6SgqSB+i2/2QkjT0=;
        b=RrII68Dejbq1HkF4fydL3l0VZhtEv8gCoDLKLUDXccotD4FRoUa7m9nBS/BaGLlKBQ
         mEHtMmX/Au2gSKMXDbHXuFVbaYBOAjJihzZUEd78ZF9Gt4h81c05ghX8b9qLiIHvc1Yj
         9yFZuuC0jO6Rxh4h4ynBb3F/w4RG3tT3DenYXINsKfpn2yL8qlyYTGwHkgnSbUqVp1iA
         gc7fPzYe2QL0fMsRGqN2WnHiYnkFPrCp6+kUlHWx6kqAOPIYI/RbfsgkujcPoJOCzwQO
         BST8vDrkQTac8c+0k4YRil5sNBpllW7GfA79XtFY9ITLHA2PxgrUUCrzWx5gB6IjE2HB
         Jotg==
X-Forwarded-Encrypted: i=1; AJvYcCVKuZDLZTnSxVXsONjJbkb6561ADMeArUcWrh3jB6C/oUcMY6mevPGugd1D5vpcmz6quVLLVqe/gblNAnwONLnKg8bloNRtB5pIkOXweY2S0x4CSXXevhncSgb7vYqLeNzmZD+CJWC9
X-Gm-Message-State: AOJu0YwisCo0QUiBZYhStt0KNRjJ/gOpfvXJCwLp/8+qqK4qxLvgPvRD
	6OGaHKEKeEE41b9AnjchzDtdQ1EOslNRumBcGImJqrrzyGP0qIUODgmq/SGPnoyypunhTV0ixto
	4cgeb45AQJKEnJrgijpskPF5fLOM=
X-Google-Smtp-Source: AGHT+IEbenEcD+K7Us/kByyWtAmMBYYHVQCv6uadqsaIVTfah+m3rW87L6fvsdS5x3c0A9QwWYL3fjR0c4Rd9rc00VY=
X-Received: by 2002:a05:6e02:1c02:b0:372:1434:8241 with SMTP id
 e9e14a558f8ab-3734aaff46dmr95389355ab.13.1716813419885; Mon, 27 May 2024
 05:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711026842-7268-1-git-send-email-shengjiu.wang@nxp.com>
 <20240424164725.GA18760@francesco-nb> <f0a38df8-9197-452d-a46f-2bc2697c1186@sirena.org.uk>
In-Reply-To: <f0a38df8-9197-452d-a46f-2bc2697c1186@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 27 May 2024 20:36:48 +0800
Message-ID: <CAA+D8APWGk6oJJsfLhcOfyzMo7uNFABFmeF51gerSC_16xj9uQ@mail.gmail.com>
Subject: Re: [PATCH v4] clk: imx: imx8mp: Add pm_runtime support for power saving
To: Mark Brown <broonie@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, 
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 8:24=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Apr 24, 2024 at 06:47:25PM +0200, Francesco Dolcini wrote:
> > On Thu, Mar 21, 2024 at 09:14:02PM +0800, Shengjiu Wang wrote:
> > > Add pm_runtime support for power saving. In pm runtime suspend
> > > state the registers will be reseted, so add registers save
> > > in pm runtime suspend and restore them in pm runtime resume.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> >
> > Is this introducing a regression?
> >
> >   800 13:50:19.713052  <6>[   16.531134] clk: Disabling unused clocks
> >   801 13:50:19.727524  <2>[   16.535413] SError Interrupt on CPU2, code=
 0x00000000bf000002 -- SError
> >   802 13:50:19.731400  <4>[   16.535421] CPU: 2 PID: 1 Comm: swapper/0 =
Not tainted 6.9.0-rc5-next-20240424 #1
> >   803 13:50:19.742514  <4>[   16.535428] Hardware name: Toradex Verdin =
iMX8M Plus on Dahlia Board (DT)
>
> I am now seeing this failure in mainline on both the above board and
> i.MX8MP-EVK.  There was a fix mentioned in the thread but it's not
> landed for -rc1, both boards crash as above.  What's the plan for
> getting this fixed, should the patch be reverted for now?

https://lore.kernel.org/all/CAPDyKFp4V8f0iyeRASSEu4YaCSz0m56=3D8ssBJ9ogSvqG=
1dzMZA@mail.gmail.com/

fixed is merged,  but may not in v6.10-rc1. Should anybody help to cherry-p=
ick?

Best regards
Shengjiu Wang

