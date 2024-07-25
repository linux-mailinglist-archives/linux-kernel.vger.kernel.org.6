Return-Path: <linux-kernel+bounces-261853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503C93BCF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198231C21003
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60FC16F27D;
	Thu, 25 Jul 2024 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiggwWEX"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1516EC18
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891647; cv=none; b=XrmPux7lBoR7Ya3ah6VsyoYHIuF9CLr7nPOQGaBVD06Zt2f51rlcEyU8e54llxcv0wHKPEwxafkajE/6WQFuz9xhL0REy1dqoqqoBB5rqLZEwSsda3f3mFKUojpcrIyFn0tbY2bji05PZzpFuCeSb/N9X+Q+5GYvucjfIHtLsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891647; c=relaxed/simple;
	bh=AH9MPnXwcjFIyYvI5beVZA3B4SXJAwhkWPJ0PBaM0K4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AslTUVgTxYzbO97GvQGCoHbIs8uAL7P3jQFSiE32OdfyatLT9wimAvd5vRA7ltu9l4bcaLJEA/uq8+KHlEsZUrgtQPgTM5rgTOehfGcRztTzaH9c8phIrn6AnE4HP+dZVnYq4b6adGj5Hne2Ge/spD5RoYgUki7JTfGj34vrLQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiggwWEX; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2d7d8854so6882161fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721891643; x=1722496443; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AH9MPnXwcjFIyYvI5beVZA3B4SXJAwhkWPJ0PBaM0K4=;
        b=XiggwWEXGABbJqgTw6xlI6t/azBmosXETnwYJFapYvytfTP3WI75O4nhnxdlHY3diT
         zfK4nAeoqT/O7q/PoODuIfWjoLZb24ioyeorHIGDi6v4pdzVoS+Vbfguy23SVigD+BdG
         pyo64sKNHpqY7m0j1Z4NntlG/n6PtP+iQZk6OXYe7MY6TBXm2XlcNnEAi17BKQcNQVY6
         x9vvzIu+E+M6JYmC3fDKz8NAfvT3KcqY/+b/+cnDWEdkJqsWIh2J25xQwS+6uQObvwJz
         583Lpp8FSl81WT8j3zz0vkgvbGII6E+d4H0VoLGepr57iioif0CM1lI8s2z0eU1O6NjA
         Erng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721891643; x=1722496443;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AH9MPnXwcjFIyYvI5beVZA3B4SXJAwhkWPJ0PBaM0K4=;
        b=k/YYjvj87hLfTiXj4xgw9yLssaEWiPFFb+jayE0EG3nfhhGkoxX8k+lQgPTJuQ0gY4
         09olH8utytHZooV6Cr+8ONFQIxg35Opcs0B48J7M72Brr0k+uA94hJMsznxkMcLSUX5a
         DEaWYPLNRk6CfMnhT9jmAEIGSEBGsD8LS8L1M7IyM2GE16/FMu1KVnb2gENXroSKEJ/H
         ZgUai4SgSY0elsQjJncF8fR3tF1/UIEEUFZwgA/N9VzbsE6whdVL/D6O2iKRzTT9LNR/
         hRPEppOehb59/uCgKWY1pASAx5RqF5Ak6FdGhT9UdBxO1wNJ2SC0S06wvMLF3kODOo/q
         77PA==
X-Forwarded-Encrypted: i=1; AJvYcCVOcTyVaYtTR1Mc4Z9lUzLHSTU4xvQ5hwEW7R2ijcKbNo3FUvwl8SK5HPOLivW+9RzTDOxXbktZDgwSZBnGhkJZcAhtGdIz7+EF/cnp
X-Gm-Message-State: AOJu0YxUUSnfqXbF+dw5RO8CTx22l1/B9xdUEcwymEtBjmRQNR7CNBzb
	LXNjIpWtU9ADMS+eMPFQHUO12o8piovjgPS5ZKKwpncJZiiQaRawNM7/pdlTvFw=
X-Google-Smtp-Source: AGHT+IH3gUGG19nPRevQcZ3s8hd7aQYxqwF7qT+FALLS7KJHriJN0NLfu5I762+j+gSizAv6avdUMA==
X-Received: by 2002:a05:6512:1152:b0:52c:d7c9:fb14 with SMTP id 2adb3069b0e04-52fd3f33b4bmr1248062e87.34.1721891643296;
        Thu, 25 Jul 2024 00:14:03 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a69c4sm19760575e9.33.2024.07.25.00.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:14:02 -0700 (PDT)
Message-ID: <90689f490cba6ea4b1bcd18c451630123a923f48.camel@linaro.org>
Subject: Re: [PATCH v4 1/2] clk: samsung: gs101: allow earlycon to work
 unconditionally
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Peter
 Griffin <peter.griffin@linaro.org>, Sam Protsenko
 <semen.protsenko@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2024 08:14:02 +0100
In-Reply-To: <c2c2b51d30f551bf8a9c1fb6507301bb.sboyd@kernel.org>
References: 
	<20240712-gs101-non-essential-clocks-2-v4-0-310aee0de46e@linaro.org>
	 <20240712-gs101-non-essential-clocks-2-v4-1-310aee0de46e@linaro.org>
	 <c2c2b51d30f551bf8a9c1fb6507301bb.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Stephen,

On Thu, 2024-07-18 at 13:46 -0700, Stephen Boyd wrote:
> I don't see anything in here that's driver specific. Please move this to
> the clk framework, hook something like of_clk_add_provider() similar to
> how of_clk_set_defaults(), and have it look at the of_stdout node for
> 'clocks' to munge the clks in the core framework for the serial console.

That makes sense, I'll have a stab at that instead.

Cheers,
Andre'


