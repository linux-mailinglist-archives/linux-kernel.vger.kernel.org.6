Return-Path: <linux-kernel+bounces-279181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF7D94BA04
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506CB282080
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF9189F27;
	Thu,  8 Aug 2024 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRxeQddw"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91873189F2D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110519; cv=none; b=qgmdJgxC1kbstyXq4SriQU/Yg/sxX/ddDYLdTiYp/D4OnK6Bao9uXqU3nic70vZZOBoMvw70cK38JNr/P7SxaxCk3DD38AoPlULdTcfgckOXQB5KoMxsOOH1XqICpYy8tyNp8sHGmCayfEVcHaPbFgyYdPz6P79hpgFVWaLaNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110519; c=relaxed/simple;
	bh=t4Oi6qrhhn59SzTgCUimyxAUyoyLx7ZjHE7Smpgi1Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fF86tL28XQX6A4iU+r/374Dw+ZgqMngOCA4mKsvGeDHVl4R27Zc3DWK5FMANqxJuy5V49UO/mcTFs4SBXKXKS85H4S9+Exr+vYDg1HXknAG371RFohO9RZH9pvw4WRvRHOxyzfX9Mu2S1RtsCnlciAqn318lVnaCs2Evd9aRaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FRxeQddw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so847022a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 02:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723110516; x=1723715316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTXsOp2Q2opTktrwF5DF7pgCqzg6HCRDQctoBjhR6tk=;
        b=FRxeQddwVbqWOW+u4SFetDSrpWXuf3dnjFmETwobPf+DaVuMkNQDFIrQpHxN0myNJU
         rGJwvn/DIkeUaexE8kJBzyTB0w1wX44NtPZFbQMln/ZSfu484EkeclOBkr8COgJZ1r3D
         /hAX+2klHbdHApL4qlbfcmd+jX5Cu+Liq0haecav2JPdxCJSPwQIRnAX30mFIHx37Gir
         Ju0jh81NnB21dI51cioCCzD55eq1bsOb2VJGAdO1l+L/VsJ7190E+mfnc3NW7eZKlQXq
         TPha6zoVJZy5muczJ/ZopcT7Il2xYSmUZH75USyyTGVVi1minM6lXjI106CmwwrKCGaY
         5Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723110516; x=1723715316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTXsOp2Q2opTktrwF5DF7pgCqzg6HCRDQctoBjhR6tk=;
        b=C5AvglQtWyzvdTIwx6eJpb6tDGcGAAfQ8nQv5Nf/uGJmyJh6mnP2dBI2goRyqRY6uq
         4UpWAF/DwxoNLBmuk3AKYKHV5/o6QTsWkKUUESNLp9l8ytvD/OZCXAqsdy/o8CC8klmW
         5OaSupGo6rbNq9TiLX5uCbYtNM3amn4KkPUFSSlZXNNsOvkxdCLrYOaWATCyskZs6+LS
         7FVUv+qGPs4EmtmjkeucoxoYOyM1jzxCFrhjiL8xyDBb1CIHcl35/PSPdB14dnKBg7NO
         3TfNhMd2BQBElFxJpFQZ483i1gtm9zbb42hm8UPj3rMOXRWv/6Pe/FqEHS0BK0PHOb6C
         Hs5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZA1EG//bKhSvkObqWdGjoKSeOpCgBsafGHs2ThkMd4pJGp4suUXTL/PprVaIDahiFuMv8/Zy316hbHw+3X+tIOMqc2sDWTOsP/Cg0
X-Gm-Message-State: AOJu0Yy/FwwSbjoTHy3GoTke7BAK4QF6wu1D9XZ6sPNP885ec2eK0HEP
	g4PiHDx6U3zJuNHx016U2kmdDTxX2cTnZXCYS0VX9ga83QY4+DY6GfcUOZ/MPjc=
X-Google-Smtp-Source: AGHT+IF3xoL+kb9I8cnpq9kAoMaPYR5z6cI5EjyOnhfkzCaXFnxM87pPrTSXdTQKrmq9f9JMKookJw==
X-Received: by 2002:a17:907:f788:b0:a7d:a29e:5c33 with SMTP id a640c23a62f3a-a8090d7d46cmr92028466b.28.1723110515904;
        Thu, 08 Aug 2024 02:48:35 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e849a0sm719911966b.186.2024.08.08.02.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:48:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Virag <virag.david003@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 2/7] dt-bindings: clock: exynos7885: Add CMU_TOP PLL MUX indices
Date: Thu,  8 Aug 2024 11:48:26 +0200
Message-ID: <172311048731.12963.10299933550707027039.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806121157.479212-3-virag.david003@gmail.com>
References: <20240806121157.479212-1-virag.david003@gmail.com> <20240806121157.479212-3-virag.david003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 06 Aug 2024 14:11:45 +0200, David Virag wrote:
> Add indices for missing MUX clocks from PLLs in CMU_TOP.
> 
> 

Applied, thanks!

[2/7] dt-bindings: clock: exynos7885: Add CMU_TOP PLL MUX indices
      https://git.kernel.org/krzk/linux/c/59baa83e30f82b74b4c7dc07c20eac9899b6c0c6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

