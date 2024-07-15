Return-Path: <linux-kernel+bounces-252477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386CF931391
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F60283E90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304B4189F5E;
	Mon, 15 Jul 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiS5oq+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20D18A93D;
	Mon, 15 Jul 2024 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045129; cv=none; b=TbQqYA20Y7wSQ9+A0qvGS3jpJYtT6kcHMhC2dvxZd7NVKQYY5Oe81Rb/KDyJxI3wcVKkAYNCYOd1P09zpu7w5jExrTo848Vhc3LqIUylUUp82MOQludqRT7q2kf4eSZX309ZtjpeNUJMr3TpQ66Gf7B06+ysWZVG4UxeIp7Jbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045129; c=relaxed/simple;
	bh=s2mkn2uq9E6TGiHmQ4YLsBdAif1DnupN+Ag/ISQjFiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekDA9ZDQXqeD6wkm2hrZ70YCZmOZkRP21p/JlzupBCvy9UfkBeJ8n44J7gCf/+QDXemjWk44LBBBM/fq2hTpnzEqRwpu7VrJENSJe4rvS6BOGz0JR/QCvrv2+C5sWJ88ufo0xLtDT8fAq/6hRKIUTNXk8CSlSz8JP6rakVOmUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiS5oq+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388D8C4AF0F;
	Mon, 15 Jul 2024 12:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721045129;
	bh=s2mkn2uq9E6TGiHmQ4YLsBdAif1DnupN+Ag/ISQjFiQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PiS5oq+7x5YGZdwbWAvUGaRUlGe+JF1MTPZ912Vifr2JPbGPQyDc6Wlo7Xby65OBw
	 1gqszfDZ41RJq7DwFYn5c+evWDoj/cToIfk5ltJ+hnj1NrPPQxMqUV3st1tRQIbDKc
	 vxmltRY/+MmRK1qnpAnufDze210RSIIrVTA760RmasX/lnd77pAVYQ5BGJnR0uJe1q
	 EWMV58KtblwGGr6QYb3IhVD57RY0jOHpH+dQglqqpYJgnhPgUFE3TYbH1Zb+Rh0Oq9
	 yPERXgob81zBgHph/sP60RgPiNLtwHOKoygKJFM/FhL6FcN6CmDwzel6AvlLMaK0FG
	 UIphjQ8dCZ/Jg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eedeca1c79so23713241fa.3;
        Mon, 15 Jul 2024 05:05:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXl400IYJYC8LZsHfczxNdhdNMneYZ9xGgrYZQaBSQEDmsuhfAxFrijuzDFjmZtnfG7sCLRhxEA2hG+WM662cpd0XvXk74Y+o+UzrkL3NRsrdVAHThsd6DEtT83Hi5FcfL3vVnrpmhx0g==
X-Gm-Message-State: AOJu0YxaquLBhRJgQzu6WHvkgpsYZpDd/QXD31WD83gal1Ngdl8UVDkN
	KfmQALVlEDWrZwK0D5na3qufXcDjeq8BVQ1NkAvB5Q0ewfjXyax35Kolf08GzPDnHMWAL0KMAKa
	ZEmOe6LYMQgiiUIyfoPhqMphT1g==
X-Google-Smtp-Source: AGHT+IFSIgWPbdlA3APqdfpWCleBYmvVZrI5bkmI1uJ4ouonfKyDbSmMH20HREkhDlvRpAe66MlHC/k+4BSNX4xBBu0=
X-Received: by 2002:a2e:960f:0:b0:2ee:52d5:c4a3 with SMTP id
 38308e7fff4ca-2eeb318241amr139840861fa.39.1721045127555; Mon, 15 Jul 2024
 05:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711085930.26252-1-krzysztof.kozlowski@linaro.org>
 <CAL_Jsq+WdctoTMNoakiY5kh4nDoNx5h522s76LoHyD_yKYvvSg@mail.gmail.com>
 <73038a80-ce58-4967-a258-d6befe23c777@linaro.org> <CAMuHMdWkGD1gcwrLhd_fSdJLV2SzCVJ=yo+ekhOAfjUp=5Hh3A@mail.gmail.com>
In-Reply-To: <CAMuHMdWkGD1gcwrLhd_fSdJLV2SzCVJ=yo+ekhOAfjUp=5Hh3A@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 15 Jul 2024 06:05:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLTeO7LyjsKAiSMZcffAj1J1=Yc+BtOzmaWZUDfukMoNw@mail.gmail.com>
Message-ID: <CAL_JsqLTeO7LyjsKAiSMZcffAj1J1=Yc+BtOzmaWZUDfukMoNw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: incomplete-devices: document devices
 without bindings
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>, 
	Jonathan Cameron <jic23@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 3:57=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Krzysztof,
>
> Sorry for being late to the party, as v2 was sent, and applied ;-)
>
> On Fri, Jul 12, 2024 at 11:41=E2=80=AFAM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 11/07/2024 15:01, Rob Herring wrote:
> > >> +      - description: Incorrect compatibles used on other PowerPC de=
vices
> > >> +        enum:
> > >> +          - 1682m-rng
> > >> +          - IBM,lhca
> > >> +          - IBM,lhea
> > >> +          - IBM,lhea-ethernet
> > >
> > >> +          - mpc5200b-fec-phy
> > >> +          - mpc5200-serial
> > >> +          - mpc5200-sram
> > >
> > > Tell Grant he needs to document these. ;) JK
> > >
> > >> +          - ohci-bigendian
> > >> +          - ohci-le
> > >> +          - ohci-littledian
> > >
> > > Given the typo, I think we can just drop this one from the driver.
> >
> > Sure, I'll send a patch. It could affect some ancient user, though...
> > Although I really wonder if any of these PowerPC boxes are still alive.
>
> Looks like you forgot various "chrp,*" and "pnpPNP,*" ;-)

There aren't any cases of 'pnpPNP' flagged by 'make
dt_compatible_check'. Most of the cases in the kernel are with
of_find_compatible_node() which doesn't get parsed. Maybe it could be.

The intent wasn't really to be complete. Doesn't really matter until
we get 'make dt_compatible_check' to zero. Still 1300 bindings to
convert.

Rob

