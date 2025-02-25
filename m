Return-Path: <linux-kernel+bounces-531815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9B5A4455C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E25C172B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D4018C32C;
	Tue, 25 Feb 2025 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dng9aAo4"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B8188A0E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499443; cv=none; b=kDKztYOV7BcHmNhp2GGMmGGM3RgXAzDDgmTucmh3+4+Cptei62MsX4i5mzwXalLcVqFYlUX/IzHHG8eMRQKtU1huoqe4bA1ffkrb/ovJRiRVUQP1z0NZrQDjSfsNiw3C0a+fCDuDKwt0u9Dw1G396KgBCL1ccSDQbdI29ZWE1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499443; c=relaxed/simple;
	bh=HAJZSDB7xuKscLHDG+yRyNMB2g3SgALZv2+HI4HLlBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cv7DxSIJM/A3MTDHI3WFCWCLZz2jr9GxvlJKgYDII0BRmBqI89p0OtB7k0ChAImM2d4zYJlYNwqtjq9O3PRXqk1/1Tvog9cygQy+tVIiC4/53qSouI+G0w08n4joGEuYd6s8XiA4oAd7ndQVBvgV8H7ES7UgAQPrBXVD7k1Is48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dng9aAo4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3072f8dc069so59535101fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740499439; x=1741104239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAJZSDB7xuKscLHDG+yRyNMB2g3SgALZv2+HI4HLlBw=;
        b=dng9aAo4J6yGm3r9pnM6qmzBu+/oLNUYGDIZNRWXqYw8X4RmbSshZXSTkd4bQ9xiLr
         u40FwTkZaqXE3Jf4EjejH/SdsAEstyZ0hcYAjETELNc7DgHFG57rP3xbF+6BkO1U4W8+
         3d+aeQrVRSVOWP2atcyMhjwbRYqVWkCKcds+Uu48NAKiR4AcMwkxbG5xdEIto1YcBvWb
         GmZCa3kvWUPWTSpcF+l/cjI+a/ayfZ5mNHPv5HmfL5R7UkXZF7kNGXHRbFxUuwLOY15H
         9mbRJ57ZjQ1TTltRNlSGC83HiSlEc2I4SSY3vxJxvVyzK1/RnGb7Sgu/7QRcpLAaMBng
         Q31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499439; x=1741104239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAJZSDB7xuKscLHDG+yRyNMB2g3SgALZv2+HI4HLlBw=;
        b=gJVIRDeFyzlTIF0Pqr2QiPsSeBfccR3sSaOh702f7M/s4Kpt1YWxbN6yX3l2+Qhm1t
         KM9of1aKA14+HGV6G2YskCBI1wsuBsoVBUpeu/L9QFNRLWYrTc/XfDIsly+4wWjVBywe
         RdlZXPfo4yAxQWx8GPivGGp2BEb152U2Jz7lNvAQiNYS6794K5y3C1nvv9xCfvzWmWMA
         zUNBWeizrrFn3XyUq8nkqAWeeUq4LBV4cag8TH4cemOGv2+4npcDr83UQbesXdwhLx/O
         bGkVqnvq3xOlgiJqMYvTFxdq0tgA92veqOKoL2cwREnvoUFfeK+QcRAUP22zmkjWvBoL
         X0bg==
X-Forwarded-Encrypted: i=1; AJvYcCUUDj4hDlrxNcIwhn5trkBIHXIkknjBBolnfMswVIqKySABLX92rMP+tp1Ow5xrX3HTy7+MRws3VdeV5zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO9iHj6zNu2YkZHGNPMIIBNSlTqziZmE85roqm8erv+3K4bIYn
	5tO6/DE/Ycq/T5JP3rGcZCcgZ/Yvx2g2AQFAyRQOR5sXt2Z9s7qYX9H9KZLbecPEGIuueWhJHWD
	PYrlBuYj4jFesxdDqN+n8/rIYFlxnFCGJRK064w==
X-Gm-Gg: ASbGncsAbn2v4QIIcpxe0n5QtIxgkJ6mqAu+SELLoIQAP8q3S9jvq0/Nv/MLG3aUdAL
	C3dVmA+RZKgOEqw5ZrhhrwjUx+yTvnvr2yJbi3MBm20IcvJq1UPPNwo7KHSjRFwPbyd5PjjuukJ
	agp0B9p6A=
X-Google-Smtp-Source: AGHT+IFwIPTPAN8ZcBc15otKiSGh1Sts3zHIN5YyF4wUrmvTE+Iv+8sCecZDdml+angRjq277rXIbRl6UYAnxPy6Zeo=
X-Received: by 2002:a2e:904e:0:b0:308:e8d3:7564 with SMTP id
 38308e7fff4ca-30b7915f5ccmr985601fa.10.1740499439306; Tue, 25 Feb 2025
 08:03:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com> <20250221180349.1413089-9-vincenzo.frascino@arm.com>
In-Reply-To: <20250221180349.1413089-9-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 17:03:48 +0100
X-Gm-Features: AWEUYZn4d45FVOQcQnBxxxqs1Gqo7DdaaspoAnfO8hGKbCHJZAxez0cdfVz437M
Message-ID: <CACRpkdaH_Ajz=604PeYctvUbTOo76YOSvWvrovPF9m=O-VES1A@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] arm64: dts: morello: Add support for soc dts
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jessica Clarke <jrtc27@jrtc27.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:04=E2=80=AFPM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> The Morello architecture is an experimental extension to Armv8.2-A,
> which extends the AArch64 state with the principles proposed in
> version 7 of the Capability Hardware Enhanced RISC Instructions
> (CHERI) ISA.
>
> Introduce Morello SoC dts.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

