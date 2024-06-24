Return-Path: <linux-kernel+bounces-226835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B6D91448E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2111F23723
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE551C21;
	Mon, 24 Jun 2024 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSQ+Giru"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840B45007
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217278; cv=none; b=H/Dw4rwwdBmTrbX/tgqD1J/UozvEbA53hf+sU058qUN2i77F7vHy7N1hBfCNrCpqQMjNq1i+lho902yLM4Jv6ojlnXksj2indg6GS7HIJtc3pUDIOWrzjuFkFY3Q8Lwk7vTg4vLxY0lX1fWgeTlpCCsxq9AWvS0CkeUK9uJ8L7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217278; c=relaxed/simple;
	bh=aXKsAl6poCZsD5YEtZcnymdeghAP24SIm0L6smSVRsQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b+Dv0KEOblV7UluMb3CfeO+0d1r7YB8/B6U1gWqCMUIoYgEnD/JmRggJUIDtCSJ+/7LRwtGYBPNho5eHeS31NUBU6wOh7ZmW1W7ZAsSa+7cZjmQZ5rtnjXadoBQ8PXrKTAa9d5ahliOOVcwM/XSLZyN/2fJ3+bF6WfQd6so7Hkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mSQ+Giru; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ce12707d9so1153719e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719217275; x=1719822075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5VAOdkKdhcM8gT/1OHnhyjoCTyfpHHr5f/6gNRJOW8=;
        b=mSQ+GiruqG0KUAy+6L4fSe/37lEFtrHEieaR03ZlWXYWgluxWp0kIQmQnCx9X6JoKx
         8hFCXX/QURUZdMgwoiKMeKyivNLqOxfb643IvadBfY7SAVyjir5ez6dopfOtowe6doYE
         deIi97WLNW6xO8SWveJVgUrY+AiUrTB9HdAG/efzISmGS59wHokLkPPD2YJrXc+Kevwr
         hQtHTF+q96sN6RhCzH10VR4JjxMn8EW4OtypgpnMiPWrqhuSu6Mvgq4Yo6PzSWXS9Lsf
         LxEQYzznyfe8rJsRzGGfPhrFaoJyuvCI7dlpqO+CNc2SQtSaMSGAFUqapr7ult75vQCZ
         voOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719217275; x=1719822075;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5VAOdkKdhcM8gT/1OHnhyjoCTyfpHHr5f/6gNRJOW8=;
        b=nrr98WsZ8is+iOHcLkqGmKl6p5JZXXYyjyJIEVidiBlPXz4QHFP+y+pReSckuePUh6
         ELBQcGIt4rCpdbkYzgbUB0QHuW9zFLC6mzZkLRfGwj//Yzx6Er/KDHQYx1rOcz/CbYQd
         tXtm/AJksWnhoYrx8c6Lt771X1TXzwoDLJn/OOP2EZrp9osnJ/XwAj8R+xEeYY3gb/Yz
         lH3T3tHV3OdQKQtJtuaoczqWDXUK8PyGC1ZmTfE9ZEW2z8H40T3Exh1jSXjiJn4WyU8H
         4upi6u8Tn9rBxd9wO8TxOEHMuCEcmUMDO8mA+mnbXCTSK+PJMW1eJ4PB6HT+52voW4E0
         I49A==
X-Forwarded-Encrypted: i=1; AJvYcCUdSFKYHRk+92BuYeFTMb6zNtgFdtQQOpVgY3mTfwsv2hMIt0iVYmpbpw61+H1PivFn8OcBqijMht0g8zzMP1+lfJBHV0NYC1ONA5V8
X-Gm-Message-State: AOJu0Yw4ERCnKFARbyJzenfudmtsIqLGBpIDajgdGW/YDRjatHErRmfj
	lLYS07jD8YUZlIPmbp6mRx4aP3M3HdfV3sxY0QpnPO0f+qZw4faFgmGen8XTTEw=
X-Google-Smtp-Source: AGHT+IFOM1tvmn28vCqfxsQmam8sAFtMLs0nKzQtQ0TNetL1dlK2e9z8H40izII7f+ZCOzp5EYKRJw==
X-Received: by 2002:ac2:5617:0:b0:52c:b606:2b2 with SMTP id 2adb3069b0e04-52ce0673b84mr2508868e87.46.1719217274315;
        Mon, 24 Jun 2024 01:21:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248179d8e0sm132450205e9.3.2024.06.24.01.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:21:13 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: Emanuel Strobel <emanuel.strobel@yahoo.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240622140112.2609534-1-christianshewitt@gmail.com>
References: <20240622140112.2609534-1-christianshewitt@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: add dream vendor prefix
Message-Id: <171921727347.3499124.419809659570327061.b4-ty@linaro.org>
Date: Mon, 24 Jun 2024 10:21:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Sat, 22 Jun 2024 14:01:10 +0000, Christian Hewitt wrote:
> Add a vendor prefix for Dream Property GmbH
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[1/3] dt-bindings: add dream vendor prefix
      https://git.kernel.org/amlogic/c/4132d13bfcdb3551b0d1a6a74e2063351b4bfcaa
[2/3] dt-bindings: arm: amlogic: add support for Dreambox One/Two
      https://git.kernel.org/amlogic/c/96cf7ca12bdcd44fcfdca74e56389c40ae47a7b1
[3/3] arm64: dts: meson: add initial support for Dreambox One/Two
      https://git.kernel.org/amlogic/c/83a6f4c62cb12aa902043fc1910fdbe483193f3c

These changes has been applied on the intermediate git tree [1].

The v6.11/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


