Return-Path: <linux-kernel+bounces-323744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CA89742D1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4780D1C2676C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA91A7048;
	Tue, 10 Sep 2024 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDpkkNMP"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70D1A4F16
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994539; cv=none; b=CAxVjsi1Clbt96XVT1wHddseRW8cSEV1UK1nxomAFAEF014IRk2dPLjx60xhlMUCVQo4hCavCBmh/x3Ya5Fxzt7r+6RPCshjyX0XpmdbN+K0A3L9Z9DV9QSjVBQL5Hom2DvTN6rsDjp53Zz2XGSQ60Iy35Yj3Hj3dyEfCTl7X/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994539; c=relaxed/simple;
	bh=o6nx0UKbm5bX64t0WzJHvUk0BXzglcXipBk50rc0cK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaGrN8G4+wXLJd2DzJp2En04nT1uoWaObOR3AQ34Ol+UB8RAxVgyRXg+nayXqJkQNq8zqexk3l6304lYrgNszJqTvfF0K0CrSvjHomLx7rI6vyTHOh4VFREWI1/0NQyCE8Q/smwcx0w6S9AtJ6pmM3TG4P0mIKE7Ns/suSf7c6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TDpkkNMP; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6db9e47ee79so7687737b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725994537; x=1726599337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6nx0UKbm5bX64t0WzJHvUk0BXzglcXipBk50rc0cK0=;
        b=TDpkkNMPliX3eEVCl+gK5A2yze+0WgfhKO9o5cHvxNPM/voYhw3YFLmxT2QMvZ+rvW
         Hcuim61A7T0dvD4KwzkiHhxfoDaIGG+weEJnr/8l1b/oxTb8tBPe+lS02FfV8YjXVEGK
         NvyNacUktMBXfa+9XTTjxDsVz29pXPYljP7kkZgiBa7fueGQqqVYOykU3uTrautInO9Y
         TkMXhrlHi9VwBaW8Ld+rHwo4YCBwJQrPL+Ag9DACWJSagVSyUwr6P+Jk1WUza9eoSDAh
         uKigAfYT7zZIwQNcCd6wEaSadH5Zc5TgQ5b1Esr5SXJsJnLsP6qCRmcqRzAY+7wzpfsf
         AS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994537; x=1726599337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6nx0UKbm5bX64t0WzJHvUk0BXzglcXipBk50rc0cK0=;
        b=jaIelpQfbi9iLKajavr7RR1JFSEjeZRsgEp/2/mCxw4q6kBwZU7anpazOpjfySBVCb
         7DD8BiKlBSC3M/ony679pgux3ztcR/vS+vVkLyqQMhpPfQhtZTjgJnhW5nXYBJlZJkfe
         2Kl6IPYimOvVjuUIk2te4gqf5F0/61AoovPYg64vwS3AC9dfDwl30B340cBnvFxhkoQK
         RZow6K1p9pTfCP7yxV0+yHNIxe34XVvmoS1C9qxz08F8mluuYeZHSzX78cpOU6M9/tAn
         jgJgfR75nAhENc40r8HWXt8cJAwXr06kWwjzRu/D7z1gaPaMjERVok09ug8sOpimnEpK
         xZAw==
X-Forwarded-Encrypted: i=1; AJvYcCWvVTn8cMzWmfV7JEc/JSrtmdsYibXhhmlvqLryNHXC6WA5wJxkkCySiJXMquh+BYPTYYEvu2SDLmr6HGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb2Ej8/JdftSOhEizzVenmRT0jsnprj+WPPYqDSuDgA759J7fJ
	Rp2GjvnOLNXhFI3HeXby7rPUuch2V2TFYc03Wdr5AF4LF22APgdB63gRv4/WzvnETFs+xXMVEGO
	d0+Sx+j08Azyb+hNGzTcjZIoSTI51+R0dC9NlFQ==
X-Google-Smtp-Source: AGHT+IHRnJG2FAr96myhBN/iC+lCC23dv/0Awgq54gvlnMb7Q4o7VlXqe2J8odG8+/yujy8sFPRnNQC/N/ypUMfjj/c=
X-Received: by 2002:a05:690c:4982:b0:6db:2d71:916 with SMTP id
 00721157ae682-6db44df3824mr197358267b3.14.1725994536995; Tue, 10 Sep 2024
 11:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240809115500epcas1p44cb69cea78a73833de38eab552b204fc@epcas1p4.samsung.com>
 <20240809-clk_dpum-v3-0-359decc30fe2@samsung.com> <2e4d3d180f535e57d9cb98e7bac1d14b51ffc5d4.camel@gmail.com>
 <337666703c41856e61f4cc2dee7e69c276d5102b.camel@yahoo.com>
In-Reply-To: <337666703c41856e61f4cc2dee7e69c276d5102b.camel@yahoo.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 10 Sep 2024 13:55:25 -0500
Message-ID: <CAPLW+4kmufpcwTSm1Rf2HEs2hNW-7pqSbxvt7py=PAmQ324Xfw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] dpum clock support for Exynos Auto v9 SoC
To: Kwanghoon Son <kwangson@yahoo.com>, David Virag <virag.david003@gmail.com>
Cc: Kwanghoon Son <k.son@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chanho Park <chanho61.park@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Jaewon Kim <jaewon02.kim@samsung.com>, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:56=E2=80=AFAM Kwanghoon Son <kwangson@yahoo.com> =
wrote:

[snip]

>
> > If you are not working on a DSIM driver, I'll keep working on it for
> > 7885. If you are, I'll have to think about how to move forward.
> >
> > Best regards,
> > David
>
> + I added Sam Protsenko <semen.protsenko@linaro.org>
> Because I also want to know maybe he has some process for drm, since he
> worked on exynos850 sysmmu.
>

I'm not working on DRM at the moment. After enabling SysMMU I've
switched to other Exynos tasks, not related to graphics. FWIW, I've
implemented the test driver for SysMMU, which you can use to verify
your SysMMU driver is functional. It's able to perform address
translations initiated from the test driver (using regular CPU). That
way you can test your SysMMU without DPU or other IP blocks initiating
the translation. You can find SysMMU test driver in GitHub repo [1],
and the commit adding the driver is [2].

All that said, I'd be excited to see DRM working on Exynos850 some
day! So please keep me in the loop, and let me know if I can help
somehow (by testing the code, etc).

Thanks!

[1] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu
[2] https://github.com/joe-skb7/linux/commit/d712fb52a12ac0958118f9c23a4f1f=
0d7b9276a7

[snip]

