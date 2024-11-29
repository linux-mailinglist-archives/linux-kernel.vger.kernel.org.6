Return-Path: <linux-kernel+bounces-425363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5A9DC108
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AAEB238AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E885170A1A;
	Fri, 29 Nov 2024 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3V8E2/k"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358AB170A15
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871009; cv=none; b=BL25tkLEUprq2zpOV7e3qrFZ9xMZRy944m1tzRiZ0dG4tyK9r8OiHkTjjtANkLPFKsBHWU59OqOftWb5cNAmRmw8aKyLW7IUiSyN77cDHcYZQKWosbwddCuFqkdph768z2rLR/0iK5q0SGnPqCl790fBO5tfr8KirHklqW5S3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871009; c=relaxed/simple;
	bh=wW1UPfI2pZbnJAJq8B5Y02AKlDZ/ksTo9I5RBhqTvuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcZWLAQxUw2OIoMALw+8gRTPQa22k5guGqyBYKdYzzK7C5AQAqPT/5DRPWr9enpZ+rS5i9ZLGrqTzw+zlzmu2+NA+vZKAb/05slLjdDEVs58UXaDpaQEM0J9mfK0eByqiMoA9QflRgHdSO55fbElHef7Tt+QBItIDSgftusAKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R3V8E2/k; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso1050443fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732871007; x=1733475807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW1UPfI2pZbnJAJq8B5Y02AKlDZ/ksTo9I5RBhqTvuI=;
        b=R3V8E2/kw9eOTTCF15X9Gph5mh24F0GkbGtFO0dNLnPJnBPY7Iq/kExGi6J6l+gp7C
         oIwvzU2bjDqU7n5m4K/NJW2pXOIlDvIuM0hjgDVSyBo0+FayvXzdmAtLPlvSRpa+Hxno
         ZPVQBcOBNwCdItc/oZvUDMcDr/5MSZoylQMvVaErk/4A78JEMQgy66WXsAT4RckqWtV1
         3GPPq9X0B1WxkLIMGCHidGgGCeo0GbDqOdCZS8dUB+gK/hRcWEzO+EvoHhwP/V5/uvFf
         9jVwCd35X4zc4T12W2NQWXPlJquAiqD6yp/AWSPrDN6Xq+tv/f5To/7M4nBtFDEuCzsE
         aHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732871007; x=1733475807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW1UPfI2pZbnJAJq8B5Y02AKlDZ/ksTo9I5RBhqTvuI=;
        b=ED2gGbJ6b44Q4jUqQgCxt2ct56MX+cH4PIxFLOZXMEar//hWLmrtGDytCeeVkXOVoz
         amMbmfR76982I/RDnTooJ4F8xWPIupRZEa3r/KxY7gTRahMjV/1KiORMZ3KSYjtmJNKt
         /3Xp6CgWKwKspXgffenqOij8I78R7ESxiVaeA39+SY+34dlqCXbT3A8zCUai4/ehzVtq
         fG8LT+R1AM/dIpSPJOEtPX1C6ido2cvhd4+wwPLvasQ9WfVmfHBpoMwAq6Ua6HVBG9Pc
         dg4jp3+/HJpXkwTVaZ2UT4XqMX4scanjg0+kAHxLPmxK3EFEO5NilDLC+kmaUCn136xq
         F3eg==
X-Forwarded-Encrypted: i=1; AJvYcCWqcr7X3hm2OOkwKZPktkrvq170cbymN/BuNbLm8GmmmU4Xjk9y52ARL7yN/5/B/SCUC5bALwPhzs7SzV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoceNbTts+5BcPZ/J2ZVEvPk7aQXmp8fWhcor3DrO2rKlj3xpE
	QGk4bdlyAgtxY6twhDi/b5Bha9Oba2Va7EihceBHd9l1nkhq4DQqRh9JbnLifpqY3S3yCweUnKw
	ihnnBItlSEQjDdoijfYmteeyhX9r2rjcq3Weuhg==
X-Gm-Gg: ASbGncvVLKpNFfKK14UiGHaWmdvX6miG+o38a/kl3eIQfSwSfpfb1va01sJW9/QUG+3
	iq9eBhshnW/+A1dcxqTiXybMi342ts2By
X-Google-Smtp-Source: AGHT+IERoPgZEiqiqez2SpbM2z9r3e17P7M26vSOjg5eYLpH30rXYi96JJOb9xGSNWtscEvyPnFpElGY/PMRwNHOdqA=
X-Received: by 2002:a05:6870:948b:b0:288:a953:a5c7 with SMTP id
 586e51a60fabf-29dc4033a56mr9209530fac.14.1732871007224; Fri, 29 Nov 2024
 01:03:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
 <20241127-gs101-phy-lanes-orientation-phy-v1-1-1b7fce24960b@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-phy-v1-1-1b7fce24960b@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 29 Nov 2024 09:03:16 +0000
Message-ID: <CADrjBPopeTk5d0irJ3UDBBG2=gJF4F7hKWbaGP80x9F+p2jhUg@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: phy: samsung,usb3-drd-phy: align to
 universal style
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	Roy Luo <royluo@google.com>, kernel-team@android.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Wed, 27 Nov 2024 at 10:58, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> In [1], Rob pointed out that we should really be separating properties
> with blank lines in between, which is universal style. Only where
> properties are booleans, empty lines are not required.
>
> Do so.
>
> Link: https://lore.kernel.org/all/20240711212359.GA3023490-robh@kernel.or=
g/ [1]
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

regards.,

Peter

