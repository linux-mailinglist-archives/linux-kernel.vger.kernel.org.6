Return-Path: <linux-kernel+bounces-292838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B395750D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 910E2B250D0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ECC1DD386;
	Mon, 19 Aug 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPB7fugQ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0268145341
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097357; cv=none; b=jMTTqja6DVMr4kG8yjrkPbZ3zw96Wx9ewUC7sdXsusUYh3SJvECexR8AZNnY/9yxHgXIjvEQVFidXwfZK3emKb98kmHkl9pRxI4lDenFELdDmeI7URGt5Nw1lIYoUhns4scZGusyvplSni5IIFmUVigIgx3pU/dH9OKVNOdVtvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097357; c=relaxed/simple;
	bh=56kHQwtpg1lPKjewNCAFNUEpIF/ZSEbFuo5zwprX+pI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fH9Zs5UMDGxBWaBT8EqzatTj6L49wmNIWikaLBcronQLHdoV3to4cmerB/dQaMG+jZfnSCqrNjYc/nAEAVC+XktKEvjmR5mfxdaSjbvz/tS2RKKgOagpna2LV0glGkoplvvJy9VFejm1o+2rjjJB8Qr0u8MdPGYazYtKDnuSdyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZPB7fugQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371b97cfd6fso1151791f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724097354; x=1724702154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SIXjnL9/zmUd0fcfye8I+jXnw5Z8DSrvcZ8Np3gZyU=;
        b=ZPB7fugQQcIjo6QSAXEgsjT+aitpSEJ7LdI5r6MBul+RniSRrmFudM0oN7w8gd0dwC
         dt8ulzKyDrdGLDde2FG3Z5higKjodONQ799xQeDVaXng/SJRqJ7nWX3cYQuGukqhKZXu
         lC5GdXDLhtxg09stttbqDAQ/ifN8RX0O8MDDhJysYL3Ls2HLkZXxzl2Xve8TT1o19GUJ
         WvWMS69MvrIPrWsScLUeC18Ptc9fYiigEoNLJlULAEEDEREs0jGRrYTJ+s7NQsYCluzB
         7WGsqkMd/JCxb9SoCVi3dMVLR2HMLW/bNR+WtJPS3o3jgr0D0Nvl6oN4JH0mR8ylk891
         AZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097354; x=1724702154;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SIXjnL9/zmUd0fcfye8I+jXnw5Z8DSrvcZ8Np3gZyU=;
        b=P3WuLqdGRaRy27W1sQG0uaNLgYW01p2e/ausL4C7URjCIlqgTmy9ygZpNNga+FB9AW
         2tK+l0hc90DxoA9D0IPYZlpXyCZN4IzVnMy7RvHRd+D0Sd37rI+8G4Am7T6O3Zw2Vr0E
         smeneG+yzTETB12ocm5q65zjI/IKAiHX3n30FUPB+KeizGQ/BDHqIIzvMzgUJa4FN/8Q
         GbZxxzrokHwI3qu8lT0MlQJF2CVZpZhjO9Hs2WwDKVE8px4R8ru8mq+kfPMdH8CZK01E
         QKivcdNKMwNiOZcbxRKRrtXACvKAtNfPDTWkC4KgqLqhGAhmcdNUezRvjYdkRx70Sw1l
         votQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnGZM8uYAm1fGM7n3H85dLt9nEM6JjJCfoAz8eZvwtnGkDeBJ1bNUrfp/dn7ElEn4YWDeeM44aD/i6mgvSrHtQJDD3F4XG1oGpa1s/
X-Gm-Message-State: AOJu0YyMAPAOFl1syF0Blnm7saoNfpJ2Ezlf19HMpEY8RyU7MzHlgXeq
	jn+Ro00CUthY79mdPayb8IJNFwCFwIidNh8D9zYaR99kv0Spp4GIQLrQNt0NSTg=
X-Google-Smtp-Source: AGHT+IEIMesZrsjAsrBCHt62mqeJkbFhD1Zoif7mP2C75jr9Zqo9nsQfgVItQh8BA+hL1eweWpL7vQ==
X-Received: by 2002:adf:f54e:0:b0:367:340e:d6e6 with SMTP id ffacd0b85a97d-371946a330emr8076461f8f.41.1724097353863;
        Mon, 19 Aug 2024 12:55:53 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bf0b0cc99fsm172687a12.49.2024.08.19.12.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:55:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240818172804.121666-1-krzysztof.kozlowski@linaro.org>
References: <20240818172804.121666-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: samsung: exynos-usi: add missing
 constraints
Message-Id: <172409735248.112951.16161782902762535598.b4-ty@linaro.org>
Date: Mon, 19 Aug 2024 21:55:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sun, 18 Aug 2024 19:28:04 +0200, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for reg, clocks and clock-names.
> 
> 

Applied, thanks!

[1/1] dt-bindings: samsung: exynos-usi: add missing constraints
      https://git.kernel.org/krzk/linux/c/84236ed0a2b1d40a0b72e8dde4b18d641263f5f9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


