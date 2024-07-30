Return-Path: <linux-kernel+bounces-266582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F29401E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F351F23098
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3204A645;
	Tue, 30 Jul 2024 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAYtT6lV"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0814621
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722298169; cv=none; b=lAEmL0GljQp48HvH1pZs4zepSxuUQzgYwrRm2HPx2TRASehDpYA6RHx3T8kTX/iTM416AdQCzWSxCJpEWgpD2oHVm1ygsQIAjOBcJuBQvL/n7hy8EhCBKySzLq5sbYqFzpjo+sklO0r7aB5bkgou4hNjMvp464+nHEt1qwwtEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722298169; c=relaxed/simple;
	bh=jQHlhYyfKMqLz/fxHMgdgBNzfVdO2Dy8J62pcV+FrP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fa+7LOq8hn0c2MVx2kmhHOdZIsMKjBYvMOjai/JMJ1PypMQjWzePcOfL3sUBdf1ckDqRbj45YuH+SDrCwIbFQPLMXwEyD5NHp4KYCYZk9URweUlOoonNoS8fRfoCmepLK431egPd6kTcJNPMUu6Q7XnrlEhP0blUkbP0VHx+3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAYtT6lV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45029af1408so68841cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 17:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722298167; x=1722902967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAeVWUbVaZ+ha1i4e50lofh18l1IXtamxtQk9o0Ghu0=;
        b=cAYtT6lVSgxq0oUzAzsBmTQ7RYZubIVxaKbmw30Si9N6RCoCMZllRRM9rq87XkD2oL
         XKsvCXW2/LlQG36Sfe0TOdJXBm3oOWEX1rXA3SkTF+sWHmycJnc7ryKmBY80gZMoniCk
         FuH53XtdCqS1AY2XFNgKOJArhPfqoZBNaCbv0HYVjm6kvk7sUtlY96acE58P3xgYY1JL
         sOkT1p5EGPhBZMsgKCakCaP48qHJgt8pVfxcX89zDx6kkBsUzTjaj8277AhFP40ZXOAh
         wntsOAi9lpGLgByTmXLAoFJKl633gAz315maOrbAkFNbieUE0YLtV5XVxHq2EMTapq5r
         s0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722298167; x=1722902967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAeVWUbVaZ+ha1i4e50lofh18l1IXtamxtQk9o0Ghu0=;
        b=Pn7ood+xm8FFanhgrpvqUDJ0PhJi5ljJ+wvU3W9vZ5DFt/KV+uPeps674lP14VMSb0
         bJCSYpAtVF/UeKhEPCZqpxMuft5c1gRwrVBzKGcXmmZLMk6/b0diFbGdOXSwdpDO3YaF
         IoTuc7ZV1t2v3AxzkvZBg1uGrk/a7ZOeN06RO4+4AW6NnDoUoFO5n5QgPQ/yaftPox6T
         MUBI3a/63DddXC8SfG7odjt9PB3rPeEX2Q4iKTHJwUu+oI9e1X3eSYmWfV8ivb6jNBiG
         AdvdkGXkPfhIqI/L5jDlzReB48fjDgATlp9sAOXZ+tZsrRK0Mg9zVF9+3yI5zs3NuYDS
         ggbA==
X-Forwarded-Encrypted: i=1; AJvYcCX86ZPB6t7CFf/GaRTs1wegPnLde3dsyDGULXpNFECHnNGWe8/oPjq+Yia40F9756Z+XrmoryQSfNHo8HsHXlDV7wCd6w57dQ4pGTKV
X-Gm-Message-State: AOJu0YwA6LzUaxzUTu/mpNNhvHkw3aSm+iPiwu97UqAjS/xc7tdwdVyl
	S10xmX680NFN6S8XFGyMkEMWui3kmFq/Tp9Eso65NBooTE4c0W0p9PHKv5NJk8humHe7fj+iQos
	gW7WevoVmDBsxnVspnwllh7Aj3I07ypFj8ZYn
X-Google-Smtp-Source: AGHT+IES9fp2l+AgH6qskNO9+SVYLz8jgaCgdqJ00W3QwiMKEf0HzznBbEBZn3bnq1PYoAnWI0ViFVxWLxPbzm3FzeU=
X-Received: by 2002:ac8:5f51:0:b0:43f:ff89:dfb9 with SMTP id
 d75a77b69052e-450362bfc06mr764261cf.6.1722298166518; Mon, 29 Jul 2024
 17:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624-fwdevlink-probed-no-err-v1-1-d1213cd354e2@collabora.com>
 <CAGETcx-sAu-wMDKT9zCeCzLzZ=ZdvK+CSoX34YxMLd5z0YeVZQ@mail.gmail.com>
 <7b995947-4540-4b17-872e-e107adca4598@notapiano> <575b02aa-6496-492b-b37d-d0612165eda3@notapiano>
In-Reply-To: <575b02aa-6496-492b-b37d-d0612165eda3@notapiano>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 29 Jul 2024 17:08:48 -0700
Message-ID: <CAGETcx9e4mpcMY+pqMYXsVWGcjgkctCqgO665KgqUH4JvYbUAQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Don't log intentional skip of device link
 creation as error
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, kernel@collabora.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:25=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Tue, Jun 25, 2024 at 09:56:07AM -0400, N=C3=ADcolas F. R. A. Prado wro=
te:
> > On Mon, Jun 24, 2024 at 04:53:30PM -0700, Saravana Kannan wrote:
> > > On Mon, Jun 24, 2024 at 8:21=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
> > > <nfraprado@collabora.com> wrote:
> > > >
> > > > Commit ac66c5bbb437 ("driver core: Allow only unprobed consumers fo=
r
> > > > SYNC_STATE_ONLY device links") introduced an early return in
> > > > device_link_add() to prevent useless links from being created. Howe=
ver
> > > > the calling function fw_devlink_create_devlink() unconditionally pr=
ints
> > > > an error if device_link_add() didn't create a link, even in this ca=
se
> > > > where it is intentionally skipping the link creation.
> > > >
> > > > Add a check to detect if the link wasn't created intentionally and =
in
> > > > that case don't log an error.
> > >
> > > Your point is somewhat valid, and I might Ack this. But this really
> > > shouldn't be happening a lot. Can you give more context on how you ar=
e
> > > hitting this?
> >
> > Of course. I'm seeing this on the mt8195-cherry-tomato-r2 platform.
> >
> > The following error is printed during boot:
> >
> >   mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180)=
 with backlight-lcd0
> >
> > It doesn't happen with the upstream defconfig, but with the following c=
onfig
> > change it does:
> >
> >   -CONFIG_PWM_MTK_DISP=3Dm
> >   +CONFIG_PWM_MTK_DISP=3Dy
> >
> > That probably changes the order in which the MTK DP and the backlight d=
rivers
> > probe, resulting in the error.
> >
> > One peculiarity that comes to mind is that the DP driver calls
> > devm_of_dp_aux_populate_bus() to run a callback once the panel has fini=
shed
> > probing. I'm not sure if this could have something to do with the error=
.
> >
> > Full log at https://lava.collabora.dev/scheduler/job/14573149
>
> Hi Saravana,
>
> With the given context for where this issue is happening, what do you thi=
nk
> about this patch?

Ah sorry, missed your earlier email.

Couple of points:
1. It looks like the link in question is "SYNC_STATE_ONLY" because
it's part of a cycle. Correct me if I'm wrong. You might want to use
the new "post-init-providers" property to help fw_devlink break the
cycle and enforce the right dependency between the edp-tx and your
backlight. And then this error should go away and your device ordering
is enforced a bit better.

2. If we take this patch, it might be better to make a "useless device
links" helper function and use the same on in device_link_add() and in
the "if" condition that's used to decide if a device link should be
created. The con =3D=3D sup is another "useless device link" check. But
I'm not really sure if we should mask this error as it help with stuff
like (1). con =3D=3D sup is a bit more clear cut example of a "useless
device link" in the context of fw_devlink.

-Saravana

