Return-Path: <linux-kernel+bounces-226319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D3913CFB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CFFFB20E36
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2DE18308F;
	Sun, 23 Jun 2024 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko/Xgd1+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2FC8F5B;
	Sun, 23 Jun 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719162489; cv=none; b=JY31W580aXTmW4y4i7JtJ42CjwNtp0uoavheVYz7qpw9HO3cz659wvxRO0zljP5/ayzOHanrLzVZl+5U3Xz7cdxDnBAAHECuFYZDmOzdXRBhlGzym8TVDi6KCTtDCgEvVGoISXe/BR5Ap/aYL5BbvX4sRfCeHxd95x3t/Yt2Yvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719162489; c=relaxed/simple;
	bh=O64q/2QrlOK51NlMxYf1EIbVDMzus2wZpPQLOTEYW9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qThynngrzXZNxM8uxC8OyxVOSCoOrt6XYZuw16yjJeKevOsLEBp33R7UWesVjxU/jzDXXtEZSum8Xpf/4lws035lQ48G8HjOL7aJ4+Ie/qkaT/CwCT7JrpPwaSJZsVfE8Kjx3gYAv56bDHAC75YVAdnIA67XLa/0kabqEknWf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko/Xgd1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584B0C4AF0D;
	Sun, 23 Jun 2024 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719162489;
	bh=O64q/2QrlOK51NlMxYf1EIbVDMzus2wZpPQLOTEYW9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ko/Xgd1+l2fiV5rq4r09a4Dkk9F6qo8JCMRAq0MUjdKJRPNa0OQzGbMb1mHz4h9F8
	 9ffKTf/Au6njmky/2JceHhV0vSPKQjO0+dMt36RgIYJqtNT9UZ8jyCqoFUQjaxe1Ut
	 +qDozt2EtOKXlwoESicyoJWJFrZ7Nt2DmKlnbyytXV7YRXA6tJCANsnRahMyPfUlFq
	 7SDZI1AVuiLGdcP4TpX4yB6EPP7G6CNMAfRmEDoHXXEvzWdfweqdJcLO645/CsRpx6
	 SwapBd4DoKEm9wphuAOBjb8Ga18XuvrjcK0o/1NdZbjKe0qazH/u4BCLzTBsPsr02H
	 IEIKOUwLb/A8Q==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6fe617966fso115193566b.1;
        Sun, 23 Jun 2024 10:08:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVx/+NW9hMeC+bZ7OgXURPIU8RQ6w2F3BuPAPHlmzBpVcrAUbI4B2s4UYV/xXFjtoyKrXGs5sYl9BgSskVuvCV7QegrxWCCrgFJKlfZI3yWUglyYSCXcdRW4U3KBWqyC5QGL+UF+416NQ==
X-Gm-Message-State: AOJu0YwN50VdGObYK3QBjSAmSOr0T8G4gFeRLDEpEfL3RRmKlrOZO0hU
	3bLmfHni2AODvuZaZIP+OTQpLb/7cO+C2oUdTI0zNcbfsYtN0+TXu+8L/i3Kr8I6+HFcdn4j36U
	feAMzataIqX7AIXd2HdisSC6Veyk=
X-Google-Smtp-Source: AGHT+IHqh5ECCo6rxNTnv13OnXMEvfR0HrFz5MxeNxK4Xo02Q+cUP1gdI3z8FF4DzmwkiDXEFxF1vKM9WwQcQqIkPjU=
X-Received: by 2002:a17:906:c014:b0:a6f:11c9:f349 with SMTP id
 a640c23a62f3a-a7245b6484cmr159368566b.23.1719162487792; Sun, 23 Jun 2024
 10:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
 <20240410-unwoven-march-299a9499f5f4@spud> <20240619-hammock-drum-04bfc16a8ef6@spud>
In-Reply-To: <20240619-hammock-drum-04bfc16a8ef6@spud>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 24 Jun 2024 01:07:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRYpDLij1aQoftz6ZqEgXDrfhNA39KiFVrwm7qc4WH6Fg@mail.gmail.com>
Message-ID: <CAJF2gTRYpDLij1aQoftz6ZqEgXDrfhNA39KiFVrwm7qc4WH6Fg@mail.gmail.com>
Subject: Re: (subset) [PATCH RESEND v8 0/6] riscv: add initial support for
 Canaan Kendryte K230
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Yangyu Chen <cyy@cyyself.name>, 
	Conor Dooley <conor.dooley@microchip.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 6:45=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Apr 10, 2024 at 11:30:25AM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > On Mon, 08 Apr 2024 00:26:58 +0800, Yangyu Chen wrote:
> > > K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add initi=
al
> > > support for it to allow more people to participate in building driver=
s
> > > to mainline for it.
> > >
> > > This kernel has been tested upon factory SDK [1] with
> > > k230_evb_only_linux_defconfig and patched mainline opensbi [2] to ski=
p
> > > locked pmp and successfully booted to busybox on initrd with this log=
 [3].
> > >
> > > [...]
> >
> > Applied to riscv-dt-for-next, thanks!
> >
> > [1/6] dt-bindings: riscv: Add T-HEAD C908 compatible
> >       https://git.kernel.org/conor/c/64cbc46bb854
> > [2/6] dt-bindings: add Canaan K230 boards compatible strings
> >       https://git.kernel.org/conor/c/b065da13ea9c
> > [3/6] dt-bindings: timer: Add Canaan K230 CLINT
> >       https://git.kernel.org/conor/c/b3ae796d0a4f
> > [4/6] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
> >       https://git.kernel.org/conor/c/db54fda11b13
> > [5/6] riscv: dts: add initial canmv-k230 and k230-evb dts
> >       https://git.kernel.org/conor/c/5db2c4dc413e
>
> After some discussion on the k1 thread
> (https://lore.kernel.org/all/ZnEOU7D00J8Jzy-1@xhacker/, https://lore.kern=
el.org/all/ZnA6pZLkI2StP8Hh@xhacker/)
> I am going to drop this series. It's not very useful in the current
> state and there's not really been any interest from people in getting
> the platform to a more complete state. Jisheng made some good points in
> the k1 thread about the missing clock controller stuff, and I think I'm
> going to make having basic things like clocks and where applicable
> resets and pinctrl the minimum requirement for the platforms I'm looking
> after.
Here is the k230 clock driver based on Linux-6.6:
https://github.com/ruyisdk/linux-xuantie-kernel/commit/196242fd9b9b4a191dab=
0c7c3c5bf851ed857d8d

pinctrl:
https://github.com/ruyisdk/linux-xuantie-kernel/commit/baf26b6622c9de2ff64a=
6ed58eeeb98c8b2c828b

No reset driver.

Most of the k230 drivers are under Linux-5.10, and we are porting them
into the newest version of Linux, which takes time.

So, if the clock & punctual drivers mentioned above could satisfy the
minimum requirements for the platforms, we will update the version of
this series as a supplement.

Is that okay?

>
> I've thrown these patches into my tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=3D=
k230-basic
>
> I do have one of these boards, but I'm fairly limited at the moment betwe=
en
> the various linux-related and work demands on my time, so it's pretty
> unlikely that I'll do anything with it myself.
>
> Thanks,
> Conor.



--=20
Best Regards
 Guo Ren

