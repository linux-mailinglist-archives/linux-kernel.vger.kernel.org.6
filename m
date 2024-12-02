Return-Path: <linux-kernel+bounces-428076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF79E0AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A9CEB82888
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F011DAC89;
	Mon,  2 Dec 2024 17:29:32 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFC1D9A78;
	Mon,  2 Dec 2024 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160572; cv=none; b=OUMMhvmICqa2GMmBs8J7l+DkCe4A85qoiw26mp0KS0/ePSlSIhrkGMRAknB+Q7dDZitEMWC199qe3JAVP0eLrUBAWPgWRaLTL+EwiGDBXhbklkHhOcVy1Y9zBfCB6QQPAjsCgC+Z1COnM7Afx/Y3tgEQ/3zniU2cAp0m9nmEsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160572; c=relaxed/simple;
	bh=QOQ+erHT4VXZq8nXOWd4czcnijmv3x7ttdi40L8gVbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2tW+hNgibcdnPij1LTmhoKotoHzma4hrYqljf6WvIs/hSngvJqwg3SU++c0a6HG7b4BdRS2hQX/XqMvGCAh1hMNeWBnE9pjiwqKp4dcvPFuHmFIACsMrQj87VtmWug00GbZRRuw0oeD4Sv2gNXwSKz9aZynJEy8ZvgPfmEPBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a68480164so630901766b.3;
        Mon, 02 Dec 2024 09:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733160568; x=1733765368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgvuKCN7J6YpKVI1K2eRbzWN5UKOCpkxDwdsMytbnaM=;
        b=LovzK/8yfwLDQyw/Y37DFPd+EJsj6gZal/pHsQ90ylPZ3aD5yEF2LE41am99BUfPdr
         ZRwss0r/chD1IkD5w/GNWmfpCRIp+fvp/hR/ykKS/wMuLRU7DY5aznAToIfNLF6bQsZx
         QaSFl1+z8s4wiXRJ4omwV5yzW1ngFSdhnD2aJmwSMb9M0+9KTRbz3u/CNtPQQReGocMU
         eTdf8G3Sk3cE5xwv3sXhM3gjniaBhJHODos5YtfvlSffhqj1NfeT8mmYnBLwIGBT9i4M
         cHYUsm+ooFfyDx0yHpdrsGuNHj+BMWAXE00QsOaqhLg0outAQn7ebwu+XRSiKJhauNZI
         zHDg==
X-Forwarded-Encrypted: i=1; AJvYcCUjWLMMMcg4COFD0t64jCZfJcK/lzw4Ed8Orao4nVee0eWu2x08y6cejP4I5kR+JhNxz9OxPuIzZ1wrHQP5@vger.kernel.org, AJvYcCVjvPH/PS+e8Ow8Z28dIRnb6AlIu8GV7rGnmVEJUBa7W22oQffbqaDg9IVgoi3MJ0EcZcwEideCw6VX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34Q/nyDL8PetC9TkKjp1vBC3FbNzbIyqxd/2L7tmpyR4TVClH
	YRzTUL3jnAgWUGRxrs/t9bz6EPOoVl8PvdFApaGdgzyVYSpIaaz8q0na79yD
X-Gm-Gg: ASbGncvzg4kl8HiLFgM6vqhK//H+i/Zjh5hXPmlv1SgO5rHUWzVK4l3rhJplNXV2lxK
	qfCvQWUDFtSR1artpfhd4awpWoPQAB0W+gkxkBSBwX55I0sqI/YSIeBl+62RljPk6FiqylaIqbF
	4Gm+jp5s52I8vH7jwq3PN4D5njeOFNj7t59Mds57nnLvvBNSHrDVmB/PlhTXWJq1I7slF1fGroi
	XpMhLcN3XkTRSI9Hgn0Rdlm+dREme7/8NHLdqNj7Y1bC5gk8g4wp5iEpsfMeX+ttdS+mvGP7ARS
	RWxW
X-Google-Smtp-Source: AGHT+IEc1tDCotDx2/Yk1SYdAKvcozPAa2ZWBTRAmdp0lcsIUgUZXQM4zrZc5g2P04VdnqlZa+7HxA==
X-Received: by 2002:a17:907:75d0:b0:aa5:3631:adcb with SMTP id a640c23a62f3a-aa58109066cmr1780274166b.53.1733160568118;
        Mon, 02 Dec 2024 09:29:28 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e649csm525879966b.110.2024.12.02.09.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 09:29:27 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa5500f7a75so733200966b.0;
        Mon, 02 Dec 2024 09:29:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGL30TI2P2nKiTyzx6HbK5SkmnNJ0DKA6jFL39nbXFKAwHGQ3KBahia2G2kSsDx9cg6aNk5GKWUYmz87JZ@vger.kernel.org, AJvYcCXhHfIINBx/4/92FiPhGcyC1OZLrRHPLgpbUAgWN10LGArD9XRkzYmhZDAi6AyShKx05uNEi+BPbE3D@vger.kernel.org
X-Received: by 2002:a17:906:c383:b0:aa5:451c:ce25 with SMTP id
 a640c23a62f3a-aa58105895amr1847466266b.43.1733160567637; Mon, 02 Dec 2024
 09:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-asahi-spi-dt-v1-0-907c9447f623@jannau.net>
In-Reply-To: <20241127-asahi-spi-dt-v1-0-907c9447f623@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 2 Dec 2024 12:28:50 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-3w3koiqnAOMQO4RZ2DB+fRiSbZJSba-Z=L8OCF2B0Pg@mail.gmail.com>
Message-ID: <CAEg-Je-3w3koiqnAOMQO4RZ2DB+fRiSbZJSba-Z=L8OCF2B0Pg@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/5] Add Apple SPI controller and spi-nor dt nodes
To: j@jannau.net
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 4:52=E2=80=AFAM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> This series adds SPI controller and SPI NOR flash device nodes to the
> man Apple silicon SoC dts files. Only the subset of used SPI controllers
> is added. Five SPI controllers exists according to pmgr ADT data but the
> commits only add controllers found in use on any of the devices. The
> parameters for the missing nodes are guessable but there's no point in
> adding them since no further M1 or M2 devices are expected.
> Together with controller nodes the first SPI device is added. All Apple
> silicon devices connect a SPI NOR flash to spi1. This holds Apple's 1st
> stage bootloader, firmwares, platform and machine specific config data
> and a writeable key-value store (nvram). Expose only the nvram as mtd
> partition since it has use beyond exploring the content. Tools from
> asahi-nvram [1] can modify the (default) boot configuration
> (asahi-bless), read Bluetooth sync keys (asahi-btsync) and read and
> write arbitrary keys (asahi-nvram).
>
> Devicetree bindings are included in the driver series. Last version at
> https://lore.kernel.org/linux-devicetree/20241101-asahi-spi-v3-0-3b411c5f=
b8e5@jannau.net/
>
> This series passes `make CHECK_DTBS=3D1 dtbs` with the spi bindings excep=
t
> for "local-mac-address" for the Bluetooth device (I need get back to
> this).
>
> [1] https://github.com/WhatAmISupposedToPutHere/asahi-nvram/
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Hector Martin (1):
>       arm64: dts: apple: t8103: Fix spi4 power domain sort order
>
> Janne Grunau (4):
>       arm64: dts: apple: t8103: Add spi controller nodes
>       arm64: dts: apple: t8112: Add spi controller nodes
>       arm64: dts: apple: t600x: Add spi controller nodes
>       arm64: dts: apple: Add SPI NOR nvram partition to all devices
>
>  arch/arm64/boot/dts/apple/spi1-nvram.dtsi      | 39 +++++++++++++++
>  arch/arm64/boot/dts/apple/t600x-common.dtsi    |  7 +++
>  arch/arm64/boot/dts/apple/t600x-die0.dtsi      | 28 +++++++++++
>  arch/arm64/boot/dts/apple/t600x-gpio-pins.dtsi | 14 ++++++
>  arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi |  2 +
>  arch/arm64/boot/dts/apple/t600x-j375.dtsi      |  2 +
>  arch/arm64/boot/dts/apple/t8103-jxxx.dtsi      |  2 +
>  arch/arm64/boot/dts/apple/t8103-pmgr.dtsi      | 18 +++----
>  arch/arm64/boot/dts/apple/t8103.dtsi           | 68 ++++++++++++++++++++=
++++++
>  arch/arm64/boot/dts/apple/t8112-jxxx.dtsi      |  2 +
>  arch/arm64/boot/dts/apple/t8112.dtsi           | 44 ++++++++++++++++-
>  11 files changed, 216 insertions(+), 10 deletions(-)
> ---
> base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
> change-id: 20241101-asahi-spi-dt-58245bb1da3e
>
> Best regards,
> --
> Janne Grunau <j@jannau.net>
>

Series LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

