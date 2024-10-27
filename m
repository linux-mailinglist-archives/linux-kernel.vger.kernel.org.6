Return-Path: <linux-kernel+bounces-383780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6309D9B2029
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176D51F21F4C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03CC17C7C4;
	Sun, 27 Oct 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/TCoIJc"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F23217C220
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059371; cv=none; b=PvL2h45Rb+xtOFybGOajK2pSoGzayPOdFsd88cInt8mcZnsPCHCWdstk7z2LtMoR38IIYpMtVyx4whv8Ufyi79iFtoX8Mk8YWplgT7FcZ8scDyDVpkIz1e2jvlXdkKnIK/wmyUWAny6IcLPvYBwkozutAXdwnaxhsPP4SQh7F30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059371; c=relaxed/simple;
	bh=NdS/jI8HA3j9LZ0W8vZFP5ip5iN3CNekL1+EtK/8zd0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ADzzQjk3fGoUNi/C8QmNR79nuQDIpVsFjLc7Sud/Mr7H46TdV1SiBvKY0lOSZP9mrGu4mFiv0QvsbU+/QPTev5nXToTM+dDPZbgamsgV6WkZrG6wRE1P36ShHYU4ly14SMRLpFaFXpBZjrbVkCKwt+utxr0hA6NG0h1hQ0FEUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/TCoIJc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431506d4f3bso3886895e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730059368; x=1730664168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Csvf9O0MpQSu0xWQHq784TkIJuAT1HW0rk5HORaFsHs=;
        b=j/TCoIJcRf0v1FQYNQmNwOWOCthvSd7oJ97no8pz7hL5lDPYS3Oc+UVvhb+TufMWBq
         8ABAhCZXJko03nPS/CN1Jn22FrBHioP/wTERjyxGxeB7KfDA5emu/1sI59K9lvkagTF5
         4zN6g18eBT/JC94tnlZCN3WWqvfoDmX6L5eofDI1D8njNIs7+T59rHWiTP/hz90neiRR
         1S9qDL+06UYdf8jAa5T7D7L2m8cYnNA8Xipq8MomK6i2Yi4Yius3X9f+wM8OI9R56Jij
         uhv/VygT/PX/Xj0rukVYkWm2ba+GdklYWCfri5uCqHcYbu3fYjDpqG//JZRLgvdyJvSk
         LQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059368; x=1730664168;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Csvf9O0MpQSu0xWQHq784TkIJuAT1HW0rk5HORaFsHs=;
        b=S6THCDHFzjzGcoO40D6fcEXdZjudk/x+80bro2ope/zr2qU5KT6o31vpU2HL/2VmYc
         0fLGAIeMu0oxqovFnNqk2DEWQNjW445njQsdjpcM0Htp6k8EHJiDecIC/v5Ks/DUC73q
         AjUJYdfR5oFb+aavCNjDPsHvyrl/XBr+PVzasD+OIGiRqvpU2ch0wersT5oBOkTLV+KG
         FIoO7DQxEa71xaPho3KvFHd5bmtWaaVZFn6tu4iQkFnwt4IPBPwo52MSzbt9/vwPIt3R
         cjP1tdDCT8VCNDjvSXnHgacYGty2hs6nfQlRSo707X80JnJvFUwvZGvAKgpZSY9Y9bCg
         97jw==
X-Forwarded-Encrypted: i=1; AJvYcCVyzcNF5BaIeOYQRSsNyaVIw8gMHPRRG3xdez23tsHAr4GA5Zft6kalF2aazQgOeS/YX5Ecx/m7p+qWqis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+Ga9oR6A/E1oNf8GYBDdELTda70HjCE1BXBkaozBn0tfldQv
	HZQCYcE9uSMXDy2gSoXxBM0gP/ZBhQaeyk9b/zLsPDVgW/nvgQNKjLTqTSIuWvc=
X-Google-Smtp-Source: AGHT+IEoeV+0hduSOZ3GDqRLImZT1Snj/R5T8mVeRbeOUEllrJtpvHsIEDIvx3ThNhrHN69b2ydTMA==
X-Received: by 2002:a05:600c:3b13:b0:431:55f3:d34b with SMTP id 5b1f17b1804b1-4319aca248dmr20598455e9.3.1730059367800;
        Sun, 27 Oct 2024 13:02:47 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70d50sm7526833f8f.76.2024.10.27.13.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 13:02:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Tomasz Figa <tomasz.figa@gmail.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Markuss Broks <markuss.broks@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Maksym Holovach <nergzd@nergzd723.xyz>
In-Reply-To: <20241026-exynos9810-v3-8-b89de9441ea8@gmail.com>
References: <20241026-exynos9810-v3-0-b89de9441ea8@gmail.com>
 <20241026-exynos9810-v3-8-b89de9441ea8@gmail.com>
Subject: Re: (subset) [PATCH v3 08/10] pinctrl: samsung: Add Exynos9810 SoC
 specific data
Message-Id: <173005936499.12757.14415579231294539195.b4-ty@linaro.org>
Date: Sun, 27 Oct 2024 21:02:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 26 Oct 2024 23:32:39 +0300, Markuss Broks wrote:
> Add Samsung Exynos9810 SoC specific data to enable pinctrl
> support for platforms based on Exynos9810.
> 
> 

Applied, thanks!

[08/10] pinctrl: samsung: Add Exynos9810 SoC specific data
        https://git.kernel.org/pinctrl/samsung/c/6d2dbd4cec8939ad2b813b8052eb12406db528d7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


