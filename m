Return-Path: <linux-kernel+bounces-565904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640D7A670D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6AD42138F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9B2080E0;
	Tue, 18 Mar 2025 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXikAOnb"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A962080D3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292674; cv=none; b=MrDZ/2tfwitYDUfzZxqKB8x8QezUh+8elgWV+oAZtT2YwaV8t6kci4WGWH5235ObguPyD8ozPU3ByxOn5El1ZFCT1w5HoqFACeiFJ5DfJJAw4tepI9bXTN59oudIl52XgDcmvE+K3+zfQn7JHd0CW7oIzPT29V+MViTGuVAnZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292674; c=relaxed/simple;
	bh=yKQqeVn0btUdtS+qPzT5gdetvTkb3UZO+pyG1ZeZ+mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDbCcOwZKPD/9+F1yaLnA/ZhMr74VUS79FRGtHj0+0MrAgAbAsiAYrhMkkxHonYiEdEsPUmziVSXzoVkBb5iUsejQOzOjFCnxHld6+ATzf0UoH7cWhqlTn8t2pyDHRKKbg6QbJfZM9ZUjzVh1049ZmV9RDPHb8SMXVDHaJhWEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UXikAOnb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5499d2134e8so6096053e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742292669; x=1742897469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVUpvtTBLHRQ7RrqjSGWWvP5ToHEThWrbkH7ADEWZ7k=;
        b=UXikAOnbm8TH+gFEHGyCBEvUGM/HaqI6axbdWnHLn3fyHyBj9MoFp9LMdEq6pirp9X
         x6kOfOqeediFjUcwlkumwAklWCmmXh3A7Cy11obEaf0AEhcqLAdP+o6nP1rFkyKejdjz
         UIoq8tsWfsTz9xaJPRV1LEUp8ARev/47Id7BQtooL/c5eX+otuZUqBCSCcbK1Y8o+Yau
         unW0JUcBVa7UK23weMWrk68j5p24dBoeRgzqXj4VXf58Y2DxeLFT0HbQLc688Nlje4L+
         QsLG09iy37qXf4xU89EiJsNwX6Tlhx5TAogG6gtb8AiPIeapfNDp/e+zHufjFmcEKzyq
         /7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742292669; x=1742897469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVUpvtTBLHRQ7RrqjSGWWvP5ToHEThWrbkH7ADEWZ7k=;
        b=uVtjs5SGZOGeYbm7R58bpMx8o8fLQ6muH74roTTD4Axmwy4TPVy3cI8IvLeFb0wycK
         vizXhRoblVluldfMEuz90lS0Cy0N4bsEf6pZMa1QeZE3zfF1dGxlRmrcNLetQX5mh9jF
         uOecK8L0Cu2hkqTiSblh1mLRxyxU0Xp1Yjcn9N5xHtOgD8pkFhSKNrmUfXLcQIMyr2NG
         BKOzYQ1MDPfwO0IkqZF8QoVEAs1pZk95GcY7/nxA5Rp383/VPRCWnr21xoY2RWEKvqRR
         ETZwRNVB5O5X+x2biY/tw2TefddUf9tne8n0Pt8ksCeQxpk8UQWqhINTcx9VL8esxTed
         Oi2w==
X-Forwarded-Encrypted: i=1; AJvYcCWUuZsqq9Bigf0TM0895moNWwsOeLArhYvNlagYADsD5pGqJcZa+veAnO2z/ZY5w4r+wiBWtoKKrT4E46A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZP/YRvgHKACUQXGIp4U1T08W+1BApiKJvtwbuO4gM5efZadr
	xBljfIrZ/sUzhtnnFjGbjphtcdUsoOt64dnpGXr//BXe9Mq68ND0iTIq9fkbWrnhvraw3ASGdWq
	NJjXEKhycxzyvjpRHcev2fOyCSohCu3nIPqcWsA==
X-Gm-Gg: ASbGncuZIrht1bDQnkxa1tCBINnQ2DVhDecjxejWKO0p1h2B8tz6/lb5tzdk6/hVVM8
	DmdD9RTLogi0WWI2mn7ylUd+XQA3B8BRknHWGFV/AmHbq1CfGaggQGkgD4HecM5z74oBOb5Lmso
	MEmiJWgY6cEfLBBQilcL+Pm9RjLQ==
X-Google-Smtp-Source: AGHT+IGaqrncYYUr4sfyRfLFzOEWIoUn1i0mOansd4z1qNbCCAzVBUKQPVLdXhHFFByp6tsLCBEDJwkAWjabnBVbVpk=
X-Received: by 2002:a05:6512:3b99:b0:549:b0f3:439f with SMTP id
 2adb3069b0e04-54a03ba664emr2114093e87.25.1742292668868; Tue, 18 Mar 2025
 03:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316143108.17045-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250316143108.17045-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Mar 2025 11:10:57 +0100
X-Gm-Features: AQ5f1JpKJfFS7YVV371lRPx1Y2xc562AW9pLo6dBt2VW6OJo1Hlc7eGeR9sMzjI
Message-ID: <CACRpkdac0zZtB=85Y+Fu=TYwf9qTjNog90-P4SBjQ-oB7X5Vag@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: drivers for v6.15
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 3:31=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f0=
5b:
>
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tag=
s/samsung-pinctrl-6.15
>
> for you to fetch changes up to 701d0e910955627734917c3587258aa7e73068bb:
>
>   pinctrl: samsung: add support for eint_fltcon_offset (2025-03-11 20:37:=
29 +0100)

Pulled in, thanks for taking care of the Samsung drivers!

Yours,
Linus Walleij

