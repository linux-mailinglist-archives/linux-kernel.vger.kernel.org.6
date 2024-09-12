Return-Path: <linux-kernel+bounces-326547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 716429769D1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012961F23D10
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976E71A724B;
	Thu, 12 Sep 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/RDDuDI"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF851A42DA;
	Thu, 12 Sep 2024 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145907; cv=none; b=eFkWd3EIIWOvE/8/7qM5lydsxGOx5WAdetpSUobMtVtfQwbsRh4ZO3bY2kz77PgtXF97nM8C2j/ng/9EUTOrnzPKxO5dfvN5j3mLstg9MWBL0z/pmkuargzODBmUUNsrk+DesRJ3VQ/dZ9RfmmEF4zgZk3S6WSE6MRObYohy2vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145907; c=relaxed/simple;
	bh=Zf2NtJUpwYD5snIo/AsUgPKDi8M6UMCbldAg5SjOo64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IioYufLJu0ncroADKCxeA0dGoNKTLNBbs0nXiGcb//Taxqy9uwG/a7/goM5FJ0/SZ2WgPCNU2IZpEyV5rbzNjsBDoSWuy63bsbj9Nk/sqlqk46tc60AH3WJAoE+OcHm4jca6MsmzuwG9bnHwm3A5sHSqSWJ69s9r/M8f19Qjl5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/RDDuDI; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so15103881fa.3;
        Thu, 12 Sep 2024 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726145904; x=1726750704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIbsyuY+/Fd64nE73gFcftmzYbv2YfAEW+UcUNjAW2w=;
        b=M/RDDuDIiigZMhujkSKfQfb2yQPwR6dlzDWGeahpLiYFc/ju0tlKGOGPtdz+NcEUTI
         coodPoiEiQM+VVtoskGlUKCl6iP/9bzbdQ+kFMLhxVf/akIs8xOvgbl6r7hBPSzcVnQy
         Qo2smCS4qSGwSLQyto6CuwmIGDrAGX12CR8xg4eASieEr8/ksyHZtxInCKGWssY4tRMA
         F43N6jw8I1XaoSEiedkXE/rp5/C0WT6aBiK/O+C0Xj0dgKGiYSH6hCo62nCi01WgMWER
         To4SqKz5wjrHNX72ExQYmegUbYc5qWdXkmZIhSZGHVsI549o6WbWxt1zpDBZHhUSMyFp
         ppnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726145904; x=1726750704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIbsyuY+/Fd64nE73gFcftmzYbv2YfAEW+UcUNjAW2w=;
        b=HacHmDfV6PI2x5kfJQ9KrixdnsDvZxipQJSvNXdG1RToMzX8IA/a5QfzLqvnSp/caR
         V19g0NwpJbAOsfD26PRS/mvdKP+Em3EAECvYcrC/etDcw4bIvraAWxLd0AAv8AGwSZIc
         /72UeEfrzXK9Hm8iL8TUs2eXCffgATTyhm+vmA/0Ma7QejlIpi+VR5M8DpJrbC0Gyl6c
         i5p5wqt7pGID71C01p27ykgTG8zG4sNeO5Qbi6UlQoTFyBzD4j03rbDFidcgTUm9n2zh
         JMWL7X+TtbipBAn2WinaP8LPImC07mqYaOFo0qQMRd2uHzfIXdSA0Qs8jyLUN55Kfnbo
         C7HA==
X-Forwarded-Encrypted: i=1; AJvYcCW/0UeAUKpsBHoYRcksuxFZIF9nPsF0rvBPn34eKA/0hDxYO3HfOfACssP+4tlld9Q3HeNN062AzK/exnFz@vger.kernel.org, AJvYcCWd9sKMImtyAaIxbfeiYExK0uDs+1/qf+P/0Ec7qiqLpCrVLSAE18HCh9TeeSvb4uFMHuwniHJLi3e6@vger.kernel.org
X-Gm-Message-State: AOJu0YyKu+DWWVG3KG0lSPF8A77s0et8cj5NXpKMwSz1JeDSL8K6zahR
	Sqh/I6MKIkIFfU0hemHnhQOK1G5QKGMIxMRAabmWJLoa084lhS38gP4DpHK43UWclciHEJ3qk2p
	naQTWn1lV6e95+cpqpaVvV1284VI=
X-Google-Smtp-Source: AGHT+IFM68wbcXf2X68m3LTOeOkZlYjRUvKjNWgDRGS8XBSP46AciYHZtXzlDzAEs025X65hBSTsFXnA04ltuxdk104=
X-Received: by 2002:a2e:b8c6:0:b0:2f7:4e61:38b4 with SMTP id
 38308e7fff4ca-2f787daf861mr23555431fa.5.1726145903455; Thu, 12 Sep 2024
 05:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912124825.2528984-1-lukma@denx.de> <20240912124825.2528984-2-lukma@denx.de>
In-Reply-To: <20240912124825.2528984-2-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 12 Sep 2024 09:58:12 -0300
Message-ID: <CAOMZO5DJ4=ARZEcq+vbisA4kJBg+WFkH3G8-hYDkL82GQBEPBw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dts: nxp: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Thu, Sep 12, 2024 at 9:48=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wro=
te:

> +&lcdif {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&lcdif_24bit_pins_a>, <&lcdif_sync_pins_bttc>,
> +                   <&lcdif_reset_pins_bttc>;
> +       lcd-supply =3D <&reg_3v3>;
> +       display =3D <&display0>;
> +       status =3D "okay";
> +       display0: display0 {
> +               bits-per-pixel =3D <32>;
> +               bus-width =3D <24>;
> +               display-timings {
> +                       native-mode =3D <&timing0>;
> +                       timing0: timing0 {
> +                               clock-frequency =3D <6500000>;
> +                               hactive =3D <320>;
> +                               vactive =3D <240>;
> +                               hfront-porch =3D <20>;
> +                               hback-porch =3D <38>;
> +                               hsync-len =3D <30>;
> +                               vfront-porch =3D <4>;
> +                               vback-porch =3D <14>;
> +                               vsync-len =3D <4>;
> +                               hsync-active =3D <0>;
> +                               vsync-active =3D <0>;
> +                               de-active =3D <0>;
> +                               pixelclk-active =3D <1>;

According to fsl,lcdif.yaml, a remote-endpoint to the display is needed.

See imx28-evk.dts for an example.

