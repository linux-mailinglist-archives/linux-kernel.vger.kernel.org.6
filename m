Return-Path: <linux-kernel+bounces-364523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E2099D5B0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24DB1F24559
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB581C57B1;
	Mon, 14 Oct 2024 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+xzqXac"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9F1C304F;
	Mon, 14 Oct 2024 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927547; cv=none; b=mYCNfOAz5W259sbU4MbPS1d2KpsAsePDRSPU6+BQYkdrBa/pcuIo7tNIDVn5tFvSTe0rwEiy9R3o8T6WWABxbh+gF1KKl12viOWwusVFfPoGPrkn4zteAIjhzgZzx0M+ERK4elq/Lznpwnab+UvtW4Rc6OVkIAwrYTEj4AKbn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927547; c=relaxed/simple;
	bh=GSdP32UvF/3OTOvTrKWKCdA75fPSJyT8cZYVq5WuII0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUJnEDQbxWq2ncbhn8tWsyNopQPpmQLQM1Egj7KXqsHOyuaRUlM5OdQfOzFwrIJH7zm4KCdymPZo32ic48sivctI7/sk8F96ZlZCa5DSn7uhOcP/+6/BNm0tB7pqwKJzwtkom1JyKCwknwjQ1NpsZnITPE8emJhk+wL8P5fPh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+xzqXac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DD8C4CEC3;
	Mon, 14 Oct 2024 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728927547;
	bh=GSdP32UvF/3OTOvTrKWKCdA75fPSJyT8cZYVq5WuII0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g+xzqXacBIPl7JsHeHXFLj46QLlo9TKTjIvSkI1GrCtwWtFRROuWaru6uv/EvqxOP
	 MBhWelqJUWvMayRlYGmZ28yzBFtnqgu1lGm0iJa4/4gBUnlXLUVeluB6fu98b1xR2G
	 Cptlvy86kNxFJn1HKS0ZjwBeXdlFwoKUWe0Cc+6NROfnosjfLL71o5CO2gKti9i+d/
	 IY2fvdAi9fKqZb3V8UvLgqn2rzW06i5T8i76C2s20EdpMKkXQ4CJhO9s7tYonv2NZ3
	 lDgbM0YVplpA60w/3Z4EMLs/o4haWCCUVDFBA3KivRurCaW0fNE+YXZSTuCPOdaN8j
	 CJ0HoiN543cbw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so1309898e87.1;
        Mon, 14 Oct 2024 10:39:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV47fyK6Rfely2VTIf02HfUGipHxtO8yoPardOcfVDN8cFIM0rQQR4uHj2Dc/cBPQ/It/plM9a6Ci9U@vger.kernel.org, AJvYcCXfQDrObMkqutAJa7VT/W7/W7qbMn0Vnc/Eudgmr4o5f9joMdAv0vIs98WY/MaNO6Qor8n7hczr6fPWkCbx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn71m7/bUle21NcNyGayAMGY2z8MNgnm5rrWwi43FAhsoAf7io
	3u4Wc0g5S3vOMYgqsIWoxJGCvXJHyvx/D9w1BSrT3MVS6weIU/jrNtOLLwF9zDdOuuv1jb8izZO
	Jf8I9J0alYLNogV/2b5GDYvUYeQ==
X-Google-Smtp-Source: AGHT+IGsfTRPyPm9+84ee+96fBbvWyKCzmA8qytZEXkaEUVRTaFfm7J3+vzBiqPzmo8azDKt+aN/qJ+sYpgh7e2h65c=
X-Received: by 2002:a05:6512:10cc:b0:539:e97c:cb12 with SMTP id
 2adb3069b0e04-539e97ccdadmr3183668e87.34.1728927545757; Mon, 14 Oct 2024
 10:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912144430.3161717-1-treapking@chromium.org>
 <20240912144430.3161717-3-treapking@chromium.org> <CAL_JsqJngFLbNtT3m--xi5nNt9o7M=se8Qkhf20TxRCj-G=6dA@mail.gmail.com>
In-Reply-To: <CAL_JsqJngFLbNtT3m--xi5nNt9o7M=se8Qkhf20TxRCj-G=6dA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 14 Oct 2024 12:38:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJM3sHECd9U1aJ+HGvTarLxmrNFkXq-k4jGU4S6h8nO3A@mail.gmail.com>
Message-ID: <CAL_JsqJM3sHECd9U1aJ+HGvTarLxmrNFkXq-k4jGU4S6h8nO3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: mt8183: Add port node to dpi node
To: Pin-yen Lin <treapking@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, Fabien Parent <fparent@baylibre.com>, 
	Jitao shi <jitao.shi@mediatek.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 4:37=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Sep 12, 2024 at 9:44=E2=80=AFAM Pin-yen Lin <treapking@chromium.o=
rg> wrote:
> >
> > Add the port node to fix the binding schema check.
>
> The dsi node has the same issue.

This is still causing warnings in the tree. Please respin the patch.

>
> > Fixes: 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202409110843.Hm5W9upr-lkp=
@intel.com/
> >
> > ---
> >
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8183.dtsi
> > index 266441e999f2..0a6578aacf82 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -1845,6 +1845,10 @@ dpi0: dpi@14015000 {
> >                                  <&mmsys CLK_MM_DPI_MM>,
> >                                  <&apmixedsys CLK_APMIXED_TVDPLL>;
> >                         clock-names =3D "pixel", "engine", "pll";
> > +
> > +                       port {
> > +                               dpi_out: endpoint { };
> > +                       };
> >                 };
> >
> >                 mutex: mutex@14016000 {
> > --
> > 2.46.0.662.g92d0881bb0-goog
> >

