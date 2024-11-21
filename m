Return-Path: <linux-kernel+bounces-416902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE209D4C33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF7F1F22DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18431D27A0;
	Thu, 21 Nov 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXJJsP+W"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB00169AE4;
	Thu, 21 Nov 2024 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189630; cv=none; b=u8Tsfi9JzvBATAyB2yi4EApk1D65wfIyOpkumIya20fovXJvQzfr7j9w13Ma9jWlZMxycXYmOAIGCPI34JHtup/Q4/utXpta39Sx+cNM9sBlKCCbi1E0160dr7S/lsFSndrF7FDCdSzUu9Tsv95vHQJKsvvahrJz7GqYMqdEPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189630; c=relaxed/simple;
	bh=6tBTumqtBmtyr65OhXGkI6NGqtaXNa4Lrl0W95sKHkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7Q0kTvfCy4Ls4BvqcjxHQgOoif+cU/W35fgiohPvUswhKX5lc1nvUwMFZXVnYv3q6B22oR/hMuVtkRTxgnz8qwJ9t4HzKZE0fDt2F3fUni4KGtamjoSY7EeZJSlL6pcgOz4ZCEOruAdyuzkRQI5RwQMAPKh3WoJh71GrBZQdnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXJJsP+W; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724d23df764so290857b3a.1;
        Thu, 21 Nov 2024 03:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732189628; x=1732794428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oKpoaoKlTteKRfatjC6kRGeLlyxZzmGL1dkD3YQ10E=;
        b=cXJJsP+WYxgihrO1X3K9OJYQtmIU3y4LyK4OdsFzRS9demiELZsDYAbiLaMR+kaqz9
         GmIlTddoOdGX6WXEYlp8EhNUCEJLQOK/CCJHEEuhx9yXnExFIrisefBESvwOHffwCI7l
         27FhEu5qolahxk+fCDT7YtDj575AJHhVa0K8QkLnlmMJ7rfU2Ry2JGR2ye5Zp6x5zw9F
         kyz+s1yejm77wjNUAwqePiXQSYF2CpJ1cGV+kDPwQMMz4soeKxLQFsoQiX3/8CdH34sr
         IrzmmyeTdhHso25/UndSx7Rp7Naok4PcOotQz67tOzKw0sVssWoE36AkJ2aNuGOMCEn1
         wY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732189628; x=1732794428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oKpoaoKlTteKRfatjC6kRGeLlyxZzmGL1dkD3YQ10E=;
        b=FLoNeYtrXEF9gHEbCPOdIQpQF0S/GW4j/F56qfUJVVd2GNXHvucWHsJ/YZdF1XuoUB
         Q7ZfAGwxPR8Jj2/Szpd9Z20Qkrf9g8B1QJJUQbxcVhDYyXijBV1CWTuy1czvGfb8Ceu4
         uEXneWjQXPufbR79R7JHGaxq8ZSZg3HNMuqy95KDnSkoeOcm8N4hSf5EpERouSCjWQB6
         eE2HjQDPPUaDnvu3deHX2iXOBBFaRcgHzo+W3YC0uemo70yhag3Kp8ezvxTNukHyjz5C
         y0rxIrhYxG2s0vzRWjcFku5ZVCQ8P+/iZlV+cSWRnpA0PPl1PhtKbyD6Dg8FbJK3sJ/w
         tAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZivFXROYBmrePwS2Mmzo/MyGjT7YZ5UsNQdhLC6mADfCifPkQNO1+3wbBQqgWzMBfD5RZcIgTR4QDFR4@vger.kernel.org, AJvYcCXjmDApHNqsLJgloPdPq8Jb2gcUEKLPGXbyqZjvKykMAGY1x95NkIIoSyQvLI5HduAK4Hq0yxqFeZZX@vger.kernel.org
X-Gm-Message-State: AOJu0YzQXy05b+vPDwqoknM78q+aHaPAwCdLk5BU8pnWaQ/nG3C5Fj7+
	C9yF3NnKOFR8VLaL9IldGTMTvEPhcHKHXJZkJPqOCHoA1fZ9rU+2buPhRPyC9I3E9MjGd0nUx5Y
	QJFIj7xJgHqMRn/9RxbcUMZhtJ18=
X-Gm-Gg: ASbGncvtApZrTCq3cT8FlGesZbyHdxKQNaRyKrzS+U8aO3CpK+OvYvhWdt29yM6TdNC
	NsXI84Qh+R2o7EAeZjZameeHTF2Cc
X-Google-Smtp-Source: AGHT+IE2h2M+qxLCspBarhNsj5yqwS/EMhkBWxXjcDD9u0KTCey5QLScBBICtmjBrds0ZAtA4MlEHX5fwedUO4F3uCA=
X-Received: by 2002:a05:6a00:2284:b0:724:5d26:d904 with SMTP id
 d2e1a72fcca58-724bed2f146mr8063161b3a.18.1732189627973; Thu, 21 Nov 2024
 03:47:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120135859.3133984-1-daniel.baluta@nxp.com>
 <20241120135859.3133984-5-daniel.baluta@nxp.com> <DB9PR04MB84616B3F5A76AA1C588DC0ED88222@DB9PR04MB8461.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB84616B3F5A76AA1C588DC0ED88222@DB9PR04MB8461.eurprd04.prod.outlook.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 21 Nov 2024 13:48:11 +0200
Message-ID: <CAEnQRZCSvOE5jQtSoL0xGJNpx_94V29TbidR8iSDC5jOwy6xQw@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: imx8mp: Add fsl,dsp-ctrl property for dsp
To: Peng Fan <peng.fan@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>, 
	Aisheng Dong <aisheng.dong@nxp.com>, Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, 
	"S.J. Wang" <shengjiu.wang@nxp.com>, Iuliana Prodan <iuliana.prodan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 1:33=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH 4/5] arm64: dts: imx8mp: Add fsl,dsp-ctrl property for
> > dsp
> >
> > Audio block control contains a set of registers some of them used for
> > DSP configuration.
> >
> > Drivers (rproc, SOF) are using fsl,dsp-ctrl property to access those
> > registers in order to control the operations of the DSP (e.g for start,
> > reset, etc).
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index 41ff40ab5da2..fa4ff75af12d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -1616,7 +1616,7 @@ sdma2: dma-controller@30e10000 {
> >                       };
> >
> >                       audio_blk_ctrl: clock-controller@30e20000 {
> > -                             compatible =3D "fsl,imx8mp-audio-blk-
> > ctrl";
> > +                             compatible =3D "fsl,imx8mp-audio-blk-
> > ctrl", "syscon";
>
> This requires binding update as I recall.

Yes, indeed. Will update in v2.

