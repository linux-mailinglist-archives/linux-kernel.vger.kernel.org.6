Return-Path: <linux-kernel+bounces-427965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD6A9E07FC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2312848A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D854417084F;
	Mon,  2 Dec 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9fCnuWJ"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E71632C5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155712; cv=none; b=ug5f+UdJn64wFE7RqYfZ1SzLolZtfkUT7uo5senhxP9uaz6pcZzIef3JhBa+GHrnT6dG7G5v39K+waVlxBi2JGlbnoUwhxJgrO1z3t8d9pBr3W1kC4w87kxv6mLSbCsm+2sBwMw26q3sYnB0FBk2WZfpkbRNhibePFj5uBBwyDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155712; c=relaxed/simple;
	bh=dHbL+f/Go6O+NMX+9hE1+QOYw6z9rPypOio0oceknSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/v2cOFSqiSXxem9V2Aq5RNmUcgFLuWzpAazWCbNZZJN2YTZRtSCdZjq8MpMv+PTLuyXWtJHj9eoYUqqoPFm6uDkx3lJKqF7tFImy0HEDy2gEEQTj6dS8wHgV4yV298Zo2gG+d4g8PNaLyLz8df1KJYeYbYBUlEFLCR6gQHDqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9fCnuWJ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b15d7b7a32so362677885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733155709; x=1733760509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g65m5wLGmeNM0imaWPfjDT5gKeN2tJjUFhX3nreziMM=;
        b=t9fCnuWJE9TntO+0UoGZVJMYnjs9yv10pSUND2fWNrBJMUL2VsWLbYD4n82aQL7ySX
         ryrEEojLU8KzNC54xPbkHAPsHTKJp7IY3AQDAdYYwqxibDbHV6GLLEkZVOIJSZQ4gT2Q
         d7gqTMVsrIDTcwfuSmOWLUDA4gbfPuFuoNt0sSEw3Qbz52seHVmR+9NxiFILTYZqvgGj
         ZvTiC12LlSLWBaKqyWcXJW6FiHng6j8nABE9nUoGVbYWdFvSKBCvgCNBLisyETad2vFm
         UoP5hL5BT/vUrUbChVvIPC6JsXzwGVzeMSfbAZVgf6zGGc4OcbqAn1v3p3gqrmA7lMzp
         zNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733155709; x=1733760509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g65m5wLGmeNM0imaWPfjDT5gKeN2tJjUFhX3nreziMM=;
        b=WCGz4i96+KfiYOFvCQ/tH0MMAnw4JFwvTXNyGfUkmNZ4ZFju5ePvUxuOX8tYGqffnE
         Jk7XaX2crlvto4xNOIfWIHoKF5bR1sH211fAmAwS/KLUmcNe0MM94Rvi2N/1jc/Z6SHF
         z8zczqPTQlS8fW96Ki7o0XeX5D0EzJSjNzVAcj0PVJzwYmQ66H67l8o3F//VtS5S9Zt/
         94BRpJfWxOt2vMKXftsa5qSuStTB4Qp1M6ZLC0betdacC/IcV6KSy4NERhJzG/Nodmz7
         J9mSCS6J1o+MsA/9MfZvCXlFQPnFn2CbwVj6rPiHqqSf8Xb7aqwLrliMu2DuvpRTmu/g
         WZrA==
X-Forwarded-Encrypted: i=1; AJvYcCVwi2FW8p0vSMi8L+IJQ0kGBkSR1Cp9MCTjESjHXG8sLYiy3mRzif1IlIv81Q6egaYOBwvSIs54Kqlfc6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVODL+32od81xmBOyl3rpRSD8Otvq/82oEMAZOeZWQsDUdPykP
	cHvxFREzR7/kU2pMSS/W/gUWIoRVfou90omjQj94IWC9tMpwHsWd+wtmYsivOf6aXfU6clxSViA
	sL862WifytwsP99NxFM9x5AENLg3xPjNEmDNpeSCjyMBYfSoq
X-Gm-Gg: ASbGncsejs9RfeYmJ2sxVRxJnZarmT1zauBkPzFNILreIG6BszV71c8az18JVeRNSFK
	M4zTGHmRtZnd+tzhA95QWvAVCf3FKrW8j
X-Google-Smtp-Source: AGHT+IFz8rX9DRRJ5onEJ67Od7I+D7KR9TNvA59oNfUh6oW0pwLXWng/zcOviJd4aYPyq52DFvFRuuqZBB6m7oAYo2M=
X-Received: by 2002:a05:6902:2b07:b0:e2b:e0ba:d50 with SMTP id
 3f1490d57ef6-e395b870e93mr21476694276.5.1733155698386; Mon, 02 Dec 2024
 08:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001113052.3124869-1-fshao@chromium.org> <CAGXv+5E4=dKkUo73x5vCMHawcr9AUd71LyLmDbdyOdJZv0ZBaQ@mail.gmail.com>
In-Reply-To: <CAGXv+5E4=dKkUo73x5vCMHawcr9AUd71LyLmDbdyOdJZv0ZBaQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 17:07:42 +0100
Message-ID: <CAPDyKFor=KyPEfrfLWct0dLa03hj6uawM-R3z4rOEzHSrNCWCg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] MT8188 DT and binding fixes
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Fei Shao <fshao@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Dec 2024 at 05:24, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Hi,
>
> On Tue, Oct 1, 2024 at 7:31=E2=80=AFPM Fei Shao <fshao@chromium.org> wrot=
e:
> >
> > Hi,
> >
> > This series is split from a previous series[*] to focus on few fixes an=
d
> > improvements around MediaTek MT8188 device tree and associated bindings=
,
> > and addressed comments and carried tags from the previous series.
> >
> > [*]: https://lore.kernel.org/all/20240909111535.528624-1-fshao@chromium=
.org/
> > [v1]: https://lore.kernel.org/all/20240925110044.3678055-1-fshao@chromi=
um.org/
> >
> > Regards,
> > Fei
> >
> > Changes in v2:
> > - new patch to MediaTek jpeg and vcodec bindings
> > - new patch to move MT8188 SPI NOR cell properties
> > - revise commit message of vdec power domain changes
> >
> > Fei Shao (8):
>
> >   dt-bindings: power: mediatek: Add another nested power-domain layer
>
> This one ^
>
> >   dt-bindings: PCI: mediatek-gen3: Allow exact number of clocks only
>
> >   dt-bindings: media: mediatek,jpeg: Relax IOMMU max item count
> >   dt-bindings: media: mediatek,vcodec: Revise description
>
> and these two ^ have not been picked up, and now v6.13-rc1 has DT
> validation errors for MT8188:
>
> /ssd1/wenst/linux/mtk/arch/arm64/boot/dts/mediatek/mt8188-evb.dtb:
> syscon@10006000:
> power-controller:power-domain@15:power-domain@16:power-domain@29:power-do=
main@30:
> Unevaluated properties are not allowed ('power-domain@31',
> 'power-domain@32' were unexpected)
>     from schema $id:
> http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
> /ssd1/wenst/linux/mtk/arch/arm64/boot/dts/mediatek/mt8188-evb.dtb:
> power-controller:
> power-domain@15:power-domain@16:power-domain@29:power-domain@30:
> Unevaluated properties are not allowed ('power-domain@31',
> 'power-domain@32' were unexpected)
>     from schema $id:
> http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
>
> /ssd1/wenst/linux/mtk/arch/arm64/boot/dts/mediatek/mt8188-evb.dtb:
> jpeg-decoder@1a040000: iommus: [[101, 685], [101, 686], [101, 690],
> [101, 691], [101, 692], [101, 693]] is too long
>     from schema $id:
> http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
>
>
> Is there any way we can get them into v6.13 as well?

I don't know why I missed picking up the DT power-domain patch for
v6.13. Sorry for the delay. Anyway, I have taken it now and applied it
as a fix for v6.13-rc[n], thanks!

I assume someone else can help to take the DT media patches.

Kind regards
Uffe


>
> ChenYu
>
> >   arm64: dts: mediatek: mt8188: Add missing dma-ranges to soc node
> >   arm64: dts: mediatek: mt8188: Update vppsys node names to syscon
> >   arm64: dts: mediatek: mt8188: Move vdec1 power domain under vdec0
> >   arm64: dts: mediatek: mt8188: Move SPI NOR *-cells properties
> >
> >  .../media/mediatek,vcodec-subdev-decoder.yaml | 100 +++++++++++-------
> >  .../bindings/media/mediatek-jpeg-decoder.yaml |   3 +-
> >  .../bindings/media/mediatek-jpeg-encoder.yaml |   2 +-
> >  .../bindings/pci/mediatek-pcie-gen3.yaml      |   5 +-
> >  .../power/mediatek,power-controller.yaml      |   4 +
> >  arch/arm64/boot/dts/mediatek/mt8188-evb.dts   |   2 -
> >  arch/arm64/boot/dts/mediatek/mt8188.dtsi      |  33 +++---
> >  7 files changed, 88 insertions(+), 61 deletions(-)
> >
> > --
> > 2.46.1.824.gd892dcdcdd-goog
> >
> >

