Return-Path: <linux-kernel+bounces-282235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C5694E131
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B6E1C20940
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A219F83CA1;
	Sun, 11 Aug 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sAlbUJGi"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FFB50A6D
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723379600; cv=none; b=SwBr4Ou179zL5J3HiUdve+1y+JTpJ5IDfRykViu77AKL8IrC9oyWd4AtZEAkjczf0MbH/u8HBqoPOTNNj5S7fij2HW+tm3aqtjl4t3ADY/q6W3wAR4s1M0bD0DxCCazSyZHMzjF4XddEhKeXwhWTLeyrn+SECZy8SL9lEOxBV84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723379600; c=relaxed/simple;
	bh=H+R/OmjOZMGBgdB1sUh7zyOJvKewZSh/I07BEcIL2LM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pI4IDIvJP6RmXU+ccindFBvx++gwBD+3SAdaenJKUyxGIy7EHRfJLnLqNhDS7aYtq6uLx151Jalqr4DjezdRGjMcUvaDhp9o9DO/yqQPLR4w1qw9o87KBRmBLhdGI5Zg6PXV75cMBAtyalaHK/6FO3PoXzaNgjPCcev01SJ+CeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sAlbUJGi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so23437225e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 05:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723379597; x=1723984397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kt1hLgivy8d0ZroiWVINLl4zitCmU47ZCc3ffQBmI38=;
        b=sAlbUJGi22xg3oAbpTKAltoYYnZr7G84jhQieUQBLahAOpUWSFrTg//dLuxO+shALk
         AkTuIOrKbnFjR6tuiZF4M9Q9l3k3uIX37hx0CZ4iNQzFJPXHtFMN6TBSkjSyAyEZ86Sx
         e85o3ch1k6aZbCB65Ko4hScYPhP1CK5iiHQu899bQzucLpMrdrjB+ZuQuaDkRkm4621M
         FKAm27F/slkWCbbDuHu1U4x0ihHfv09s15pJ70NBda2jCYH+Ie/uFzObbaRqlWebPzWH
         n1bVZyNU5pojdDYkQaSXD3XiVz1UxqKCCYVY5hp4/HPesSyaomGbGxwYWiItjvjzu5+W
         bisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723379597; x=1723984397;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kt1hLgivy8d0ZroiWVINLl4zitCmU47ZCc3ffQBmI38=;
        b=tSIVK9bMuVFB+WwlygsoqvGj1SHTuFLSjH3t4A6QCtuToRQC6BpnUyhHCOPT+Q4SAm
         JLtl2P6tm6yrDygbgG+kmhU82C7YRK7xW+b18lYBPfUIkSWStKCzGinD1qrUi6kyT0+I
         DvYP2qZam6sgRSPjIZKPBrGIiGtOsUNPhjqQDhmA9aOX2Npx6x9UenaF6jZ2iN1E4kQz
         6u5YlZX3td7MhPvSlF9yDf00mODL5lg4/ybI72OmOvJ2aSNE0InCmvMhO6/oykgeye0W
         pYFeSQ16cUurDOUH3R+7bg6054nNlAP2iuoW/r6GdyF9fMrhkLRObwlwYgJMAlXZTBY9
         7dCw==
X-Forwarded-Encrypted: i=1; AJvYcCUYmujeT+RKaB+ClrUPMdjMyqk0W9qMNRs3lsdgG7xyfhsnj3vC/0AHlQmNcJ6eiZ5ilZjvQ9MU/znIC5aMpNy46QRm97W6DoSwhI0g
X-Gm-Message-State: AOJu0YxANWiTwXPzq5HmlUV7aFPM1IODGAdfzT9wkHmxrs9ob1CmZZHC
	b4UcW/BhX/E4GQ3LuEscBG1XVRGm+iolvMCbs6VklWKfdlME5ccrOloXPIaaoqs=
X-Google-Smtp-Source: AGHT+IFq2LPBmSvGRCeZCydCnnAu8AxMgVrN9EiqvYpbrAorrsapRaJIkZ+sMbUiaGxYFDtBvfBkag==
X-Received: by 2002:a05:600c:a0b:b0:426:5416:67d7 with SMTP id 5b1f17b1804b1-429c3a52143mr47763835e9.27.1723379596600;
        Sun, 11 Aug 2024 05:33:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c79f345sm148055605e9.39.2024.08.11.05.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 05:33:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chanho Park <chanho61.park@samsung.com>, 
 Tomasz Figa <tomasz.figa@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Kwanghoon Son <k.son@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240809-clk_dpum-v3-2-359decc30fe2@samsung.com>
References: <20240809-clk_dpum-v3-0-359decc30fe2@samsung.com>
 <CGME20240809115500epcas1p34ab112e1a0da7247257b9cb8f7eafbe9@epcas1p3.samsung.com>
 <20240809-clk_dpum-v3-2-359decc30fe2@samsung.com>
Subject: Re: (subset) [PATCH v3 2/3] arm64: dts: exynosautov9: add dpum
 clock DT nodes
Message-Id: <172337959515.7186.17124909105014310373.b4-ty@linaro.org>
Date: Sun, 11 Aug 2024 14:33:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 09 Aug 2024 20:54:13 +0900, Kwanghoon Son wrote:
> Add dpum clock for sysmmu, dpu.
> 
> 

Applied, thanks!

[2/3] arm64: dts: exynosautov9: add dpum clock DT nodes
      https://git.kernel.org/krzk/linux/c/2cc6b908f800bd6440cc57c1c692449fab49168b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


