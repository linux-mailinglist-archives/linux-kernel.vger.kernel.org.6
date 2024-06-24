Return-Path: <linux-kernel+bounces-227096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B9E914841
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6927B1F211D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D2813A25D;
	Mon, 24 Jun 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8oNNWxG"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A7913699A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227641; cv=none; b=P6NKw6h8bLV79BRKPa0eZOtGgTWbfjchxf8O/x57nq32yUPGTxL546riBTQSgYkvu4CKwd9LQZoT6ohJ511IzvFwvAju6IfwLb0VLDFqBGDlsN3SCraJgXdK/nkkAJ28hYFzUC0JTPrv4DMk10JnrssMuiayNiDq7v7LfpjX6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227641; c=relaxed/simple;
	bh=meeWBmILHEqJWzac8umjaOJa8I4Ncz20EGfL7OzEJwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/VQh+a/8VXZZ2K6WgVa6j84xAllXbs4H0YT5lSOK1NukOX+hW5PCWoKGKGXRrrCCVh6jTls4ENx6VSnJvjJzWVU1/nm7wle++9bYt2PE6Wx6DaetpRVvw9rb4Q8/5UdrofkPGAYBdWP9fBRxxTkfUmHx7CBaN6OD2t3AxXuIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n8oNNWxG; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5bfb24e338bso1670593eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719227638; x=1719832438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEzwQY70dS5/4zaR7wFnTP3jHuIxxfgJgjvsBN94sGk=;
        b=n8oNNWxGWwHxlRPICp3Lbhcrqp48MuLJ+XqpwHPRlQhtDrWO1ymAwipoBvp/kZBo1E
         YoqlJEguO7P2Br1oe6Ky/QkbZIp8dG0Rb3l3MUIY5uTlmqgQ79wayKMl96hlVClOGFwb
         P2bL1oV5ZN+SouYXL1wpkKLxlb6CNBD/V2XKZPnoLrFSoKpakyIknf7xEZYgs2DHew3N
         zfejOkheZ8SZmO/9LgqKjATU+rqmyjMjJCRJSTITy4OpYyJWhSJHkYK9YhN6d1dIlqqH
         pE7vrU568dRXPFINhVbfmphfTBFqwQLzG1pkpkab0h8oC0nFJtpy3skBNWorQgfqmyRD
         WjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719227638; x=1719832438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEzwQY70dS5/4zaR7wFnTP3jHuIxxfgJgjvsBN94sGk=;
        b=nzgXzZmnvk1620626YsBJ1PwQKbUl1U4n8u5DxtT5jG4V6eDIhdKCR194NgUlqj6kx
         5RNHeYbXcOSf5oqVMfWqXyoNaOZYn3OxMQ4DBz6LC54q5jIaKUUJ+XWrpPSRMHIFHe+3
         eIidcOtKMGpuxjBGwfaIh+0Y2w1tjCmorVa7o16xWHQwuAv5811aDB4YCGbxjpGcLM2D
         Kr1NY2ve45G2aEx04b/EANshDFM16cu+axOOM9gXZgITpjDBhyFcWZEUZiX4z5zWmuHp
         aP6MRGq9p048S0FvK1V26+hatJ8jG+BP6qSxC2BZUnhOkZS7Uz/ZtfYFgO7eVMp4fP+Z
         5a+A==
X-Forwarded-Encrypted: i=1; AJvYcCUlUyujR2QobM6WC9z5/IKiTPky9AgNMyc3qM0gpp+jw98QzNlulPaLbmMl9F3eicHeveHwBjBQEyL7Kr//RhNgTXzYparDVQOVQMO5
X-Gm-Message-State: AOJu0YxtW1UBvaTwNBoEo8EZW5sAZ9bQgy8sHwmQf1MsknHc9n92etMv
	MjWJuxtboxlfXukwws6wS8Ef74OCDlPPSYa4CrcRpOvtJat7dd1Bqe8u/Ge09Ej6w/hF9Dv+Twg
	BlKgdNea7JvIKz/+lFsL6FfbCMeoj6Ng8co2VJQ==
X-Google-Smtp-Source: AGHT+IHmVjPOuYszhXpUs8aOYTWZZ40BicRqOgwhbWDxIhWPU3UqwLQsR384Gfu6pdKECYYPVPugv6s8L7YYKqqAGTM=
X-Received: by 2002:a4a:240b:0:b0:5c1:e8e4:57a6 with SMTP id
 006d021491bc7-5c20ec4e865mr59179eaf.4.1719227638018; Mon, 24 Jun 2024
 04:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-usb-phy-gs101-v3-0-b66de9ae7424@linaro.org> <20240617-usb-phy-gs101-v3-1-b66de9ae7424@linaro.org>
In-Reply-To: <20240617-usb-phy-gs101-v3-1-b66de9ae7424@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 24 Jun 2024 12:13:46 +0100
Message-ID: <CADrjBPqLgvot6oG_Kx06okwOkzn=Kozjj5Upem3w4OhN-Z3hNA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: phy: samsung,usb3-drd-phy: add gs101 compatible
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, kernel-team@android.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Mon, 17 Jun 2024 at 17:45, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Add a dedicated google,gs101-usb31drd-phy compatible for Google Tensor
> gs101 SoC.
>
> It needs additional clocks enabled for register access, and additional
> memory regions (PCS & PMA) are required for successful configuration.
>
> It also requires various power supplies (regulators) for the internal
> circuitry to work. The required voltages are:
> * pll-supply: 0.85V
> * dvdd-usb20-supply: 0.85V (+10%, -7%)
> * vddh-usb20-supply: 1.8V (+10%, -7%)
> * vdd33-usb20-supply: 3.3V (+10%, -7%)
> * vdda-usbdp-supply: 0.85V
> * vddh-usbdp-supply: 1.8V
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> ---

Reviewed-by:  Peter Griffin <peter.griffin@linaro.org>

regards,

Peter

[..]

