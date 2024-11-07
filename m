Return-Path: <linux-kernel+bounces-400399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 001229C0CF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C55FB238CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88B21315C;
	Thu,  7 Nov 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L51dwxb8"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F2215034
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000796; cv=none; b=FW8BspUKSPkYe7TrAq61IDNXvFGNZ0VTTW06UTEmETuPlPWOph/cISknXQkJ7vGdqXRNQ24nYyLb0bLVpjh61xQw1Om7mdD2fB0RohxUOz17X1fS/FSHqvEhw41mNIPHWNoPClkfIsMyTtba4x0Sppin5dfc8QBio53ITLrPBsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000796; c=relaxed/simple;
	bh=VcLKfMSf8JP+NkMpQTEbf+RyL/1VCXYqrQtktiAyc58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulZ7IPXWt/rW+lQ6R6hl+uYSj/2PAcExzGxG5yncTOhQAqwpmkstlEXPgzqf1YA8FcOMc3LrEqTzxX7XXgaRmIsl6VU+AnPmkHH89y4B+7ARpt7B/M1J4C7qgkHK1VVo9iDi+9og8VSfFhu4LbwhcCsYmbubBOuzIOCkPbG2NSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L51dwxb8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso1004677a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 09:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731000793; x=1731605593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HftcmsOOs+Ls9qs/ilXFXGyq529PGQ4QO+JwXX/wik=;
        b=L51dwxb8wuZIoRPlBd+wu1/E8+XoQBn+3LzcBgA7wxCYnNFXdOnCpn7vGiuHDzU0G9
         6YaPfYi+lwdZeZx3bxDxELEjvM+SQVxig6c+WVq5r2WCLe43pusNlBvTyHIHFyXVGXba
         B4DysBYiMIrrp++FEsG9pBRK0vzWG8THgrDgl2PxDaxkcyJW530lSS3geVOikjGqetRW
         cJwXfQnpzUy4w5hPr96nfwYDGKO9FjmaXWKeC5Wt0S9B7e45w8mtSlzgeOjEg4PuqPun
         xTGl79KVYUlfahXuIDkogqW8plNvWlB3rQiLkIftoCy9ys44M5RY+odNoSuM5xphmnNJ
         BoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731000793; x=1731605593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HftcmsOOs+Ls9qs/ilXFXGyq529PGQ4QO+JwXX/wik=;
        b=nmwbner4ly0DvhT/odb7MULoo70TIfKgm4mXfK2NebU1qx+6kmILyBLnFAJ6w+7X1W
         rmg3+X2L4ubBw5fDYbn337O7sHsBgZcrUp9GFy7XUro1vtzYi+YNB/AcOLQjGSMfocIp
         aRvsw+eOA0lnEoRjzkWeCO+CTUaxIVr+ARINDPIJ51/OZvmKXaGI4XeTQXpul8JM0zK1
         4voSWO1a8O/9VdacoXCoJF/LiGQRp0889123Eu4pVdDz8owR/4/FtqXqjjU985CbYcvL
         CoovUWYNsDC16jdhjII2Ljt9PCjKAp9TrbMksk86zKJBLlJpnA/O/VnpIdZ30NjmqziP
         iz0w==
X-Forwarded-Encrypted: i=1; AJvYcCX0NiMBDROhOFywvG1nz2tyA9pjhwC58awWxbfyPVZDtv4FuxeZZFHGndEywjQClTyHpBYcyuCpyhilOLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+obitGn9gs0jdVe7UeddLvU8uKT5X6UYqwjDH59HLm0523Frg
	HzXLJiH2SjaQazM0aMSAIDpSj7uGpwSEO3KUWAFYwCoKPm+HI9RNUuaNFbxZpJSs10qgqcsRX1C
	liK2/s4jdpuIGnaC7mtc1fACNokE=
X-Google-Smtp-Source: AGHT+IEJ8zWmzbfoKjIq//36/+CYuY7j1PnwnpoNb20YuudbiCyf8+lGcJqZlqV568JLMcy5XcjBjUGlLD8TC4ubmdw=
X-Received: by 2002:a17:90b:2f03:b0:2e9:20d8:4147 with SMTP id
 98e67ed59e1d1-2e9b1475c8fmr54805a91.33.1731000793175; Thu, 07 Nov 2024
 09:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026132014.73050-1-aford173@gmail.com>
In-Reply-To: <20241026132014.73050-1-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 7 Nov 2024 11:33:01 -0600
Message-ID: <CAHCN7x+Mdp72oiuLb3dM+sOy7DfdVWoakxH92yxvmW3oSPNPLw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] phy: freescale: fsl-samsung-hdmi: Expand Integer
 divider range
To: linux-phy@lists.infradead.org
Cc: aford@beaconembedded.com, sandor.yu@nxp.com, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, 
	Marco Felsch <m.felsch@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 8:20=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The Integer divder uses values of P,M, and S to determine the PLL
> rate.  Currently, the range of M was set based on a series of
> table entries where the range was limited.  Since the ref manual
> shows it is 8-bit wide, expand the range to be up to 255.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> V2:  Fix typo in comment

Vinod,

Is there any chance this series could also be applied for the next
release?  I don't know what the cutoff deadline is, so if I'm too
late, I apologize.

adam
>
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/f=
reescale/phy-fsl-samsung-hdmi.c
> index 2c8038864357..412c03b7dcd6 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -406,16 +406,15 @@ static unsigned long fsl_samsung_hdmi_phy_find_pms(=
unsigned long fout, u8 *p, u1
>                                 continue;
>
>                         /*
> -                        * TODO: Ref Manual doesn't state the range of _m
> -                        * so this should be further refined if possible.
> -                        * This range was set based on the original value=
s
> -                        * in the lookup table
> +                        * The Ref manual doesn't explicitly state the ra=
nge of M,
> +                        * but it does show it as an 8-bit value, so reje=
ct
> +                        * any value above 255.
>                          */
>                         tmp =3D (u64)fout * (_p * _s);
>                         do_div(tmp, 24 * MHZ);
> -                       _m =3D tmp;
> -                       if (_m < 0x30 || _m > 0x7b)
> +                       if (tmp > 255)
>                                 continue;
> +                       _m =3D tmp;
>
>                         /*
>                          * Rev 2 of the Ref Manual states the
> --
> 2.45.2
>

