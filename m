Return-Path: <linux-kernel+bounces-369372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51B19A1C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6840A28289E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D67E1D5AC7;
	Thu, 17 Oct 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcCGXIv7"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BCF1D9698
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152201; cv=none; b=AbA1tm/erR1K9E13LXTwMihpCX4S8ZZVddonKdjs9XxM5/sWrx2wEJdEBUV/hZl7IqNyx5RQ6XB+Z5fMi4ok7/VOMEzjh3HBV67hMW3pIsGvJC4p+ltCQC2bfDVKr/TyVQqOzIgvds9UTAy5y3H0pYFsZq2/BmQOXokLw7KbUOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152201; c=relaxed/simple;
	bh=4apx67hMPEGfW+X8x9LFHcZNR7+Evj0GhnAX780tCk8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qlvnUuwDiUQMg1NbcGCG5pb79kwEejSGlXSXSQQHFpf4IZO3Pa8+Qe0y+N9or80Uf7imBAC02HbkUBBxbrl3LkqN79AYb1WWaCV+MKrgwSPT2dLkHJqIw7OhHOwaY3//fxI58aiqni4uujGJvl/ud2RKf8Dg7QqrB2JHvSFWNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YcCGXIv7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43159469053so950185e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729152195; x=1729756995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgDrUEOZ94rd/JYn5q5SRCaHm/3syJ91b47zWHTaaZg=;
        b=YcCGXIv7wed2keCKFBSpByTu1X3n4saKmeOV8B48UmEPqIT8TdhkPw/J0vdWGA5Qk5
         EwKCEMEY5oVL7G9qfEVpxuLrC9N5u7OdPUbyzFfeMDcORE6wopN9x1iXwEC9r/Em+ZT5
         P7Q2nu/UB0ne5hQFavco00HwaTwihNk12RRrifXsuSB3l5FSHP29QJhf3/DjFmZ3UNC6
         q0uZlGbeSBhrL97o6RUOFm3N2Rph9RExFwOjSZrFuGai7YttnCZ1zxV7K9tndXGHgsG6
         5LnUV2htXTmIlrxR0wdEQeEcoUXQU1J6M/cnrSYwHonkxxoFLKyJ7ziPq7uUE0ZZCQlG
         kS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152195; x=1729756995;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgDrUEOZ94rd/JYn5q5SRCaHm/3syJ91b47zWHTaaZg=;
        b=HgaV04jvldTTkM1f7AsO4y1TilkjcbmyZsLg5mmY+2gj0u47TYmFY+6aMnMAuaW3+u
         Y2Z9Y1YXzZrRrAyKvLhN6Va4W0UXJ2nKDoiLhCmrV2jyqccYybAx3rAJ18157r3I0zwI
         Y+x3QWQkW0A3yuzvTkxlOb2aOd260paaUM5625bSEKQFUYHYBP82gWG/jFZ1YndAV032
         eloXWM+dMeNZgkRsX7c+UcE0dHJQOfHonrBG3I9J+7Kx3jBM+hbOX+uwNkyDLZQ8AJXC
         z2sbpMc/8SlsgYmPJuurxpQCAPq1jNvSb+aZK6V+orvfQkbwrmd6q8QliF2KUdfE92LF
         fEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1Jmb7Up7AP9S5eIjI2O9xg/GMBT6Mj4yjpZN/4A8YqDQbfskSzuvaVRpNDLZSbgm41UKIHo7umVh7z8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Q6t6I+o44QDPUlN7fhD/atx2cK8Ir7uZ1dAX3e57hdRm9t6u
	10+yPZ9CN3Rf+iqGjucfCQTrqeH4s9UwV8tefs+YzkIqsz9P8GWqVGgXHFIlWDQ=
X-Google-Smtp-Source: AGHT+IHv78ZK3kwWzebAfwfv7YsgLxzY87tYqG8Cfv9L84+hdRFMj6rOmLuL//nV67nrynimgjjL4w==
X-Received: by 2002:a05:600c:5120:b0:431:5632:448d with SMTP id 5b1f17b1804b1-4315861d9e8mr7487085e9.9.1729152195045;
        Thu, 17 Oct 2024 01:03:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a151sm6387002f8f.10.2024.10.17.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:03:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
In-Reply-To: <20241016154747.64343-1-igor.belwon@mentallysanemainliners.org>
References: <20241016154747.64343-1-igor.belwon@mentallysanemainliners.org>
Subject: Re: (subset) [PATCH v3 0/6] Add minimal Exynos990 SoC and SM-N981B
 support
Message-Id: <172915219372.18330.2035321894922518356.b4-ty@linaro.org>
Date: Thu, 17 Oct 2024 10:03:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 16 Oct 2024 17:47:41 +0200, Igor Belwon wrote:
> This series adds initial support for the Exynos 990 SoC and also
> initial board support for the Samsung Galaxy Note20 5G (SM-N981B)
> codenamed c1s.
> 
> The Exynos 990 SoC is also used in the S20 series, as well as in the
> Note 20 Ultra phones. Currently the device trees added are for the
> Exynos 990 SoC and c1s. The device tree has been tested with
> dtbs_check W=1 and results in no warnings.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: arm: cpus: Add Samsung Mongoose M5
      https://git.kernel.org/krzk/linux/c/0d16910e899d0645e45128102c5113836eaf9bc1
[3/6] dt-bindings: arm: samsung: samsung-boards: Add bindings for Exynos 990 boards
      https://git.kernel.org/krzk/linux/c/f7aeff28f2768443a49600625b6f3d0aad1fdd52
[5/6] arm64: dts: exynos: Add initial support for the Exynos 990 SoC
      https://git.kernel.org/krzk/linux/c/1e5f14efd65caf1d173af8fb4eeb3e04b2625ad3
[6/6] arm64: dts: exynos: Add initial support for Samsung Galaxy Note20 5G (c1s)
      https://git.kernel.org/krzk/linux/c/8354f854a90bcecd32dc1dc9646e805d60e96f0a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


