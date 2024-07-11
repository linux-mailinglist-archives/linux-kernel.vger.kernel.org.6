Return-Path: <linux-kernel+bounces-249785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D380692EFC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034FD1C2214C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515B416DC3C;
	Thu, 11 Jul 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mPRWHDAJ"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E417A582
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726614; cv=none; b=SBUrcY6PvKLuI4D9tUzp1f3SD7Lvy/9+Bnmmzm2r/w+gev2ckycS3tHXpYlKdf/SDcnV3qV8xgeLL0/c4tHANVVw0A0IoKIs8xhpiysqqc5OrMEtYkI33ORA67DxKiKwDrmfSVd+tss4vlTOgr9WAI5Xe4HhL057VIk7dsRK+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726614; c=relaxed/simple;
	bh=ZZ1bOBY3w2CQfG/2NQXLQUZGJruqNZ9i879RYUzCCAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/X2zKBYDtr/sqqFxOehLlthpAzHV8jN3sFj/WeVhRczuVfptsjBGZqfCUU1sY7WgJrTfzqOtQWfRCUNCxvHx3V+bNVhn/I8COm9RMjW9ucsGmTrNYpup/XEI9Ulb6vpqknOuLZOUzCOnyiSqNz3sEAsaVpDbNUEo8fFP+FSHfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mPRWHDAJ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48fde375918so409085137.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720726610; x=1721331410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYCTn4/p66mHlGbWx9vmwvaVwx5YCoUoX/9c7g8wN78=;
        b=mPRWHDAJX/xy2jrrLiOs31INp8qwPXEzXMqfhC27j89CgE7PLQ0CptJjVUZXoR78zy
         ZjoJUKR0IB0gWnA8WlkRTreUvDGxYhAQpNaUgyU4PQX9kY9z7VZZLh3DoD0OsURmvn3w
         O9oA5El7UwQ+AWsbVHjk6tiCq09FVJaztD7UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720726610; x=1721331410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYCTn4/p66mHlGbWx9vmwvaVwx5YCoUoX/9c7g8wN78=;
        b=N0B0kOKFkb9rzqRykzpC4+eBJpI7UOnB2khF3cXJY/UZ6XhYQ7vHrb8igRc3bIj+x5
         7SPBmV20eG2tvx3paARxtJv9K2/5Kf1/xuZMAVQ3X/Zu4EA1GcoBiyJ5TmTbNmkeJDwe
         0cfcCYBOkQktYzw12UVkDPz50rX/kT1GnI2tlj+nbcg26NyoAV9YsJ34qVmv5MdTRdn2
         ZhEJw7LolANpnOrNAaCCC+JiQqhe39iS3jo8f8hqK5ixDMXFZ3sINPWOhl3rkPmW+rxO
         8Y/NxwqMXPTliAm3OzAb5xHprP1HaOnBAaa0OouELVh59RHA1tWc2wBkPfpqf+B1xT8C
         MF1g==
X-Forwarded-Encrypted: i=1; AJvYcCUT2tHagQ5BZfIusqn9xJvMQIUPjLIdDugxuPkqMXfCm8jQym3bap7Aaw/ueiU/3UkUsTEvKSXrystDJxhqvJ+P5QdxrLshUpRa48sR
X-Gm-Message-State: AOJu0Ywi1olW6rqYqsDRDVKP9lkvmHGaOuLvf5+g7fH5mQjN0RLlmlB/
	Jfx7L4IhlwC4aIBcfkeN/Rlb45v23ertAaSh2ssPlTjrDE+WFMhCuHhkL3kh4aXAliKciBF4tSQ
	=
X-Google-Smtp-Source: AGHT+IFW3IYZ1DcFtlMgxof/pka7/rmqyUk9mWJBpiW1dFvIIVT558+/ktJWDvH13oqFw2Cf8tQwTw==
X-Received: by 2002:a05:6102:3fa7:b0:48f:4d5c:69cc with SMTP id ada2fe7eead31-4903215c0a9mr11940235137.11.1720726609937;
        Thu, 11 Jul 2024 12:36:49 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b2d235sm33497391cf.9.2024.07.11.12.36.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 12:36:48 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-447df43324fso60611cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:36:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbh9GAFdoEZkNc5xTawcisBM4LmViCmf/Hv8WObhR10odJG3/LRAX8I8J1ktRKENhOmkuSpe5tZpcO8UpJRLNCSITjSDi9n1jCE/om
X-Received: by 2002:a05:622a:1808:b0:447:e04d:51b1 with SMTP id
 d75a77b69052e-44e793e5b1fmr549761cf.11.1720726608407; Thu, 11 Jul 2024
 12:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
 <20240710084715.1119935-5-yangcong5@huaqin.corp-partner.google.com>
 <D2LQJROQYIY3.2Q88EXS8HUDLQ@kernel.org> <CAD=FV=WAosZPSKdpwR6pjOmiy4hih=jXaMg2guuVgmc+qj-Csw@mail.gmail.com>
 <D2M42ODWQPAU.I0BMEOLKUP29@kernel.org> <CAHwB_NJ+YEMoL18Sr9HFmTVH_ErDztyF7vxxPFAE0Y2ta3dO0A@mail.gmail.com>
In-Reply-To: <CAHwB_NJ+YEMoL18Sr9HFmTVH_ErDztyF7vxxPFAE0Y2ta3dO0A@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 11 Jul 2024 12:36:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNx5qEyWDvVz6AVDryqvw09tkYRYMjbFuUQS4Wvyok6Q@mail.gmail.com>
Message-ID: <CAD=FV=VNx5qEyWDvVz6AVDryqvw09tkYRYMjbFuUQS4Wvyok6Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] drm/panel: ili9806e: Break some CMDS into helper functions
To: cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc: Michael Walle <mwalle@kernel.org>, quic_jesszhan@quicinc.com, neil.armstrong@linaro.org, 
	linus.walleij@linaro.org, airlied@gmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2024 at 6:09=E2=80=AFPM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Hi,
>
> Michael Walle <mwalle@kernel.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=9B=9B 03:38=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed Jul 10, 2024 at 9:12 PM CEST, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Wed, Jul 10, 2024 at 2:02=E2=80=AFAM Michael Walle <mwalle@kernel.=
org> wrote:
> > > >
> > > > On Wed Jul 10, 2024 at 10:47 AM CEST, Cong Yang wrote:
> > > > > Break select page cmds into helper function.
> > > >
> > > > Why though? I don't find that anything easier to read. In fact, I
> > > > deliberately chose not to factor that out into a function. It's jus=
t
> > > > a sequence of magic commands, taken straight from the datasheet. So=
,
> > > > I'd like to keep it that way.
> > >
> > > The consensus of previous discussion on the lists was that folks
> > > agreed that we should, where possible, make it more obvious what thes=
e
> > > magic sequences of commands were doing. IMO separating out the page
> > > switch command helps. Certainly I'm always happy to hear other
> > > opinions, though.
> >
> > Fair enough, but in that case, one should take the datasheet (which
> > you can find online) and replace all the magic numbers with the
> > correct command names from it. E.g. 0xff is the ENEXTC register. To
> > be clear, I'm not just talking about the "switch page command".
> >
> > As patch stands, I don't see much value, TBH. On the contrary, you
> > make it harder to compare it with the Ortustech panel datasheet.
> >
> > just my 2c,
> > -michael
>
> If all drivers replace all the magic numbers with the correct command nam=
es,
> it will be a huge amount of work (assuming that the datasheet can be foun=
d).
>  I am afraid I don't have enough time to complete it.  Thanks.

Makes sense. I'd be interested in hearing the opinion of others in the
DRM community about whether they'd prefer to land something long this
patch as-is or drop it.

-Doug

