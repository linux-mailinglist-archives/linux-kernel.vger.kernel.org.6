Return-Path: <linux-kernel+bounces-192167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F0C8D196B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56B91F2339A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8A016C6A9;
	Tue, 28 May 2024 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmNMDcdW"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF616C684
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895766; cv=none; b=mfsObFX1HUeDraRQisD0YZ/FGsElruRobX7zg6D/7hr+5QYxWzkx6Ev8eQKjfs+97Z3P42lra3jFJ6oZeddDjLPBGE0dy7SlCZWZSzBmE6JbE/qR+pfawmVLTMg9l0mHtjNt3JQNyVdBEj9cgSHb8y3WEOYvh9FmyYk9xBUt+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895766; c=relaxed/simple;
	bh=HrLuMk+QemkYNFhy0HrMjcUhynlD+skk3KpAQxbcfcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9Ntgt+B/2Zd0AaofPXSjNeI11QDMyij/64f7SxwQE82D+kXLogdVetFr4mx+OHOaSvYBfEc+zv45jeB1uzWsO7iMnniKs+ZsgYTMAmGkulSCAJqsiwCpHd3jp/RNTVaCHahjhnkKsKHRHCNrJgWc2HWYYiranO8uA3WinavBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xmNMDcdW; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-62a088f80f6so29970967b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716895764; x=1717500564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrLuMk+QemkYNFhy0HrMjcUhynlD+skk3KpAQxbcfcU=;
        b=xmNMDcdWNuSwYh85TiXII5UFy4pcSeAkcqt9MaVS9tDMlWbCy09qyAPaLVddFDp7Zh
         nhd5lYz7SfCIjG+ku7aNsJUP7p621DR1agS5gzqyIJnPr0mLUPZZWyTLZjPY0J/h2bUe
         m1/CXxnfh7jmPFsW573fbp7ueXIGPrKcZ++v0SHFGHFC6+GNocEnrEHAxVbVk4ABFClP
         u32zoRHz0oE9uUmKWv9Zw8s9P089VKW+stsgzRN2DWunEjXRW8gjwWPdlbL27/hU3IGd
         6wo+I/c21dDPnjGd9QSZMdhvaIynYubfVOIvEAv/xs42XLL2K8lt8uLLVjE+NiHglJVC
         NHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716895764; x=1717500564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrLuMk+QemkYNFhy0HrMjcUhynlD+skk3KpAQxbcfcU=;
        b=BUv2gJoQWQb2xmN1USFcFSDGu9bG1alIC45+9rrXxwVbeBS77NX+BwHEVuC+qcfeFs
         7+5QnwWBGDyTDdtEFiAw3mlVwSCKEUMqaFydbR/FHu4eAnOSLSGJ6svZqsJsftolSfMp
         ppGVtEB32gROsYDAIIG2Av79XRMV+Q0t03PIdyx2b4aooRrWn6PDZB3qbxhyHQn4ZKcU
         9mS77H/gk1mVhXsWYTmNPNxg897KQFn25DqWnnPcVAx7FUHZw3QNWBrnT6K4FIWaoOfI
         ycKyzsWPyk6U+KZI/weIcL/qBQtD0SqPGFJiM1sGkQ05oHFMc14k0KFWCrYdgMCIGpjB
         noYw==
X-Forwarded-Encrypted: i=1; AJvYcCXX7XDKhbzdl2uboxGgDwB9pc7MpY9WpHZEQetzu4kaXDPPTyLG8g7JvFl2+4Y+mMGPlTczcvcBayPTr9q55/fUzS+nCeADoSm8CikF
X-Gm-Message-State: AOJu0YzLC+wXBCkZXLaThowqWI79WyfLd1000mwe5hWxfxEulKOf62Nh
	71AjrWGMlPKHF0dxorGuVJP1it/jyaS2Mom0mAegMUEVviTkd86NrTPijr+3bX/JSg7GIaxGZ96
	54BhguMyx3qbNsFdg5llT8GPPhxxAjmNTasVEDw==
X-Google-Smtp-Source: AGHT+IEk6wsE6F4jE8aDIDCXOolP04kWcVWKcPIVc0WwOa4C3mfNwJ2alb6IUhDHtVxsQ6/JzHOzIjBnpoOasKo/B/o=
X-Received: by 2002:a25:bdcb:0:b0:df4:e4fc:16a0 with SMTP id
 3f1490d57ef6-df542239ee2mr11528398276.13.1716895763808; Tue, 28 May 2024
 04:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515121634.23945-1-dmt.yashin@gmail.com> <20240515121634.23945-2-dmt.yashin@gmail.com>
In-Reply-To: <20240515121634.23945-2-dmt.yashin@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 May 2024 13:29:12 +0200
Message-ID: <CACRpkdYO_zr=OEZCv8LKtw+fNOwJ906ZVKyPhbbyA=9gP5XQgg@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: rockchip: update rk3308 iomux routes
To: Dmitry Yashin <dmt.yashin@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Jianqun Xu <jay.xu@rock-chips.com>, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 2:17=E2=80=AFPM Dmitry Yashin <dmt.yashin@gmail.com=
> wrote:

> Some of the rk3308 iomux routes in rk3308_mux_route_data belong to
> the rk3308b SoC. Remove them and correct i2c3 routes.
>
> Fixes: 7825aeb7b208 ("pinctrl: rockchip: add rk3308 SoC support")
> Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>

While you guys are thinking about the RK3308B support, is this fix
something I can just apply?

Yours,
Linus Walleij

