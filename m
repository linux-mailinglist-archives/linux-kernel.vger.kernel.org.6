Return-Path: <linux-kernel+bounces-190681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489078D0154
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1331F21EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC0F15EFBE;
	Mon, 27 May 2024 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2ka2B0X"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59D15EFA4
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816256; cv=none; b=NtW2qKJeb+C4As6sr3jthEUi5u+0LkhNqPz5eh4Q+5mtgM7jB0YeTLnlpHFgye8DzewXUrEOkwWDyhpy4R+r8ulfQpYxs0gtsZJ2MSiO/zS9D1yeaOHLBKsGgblPR4qa6veWVL68gIYSgrehWU8X62uQ4Yp/fnsGL7YIppveVj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816256; c=relaxed/simple;
	bh=BeMqoH5GvSpJ1d9avTl/slNkeZp+MwMFavChpJnITDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDFC4otrL3E4HhO2m0cFwqFpbpf6HVX+Cesfc6yAUt9sD4DUBkKhuOJeQ0m38PnaKoiXuZBzfStbRoDxz4uu49y3bBERMO/K4o2q+OtmWOHRPtGRW8K21nDdJPeBnulGdNaxKx8jg9nYiYaKWrI805I27LvgoO/4upLUuStjfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T2ka2B0X; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b2e93fddafso2498838eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716816254; x=1717421054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHrHZEEV9e4XfK4jWbKD94symQTEPPz3n5O2dV/Sklk=;
        b=T2ka2B0XNH2fbhlUlOYkda/4neCoJZnbbZitc6m2ZLtd/9pHRrwSP5AXzGL2pqiZui
         NStIEqWW+UKuI1tdydtCzwy4fGB/LxPUVEsk+6JfF3VYJLD4vj05k0oEorsOdMcgZoTw
         2KIX1pAoeedXHOiQE8ShwbF23Hg9JWNV4mKNoG9ebr6lEaM5OkbBjeYfN0vzb3Xxk3xY
         V2jBTzejhOXwz7F+sLI2OZP5uyQAdAezFdIdvJKzOGBcROpRxNQQepBXOLBHx4Ihg0wq
         +qezH8fip8RBP7wMT+psPhmgu98ERMHqU559NGw6y7xt2ZSi4Z+WHLGx5ZRybQxTiO3i
         S56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816254; x=1717421054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHrHZEEV9e4XfK4jWbKD94symQTEPPz3n5O2dV/Sklk=;
        b=VpaoIaMDokcSYhRtzhS0vO/RpvY19he9bHeIpRuRDxTSYsGySMp/mJ3rYCcDk6JhCa
         SSre17CoOGM9s3MoklsQgN1MdKZCOyzXBHljq4oR7Uf0XNbg5T14FmrlMX1iiNJefC13
         /K9/dUgLXwwoRmsIcycEFOa0IgN4YMByPljuaFGCI0P+d6Gn3Qaiyz7xnUErVjSYnYtF
         F0b2dYxOYTiJSNYr2CLNa1yIwXIUBkr7EK2h3BCjhr2Q+b9xNabvYuHe4h3P5B0Cd/pr
         I8Uwpvf6NgRKZONofzMK+ShITPaWfq2d2FXPRg8KHw0fqmNDe9JTtUbFTTaOZopR7HdR
         9u2w==
X-Gm-Message-State: AOJu0YyPHeQZ7mAczD7x2eLRHW+zn6kRLZIjaLEMIRQIDs9Bce8zY5WO
	9JJWCsNvhdGsBZ7avnTeYRUSwROyfCHKUt6M8iPPnRaiX9yjK8YFoHnaypiEZEJhZFFcTwgrSvJ
	b6LzLzBunS/iQxB4olmSe1BjEtQC/9R+7c5qWeg==
X-Google-Smtp-Source: AGHT+IFJyq+AmvAn3DRrmHTUYcPq5TlAmpW0rWrghLQmgqDTzPzpoHnXo1PKce+wt5kaPQ1qmeH225azZTV6JbGWreY=
X-Received: by 2002:a05:6820:22aa:b0:5b9:89d9:c5ef with SMTP id
 006d021491bc7-5b989d9c96amr2849706eaf.0.1716816253777; Mon, 27 May 2024
 06:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org> <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
In-Reply-To: <fc3bfebb-78b7-428e-8da5-5221f4921faa@linaro.org>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 27 May 2024 15:24:01 +0200
Message-ID: <CAHUa44G0bcK55RxNrN5sXiicBZ-BJtA46KpedfBdUSKsN8eUOA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Manuel Traut <manut@mecka.net>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 3:00=E2=80=AFPM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> On 5/27/24 14:13, Jens Wiklander wrote:
> > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to probe an=
d
> > use an RPMB device via the RPMB subsystem instead of passing the RPMB
> > frames via tee-supplicant in user space. A fallback mechanism is kept t=
o
> > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > available.
> >
> > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > devices until one is found with the expected RPMB key already
> > programmed.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Tested-by: Manuel Traut <manut@mecka.net>
> > ---
> >  Documentation/ABI/testing/sysfs-class-tee |  15 ++
> >  MAINTAINERS                               |   1 +
> >  drivers/tee/optee/core.c                  |  96 +++++++++++-
> >  drivers/tee/optee/device.c                |   7 +
> >  drivers/tee/optee/ffa_abi.c               |  14 ++
> >  drivers/tee/optee/optee_ffa.h             |   2 +
> >  drivers/tee/optee/optee_private.h         |  26 +++-
> >  drivers/tee/optee/optee_rpc_cmd.h         |  35 +++++
> >  drivers/tee/optee/optee_smc.h             |   2 +
> >  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++++++++
> >  drivers/tee/optee/smc_abi.c               |  14 ++
> >  11 files changed, 387 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-tee b/Documentation/=
ABI/testing/sysfs-class-tee
> > new file mode 100644
> > index 000000000000..c9144d16003e
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-tee
> > @@ -0,0 +1,15 @@
> > +What:                /sys/class/tee/tee{,priv}X/rpmb_routing_model
>
> Wouldn't /sys/class/tee/teeX/rpmb_routing_model be good enough?

Doesn't the routing model concern tee-supplicant more than a TEE
client? Then it might make more sense to have
/sys/class/tee/teeprivX/rpmb_routing_model only. Keeping it for both
devices representing the same internal struct optee makes it easier to
find. Anyway, I don't mind removing one. Mikko, what do you prefer?

Cheers,
Jens

