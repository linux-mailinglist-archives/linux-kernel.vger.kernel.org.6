Return-Path: <linux-kernel+bounces-231969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DFA91A0F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6885FB2170D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8146F068;
	Thu, 27 Jun 2024 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzE44u76"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A37406F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474971; cv=none; b=jkLufI1sl82j7VX2pl/oHtoFNmTBveaDcxAUW79hIiRxzlgE3Rr8Yu/wNBZiCOe3LYtcnis5cxOHsl4jgfZjGwLSAae53XdRazRPuEi7+NIL98VsJCC1AimLhTG9IaHSfsV4nJSfzBKdOOcSOzqcUIvkkIRvkq3nQa2qVgCT3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474971; c=relaxed/simple;
	bh=A346QiIXS00xNk3ASUpVgw5Wdt0aDVi+VgTddZx6WCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DaXHZYZcJNDQ9pYDX74bIE3mR+7yjJ84hamBvcqgPJ+BcMynj/zadvyflzhubIj7Qb5CPupevkRroP2YLTr8Dwe3ACTllxH4bvGyjPl4xEt9h+XfMgaGjSMtblrRqTY9fXgTp2HPWBSTi6yAonRqXnnOSR8TF36TIF0I0Gc2X7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fzE44u76; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-356c4e926a3so6733696f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719474968; x=1720079768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhb8tshU4UTCoUKCJ0uFCvR9IBtcpzLcynFRgzyN5xo=;
        b=fzE44u76GlrBgDuxaRzaIZVWX/cykXkLr3j53FsgA5Gr/uG30jZUg30B7X8rk54Qk8
         zTr9vTvYOm8FtyhGDRHkHiG6WfY//OEtayST8JopWwNk8a/ZIcDX3X0mZyzVO6uhh2UJ
         1AHPkq8G/6k/OWMgY4LuZQV17Fva309L3uNtArTKehaRvgpjRvJWzKDSuB4sKuOIBLjB
         Q06DbgNFaeWeMcbuk3qNFhmmn43UXv3JLZ4spn03nNOJ2Ja75RAUtXggnoDAXxazv0eQ
         PqynOOXfVFKm0P6cbifa1VknehLMCp/84LTwSgUVUsE62G5XIBrQX/u+z4b0xyFQIJmy
         FZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719474968; x=1720079768;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhb8tshU4UTCoUKCJ0uFCvR9IBtcpzLcynFRgzyN5xo=;
        b=Tx/Hda0hY2Y5L00v5vPyiWAZJ669+JEDuIJadT3iduaKDxDIsRLKFFWQgIZwvaavgI
         s0zpEBfqeaaTmLquCEO4zG2OZQfb3Ir+Qe3C9OHNPnW5MKohWkI87Ovwq3Pydpcs+7zb
         Ie6XGrerkMYLcsc7im3B2Vx13OvmXRaDLAndzgbC721KgfGXMwyCB7AqJKZsuYBsTQBm
         QqvNM/H84dZfjKtvHuJJKjBcjug4WyxLk4bVMfaQdZjK2HJb/l1o9PMwsF8cfE/AllTd
         vI5A9+T1UEQHMt8grV+iMwPhU/jplRzQaVsa9C9FucIeqIw8hEzTWarRVn/NgDCW84c5
         8Qig==
X-Forwarded-Encrypted: i=1; AJvYcCXc8/7Ps9FXVm6X8Q0qdTQKMH5uyn6vgc74KRpRf+Fhbe3km6G9wX+FXPhvzWQmZHezwFj5gyYRBzep1O8ES9Cm1ua3ARmOZCjhPyr7
X-Gm-Message-State: AOJu0YyMjAorP6SxrRZ63R7TtQh10zike4lc67dLxM3iJlLAWs5hBl65
	r4CM/kVlKFfb5IY9u1N2CvS+P9U724Jbht5O+8dLWTQg/icMS6KNUdhdxXSCo/A=
X-Google-Smtp-Source: AGHT+IHGlNZJk2OgRWQ8EYg2rsbzX9mhgpwNdd4jOMVlOFKRnwWm3q8FMrXLPKl2frkadi+gta/3Gw==
X-Received: by 2002:a05:6000:24f:b0:367:43ce:9c92 with SMTP id ffacd0b85a97d-36743ce9f2emr425332f8f.20.1719474967330;
        Thu, 27 Jun 2024 00:56:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674357c089sm1024019f8f.7.2024.06.27.00.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:56:06 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kelvin Zhang <kelvin.zhang@amlogic.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Junyi Zhao <junyi.zhao@amlogic.com>, 
 George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
Subject: Re: (subset) [PATCH v8 0/2] Add support for Amlogic S4 PWM
Message-Id: <171947496641.3255632.14959368201943139429.b4-ty@linaro.org>
Date: Thu, 27 Jun 2024 09:56:06 +0200
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

On Thu, 13 Jun 2024 19:46:34 +0800, Kelvin Zhang wrote:
> Add support for Amlogic S4 PWM, including the driver and DTS.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[2/2] arm64: dts: amlogic: Add Amlogic S4 PWM
      https://git.kernel.org/amlogic/c/e227c1e14dfe06a54844014c076d11e9cdef87e4

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


