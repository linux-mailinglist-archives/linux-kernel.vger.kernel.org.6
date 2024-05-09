Return-Path: <linux-kernel+bounces-174557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCEC8C10B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8DD8B22252
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3C615CD7C;
	Thu,  9 May 2024 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvusXzrp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CDC15B116;
	Thu,  9 May 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262932; cv=none; b=lj4naP7Mm5OVuJ15ZTiRc/VieVQ/NrWgTeX64F4BQx2YfGT4EejfR5llAx+rYpJFyMGVcwKQZ96zuB7W3KNrn3A/nGVJwbNSF98NG4xHyEgskuY+M1+gwbDlQVkeq7m1YmKg3PsWuS3LopI5S/xB+EMG+Hl36BxR7XOQTQzMR+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262932; c=relaxed/simple;
	bh=Pbof/f9raYmyb5MqYobPUYSaqX0hPFgEJmmhhXn7+X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlsOaRJ7G4r2VLOaakkujv2BabJdvpzLhA0jyDBPMIBsWdnXqp+9YUneRpPbTjyfr7FU2l7ZLZfwzQG8O1a/CcK0DAW4yPkm6E74AFYmzvWXGtOp5H8u9e0emDGdPoGAzJKcIdPZcSiQnWRamWlfXmvMn4Hb4pM81u08MeyvSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvusXzrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAB7C4AF07;
	Thu,  9 May 2024 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715262932;
	bh=Pbof/f9raYmyb5MqYobPUYSaqX0hPFgEJmmhhXn7+X0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=FvusXzrpoUpbIRurmDotbS7K6rvaOqa2+nfYfRkHbNbMfnCEPsvbLey4dNkc00KOm
	 aEigNXz+A+kXpR/8WtjENbu1U6ElkppXXSVPpwsia59KcdYJD6o2C3qotIcusHn9Jm
	 7kZHO6svdZ9mmdjNhSglTJqpu5sXluW1N5YpOsWzwLrZoJnY+GNpcOagPXMLuqJwVW
	 gC3gt2GWxCNM1EazJGQ0BxYte0D4Os3japrP7nwU/tDJOtpSP/OjWMUsPJUHOGVbrF
	 PPP6MRLrsg3MeUL/Phdz50LMzDvnNf6FX5bcDt9YzPs/pZTNsTti5Jfxkiod1byzhx
	 9dnHH8ZBTc21w==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e271acb015so11694101fa.1;
        Thu, 09 May 2024 06:55:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW15yifjC/PfqOQ38MFBt5/rassF5Bkhpo5q+2MDnL6ET0cGBXFfKS+n0KZ607oBRmdhWXZC4bXGOA8kagbtFZKY0H3F6rkFCPVm17rtfumywtQDC1VtjSdPpMYn+R/nu+p5IitS4MOSg==
X-Gm-Message-State: AOJu0YzevzN0fGp3ZdFViOlFlJkHK16xose+iIdaA3srg1lIt3uDZWUJ
	//MvgF8gxdV6sPH+xN1gCQyCgxnOhsg4uuF2pALimdyWtBoG3K1fGDu3IF+pLB1LmLmwq/YiDLV
	1FxoEXitebK4fryMHkmH0mJvBYOA=
X-Google-Smtp-Source: AGHT+IE3IRxdieZZWFIAV2yKut1U/0GAf5n97B1SmEfJ3sNacc7fuXxvGQJsEaDI4WAJQ8++usuBY9y4zk71QcZW0sg=
X-Received: by 2002:a2e:81c4:0:b0:2df:1f7c:b84 with SMTP id
 38308e7fff4ca-2e446d83c4dmr36119491fa.6.1715262930588; Thu, 09 May 2024
 06:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507041343.272569-1-wens@kernel.org> <20240507041343.272569-3-wens@kernel.org>
 <ZjxWKOoLMNQAmhla@finisterre.sirena.org.uk>
In-Reply-To: <ZjxWKOoLMNQAmhla@finisterre.sirena.org.uk>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 9 May 2024 21:55:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v66VmizAy-+XWUK3-tYyZFV6qQUdBrxPU72nFPH71tNekw@mail.gmail.com>
Message-ID: <CAGb2v66VmizAy-+XWUK3-tYyZFV6qQUdBrxPU72nFPH71tNekw@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 2/2] regulator: sun20i: Add Allwinner D1 LDOs driver
To: Mark Brown <broonie@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 12:50=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, May 07, 2024 at 12:13:43PM +0800, Chen-Yu Tsai wrote:
> > From: Samuel Holland <samuel@sholland.org>
> >
> > D1 contains two pairs of LDOs, "analog" LDOs and "system" LDOs. They ar=
e
> > similar and can share a driver, but only the system LDOs have a DT
> > binding defined so far.
>
> This doesn't build on at least multi_v5_defconfig, multi_v7_defconfig
> and arm64 defconfig:
>
> /build/stage/linux/drivers/regulator/sun20i-regulator.c: In function =E2=
=80=98sun20i_reg
> ulator_probe=E2=80=99:
> /build/stage/linux/drivers/regulator/sun20i-regulator.c:111:16: error: im=
plicit
> declaration of function =E2=80=98of_device_get_match_data=E2=80=99 [-Werr=
or=3Dimplicit-function-de
> claration]
>   111 |         data =3D of_device_get_match_data(dev);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/regulator/sun20i-regulator.c:111:14: warning: =
assignm
> ent to =E2=80=98const struct sun20i_regulator_data *=E2=80=99 from =E2=80=
=98int=E2=80=99 makes pointer from inte
> ger without a cast [-Wint-conversion]
>   111 |         data =3D of_device_get_match_data(dev);
>       |              ^
> /build/stage/linux/drivers/regulator/sun20i-regulator.c: At top level:
> /build/stage/linux/drivers/regulator/sun20i-regulator.c:136:34: error: ar=
ray typ
> e has incomplete element type =E2=80=98struct of_device_id=E2=80=99
>   136 | static const struct of_device_id sun20i_regulator_of_match[] =3D =
{
>       |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/regulator/sun20i-regulator.c:136:34: warning: =
=E2=80=98sun20i
> _regulator_of_match=E2=80=99 defined but not used [-Wunused-variable]

Looks like the patch was from when of_device.h still included of.h.

I'll send a new version shortly.


ChenYu

