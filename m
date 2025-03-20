Return-Path: <linux-kernel+bounces-569824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B364A6A7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB478A6F93
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02DD221F21;
	Thu, 20 Mar 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4BPKYRz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077BDEEBA;
	Thu, 20 Mar 2025 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479618; cv=none; b=se7iJBz8w53MtpATQtgZTfYIzpQbmJaRrAE4yZ9zAGjidKVNdHf/DLw9dPeBHt60LPPta8C1MASZMa1/Sg39Tj4gHOAP1Q8h/5Y3QgudDNa5b2DP6oNN3+35X+XeEwDxgzbssl8HlyAixau5HHIF0jekcn2K1aUEW9Xtc/45kj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479618; c=relaxed/simple;
	bh=DDT6cBNLHmKYa9YmgU/1bp9DFS0kjiVUPiG6LoDCQkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFvfmaRpb7h+Ihf9Yy3TnWDWXVrb1h6/mnzA7B/r0wscbpTLz9m/liSttkENhploam1S3awoMXWkVaNFo+xwY3k/0Mqx5lCfGq31KTIQvLqULszcnWZx1MWpYUyo472oo13rVpw7yxcsegpGHBfUjMRXoVKaKm6pubKGRfLvrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4BPKYRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A300C4CEE3;
	Thu, 20 Mar 2025 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742479617;
	bh=DDT6cBNLHmKYa9YmgU/1bp9DFS0kjiVUPiG6LoDCQkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V4BPKYRzvQJtl1/VHvXwAeLhb2QGsK0slYcHLiptqwGGBaU12wkYPoU0ZrcIiigcf
	 wbtYtBqP3MPNAhTXnGH09V+oGtpxwxjk00zWyZ+m7WsaoJCCV+H1sEpcBU7TJASn7d
	 +MxLw9anNefyoGhx2LI2yTOnk5Tz+hAMO75y9EaP1r/qfVEjx1wzMOGgy4LUp8WLmA
	 kSPIAk5eXVN067y2nnTMXzE83vHOtWoywWHplLl/nCR2K4ZlrCYurIHShzKZ600ic7
	 zFx8r8yQqszbiMVymkwM/txmVYr5V19fzmZ/WZ3/ysnlRDeYqgWu8TmzsVgVmltDXn
	 XZIStK5gJNvwQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso1500346a12.3;
        Thu, 20 Mar 2025 07:06:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJkTRRd9yccUZz2Odbbn2GgilE1aX/yMQUwiIKRcPlYPfg48v4P+2pC++IgVxF/uqN1jTxxD5/gbfRX5He@vger.kernel.org, AJvYcCVn6YDzDk1kyURxRtWsipWJ1RekFywzwVyYMTWiZKD7jcLUIN1syLNMVTUOzrZvu0LnuyQWxoPChWLr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5l/7piE/S9LoBJJZ250vvnKMSNsfJLHmy+vXEa65AiZIFxSV
	YktaYfYTluVYjxGsBy6T3h787JXToWRso7R1vk3hghjQlwgFZUzTW98ps17+0cn/NqLICTTvpQQ
	Qn4yHjgTy4pLpWKizGYyBmsh3fA==
X-Google-Smtp-Source: AGHT+IH2XwHhX6jV9jRXmOCR8jBeUV2nLXlOUeKeC+dcaCuo4JoCVhdLZhacD69eHm0iAGZjF0VMi0QdyHinZWHSPLg=
X-Received: by 2002:a05:6402:1e8a:b0:5ea:cca7:432d with SMTP id
 4fb4d7f45d1cf-5eb80d1af73mr7445698a12.14.1742479615750; Thu, 20 Mar 2025
 07:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319-snor-rdid-dummy-ncycles-v1-0-fbf64e4c226a@infineon.com>
 <20250319-snor-rdid-dummy-ncycles-v1-2-fbf64e4c226a@infineon.com>
 <20250319233024.GA2625856-robh@kernel.org> <a3818477-5a67-43ad-8961-88fa02916968@linaro.org>
In-Reply-To: <a3818477-5a67-43ad-8961-88fa02916968@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 20 Mar 2025 09:06:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKtz5+R1kjEzjo6bVicOX2c=UauC0_STAF0T02rSDqO+w@mail.gmail.com>
X-Gm-Features: AQ5f1JpmrFI8IwNaOt_WJJA7aVFlee9JZM4Qcktwre03i7fejG0n7XaAnObd1s0
Message-ID: <CAL_JsqKtz5+R1kjEzjo6bVicOX2c=UauC0_STAF0T02rSDqO+w@mail.gmail.com>
Subject: Re: [PATCH 2/3] mtd: spi-nor: use rdid-dummy-ncycles DT property
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Takahiro Kuwano <tkuw584924@gmail.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bacem Daassi <Bacem.Daassi@infineon.com>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 2:44=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> Hi, Rob,
>
> On 3/19/25 11:30 PM, Rob Herring wrote:
> > On Wed, Mar 19, 2025 at 06:47:44PM +0900, Takahiro Kuwano wrote:
> >> There are infineon flashes [1] that require 8 dummy cycles for the
> >> 1-1-1 Read ID command. Since the command is not covered by JESD216
> >> or any other standard, get the number of dummy cycles from DT and use
> >> them to correctly identify the flash.
> >
> > If Read ID fails, then couldn't you just retry with dummy cycles? Or
>
> I think Read ID won't fail when the op requires 8 dummy cycles, it
> probably just reads garbage on the first 8 cycles, so we risk to wrongly
> match other flash IDs.
>
> > would unconditionally adding dummy cycles adversely affect other chips?
>
> Adding 8 dummy cycles to chips that don't need it, would mean ignoring
> the first byte of the flash ID, thus we again risk to wrongly match
> against other flash IDs.
>
> >
> > Otherwise, add a specific compatible to imply this requirement. Adding
> > quirk properties doesn't scale.
>
> Do you mean a flash name compatible, like "cyrs17b512,spi-nor"?

Yes, but that's not the format of compatible strings.

> The
> problem that I see with that is that we no longer bind against the
> generic jedec,spi-nor compatible, so people need to update their DT in
> case they use/plug-in a different flash on their board.

This chip is clearly *not* compatible with a generic chip.

You have the same problem with a property. Users have to add or remove
the property if the flash changes. Anyone thinking they can use this
chip as a compatible 2nd source is SOL.

Rob

