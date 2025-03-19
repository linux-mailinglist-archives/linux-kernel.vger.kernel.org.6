Return-Path: <linux-kernel+bounces-568914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8D6A69C05
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86417A1741
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6641A21C19C;
	Wed, 19 Mar 2025 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bFqEJe/p"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A06121B9C5;
	Wed, 19 Mar 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423240; cv=none; b=F6O1Ovk1nHN2PIkd2kBF2Q6URjaeJxbL6LvppkgTrtoTlYKn1URp5+gD0ygEHDa2Pn3/WoLqdA+NQlylEQRjmcNYucC9sr13Sy+/JL+J+PhcxZUpp4ZIfGaC0nSA24uDZ3Yr40Dk+uYsUYcfLMvBXp+BXtzCWkVf9lJbz+iLdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423240; c=relaxed/simple;
	bh=/QdNxqZa72CttkJNa9ZShSXnJNwcyaNxbGmUvZxn2Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oB/Dz52kSiSVL0efLouukubfPhD0XX1Jx27Bk/CjzQdaMSs46bdYHDwHZS2rvvgeHNVqqrMlFrglPY8P2zsiD6Qyf82/3sXexj1S59hiuOiqsSLmMqYJPQFRWrifw2TE8C1cJ88PYoaVHqO8ll582tvn4ZDO+2S+/Vu8sm7tKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bFqEJe/p; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225b5448519so1325585ad.0;
        Wed, 19 Mar 2025 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742423239; x=1743028039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNYERNhRSmEwITLfpZYCCLoI9bGljSTelP1WrYbn7WE=;
        b=bFqEJe/p0b+sfVkoTEQ4QAfJXxfdLR2oeU7REoJbMyH+96lSzf0alwKIdrz83025ud
         ODI/L3cHudzL21+MrcocYN2/x8jD0PGK2ET65S2ywY4hGm8a2WaOpUmVYaUA0WDlhqAl
         lCrBMwyXOIkFLXFt+9WcNnu53BSf12E3WSm0Ud/yrMm+uw1idgEFuflTaH/ObxAwwZIS
         8EnqyeBdjp0qqdU6fBneYOZX7l6ViD8+LVVdQ/nnbIFgPz65/fGEvLPWXwJ1+dHxiCzG
         4NGyTUAjSj3h/t5J3i5luRRLYgccKsnm5nr/rXaRtXTzOd8NkwC1Ja+G6bsV52eSW17F
         NPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423239; x=1743028039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNYERNhRSmEwITLfpZYCCLoI9bGljSTelP1WrYbn7WE=;
        b=dWvunvtT/NQfCiu+GB57MPBwMP1VGTFd5n1/7RpVbu92LHKGz7I/QQNYrnq6s8OUrh
         yr2gVYVlq2h7/iA/UBoDSIpL2H9dTtPpBEW7xLNDnP/gFoRYUZcH685MBBV1K//fawwD
         xlxLRsDJ88LKJBjNhOT+aKJqqipIII18VBepqEV//2wqs8o2PjVScxXSqxNKRv/wvpnk
         W6Pyh+1CZfvCEgJupjwdrRScYoSaNp9NmkpKyicA8QvZov7OChQKG47c+5W/oEIV7qo2
         27IAKyn61VnRtaO64kXUkkpBvw9qCzO0y+bLEqNzmeWg5fuLosEgz8ibHrPEw5r7DQTl
         RocQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaWRRNmolVindMvsR47VnbMCRgcxj9tij4g8e6dBi9MhPffs5ajuptBCvmYw1YukYfI8quUlRHgZp9@vger.kernel.org, AJvYcCV8d564YBExK0dc/1FPCfFMgrmPrhDDK4AlfHXHy4+3osTo47nRe2NAGRbUuk4v/HQu8ZaACjclS64ZVwGy@vger.kernel.org
X-Gm-Message-State: AOJu0YwzeJ1Mey+DRemwl6m3b5mQfRoHfosm1HcmBmzO6zvCHxJLKhYu
	nZpll0iZzaL3xSCmfY6LqduFoccZyaGMX3PheC3V9zOzj/w1MC6MMmnkYYvxGRXBOxGna/N6u5n
	MbDVkUPhf2FSMGt+v5WeoS7kw5+0=
X-Gm-Gg: ASbGncvBqgQOWYjwQkSqzYoZsXIMBR7dpinOA7XRO0Y+8HbFkaliQmdBFykQ1oFjxBz
	0GPdvZCgUPcQ6IPt8Y1030eDqeJykSjrE8cYzRAYrMnMRiByM/qpoCAfmlTsGUqn+S1evy/XTDy
	DfVGQye//tqdZPSOZpd2XaEInIL59KdrX6FVw/YFAPAS4uvUZarTRPX/oST3o=
X-Google-Smtp-Source: AGHT+IFAWS2OHB1m+Vc2vxoZrF2uLP/QolfYKiuDmkj1RM7T3/ht3qZtnjLSYd3ujmhvShSgAjncLaYsLA0qAzPhp6U=
X-Received: by 2002:a17:902:f693:b0:21f:68ae:56e3 with SMTP id
 d9443c01a7336-22649c8e7e9mr52422045ad.39.1742423238640; Wed, 19 Mar 2025
 15:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319190150.31529-2-funderscore@postmarketos.org> <20250319190150.31529-3-funderscore@postmarketos.org>
In-Reply-To: <20250319190150.31529-3-funderscore@postmarketos.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 19 Mar 2025 23:27:07 +0100
X-Gm-Features: AQ5f1Jq_ZECwLUjQyBqdaX25O07PIZ7e5glTPQT7D1by9iVmLwmBmJhYAj9-cEY
Message-ID: <CAFBinCC14dxYHWO1yMrGyvQigVR+h9qGaxUNjL49WXh-p5XMNg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: amlogic: add S805Y and Mi TV Stick
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, Artur Weber <aweber.kernel@gmail.com>, 
	Karl Chan <exxxxkc@getgoogleoff.me>, Christian Hewitt <christianshewitt@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 8:02=E2=80=AFPM Ferass El Hafidi
<funderscore@postmarketos.org> wrote:
>
> Add support for the Amlogic S805Y SoC and the Xiaomi Mi TV Stick (aka.
> xiaomi-aquaman).  The S805Y is very similar to the S805X, with just a
> few minor differences.
>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

