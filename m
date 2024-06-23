Return-Path: <linux-kernel+bounces-226121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC74913A84
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9C51F21890
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28620181D0F;
	Sun, 23 Jun 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yoypqlcr"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BF181BA6
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719145361; cv=none; b=FBQSREsPOwzfERwoaSYmgkyUo0PQNhvjSfNrrZJpztoU57uko3fKa3y366P31g3nh1qiCR495TDVhKdTf9Rld6g6WXg1j9tNXxkR+yCpvSwglXix8dkDQvPgAC0TBUG0ocLITaXLmCcls8K1tzSX6k2Ow9+PNdhGrbbSe/8rIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719145361; c=relaxed/simple;
	bh=dptKWOler4N7yIKYoGpq4WLD+5yTvioWdUK3HNlSHmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aL/8B0QoEwQEv939T2OeBYjRFMFjN0VC9g7Vw2aPosAAs+DF47VD+CH/AORsXC1hutfNGKUk2dLasFCtmDNMi9KBzJ3GBfNNk2s7Od09o40JBqkRBAV0o8q4h6OgVYOI5NZd7qH+ERKIZ1Q+ZiJGt1+t7TsAwgr/LZRLpGve0Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yoypqlcr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217d451f69so29409025e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719145357; x=1719750157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEyt1clUvQ1PslgHqEefPU/EF6DS0rMvBZKOKD27pAk=;
        b=yoypqlcrRTjkP50w312GmUcl/9VHPgnw653zk00RoLXrbaruNCF0ch7OFZ6qoUz/y5
         FoPeFXqidurXff5AHqKgo7OJ4WlyLOQi3/MoxB6+uyG8Mo6MEaUOPBM4+ozfKn4K3MMa
         fcfFbQ3bmbZ5K9IyZKDTjlM4YnE3jE6F+RM6fzDo/DPtW+NU+La86DYZqnWUmVHIeTcH
         3iz4J9WgurgYQhNrNZN9wK0VJoWs2sJsZ83efQlS9k0uF/XsaOXm+BbdRZUAupWkiapH
         OMoYq1RNJfHviOcY3ulSMrDjD3txNpwYk8N6dcHbHeVYK3A48BxOBxxot9EBfYHCXMoe
         XPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719145357; x=1719750157;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEyt1clUvQ1PslgHqEefPU/EF6DS0rMvBZKOKD27pAk=;
        b=vE6fDrwyD63PsN9vSAxRkPShQ13ldaM7LvXWI8bbmBgcQdcVuxCRL5YZrSwJn9mM9u
         ku51pIoL8t3jZJd4MLbBTz13CmgUDvbNnY1FLZji0MMajjtRrjhugYwAewdiwQyYUUp0
         UAUrpWRVZKo7x1qBvijB/wY3ktkWB+KMpN2/Eq18YEuH8Eh775OQpI23RAR1wdqrkKHD
         QKChuY8rwtzwbsY3q6dvO/WmqWtG++6ma2z00MystUwp0EfiOcLorQ1ZBpzrW0a82Yvz
         Ht5O4yDVO8IkLkDktJojPZ6lUX4rJGQ6IyV2lGQFZmG26NM8cq91ggFwhHRU51phpO3y
         nmpA==
X-Forwarded-Encrypted: i=1; AJvYcCV8o0YrX2NgnRFeJdso7jHAOiRkR+i7zMCsA3VuYBgxv8sw/cE7uWvVkD98ZfVHmCGQzMmlw17+F/SXr4c8/PL8c9aHgKZRMWBf+ZtZ
X-Gm-Message-State: AOJu0YwQw2KEH1WXJPxcdH6UzYtGEQvkFeFwOJMAfw4G2Jk0c21NjEh+
	x5J2Dn2Uqs9HbYWX/kxhIkqIkOqG02kP8IRaP8ohg44sg77eEN7IgOSZlQb4xpQ=
X-Google-Smtp-Source: AGHT+IEMZCFOhYXky3s3TDx8dy5hM9Fnpch+Lj8XEfUD5u6tCF3MRMkE/dJ5+tVAvUSDRCUQdjLCtg==
X-Received: by 2002:a05:600c:450d:b0:421:7198:3d76 with SMTP id 5b1f17b1804b1-4248cc58b99mr12799485e9.28.1719145357746;
        Sun, 23 Jun 2024 05:22:37 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be841sm136955455e9.20.2024.06.23.05.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 05:22:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Oleksij Rempel <linux@rempel-privat.de>
In-Reply-To: <20240612141018.7348-1-krzysztof.kozlowski@linaro.org>
References: <20240612141018.7348-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: ARM: alphascale: add Krzysztof Kozlowski
 as maintainer
Message-Id: <171914535659.46985.7068409299945759255.b4-ty@linaro.org>
Date: Sun, 23 Jun 2024 14:22:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 12 Jun 2024 16:10:18 +0200, Krzysztof Kozlowski wrote:
> Apparently there was never a maintainers entry for the ARM Alphascale
> ASM9260 SoC, thus patches end up nowhere.  Add such entry, because even
> if platform is orphaned and on its way out of the kernel, it is nice to
> take patches if someone sends something.
> 
> I do not plan to actively support/maintain ARM Alphascale but I can take
> odd fixes now and then.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: ARM: alphascale: add Krzysztof Kozlowski as maintainer
      https://git.kernel.org/krzk/linux-dt/c/3974eeb925657091884a2a44f8b71ab56befdce7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


