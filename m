Return-Path: <linux-kernel+bounces-401257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA29C17D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949182842E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB571DDC38;
	Fri,  8 Nov 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDEQ/1OP"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882FB1DB55C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054246; cv=none; b=pKPESf5lIrOqc9Rb+GPgrFe/vIH2RCAzUx1UE+iVqirjMy+7Y156XomqtrJbQy8/arYZHgFckUPKPOHECZU3PW9E0SfG8S531x3lDuB3Z6r2vs1srdvBxBKmsE3Og3Tmgs93NTF1C0tSnIvqTPfNOMPdJzqW0yagnYR+/EA3xWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054246; c=relaxed/simple;
	bh=Jl0lx7Gsy6iH5afi7dJma9NiuABi3ClmekHLbyLNYbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsxKCl23rpx6U0f0sRGcfF+1K0jAnNqGPvZG2ogb56nHpvWx+jAxDTm6CgW+2s6jNF5LPtS/UvEOD2fPa/GTzImKLGziuPH70IBU4BNpNI8zmrklmDCpyitc2RrN6GEHHusmwVkMSVqkBWV78HX4E80FnxnjN9ids3xm00s+apI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lDEQ/1OP; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb587d0436so19931261fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731054242; x=1731659042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jl0lx7Gsy6iH5afi7dJma9NiuABi3ClmekHLbyLNYbM=;
        b=lDEQ/1OPDXeZQgdRP9qaJxnG87KhKPu3e3jvJhAhGrG8A/rQdL/1hvXz0Uwt1ZVWYG
         GSGWgkKYsqWzu0W50Fyw/KGZ7t5kogR1BGiz4qPZUmZzLvV48CYwiGlQPpFTfbFNl0Hv
         lIlb5sILAcF2HQSdIxO4BmRDSTTK6h5VUbWedO2mlF6rhEbO9FFta2AYweH8rCORVaI3
         QfcGNA/dNk6DuQAYT9r2FyoD362qidhO8IUb4DF4VmyZlvInq5bRSKnlmlbN0Nn/ad9b
         TkBBVrXuM2F+EfNDTB7ZQyk5DlgyuzkL/E9oehXP1R5oNNAYFeBdJwkTA8md9g1ZSUZk
         JS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731054242; x=1731659042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jl0lx7Gsy6iH5afi7dJma9NiuABi3ClmekHLbyLNYbM=;
        b=Z0aQ6ODXThyM1aLQRwhXKtq7NeCj913ZDX7f3ymRSpGNmGJTcqbTy6S0CQ0upBf79c
         uYYo6VU1/2ykI0MYBjD2rNtY7JkmmtMX0Lx2PdLFeKOb6xDhvDW42VFsl7I6bvOdZO5C
         +A432ve/GhGTT7/ArQ064ZEeo4TfKLbSbxsKw7ElWDoNbANREutW65vqxK+/V8T0CtQc
         ZtQhMSGCq4g80ryr3zu4/e4A6NogF44btVZtFyERueV8RF8f7+QuQlGOXySJ8eROle/B
         TO2/6dsQOFTcDnn+L+YST595SS6ks3O9wnG2Xk5M2IxNipONgX/IsY9YTm6iBc1i8tWs
         p9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP5UlPArfMXARJUEvKqupeZpzOtxdsmNhF3Lv8LW8eSseX2eOBWG849WagdiUbYDLdK9gXjFm0dx4+KQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqONpL3gTfxGsahbQglUApL2AFczxrdVxb8X5GqZbpLy9jmo/M
	H0dx1h3i9+TIeZ2sUyUMDpc1rLkdIPIvOcn+9aNWIxSjlkGyL8mEUQZywa9xQ1XPHYSTrB6mLqb
	yT5PpcdwZPYekve8VLJHc0q7bDDUguUMAVVhmUw==
X-Google-Smtp-Source: AGHT+IEoi4h9cOF0NrDnDfN2mcJ8OQ9IS7ZeEM0xCssVYgc2FE/qjtdzrUC7fSlflKMcaF1UCWmg7W2XU/WUPP4wOug=
X-Received: by 2002:a2e:9a16:0:b0:2fa:d67a:ada7 with SMTP id
 38308e7fff4ca-2ff201b1d51mr9123811fa.23.1731054241726; Fri, 08 Nov 2024
 00:24:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029012312.3448287-1-unicornxw@gmail.com>
In-Reply-To: <20241029012312.3448287-1-unicornxw@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:23:50 +0100
Message-ID: <CACRpkdZB1RT=ATC1RKosjVyj2G1v4F8NYEPOTpfW16vmTG5y4w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: correct typo of description for cv1800
To: Chen Wang <unicornxw@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	inochiama@outlook.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Chen Wang <unicorn_wang@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 2:23=E2=80=AFAM Chen Wang <unicornxw@gmail.com> wro=
te:

> From: Chen Wang <unicorn_wang@outlook.com>
>
> It should be PINMUX/PINMUX2, not GPIOMUX/GPIOMUX2, see
> <dt-bindings/pinctrl/pinctrl-cv1800b.h>.
>
> Fixes: 64aa494de6fa ("dt-bindings: pinctrl: Add pinctrl for Sophgo CV1800=
 series SoC.")
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>

Patch applied!

Yours,
Linus Walleij

