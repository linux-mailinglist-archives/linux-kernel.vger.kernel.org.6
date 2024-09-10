Return-Path: <linux-kernel+bounces-322469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B41997294A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07171F26310
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3163417A5AA;
	Tue, 10 Sep 2024 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBzntBuK"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C6166F00
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948422; cv=none; b=HuYF7FBhbrmD2F7Tw9vKdCKmq5a/z5yG3uq83XEIConrS3iD27AHm7xIn69uzUyBWp6T4KCbbTpYT4688Ogmknp9qV8RT1/RrL7rbmu+NoMYWzh3UScnw0vtgtVsr9Ibw5+weUpXPcZb6nugkmugbXuVVwS/DQbjJzXsLb0tMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948422; c=relaxed/simple;
	bh=Y4IUApUSHTsnmcu4wF4wE4pQLfT7M//t+j035MFadwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpByJpzoWfly75kpLrjGVNgN2BRGoC/J1PczbyEtk50/u6cLyQ4rbLqGCdlvDsVI7Bj8NAo9b/TphHYyzxDR+ltUJuR4si6O8GwdarxKPZX5MXST6L0SMis2F6NapjDSZH6+pVmCpu66yP/obkFgkoUhaM0yt0lIh6U44cXcorU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CBzntBuK; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-277e6002b7dso2706303fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725948418; x=1726553218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9MHdiQIKbQZ7sHVzFN+NNCUWOQwDHp5p4yZrC2v9dg=;
        b=CBzntBuK2A80ovZYB1HZeo1BQcV1R3JOEpzWXtSSPd97UEQgaaQ/giTYolQiIlr+L0
         h8PwVtwiwPLypvtN/15CnRw1nWQWh9v47565FNPzLypO8K9hzscNCsxmp+q3g5u0Heyw
         iTEVkuW8Na+SOpW2LzN7YMOKjwAqPKOTvuvnj+hkqo/QEM/W1w7iufVPCGlwcbWyUxKo
         L+Oa6hURcTi9CrPmrEe/ep93cCXFh/K39VS9lgOkpgXOngus3Kc8EmxaNJDPbwnnhxt1
         UreKI9e7FOGBDmO/wFWkv5kpE27cFx9CeeM5PRWF8FhPMjvhbF7GIv2uRsStrbuIsvez
         CRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725948419; x=1726553219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9MHdiQIKbQZ7sHVzFN+NNCUWOQwDHp5p4yZrC2v9dg=;
        b=eHweoqODYnvSEPLOsmLvSRJ8x59V4WEKWe4OPpWq/tp7/dCFr8lMz/DJiknnNmu7Em
         D2A//FTf6nUzhq2jB0xf659ZPxOaNC7c9cbb64o4ifdNshF4QR8OK3yDlCeYXEfPJTXN
         somOWBA4j5ELYE0N77tKSfBrxzO1a3WUWqrkbMS59HmF6cK25qPd8+6TuOmnUAxd1rQT
         48UrznuspHgxcVxn+GPNiDdQ2gB5zP2giIjV3ZRjTKIhxQaNPL67BemJxbSkeRnLY2OS
         IuEEfBsqVrsgzu9Vwo9IBTuVJLBtHB/N9zGO8WcQy5R+x0JGtPGW4eFFl2IXwHYSvZ0N
         Uo5Q==
X-Gm-Message-State: AOJu0YwggP8u7bpInxdWJ4Yi9+uExxckzUSIMg1HCTtZT4mrd271WTWu
	/7i3nWHWBKtuZUj6yDJTFmnueNuIr4oK0rUXVw2aESlT9somEQdEuJUW6rkcTx6dnxovPZ/nywq
	ZU5j7x2MJsW4YtfdgayxL/2j+NOPam4pl+zXZDQ==
X-Google-Smtp-Source: AGHT+IEICe98dkZbn2Ns9nln8TerGdgfmay8kae6nOnNQUjTdvKEr1T8PPGslpKcLz8r5N2w/0aeGsRv9D3S4R0GNlg=
X-Received: by 2002:a05:6870:9122:b0:278:22d3:53 with SMTP id
 586e51a60fabf-27b82e076cdmr13465979fac.12.1725948418296; Mon, 09 Sep 2024
 23:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830070351.2855919-1-jens.wiklander@linaro.org>
 <20240830070351.2855919-5-jens.wiklander@linaro.org> <CABdmKX2KzswmiDY4oWw69_rPWs8d_Cqp7OXouSeMQaYX1SDSmw@mail.gmail.com>
 <CAHUa44FYYFVQWf0DGUXNHoOVQEC0-HRyYa0386dHNjo4y1qSiQ@mail.gmail.com> <CABdmKX0qd0RoTn2TBQTs9zdf=_JP8pW8hFRUR_7n_t-sfxsGdg@mail.gmail.com>
In-Reply-To: <CABdmKX0qd0RoTn2TBQTs9zdf=_JP8pW8hFRUR_7n_t-sfxsGdg@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 10 Sep 2024 08:06:46 +0200
Message-ID: <CAHUa44E-7UMseWSEeneYYnAPyhH___=a1YYR6uaOVTNZytzg7g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] dma-buf: heaps: add Linaro restricted dmabuf heap support
To: "T.J. Mercier" <tjmercier@google.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 11:42=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Wed, Sep 4, 2024 at 2:44=E2=80=AFAM Jens Wiklander <jens.wiklander@lin=
aro.org> wrote:
> >
> > On Tue, Sep 3, 2024 at 7:50=E2=80=AFPM T.J. Mercier <tjmercier@google.c=
om> wrote:
> > >
> > > On Fri, Aug 30, 2024 at 12:04=E2=80=AFAM Jens Wiklander
> > > <jens.wiklander@linaro.org> wrote:
> > > >
> > > > Add a Linaro restricted heap using the linaro,restricted-heap bindi=
ngs
> > > > implemented based on the generic restricted heap.
> > > >
> > > > The bindings defines a range of physical restricted memory. The hea=
p
> > > > manages this address range using genalloc. The allocated dma-buf fi=
le
> > > > descriptor can later be registered with the TEE subsystem for later=
 use
> > > > via Trusted Applications in the secure world.
> > > >
> > > > Co-developed-by: Olivier Masse <olivier.masse@nxp.com>
> > > > Signed-off-by: Olivier Masse <olivier.masse@nxp.com>
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  drivers/dma-buf/heaps/Kconfig                 |  10 ++
> > > >  drivers/dma-buf/heaps/Makefile                |   1 +
> > > >  .../dma-buf/heaps/restricted_heap_linaro.c    | 165 ++++++++++++++=
++++
> > > >  3 files changed, 176 insertions(+)
> > > >  create mode 100644 drivers/dma-buf/heaps/restricted_heap_linaro.c
> > > >
> > > > diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/=
Kconfig
> > > > index 58903bc62ac8..82e2c5d09242 100644
> > > > --- a/drivers/dma-buf/heaps/Kconfig
> > > > +++ b/drivers/dma-buf/heaps/Kconfig
> > > > @@ -28,3 +28,13 @@ config DMABUF_HEAPS_RESTRICTED_MTK
> > > >         help
> > > >           Enable restricted dma-buf heaps for MediaTek platform. Th=
is heap is backed by
> > > >           TEE client interfaces. If in doubt, say N.
> > > > +
> > > > +config DMABUF_HEAPS_RESTRICTED_LINARO
> > > > +       bool "Linaro DMA-BUF Restricted Heap"
> > > > +       depends on DMABUF_HEAPS_RESTRICTED
> > > > +       help
> > > > +         Choose this option to enable the Linaro restricted dma-bu=
f heap.
> > > > +         The restricted heap pools are defined according to the DT=
. Heaps
> > > > +         are allocated in the pools using gen allocater.
> > > > +         If in doubt, say N.
> > > > +
> > > > diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps=
/Makefile
> > > > index 0028aa9d875f..66b2f67c47b5 100644
> > > > --- a/drivers/dma-buf/heaps/Makefile
> > > > +++ b/drivers/dma-buf/heaps/Makefile
> > > > @@ -2,4 +2,5 @@
> > > >  obj-$(CONFIG_DMABUF_HEAPS_CMA)         +=3D cma_heap.o
> > > >  obj-$(CONFIG_DMABUF_HEAPS_RESTRICTED)  +=3D restricted_heap.o
> > > >  obj-$(CONFIG_DMABUF_HEAPS_RESTRICTED_MTK)      +=3D restricted_hea=
p_mtk.o
> > > > +obj-$(CONFIG_DMABUF_HEAPS_RESTRICTED_LINARO)   +=3D restricted_hea=
p_linaro.o
> > > >  obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)      +=3D system_heap.o
> > > > diff --git a/drivers/dma-buf/heaps/restricted_heap_linaro.c b/drive=
rs/dma-buf/heaps/restricted_heap_linaro.c
> > > > new file mode 100644
> > > > index 000000000000..4b08ed514023
> > > > --- /dev/null
> > > > +++ b/drivers/dma-buf/heaps/restricted_heap_linaro.c
> > > > @@ -0,0 +1,165 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * DMABUF secure heap exporter
> > > > + *
> > > > + * Copyright 2021 NXP.
> > > > + * Copyright 2024 Linaro Limited.
> > > > + */
> > > > +
> > > > +#define pr_fmt(fmt)     "rheap_linaro: " fmt
> > > > +
> > > > +#include <linux/dma-buf.h>
> > > > +#include <linux/err.h>
> > > > +#include <linux/genalloc.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/of_fdt.h>
> > > > +#include <linux/of_reserved_mem.h>
> > > > +#include <linux/scatterlist.h>
> > > > +#include <linux/slab.h>
> > > > +
> > > > +#include "restricted_heap.h"
> > > > +
> > > > +#define MAX_HEAP_COUNT 2
> > >
> > > Are multiple supported because of what Cyrille mentioned here about p=
ermissions?
> > > https://lore.kernel.org/lkml/DBBPR04MB7514E006455AEA407041E4F788709@D=
BBPR04MB7514.eurprd04.prod.outlook.com/
> >
> > Yes, I kept that as is.
>
> Ok thanks.
>
> > > So this is just some arbitrary limit? I'd prefer to have some sort of
> > > documentation about this.
> >
> > How about removing the limit and using dynamic allocation instead?
>
> That works too!

It turns out that was easier said than done. The limit is hardcoded
because dynamic memory allocation isn't available at that stage during
boot. We have a short description of this heap in Kconfig. I'll add
something about the limit there if that makes sense.

Thanks,
Jens

