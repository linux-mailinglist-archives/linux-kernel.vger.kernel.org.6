Return-Path: <linux-kernel+bounces-313126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBE196A09A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899B3287859
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F02216EBE9;
	Tue,  3 Sep 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7hQ8RLX"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388DB145B03;
	Tue,  3 Sep 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373724; cv=none; b=CP4L8F3SylKcrRrI5/RqROi7RgqImif6hlWbbNKItrWSoFb17Kw6guh1Iekg5z7tV+v/viVXTlkaoJNt1gB7UDjRYxGhnU77TofC48PPXQYFvhWoSHy7edskVWznliN/RHXPAkuBi8txsD0m6QQzal0p21a5daD3WvZkIPFnFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373724; c=relaxed/simple;
	bh=VKKNvJ6eiGKtuXc2h+IwHD2WLZaWPWtYgU92DtTw0k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOxLXldarC7ILfvBtKjGz4jed9lDj5n9CcSse5yPmLy1zeeluHBqhn7vXUS23YEK1NeWE36dh/rI1HTh0ZmdhseXcAv4g4PR6L8r7bzP5xYq1ZtZU55rrHG7F/d7Ej6QemT/D3WFTb119A97TinQMaGZeZv+P+sJPB5dvRsydSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7hQ8RLX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3e071eb64so286891fa.1;
        Tue, 03 Sep 2024 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725373721; x=1725978521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKKNvJ6eiGKtuXc2h+IwHD2WLZaWPWtYgU92DtTw0k8=;
        b=W7hQ8RLXKsn4tAtQffBTb21JEcCLdkO1vi3OEwRLTNZJb/3jMjcnDyCJ3ybUbMisUY
         X3tBBnbUx9V4U6rVg14qO5N1Gbhf34HBvJCisX/sfnlMA0dYLiF799haoCfHFYOn3Gtk
         vMig42T2kfTiYGT2xp2VJjFVmL5IpEvdB5volMFVDdwOUxPsbUiYtC1ohXn3uyFEZh3f
         VAmsksbet1RbGo3U3Pac0Kwl8CsAxteBKzPQLpek34MT7rliTwmGshnwGkkfKaTWkC6Z
         yVyUCQtT2k2gNK9OqFwH72/i4ABcUx2Bcv5isguqRcrb0IoqraoSIyjtZKQosmYpsUQt
         NP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725373721; x=1725978521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKKNvJ6eiGKtuXc2h+IwHD2WLZaWPWtYgU92DtTw0k8=;
        b=vbcV6g/1aJI4rRXCEorzGfHNiERFPSjVsUQx9FOGtS0oKHsmxa5yK9qhCpBrnx2t7g
         IJ2tDUnNBwQR/I5Rh3J8v61P6M/dzGpKZOA3qetQEdV7u49vhn0B5cSFcUv9kuutbmrv
         6bDMawMF9w7dewBejMyVX4dnqRCrBtrA150x86a2nwTpRHo5NI476jF97FUIfTegg8rp
         HDJjDu/fRsXM18+0pJwE9rWYzsWekvIlV2HSYN7p3YVGe/30VACYzAzlrS5E8dIccEaC
         5VYfJywAHEFc/pCmcLBYXFiPDAab/me/Jo797tOe1aZpue1z3nGfKbrB+Unlvvcg0VmX
         YbBg==
X-Forwarded-Encrypted: i=1; AJvYcCUZcshLvGlZr+fVkSGtbfg1ZWJh0ok/DgkbRY+7Qr5nKpnEjDfXKI8q1ouzmPJlmoKAsOsGS0kVlQyw4pNI@vger.kernel.org, AJvYcCWBVuBGqej3hNdBhA49dz6O4kAd58dJ/PRfANYSVaL3YmW36jq9XA9M5PJO403MGIG9ZLl3Y192kG41@vger.kernel.org
X-Gm-Message-State: AOJu0YzlRKbGtdqDQp0oEtaM8Cd/QXsANYRgObpFhvhBZNYZR+yIhPHU
	cNBpJ5VeeDuavcph/+zPFoxUFPeBg6/dwRSxETBAVJkaVOFyt80zAPVSQUD7BzVMSIeOZYMrN4k
	/Obco1azj2ggn5ayjfec9RGRtF8kANdlY
X-Google-Smtp-Source: AGHT+IGCO1CzOe01x2gBVQqFSDi6qd3Veq6Yt+sGuAWQFT1yn9+VVUGsDueXdBocFTMYsIqtb86HTnyDp1Iz04sgASA=
X-Received: by 2002:a2e:b8d6:0:b0:2ef:2ba5:d214 with SMTP id
 38308e7fff4ca-2f6105c4facmr169146491fa.4.1725373720919; Tue, 03 Sep 2024
 07:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903091720.443091-1-tarang.raval@siliconsignals.io> <172537334994.875077.18308965320836312656.robh@kernel.org>
In-Reply-To: <172537334994.875077.18308965320836312656.robh@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 3 Sep 2024 11:28:29 -0300
Message-ID: <CAOMZO5BNYopFt=_o5qrK7piwxYwF4E10DzCKPW4oh0k4Yj0hUQ@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals Support
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tarang Raval <tarang.raval@siliconsignals.io>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, shawnguo@kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 11:26=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> New warnings running 'make CHECK_DTBS=3Dy freescale/imx8mm-emtop-baseboar=
d.dtb' for 20240903091720.443091-1-tarang.raval@siliconsignals.io:
>
> arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dtb: /soc@0/bus@3080=
0000/spba-bus@30800000/spi@30830000/can@0: failed to match any schema with =
compatible: ['microchip,mcp2515']

There is a patch from Frank to address this compatible:

https://lore.kernel.org/lkml/20240814164407.4022211-1-Frank.Li@nxp.com/T/

