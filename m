Return-Path: <linux-kernel+bounces-538449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 475C3A498DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C634166DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C481026AAB8;
	Fri, 28 Feb 2025 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWOoE0Wd"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A826A1C8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744742; cv=none; b=UOJqId4q4M3BnYkWHBrvn20twi8kzKhpfhVZQe/5sgGe09+wF33sjQkv+4RVjkC/dnpBdfXkk3+w6eSY72smBW3xZlJON1e5putGzk1+w1IGU1neAtKrU29SNFI/lhQ10OtD0BKYst8LedLv5KGscugFKYtPBbzaMCxaPvZbqnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744742; c=relaxed/simple;
	bh=BABB+Jo1h//suep72I5ItsmFCikAKQIa7J/lBeJE4oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0UXmI5srNq9p4mZg67KYW7WTlVs2ZGm6VtmvSMny5UcBjHqgXAlesws0f+RA3zk9FWuJ/WQ1yGGc8CA5K2/GEkxPwIR3ZRQfkZ/pgr7mtHFvrR58pUcjhixOybz86X7D8j5J7p3GNAXiFoEbpG/9Eyz7YZtS7r+/HxIHaoPzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MWOoE0Wd; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6efe4e3d698so18505937b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740744738; x=1741349538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+5pSPichyRWnjhlJDxySBmjSSTwMvFSyoqY5brH4NbM=;
        b=MWOoE0Wd2RXtwcRi5J0n8V0Tz6p9qajDwFY4kv3BqrsZd7u31vdZWqV8Pbo6n82lFf
         mAfD1OR8EUcHY2isQGYE4hWxvhcYF4dVhOWgCiz/K/skQ2tYZOw8Ul3VKMe/9b1qB8rr
         xKk7Fc4v4w5omk+vT/Xok5k6XttJh7FnjPpxLz47tYNiLg/NUvw0k8Mz8+eCgBnnRD/s
         Psl9/Ey2qGJ/i1orGUknXoRUEtEtaGbXL2wKfYxI6N5CS6I1n7zUKa6zaZ6udvqcygDH
         hgi7EF7vqVZdIL+87NPThQifn830wWjmCG1kt5UFbg/oi67MjqRM9K4dsulFM/EqBDVu
         ANyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740744738; x=1741349538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5pSPichyRWnjhlJDxySBmjSSTwMvFSyoqY5brH4NbM=;
        b=mkXeRrgReGuLFlzPoVLtwmLQYhbWy5Ka81+iTJv2fF/knwcwYbShjZzBAlObf1pWTg
         OuestjTecv45LTf9A9mY24sRkGTyaMFsrpVW54SuRgOSKGTn1b1MlTYOwAZ+ijWGqfeX
         qn0AKxSfmPd7o3FsCYFLKSsWfTz2LynjFoWY1pbsMqdsB1sujXLunUg7u8mnSOq8LXUd
         IN/Gw287V2+8VdhBYyS2CG/GtqHZklmhHOCcPyFWo96kefNP0piVFUaYPMec2T+S9nJ/
         Jb4J7bC/gNCzPhdDMQL4SGWYefYailV7I73ppgRsctNtUt4SMU8JlbOA4nm+3ya+d9Yn
         EZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCU7Lp1z1SIf6pZ4jc45Xc5Iv2c8mCa+O9Be9kRVIuWjnvIQftQY34L5V52TjxxE1hmCMwKNwWmh+Upg5wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/CbUlBns3mAOGq4RZGtogman3gxn/AIAKbuBCkXLvq3DBIiLm
	8E9KTNnBeIDx74/cX0sgdE2XPMwHVYw8BJIbcxebsSCaPcCFmSmH6YL1MXWlyshXToCg3a7pmY6
	k+YnRonPG9T+9IwvF265wrSqm8iJF/QU2mK75kQ==
X-Gm-Gg: ASbGncui/vZdcAj1klJXOLCSNR/FM41R9G+bbP1rmLP1xz5f7M7YdMhhhMKzMvwur+L
	T6tlGC56eBIv6ch44EfZg0G2IqA4ESaNZ8Aik0xHxcjqirbWQh6kW62jlkd9S1fXacy7GLRCPga
	NOc7/b2J3Q
X-Google-Smtp-Source: AGHT+IF5LyA0z6vq8zu3tO1oWVDzeSmN4FFCP4cjtDkkdxPV7Z3Ux5LaBEWOF5SLfhfWthG59puDdlr/Ga0qhFSovFs=
X-Received: by 2002:a05:690c:3506:b0:6ef:6fef:4cb6 with SMTP id
 00721157ae682-6fd49ea038fmr45080957b3.0.1740744738231; Fri, 28 Feb 2025
 04:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
 <20250220-rk3588-gpu-pwr-domain-regulator-v6-1-a4f9c24e5b81@kernel.org> <3360051d-1699-46cc-a4c9-0f379fcf8de0@sirena.org.uk>
In-Reply-To: <3360051d-1699-46cc-a4c9-0f379fcf8de0@sirena.org.uk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 28 Feb 2025 13:11:42 +0100
X-Gm-Features: AQ5f1JqGrLsCSl6mU4TpCihGk9__DNvMDKpAdcL6_WxMDANY54b_Qa_DhEb314k
Message-ID: <CAPDyKFoJ5ZH6LAjFUURkJcudVewxwBM50T4e_GX_COVA5Z2knA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] regulator: Add (devm_)of_regulator_get()
To: Mark Brown <broonie@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Peter Geis <pgwipeout@gmail.com>, 
	Tomeu Vizoso <tomeu@tomeuvizoso.net>, Vignesh Raman <vignesh.raman@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 18:59, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Feb 20, 2025 at 07:58:04PM +0100, Sebastian Reichel wrote:
> > The Rockchip power-domain controller also plans to make use of
> > per-domain regulators similar to the MediaTek power-domain controller.
> > Since existing DTs are missing the regulator information, the kernel
> > should fallback to the automatically created dummy regulator if
> > necessary. Thus the version without the _optional suffix is needed.
>
> The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:
>
>   Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-devm-of-get
>
> for you to fetch changes up to 0dffacbbf8d044456d50c893adb9499775c489f4:
>
>   regulator: Add (devm_)of_regulator_get() (2025-02-24 15:26:08 +0000)
>
> ----------------------------------------------------------------
> regulator: Add (devm_)of_regulator_get()
>
> This introduces devm_of_regulator_get without the _optional suffix, since
> that is more sensible for the Rockchip usecase.
>
> ----------------------------------------------------------------
> Sebastian Reichel (1):
>       regulator: Add (devm_)of_regulator_get()
>
>  drivers/regulator/devres.c         | 17 +++++++++++++++++
>  drivers/regulator/of_regulator.c   | 21 +++++++++++++++++++++
>  include/linux/regulator/consumer.h |  6 ++++++
>  3 files changed, 44 insertions(+)

Thanks, pulled into the next branch of my pmdomain tree.

Kind regards
Uffe

