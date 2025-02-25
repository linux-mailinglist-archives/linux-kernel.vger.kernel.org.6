Return-Path: <linux-kernel+bounces-531749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A482A44468
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F843AEEF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF7826D5A4;
	Tue, 25 Feb 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PK0iVrMZ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567026B95B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497393; cv=none; b=skrdFb8OH3fUF7/jbemom/0EkziFerhC8duJzGFAl8PT7U3PcVIs+rnsC3dkBAuaX1U103BxAbv9HocXIJUwqEGAsGIT4Hc0Bt8bTtb04g5Bxn4WNCZ08F0BIE10FdhQvcuVlY2Ucg7ndAvMmOxVqFxV7OckUjVWNFoYSwmTR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497393; c=relaxed/simple;
	bh=wWdKSLMGtVhehTwaDiWa/QdGdTyZRwxOUPS5ZjyNBak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NF12y4tAakncFC55G6FU70NOJjmrfU+Zxdl196iGwWvgCYjzJXk+3zV+BNOEYRW4PAEfH1dCbgmcwsoCODtBTnsyqaBGUWxw/9ZL/ZmzIyR/GSErzVvubui2IoeCoNrKuctNdNsG3rIiQc7KNaGv06tduEBNQf+MiRHRU6yXUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PK0iVrMZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5462a2b9dedso6839649e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740497390; x=1741102190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWdKSLMGtVhehTwaDiWa/QdGdTyZRwxOUPS5ZjyNBak=;
        b=PK0iVrMZIjuE3nSmGvq39lNXR9njQtjA611bqdgJ3xS0EgRwAp7SVwDni2TlSbjuQm
         /R1Folk9D10ge7vhVTIAv2yL1RIv48b55FGd/nJLF+UJ44tfU/7gSHv2wzSiLbT2j7tx
         A1Wx/9e1VNdSSBPwOuU4XpFwWMnkqzkkzHE62EU8IrCWhE8qxuzu6Y+mWkdnMRJqbD91
         DA1hBVkLTgnHM+Ixa2YBvx8ja6KW6CPlxoClCmTVMY8ExQ6+Hokko2dkdhFSqQZhSUz6
         KS3ZI5t2IqtXqm14vruC56FkwXizSd6tTFpnV7Hfy4sOvid8yRjdem/EuYbDOgm4HJYU
         07Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497390; x=1741102190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWdKSLMGtVhehTwaDiWa/QdGdTyZRwxOUPS5ZjyNBak=;
        b=BW1+FzKLojNp3vTk9fky/5rHuDW4HXvxnCSjzMBuSMiKHEk8e1i9O6K8qDHwIX48ka
         my/Q7xUvWHafJgplsQz/Oj62wmTBq5SXriayRUONSZcvNQI95y0Kcq8fwIxvFN3rMz/Y
         4aWh1epOZSw6ToNv8BtnwE4ZQuvEPr0okJ7EpSwa8n3nkP+ONOgh0j8BGTLOniCXz/y2
         XGbL/hAqeRt7dMfoE0x31jIT66O7Q9O0P1/6MCM4arvBi6nlPD+wg8Vtqw929fjH4Ubu
         B4f7iRevwBZhgIOYmo0C9PV7PB7rl367ISjakCEFKiC4HfSwfdr56DGmity/4qZEukCG
         J4xg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ35c377gCIUd9clwX3kB+EE7n1I7iE7XLJ18jHEo12fnXp99iOJ/66RDVHMjB+O08pq+vLjWvbbRB0GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW47Uq2tBHcwpwxNgXgbeXzimDg/i+JVRkDUu+1zY99aTK7kiY
	sn2XF3YEIIAwqlt7o0KZOjzdxCEVaQY40ajRtZJAWxOY4lP1b5j4xZOdKGBmorJbtWo/OE8E66F
	hXMcIFnJTS4TCnUL4EP7qW7ygxDsl74CmLw4WMg==
X-Gm-Gg: ASbGncsVB3PLRMh3oy/vJRNrCNjMEj7JZcFKpO7oWI6vYjxI0Hw4Icy31r/ZN15bsCB
	OOinp6U+LYj24MBxBhAmibFmK8iI8K9sybenppB91gI9krD1SQNBxAn+qjRi7eAa1OMfv6k2lY3
	6Rn0h4qJk=
X-Google-Smtp-Source: AGHT+IHvpjreeVdSU9R9yS1LahY6jIM253YORDAz6aGw1c4d6Ig0oMzawVusMy/Ox5z7NzVK8VH5Bf9FnhT6749AFpc=
X-Received: by 2002:a05:6512:2204:b0:545:2300:924d with SMTP id
 2adb3069b0e04-5483913b648mr6916367e87.22.1740497389960; Tue, 25 Feb 2025
 07:29:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220180427.3382482-1-vincenzo.frascino@arm.com> <20250220180427.3382482-8-vincenzo.frascino@arm.com>
In-Reply-To: <20250220180427.3382482-8-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 16:29:39 +0100
X-Gm-Features: AWEUYZkxyqLZJ8PShNH5_rYAenOAI2e1xZONqXj_RF2KAU6bd0KxT-okASSmRCo
Message-ID: <CACRpkdagr5EhOL1K=SYHxpT3KV7J2WypynOEpTmExK16Nx1ezw@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] arm64: dts: morello: Add support for common functionalities
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

On Thu, Feb 20, 2025 at 7:04=E2=80=AFPM Vincenzo Frascino
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

This looks like a good base to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

