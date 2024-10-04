Return-Path: <linux-kernel+bounces-351501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ABA991226
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209F6285E1D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813761AE000;
	Fri,  4 Oct 2024 22:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jMc8bnvO"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3E231CAD
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079754; cv=none; b=suVtQ1ycSXXARGkqD01QTav3id3oiVK5yyKyYIWaRgVgOVkeif9XrkE30a5Bl76HwZvfQ7bKLVCgoCnrOn3Q3K8WujwuAghDv3rdOr/Tr4LiQAFkiqip/ESppKhZ3Gq+caGr1qq9r651qUdzYpXu4vkqF3nGCbqWhjvv/gAuCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079754; c=relaxed/simple;
	bh=TIg3IMhaT0ye8GFuRZW78WuPRs5cCfT/FubBhjwyMUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NZskOcnTZUXoxjha9qkz38ALBSxverUqY7d1+7KonWgzEjNUjVBuUVuXUVm05PAt44ls/d0oUt5CbActiEfXDtLwCk1u/19we7NqRWKrGECq8n63HZB4Q+YlcIExSbF1E67ryOrqASl4IxJSgLbLo2rjCe3rdZAfJA5ymVr7ZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jMc8bnvO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71df4620966so13683b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 15:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728079751; x=1728684551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIg3IMhaT0ye8GFuRZW78WuPRs5cCfT/FubBhjwyMUE=;
        b=jMc8bnvO3NGEqCieQkzQjVkluJktyThqZUwwuurwAMNpUUUWpWeARmdDFg6Q0EZn4q
         y2ZUAmL3qUwRFycpQri+yNrDy/qjuZkhTpzMHjuvvcRycZLH231DPBMncVAbhkjSrYfn
         FKF57hrf4MPPwrBOiNHPn7I3okkCjOXAlTYUV01CnHWYD0wsORMpUJy4h4qrP5kNTxBa
         GUbUxkAeiCmSmSHYLdWDxaSjv0N0e5eaLEH2myh5iRwKPaOD+PzBVqiA0ZsEUJEqtc07
         TKq3MCCLAVYLHnAdyGWWTypoE9gmWqAenHMje6ik2I6X/Lmy3mw2EoLbV9KM4l4fcHxe
         ov1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728079751; x=1728684551;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIg3IMhaT0ye8GFuRZW78WuPRs5cCfT/FubBhjwyMUE=;
        b=NpAh4rhvhSFyVJSHzqji8mVhNrUBOUGLit5otOvwXMEIccF5lXGI62N7lkM3i3LqBG
         L0Pc0+l9WzJ7ROM98Xcv7mheyx5KUyWMCZq1GIi/oaQ1ZX+MgFK8rJWhkXajnEuN+Yg5
         GMSJdT1zsK7xpGeoTVGJ6yCLNYXzIy93PXQWVCDn6ORHXa0GdMg0H009WB96OGW1Ft5q
         t2YTg2RX79T1VH/aDke3s3fwWLPvjCUz1CcmLg7K0hwGhnjcDGX6pqxxreGecrTQ/AwV
         ws1K/ptm0VjxMOSxZr+7ApBwLlcWEod/N5GylWLVaud8SgJkhR+eoLceCUiSwQDm7cVB
         gEWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW360fHJFjz14Gcmm3PT8cbaVvsw8G2KS2pc/eqPIA8cJHVwy4V09+Tsi9kffpDru2CqUcsXckm6Nwsze4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjxIsn9jxHdso41Da9B/kFcJ/fpzNTdkqhTqohW5eNIHoKfzL0
	g2FJd9PE/D8aOo8NIQKWmRm+9cFaPUT0nQjuyPHBmZ5prb3/TSlXJWO1PUcUUBo=
X-Google-Smtp-Source: AGHT+IG069EnxRv30+3RjzhAK77wi1qDO55xqPHdUqxs7JXDSV/D/reKudXwRnQMxPPARwBk4/0s5A==
X-Received: by 2002:a05:6a00:cd1:b0:717:8a87:7d02 with SMTP id d2e1a72fcca58-71de245eb16mr7947141b3a.23.1728079751622;
        Fri, 04 Oct 2024 15:09:11 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd5006sm360165b3a.77.2024.10.04.15.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 15:09:11 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, Jonathan
 Corbet <corbet@lwn.net>, linux-arm-kernel@lists.infradead.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Linus Walleij
 <linus.walleij@linaro.org>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Will Deacon <will@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Conor Dooley <conor@kernel.org>, Heiko
 =?utf-8?Q?St=C3=BCbner?=
 <heiko@sntech.de>
Subject: Re: [PATCH v2] Documentation/process: maintainer-soc: clarify
 submitting patches
In-Reply-To: <20240925095635.30452-1-krzysztof.kozlowski@linaro.org>
References: <20240925095635.30452-1-krzysztof.kozlowski@linaro.org>
Date: Fri, 04 Oct 2024 15:09:10 -0700
Message-ID: <7h4j5rjzax.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Patches for SoCs are expected to be picked up by SoC submaintainers.
> The main SoC maintainers should be addressed only in few cases.
>
> Rewrite the section about maintainer handling to document above
> expectation.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Conor Dooley <conor@kernel.org>
> Cc: Heiko St=C3=BCbner <heiko@sntech.de>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Thanks for writing this up Krzysztof,

Kevin

