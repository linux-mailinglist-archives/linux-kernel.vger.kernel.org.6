Return-Path: <linux-kernel+bounces-177657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B76C8C4288
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB0E1F213C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4481715357A;
	Mon, 13 May 2024 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="aWKGTxcY"
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AF145B10
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608299; cv=none; b=MhVMOQ8VU8fH5EjFX2Tekh/JcSsXtVgozF5dtpzwqiUDBjwgVQ2cggG7Ncd+HMNuYeBE6QrjrxL6uy6sE2dSGz/Yx/SKT+mrEujoF1R4uMkVWIbL59ObAdOJgYBaGPSRL+DlsvkSp+Yysfy+UrakKmB3Eyg58Kq2bNEiatY+Po8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608299; c=relaxed/simple;
	bh=rCp4a/BDWi17CHMvgY5xOFl3QoPKRxwfeBuT/Fb98Nk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SprnRPAO9+Fm+aKEP7WgasR3A5DsgVIdoMhvwHa0GW3kZp2RYjt2qzQaYviSNNdfzhNo0+IHyVt0Tb2C+ZbIJi3QXqIyT5bGyzZp1Mv+waL5v/53SmL0pFD4U4TbiCoTwIP+xbMLWD8j2OLePZzp37Zu5gQZIhY2MlJFxJy1bBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr; spf=pass smtp.mailfrom=emersion.fr; dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b=aWKGTxcY; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail3; t=1715608289; x=1715867489;
	bh=rCp4a/BDWi17CHMvgY5xOFl3QoPKRxwfeBuT/Fb98Nk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aWKGTxcY4wKQzfazyx23U28lrFiumZcz/zIWjprWPjlb+90HEZ3QinH0QcLZhB0w1
	 AU+tYlAaAjNrUCRfki7nrcCXtQjCFzjBSva5vjijed5vbJr6GWsUQlPalvQJ5y97Rt
	 hOddSllCePkYcy/13GUkJzkFK4K4f5X4V/AkRM+Oj/Fb5m4h9mGAeYfzGiElsKBUSS
	 Ne2uofSfC78mYkVdNUrDxiZpK5IMOdrgD2qV6pT7wO7I5IoSJ2IVqiRfPQvcPeF5bg
	 w4B9PkQd4Pt96uvhvTkfJt2RJUYEAKdGj4GKMpLuYSzLfAzHL6UWqPQV0ypt4Ie8yZ
	 LS37it/d2kEgw==
Date: Mon, 13 May 2024 13:51:23 +0000
To: Daniel Vetter <daniel@ffwll.ch>
From: Simon Ser <contact@emersion.fr>
Cc: Daniel Stone <daniel@fooishbar.org>, Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <mripard@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Lennart Poettering <mzxreary@0pointer.de>, Robert Mader <robert.mader@collabora.com>, Sebastien Bacher <sebastien.bacher@canonical.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Milan Zamazal <mzamazal@redhat.com>, Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users (udev uaccess tag) ?
Message-ID: <IXDM2ci-eGvU9RQkT6a52vcV66vr8d0ywbDRFY8gBjjNuMyv8RDgdJS0PvvfnKuPR1fXINPUjOBkKx4vIcshSb2Y11xd3DjfDQ-Np8VIFgQ=@emersion.fr>
In-Reply-To: <Zjue98r4ZgGbMN5K@phenom.ffwll.local>
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com> <20240506-dazzling-nippy-rhino-eabccd@houat> <ZjjdUBYYKXJ1EPr5@phenom.ffwll.local> <cbe5a743-d8be-4b0e-99c4-e804fbadc099@redhat.com> <ZjoNTw-TkPnnWLTG@phenom.ffwll.local> <CAPj87rN3uSZoHpWLSQqz1SW9YMZNj9fkoA_EDEE_bzv-Tw8tSw@mail.gmail.com> <Zjs42PGvilLlF0Cg@phenom.ffwll.local> <CAPj87rN-wSbGSAoB8y3MXCS20_MAQvfpWSeUKYR6XzQ+Oh0FZA@mail.gmail.com> <Zjue98r4ZgGbMN5K@phenom.ffwll.local>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: d2a6e70754ffedf294a79e2c65504e513c8e9b24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, May 8th, 2024 at 17:49, Daniel Vetter <daniel@ffwll.ch> wrote=
:

> On Wed, May 08, 2024 at 09:38:33AM +0100, Daniel Stone wrote:
>=20
> > On Wed, 8 May 2024 at 09:33, Daniel Vetter daniel@ffwll.ch wrote:
> >=20
> > > On Wed, May 08, 2024 at 06:46:53AM +0100, Daniel Stone wrote:
> > >=20
> > > > That would have the unfortunate side effect of making sandboxed app=
s
> > > > less efficient on some platforms, since they wouldn't be able to do
> > > > direct scanout anymore ...
> > >=20
> > > I was assuming that everyone goes through pipewire, and ideally that =
is
> > > the only one that can even get at these special chardev.
> > >=20
> > > If pipewire is only for sandboxed apps then yeah this aint great :-/
> >=20
> > No, PipeWire is fine, I mean graphical apps.
> >=20
> > Right now, if your platform requires CMA for display, then the app
> > needs access to the GPU render node and the display node too, in order
> > to allocate buffers which the compositor can scan out directly. If it
> > only has access to the render nodes and not the display node, it won't
> > be able to allocate correctly, so its content will need a composition
> > pass, i.e. performance penalty for sandboxing. But if it can allocate
> > correctly, then hey, it can exhaust CMA just like heaps can.
> >=20
> > Personally I think we'd be better off just allowing access and
> > figuring out cgroups later. It's not like the OOM story is great
> > generally, and hey, you can get there with just render nodes ...
>=20
> Imo the right fix is to ask the compositor to allocate the buffers in thi=
s
> case, and then maybe have some kind of revoke/purge behaviour on these
> buffers. Compositor has an actual idea of who's a candidate for direct
> scanout after all, not the app. Or well at least force migrate the memory
> from cma to shmem.
>=20
> If you only whack cgroups on this issue you're still stuck in the world
> where either all apps together can ddos the display or no one can
> realistically direct scanout.
>=20
> So yeah on the display side the problem isn't solved either, but we knew
> that already.

What makes scanout memory so special?

The way I see it, any kind of memory will always be a limited resource:
regular programs can exhaust system memory, as well as GPU VRAM, as well
as scanout memory. I think we need to have ways to limit/control/arbiter
the allocations regardless, and I don't think scanout memory should be a
special case here.

