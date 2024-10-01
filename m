Return-Path: <linux-kernel+bounces-345843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946FF98BBB6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EC228430D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA6E1BC09F;
	Tue,  1 Oct 2024 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5dwuVri"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3570C1C0DD1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783939; cv=none; b=JMnTD53ESLLp34UHQ9n0oboqC/qWQnlGxp8fO59xMIE9JvqoRzzWCViupWrMy2M4skstUoGBfwi5gXgh2kTjLloTCiMry3VA2mtETqRmyriR04WZ289b5GbiZHhk/NfKO1X/Mc5Eh6E1mwWCmM6156gXV77RRFgV81k+wOm2ihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783939; c=relaxed/simple;
	bh=tT3uNe+7OwJiWl6dOd3zCd4RwjUbE0KVnThqCE7dP4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FiNXkK28JAqJSL4DgAplMu/XKARmHmsEmJKXUrcjmQ7nfOg0jD1YE4OQ41hWj02B7b4ymIYjdfS0RAl4wlOW0TXPmpNPLmxYalXa+QQhPEDyIxs3dt4VZEp8Mltk6mBL1+weEm+BrA0ty/qE+q/5nCCOo/RwnUUrFVwAsB0anzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s5dwuVri; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5399675e14cso2422918e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727783936; x=1728388736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tT3uNe+7OwJiWl6dOd3zCd4RwjUbE0KVnThqCE7dP4w=;
        b=s5dwuVriiLT9PY5kTmOvohth7wSiLhztspRypJI12NVtFer1FkKSP6ire7gzXZW11n
         xTU5RHrRmTl/LUuMhqp9eRaBI1PaDi83b5ozEj/YViQYDNDalZ5r6j64RcHQG2cup1nI
         TmW7h45WfAAKE209ymc8AbB+HYcEJwTeSdDP5Jn5Mu/gCFlh5wtSiV75VMpK5ZHtZB06
         zERlJFCPf/Eva/zCdWvLr3H3P7CdAzGYk/P9gYGXAfEQm+wwqV5l1eWZNCTBraD5z0KO
         YgeOQJZPaUbghMaiAp2BHS+MoB+kj3PxOsMViY63nK41q5RByjtMVSa7aeO0EimH9uaz
         WTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727783936; x=1728388736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tT3uNe+7OwJiWl6dOd3zCd4RwjUbE0KVnThqCE7dP4w=;
        b=jHUj1nVhRsO/u/D/umPqAiDqaDg1q16d6YZFqT/Al2LyrOqiIIzse5fKPmg3CHwhbg
         u8UsDvoklbZ8pKliApVmlc3oku33wpQpbO43JWrp8x3mIauO5XjvfUyWtzXfinayttMx
         M8XOFb5P5Tm8BxjZN2a3i//33un/5HEjxCO2w+PxyGSQdbQV95eaz+YTBEk2BmRwi7aX
         umu7BO6rDxsSMefrN6cil6Kk9KzKueXfMm8YNA1C0+SkQbVRVhnaOYZNgUH/QpOk36OW
         ahaSTLp0DFwQytDbiSr79HS5t+RmQHg1bgq2a3VMc/OfcPueB75nTGga4yeLiHFyL8OJ
         XiZw==
X-Forwarded-Encrypted: i=1; AJvYcCUmdQDActznk9g8TrTqRL/7oGFS8Nop7afxAr+pB70z33QFQCVLo29J7l5tYYTSy1nJuBUOz+bbhaHZyCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDnZDID8+ZZNc0eweqckFvfzJ80cvsgsSDCxv9kocGCnpgTdO
	kx9b7e/bybOx3qZVOJ5sgdTBRfiVUERpwvUCm9cLPg47EyK7X4uP2q+mOX8s75tOiSqMBy57Skk
	DGG1pzX3q2W5iAy6uNFXmn2q4T+kXgwbgvzUpXw==
X-Google-Smtp-Source: AGHT+IF1aWSW3u0bVeF7TKArbk/atdczzyQVZ7HJ+FgfyXMEiW9tWm+hcgU74jnyncTE1uZzGRzCTWRoyijV6XUmu6w=
X-Received: by 2002:a05:6512:1054:b0:52c:e05e:849b with SMTP id
 2adb3069b0e04-5389fc63377mr8318002e87.39.1727783936401; Tue, 01 Oct 2024
 04:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917-lan969x-pinctrl-v2-0-ea02cbc56831@microchip.com>
In-Reply-To: <20240917-lan969x-pinctrl-v2-0-ea02cbc56831@microchip.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 13:58:44 +0200
Message-ID: <CACRpkdZWp8W5W0BLzCJ6hHoqMUwCr4oZ7XZS3RbZ4YYNp__h2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: ocelot: add support for lan969x SoC
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 2:46=E2=80=AFPM Daniel Machon
<daniel.machon@microchip.com> wrote:

> This series adds support for lan969x SoC pinctrl by reusing the existing
> Ocelot pinctrl driver.
>
> There are 66 General Purpose I/O pins that are individually configurable
> to multiple interfaces. The matrix of available GPIO alternate functions
> is detailed in the pinmuxing table of patch #2.
>
> Patch #1 adds compatible strings for lan969x in the dt-bindings.
> Patch #2 adds support for lan969x SoC pinctrl.
>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Bindings ACKed and no reaction from other maintainers for two
weeks, so patches applied!

Yours,
Linus Walleij

