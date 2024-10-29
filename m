Return-Path: <linux-kernel+bounces-386652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8429B4663
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE25B220B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B42040A9;
	Tue, 29 Oct 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2SEk6mL"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFA203710
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196324; cv=none; b=exaOmcFPUbzf6E3GbK7HWh+pWtWsl19AQv3VSKRxA8GemfoHTgMiCQcWhYNbLYMandNamG6FEDb+IymjY/vLV0GqMNNTZXV1bsSJiZosLyTO4Ga5kDNPjmjimlzfnVrFXRpo7jaZ6jLF5cSMvekZ0WOWs6QqkRqxeXJ6T9seqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196324; c=relaxed/simple;
	bh=AfykAnYLZupGg1fLCVn8uYBy1t/aBOVuyKkPyLQTwRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZINy91ualHaqZg/WSEX17tMi9JvoPnhvpHjBi0x7wHKAuuDxilFy1sLiIm9I/JNjAAKK04lhQDflxsskMu6pXfiAj/ik1P+E8eneggZYHKo1x3T8IEziRGT9JWk5NY3Ery9LMNkTS0xLhbeUQc8rwvZxkmh01SwfwaMIioZEATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2SEk6mL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539fbbadf83so6740059e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730196320; x=1730801120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4RV5zlTOUYZMKhmx1UYpbwnBm/HWX3vXyjwC0A2b/s=;
        b=K2SEk6mLQhmuMGkCEAP/7maZCivDCatMZZU0ZxYlsyNSCCxV0fLDCKM+gL8MAINSJ2
         966UBH/rygUX2pZm0WbB3mljpKcDeRCdmZw4LlSZEntx22jwxiGaUu2+npdSWrjr5O0M
         w7aB/2sw6qdLeI3tUcSjT9pVsah0SfZgpiW4vYMjER0M+6uM6ehds7TRlKSiE6A7uu6T
         +wgKZrlpDVgxRESgyv97l2sbU0mGz5/5nxaAowfDcUV3NMcKpbRf0N5iwNknbvACHYl6
         UHzmgKN9P6l1t1QRjnMJ68S+hAlJbjmdMdmMYtmZUhWF9Ci8VJWcR9ZXK+INm6ZKxyrK
         Aa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730196320; x=1730801120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4RV5zlTOUYZMKhmx1UYpbwnBm/HWX3vXyjwC0A2b/s=;
        b=E+Nrj6iwuTtEa8uU9lkknPYr42ZQ2HCXF099ilb+C5DigSvYWy1ZJTlQV1axNrUERP
         Fmfdf0NkzobJxMk/wx1fqsYJ5HEMNUrH5uB9Kc7br8GtaupGFEf0l74+GYOjALB/Z18J
         +k8GPG5Cr5wRW8xCTkmme2F0S5kWsD4eYNpMVpTh4dyylvXALGlO+jguQkBgwQQsAy6G
         yvAqGiLK0foCqXrHHcwtomV0YnCsFasLvw9r3YqG/+9wy6K1Xlu0R677344ryPA4FR1t
         RHEcyFF08k6F0vImFqvU4kzU6iCIyqROeylIkc5oXh3TDZ8aavBdWnQSP3MzTHujQ446
         jyxg==
X-Forwarded-Encrypted: i=1; AJvYcCWoLpw1YIppzIJjXDiYC3I/OxRPhG9iaJ2wyGjBmhORlJhFW5lUKfKBD1SoXGDvivNJ4I3jn0J0mjdlybI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLsB58FIuzSneQAi2aOlfJJpvutpAUxjCPhqRXNZ07cw8pl9Jl
	chEhQzGPft/NmVzu8uLfZ50QF7TWB7oAUmiOdN24L9uM94RlZc68vdMTXt6s4I+uh5mEMwgS7Wg
	IlZlGS8wQ7zUZZ8Wr2ltA4IBc1k6efnUQfBssUQ==
X-Google-Smtp-Source: AGHT+IHRjlZ5hUDjfU+PhK/6e3oqa7R+fo3XhjKnYIjv7VyxU8Q5LEQEqbHbzMAmS4KxgFa0+3jWkOmL3SAGQgEfxvY=
X-Received: by 2002:a05:6512:3c98:b0:536:54e9:3a63 with SMTP id
 2adb3069b0e04-53b34a19727mr5084956e87.49.1730196320370; Tue, 29 Oct 2024
 03:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029074901.18977-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20241029074901.18977-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 11:05:07 +0100
Message-ID: <CACRpkdZCeQFzqbSN_=jX-_406OyxOoLb3b0R5NX3SjacE5JZSQ@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: drivers for v6.13
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 8:49=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758e=
dc:
>
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tag=
s/samsung-pinctrl-6.13
>
> for you to fetch changes up to 6d2dbd4cec8939ad2b813b8052eb12406db528d7:
>
>   pinctrl: samsung: Add Exynos9810 SoC specific data (2024-10-27 21:02:08=
 +0100)

Pulled into the pinctrl tree for v6.13.

Thanks for sorting out the Exynos drivers, excellent work as always Krzyszt=
of!

Yours,
Linus Walleij

