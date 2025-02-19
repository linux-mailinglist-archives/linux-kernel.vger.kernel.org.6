Return-Path: <linux-kernel+bounces-521375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CEEA3BC6F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A1D1889E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D0B1DED49;
	Wed, 19 Feb 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2jIb/FO"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6CC1DED40
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963342; cv=none; b=Di5NR0Suddkse2fXGj8dsNiphdL1ZJpslAVNZ3+KmlW8YRK6FKQFWAvEDT9OoWWvBIXxQ5hgtbAxHP6fN6tJOk5wDT9O2b/ESBFL6AsiYvFw8TBWy8PaP81pkdZMd3UFgmFOs5bWisXqU5uKQwlRs1Q2CRXgL/AEOFEZC/03tps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963342; c=relaxed/simple;
	bh=cvlaH9bP1Ejwnm0RINb1NYM/JFKbZqpkIyKiOdyhiaE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NMtFhn2SSMMUvJk28f9sOz1JYG0TDoaep+Pqj9uBDMsckFPI4T2lDxsh4zRFUyXj51CUsFoXJSHuYp+lzwO5XQpp8Yu/RKXvufl0Wl8mo+nTwPd/vCH+oHqErAF7X3zBhlSS+4SBPMYvPyOieMew7jpMhw7mFpuIEnPmladB2J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k2jIb/FO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb88d2b67eso40542066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739963339; x=1740568139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIQn4T+Ol8k281C344dwvV9xtdIPcPz3ZnNCTAKTtPM=;
        b=k2jIb/FOxIqoqhZdXiANWaSgiy0MxHKOeyahb5pMBoQ8LaY6qSEd2kI+53R7jeEbW0
         qrWpfHM0nfpo6ftXVprBz/yN70CunrhPouJ86Q6KdZtEMs/kzp6uRSqBSNUCT2p6+meH
         hwgFxb9OQIanNez/irel+s3TYaapkWu49h1ZU40g0vR8EOXyhcFFLEI1P3q520w1+rJL
         kUZ8/3tURLFqs1YYm7B7+7qpG71BqXpihb9lhh/TV3H8Pnk4aXHacgYESSvHLr5WUywm
         P6RJdSCLep/mwWGiKLcmWEEX3fixuHFTugUWxG+e6uioHFvGq+cCjY08D/DlgKd5qtau
         h3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739963339; x=1740568139;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIQn4T+Ol8k281C344dwvV9xtdIPcPz3ZnNCTAKTtPM=;
        b=OiDZKlV0qP9M8I9kdjf5V/yjibCT+MWQJAKFIy4EV0jAbYf8xKBIA1I6UwAhaNybR5
         tYs84Hn3bBjXAba4UnCbEDtmCRk3yUa+HqCYFpwsVq+LlNRDiLMLTUvydX8x5sjS/3Kr
         +aubgg5SXkKdZ8p5g0mbPYtCbU4sgIt2wyxHkhajRKF3hK8/D6taBDmYYfN/k7q2mKFJ
         bxTZ1PfpSfA7IfaIylxzGYovLctfHiNc7XVPP7BaaZnwpihBIBdrTkDqdCyQG9htNpqZ
         eyV7IftXvhpYOePk89JwBRjIPeYhm0aNrRzBWM8JQ//8opQ5FOUNkMfz+eS58lVEi3j6
         cOnw==
X-Forwarded-Encrypted: i=1; AJvYcCX1X6cvhuZ3z5TjtMxYv0n65J+iD7xcoesScPXfcPLC92hP6zVFyKvBMG/xl5P1fWeYZcG3S0jMzrHYP+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsqIjJRWXeJOvAW2CtIH/szXNI+aMW+zWWMboAUyiO5LQwI3K
	WSPVVv6DhijolOhlLkvL2Rye7BDd7a6AUkDpJxYRwTcEs/5OD4eV2ak/4mnhQ9c=
X-Gm-Gg: ASbGncuh28BfkKDgSv0bC7ajwB/2RvCioS9ZDRYd+UtQ+X1+Fxaz+Zs4bVDDbNyE3B8
	4U+yjhg1x6MuBgr0tiETdrYmkxp/IHDI5ViE0+1+4nESt8xpmHhHmuq2aBPteuW3K1aiXjcBAio
	VZRvPj6iSFoxQxR03NqB2FcbIxG17K7GJARHvcd0O+8pflg5QJaVOq0n2LbTFO1llPVeaIybsE9
	Yt8AsfIkv73iMzaRJ4D2yARepNI9xikb9GeTlhlQw1w1K4OkoblaE1Srvcxjf4Dy/mnQtZ38BZb
	84Il8yzuyHojIX6H/RWaXOriXcVXEgY=
X-Google-Smtp-Source: AGHT+IEe+1BQ8AYZk91y7yXjhMM+ta1+WK/nmzl8UeGC016o3r2DG8gtpQnMR/wNL+rcqmeldzltmA==
X-Received: by 2002:a17:907:7248:b0:ab7:bb4b:aa49 with SMTP id a640c23a62f3a-abb70ab878bmr651662466b.5.1739963339206;
        Wed, 19 Feb 2025 03:08:59 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba4fc0c29sm475464466b.157.2025.02.19.03.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:08:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250215113248.159386-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250215113248.159386-1-ivo.ivanov.ivanov1@gmail.com>
Subject: Re: [PATCH v1 0/3] pinctrl: samsung: add exynos2200 SoC pinctrl
 configuration
Message-Id: <173996333675.137445.366892422452609954.b4-ty@linaro.org>
Date: Wed, 19 Feb 2025 12:08:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 15 Feb 2025 13:32:45 +0200, Ivaylo Ivanov wrote:
> Hey folks,
> 
> This patchset adds support for pinctrl of Exynos 2200, as well as
> documents the pinctrl and wakeup-eint compatibles for that SoC.
> 
> Best regards,
> Ivaylo
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: pinctrl: samsung: add exynos2200-wakeup-eint compatible
      https://git.kernel.org/pinctrl/samsung/c/aced1f7b82b1594189be98ba7c51d0a60a4a279e
[2/3] dt-bindings: pinctrl: samsung: add exynos2200 compatible
      https://git.kernel.org/pinctrl/samsung/c/bbdb937962f2261355e48965b631742d12629451
[3/3] pinctrl: samsung: add exynos2200 SoC pinctrl configuration
      https://git.kernel.org/pinctrl/samsung/c/574d0f2120b8e7e6a218d81267f4b543d586df11

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


