Return-Path: <linux-kernel+bounces-252174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70826930F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF492813FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F60913B2B0;
	Mon, 15 Jul 2024 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nk1OY536"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A924B5B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031770; cv=none; b=DYA+LTU2eopypiXH3kPBV668v4dbKxS+6DaK23ilkmt0bIFiZCd7FZNoHW0H597AIGSHX0bJWCG1RjRcs79l25/87wtK2TiJ/jYu/KpU2Rro/4xm4zpHAvHwCeVO1j2GibqRyLALFeNnmMbvVnvwK6ipc5d/VTNwB1LIPJqQDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031770; c=relaxed/simple;
	bh=L36mM9kQrS9p/p4Y6qIxqqLG5IWaYsdwHYYb7f0HXRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjWYLCtMIvbhjighhD7lmmjC5EylZQOvHG7Ua9Np6YhLX/QNHu8QuuzjqLn4gLJrz7nulhsFy39YDbijaDYI7SeZYtkl1wakb98WuTLoJPWVYAiuJCOeawvqudYWewaKkFR7t2PwieLjGNeE+rPbVxtl1mRcvFMwyXisNWDv7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nk1OY536; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77e7420697so520215066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721031767; x=1721636567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UxvuVs2RYdJvTG90vVQNL3KW5LdM1oQjpCuXib7OYPg=;
        b=nk1OY536eQZe0iJ01Z1MpR0ZMF0uTG/YPkX7yboukd+EAapdja/zxtHslTIehXEoKD
         95FNiz+WctiazXvuzzF73WXFELYS8zdXCQndnsqKcmxcPtRXfN89wgBwOBlsFaJ4ApO7
         CbFtrfssCM0mE+1/QoxXzAP/tLYJ42q0Xmya0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721031767; x=1721636567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxvuVs2RYdJvTG90vVQNL3KW5LdM1oQjpCuXib7OYPg=;
        b=t2QLsaC1DSGo+23JPvZ3hORZ1Y4JLSKrUzxjo8C5Z79nZXjPDJSexZmtRGMN4r1cBN
         Zut6do2EhEwyb8LX/GtgoAdQk78H7T6O4LvDL11ztDEXE8U4YQgRCGg3iYdgU8dPIX9b
         X1HnfsBAut6juxsdYaHkThm06OPGKPq/siGxPQnhzeO4CPEaXwYqoUNJ+LMr9Qplo9CF
         2zh27JcbRItENO5/fL/wFLBELXZncuiN9SdJZCG2CrIJI0H8RxH4ww/tuWLKmR2HHDW5
         egN2G/AfauDKtDvlXoY/WUTRsMMzKJu2uOSTZQCtDq3U3iSWEWDS99Idz2kgVl63QTmf
         jD5g==
X-Forwarded-Encrypted: i=1; AJvYcCWarIORbrRXbVbmaJ02qqvbmLgMqjCP5p5T4duwpsPXxLDdCGPSIrKkauEBB1peU1gpXh+TTUZlyF6rIa25q7C3G1gUrrnxyKTrsPhE
X-Gm-Message-State: AOJu0Yw2xtmfMnMnldSChAc5RiWFg7jFgrW7ayBZYeu+XxdakpigG3GI
	H/l4qh11Pn6OxAK8fDdJZ/iixPrxV47Z6mesCl3qUKkSWEi60tP7kiBJ5yID2GYrAuWIizJAnvB
	GAw==
X-Google-Smtp-Source: AGHT+IFb3HY7wUTNlqqLZUIYOatDaxS8nKDPA71Y9CIQa4BEIoVIdwFIuZAIDjnJxPddbaKRQ6ETZg==
X-Received: by 2002:a17:906:30d2:b0:a77:d7f1:42ea with SMTP id a640c23a62f3a-a780b70541fmr1212378266b.45.1721031767320;
        Mon, 15 Jul 2024 01:22:47 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff81esm191317466b.157.2024.07.15.01.22.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 01:22:46 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso4536159a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:22:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgI5xCl0Du6vtk0J7cn4aydjMbjzmkWowfqFPu8ykm6UT2LiwRpXMxXk5h9gonRlbM53phvo00+OGVu0jfCxKyvGhbFDcLnocaQwu/
X-Received: by 2002:a17:906:46c9:b0:a77:e2b2:8ec with SMTP id
 a640c23a62f3a-a780b68899dmr1183961966b.3.1721031766301; Mon, 15 Jul 2024
 01:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628-gcc5-v1-1-7cd56f04a6a8@chromium.org> <7dbda1952c9e873823d4e6d2a9534f1b3b945c4a.camel@pengutronix.de>
In-Reply-To: <7dbda1952c9e873823d4e6d2a9534f1b3b945c4a.camel@pengutronix.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Jul 2024 10:22:34 +0200
X-Gmail-Original-Message-ID: <CANiDSCvfamZjwOohT8ZFOr-m2SB=r-MCsrXGHtkfEkeYyEo2Nw@mail.gmail.com>
Message-ID: <CANiDSCvfamZjwOohT8ZFOr-m2SB=r-MCsrXGHtkfEkeYyEo2Nw@mail.gmail.com>
Subject: Re: [PATCH] media: imx-pxp: Rewrite coeff expression
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-media@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

Hi Philipp


On Mon, 1 Jul 2024 at 11:30, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Fr, 2024-06-28 at 15:11 +0000, Ricardo Ribalda wrote:
> > GCC5 cannot figure out that the expressions are constant, and that
> > triggers a build failure. Rewrite the expressions.
> >
> > The following gcc5 error is workaround:
> >
> >  #define BM_PXP_CSC1_COEF0_YCBCR_MODE 0x80000000
> >                                       ^
> >     BM_PXP_CSC1_COEF0_YCBCR_MODE |
> >     ^
> >  #define BM_PXP_CSC1_COEF0_YCBCR_MODE 0x80000000
> >                                       ^
> >
> > drivers/media/platform/nxp/imx-pxp.c: In function 'pxp_setup_csc':
> > drivers/media/platform/nxp/imx-pxp.h:582:38: error: initializer element is not constant
> > drivers/media/platform/nxp/imx-pxp.c:374:4: note: in expansion of macro 'BM_PXP_CSC1_COEF0_YCBCR_MODE'
> > drivers/media/platform/nxp/imx-pxp.h:582:38: note: (near initialization for 'csc1_coef_bt601_lim[0]')
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Can you elaborate on how this is triggered?

Building the driver with
https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/5.5.0/

It might be easier to repro with:

ribalda@denia:~/work/linux$ podman run --pids-limit=-1 --rm -it -v
.:/workdir  registry.freedesktop.org/linux-media/media-ci/build-ancient
# cd /workdir
# CROSS_COMPILE=x86_64-linux- make allyesconfig
# scripts/config -d MITIGATION_RETPOLINE
# CROSS_COMPILE=x86_64-linux- make olddefconfig
# CROSS_COMPILE=x86_64-linux- make drivers/media/platform/nxp/


>
> At least I couldn't reproduce this by just copy & pasting the
> csc1_coef_bt601_lim initializer and the required macros into gcc 5.4 on
> godbolt.
>
> Can this be fixed by using GENMASK / FIELD_PREP instead?

I was looking to make the change as simple as possible :)

>
> regards
> Philipp



-- 
Ricardo Ribalda

