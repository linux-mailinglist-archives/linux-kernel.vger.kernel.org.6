Return-Path: <linux-kernel+bounces-553262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C8BA58685
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B3567A30A5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E133B1EF383;
	Sun,  9 Mar 2025 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnPPfSFw"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33131DE3DC
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741542882; cv=none; b=RMoCFT5Ef38kgQqzMwXxxMR2BOxt1ck8LGAwNOd+9mvaPfJMx5+7n/IqcNkQclAlh2JBpTac1W9HK6reDZkKmQCI0R4lWaS21LXXEGh7Vq+RQQyThe5JpEMP5o75z5xHK7hGkfamULnt+aETa02uAEd+N8FrveHiUfEgjpx8w1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741542882; c=relaxed/simple;
	bh=Sjd6eO3hcXcao/UsiuWYpFLSLNgg7a8oNviIVpcaneA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lh9u5OzlVSceHrDUYu4ItlKliW5N3Ivklq2qvnkwsN3CuCc8+XMUlzlEy1mCmn1aVGKLTlxHJm/DmRHP/8R6WrsdDR1VhHUoSSi4V98L64u+IsTaByndWhLPrWj0/cx+R17sv9Tce+YcFMEpAKCuKGHwQx15KwNzMf2IlN0D4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EnPPfSFw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913290f754so147144f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741542879; x=1742147679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAqFx78SArbrBH5Q1+Ilkti3+dZ3JAByQkBS9egtY1g=;
        b=EnPPfSFwJ1Hc2Sg7X+FzpbzbeJ3pcyCsnNzxG/CN6ER+7T2RD80W7vxLVKgzOnFP0H
         1FvyRGCJ2hRWqLlByJh0q5x00hoP0wQxqvbjeodd5gvmzbCFPtyV/EIliTm30tQE+Gn8
         F1vKl3BoQpPGLMpMfZrcgBngphCfsmaUqFKIN39s60YzhaK0nQKbsuZ9oQmhO+1P9VZw
         EEt48TtA5WZ41r/aQfzuARi7bD/VewDdtQU1DKGfl7W1r5DgLybcnD03WanoPpqARyNz
         PDMkUjqBbdCdxcfsphb/5JkVRqh3SnrRJSVpGK382SmIb0jewdvnw3CkA+nzLsjbl72s
         gTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741542879; x=1742147679;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAqFx78SArbrBH5Q1+Ilkti3+dZ3JAByQkBS9egtY1g=;
        b=kE5GJYBzyJS61aolx+hAtbtdBuSrC++ypTgRaqo0CigBAyoHdCMoOuxwJhLuqzzKrA
         5kOj5mOLTOslq2biVg7CshUjIxonbHmSpAe9aFyyo5HR6awmYFBCzsgrAgLFQDpvCZO/
         nyQsDZU9X6o5Hz3JKN50cQqYrm2QoMyojLrfeijzHRniNBCdft/0phAV7M2KaOKlbJCW
         I81AhifX4NuGEZkiD7MoVVZDKyoNENQjqreu8a7GN9Zm0DSMgG1ie+XjWE7cofgZD99z
         zVbTUO5iE4275kwwHFUXG8DStpVtVy2MvW3EHnFQb83ApdRDwHvrAxobAVk0/H9c00oH
         Wr4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVadEOlK2sKSlydRUHgiCARdSG8VWAp1uvvuoBhxw0tlRicQK5EvFqtL+KaRkVxsaWptUPeFHKbM7y9I0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMYn+PBB6CnjM6OYLgQRYWEBFFubB0QxXBA6e3XjsaSOc7FRfz
	8Ssz2fcT+Y6DQVGve28rReHHP8chJLctjopo4vLQXgy4vNWdMEX1/VkUuJ3xoVY=
X-Gm-Gg: ASbGnct/c1pLefXmKVBqeArhEu3pn66U0oDUDkRGmClolEGl+W/HtpmVSkD5tL3ZGaH
	Xlq27y2Su2qI94lGdVS/2xtmH6Mew+uVZPsGn9pTsAyRVLYFeX9YgunKOX2AbD3qvnT7mN3pHJL
	nWvTvMrqgWIPzLShHWOa874D8XWb7H6sV471yOpwct7tPp2p7cwNWGHZdicNqOC9h0XH83LBwwJ
	kobNjfngxucgKq2xfnyZ053Rxqu2tjyUJ+Y+X2EWy6mytjRTl/Bfej6NmIBelbwApveHK8c4lZM
	Etgud1uI2Hn93s6ItkGZirF17erjrtXU2J9ZhOpalP1wxpzK1iYe5vtAdG1d
X-Google-Smtp-Source: AGHT+IFYzKEoA/0BD629Q+oyNq4LgcHKydsos0JaNMt90Qxi5qetmVUanZhNd8Ow0nb+R9OCR/6Ciw==
X-Received: by 2002:a05:6000:178e:b0:38d:d743:7d36 with SMTP id ffacd0b85a97d-3913bba4880mr1367921f8f.10.1741542879038;
        Sun, 09 Mar 2025 10:54:39 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c106a1asm12425578f8f.100.2025.03.09.10.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:54:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250307081341.35197-1-krzysztof.kozlowski@linaro.org>
References: <20250307081341.35197-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: soc: samsung: exynos-usi: Drop
 unnecessary status from example
Message-Id: <174154287672.7465.7756190815598140333.b4-ty@linaro.org>
Date: Sun, 09 Mar 2025 18:54:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 07 Mar 2025 09:13:41 +0100, Krzysztof Kozlowski wrote:
> Device nodes in the examples are supposed to be enabled, so the schema
> will be validated against them.  Keeping them disabled hides potential
> errors.  Only one child of Samsung Exynos USI device node should be
> enabled.  The node in the example already selected 'USI_MODE_UART', so
> enable the serial node while keeping second - I2C - disabled.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: soc: samsung: exynos-usi: Drop unnecessary status from example
      https://git.kernel.org/krzk/linux/c/8f299df1b75ad0939f1340182c265de019eab438

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


