Return-Path: <linux-kernel+bounces-269354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4099431E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4C21C24345
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56096193079;
	Wed, 31 Jul 2024 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mc8UuMdW"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C991B1406
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435660; cv=none; b=jAH7Lb7KGUC7MfapT/EizwSSzcQSYjdB/j47/pbGNgfaLHMAWLPfGVrip3Vsj0u8b1dhyax7y1l81D0k6i23uNCniGUMMG+mOzRQBzJqZHN1snTguq1btTYw01+5uPiHe9wVBa6LWurKl+tPkD1JBWFum/ywZj3M98XkqYkZLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435660; c=relaxed/simple;
	bh=ytvkCSgLKlKnXnV2Hzh3Ns/9Jy05DqiloCwaHB1hxzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tJUzNLxOudvqcGYyQWYRng0CgR1yE/I7Bo80zvOlGqF5hTVWJhSaCjztWRt7NNsm6Ljl/dFmNzq+t0GdAN3jfHilBN8cZHdUSWndXlYqsmrZ111WDFt8McDIOjt0y5YtRa48YUuAbG0ZaUTmqEAL0m4W4/Y03V5IbUqbtR68O7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mc8UuMdW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36887ca3da2so2701536f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722435657; x=1723040457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSqOaofEO5POC+mJL3PUsgfCrvCN5J6u6ZevBKAvHRU=;
        b=Mc8UuMdWXpeCBj8ossOCq4MFPvTwTLnDaOpM+OFH16yUN/iPVDln12fg1w+E/8ittV
         f34384WqFIgYZqUq6a1csuMGq5Djz8AZP0l9GgPZQVE818v6qVg3fT+uraKXbr/l6lH0
         tnOyoC946e37iCNa25sFqsXAIhjyuHWiPk6UHTGTHk8ehAjXXcj45Vg+si4fLYNIZ9s9
         2b1lcQ6zBjk3Zfyf9WpSRD/H8HFkK/ftaACUmB3d0xmQSgTgUh3CcwS+UD57hWBkKvwM
         2sP+G/qQw6s1K/CQP4/oeYFAcBTOeQTvOqXzmf9/Uua/82DeGbe6zKYjdmFRwSK3xge5
         eW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722435657; x=1723040457;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSqOaofEO5POC+mJL3PUsgfCrvCN5J6u6ZevBKAvHRU=;
        b=rKNMxz2xiH5Ed1FG9V62eggF2TBluCcvyPH756HUOiBV3+bE+anSTLos4nBSN81znK
         GZJJqsJ7zkecGLaG9l6qAx7xmo6W5Bdyc7eu4aJnRNfL5fbWnBELLNtO9FTelTW5wBVX
         chFN46AsZBOFgbZspSrHU5wnbIaLjb06cWttucgUL/jsQ6FWmFpPmuTXbOFNAxKxjvwB
         D+yaLuTGLUb33ax9wheOvFWEzcsTILpoI5SaszfSdXmNqQsvbbsG0dHfJ/VPqbP1II0d
         4YdI+/3NGengbXyBOTjrpkI5GQFj9XBHzvxeB4tBD5R8g/+IzmgMD4s9I+Z1fgKn5X/y
         yg4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVa1Aznla9PXHfGTSScB0P3qbCIixpfRg5/s5+VEKsD6sS1XS/1AgCvVMYZTTEvBZn6o/757Qmil61PVn5isrD8s1COCeKtuRUFb5+w
X-Gm-Message-State: AOJu0Yz3vLBcvegiyAM3WLmUWfLoCSotFv6J4rT8JA7RHiMT62y+FskY
	niIrwFZOEfQiJXWUd7/DzKnG1vcFOH0Zc/a5yxvEBtSzBT4CzS1sD6sZIMXDOz8=
X-Google-Smtp-Source: AGHT+IF8cZAUIzwi2BdvTEoaAp7Ev+Xb+P31buCoG7nk0jYrnENn135x7PpsFSsL2dKIwhDwVzjNAw==
X-Received: by 2002:adf:e30d:0:b0:368:87ca:3d85 with SMTP id ffacd0b85a97d-36b5cf00512mr8502223f8f.29.1722435657126;
        Wed, 31 Jul 2024 07:20:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c02b1sm17292561f8f.9.2024.07.31.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 07:20:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Mateusz Majewski <m.majewski2@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240723163311.28654-1-semen.protsenko@linaro.org>
References: <20240723163311.28654-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: exynos850: Add TMU clock
Message-Id: <172243565547.42492.1072397968108986657.b4-ty@linaro.org>
Date: Wed, 31 Jul 2024 16:20:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 23 Jul 2024 11:33:10 -0500, Sam Protsenko wrote:
> Add a constant for TMU PCLK clock. It acts simultaneously as an
> interface clock (to access TMU registers) and an operating clock which
> makes TMU IP-core functional.
> 
> 

Applied, thanks!

[1/2] dt-bindings: clock: exynos850: Add TMU clock
      https://git.kernel.org/krzk/linux/c/01ce1bf22adc0d09d906319787091ce784cb9914
[2/2] clk: samsung: exynos850: Add TMU clock
      https://git.kernel.org/krzk/linux/c/79b918aa997acd5066c7962502b1daaae76b6911

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


