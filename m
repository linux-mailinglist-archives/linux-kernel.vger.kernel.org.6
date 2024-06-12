Return-Path: <linux-kernel+bounces-211381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA7F9050E2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B811C2117F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904916F0CB;
	Wed, 12 Jun 2024 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKGz5irt"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A416E888;
	Wed, 12 Jun 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189453; cv=none; b=MC+tNTiVydj6Lf6fQGaoB0ESAmpZ2B/TSh3ybndR2V1b1AkidMT8xmfivk0+8ySFo/prv3PSqWPjCwXKEDjAldzm+pmc11mqBrxOxYsXOxQYNrKp56FnQ5Ddn85TeHBiMuU+e+58vA6JabKWruUTdybUPj7Okdv0pypRbKu6p98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189453; c=relaxed/simple;
	bh=gPrkmLuEip24rQDMBNxfQcWKheL4If4TqkyUbqMGUBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqA/pGnMHHUsojoTD7vzsfLXHNbPG1c8BFYIGrALxX0ZQe92sT4tVFao98Xbc6ibnor9cibYX0jPgUN2itplyzfZnzNN797pccceR4m9i59lN5ScWiOvuvvGtJJ2zf+g35j5Oa/WIq6fKileZuIFUVgb5424xtRV9JXbkDFpyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKGz5irt; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-48c3957a7c5so1639611137.0;
        Wed, 12 Jun 2024 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718189451; x=1718794251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnNdcpUztmxxIzRAemfxZWkh6cGiDZLepHKzz20EjH0=;
        b=BKGz5irtO0jpnOr6dgSSw65dt7GQd+zNVicoqzOKhbYZzrAV3LzY4XeNW+pTvdXpoJ
         Y7+EvnYhzFVl5wFsPlzxcOlvhKAxGvPyUQOAqwjZScvf0lN+pVYuBf94LTKl7+GP8V5C
         F1H9ojQiIvAeUSwI0u+tAvEfInEdS9Anyd7icyKNmxa/YcZ5UDOqOTktO/X39gFN5c09
         Zg31DjZur+/7ZSS3DgfjCJ2+6P2aUP6uOkgeycqtvt5pJNA1n2iHbajTfqQcnYjkeQ6+
         TLi7Saxt0qnixi2o4l86L0K0DVMQFskqtl21PH9OTk9S/g6MmYgwiEYK1x1UUkvtMkDA
         CQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718189451; x=1718794251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnNdcpUztmxxIzRAemfxZWkh6cGiDZLepHKzz20EjH0=;
        b=sw313xF+CZbG2NzNyj/4IgdDtoLJ/YLoUn8H7uNVyjDLo+H0prnoUyd99ww2ouZwGO
         /2oQLlkUzC1WJ1NfjJ2yU98c1pSFh/rtSnltBLfhiJamx8F+CAfliE+dpbs7tGea0LwQ
         c/+HkPTLHirmXomvIBsfLUfd5eszx6hyG3o+B3zikWhGLp+vFvz6uqU87LWdg1AAtP2X
         8DBHPEvf33sMpe+qdSWQ3LxPr8osdLeX8XsLOf7xZxdLoTLBRuXmDwLlpO80Yc2og+U+
         SqkhSdKpL88x1SJldh1nL/BH0E2iiF/63w2oyf5N6WHpCb5srdESDII5kaphwKNfLGcL
         HLmA==
X-Forwarded-Encrypted: i=1; AJvYcCUAff3hM1cfNxPgppylExlTml/QYWz92m0D35i3eWrjWY+26vdTlAN4CmQl59fvWuLKLbkenXlBulATCyYJGYaJDDnFq6zezezUGqCIWMH2/bAmF6Emceu87z8b2EscpGlDkUjU2df8YA==
X-Gm-Message-State: AOJu0Yz3PpzGBVZpFtSL64cv9KhxAH6P3BPhjErYHOexmC8dTGOUfB3A
	Zh6L+McKcTD+MaTArT/fcEBGL3EmGyFNsxgX/WTKMx6jol1gWRlg3PlE8JtXqjG0+jS2OyVUOBc
	0+mpKXTT5geeA6EWh02FrvZjM28vHvom4Cys=
X-Google-Smtp-Source: AGHT+IG9mILrRCPtGIeqY6s6hVhQfpuh7Ua8TIQsbfdFRmq5VFdX20DYGz4fiJ6e4HTepneR9rq/sHGhuMsdCUKsDTM=
X-Received: by 2002:a67:fa57:0:b0:48c:3d43:a157 with SMTP id
 ada2fe7eead31-48d91e4111amr1360703137.27.1718189450838; Wed, 12 Jun 2024
 03:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423150728.91527-1-sheharyaar48@gmail.com>
 <f60aac7f-dbba-4cba-8bb6-302b5c911b8c@linaro.org> <CAHTLo_=Gg-KN2zOtjOBCxQURq+Ap913Miph2FMhvkoV+GybFNA@mail.gmail.com>
 <106b6911-3097-487e-85db-f8de5958adcb@linaro.org>
In-Reply-To: <106b6911-3097-487e-85db-f8de5958adcb@linaro.org>
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Date: Wed, 12 Jun 2024 16:20:39 +0530
Message-ID: <CAHTLo_kf5+3hW1NytA7tD64MSFOUEfkb71cNARkHb95Qhm=W2Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vt8500: replace "uhci" nodename with generic
 name "usb"
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 1:44=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/05/2024 06:53, Mohammad Shehar Yaar Tausif wrote:
> > On Tue, Apr 23, 2024 at 8:46=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 23/04/2024 17:07, Mohammad Shehar Yaar Tausif wrote:
> >>> Replace "uhci" nodenames with "usb" as it's generic and aligns with
> >>> the schema binding.
> >>>
> >>> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
> >>> ---
> >>>  arch/arm/boot/dts/vt8500/vt8500.dtsi | 2 +-
> >>>  arch/arm/boot/dts/vt8500/wm8505.dtsi | 2 +-
> >>>  arch/arm/boot/dts/vt8500/wm8650.dtsi | 2 +-
> >>>  arch/arm/boot/dts/vt8500/wm8750.dtsi | 4 ++--
> >>>  arch/arm/boot/dts/vt8500/wm8850.dtsi | 4 ++--
> >>>  5 files changed, 7 insertions(+), 7 deletions(-)
> >>
> >>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >
> > Hi,
> >
> > Is there any further feedback or update for this ? This patch is not
> > yet merged but the related dt-binding patch that has been merged :
> > https://lore.kernel.org/all/20240423150550.91055-1-sheharyaar48@gmail.c=
om/.
> > I understand that this is a trivial patch and the maintainers may be
> > busy with important work.
>
> I don't see you Cc any maintainers, so no one will pick it up.

Sorry for the mistake, I used b4 and it gave me this list of
maintainers for the patch, the other recipients were commit_signers.
Please guide me for my next steps. Should I add them to the list too ?

Regards,
Shehar

> Best regards,
> Krzysztof
>

