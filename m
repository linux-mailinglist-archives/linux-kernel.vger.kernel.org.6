Return-Path: <linux-kernel+bounces-311002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583159683C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0896B1F210F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835A776035;
	Mon,  2 Sep 2024 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLn80fpT"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B821D31BD
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270881; cv=none; b=jXU3ZA0wrFGrzRkCBrBFbMwPRQRnCU0iSMHleKuNmgofH3bTKGq5g5nkp/POq3hrdYaPKbd7vGnRa/9lnlsT5i+ZhwV9Jjwb7ZK1XMoSC0rizYGQ5FnnjEWglG+6DBiGEL5YifaSjLtXvzCL1ACl9FG3K+w4ObmkOsZpACj0RZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270881; c=relaxed/simple;
	bh=lr0ZgOefoKyV/C+lLt6hv10oU2KyflB3T+80PqFO700=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqjkXRpcQ1VqLM0ce/ZWlhnUl3U8DeAdMjVMXhPuvOUuwUlcDk/zNk8q98TTEyxz6EfPztKg1NfUwMZ1lygx0MhQwWs+sVk0SlH7s5RNjehGY7EAdI1j1G3VHAatIf71E2ntj/eNY7L3mJg0wqSCqjWrKmEFDArvqq++ZCqC4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BLn80fpT; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-27045e54272so1857925fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725270879; x=1725875679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j39H0djlIGNkRvEqahAzaXDKTgYWKF7ZLeLZ5ZOqaUw=;
        b=BLn80fpTbPZ+O4OsZqetw7rD4UBCA+dWPLJz/j2nZP7MkcGfUOQnnf5o5Ktk+a8aW+
         q4U6UcqbltOiQzOXDEUw6KPkO35M5RHRqQT6Vvr6Ve4IBRq0XP8K6apNe5zNdgINTiYv
         LuZWhYALeiiMu8E9r8f8K2dFd7dBnV1K7284Qin0GjPGNZ5ddRExXRgYaF4OsLUFTCvJ
         hduDeelqWyr0EH835COqrVB99dTt+K+VKwqIp1q1xwE8ICZYjYUoVK73jeKM5nRd2J7B
         N3IxgJJX/NcXQwM/7JAnOHny0SB49WbubaCWh2xStVchx0Bwz2n6NWPDujhoddDh+BO9
         Bq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270879; x=1725875679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j39H0djlIGNkRvEqahAzaXDKTgYWKF7ZLeLZ5ZOqaUw=;
        b=MuBCdTEiTcqlhsqdFVKri8JlGlDoJh28BwkZk+LaqbPuLmznGZu9giVFYkKyteILNS
         VxzdgTOizgby1RPbcMuL+1teA7SpxbcSDgUr30Xms3DnBtgXct9MKpRW05/Ny1BJoZcr
         5V0bZudbJZ0DPg8dcmJB4AOITzoQ2ruJFwrYKdVFkO0ugQTL24uSby+ziUlDQHAQZD72
         BPgR2D6ptxRXWu+/B4kCqvieV8Qcze9fzWd9grG/as9ZmkW5S/LYUt7y5bdJWMCCuD4c
         tIlV4AoXGT9oyzgolG6wcGCExOy8SF5mTG2/GbcHjozLwLQVg/K4SqHYanDTj/Z8D8Z6
         S+rg==
X-Gm-Message-State: AOJu0Yw2J36bjJ4xJ5Juzl/4qvtA+cs50pdxgsr1Ghx+UGs8XaBO0RAx
	ajCubWr/b2b9/crlrYbLRvfwMwK65kKfzhhkIC52vY9yi8oG2QeOMdV27CkOKu/Aiwhfp2iUr5v
	1Psj43W/aA56v0NLJnPiHBQjynKbR8GYLOFrlBw==
X-Google-Smtp-Source: AGHT+IGhAc+HyV61NOmivUagjO1+iOAamEKWiED6kc10KxPMsRcrdentwJMQWcDI20Kynm7aQSVNQ8jXBxVAvMi0P1Y=
X-Received: by 2002:a05:6871:8d81:b0:277:fdb5:9ce5 with SMTP id
 586e51a60fabf-277fdb5ce66mr978816fac.27.1725270879339; Mon, 02 Sep 2024
 02:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902080727.2665235-1-jens.wiklander@linaro.org> <b1787919-77d3-41da-9ebb-cecc65d2d310@app.fastmail.com>
In-Reply-To: <b1787919-77d3-41da-9ebb-cecc65d2d310@app.fastmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 2 Sep 2024 11:54:28 +0200
Message-ID: <CAHUa44GgySmc=byL9_0vUuP2BKifpMHqMgvMHJpEukgFGRvVmg@mail.gmail.com>
Subject: Re: [PATCH] rpmb: use IS_REACHABLE instead of IS_ENABLED
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Mon, Sep 2, 2024 at 10:31=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Sep 2, 2024, at 08:07, Jens Wiklander wrote:
> > Use the macro IS_REACHABLE instead of IS_ENABLED in <linux/rpmb.h> when
> > deciding if prototypes or stubbed static inline functions should be
> > provided. This fixes link errors when the calling code is builtin while
> > the RPMB subsystem is a module.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp@intel.c=
om/
> > Fixes: 1e9046e3a154 ("rpmb: add Replay Protected Memory Block (RPMB)
> > subsystem")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> Please don't work around a bug like this, fix it properly instead.
>
> > diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
> > index cccda73eea4d..37b5273c4027 100644
> > --- a/include/linux/rpmb.h
> > +++ b/include/linux/rpmb.h
> > @@ -61,7 +61,7 @@ struct rpmb_dev {
> >
> >  #define to_rpmb_dev(x)               container_of((x), struct rpmb_dev=
, dev)
> >
> > -#if IS_ENABLED(CONFIG_RPMB)
> > +#if IS_REACHABLE(CONFIG_RPMB)
> >  struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
> >  void rpmb_dev_put(struct rpmb_dev *rdev);
>
> This gives very unexpected runtime behavior where both RPMB and
> its user are enabled, but it doesn't work.
>
> I think what you want here is a dependency like
>
>       depends on RPMB || !RPMB
>
> for every caller. This enforces at build time that the MMC core can
> be built either when RPMB is disabled, of when it is reachable.

Thanks for the suggestion.

I tried adding the dependency above for MMC_BLOCK and OPTEE.

Setting CONFIG_RPMB to "y" works as expected CONFIG_MMC_BLOCK and
CONFIG_OPTEE can be configured as both "y" or "m".

Setting CONFIG_RPMB to "m" will make CONFIG_MMC_BLOCK and CONFIG_OPTEE
"m" too, even if they are set as "y" in the defconfig. So the module
status seems to spread to the options with the dependency. For
tristate options, it guarantees that the expected features are
available even if it changes from built-in to a loadable module.

It will do nothing for bool options, but that's a hypothetical case
for now.  Wouldn't spreading the built-in status to CONFIG_RPMB be
better? So CONFIG_RPMB turns into "y" if an option configured as
built-in depends on it. I don't know how to do that though, so that
could be saved for when it's needed.

I'll send out patches for MMC_BLOCK and OPTEE options shortly if we're
happy with the "depends on RPMB || !RPMB" approach.

Cheers,
Jens

