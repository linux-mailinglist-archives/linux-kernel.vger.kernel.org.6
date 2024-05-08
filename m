Return-Path: <linux-kernel+bounces-173172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DDC8BFC86
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E20282849
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072B882C7D;
	Wed,  8 May 2024 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QyAPnrLz"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C959C82899
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168629; cv=none; b=n5UjeV+hI3ZCaPnPqfy4a3sYvTqLPH+LMIv36CqAhI6nbcFNc2iJXGkIbrk7ckr9e5Fxk/J5eRVp8CxtcggbjqKYwVKd6EChGke7ua2rhG3Y7zHXGpLZUz3ZmKQuDqjeaIon+LNxeQdCv/yCEbODVZIYJn9JVCn6aw4ut3oX07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168629; c=relaxed/simple;
	bh=KMEJ67Lgf0ato9GCP4BhJGyrBemrOUmEZZ2EyOeaUVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrN3+qRkzVMXC2FPEXIaVJGoNUQD/uESL312dTx7n5UvERJWO1D3OI645k2rcSo8JfoFNytuHGFm/OhEL8CRead4Yky9Evj2hM/p/WzDGPLFIK4S9ffz/j6k/Umk6dDWOOIbJs++4kk8z4C8aQzy4sw3whtg3499RKnKF4ZsxG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QyAPnrLz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b6456f7e94so160852a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715168627; x=1715773427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzEeV8O7cqpPCMasGDN5yB28tX49+B8gmMSvUBqc6vQ=;
        b=QyAPnrLztXMyrY/TFo8TGdM+2qOIVSpYTb+g2N0xq2uH/MuybjsbOXTK43UtSpijNn
         Ay3bvkooK2AHoI3QRtMYe9v2MEp6YWZwS6Khe3iloB1kaVgSNg6SkOcm6BofYy09u9Kw
         OzJ9iEyg+vnyMgiyRHOEhifbTkSyRg4rDY+jxWcUIB7bLxGVatSXVENlp5XC0n21VIjs
         NFPG4334x1L5SmCMkIeG1MSVknqJEjqfV+2fw8+4dNlM+Gxd4Si5CpH2l1t5qcNh3DS1
         ILivQu7pGrGCTOiXJuUC6YkvcuFT+TN4ZV5r5yrKlw+y2YIZXZ38vqrvNmH3blOBmRJP
         /pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168627; x=1715773427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzEeV8O7cqpPCMasGDN5yB28tX49+B8gmMSvUBqc6vQ=;
        b=npO8hyBE+XS9/BbvaZouQ5fTFDeVDxffVAh7mdegztU3UbOMe+Ugpj8OUBzIDEY85h
         UqsePyLXrQM7BdCBGAS9V8s9dMFn+WQPY6IG8LmcHjXMqiamtsLmlfL7Yf+8LuK3+TlK
         ubSs/7dqfj3oerbfjLyq/ePmnXuhaY9gsxC+mIwdNPp9BKDdpF3D7mzZbAA9Dq1KwQy7
         1lB+UZKV1h+/FXm76/rOH/2kJcot5n7RoeXA/s5dWhHo6J+V1OQrAy9Etc/6DapBpAun
         dWKK8hvESxTzO6o1Hvtzk6DBqR+3bVruYhSHQIgOWLhlTAGw6tWl8mTcbNdUuGOAb50c
         G8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXAnT6C5ee6zS+knhNTRIV9CuayTGByorgp+JyymxeDHSvt1cO+WEXjiESgV0DpQYRtvGI6UuPSLrQIfWEH43qI6Tq17cWiP3Ngmd8
X-Gm-Message-State: AOJu0Yy04V39DzRZDTKnnuRXYQwnLajCjD05aQZJtKh13YddrnxTIbZ8
	WCDFNfWaUVkV0rGLLmt2jFcsDijEh5jyAByYBUtGBSxCHfEGawlh+kLtKa7Wo6zIg1p2ufwiFkF
	mZ/tkZPiL1YIp0VTxw/XXS0LixbAG/RtndSW7nwFA/nGcswAcxbc=
X-Google-Smtp-Source: AGHT+IEO3bd85u0B2AuxdYue4avxAitA4qBL7f0hd7JLyvHCW/eV8DnhuJEJqXEQqub2JjhK5jzqGCHK0lLkb/fyC7g=
X-Received: by 2002:a17:90a:fb96:b0:2b2:802f:e90a with SMTP id
 98e67ed59e1d1-2b611aed27bmr3178106a91.24.1715168627082; Wed, 08 May 2024
 04:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
 <20240507135234.1356855-2-yangcong5@huaqin.corp-partner.google.com>
 <171509488827.493449.2668049686067198439.robh@kernel.org> <CAD=FV=VNNB=jtyM1BMTUTzyTjOUqDxobWTYz9RAnCmYha-DG0w@mail.gmail.com>
In-Reply-To: <CAD=FV=VNNB=jtyM1BMTUTzyTjOUqDxobWTYz9RAnCmYha-DG0w@mail.gmail.com>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Wed, 8 May 2024 19:43:35 +0800
Message-ID: <CAHwB_NLhKqqy-Ot=HjiG2oZ6MraYvvMaV_=r60=1yR4164FeaA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: display: panel: Add himax hx83102
 panel bindings
To: Doug Anderson <dianders@chromium.org>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linus.walleij@linaro.org, 
	xuxinxiong@huaqin.corp-partner.google.com, airlied@gmail.com, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, daniel@ffwll.ch, 
	neil.armstrong@linaro.org, "Rob Herring (Arm)" <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Doug &Conor

Doug Anderson <dianders@chromium.org> =E4=BA=8E2024=E5=B9=B45=E6=9C=888=E6=
=97=A5=E5=91=A8=E4=B8=89 00:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Tue, May 7, 2024 at 8:14=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org=
> wrote:
> >
> >
> > On Tue, 07 May 2024 21:52:28 +0800, Cong Yang wrote:
> > > In V1, discussed with Doug and Linus [1], we need break out as separa=
te
> > > driver for the himax83102-j02 controller. Beacuse "starry,himax83102-=
j02"
> > > and in this series "BOE nv110wum-l60" "IVO t109nw41" panels use same
> > > controller, they have some common CMDS. So add new documentation for
> > > this panels.
> > >
> > > For himax83102-j02 controller, no need 3v3 supply, so remove it.
> > >
> > > [1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=3DzBQJUC4CB2wj4s1h6n6=
aSAZQvdMV95r3zRUw@mail.gmail.com
> > >
> > > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > > ---
> > > Chage since V4:
> > >
> > > - Update commit message and add fallback compatible.
> > >
> > > V3: https://lore.kernel.org/all/20240424023010.2099949-2-yangcong5@hu=
aqin.corp-partner.google.com
> > >
> > > Chage since V3:
> > >
> > > - Update commit message.
> > >
> > > V2: https://lore.kernel.org/all/20240422090310.3311429-2-yangcong5@hu=
aqin.corp-partner.google.com
> > >
> > > ---
> > >  .../display/panel/boe,tv101wum-nl6.yaml       |  2 -
> > >  .../bindings/display/panel/himax,hx83102.yaml | 73 +++++++++++++++++=
++
> > >  2 files changed, 73 insertions(+), 2 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/display/panel/h=
imax,hx83102.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/display/panel/himax,hx83102.example.dtb: panel@0: compatible:0: 'starry,hi=
max83102-j02, himax,hx83102' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/=
]+$'
> >         from schema $id: http://devicetree.org/schemas/dt-core.yaml#
> > Documentation/devicetree/bindings/display/panel/himax,hx83102.example.d=
tb: /example-0/dsi/panel@0: failed to match any schema with compatible: ['s=
tarry,himax83102-j02, himax,hx83102']
> >
> > doc reference errors (make refcheckdocs):
> >
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2024=
0507135234.1356855-2-yangcong5@huaqin.corp-partner.google.com
> >
> > The base for the series is generally the latest rc1. A different depend=
ency
> > should be noted in *this* patch.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
> >
> > Please check and re-submit after running the above command yourself. No=
te
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checkin=
g
> > your schema. However, it must be unset to test all examples with your s=
chema.
>
> I think several of your bindings patches have triggered Rob's bot.
> Please make sure you're set up to test this yourself and make sure you
> run it locally before sending out the next version of your patches. In
> general you should get in the habit of running 'make dt_binding_check'
> locally before you post any bindings changes.

Sorry, I forgot to running 'make dt_binding_check'.
Thanks for the correction.

>
> Thanks!
>
> -Doug

