Return-Path: <linux-kernel+bounces-426329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8983A9DF1CA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E83A2816D7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B5B1A01CD;
	Sat, 30 Nov 2024 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yaFPs75B"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443A42AA4
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732981054; cv=none; b=ow7pBe6wkqCbtLK+xWB6nN43VLSFvCJQbn6UTvjW9TqYow8iucP6bYtHtTxWy1ifjWD58nSVr7npHdSfYIP2x6qsyPznDaaptqbvU91qfFhfc+8lGQ4FwSjQ/HE6MQEYqMgVKc3+XPWiKDz2VH+nTq6OwJU0xj6SRNXsm4gppzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732981054; c=relaxed/simple;
	bh=IfHj8arS58dxUpHrxfI2d7SUYf3amaDgz9NoPNRS6zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5GUKq6KyniaukqfzOn6nAFBJ47WKxB8G/lZycIrJbpU+FuAxBUfkfvVTcOCgMnxiPia2RooLlSzLaTxpV/Ooc7MQZZDrbd9MGAZ9eg+vr7g7/wb5NM04bac+GG3MI1cWglYNL/4NUwtbvnW7nFANpvKdih32yNrY+Oz6Fn16Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yaFPs75B; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffd711274dso33151981fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 07:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732981050; x=1733585850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/j5RX3MP964cNRKKWQKaoJ36XFkjCCUdFUttOGIg2Z8=;
        b=yaFPs75BQngagAgW3YABCScbhjbPpF+oSM8QFKuM6YhpICdnMKZ/AvhzeDY+9d0gjE
         +NF1uFvOwZo8aw+7OxHj+nIhdEwv3ZvuvFiE+1ewoFC7BXRbZtxngoq/jdqJgwIUmUjT
         L1tFyd1ApqVMkd6C2xdcdAPGlXmlFVwPekc1S98+LQuOV4oc7968+IXuNQSfkLh0hnsa
         jrTDbkYJrhC2nLjp2FP26V5+Fsm/U7FsXjAH75MhWsJ97tl6jIwdDUBdkz69YEipVzng
         7SLV5RspY8Fr+2ablPRCPMRO7YUN8R4bUUTHD3JwCdOiSz5QHpI0gKezc+v/zqdZFjQ0
         7KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732981050; x=1733585850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/j5RX3MP964cNRKKWQKaoJ36XFkjCCUdFUttOGIg2Z8=;
        b=vWaW76WhlUxxchIZ367G6nhnybbRS2zjY3EedbJwLDHbikAih9S0UE0eAU6uy9+FHb
         cQ7NMWHq+Vi6vfKit7nqPPN0X/oHoMWWky5zGTxFrhZ6K4zy2nTrPP2eEIHOoPtqwLOT
         GL41/MZNyREAbhTbhTNYITeUbX3Dla+WwER3gC/FTiGDX2qUDoLU8Pe7Tsn4ZMuaHwzV
         OmQRn3k7iCq7fUF/Bnd/LIwXjuRK3cxAVzfGD28Jvx0tYCi+dj/3xi0QoHaq5m7iUIy5
         31U3buNcvu07ZrDb3/dzviw35CxJw8YeohMDM78Mp8RjkrPD3rSVfIkc4Q1FAgBb99vR
         7kKQ==
X-Gm-Message-State: AOJu0YwJULUTEWGEzvc1y/db0KPmd7DlD2HisvZ1H0Vr3qs4jbONcb1I
	bNQFHk1WRIwBX+WwrodZiAdrFzX1LuaVDFbhh8Hm8mGVnnDEAyidpw0p5O/30zFgfrxclBpenbx
	T+c2jaVrszSNOkIDt2lMNY2hce9vcBVK73nJwvQ31VB59OFGw
X-Gm-Gg: ASbGncuK90ctLOuCqiWFLU+RdYDuNYU+VGjF+GKdmIqADt3zdB+2eeqjMWXBsTQSe0t
	eDcq6ftLjdIrH6MqwTdfOTpDAZpQz+2xJWyKRqA7SQHudwPjIuXE8/CB9plijiT4=
X-Google-Smtp-Source: AGHT+IE1M+NzYQCMccnmg8fuPm2rVuofQwMi/nH5uhuyr6yUH9TSyqqTfUQBhZ0X/ylREXAh/c0xgYasYanKK7hbic8=
X-Received: by 2002:a05:6512:2806:b0:53d:f7f5:bede with SMTP id
 2adb3069b0e04-53df7f5bef1mr3844873e87.25.1732981049810; Sat, 30 Nov 2024
 07:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014122551.116491-1-brgl@bgdev.pl> <CAMRc=MfscDCr8mdxSiC8zWUgdzdqLCo3=PKhuWhWueGoq_c82w@mail.gmail.com>
 <CAMRc=MehYdep3YvfDjZPmut4d2uKq+Cb5tQecJCQMjAEJxSdTw@mail.gmail.com> <2c69d0e0-c090-76be-3bd2-e5e92c585ffb@axentia.se>
In-Reply-To: <2c69d0e0-c090-76be-3bd2-e5e92c585ffb@axentia.se>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 30 Nov 2024 16:37:18 +0100
Message-ID: <CAMRc=Meo9rL62hNLJE6RuXe3S2N7vRJ1bWxeG2LbgqrJRmW7HQ@mail.gmail.com>
Subject: Re: [PATCH] mux: constify mux class
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 10:53=E2=80=AFPM Peter Rosin <peda@axentia.se> wrote=
:
>
> Hi Bartosz,
>
> 2024-11-01 at 15:21, Bartosz Golaszewski wrote:
> > On Thu, Oct 24, 2024 at 9:08=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> >>
> >> On Mon, Oct 14, 2024 at 2:25=E2=80=AFPM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> >>>
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> All class functions used here take a const pointer to the class
> >>> structure so we can make the struct itself constant.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>> ---
> >>>  drivers/mux/core.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> >>> index 78c0022697ec..02be4ba37257 100644
> >>> --- a/drivers/mux/core.c
> >>> +++ b/drivers/mux/core.c
> >>> @@ -42,7 +42,7 @@ struct mux_state {
> >>>         unsigned int state;
> >>>  };
> >>>
> >>> -static struct class mux_class =3D {
> >>> +static const struct class mux_class =3D {
> >>>         .name =3D "mux",
> >>>  };
> >>>
> >>> --
> >>> 2.43.0
> >>>
> >>
> >> Gentle ping.
> >>
> >> Bart
> >
> > Peter,
> >
> > Your email doesn't bounce so I assume you are getting this. Any reason
> > why this simple change is not being picked up?
>
> I'm here, and am just being slow as usual. Sorry about that. I have now
> added the patch to linux-next.
>
> Cheers,
> Peter

Peter,

This commit is in next but it's not gone upstream and it's almost the
end of the merge window. I don't see any pending PR from you. Can this
go upstream?

Bartosz

