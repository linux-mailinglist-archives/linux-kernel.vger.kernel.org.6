Return-Path: <linux-kernel+bounces-440248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3B59EBAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C1B18876CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A48C226890;
	Tue, 10 Dec 2024 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hELjNFc2"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A398633A;
	Tue, 10 Dec 2024 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861624; cv=none; b=Ml9ke2Yawt9aBnCszViyz+JAY+PJ/eYGNXGoUdGsaxmjclSVjLWLalpaRnVzLMnTp7PoiP/o49JoDPHPC46xQDOD8CQWoThYeO3SO9SsvU/Z8qSLZVDjtBlU4T96fVbQd6BOsHCgJBi7ysoFwyY6UB47kbNjSrTUUZRB4eta7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861624; c=relaxed/simple;
	bh=w7i7vP0J31Td2SDhg+SnejXzJiMC9Nu7DXLw2oI9P7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjncMRAAcbve/NFlzfAJJwsMSt8vku1yZy2pbgKaxvMUP5Jusp1xcMGKjaRTQyLoaaz27XkJ3CzM44hF9w8GNXeXq9r0nPvS78xN7Nvkr3cifwBb1XBxPJOcfyN7+T+uFv5yFkffv35eU+prhe7dT0Ie8oNRbxqhuzbE8rK4fGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hELjNFc2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso4325994a12.0;
        Tue, 10 Dec 2024 12:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733861621; x=1734466421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgKU23big2iA/4lgJjztR5Vr5E09reP3/HgJodbz0+Y=;
        b=hELjNFc2Ey3zog61zy/lAXZsbT0je6/MSniyUAhWxw4Fl6Qv0fEz9VhA7Cv7wTleOy
         tyD6l0rnd5oQKDrMDbgVooycU1s0hrw8//2oPOIwmKCmpb5byB5JM2Hk7Oo2udpMvsZd
         Q7jV2WrcPNmuY0B4611wmQM5pBOnI8S6AZmtq5Cei8XnePqeAeYKGtNP38kzO1lAHRzI
         0bc8yk/1qTKWPEecvvVPi4IcHsIrF5xOAy3anISPCDuvpwdP+ISYw1idWUvxU19a87Ou
         GN0TdPp2YgHYUGJp0EibjuSB/WG+62lEIEKra7l0v/PTHLbWx3VNEqNtFzjDdW2R3c3G
         XhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861621; x=1734466421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgKU23big2iA/4lgJjztR5Vr5E09reP3/HgJodbz0+Y=;
        b=Y6cqEOqnM0xQQbe7L2W15DV5fdfuTQ8tBXaAtk5/O8dN6tIgJ2wcnUvkiV6UzPoSJN
         SDl66xrz3Z612SlK/WOwYyauWWKwWBZj1F3wOZ2YFdQJ09XUl/DNnuXxF2wyr152igF6
         kZe32L4mKSLcO523LTM8g687Kxf8/D50/W32OdM1AZqlU2IgWI6bLPQ0If+wL5ra8WGD
         ylbtrb95+0zsihCdH/XMsQ7euCe6KkDbCAhFyDa+yix2yW1qw/hSTV7nIcYr5T3khicA
         UYY7KGexvPRVPBHy7Y4CUuKCRVVtfZ1qytfn5YDE7hjsY6PFdWT6rxBK5qjVI7V2k/yf
         NsZw==
X-Forwarded-Encrypted: i=1; AJvYcCVu9whdgPTbtNbQUiFwtzbEScsxAItq3ypngL8JpCKPKxNVKO59JfLJCw+yCFKF85+YZzTyH9+iosx5SY5F@vger.kernel.org, AJvYcCXTRghBjVawMYovbZH7gPJ7iGipDAxFyecQ9XebkRp0j3CVFEiP6S2qna6fq8nQjwDH+C9c5z/F5T+o@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NENckQaP/+Ycv1hRb5BRRwInT/9lhlfXimb9ct3BhFtvRc/L
	FXg8qJwNN2rkFct9xJxJLliDn/zO6KNnW8zP1CUhVvGnbg5u3iPS14cQUGHWP6KUbPJkrjYsddA
	d+WrLZCr4O/tXEwhfsleeHVeCCJk=
X-Gm-Gg: ASbGncuZfdY1SmmLqt8i4DzudFipAmLAA9p0TfOFD4GzrnL6P2duJC+GujNgcBks2uE
	WD4SAHWfnz2DWYs4YVQTO9sm1ZNqWrun1d2NF
X-Google-Smtp-Source: AGHT+IHT1KsOnBSj6/Zb1BhVvcEFV7dOkovEkS80li9AoqSjDy646pb5zs7A/JETWOAV235CrH6wQHRXekgMqdfvQeU=
X-Received: by 2002:a05:6402:4583:b0:5d2:2768:4f10 with SMTP id
 4fb4d7f45d1cf-5d4330ada8dmr127736a12.17.1733861621325; Tue, 10 Dec 2024
 12:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210013010.81257-1-pgwipeout@gmail.com> <20241210013010.81257-4-pgwipeout@gmail.com>
 <20693a7b7cb1aaed2c21b84fd57c4b72@manjaro.org>
In-Reply-To: <20693a7b7cb1aaed2c21b84fd57c4b72@manjaro.org>
From: Peter Geis <pgwipeout@gmail.com>
Date: Tue, 10 Dec 2024 15:13:29 -0500
Message-ID: <CAMdYzYr-4mA703ZWGZnCoRtmmkS689XHk854j73M4pgJceeJcQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: rockchip: remove ethernet alias from rk3328-roc
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, 
	Diederik de Haas <didi.debian@cknow.org>, Johan Jonker <jbx6244@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 3:01=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Peter,
>
> On 2024-12-10 02:30, Peter Geis wrote:
> > Remove the ethernet alias added back in during the rk3328-roc dtsi
> > conversion.
>
> I just checked again the dtsi parent conversion I performed in
> the commit f3c6526d6fb2 ("arm64: dts: rockchip: Convert dts files
> used as parents to dtsi files"), and both rk3328-roc-cc.dts and
> rk3328-roc-pc.dts had the ethernet0 alias defined before the
> conversion.  Thus, the alias wasn't added back by mistake during
> the conversion, it was there before.
>
> Moreover, I don't see why would we want to delete the ethernet0
> alias(es) in the first place?  It's usual for Rockchip board dts
> files to have ethernetX aliases defined, and both ROC-RK3328-CC
> and ROC-RK3328-PC have their gmac2io DT nodes enabled, and the
> boards have wired Ethernet ports, so they should also have the
> ethernet0 alias(es) defined.
>
> Am I missing something?

You aren't missing something, I just misunderstood what was happening
with your patch. I can safely drop this.

Thanks!
Peter

>
> > Fixes: f3c6526d6fb2 ("arm64: dts: rockchip: Convert dts files used as
> > parents to dtsi files")
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >
> >  arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> > index b5bd5e7d5748..f782c8220dd3 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
> > @@ -9,7 +9,6 @@
> >
> >  / {
> >       aliases {
> > -             ethernet0 =3D &gmac2io;
> >               mmc0 =3D &sdmmc;
> >               mmc1 =3D &emmc;
> >       };

