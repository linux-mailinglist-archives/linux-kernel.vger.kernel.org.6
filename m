Return-Path: <linux-kernel+bounces-551276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB115A56A61
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08C21899820
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88BC21C163;
	Fri,  7 Mar 2025 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z17HDPYr"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886321B9D9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357792; cv=none; b=OvP+zlm41dJbqgX5PuHuU+vqh5NhS+Wu40hubMCgrBcaKsGYnjM1do1GzAyJO7w+YRb00MU5wezmV0lnw29Es/e1OiNiTgkDgC6a/YEJKxVJ2T5EyRUlkggCYO8AMvL+zkV4c2FkHlgrBUPRye9U1+5s+YXuNKclBbSOu3wQkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357792; c=relaxed/simple;
	bh=YIOMNLEjH69nnT403tSpw0NEiiWDGz/NjC6xURZwUgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2NOCfa5d92ClBmHu8/UIapkThn2+SEK+p++HbXADV+E36VYQzBJAnV8WfrNaU4laEO/LAh0FxVSmJ6u5XPnXgkSyThqhqShX6/dKKgc06zrYbVP4hDFt1CXKqEutSX6DRX/X+r2/kioYTqiz+kwqhcROYsV5o+ThBfnhbODyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z17HDPYr; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-60029342c98so1102217eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 06:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741357789; x=1741962589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YIOMNLEjH69nnT403tSpw0NEiiWDGz/NjC6xURZwUgE=;
        b=Z17HDPYrBl1PNdX/ewmZy6IdED9fcVJZ2LQkj6dpDn9tW2uD2Ow9fF++eoNxZo84Vh
         ZGaC9ww8Wqn3pyxx6TTVirYuSUp2kPjY7V2aWQGSuhh5/k65CGGE4ueojhqEI488Jm6Z
         PlneGRRs8jGrjY8aCmwdeLUSuQZqWATgYzLEFjpqrjhP0xFOf4mfD3CDa6OH22x6n8mB
         z8Id0jYHdeHZ3Y0iIWD17y0+tOyu0xxZ6P1AOuzDbGQ8fMSs7NwBQZc/cMBrbO769u3k
         tygQ0wFkeO/I/nqpMzZXxcrnw8xPaqZImG2litFL9HhkY6MY+KDy2SZf3Mzu4fkIQTM9
         Uwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741357789; x=1741962589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIOMNLEjH69nnT403tSpw0NEiiWDGz/NjC6xURZwUgE=;
        b=s9EN+AsnAucbcGM7sU5f+gHKd423DdhzHmq10T7+qooDjt5wPi7vxkwlOls2ch/TWV
         DJInlGNEvONnlQXKTvulm/5KhsVrbHq7F0yh5OMAEWeQsELd8TbSSkQsEl4pKrA8+cIa
         +UwCXYsYD4NyXQcVHC1YcZJ2a2r5WKRkdl+TC30vvPVOlDIKg4pyhgtmeYlzpvIOPveQ
         hTIqHlnJW70RSzLtsKEoX5KVXfMPAiPrrcuXq/LHIQgXGitpoW/Qn95ZBOriACqDljzb
         Nk6RU0hozUo2XwnPtmwS5bWUWmpTJ89ZvfrLw2+pha6i3QTDe0Aj8t9Ig7kITx2uzcjl
         LlCw==
X-Forwarded-Encrypted: i=1; AJvYcCUW+HIF+rE4NhbPueI1FXdniLmyURCIdNwEkEven8a/96nD5pdXpkRtmoltHd7YAXTtMNPfJLsjmK8ZAcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5DLWUOhadou7StMtoK7YAuwp6zxR2SESOEFoGWDPV1RiNKbH
	jDiTUNATO9K3hameI42LP+KE6As+r4HOTyXuH0ncQnu88QpjACt7ef7JrQ/HXveXcDqLskWBt7K
	pR9k76Wzau2XjygypWZW1sGNKfyPtO9xM5o6ZSw==
X-Gm-Gg: ASbGncsRcmOrSsa5frhKwPcdpGepQmuEtuuHOL3ENPnAd5pRHGDjfNjRdSJxkC/c2dA
	5Feu7HYotrlOKlT1TVD4RWcIq4jChJYRtPJymyJMBODG4wdKag0d5V6ve3PBgI0GeyxIOW9p+ku
	TI/pEjZqvhOzHNxjmTdWatFxVwFtI=
X-Google-Smtp-Source: AGHT+IGGmn8xLMWajxv8ICMHuaMrPUNcMWpzQrq5wZQhGe8IYs0letUmBAshmOVmzeAwyTeMZx2VSjL3a/o/8GUoJQw=
X-Received: by 2002:a05:6820:2709:b0:5fe:9fed:f391 with SMTP id
 006d021491bc7-6004a78b8f1mr1708857eaf.1.1741357789463; Fri, 07 Mar 2025
 06:29:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-clk-samsung-headers-cleanup-v2-0-ea1ae8e9e2bf@linaro.org>
 <20250305-clk-samsung-headers-cleanup-v2-2-ea1ae8e9e2bf@linaro.org>
In-Reply-To: <20250305-clk-samsung-headers-cleanup-v2-2-ea1ae8e9e2bf@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 7 Mar 2025 14:29:38 +0000
X-Gm-Features: AQ5f1JpUppE0sfHDV86NNTwKvteo5ZV6XyAd9bvAyX6uA7UR9Otm7vbstJwPknw
Message-ID: <CADrjBPq3CA97cGopuCFD5BrPH8KnM-rsi7vMC3w285ihNDm40Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: samsung: Drop unused clk.h and of.h headers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 20:04, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> <clk.h> header is for clock consumers, so drop its include from the
> Samsung clock controller drivers which do not use the consumer API
> (there are few which do, so leave it there).
>
> Drop including of <of.h> and <of_address.h> headers for all drivers
> which do not use anything from generic OF API or of_iomap().
>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

