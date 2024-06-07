Return-Path: <linux-kernel+bounces-205226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4338FF9A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D31D28462D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C56B1172C;
	Fri,  7 Jun 2024 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwbgFCN5"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829CEDDD4;
	Fri,  7 Jun 2024 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717724333; cv=none; b=Zb1zmBR3pslBv24qCP7Bmd1F/9KUFPAiTmkCNOM0VEu5jXTc+eyeTw++J8PCfd19YigZu3bu6dMbchcB6ba+j4tBIr/prikWBbEP4hL+Iq6kM5oPM+zJEsDp2iisQ+P/jox8qHsgnXStDhGZ8m6vYw0rfuvz5lg+ywDITwuJp60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717724333; c=relaxed/simple;
	bh=6bxlEeb4hb38QE3vXuSzO0xUdVng62y+HycXyjetSBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5ph7kX+1nlMrgZZs4H8p/6l8m2gfh3nhaCT8bQYb9u9gPHUMJsmFXxFefX2GbAdU9q1eyTr7H3LO4JdE7YxqIKuVmvMRUYgCX2USaXSTQxGZgXgLYDkqr4jVg74HFKFeTh3ZHkYBw/bJsTPNOIHO5rWBjaG2cDB1KrJdu0G1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwbgFCN5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70254440f1dso55931b3a.3;
        Thu, 06 Jun 2024 18:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717724332; x=1718329132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrJtzXtCuRxEweUkMCnAiqcogNc07ylGEeZdwo2MLn0=;
        b=DwbgFCN5WXNDqBMtiUEQ3h2JYGzz5k1m7tEcN/irEUyLGVSG/59TtMpNm39VQAXQ5F
         pVJ1WTiDQCu/7in4pvkP5ZLxwtoDE9z7X7J3Gat5hbpITl9TvrA1YuivhkItIJ1NlgOk
         Z8rBvbZW63Y+6QZ749d13Wn7H7kxFVkUwNBjrzg42RXEXC9RVxIoTJsOD28MaWTWXFaI
         8sIUkbCEdeQuEpQkEBl/OeFhD7MIxQZ0zjlN8w7raQh14VPobzIYpDYfqM3YdHNK+3Lw
         mwqKDl9SkIGEzMHjN65kWYLS1WUGDUSBTjYVbg7JZoRwWrCO83fnF9wdvlzB6ZvhgFQI
         L/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717724332; x=1718329132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrJtzXtCuRxEweUkMCnAiqcogNc07ylGEeZdwo2MLn0=;
        b=BKG3wYP2IOSdxbC+QucdgyxI1jRuY0AF66ROxwrRwE4q1eWDEJHp3/CV3FBQEMgNs1
         nns4JzMwq9Jr4+7h5aPSOns+5+HnJPpCZj6YGU3wpqlFBlKqEqoEQcuV1KyUEEzJsw5g
         EiuUXZxw43LZLaW191NIM54R423q9X7KCSZdHeJGHq5mFgLKukAywaYNlmxp5YhBXA8T
         zuC5izydu2gICNoEwuhcz8M5LHi1RiO4zP7fxlzvxsXn5yfALGxwmSgLtM2Sa40t9V6P
         ly31y2pgBc5hiG8lzH6qebl9R5wBTcVZJUKBqnDvXGaenXwoyiFflXlzh5NPqPa7AOsw
         3bdw==
X-Forwarded-Encrypted: i=1; AJvYcCVMZ9f3ilBTO7ScbQGNzyMwcK50xpjJxZORHdDz46w5umBzI9aG0jVc8bMga8fQncCbuIaR6F6n+5anbZAyCjM4WGXEwZytlWMILGDGo4Bk3hTbtM2COvubhPaqvdWseZcVobCVAI+MXQ==
X-Gm-Message-State: AOJu0Yzri/kxws4aha8oauS9I6OdCjQ6NAGwtaggnYFbZBIFc32A4gZw
	mXQxat/wJuWarB4bpwIwB2iCMF/0S+prauPCLBa23zOLd9JZhjtUI2mC40+ALzdGLex7+ou9Ign
	xlA2Ke5KYCYipk0V1PVHNToUiECg=
X-Google-Smtp-Source: AGHT+IHcZ6tSjJET+S1F8rqTj6jNBqUAkJu1y9qhZ7qLpSho5tRoH6yXpyj/NM9EYgmU0DW1AZiEV6bFvns3v6VLrdQ=
X-Received: by 2002:a05:6a20:9485:b0:1af:cefe:dba3 with SMTP id
 adf61e73a8af0-1b2f151f7f7mr1124821637.0.1717724331641; Thu, 06 Jun 2024
 18:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com> <20240606-imx8qm-dts-usb-v1-4-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-4-565721b64f25@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 6 Jun 2024 22:38:40 -0300
Message-ID: <CAOMZO5BQ9zpSQn=m1RHLKSmYH=ZCq79cF-3pKKUxjcn6FfS6Tg@mail.gmail.com>
Subject: Re: [PATCH 4/7] arm64: dts: imx8qm-mek: add pwm and i2c in lvds subsystem
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:47=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +               brightness-levels =3D < 0  1  2  3  4  5  6  7  8  9
> +                                    10 11 12 13 14 15 16 17 18 19
> +                                    20 21 22 23 24 25 26 27 28 29
> +                                    30 31 32 33 34 35 36 37 38 39
> +                                    40 41 42 43 44 45 46 47 48 49
> +                                    50 51 52 53 54 55 56 57 58 59
> +                                    60 61 62 63 64 65 66 67 68 69
> +                                    70 71 72 73 74 75 76 77 78 79
> +                                    80 81 82 83 84 85 86 87 88 89
> +                                    90 91 92 93 94 95 96 97 98 99
> +                                   100>;

You can use this instead:

num-interpolated-steps =3D <100>;

