Return-Path: <linux-kernel+bounces-212143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B97F905BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195861F21BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CC782D90;
	Wed, 12 Jun 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqlsqxuI"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806982D86
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219768; cv=none; b=enzdqgHvOU4s/lUWE0pwdIIcflHwGTkYcFGNG5IRSsX0fpRvxI7+Nj+DYnIZxrVLUNcIrg5oHLLg8iiuvJ5Bb7prRo31FkZievYc6t81LVDdK1jyy8pe7VBv913ClVQ7CcgUcyugAffSXzSxvHVTR7EJraFMZhR+HALnIwCxEkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219768; c=relaxed/simple;
	bh=TT5Yy8Cg+zgc/dvH/JAnRm7xPX0YfVAnSj1ykdSJ2Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETWQdaaAnfAcW8RjG8CsEUPW80WKcWukBR2omukeHHW0ECaZ8CUkq7hF93r9G2Q1N9TbLYWLrUa3r7mWCqXehpzeMHD6KccOAY4DkeaWUueqiFQXeY2PdxO0XCirHAdxJNb/wMS57zx+Xqc7sGUV2V2esd8AU+oZ4ZPGmJDDgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qqlsqxuI; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-627ebbe7720so2560137b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718219765; x=1718824565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTOoAkY+XFAaDVAn5K5dGWlrUR6Zg5YNXYx5cYl0uTA=;
        b=qqlsqxuI4MrXCsiHf1QBwajMznvQd0klDYXqfWO0fmhEwkub1IFZ7mImy/kMhHg0mj
         ccs2XsUnw1uQFb4SDV8oXVV0siVRNsaKhueZa4cHmnry6p+ZlYsyI9E3qpaWkXPnx1u0
         n2AejvagYycZ+BlaqZ3vojoAllcD57s4i1lLe4l4N68eVc/NPHmKJxzCic1FO1M8sumY
         uISEevEhp1oawx3VBwqhGV5mFMLRW8QThfDnvE+Z3lSEM4OnMGClQxtMdjQbLkebVNFm
         gTpeeOrh/lhe63yZEXtLHOy+5/O9DTY8yCkCrzmggdZzDYj2ljCJT/m2+VWXbZR6/jP6
         V4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718219765; x=1718824565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTOoAkY+XFAaDVAn5K5dGWlrUR6Zg5YNXYx5cYl0uTA=;
        b=lPmsnxdpgscImbMVRlH+LijQmnN9DTxkmDfutNeIDjL8h/2Jtp8Eujr3gfN+NCDdnd
         zthuxZ67zN7RIqDieVsQ+51sYrwRYx6Z34Khd3NuMNV6PyCSwEwdpYR5zLPeR13YD/9J
         V7mMwocwHRbXQk+SqUlnjN+hDZmkvss2HneHKTfdj/bPhnF6l9obDF91dNo+EF5EjH30
         YB+sU99qM4JdGz5H2M8m+o4K/s1QxHmAcPWsXU4T2b8DoLIIUNtO/h3raHnvolrT0R3Z
         v/Wy3zFh1mzkY+xLb6OU/eKehB5HkBKnTU7glfGAaf4o6Ydrbh/ZXIHGTl1+g2H+1fi8
         e6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXxsigB0q5rj7Q/cS4tGZeqElzTc6s5kIJfIDYnvW/UFwQrihRo6DDVrDQvR0uXby/tYbCA3c0vIPXIah5Vjc4ay7d0tsQpf4AWf2+d
X-Gm-Message-State: AOJu0YzqrzWyo4A3gi4y0FyiHP/WLQ2rfNdGAlb5G78eHIWqSUX/k+aj
	WSB05naGSHk0qsA0iJ3/4wrGxnEV08IOZvUmHHceu4JHGQpunFl4JcIJLDlrT85u/XDP3alA0pG
	Il+DjQScvOnh+RwdL6Ww3/64bVmUWEmtKAvKASA==
X-Google-Smtp-Source: AGHT+IG5dsLLwBGQuoG4Hoy7VVSKfSzrxGdFqSvbA7MGEl1gf4yhjr5zOnzliAi/dYKgH3eizXYGtPwh7TsAUPZRI9E=
X-Received: by 2002:a81:a189:0:b0:615:15fe:3cb8 with SMTP id
 00721157ae682-62fbaf3794cmr28360767b3.28.1718219765456; Wed, 12 Jun 2024
 12:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-samsung-usb-phy-fixes-v1-0-4ccba5afa7cc@linaro.org> <171821470509.586907.3119518278516252634.b4-ty@kernel.org>
In-Reply-To: <171821470509.586907.3119518278516252634.b4-ty@kernel.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 12 Jun 2024 14:15:54 -0500
Message-ID: <CAPLW+4kgsSrbVbsHgFOhM_FppoPngnk2XhvbmByLtyUKkEWgWQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] a few fixes for the Samsung USB phy driver
To: Vinod Koul <vkoul@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 12:51=E2=80=AFPM Vinod Koul <vkoul@kernel.org> wrot=
e:
>
>
> On Tue, 07 May 2024 15:14:43 +0100, Andr=C3=A9 Draszik wrote:
> > Before coming to an agreement on my Samsung USB31 / gs101 phy changes [=
1]
> > [2], I decided to split out those changes from that series which can al=
so be
> > applied independently and add a few additional fixes I had lying around=
.
> >
> > This contains mostly cleanup, but also a change to using fsleep() as
> > recommended by the timers-howto, and a fix for setting the ref frequenc=
y for
> > E850.
> >
> > [...]
>
> Applied, thanks!
>
> [1/5] phy: exynos5-usbdrd: uniform order of register bit macros
>       commit: 2a0dc34bab8ede5fa50378ef206f580303eed8de
> [2/5] phy: exynos5-usbdrd: convert udelay() to fsleep()
>       commit: 27f3d3f6d87f650cc6b3ea08335dea749f1b04aa
> [3/5] phy: exynos5-usbdrd: make phy_isol() take a bool for clarity
>       commit: f2b6fc4d5c9793c556412e9a8ac122670a0d8dcb
> [4/5] phy: exynos5-usbdrd: fix definition of EXYNOS5_FSEL_26MHZ
>       commit: 32b2495e731f2a56118034e9c665e6fe56bbfe3a
> [5/5] phy: exynos5-usbdrd: set ref clk freq in exynos850_usbdrd_utmi_init=
()
>       commit: d14c14618e851eb25d55807810c2c1791a637712
>

Did somebody actually test it on Exynos850?


> Best regards,
> --
> Vinod Koul <vkoul@kernel.org>
>

