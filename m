Return-Path: <linux-kernel+bounces-383152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C979B17D9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2841C20B12
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F11D47B4;
	Sat, 26 Oct 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jw8cbXC7"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A901217F3B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729944730; cv=none; b=H8Rsfutzts+9jv7vvsXU4awjW6/GvkeF5hVxUswIGV8H/jnbWR0/v9HM17Bsax0DAimotVOuu0Jp0ucsMqq0zs0Z5XOOeHMdCS8hETcssh7zdYvC+LDHVg5ZlZMJ/XnTw/ZwRcXEnOmYuxI/IHXpLjedDAfQ2uIaPYgKjHCY1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729944730; c=relaxed/simple;
	bh=I5Ne/vvklkREjVmexRxHU/F8r004cv6BA6FFj89lMo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TY0F2HYhbLYqIdon0lXorDt3xBNNvKN4UZkIEDvbvFjrcs4dK990qgNI5RZ//xhxattwtnn+oYwwA2wGaqLbaaBZ++ZzJ9TZ91EJtaSNcgcsFCNiIF4Z6fqoTOkX+AuY1LVaB9wQGaiWa8D83XvfOOnlPQeCApyKp47AHaF+vT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jw8cbXC7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9589ba577so469966a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729944726; x=1730549526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/M8UQSVOYdwgbj5CZajVmfuAcuFVgOKdwDSIzZcGcQ=;
        b=Jw8cbXC7zISiZe8XnWueV4ahMccb3LNIZiAQxHK8gSMEiWqzYbQt6RU5zck2vzZkNQ
         Rb5XccItZ/q5odUKh7wnC+SJWI5P3uimVGFhp6iw3mcrV+U/px1737TYXK+sDdEaYlYq
         Iq60d18qprcDdvTi3Hj4d+haOSfPIude8A8u3dUph5WV5U0kW4NZVfdhpYPqjkF7Mmr+
         0wl2VPx9dCGLUmFe0gbVWNFq+8VAwQHWm3omlKiTBnNQqEPeKLPEJX9mA3YMQB0JGThG
         A8FkfjiYtGD8Sng6Hvn7zsfENtvpBbGEOvZVEH2gKWjrMUrOLWWjypUB3subgTjd3T6w
         N8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729944726; x=1730549526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/M8UQSVOYdwgbj5CZajVmfuAcuFVgOKdwDSIzZcGcQ=;
        b=LSvM7qzURw1ztcbjRWUusZiVOc889seWLPPFIWVTkE8ivtKyS4SGzKifh4hFIlXlm7
         dp2Wjl+vXQw8nHnKrN2nBBe3MaS6R/Ihxb63E67iPXf/DPSRCEozKmZ4MytrWWqBs8RT
         T2S0ZiHHGcwA2ZhGJKjtO+A0+aSwhGjeNkkIC9b6FrvWTFTaw7x9q6Krc5PB6DwgqLPH
         RhkrmFhSyk8XT2E7NyZ2NLgE63FlkBMDl1vOS8FRvyobAc0QOGRzTshE6uimozPCiNqg
         dSlfWBD/UbMqxV5xxQxSQqHejmFd4354d2exqGLJ+yRpDRcKAhldcC1ECp1c3pH5kKnw
         Pe3g==
X-Forwarded-Encrypted: i=1; AJvYcCVoXYpjgMTpJSePcdxEb7wHs3vF1EOYl/JNndTITw9i8Hhy2SmTYbVGIxbL5ggTD1F0MQ89D01L/WRttS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Z+h/c6zrH4On9DoNhRat3/sdJP/8pU5EZNxoiPc4dV0zGiqo
	lldrECkVUKrCD0UizYoDrnSLRXhELYmh3mcO4xUDThzMy/fX9mnq6ZRsr5bFILI=
X-Google-Smtp-Source: AGHT+IEUleyfh0n6tWnMCBjtlyAZ3mGKhEds91T7wra0PT/A5QLxjmifUACEHGa/AYzNQ3vXhOB/7w==
X-Received: by 2002:a17:907:86a0:b0:a9a:2a56:139a with SMTP id a640c23a62f3a-a9de5d2a83emr74680166b.4.1729944726111;
        Sat, 26 Oct 2024 05:12:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a089168sm166821066b.208.2024.10.26.05.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 05:12:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] arm64: dts: exynos8895: Add cmu, mct, serial_0/1 and spi_0/1
Date: Sat, 26 Oct 2024 14:12:02 +0200
Message-ID: <172994467264.24870.11860096857422265131.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023091734.538682-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241023091734.538682-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 23 Oct 2024 12:17:29 +0300, Ivaylo Ivanov wrote:
> Hey folks,
> 
> This patchset adds device tree nodes for multiple clock management unit
> blocks, MCT, SPI and UART for Exynos8895.
> 
> Exynos8895 uses USIv1 for most of its serial buses, except a few that
> have been implemented in this series. Support for USIv1 and HSI2C will
> be added in the future.
> 
> [...]

NOT applied patch 4/5 - I wait for bindings to be accepted by Greg.

Applied, thanks!

[1/5] dt-bindings: timer: exynos4210-mct: Add samsung,exynos8895-mct compatible
      https://git.kernel.org/krzk/linux/c/e54eb0465e548a7c6115e336ec5cfec04bbe8747
[2/5] arm64: dts: exynos8895: Add clock management unit nodes
      https://git.kernel.org/krzk/linux/c/fa986d1073805154888a788eda38d46a796346e8
[3/5] arm64: dts: exynos8895: Add Multi Core Timer (MCT) node
      https://git.kernel.org/krzk/linux/c/9ad6c3bd1bcbb73e2a5723e13b9d06e2296b07e4
[5/5] arm64: dts: exynos8895: Add spi_0/1 nodes
      https://git.kernel.org/krzk/linux/c/a5541d737c8de71948bcdaee912bcb6b0781af7e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

