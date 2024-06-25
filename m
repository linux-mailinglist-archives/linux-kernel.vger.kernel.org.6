Return-Path: <linux-kernel+bounces-228270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC90F915D82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75448282847
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6A7135A69;
	Tue, 25 Jun 2024 03:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtN0VewR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4538F9A;
	Tue, 25 Jun 2024 03:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719287747; cv=none; b=FQfN3ZwAmYRHmN113f16gcnNU5rZRbE2TxWx/kcKjRhFC1bLa/QrfUWkcSFvGoxdt5T9F/69HARoCZVwrwqjPxDmiesHFM3M6n6S4Zp1RZvxtbjEhDLYp8Lk8TeAsCTNEhoxlzEzbrJ5UdCZ/P7JBdtBiw0YeQYlRZzoo6FxXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719287747; c=relaxed/simple;
	bh=cQaTKnbbQKLHRvFAP0Ke1Gk/g4E7YkyDRfUGaWmHRtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oijSYpHdvkeMT79VsTCC43Ke45rdKrONP5RZ6ERA3Lrudbg0mDTKIAwAzbJx9MhXE0iz81TVG/TdsshN/KgJ7BZzg3eE6qvNMabv8uq+Z6KmR3InzGtb9+sUpNz/6gQiyL8UdiRCOPj6a6G1WUrLD1cbS/I8uIA704DRpzlrqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtN0VewR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2F8C4AF0A;
	Tue, 25 Jun 2024 03:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719287747;
	bh=cQaTKnbbQKLHRvFAP0Ke1Gk/g4E7YkyDRfUGaWmHRtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CtN0VewRu6rSd7ETBhqeZb9oIsW9ianhZG2gpxnYGznwuXP6NtkFzCg5rxnrb2g/B
	 pJrKZLJD/VQ0nTodyJ9MpaCAh0W4ks3FJH8NXNvWMcTaN9btIhwfGA1UUR3cPYZcMp
	 g3c2CcGNzpHMqNc7Vgdu83ca8t4kcXR6xn1Va9kde3fhATTwrJcAAWrrSGJmWayEdk
	 NBw58IY6QicXI3wst7P/9PdWdNa7Za8w9sq1yXGWxgxTSwTYdZn3rERWGDB2XYrcRq
	 HiOmCArbD1ig07LK8oX6/wOd7p9wvNX+NtNQslosF0Odp95WOaJOwAlK4NxjqoYDrn
	 dC4OyGwAjuLnA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7241b2fe79so277218866b.1;
        Mon, 24 Jun 2024 20:55:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVELi1U2ZzYHaIaeu40DE0bOdnicn5jxmVjPjF8FaEnopWIa/HHwn+ETBZmOjT3qaxnjlFU/9rf+LnEaZRE6eJVtX5wgburaGMQVia+YDFvdtDAiUbFBeN2oZx6Wu279ssadk0J3pBwjA==
X-Gm-Message-State: AOJu0Yy/J3vP4oC/mYrcY4wF1xXHQS5w4HUsHVoyfw2j/VuHklsWOWq2
	IM0rMWZMMGeNaS7QSDrQtruptawdMaNwUiZVH58uZetvD8JTvxT1gLybaRAPnrplqoAlKi6Bu3T
	ApFmlsPuqy41t4rSC6PgVBpzURio=
X-Google-Smtp-Source: AGHT+IFpMrmDvhxYYpFAqoCj+v/ziYjdVaIIAkZShbx9udkdSPZQ9vpFAE6n7C6kUJa0fixtVlDWWvqsRB4url4vpsw=
X-Received: by 2002:a17:906:bcf3:b0:a6e:fb9b:6769 with SMTP id
 a640c23a62f3a-a7242d2ac25mr496698666b.75.1719287745662; Mon, 24 Jun 2024
 20:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
 <20240410-unwoven-march-299a9499f5f4@spud> <20240619-hammock-drum-04bfc16a8ef6@spud>
 <CAJF2gTRYpDLij1aQoftz6ZqEgXDrfhNA39KiFVrwm7qc4WH6Fg@mail.gmail.com> <20240623-graveyard-consonant-97eff0f11808@spud>
In-Reply-To: <20240623-graveyard-consonant-97eff0f11808@spud>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 25 Jun 2024 11:55:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS_KkQjyQPubc2+naYiammLjN8jJyptGtCe8Z56MAmT2A@mail.gmail.com>
Message-ID: <CAJF2gTS_KkQjyQPubc2+naYiammLjN8jJyptGtCe8Z56MAmT2A@mail.gmail.com>
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

On Mon, Jun 24, 2024 at 1:32=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Jun 24, 2024 at 01:07:55AM +0800, Guo Ren wrote:
> > On Wed, Jun 19, 2024 at 6:45=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Wed, Apr 10, 2024 at 11:30:25AM +0100, Conor Dooley wrote:
> > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > >
> > > > On Mon, 08 Apr 2024 00:26:58 +0800, Yangyu Chen wrote:
> > > > > K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add i=
nitial
> > > > > support for it to allow more people to participate in building dr=
ivers
> > > > > to mainline for it.
> > > > >
> > > > > This kernel has been tested upon factory SDK [1] with
> > > > > k230_evb_only_linux_defconfig and patched mainline opensbi [2] to=
 skip
> > > > > locked pmp and successfully booted to busybox on initrd with this=
 log [3].
> > > > >
> > > > > [...]
> > > >
> > > > Applied to riscv-dt-for-next, thanks!
> > > >
> > > > [1/6] dt-bindings: riscv: Add T-HEAD C908 compatible
> > > >       https://git.kernel.org/conor/c/64cbc46bb854
> > > > [2/6] dt-bindings: add Canaan K230 boards compatible strings
> > > >       https://git.kernel.org/conor/c/b065da13ea9c
> > > > [3/6] dt-bindings: timer: Add Canaan K230 CLINT
> > > >       https://git.kernel.org/conor/c/b3ae796d0a4f
> > > > [4/6] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
> > > >       https://git.kernel.org/conor/c/db54fda11b13
> > > > [5/6] riscv: dts: add initial canmv-k230 and k230-evb dts
> > > >       https://git.kernel.org/conor/c/5db2c4dc413e
> > >
> > > After some discussion on the k1 thread
> > > (https://lore.kernel.org/all/ZnEOU7D00J8Jzy-1@xhacker/, https://lore.=
kernel.org/all/ZnA6pZLkI2StP8Hh@xhacker/)
> > > I am going to drop this series. It's not very useful in the current
> > > state and there's not really been any interest from people in getting
> > > the platform to a more complete state. Jisheng made some good points =
in
> > > the k1 thread about the missing clock controller stuff, and I think I=
'm
> > > going to make having basic things like clocks and where applicable
> > > resets and pinctrl the minimum requirement for the platforms I'm look=
ing
> > > after.
> > Here is the k230 clock driver based on Linux-6.6:
> > https://github.com/ruyisdk/linux-xuantie-kernel/commit/196242fd9b9b4a19=
1dab0c7c3c5bf851ed857d8d
> >
> > pinctrl:
> > https://github.com/ruyisdk/linux-xuantie-kernel/commit/baf26b6622c9de2f=
f64a6ed58eeeb98c8b2c828b
> >
> > No reset driver.
> >
> > Most of the k230 drivers are under Linux-5.10, and we are porting them
> > into the newest version of Linux, which takes time.
> >
> > So, if the clock & punctual drivers mentioned above could satisfy the
> > minimum requirements for the platforms, we will update the version of
> > this series as a supplement.
> >
> > Is that okay?
>
> I don't understand how that changes anything, these are all out of tree
> drivers based on an old kernel. I know that there are drivers for a lot
> of the peripherals that are in-use in the vendor tree etc. What I am
> looking to happen, before I apply patches for the k230, is that the clock
> dt-bindings will have landed in linux-next - and ideally the pinctrl ones
> too.
Okay, clock & pinctrl, the reply is clear to me. Thx.

>
> Thanks,
> Conor.



--=20
Best Regards
 Guo Ren

