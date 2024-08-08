Return-Path: <linux-kernel+bounces-279185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE294BA13
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73B6FB2172A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB41139CE9;
	Thu,  8 Aug 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlhkdyZB"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3B18A95E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110525; cv=none; b=bsdbTEHPANJuNlNeYz1oVA8kzYKMcyxfTHRzkPvkIvhlHHOZFQHgO9uN/0fvIOffsAC8GSVnHaBjJkdUWA4/DpqqCn07zEptLWHIJNyKefFuv7sSaaqdqSa5zGvz/TJaDsldVTQkXGs48blmjV0sApyVS3GZbdZoketvtETtgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110525; c=relaxed/simple;
	bh=2+54UKwY+6OZ3C5jMc4dxdsS1Mc8kvt9ihKClx0FaP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nof2nA2YC8ZdpujlJHHHv9EyFiNJxBE6Ii/NmM0AGwPk50PRXOehw8YxBw2RvzgL4vo/j/m7K5j1sQGt3KU2FFEmfX3PpK++5VAo/1DEEI05FuGsm/b1a7Ov+yr0IM4FRwYWB+rwr2xHO6Vp2hxCNaghr4odY0mlclPziTfpHkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GlhkdyZB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so767357a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723110521; x=1723715321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98Te9XHs0b4R6F3LHWV/8NF0vam7bkosWDODD3/D7Ps=;
        b=GlhkdyZBvw1lRfp4Qu6++ng9z12kH1y9e1WSxoITClVQ/BEjwn4LTPSnA+WiM3IM/J
         +0OCVY//hmYUUmsRgKiG5jlDbtWVT2sQsK0M9Z5cKjlQVYyFGBwjFtfD+0PeVGV6SlZS
         RRvlQFjgABj717yvSuzVLZo4QKyaKFDN29vT9Yw/LTpdXQ5KFdUA0ry7O/zjs/ncwSFo
         /BaylYmTE0XL2rdeLEQVi78XsZdLCcbjI+Oexu0HdwqAUv+Z+2i+uTNzuig7bgVcrwn+
         lpzfKo1pqoNrNrHJwIwAtCV6TzqpiXxHev67Yh2O0xunDLDHwuqbxB0O2+pvzgekwwO+
         BdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723110521; x=1723715321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98Te9XHs0b4R6F3LHWV/8NF0vam7bkosWDODD3/D7Ps=;
        b=bfWLsEDIwYiqLRGUrTTQFYshHSuccRpCuwltO17UeDCBL2ZhQCe9D8CQedUlCkfz34
         +Ut4geFQ1AYyF23jh+E1RPIVvoqwAg9ruikgphnU/61JIoVRF4K3QL+tOH6KlEbA+Qy+
         3dzSgLGt3MrXod5P7YMaw4VjhM+ZpPM71UdAPEq2xI2ryEAc98FRz9DqJjIK8ddakqyT
         TTi0lUFR0Y5v7uBtUBDusAkswFsyBrl6f+xtVNT7AcJGooMHTbhTW8w6GeOdu8o08nMo
         qpIzXObyJ3x2DDEdLgrjgqS+bl8pAOyIC0w4oGa0yYJYB9qCJqHdqsYIgwDKnrCGH3IV
         dXwg==
X-Forwarded-Encrypted: i=1; AJvYcCXn/ZMzRwzfHWrqlOGmc0AOsEqBc9IaqljGDaVNdbAjbaqdCAAh9PnsO+PphSjvxoZPa6wZkAs1vFUEsO6vGg7NYZAYfoDVzfC/lDIB
X-Gm-Message-State: AOJu0Yyb60qeveoVWbUzrRmiuS+2/7qqA0g0o+LM0CvT4e/GZ2lyFuH8
	KJ0TqKMQmf8Vpgq4elSa9hckAODKd6tsifKF2cmm2sr9Y4K6UuGiC7JeJypeElCmt5HOhklMNXc
	2
X-Google-Smtp-Source: AGHT+IGqfY8r5JL1RRRnhevzOCdhhwCU4ZuoAU0iSOK3XKT0/qxz4dNOCpYyRCQcFicXUDKPwa9zOA==
X-Received: by 2002:a17:907:968c:b0:a80:7c30:a836 with SMTP id a640c23a62f3a-a8090ea38e6mr99727866b.56.1723110520996;
        Thu, 08 Aug 2024 02:48:40 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e849a0sm719911966b.186.2024.08.08.02.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:48:40 -0700 (PDT)
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
Subject: Re: (subset) [PATCH v2 5/7] clk: samsung: exynos7885: Add missing MUX clocks from PLLs in CMU_TOP
Date: Thu,  8 Aug 2024 11:48:29 +0200
Message-ID: <172311048731.12963.6553046797863200801.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806121157.479212-6-virag.david003@gmail.com>
References: <20240806121157.479212-1-virag.david003@gmail.com> <20240806121157.479212-6-virag.david003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 06 Aug 2024 14:11:48 +0200, David Virag wrote:
> In Exynos7885 (and seemingly all modern Exynos SoCs) all PLLs have a MUX
> attached to them controlled by bit 4 in the PLL's CON0 register.
> 
> These MUXes can select between OSCCLK or the PLL's output, essentially
> making the PLL bypassable.
> 
> These weren't modeled in the driver because the vendor provided drivers
> didn't model it properly, instead setting them when updating the PMS
> values.
> 
> [...]

Applied, thanks!

[5/7] clk: samsung: exynos7885: Add missing MUX clocks from PLLs in CMU_TOP
      https://git.kernel.org/krzk/linux/c/cc9e3e375f4f2e244695040aa416d16ef6d26ddd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

