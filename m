Return-Path: <linux-kernel+bounces-575451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35344A7029B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C2517C489
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F08C258CC9;
	Tue, 25 Mar 2025 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjMfAr6Z"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01C2580E4;
	Tue, 25 Mar 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909898; cv=none; b=ePC1KdbXP4Wthin/sm9gmaF3R4iofQ2P00BQYxkIB6uJHvBlKSm36MtK6TC5op7LW0A2hkEkztiXSXGjQD/7gwYXKva1Y/XVdGp11K3sCeSlY/u4cRynIm2ix8T0idviPEolwXazyvkLQhkJ23PdiWZCww6Z93AQYZBJ/LBUwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909898; c=relaxed/simple;
	bh=9vJQXOVux1nsVJWDEzTcb5/Ceg70DOuWGdhP5xFpo9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQUhxKjkCebmrmHwKQHaA6iBBfBX3mE5n2wnY6wzD+/PApJhPIhcE6l50cYAhzWzfnrUsoMCYLJP8utbEiiXntFSPLiRNocu5c8BOe++tVQQpSz9++W0kqazMpNnm/EZIH20fOyyx2tIm+qu5WfYpaMvb6OIDNCM2JP3pBpkZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjMfAr6Z; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30c461a45f8so55846191fa.1;
        Tue, 25 Mar 2025 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742909893; x=1743514693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJcwO6oJh/3y1WM8EogHyJVWkUsi3cC2Ve5E14+wX6I=;
        b=PjMfAr6ZudUYCfKKXGv+YwQ0kbkRZHRJhTiJXQMH6/QBbtMW51pRUxC0NgJDgD8lCH
         AleE+YVLc8L0mgmzqyl0kwG5Sxl1KGSc0H+oJIkzgYcXCsCWu9rnM+3dGELeM2JQ6oh5
         +yBYpTzmAOC2zTjJocdDUe/nXlYe2bHCQK8efWM+D6i8/vTdNZoDFugX/E06lkMFxKXw
         37z/PjQNdsswU+1VAaXkM/nT+++TTrWjcHx73XEithEMSf4383b8cUFDTnf9JVobSzcC
         husy0x5CTPkYKRTnCGhV4oamJe0twBg5MEDxmyNJU3ZqaxXqzn7CrCWXIjcRN+6EE5pf
         ZjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742909893; x=1743514693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJcwO6oJh/3y1WM8EogHyJVWkUsi3cC2Ve5E14+wX6I=;
        b=AL1aQguSXEXQVb7/j+7nVjfrYH0e5Kiv1mUh0XRujncTYbUv8EZm9sMmSzcqw/xZbV
         hncMZ+afNJieePIIut/m9bJT95L7zRCnSvvulZ1Ux5tldkwX83K1YUy5KFruzb7hCOxv
         0/mb7ZG9zK+DvkKQpLYNlZ8XuARU7TNAmp+eQgleJP61Rcy71W7G9peM9bnVPvjx4fxA
         wT/uoOXv/riFr5g2YojMSFDHPgw6Rfq/f86trJ5yd2oZQFkCThOXEnnEYHSiHZEJKMZj
         aaEBeivIIWc74xKiOHMaJHNZhsYNmX6Mo/mfT1SKaoenWAUTZnEeajYZStrnbyF6K8Xh
         T9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUVLB2p2+3MJ3zg7diQv3Rp1gxnLqIW4IEsbIARmL9D6DmO9p8bahpC6uIkfMD+uYCU+OYGBBLZApA0@vger.kernel.org, AJvYcCVZ1n4aHMFvoGXuiLJtE3D4j2H6ls2gNvkjzcRMNvvzOP7NmSIH3DKFqON3D8VTSMr1rrN2TfcKZHkSeRg1@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxPs92HLjaR1DWhvFIcnGmm/Y8A6py3kwCwmvpaEXdqsOyOeF
	obzHHhxJld6e1m35XbVxAx18Ps25CpGT6uEJPrRXkDh99d0mcIfi8jb7QlEK541aYvk6qmYqokV
	jHKmT41P9l3YXxf9hTua14wBOzU0=
X-Gm-Gg: ASbGncvbpH8zAqROpLodpJ2V/nrm+4m8szfOnPCR0P/5M+nb4V97n8Gy/yvUZ/+qg71
	4dJ775E0F87wbU8cpsA/PatwoRbIQ3SQ0WrsWpai2lqclQrzBfnKsYXqpGFug567UBDI88xaQuk
	hFrSINFA5/jlvVv2YKEZsZe8Z9ASwKOjVT9fZP6/q+d5PMU2Mzbv42kJux
X-Google-Smtp-Source: AGHT+IE2jBJpiBJtfwsHoNJN87YabNIB3Bk17olZpd4dKi/GPoInYLNljjvK/5Lld/OJTFfbkolpcu+ArxWQkLCWGFg=
X-Received: by 2002:a05:651c:39e:b0:30d:626e:d03a with SMTP id
 38308e7fff4ca-30d7e2be3eemr64314551fa.34.1742909892678; Tue, 25 Mar 2025
 06:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324234013.140440-1-marex@denx.de> <20250324234013.140440-2-marex@denx.de>
In-Reply-To: <20250324234013.140440-2-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 25 Mar 2025 10:38:00 -0300
X-Gm-Features: AQ5f1JrOTiHA3zEWxRMp40SYF5x01ogmRGkPujdxnIUlw181i_K13kaKiIhlIDY
Message-ID: <CAOMZO5AVRZBNntXD4p+esOFMrex4a84p12xL509Hg=cVpRnO8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: freescale: add initial support for i.MX
 95 Verdin Evaluation Kit (EVK)
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Conor Dooley <conor+dt@kernel.org>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Hiago De Franco <hiago.franco@toradex.com>, 
	Joao Goncalves <joao.goncalves@toradex.com>, 
	Joao Goncalves <jpaulo.silvagoncalves@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Max Merchel <Max.Merchel@ew.tq-group.com>, Michael Walle <mwalle@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:40=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> +#include <dt-bindings/pwm/pwm.h>

This is unused. Drop it.

> +/ {
> +       model =3D "i.MX 95 Verdin Evaluation Kit (EVK)";
> +       compatible =3D "toradex,verdin-imx95-19x19-evk",
> +                    "fsl,imx95";

The compatible string could be written on a single line.

