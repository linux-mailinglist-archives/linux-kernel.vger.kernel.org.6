Return-Path: <linux-kernel+bounces-539981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4660A4AB93
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E343AD56D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07E01E008B;
	Sat,  1 Mar 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qW5sj1wN"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2BB1DFE1C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838414; cv=none; b=Wj9rkMftuww4P3F/2/N9/p4GTu1VPUi5wVhf5KKThBDeoC9jWy1LZhbyw3481BFO1A5Uxd5ySgts1GfmMJu9AuyFxBSXIIeE5xkTpvBc+70uUAINodfTRfeFWWn47uTit3gafLfuSf+N8NMjJQWe4qkWv8/qB1mmAD5GJiZwJpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838414; c=relaxed/simple;
	bh=3OnlkhqkOzm83q2muEV8j1QVdQCjg4YiqkJ/xDPT168=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lcP4eyL+CJd90hJS8LgQTy2gliiVW06DLZiylz/C0lPqedYGZPAV+HEdnfcmMnbx0MtMTGda/mce8nN/8Nq6neCScLhhp/3rW4NRIjK0auSrhHSipIv68B2vTMDx0FwjCNR+sxZzlclZPDwMUyGU5sp8mIzcQmOFv/vUI0YRUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qW5sj1wN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb9e81c408so66870666b.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 06:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740838409; x=1741443209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnbdHsHTQ86fPzgXCuKmjr1fO3E1oZYk9t9Lff4ycVM=;
        b=qW5sj1wNqR1fQD3JbyyY0DzqLPpOoyjHNyqJEzFiwafE2kGVFQwequKWKRIci7/Zr8
         Xq+H5hOyW39pMKT945DaA6B/vndn7teU/9vso1YqM0LMel1/Rv4VyaEqztA/cgoGc1n5
         uwGvjdJIIXcAWiSoeurByXkZfTDQTu5sVbM9gu6c76tCwePNr40DD7wFtTpBWBPYv0Mo
         /K1hWvd7jxX3zewOTJBRkYUJCxh4k9bUlfOqNsLtD9q31f7eO2JW18Lf9MGr5mSBecJU
         LIfHhR8FXuKzvDPDd29x5U0EWWrXmS2QjB2goMtOWJCaLlxskL5N02LJAy/6gXR4kB6W
         XEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740838409; x=1741443209;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnbdHsHTQ86fPzgXCuKmjr1fO3E1oZYk9t9Lff4ycVM=;
        b=ULECPb82ao5YuXAGgGqcTQymQ/oOMuAWruYBWrt3we6Hs3Q1/0zLvxplpWSiY22MWy
         uFYSg8T/wWw+VhORjIcvdni2iWSgmf8AMGFRNLkpMTTunH/+s93RSI/vAX90awwGmzqC
         yld5HdaS8SB+J6J2tu9wcS5mnLsOATO6idLxWmmez701mNbONR1qfblBcXj7kAGkml+y
         QZ4rNEGVABA+Qd5hN8ANSBwJ1jvTvgQWg3vKr8LhMBvtlJg7gSuF34oO1hLtLT8EMSZg
         yzF46CVQu/o13zjZwYOWYRcR4LOd05FoFo2NYSE4/sjSKmtVSAQWDakzVh6yZI3RGKAH
         XGsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV54crfD56E0M4I6y8YrebSexRJSOKhEV0gQl7AOJmLIjaztXNaACZohmap0oB0jON+W59q3ZL9Df8OPuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCUucm21DlRU8bfuhiaz5g8E+QdOvURrVIesCnDFIXuSRCDgv
	jYgz8eMkebD8ShMJKxiO0XvMA0inndZrhUiOkfWDSxAvkB/f1JXEAo3ojyih3ok=
X-Gm-Gg: ASbGncuTEEM0z8QdBzqU8peH9inEorLbxkk0WwdpitKu/R84+Hm1Ioeux3AqGPAO3AG
	ryC0Ns7ABPcT563fFrA56WlZkhFzMkEtvZecngHuJ6+KJNOqL9F7Dkv1L7fAPw53hwqLqubdb9Z
	nwbD1uYTB7vliqEqi8RUHwXgN7FVakessg1gdfdi6ZxvFzLo1ydrv5KRUmgEvwT3kfy2/28u31x
	NRrpqgwTMenF6IJNgguaTbEZJyocNzE82e/D2ogq3U2uQlAUMOnC+qUhb7TRqoieGgZ90zvhnUo
	RfBZQrfwWHP+Ulziw6RfTFYNP98pQo47Y2h5OwZ/Jjktrehru7MyGJrQaU/w
X-Google-Smtp-Source: AGHT+IFbAre7Y2ts6f+9wyz3jeSARqJEVou9IA7TgraYYXlc+RIXaNzzDk7QN2b0NMZOmmxJ3LBOAg==
X-Received: by 2002:a17:907:3203:b0:ab6:6176:9dff with SMTP id a640c23a62f3a-abf25b120f2mr310555266b.0.1740838409375;
        Sat, 01 Mar 2025 06:13:29 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9cbfsm485532366b.14.2025.03.01.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:13:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250223115601.723886-3-ivo.ivanov.ivanov1@gmail.com>
References: <20250223115601.723886-1-ivo.ivanov.ivanov1@gmail.com>
 <20250223115601.723886-3-ivo.ivanov.ivanov1@gmail.com>
Subject: Re: (subset) [PATCH v2 2/3] clk: samsung: clk-pll: add support for
 pll_4311
Message-Id: <174083840636.17657.13627418806102780540.b4-ty@linaro.org>
Date: Sat, 01 Mar 2025 15:13:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 23 Feb 2025 13:55:59 +0200, Ivaylo Ivanov wrote:
> pll4311 (also known in the vendor kernel as frd_4311_rpll) is a PLL used
> in the Exynos2200 SoC. It's an integer/fractional PLL with mid frequency
> FVCO (650 to 3500Mhz).
> 
> The PLL is functionally similar enough to pll531x, so the same code can
> handle both.
> 
> [...]

Applied, thanks!

[2/3] clk: samsung: clk-pll: add support for pll_4311
      https://git.kernel.org/krzk/linux/c/f33807c30664d2b134ba17f2ae0740acbe91986a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


