Return-Path: <linux-kernel+bounces-440887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DBA9EC5FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDB91639C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB0E1D6194;
	Wed, 11 Dec 2024 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkF7aFKk"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440D51D2B0E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903408; cv=none; b=WqYwulpGT87r1mMKT0KjFwi9gspocl80SREaKTxMoYn4wi2ftaXpJjVzN/i2SoGDxwOTIDQPn+HzhavZojR1KQO01M95xDR5NjxHerNoMvsuQNVj3n9WHZy6u04X5+Z06Fg/cKexa9bKCmSrZ/KcwEhV/PmSaO4wxu3N5MCdpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903408; c=relaxed/simple;
	bh=byCXBbBMkzxnWu1JfDLHLINiG67d/FWoOMVk8Wzbj/E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U3x70Su+kr3LPFRI8sDyzBOQpKM2KGE+KatQyUmnBA7jnc4MFkX0qM9+eDc+vx3tZnvgqg4Fq88vKgnJJWAN/ETpSoQ+njht+GgaZ2KI+wUjPrRB8HfxzuKyXePBfM26e/9IXt2yDq1K5dWRATyT1FfnLdi4jYiZwpnJ5kEB/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GkF7aFKk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434e91ac3d4so3084035e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 23:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733903404; x=1734508204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR5y5SI21qqr719CHt05ra6RVhCy3LYtwxpSH0rstSA=;
        b=GkF7aFKkdO5PjXqskM6RTWdDMytEhzWlRZ1cY7fdOg1j2e/6oWK87FJZCAQksCoVhz
         Yo47J7d9sr9HoUV/h5jfgekgy3sSn6eBJQtnmebqivIntV9McC1ulLyEKTETwUMAOt4E
         Y6dje6V1rvmdr+uHZT4u1JL2lh+4zc/YJEN16+clgvNsB2oxUCYMmTuwYgE7xeppCFWU
         n1JUA8P779Fa03pnH8yxRqjUrrQe/ijF/nr6OBpyA+nknYwDfcGxkKPAe41FKll3eMWj
         wGY5mppFqG+jDmnOW1fMTvwAlDINV/mSkh1hRQ4TPL6Y7bMClARdoFvNt9MoZmnAKe+u
         oSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733903404; x=1734508204;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR5y5SI21qqr719CHt05ra6RVhCy3LYtwxpSH0rstSA=;
        b=hN8+O/FfBkzvarknV9MMWVMOFnOHZk+g/lM0+y2egVxl2Fut5q2BGtarc5ZnjNLJwu
         kOnwhPOtT2JNVrWcjGRWuuQ3bCLfE7/mwO5f9oLJODCuk7RISxGV890KqfTBF+qu8JuI
         EzPkB4VCUaU0HIyUP6+r24QYOQt2/kZg59cGKRbZJaUaTzc8ai/5HcdiDL1pw6So5gBo
         NhWjgp75CjejgCy6lHbPVD9vUYxtN2Ao6B5y940otSJGDXNuVSWoC9DNOKDdYnkkqwhM
         6zDRVDQIf+2uu/nG7adfz1KF7EScUf/yF4QTIbkxpEX0CsiRmW65i7WhCDUye8X9/6Ix
         zoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv6c8hlYF81Q2m+d5dBj8QsJU4U9gRvRzhX1cbta8OKkQkoJOlyYLE7wO3DcZRyPt54yULfZDXNoD4UNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdkeHByfDuuCIYwn1GNMkKh+pO/vAhqoK/516CTihz03pMfiEB
	Ea1g08heMma8h0f65ijTeOJSBca2HQwwYijB/qayLCHNIMIb2s2TDeKoTFviDxOOCPvYGMWU/w8
	u
X-Gm-Gg: ASbGncsXvC7cLrzxBuvUQ65uV1XB4F2SkaCQEc+G/IzCz4Sclo5vLa5GtHgQSjDz4Rk
	eTqcy07ey9AMdpHdhBXIpSjhxv7N88bBw4G9uYPvzS03uF8jtDQdXuDDhQwa0lFZSoR0PjQWQCn
	NUQGEi1TXb0vZgeYQcQofE0bhdIasTWUHiBICTkSMp4eKtwXFGlFMK75h8rOOe3oa5ReROsbbvA
	PbAWC2w2zoV6UlqOV7g19PzOYtk1EL1eVnEX46C9M5HsAWFEY8LXaGbz4jwnXT4mUZnag==
X-Google-Smtp-Source: AGHT+IHzOkWDq3KGGPDZsVQbPi+YFqSrAVZOEWrnqAZJZ2wtM0+/RjpL+t5H9Or+bcHPIqDSNw5ORQ==
X-Received: by 2002:a05:600c:1d20:b0:430:52ec:1e2a with SMTP id 5b1f17b1804b1-4361c441982mr4065105e9.7.1733903404111;
        Tue, 10 Dec 2024 23:50:04 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361b6d6ea0sm22222385e9.16.2024.12.10.23.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 23:50:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Taewan Kim <trunixs.kim@samsung.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
In-Reply-To: <20241206025139.2148833-1-trunixs.kim@samsung.com>
References: <CGME20241206025156epcas2p3e1ce9ff35589d821735a7c038b9ac9da@epcas2p3.samsung.com>
 <20241206025139.2148833-1-trunixs.kim@samsung.com>
Subject: Re: [PATCH v4 0/1] support watchdog for exynosautov920
Message-Id: <173390340180.16989.11837691973342827218.b4-ty@linaro.org>
Date: Wed, 11 Dec 2024 08:50:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 06 Dec 2024 11:51:37 +0900, Taewan Kim wrote:
> Add support for the ExynosAutoV920 SoC. Basically this is almost
> similar to ExynosAuto V9 or Exynos850 such as two watchdog instance for
> each cluster but some CPU configuration are quite different.
> Therefore device tree, compatibles and drvdata should be added.
> 
> In v3, the first and second patches were approved by watchdog maintainer and added as next-git.
> - Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=grep&q=bt.cho
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynosautov920: add watchdog DT node
      https://git.kernel.org/krzk/linux/c/41979b81b22a35322817733b15407167164be58e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


