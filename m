Return-Path: <linux-kernel+bounces-431329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7825B9E3C0C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9C8B39883
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110FA1F7590;
	Wed,  4 Dec 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBi/Sh95"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230A1CEADF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321020; cv=none; b=DLkaqm3s9dE6PzMOTCyZsO/JSgOeogyWPK0ACp/PnYrNKTthRMEq9J0pvBHGN/pqnsvWLicHk3nvM9tF64nUERn6DhPo0PEvZWDLrEwFrG7T1rRuufYyoTnvd0o4nfmaPH5W4bbdIoshluWq+g1TgubCRGc4BGBLPQe9YZyZbDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321020; c=relaxed/simple;
	bh=VG3jhj+5o+M0i+c1fMNGmSjOsObYEQMl2enztBpnOoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTTau1EjX+oaq17j9+BpZznAhDsRCTuCGzLrJ0UPHJpDZmVXFMEyoJJEbvg6TFBwwDFmlERxTWG1OQjdeAbh7ZMljnuf5K1gyfLhk673BDKotGzZ4lut806BTDpzrl0AsMS61UNy3bxQOGDfUv3nzuQV/vbK86yYMsjMXF4mUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KBi/Sh95; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53e1be0ec84so1546784e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733321016; x=1733925816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzW/JtCH00KsxtW/vWSFPSj4+ptoInfVhNf9UaERk0U=;
        b=KBi/Sh95UdPxn0Vv6qX0JyGcosuD6VJ4dHrOhzjEIgk1/put45aODfwjQTM2SMsSsT
         lvChmNv2Xo53rV8P5j1w1R1llMLJcs1tiJS/uFHiKp5XCxbBnBBdbmFb7oCgUVWD+Qmi
         ojv/Zze/sirtuwpHFKFpw+/KEKL7c+ZIevRa7UXM5aT2/hOz2eDYZfSw170c2anO484/
         gBaWbZfMFIHFqH+BWuA8893I64rpFXLPu+SG71FS5n5A0cSkZB9hSs6k6D1QQv/IyUk8
         Lw/A/QoInCrz11PpQY2u5mEd0eu4fonrM9tsbV/novTT6L3Olm/Jf4lknI3N3/pKNINg
         h8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321016; x=1733925816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzW/JtCH00KsxtW/vWSFPSj4+ptoInfVhNf9UaERk0U=;
        b=QACAozx4UopO4FENwkgkrzhb/lE0MXFRuZR0h2TXK3eTNToJT9cvrvPoGV4g2hwd/E
         6G2uHuTobWbGAc32Z4G6Dzsp1mje+pvhei2toEIav6qPKM8PF+2dIjLqWvq9xG8Fzjzl
         mi7j5C2n1x/Gvh2k2ykprPgg9u/G84l3BEjzDTrQnB5zlkw9g1qCjWbc9UbRGGmIY0QO
         D+QT62QoYORRM/DvTUraj/Cysmu302Up5BpPdhPvp9uDDfTmeGMqTi2G2RzrAE8PifEY
         flcUWG+2P6HKLTpGTALylIyg+SOzcaEpeYtSsh5P96hZl/SNwzeVlguTTogSVIoKfw/a
         QuvA==
X-Gm-Message-State: AOJu0Yy1gcPYEbSR1i0OKUA3pt3k0h6QvQXRh2z3q5UbgP7aBNTVJUm9
	SfZjGUb0V9Mt+8gEFBJwiSIj4a5OOpcnLhGbtasr8xdM2hkh0m/gHAIoyvJ5Qpjuy1TrkaCOve5
	Mfz+KrOKD6eQ6V9qUdh1SJXx2S2YjRnxUdAsc3w==
X-Gm-Gg: ASbGncsfCOCOTHkWy/XzUOsQtmSYAMy27Kmu/hOdlFmf4SfvLyCobTDXSQXtfjSG703
	rRpC1yPSRSxy7DghoLP5x5t8VRgsDWQ==
X-Google-Smtp-Source: AGHT+IEt8hy//Qrsq15lWQdoGs4MkH3N9p07ErAD0IhQ0ETz6672nArlbxKict87HTx275FZUH7Fy/W4YCbrdpI9H28=
X-Received: by 2002:a05:6512:3da6:b0:53d:ec93:5a9d with SMTP id
 2adb3069b0e04-53e12a3426cmr3864178e87.49.1733321015399; Wed, 04 Dec 2024
 06:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204102904.1863796-1-arnd@kernel.org> <20241204102904.1863796-5-arnd@kernel.org>
In-Reply-To: <20241204102904.1863796-5-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Dec 2024 15:03:24 +0100
Message-ID: <CACRpkdYN0b9LqpPzrw1Xx-A0sUzUhjevT_J7S-sOyLE7Aeym2A@mail.gmail.com>
Subject: Re: [PATCH 04/15] ARM: deprecate support for ARM1136r0
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, 
	Ard Biesheuvel <ardb@kernel.org>, Daniel Mack <daniel@zonque.org>, 
	Gregory Clement <gregory.clement@bootlin.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	"Jeremy J. Peper" <jeremy@jeremypeper.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Ralph Siemsen <ralph.siemsen@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Russell King <linux@armlinux.org.uk>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:29=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This CPU revision remains a special case as it is now incompatible
> with CONFIG_SMP. Only the Nokia N8x0 is used in practice, and even
> that one is fairly rare these days, so let's plan to remove all of
> them after the 2025 LTS kernel release.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For:
>  arch/arm/mach-versatile/Kconfig |  5 ++++-

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

