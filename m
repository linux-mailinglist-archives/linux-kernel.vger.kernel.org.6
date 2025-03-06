Return-Path: <linux-kernel+bounces-549604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8639A5548F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0F73B4F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760372139CD;
	Thu,  6 Mar 2025 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWy2UugF"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20861198E63
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284678; cv=none; b=dSmrW4MvgwYsGb04E8C43xSvJwCpZT2q6plqKSVoF7zLCxQ2QfwUIaE5KX9YBaFeNylXkYpzxyex7sjJqzzkm+socmfYZEFvug4OfMIHj8vGo/UoXjHFnpWq/kATARJJXDDC2OP/RHd43y85uRwTz+M6UKkuYUel+YYApgGM0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284678; c=relaxed/simple;
	bh=JbH8xjfsf6P7OmD9axfTwXfSPdYjRzKgiAuZzz5MlcU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=beodYGusAnXIAO8sWx2WQYtOckl21EDahs+Lq4m7xa5BM7cqdLB4ntoj+iV5VM0oBYGdcLiZYyvWtIfbn7CI60UY83aIopSY2yPbI4xLVlCgu+XtH1qkY0GnnsWE2yiHbRbrbifRgTt+r/0OPQYeMLKyvZaKbAt2G8VuZHbMiqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qWy2UugF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bca8cabc8so901035e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741284674; x=1741889474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AnLds6lWEOgctovP8rZZIFlWYH7eclRkLDrgHTySwE=;
        b=qWy2UugF1tUw8XPDYhoHYbJrl0VOPngWhUtJ5xH+7o6fmMcFqmJteyg7MoWekPmjpe
         Ch0Xo8SF3N51fyqdn5fAUEZopgiT2PBuKrROUTyLNfJcktapgs2f31kkgDNZ4Ahn9nx2
         RPlJ++L22oSc4MiIv2dY6NgDbWbvkqf2ITqMXbzPGfAVm37f3kz41msk9jEhzH1pswK2
         RK4RXceUXLS3gHPZVE3WkzekX/G1+ciDEDvD2kSXCFGFD0MbGkaqXEoCXl8C6MsxuawJ
         7pWLWW0zUzueVBBSZFD/rMhRxMW+0ZL/ygPVvJ4nJEGXKGc7g7K0kTh70I+oNxKQc8eR
         VF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741284674; x=1741889474;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AnLds6lWEOgctovP8rZZIFlWYH7eclRkLDrgHTySwE=;
        b=b9/Cnef7CVUm7kgDKqtkb99sDa6PUQV5FcvGCvIJ5W4s3OfPgnIP/73ijpYwxcaCKy
         aSVTJ6cQEhgPGuCJMJxFS+l+63rGQqlYg6ZFlT9iZY0T3XmAyqFcGZowFAjp+69k+qnR
         pEOqCNeYZksmulRDaRlPVvnWFS18bcQGI1qqWKp/NZMvsZg67/WN5OV5XjmV183Szz45
         xTd0zfBPYacIiv0UoVwQqFXCUVmcrPsEPmuPNWEeqduDVH/ebuTVnH2ysczS0g+uYfV0
         yOdTlGna4sJDPGpp/DFnDfNVpABdjZ77Ey4aGkjzd+lB0C1Rsqp4dFiXIt6CTc2zdy2q
         /ZXg==
X-Forwarded-Encrypted: i=1; AJvYcCXayeUcFg2pPq/sNhGdATJNy0CvmuyQweOvI9xJBRhN/RaacaV24B5OnOQyXOih0f7xnbkDRvBvoqYzHDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRdDE2y5ZaZCty3NMZRxzGARXx+aAuMpqgjFNqCL6H344hAnup
	E84w3g2apX/kqYdHxKM3SObxuXJ4QK4slE+sMgAQWWXSEH2kyKfGpNasKEne04A=
X-Gm-Gg: ASbGncvPFMN5rXuIWY5ML95dndlB6+jZ5Vb54rXfH51tP8PIZ5LFX2C+UuyfaGLvzjB
	RDh+x/w9jpaiBTvWGtHudu5U4yqUTlFB6sli/KD7nKCtz41Z+/HriDNVLfkSn5krMdinadynddN
	k02kj832zYpaU6emCu48G/aIEDNs/IwiyRgdVMhcZLDaYKCSQ2trD+w0P2w7/SJItLTSRAtWHzp
	5ob1rbvNBeQxyaYfI8YdB4aEhQwhGeVIKwMmolxUQ8oWCwSFBi/HR4FO4/uYDOZlG1b5Gj6NaTB
	648jNEafl1lMDBh6F+TAKYwjQNAL3fzp5f/LWTD/0oSd1DtJSiWbGoWM8Zvh
X-Google-Smtp-Source: AGHT+IFFRvwmZacRwHe9yk3mbn6KEKhfILWjskick/fV1fIsJkk5zhEz8ZiB5cRx3bewoTl4Sqa/eA==
X-Received: by 2002:a5d:6d8c:0:b0:38e:48a6:280f with SMTP id ffacd0b85a97d-39132d93f92mr48151f8f.9.1741284674274;
        Thu, 06 Mar 2025 10:11:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1027d3sm2716967f8f.83.2025.03.06.10.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:11:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: soc@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250305211446.43772-1-arnd@kernel.org>
References: <20250305211446.43772-1-arnd@kernel.org>
Subject: Re: [PATCH] soc: samsung: include linux/array_size.h where needed
Message-Id: <174128467279.252750.12742713284242817976.b4-ty@linaro.org>
Date: Thu, 06 Mar 2025 19:11:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 05 Mar 2025 22:14:02 +0100, Arnd Bergmann wrote:
> This does not necessarily get included through asm/io.h:
> 
> drivers/soc/samsung/exynos3250-pmu.c:120:18: error: use of undeclared identifier 'ARRAY_SIZE'
>   120 |         for (i = 0; i < ARRAY_SIZE(exynos3250_list_feed); i++) {
>       |                         ^
> drivers/soc/samsung/exynos5250-pmu.c:162:18: error: use of undeclared identifier 'ARRAY_SIZE'
>   162 |         for (i = 0; i < ARRAY_SIZE(exynos5_list_both_cnt_feed); i++) {
>       |                         ^
> 
> [...]

Applied, thanks!

[1/1] soc: samsung: include linux/array_size.h where needed
      https://git.kernel.org/krzk/linux/c/4c57930f68d90e0d52c396d058cfa9ed8447a6c4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


