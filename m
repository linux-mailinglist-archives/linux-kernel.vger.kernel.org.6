Return-Path: <linux-kernel+bounces-574858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81623A6EAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0474E16EA12
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5434019D8A3;
	Tue, 25 Mar 2025 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OupcoIJT"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A78460
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888816; cv=none; b=dl9r/xBGDwJlIdA1eOICKiX1S46MgQsS9jvFj+cdVdFpubSP6V5aqnEu74eup9HVUkPmTMoaX7RVG06hwgW/x4iN1JPzkF3PPtEUEzmLqN0xBGOSrVY68f2WUPr09Las/NA4hcfL/snb9q5E7zP+SGQ+uCC0mx8HGFzYDimV/3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888816; c=relaxed/simple;
	bh=BQxfPLKh6lFlvIdsZxZv5dbZ5pCBFsGj03Pttf1FvRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rL41JnqYGNR47zc8E6dAVO2ldm+AP03xeMV0bsVNMyYrPw4vNEWZBnCUFpbeLDlvxYMHT7yZdbvzaw+10itOxb4fSjs0OXMY78Pb5/Ys9mhgRUAUfTgmvg76KN+a5r1GFDhLmPLvjeJ0Cb6tqyGA80CxJf/JP+NVBcECkGKkYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OupcoIJT; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30db1bc464dso3288381fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742888813; x=1743493613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoJ836Wd7vkGzLLJk2fss49Xw64vZKkegg0JgsJL6/g=;
        b=OupcoIJTMHzGX6DEzfWrcCAJiseE2ZpZ7ADIIGnDD1DRQd+993YYNS/vPqqZk03tKc
         tmlCRQ7VMXXEiC6ryRn25QdNzZjK+Y0gJ0EiGpUZK/MmXiqi7p+aREvyA10M8mbSNL0v
         PMKd206XTRUm6K4H+pDhgwHuRoyN3bhiAXP7yU99aG48TANeAC3agRaXeGa866/K+vxL
         9g+5/D46BDAVhXasmxRF4S1u2gTq5/n6ENUkJvM1Id1K9ptCXYcPSnFe/4Ceb26xRQkr
         K8n3UC+GlSmcJNYUXrwekPNpP7NsdGMEnRyZac09GgkI8hSE37gxG+dV8zl4Ie05xqmX
         FitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742888813; x=1743493613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoJ836Wd7vkGzLLJk2fss49Xw64vZKkegg0JgsJL6/g=;
        b=lsRHXNVaUUCgKYSdz6wKpnMrHep9K1ZoekO1r5QMG1kpeJx2/6AdMxVpeXRw5T/If/
         QKc86AKtHSYLBcutYlildBuBeqYGy5YT4kofhC9HA764kH7IGS/Y2xlGLPdeE8Ps/on0
         cjNPwQH8AK/J8pkAAG+1cHZitkQxjruV7YlWRphq82R/lRrDfYqI92DY6qbwZJJ2x6sj
         axORo1yGxIHlCBbbA5L1+GpWxuZXHv/Ka+HX0n3GGyxRgyzEkd9kTnUwWncvVeqkb7zL
         59anFplY3xLBL3R++alo3xJlf6t7qRij9ZvOvSejcO6bUwbbjkpVavzIp+7h0EJfgVTh
         OQ9g==
X-Forwarded-Encrypted: i=1; AJvYcCVWAwNoDZu2CnAsH3JYusHXm24XZXRpQLGgcRuP0z8NN8OumrWoz8x6g4Zrr+A5wgnDnQ8hTk3RtdOrSZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLezI08yBY2zWp5+tVWtdtougug+hI7qTysDz60PhMnMKlHwrJ
	9mJTI9DNiTqg2EEi0kJybEIPWpQWAPCa4tqGjWG/V3BXI26ziXw3Ug4yqMc/3JLkNaBCzbsnrKF
	QLVxIh6e86NhyDtKCH0XiDs94B2LuV4Nn+4JkkA==
X-Gm-Gg: ASbGncskN3+4VG4y6eNjIKtm2sAWbSf5S7Ywlp1AXRAw9RL1zQuj0i/Yq8Anh5ZxQOZ
	0fjexJ8zRnkUcTqskBgG2wyK0RY6gytf83g+4r3mcEKgr3BKYlu7V555w4GNQBOoHAiTjPs8t4R
	e0sJqh7IGVq6NhVQcXkDGjoXQsW6nLvJZoopSdUkl2w/dy3GpxWT7byZi/uA==
X-Google-Smtp-Source: AGHT+IEXQevg12XN39ACCSgu7woEcRZesJCodzxnQwDV3gYwSkv1bJoPPtupvwtOAUoMN/cjKoHLWBSSAF9PWwsTMWk=
X-Received: by 2002:a05:651c:1989:b0:30c:1017:e5e2 with SMTP id
 38308e7fff4ca-30d7e2aacacmr65142341fa.26.1742888812530; Tue, 25 Mar 2025
 00:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324213340.4129384-1-arnd@kernel.org>
In-Reply-To: <20250324213340.4129384-1-arnd@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Mar 2025 08:46:41 +0100
X-Gm-Features: AQ5f1JrDiS4iAiS5mzXk4C4Rng3rq7rGhoSulGPK8xWU4CpD_aXZHddsJebMFnM
Message-ID: <CAMRc=Mc1zPjuU2KAWkq7s=tizDC+EX86DPNoRjUxutL=U_pY_w@mail.gmail.com>
Subject: Re: [PATCH] ARM: davinci: always enable CONFIG_ARCH_DAVINCI_DA850
To: Arnd Bergmann <arnd@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, David Lechner <david@lechnology.com>, 
	Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, 
	David Lechner <dlechner@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 10:33=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> A change to the clk driver broke configurations that enable DA830
> but not DA850:
>
> arm-linux-gnueabi-ld: drivers/clk/davinci/pll.o: in function `__da850_pll=
0_of_clk_init_declare':
> pll.c:(.init.text+0x30): undefined reference to `of_da850_pll0_init'
> arm-linux-gnueabi-ld: drivers/clk/davinci/pll.o:(.rodata.davinci_pll_id_t=
able+0x14): undefined reference to `da850_pll0_init'
> arm-linux-gnueabi-ld: drivers/clk/davinci/pll.o:(.rodata.davinci_pll_id_t=
able+0x2c): undefined reference to `da850_pll1_init'
> arm-linux-gnueabi-ld: drivers/clk/davinci/pll.o:(.rodata.davinci_pll_of_m=
atch+0xc0): undefined reference to `of_da850_pll1_init'
> arm-linux-gnueabi-ld: drivers/clk/davinci/psc.o:(.rodata.davinci_psc_id_t=
able+0x14): undefined reference to `da850_psc0_init_data'
> arm-linux-gnueabi-ld: drivers/clk/davinci/psc.o:(.rodata.davinci_psc_id_t=
able+0x2c): undefined reference to `da850_psc1_init_data'
>
> Select ARCH_DAVINCI_DA850 unconditionally to ensure the driver can still
> build.
>
> Fixes: a31b4dcf188c ("clk: davinci: remove support for da830")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-davinci/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfi=
g
> index 3fa15f342240..8f66de0405d9 100644
> --- a/arch/arm/mach-davinci/Kconfig
> +++ b/arch/arm/mach-davinci/Kconfig
> @@ -4,6 +4,7 @@ menuconfig ARCH_DAVINCI
>         bool "TI DaVinci"
>         depends on ARCH_MULTI_V5
>         depends on CPU_LITTLE_ENDIAN
> +       select ARCH_DAVINCI_DA850
>         select CPU_ARM926T
>         select DAVINCI_TIMER
>         select ZONE_DMA
> --
> 2.39.5
>

Thanks and sorry for the trouble. FYI I want to remove all traces of
da830 during this cycle leaving da850 as the only platform upstream.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

