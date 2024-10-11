Return-Path: <linux-kernel+bounces-361810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E6599AD46
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581121C21104
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5A1D12EC;
	Fri, 11 Oct 2024 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHziWnCM"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7F1D12E5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676782; cv=none; b=GSPe0DooO1quEvB9x2RChhTNIWCF/JLUQe0OhSA6fVX1+bS/D1KTDj+afeWgQemx6zg7yy0PCQN6X6H/ZfGNELZF5tUirkaYmM6r3OUbmAfEAUH37/vCrzy/m9k0JsH17sVzJ7oo71uuN38DWmdNaJgNWPEVMDfNqAZ9nfXYTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676782; c=relaxed/simple;
	bh=b3t/6WlSF/m01dr3JqwvO6A1PNlbPysSRIdrRHqnmAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiOh1tfM3pHD5gFLzEBBWSc03XN2iU/RoYoOrcHkDfZTm6OOkTFZ79m1vMC4ycUgov7K+uurFxzEEBa7PM+jM8vgQ+pTeXJu4B7dTTNPAPqsdiiT7sxuv70oip6k0Zn07PWF8+zx2+m2d5J5t+3MER1O8aBg+L6Xyq+OJG9kT0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHziWnCM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e305c2987bso23230227b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728676780; x=1729281580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3t/6WlSF/m01dr3JqwvO6A1PNlbPysSRIdrRHqnmAY=;
        b=EHziWnCMURu34idNgNXQl4xyRVcddHTweLctXq8iK+REnwjG+In+bNzFg46FA3Au2C
         7xGhtXVC/eujF80m2u/SpW34juBEq2HGbHLRWoJX2U8SqKWFNU+//VNze0g6Zi5oH9KJ
         UmNC6AHvUy5nMcGnasgtugL4iQ6eqMZX3Yvm/PlUgd5fWGRrPc5W4CRpa4h8lX8HUKzS
         7BhQSdyNS870ZjMtOIdCQGKNQExRVgyM4KvW1wrYEA5iIdhmvT3xxE/mowLv/W0Vn7Ol
         7Vvl6HGUsd3VmB7rTeJM8K762xrlsy+Hf+DsCu2axpZ4gCX6i5cQyOhk+SLljVT4StdP
         VnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676780; x=1729281580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3t/6WlSF/m01dr3JqwvO6A1PNlbPysSRIdrRHqnmAY=;
        b=WWlaJNLIPLyd4VC7nFJBbnriqOfXr3C+ceukxXQXODFYdKvakSr/HFUMPQdY4BP8YS
         slnO2wTZPkM6zBlA4pOFA4UAPBrQ2hBZoDFJHJRzZ+uGBbfEzbaKUWiPXuH4Ka0WLJ7g
         qPT169nmNNExoXh/qtk5cxpbJyKAcS5aHo7BMFLRuTCBT8QDlVGgVD9JWGEfuU3QkYcs
         7jIASHi4h5y//845EeAymm/SyF3XJeko0n8i3/rySmkCzTamHC2UUl/1UcpP9s4r3gMU
         FMe3Ugj6OIlJVlsg3Fq52RjC1mvHIZBtu7OQKvQCNOxSpg5TSXDWRhihyP0yY1gVmJ7n
         eOQg==
X-Forwarded-Encrypted: i=1; AJvYcCWBFm7HQOsgtAlcHLFuqIBtHO/Ni8cIGeP9h1QmWHFImyJFo/jAQcwQAY/3BkaAH6NCGOuZvqNcrydRMTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM3nU9qVNKD3vD77bQHU8nupnEW1KBxIT+hvqG+nuPHuKZENl6
	+XNCr0kWuEXrVE0Fa2dRTQe7pJNqI2PE72MsqNPgEZn8DOTMV46WZ5ypMvtV/7jwDl/x7pWXJqm
	+tjfCpCSSnh1ysBgGU/Rb2SdsUYNV6pzWULak9g==
X-Google-Smtp-Source: AGHT+IHjM2GvHz3Aq3fHGIQKpV063T+kfFhYOorOlX0bt74yIAWxcubkag8mG5yY3qwwQRASFB0kIRqgK4TTo+XYaUs=
X-Received: by 2002:a05:690c:5608:b0:6e2:ada7:ab89 with SMTP id
 00721157ae682-6e3479e1d7cmr37079067b3.26.1728676779984; Fri, 11 Oct 2024
 12:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011120520.140318-1-y.oudjana@protonmail.com>
In-Reply-To: <20241011120520.140318-1-y.oudjana@protonmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:59:27 +0200
Message-ID: <CACRpkdaWZ6R4wtTs_YqzbhSrUyfOCqd9tGWFP7dZTqp6v7ijzA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] MediaTek pinctrl DT binding cleanup and MT6735
 pinctrl support
To: Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Sean Wang <sean.wang@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Andy Teng <andy.teng@mediatek.com>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 2:05=E2=80=AFPM Yassine Oudjana
<yassine.oudjana@gmail.com> wrote:

> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> These patches are part of a larger effort to support the MT6735 SoC famil=
y in
> mainline Linux. More patches (unsent or sent and pending review or revisi=
on) can
> be found here[1].
>
> This series adds a driver for the pin controller found on the MediaTek MT=
6735
> and MT6735M SoCs. The two differ in the last 6 physical pins, which are u=
sed
> for MSDC2 on MT6735 but don't exist on MT6735M (since MSDC2 doesn't exist=
 on it
> to begin with). In preparation to document DT bindings for this pin contr=
oller,
> the existing documents for MT67xx SoCs are combined into one in order to
> eliminate duplicate property definitions and standardize pin configuratio=
n node
> names. Necessary cleanup is done along the way.

Once Rob is happy with all binding patches, my plan is to merge all
except the DTS[I] changes to an immutable branch in the pin control
tree and then you can offer that as a base for the SoC tree if it's
needed for the DTS[I] files.

Yours,
Linus Walleij

