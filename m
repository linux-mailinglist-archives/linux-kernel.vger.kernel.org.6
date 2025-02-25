Return-Path: <linux-kernel+bounces-531813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFB4A44564
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1149188AC71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AA015C14B;
	Tue, 25 Feb 2025 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="krCAssx/"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795DB175AB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499428; cv=none; b=Nwfrm9YHK+DdoHcS46ivz1CemH8jd4Dc4m5e0u+EG4yltcBpO6bz0wTl+5REc3srW4Fcg6EdHzvbdC4WFraE+dVF3mjZCE1+8KZw3CmJuQlggXQYJUlFoqJ0G5CFOMxYAr0TNRWSpThR/GsceuHUkn4MasPVLvXgGFOO9XmgMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499428; c=relaxed/simple;
	bh=qR2JNB0YtgaNbh5AVqlZ4RITAUXIBdixqpacE0N/jLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhiOPoJ6da2ablsdReqbUwJxXcMCgLUKRnUGMnfEfA43HTxQvHpgTKCPxzacU0nM2pyXYITAFy55Holq4eggs14nTSowMbg8ofVyFVBnRsZ+dx1CqqkUyNudzyvoK6NaqB9sYweReEW8Pam7i+hThu8kxOSPlzfDExJb1Ha0S2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=krCAssx/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a303a656aso60675981fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740499424; x=1741104224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qR2JNB0YtgaNbh5AVqlZ4RITAUXIBdixqpacE0N/jLk=;
        b=krCAssx/6iNXtjhMAx6SD/YZx+6jk0joE+41Ra/DLH/T/r+j0BcJ+9rr6C5qjL/4i3
         HPysvZ70f8qfrWon/iqNYeTwJkz2RO795vPQ9shj3H2htYnbCjq1NHtWJ4hWv8SH2jl7
         fq27LmFz1vC59DWpXxmq62seTxv12CYwpv/PUqdX1zN16F4Z0/aRvzn/Okhi68rQTQYQ
         k/k4Ba6V2gohadCChH5U0uc7MON4RFTwEaoV2F1aOQdihFU3K3gNaifaxTYPotIxMrir
         ja323fvnD+DMUF0x8tWDf+/o4P9BTEUSHljlt6E3CIiu/Fy537GPdEoE5duc842zH+X4
         1JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499424; x=1741104224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qR2JNB0YtgaNbh5AVqlZ4RITAUXIBdixqpacE0N/jLk=;
        b=IpdLtntNohBZFaCVrVbTHbtnCzX4IGVq2kElEg46rUpYxtXUABCLnkYLt1jUDjl3u9
         yVtspPmHU9M0a3d3olW326CjKuk3ER7ZalYkpGngkWbErAC+957Tif5LxLTIJUpIquAH
         ThYBf3nSWRabChiQgny14yLLzpvq9c2noDFxtBCyL6VHGiT2odxfQtQlVIvfD67I2BrL
         LVwr2SGYW3GlXYbGfDd2p7Sg0cj/6lAPjPV9BdiTYCaSCN25HZiNdzmp0WRPo9EqzsYx
         Wog7cA0ONla+a6XOkKldRMJYF+TLye3K3fk4bgJNZ8M8MaDZimb+Zz9um5oAYIAKrNb9
         cfNg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Ea80cnm9HXAIH3evan+BDFy2MzqU0L2IWtbMKDhVQ3I2NduT6ds68wdhtHEbh8mHSIyFChfhEemdYGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9CVIUIB6eYPGU/s0Gj9nDqv+xGzd7wSySUPLY6q6E2obE6Wlg
	ep3JaJfmW0UPOgJ1DLY5+xOUsYcpTkHhI7ktXVCdCSX+v5FuVTybPjP3Z+hWp4zPhs0xSMwokab
	zpYjZLX9aVADAcYQxPaDts09eAmhY0rrWZ2wpBg==
X-Gm-Gg: ASbGncvHX54zbrne0mIQ4EL+Azt5honQjsQGu77xKc2yBdccuzlxoqrwt7B5Ucz5BYe
	Zq0nz4O3iSjpnpLsgLzc4B+iK/xHV5rf/JbmV1/vr7Y/NN/AJ20oXYU7oaqdc6J7/UgXbulJEyW
	LaEqmQRlA=
X-Google-Smtp-Source: AGHT+IFk/m7lVF7R7K4H5m7+dbhSnktSBcDmdUKKqlVUrI9Kn7thAe5jkuemGc5E1zKqYjYWf17ZEngP8oaLfuPEGKw=
X-Received: by 2002:a2e:7218:0:b0:308:e956:662 with SMTP id
 38308e7fff4ca-30a5b1a08d3mr64411471fa.17.1740499423031; Tue, 25 Feb 2025
 08:03:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com> <20250221180349.1413089-8-vincenzo.frascino@arm.com>
In-Reply-To: <20250221180349.1413089-8-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 17:03:31 +0100
X-Gm-Features: AWEUYZnIWuR60Y1CICJ6IBniRC28YSjUf8IJsjOxper9yUD4oZSXk7ZrSbIe5X0
Message-ID: <CACRpkda0o=xGBsZkL+jLH=sGyZ-vHiuS3OTmOHhjMdezkUH77Q@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] arm64: dts: morello: Add support for common functionalities
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
> The Morello Platform (soc) and the Fixed Virtual Platfom (fvp) share
> some functionalities that have conveniently been included in
> morello.dtsi to avoid duplication.
>
> Introduce morello.dtsi.
>
> Note: Morello fvp will be introduced with a future patch series.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

