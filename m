Return-Path: <linux-kernel+bounces-236237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF6C91DF2C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91204B21882
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7F614BF8F;
	Mon,  1 Jul 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hb26X+hW"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C49214B09F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836864; cv=none; b=odJihGurTsT8KodX2ZpcfC4EWKn6409GngJKGaokFMilACa6Y1Pj/bTZQ9iMjJywrccGAUNI4OrNTWWMfywW7Jtm1fwgzW1xGJWM1m1Y5QSJTt3clQ8FSoRMP0VrHO701Amlb070hXsiVQdF76143NmOQfl8JuZQqeH4wOXqsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836864; c=relaxed/simple;
	bh=DKtxpPgVNtsn7K3hHeygsIzw1BFxEqTpvfTeM+AQT+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pFHRtdWFNG9yEH0Sgp3Z0rI4So924Dpo0PLSr/PnpCskOw7Y0RpvC4WhmBaT3qdGjL2/SV/wESknv6v9o9XRtgNRSCfSrGAthp/Vno7RKvGhEUdVCbhaQZaWicAVe9ih24VicZ/T45ZTaBMnOgISKrheT9t10F2QG+2FEq0d8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hb26X+hW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-365663f51adso1823015f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719836861; x=1720441661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbKJ1+fHrcfsxoNPssv5ufXQjSB4NnSOZ79R2VobUDs=;
        b=Hb26X+hWtdxku4kNvWXx2QTDnVXqfsxei5cJwNrLYvRB8BZ2vid8FHRGW1/UnU27Wn
         xe2aq0si6KQ8yIUcNgEjjh5rzdVDR6IYF96DmAPlgqLQmQBUMvX4TObcGPOu6GDpTXlN
         oOW5mq81QcpjRsP1Qo+Jg0xXqhSwcjw/uRZyAnridOfHTyifQzJIEQjIJUUesdsleCxS
         gS85qnhb6qErGTozxsyGFvGWCKuZ87UXCRvzp7CVnI+hhARkLLHSQP5/+ViLCr3PedNR
         MoxMmgkpqTs0ZWawGcL8g3j2ioyAh8atXsCfki+ZrFBNAPau9Fai1b/s8I+fsR8sajDj
         kRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836861; x=1720441661;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbKJ1+fHrcfsxoNPssv5ufXQjSB4NnSOZ79R2VobUDs=;
        b=XE0U+5yyxz5yzqSwnMJbDEpF+zCMHooC1jNsBeqRCSbUPVQbVppxl2p7/uJqzonvwe
         Aqbf9VsaIt3gF1wZFgwrl0d8+pcyHucGs66Jb/fdQ9YvvNXUIrjtG+MHSjRDOmYL2ixQ
         psPDRpMwQzoZo+SZ7di33s0Fy6O67bTkiL6/udpoiRGAhA4wnh3RYitq8zvCJH60Wdka
         LZmWV2H/f7jJLtYd6x3/F3/tJfiYDvJdeZg6xlS9h/FsDUmrfIu3bwSq9+sZ46AzxKY5
         RRJKcznIuWujpfBM0Sezz3JM2V9x7ymDLmfGzntlw8WnwE0wZOWnc3vx9uOQQISn6ckL
         8mpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhw48Vm7Ku+rgI2h1Gg6x+PYx/z0rpg+UvuKjCdU4KhwdnKxk/xt5jRE7uLWZo4UhhA3qp3hy48f2tNCLO41YQ/Z4rBFLoxBZNI3AL
X-Gm-Message-State: AOJu0YwHXtbw51xY0aMgfB702F9gcDTxZ9kDEUXxJRTQbOpKZTRhvX8d
	dc64SiRT/oeZO5xoNQHe2UbSBFrlKK30gSpa5rmQTtKz8ImAUoyPHSwnPXgSeNCjMr/ssNWy8kr
	R
X-Google-Smtp-Source: AGHT+IFH35xxvg5N4AtgQdVncudDweLagl90Mb/QWe2ODsQ64shBW9nGUOgVWRgqPVDQN+ts6wv3Yw==
X-Received: by 2002:adf:ab17:0:b0:364:a733:74de with SMTP id ffacd0b85a97d-367756a9394mr3104569f8f.28.1719836860636;
        Mon, 01 Jul 2024 05:27:40 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d90d5sm9961414f8f.31.2024.07.01.05.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:27:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Anand Moon <linux.amoon@gmail.com>, Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-samsung-soc@vger.kernel.org, 
 linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240618204523.9563-8-semen.protsenko@linaro.org>
References: <20240618204523.9563-1-semen.protsenko@linaro.org>
 <20240618204523.9563-8-semen.protsenko@linaro.org>
Subject: Re: (subset) [PATCH v2 7/7] arm64: dts: exynos850: Enable TRNG
Message-Id: <171983685912.414640.3760379043384228947.b4-ty@linaro.org>
Date: Mon, 01 Jul 2024 14:27:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 18 Jun 2024 15:45:23 -0500, Sam Protsenko wrote:
> Add True Random Number Generator (TRNG) node to Exynos850 SoC dtsi.
> 
> 

Applied, thanks!

[7/7] arm64: dts: exynos850: Enable TRNG
      https://git.kernel.org/krzk/linux/c/64c7ea42fcc2b972fc8d108642f4b8fabf0999c3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


