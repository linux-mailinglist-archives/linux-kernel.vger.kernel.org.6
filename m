Return-Path: <linux-kernel+bounces-311331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C03896879D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D17D1C21CC5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0FE19C55E;
	Mon,  2 Sep 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Hl+4GqzY"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB119C56D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280547; cv=none; b=ByI+AcL/7jsuV94BVgu8ENJuVTCLWY6FkRmTQkbYL2610aGnuWhycmq3oSq7cWCz8NhcySEMQxogMPCP6LaQznUweauLAnq8x8/pmo+rK+iUAYQYSPx2utuihWg+PMWewQvWFLc/CyNqWWlrAS5MadxjYOEgF4PtxESSzKCl7Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280547; c=relaxed/simple;
	bh=aOwk+CL0TJPxOVN51SIzI/t+S0Trf54uN7JkkUAIU8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uenBFTDXt3LBPZXCjc7pmJAZ/dyCZeF233PyK2Fim+Iv6963iiAjKjgnldfZGmXAQ8IEotPp1hlEHf7KFabt1zdjmevatls71z2sozwwXX2ydgohjUCWDd3wV1kpqLgursYJ+7UKD85k5e5bIiL+fKBT7MxsT474uybisCzjW2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Hl+4GqzY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42c7bc97423so19047385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725280545; x=1725885345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tpnj+/HKdVwgf15IPSWq5bY+Pk4gPjusx0sjEUnHeK0=;
        b=Hl+4GqzY5zNiDn+ZinOgd5ZtAn2L6zaeRsBm169bKrJYzLDy5Avd6Nhbmf4VHD0YGF
         2nv2yQGCsCTNUGjZroFJOgLfVW9hx09eahGv0TCNRHMpItRvAVFw8BKfnXat5dkOBwSK
         JXsKlge+yjxDzrn6BqKlXRnSUBUbg19GzGSUMiRH7BXQQuSnv1nP8vyURuGu4vdJkjpB
         2VN8LdwWmjHe2OSZsxOkYWfXolGUOcbi8QOD3a6x7TTNtngNK6FOE7Z4tShfTG+J1F5O
         vJ95ilODFKhE2Q4djCWQ8YYI3327E9rs4SFVozA7HMQB0TjUM7/dBSKiGeQfPusIFOh1
         hpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725280545; x=1725885345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tpnj+/HKdVwgf15IPSWq5bY+Pk4gPjusx0sjEUnHeK0=;
        b=QfV29xLxGCO895WwQuS759vGsEiASCo1qDAtPMQXOhbzAzDwBhedZ/OgQcWyI0ewTi
         yQJl6pG2k+092qQtglaPSxbzjHtL8D7pHiVSne8N8US1+StI4z9zJw+vSwjHjpFGH2+z
         q1tzqdsJJxQTNf+9II9CHrEwyX7hItkSjnRuD3wCYfBIgNIiUNgB6dE1OUODPe8DUann
         mZ+FEBt2uDpYbr0aWUEj/XLFvwsG8GzMEPWoProeeCMxT3anaDNqJl4Pb9ipBeoNL5Rd
         5r7UEcGW+bRZoZHxQTrAfG0x52Hefxlizh1aHz/qS/AZK3n+srm4iSeJGbfXKhYfbAMc
         imcg==
X-Forwarded-Encrypted: i=1; AJvYcCWVD1iwPUlLGfGQ818dSpneQlXn22D6pbAtIoCBPo99URXXipV81atZcVGCYHghtnzZOhVb5Y7mrsFWgms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCaBOA3I8aLKnkhkRmKDHUO0dI1wgg4fz3yt14bHsk/t74WsuT
	sUNaKEI72dO2Sk5IgWA+YL9UCxsdJY3qjH8SrQEqsJ7oEySPJhMK/pzSBk7RWR4=
X-Google-Smtp-Source: AGHT+IHwJl4i3KHkhdA+Vrs/mDuObZdEmS6zBbFWSWuaIR6VdOmEX72sy09bnz0/7BHM/1CuOEsNwA==
X-Received: by 2002:a05:600c:4ece:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42bb01c1b92mr140463635e9.18.1725280544243;
        Mon, 02 Sep 2024 05:35:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33e2asm136864265e9.45.2024.09.02.05.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:35:41 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpio: pch: kerneldoc fixes for excess members
Date: Mon,  2 Sep 2024 14:35:40 +0200
Message-ID: <172528053865.30388.17206369071478627196.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240902121258.64094-1-krzysztof.kozlowski@linaro.org>
References: <20240902121258.64094-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 02 Sep 2024 14:12:58 +0200, Krzysztof Kozlowski wrote:
> Drop kerneldoc description of 'lock' to fix W=1 warning:
> 
>   drivers/gpio/gpio-pch.c:101: warning: Excess struct member 'lock' description in 'pch_gpio'
> 
> 

Applied, thanks!

[1/1] gpio: pch: kerneldoc fixes for excess members
      commit: e1df5d0229c37265e4a84a32e71690c5089d2f5b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

