Return-Path: <linux-kernel+bounces-305609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D944963120
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9529128675A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0282B1ABEC8;
	Wed, 28 Aug 2024 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7pYvE5c"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C754C15575D;
	Wed, 28 Aug 2024 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874257; cv=none; b=MS7ec6fcGAEsCBWX2OnX+Ua1sAvrotdu22rad10twKdHOhDqSFQePlDwcwznlju0Y0w6wTP+RhN707d0DvqV9rDQz7PpG/MvAmZWFrvbJv+xkxE4jyoNhF3fGam6NUKmKIRJ/ambeybsWzfW1kcgq2P0cp/MlYKtal0tDnu3wNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874257; c=relaxed/simple;
	bh=cCE4qKAoYwqFPsDCxa9nxuRmwSrttn6gXj7lmU6EaVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBqUyb1t8/BWYrNK0PuLxwvnktqo9dZKKHdB6N0ZbxoFTsx2Y7Re4FSmti6BbfL/zgWRNi8PEWGgd42/ybEdprGAks9Khbe6IhsYoaKJiEQgkNj9nMqTMEznrR7sNFqaHqSCXQP4y0DotoguHdXnTJek4Dpych/TxZEclpAYq3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7pYvE5c; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d984ed52so448671785a.0;
        Wed, 28 Aug 2024 12:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724874255; x=1725479055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhkQmV0nwW9NmjeFbasAcMvP5f84y6KspV8NtnyqUzs=;
        b=D7pYvE5cu5UMfGXxhhKR7k6X9LoBINmoK2RSK5Zat59qpnHUlnbdZBB6Ul9TDYWomg
         ZJZR1pE2junNZLWjwBMjAD68u34qgfv8evw83enxZmPvsM0b7C8iBZafsgWCAC7E2tDY
         2ss9hWufGDD3qOQZZ2LVJbbzkzFQDqPu8i9xKZpzPa294OPBRz8OGhzEjU2/tL8cakW1
         wwGA1iK2Ro4TufNCHGwSS/eaJxDtPVoh+95cIwUJXNVBJH3E39ZliPDnaw/RpwrbKxV+
         ZM4yxeuE706JBjtzZXh+5PwZDn+lF+YZXU2igSdKmKPiyJdL44xHrQ/n9Vw42/VYjnvU
         YSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724874255; x=1725479055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhkQmV0nwW9NmjeFbasAcMvP5f84y6KspV8NtnyqUzs=;
        b=v2RM85N/lX+2iT90z4swHSkiurl7xvDVt89gGFakoAF2dp37kY0sISkKK1wasjcOS/
         TWLDyx8IROdW2KQYTg88Fj16NYqoUYeNX9JvQ1Om7FFsrJUHgsiIwU/JVDZgmjQjljjL
         k45fHJ0v9EV3zm+KYETurYqXRIPEtY+Sh454mPvq6Fa6ZSZHWQnKqWiK6tixtLfFhkb7
         69kF6G20mQL4d6ssK6ggBqaXMYI3+JpndnxIB2wIV+WKpPcpNpvraO14lURQ515BO8us
         maSNfeU0P6q0D3UvA2H6Hp3nNG2C8ZKPU3Ha3mKFENP0gZmhVTPooQ9VZKxQNYajy2y7
         5/7g==
X-Forwarded-Encrypted: i=1; AJvYcCUGfAUJ20ofyFzMQoF9EnCGyrPJbL4DF3WFZmqdZB48hU0sLsX/nOwMM6PD0LUM0zJ1cbiM3Id5yH10@vger.kernel.org, AJvYcCWpdRtN2euS1gTFVwT29mmUBNbHItBeCWuCiKRPL8wKBUELLupyRI+W8lta8IFXjya5H6nHDO8UWH7DCESt@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6Fy1FjV9lKo5I4+q5NAofgpdSIyavPUG4ytnhO03SzX7bAMn
	lilcg4zQoGKItLHNdgkddfwWylcGlVoK+wkN975GCDd1+JsWBt17gVHtBotuNct/+cW/Y4X4n96
	BtXwhVSY2sft4FNp13ZqzeKIbqQ4=
X-Google-Smtp-Source: AGHT+IHT0uRMRKU5Z9Wr54tOM9vZwzCmFpIVQ3gA8qAoECRK1Ybk86Zrdo+xr3pQg05MBjSWK5EpMUOxfeLDB6PnAso=
X-Received: by 2002:a05:6214:2f89:b0:6bf:7c44:f7b4 with SMTP id
 6a1803df08f44-6c33e62a7admr7619506d6.31.1724874254580; Wed, 28 Aug 2024
 12:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822170440.265055-1-robertcnelson@gmail.com>
 <20240822170440.265055-2-robertcnelson@gmail.com> <20240824184415.o7ehjqm523igqbbi@cornhusk>
 <CAOCHtYiap7JzwEXZ3aHDC+yhXEdoJuyb+q-sZAmbMENHCjtvUw@mail.gmail.com>
 <CAOCHtYg8DTuGncoxKPvTOyKvGrF-zNMwVvKcNWzRHxT5Hvt7nw@mail.gmail.com> <20240828165954.4d2uf65khni7rlr5@uncurled>
In-Reply-To: <20240828165954.4d2uf65khni7rlr5@uncurled>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Wed, 28 Aug 2024 14:43:47 -0500
Message-ID: <CAOCHtYhdoaxERuB89orO=mn3vdt=_h1zvay+1Tr3Z0FEnes95A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
To: Nishanth Menon <nm@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Jared McArthur <j-mcarthur@ti.com>, Jason Kridner <jkridner@beagleboard.org>, 
	Deepak Khatri <lorforlinux@beagleboard.org>, Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:59=E2=80=AFAM Nishanth Menon <nm@ti.com> wrote:
>
> On 11:34-20240828, Robert Nelson wrote:
> [...]
> >
> > /builds/RobertCNelson/arm64-multiplatform/KERNEL/arch/arm64/boot/dts/ti=
/k3-am67a-beagley-ai.dtb:
> > leds: led-0:linux,default-trigger: 'oneOf' conditional failed, one
> > must be fixed:
> > 'off' is not one of ['backlight', 'default-on', 'heartbeat',
> > 'disk-activity', 'disk-read', 'disk-write', 'timer', 'pattern',
> > 'audio-micmute', 'audio-mute', 'bluetooth-power', 'flash',
> > 'kbd-capslock', 'mtd', 'nand-disk', 'none', 'torch', 'usb-gadget',
> > 'usb-host', 'usbport']
> >
> > I guess, 'none' is close... off/etc..
> >
>
> I'd just suggest to drop the property since you already use heartbeat.
>
> Also function =3D is alternate option, if you choose to go down the road
> of enabling a function
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/dt-bindings/leds/common.h#n77
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/leds/common.yaml#n83

I can drop it, we basically have two leds on the board... Red and
Green.. Jason didn't like the Red being activity as it looks like
something is wrong, we just turn it off once into Linux..  Thus Green
became heartbeat..

From a user perspective (when they don't have a serial cable),
Blinking red =3D in u-boot board starting up... Blinking Green =3D in
Linux finishing bootup..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

