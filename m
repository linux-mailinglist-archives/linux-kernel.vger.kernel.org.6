Return-Path: <linux-kernel+bounces-251876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2AE930AE5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67EEB20A83
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8302413BC3D;
	Sun, 14 Jul 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IahU0CBv"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA64139CFF;
	Sun, 14 Jul 2024 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720976568; cv=none; b=SALIBQ9tUgqeCgCYQGnlouL/ajgvQp4zGt0rPlrjFtYeD8bO97gU4lZeGlfB25vb71NSoWfeScf92DRI9PHJJaADmswGANoDnvTG/7Y/XYZLIQwSSNocXlWMPHIzY/1xAzBgNoe31bkzUwg7+KX4PkHnMd3ekfVIngEE9ip5tnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720976568; c=relaxed/simple;
	bh=imFGudE0abTwx4msHdDYdZAoZLvRkFY2Ru5F4Y8JOZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRE/3ZesobcPDcTGaIxvGnMkrRUal7W0KJRAOuOP3I0eUqxAhal6chIgXZtNng3/tcdKWFuNTdI/TRVb6T5zURUPHCHs90Gm3osFI2KwC2i56b9Q4VTed0FH/TAZDGwBj8hcTBmb6112o0GUMDurvz0i+/xPXb6Y8zyuME8rz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IahU0CBv; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-765590154b4so2030055a12.0;
        Sun, 14 Jul 2024 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720976567; x=1721581367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2F80DyFNnpYsHP7zwJV9lSVbXe9QpASbGWUomP7AEo=;
        b=IahU0CBvoV1sB6ufuN08G61kR7kVHas8tHrgVTC1oGsnBxgo6rDrwHh/sDp95znBhT
         iIs3e9RA3S6bmyRQruqhfT4WJIZGASpc2utx70gV174HgFneUHcRBUQTOHAcdtDG1pzB
         feVrJWcefRdYgrj4qcafDAjKQ2buIBbgH58JbOaL/+AJlwDnJLURvmX5uIT/G1gOUD3U
         oOTphhEjEEUOH4vM16EyfSiRyftDadVv/4bHUdYwpvkIx8IEw3nKKYkRsxPWGKEmqFEB
         leNCrPZ+adl94pSfakQZTOkr8RD/ayWXl51MoMG9HXarxdvqzo26UI/Ij5EdyrEwCWMW
         Or8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720976567; x=1721581367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2F80DyFNnpYsHP7zwJV9lSVbXe9QpASbGWUomP7AEo=;
        b=G8vAd2iTh0IFbmHRjFHdt6JTymcLGg2KqW5qYpq19QnFOFmxJ3a8YE7cc8q/N/7Iyr
         jBoMQmlA/uOLRPwwZf+zcJwcaGTOOyOrskfSz7ULfQ0iw1B6tYkqDsq2T4x43//y1GSd
         6/bX9zMoNX08xHoVQC0MhljJvCYx2HOMu3OGAjX44qOn7szPa8MwoIDui4IoXn+rQIGn
         aiJxZEZjaQOUddu4EZL7GuePvaUbB/lXbB0HxtqktqPcLPLj3YJ3Ggvf5qHgFRH/73hf
         MACbHPZ7rWwDT/cXl1YtnYxwS6RSsZFUxGPMs+mSZP32NDPxNsK829xnOzxh7HwLD9EO
         SIkg==
X-Forwarded-Encrypted: i=1; AJvYcCX7I4QJ0/qDqFwWkCmTzyFZ3Bjb7AprYz/K7MOCoPnLZhF3gZB6M82poyhMHAjZUn7Ggdw0CR1UdKl1gY40o/vMb2JC/M1bLqjdR5NARFxBtkNuYbCLRsUHIgjk3P6q40ldmaJJYBuW
X-Gm-Message-State: AOJu0YyhbfJY2txDSpt39b/RZu1wg0NFAVri4RKD1MMugE0mYKPHsML1
	cj8pB3J2lYdNxs7IDttzXK5B2ZDfPrxMM/Wl17E9J9Mq7m9j/iN7OT5QsOZe12w/2PaJVjpJFrm
	C8lfbONDVQ3Mp0+S57aBo2WeisJY3jA==
X-Google-Smtp-Source: AGHT+IGHPlz4JVnrclkH/s8T8rzAqvI6Kcvne8QSso/Zp8ZfFWs0gedBWYKbzhNBAFNfq6Nmba+ZrZyBPvatXfS++P0=
X-Received: by 2002:a05:6a20:7f87:b0:1c3:b210:418b with SMTP id
 adf61e73a8af0-1c3b21041f3mr11115631637.52.1720976566543; Sun, 14 Jul 2024
 10:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607133347.3291040-1-peng.fan@oss.nxp.com> <20240607133347.3291040-6-peng.fan@oss.nxp.com>
In-Reply-To: <20240607133347.3291040-6-peng.fan@oss.nxp.com>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 14 Jul 2024 12:02:35 -0500
Message-ID: <CAHCN7x+pzcdwSq19LefsyYAPUp8=kQYJeVbHm9sgSeaKXigMZg@mail.gmail.com>
Subject: Re: [PATCH V3 05/15] clk: imx: imx8mp-audiomix: remove sdma root clock
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:28=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> There is an issue:
> SDMA3 can't work without setting AUDIOMIX_CLKEN0[SDMA2] (bit-26) to 1
>
> The workaround is:
> As the reset state of AUDIOMIX_CLKEN0[SDMA2] is enabled,
> we just need to keep it on as reset state, don't touch it
> in kernel, then every thing is same as before, if we register
> the clock in clk-audiomix, then kernel will try to disable
> it in idle.
>
> Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block control")
> Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

With this patch,I found it broke the imx8mp-beacon board when running
audio through a codec connected to sai3.  Reverting this patch made
the crash go away.  Is there a way to mark the clock as critical so it
doesn't get idled?

adam
>  drivers/clk/imx/clk-imx8mp-audiomix.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-=
imx8mp-audiomix.c
> index b381d6f784c8..88d8ba975b5a 100644
> --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> @@ -172,7 +172,6 @@ static struct clk_imx8mp_audiomix_sel sels[] =3D {
>         CLK_GATE("ocrama", OCRAMA_IPG),
>         CLK_GATE("aud2htx", AUD2HTX_IPG),
>         CLK_GATE("earc_phy", EARC_PHY),
> -       CLK_GATE("sdma2", SDMA2_ROOT),
>         CLK_GATE("sdma3", SDMA3_ROOT),
>         CLK_GATE("spba2", SPBA2_ROOT),
>         CLK_GATE("dsp", DSP_ROOT),
> --
> 2.37.1
>
>

