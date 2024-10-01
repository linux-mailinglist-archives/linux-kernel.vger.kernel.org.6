Return-Path: <linux-kernel+bounces-345955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D71E98BD5F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBCB1C2385A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7311C331E;
	Tue,  1 Oct 2024 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1MnatXU"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17EE18C011
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788918; cv=none; b=DzpY4TLNyBG/Nhm2YkviduliX32lgvjh/HlKY4iBGYP6SyvVVsEx5CWSk2rg1JWhJrG5T/QIFElINfDvbWvBFUyw4vnYlzNTYd2XlHeDoGzyWL7GYEazEG+Wj1aGDklVUj8EipOtB+ZcbAQUR3oY311EYi/z3ThOCr4HFvzuRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788918; c=relaxed/simple;
	bh=cyEcKeEaGeyjn3FmCQILe/HAvSQ7EjvyAoQhRa/81EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyVJeTrpm/370qWNcjLO4DT8cHNAgKflkXXGXsjCtk+HgEGcfJ2/hbeQCgsOOc5gohBIkXNTuEyu4u3B90xNz1SjvNlB84kP39dUR7idRm+9SoPcVUPYMEjab+IRtKd2IU83YgCAx9RWCeVhO6a2xC/JwlavAQbO4YFcycmOw5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w1MnatXU; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e25d405f238so4745586276.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727788915; x=1728393715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyEcKeEaGeyjn3FmCQILe/HAvSQ7EjvyAoQhRa/81EQ=;
        b=w1MnatXUByKr78z7ZGTplGLKVhk/yoQ5iRYII5biH/oiWFP+8YG/ShZybC0BP7nzKL
         i4kQykCpZmFvTZdSr0kC7at6CSoSKOf2nT1bxKaMiodRR6LvlX+aV/XfpokIEyI+0rdj
         RjaWyyDmvyxSebRKsdg6pBnNw93WRNcCt9M29SnNSB1f8yU37Hi7sXiyOQwnQqCaAvH/
         eYeLrkdZaufFDwCf6QVH6ri/j1cxh+HfUx3Yh6k9gPHy7yRZXeBwwrPZdGhIemt+9nUd
         v3z4jcwVwYzXk5F2XNHJmPCNV5dB+NKwiW7znvkGM9FcqyxNO4FBB3FMuHZ9QzmaaYly
         HppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788915; x=1728393715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyEcKeEaGeyjn3FmCQILe/HAvSQ7EjvyAoQhRa/81EQ=;
        b=xMhClVmfvaDMn4hPGsUMZeyBgdyRNFWzpo1aJdryFX6qnjNcumpTGmVuoByQ77ANmW
         sxS9drWpSVf854PGZZiBqlry8gftO+t7cA+lCE1lDj/rTfqDReGRKlRF/XKlx6yDaQJM
         f/WXO1fbTWNJaiqbyB4xua03bAmYc+P0ZqgGnIuiL5LCoL8Aory7CLYSCmsnG7mKTMcV
         glyqq714w39gYIovr3cZv6SdTVwxu3q78ypjtIwG7YcIVlPMj7G176Jp5nceZ5ML5i8n
         +Z3GjMAZ7Cmhx8o145LtlVTuJVomgij3glEb5Ja8ZNrQ7IE9KrfbHevos21Az5BuUPIW
         FfeA==
X-Forwarded-Encrypted: i=1; AJvYcCWn6dWLNt7XZ4DVfDfGzLNYX1TuzmYwru+VN/63QwSrp6uMasp4KK73ipoLVM4OWm/YL6J0GubpjsrG4TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1FqqpsoUxe+NiVvai9BNx2Mp0A+cC+IUX/The73YQXeGKui5
	LyYPk4cxDNhjg38aXY4oKg6qXozIRPnqEGjMyD9LZiiHUorHYirJket3Y28vMUcrdC2V3CnY0ye
	+qhX1M+US4dqd/F2fDTb3PjJIpOYvIB4XNM6Ybw==
X-Google-Smtp-Source: AGHT+IFX+RG9oTFLQI1ImSBKJqO6cvjvCh73Pi/+D7i6lN9FLnM4YRXO332XYCzrUNg6/1KlbELqPZKC4ieZWZ8y//E=
X-Received: by 2002:a05:6902:15c3:b0:e26:3659:577c with SMTP id
 3f1490d57ef6-e26365959acmr260283276.49.1727788915541; Tue, 01 Oct 2024
 06:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-meson-pinctrl-gpio-line-names-v1-1-4345ba336ea4@linaro.org>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-meson-pinctrl-gpio-line-names-v1-1-4345ba336ea4@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 15:21:40 +0200
Message-ID: <CACRpkdau=4jrL5zWCwDOtcggm05XSXCjUrCr0t2MtAUC8TdR3w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: amlogic,meson-pinctrl: lower
 gpio-line-names minItems for meson8b
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 5:24=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:

> The Amlogic Meson8b SoC has 83 CBUS GPIOs, thus lower the minItems
> for gpio-line-names to account for it, fixing DTBs check on Meson8b
> based boards.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Patch applied!

Yours,
Linus Walleij

