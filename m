Return-Path: <linux-kernel+bounces-349021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5998EF8D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665141C2104C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4933186E3C;
	Thu,  3 Oct 2024 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMBewtC0"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3D1E49B;
	Thu,  3 Oct 2024 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959540; cv=none; b=CMJnEfKivhtGf4eQB+5YNnVp9+DWeV7DSy2TEXTy7YGnpUJiGlUjxvvwV6oS7BazvE/m8nspZ4eRx1larxYpYfbToEH5uIn3nK9EZYW/M841UTwmf88B4jv1SP5mhf5D1l67XzmojG27mP+Do2Zao3UJAC4T1ERV+kUVeDfxPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959540; c=relaxed/simple;
	bh=h8glWa8FKBKj3nCk6I+JgRJLRZCrCXwBgF2+dYsvdM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9onHK//dRYcPrrrmyvEFoeJ7yZaLsm3QcEQf8DRqdO/EUYynRxI6ETBva+UxLMiyPUmJkZhCc97nFQuMCMwRFpHJQwAJ/C7VU/uP7zGcYlCBasZEeSacs7VUDqJCokEqfXYGOc8pKtaRD0mAbiLYFhstdUknUdLAPXnHCJU3A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMBewtC0; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fad5024b8dso11708781fa.1;
        Thu, 03 Oct 2024 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727959537; x=1728564337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8glWa8FKBKj3nCk6I+JgRJLRZCrCXwBgF2+dYsvdM8=;
        b=OMBewtC0141O11YmIKxta4kytxFFJXVXUv5m1QcP2QjUNG7WAnKW4eGq8/Z5wGY/oW
         9WUjXu5f8Ik5FEbqjsOALuRertbNGt5IYGOINePwk3c9gvtATPQTrhDN5bYJNbPH5m0U
         tPHBNDsJcEAjM9Gt1l8lfM7lJWWSZDQmMPz4CeXoSfxIlVb8rO57HckzRNYkvkJXfBu/
         nf9xAzUnmV38zxlf3NTVcPi4piYw19hBcYIPgWM58OPbWHHbQ0H2dcJ1EvvcJbVDL+Id
         Aj2iAwqztq8QKIzLcIIGAJ72+mGEnA0BcFzhEHyX8Ah06R87gFXwZuH6g8iqgv1kMiGp
         OZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727959537; x=1728564337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8glWa8FKBKj3nCk6I+JgRJLRZCrCXwBgF2+dYsvdM8=;
        b=Rwm86ho51ZglQ5RpG+rftqMmP0hUmP3qqjfi0lmKGULp8l4GHqshWF1NbATWdCgEWa
         NzKsu0F0s6794kJiztEmkZufOFk+oOsclFJA/nJ3T8cz5Gqrf+3REa5nziGIRVBHCvTT
         4f4IXYYBQ/6baQKsW6vKQfmddnKbXJuytdNGLyDeNEoeiuT/OxR9SZnlE6DA0TIbs2+a
         OjNUYfeaL5uuuw9z1QZpb86IPkD36E13G0ISk32iAuSHbagFqKOWK25CBghlAjAKEmdc
         ja2/bCwRglQ2Ay/U6ebfiBI8ibGg7T+BnOClMT5KAEJaAqSirR74l7mJc/hT5j1Vw93I
         u/WA==
X-Forwarded-Encrypted: i=1; AJvYcCVzfirzXSWffHfffPEPWh9X7yRY7RZjz9Xj+6Q/gx3w6MI182VvWdBHo6uCPCJRIrclmQkkLtwo/3UT0ANv@vger.kernel.org, AJvYcCXHtpWiXy4WAXyfL9A6DDmLCDon9qaCoLY5vat0d16qGNYgp61jt1edfe6xGlUcj2L9lkXy1alWYjSh@vger.kernel.org
X-Gm-Message-State: AOJu0YzYbluxwp+qva8cZ9xji81nr4Rn0GynwkRWoSs1Tchw9WEA07z8
	9UVi10J6E282HgqEJKNT+iiH+HY+MTy+C9Oz4h5tyAWTCoQ7idwQkcGIm6ll5KdMlqFqX04riSh
	XLryDUTVvtsXc9SQd8LtyDUGgbtc=
X-Google-Smtp-Source: AGHT+IFH/d91ETaLO9wS69JBdZtdkMi1nBG0J5JtGXgyo3Q1FiOyG+AaAEmd/z9+6SFqLvAFdUJ6gCbWcbyQrmqWuPc=
X-Received: by 2002:a05:6512:12d3:b0:530:aea3:4659 with SMTP id
 2adb3069b0e04-539a0658b50mr4221107e87.9.1727959536381; Thu, 03 Oct 2024
 05:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002204750.597337-1-Frank.Li@nxp.com> <20241002204750.597337-2-Frank.Li@nxp.com>
In-Reply-To: <20241002204750.597337-2-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 3 Oct 2024 09:45:24 -0300
Message-ID: <CAOMZO5CDwN32kiPWQ+ObNiFD1Wewj+qyTUMCRhyXKq941phAkg@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: imx8dxl-evk: Add PCIe support
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 5:48=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> From: Richard Zhu <hongxing.zhu@nxp.com>
>
> Add PCIe supports on i.MX8DXL EVK board.

s/supports/support

> +&hsio_phy{

missing space.

> +&pcieb{

Ditto.

