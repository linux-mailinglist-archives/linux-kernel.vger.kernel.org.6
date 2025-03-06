Return-Path: <linux-kernel+bounces-549179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B29FA54EA5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D63B7A3992
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA85718FDD0;
	Thu,  6 Mar 2025 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8+ZOIGg"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320A1DDC1A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273938; cv=none; b=mQz3V8eci0OpTwTNZp8j0Ynudizfkt4MSdY00LKxESopz6KqVpErpM55BFJ3fmNss0J//xaoofAtW+nm+lOzQ0fGhEsrBRhoZx9uNCm2rAFl5W2V/hY9MfR7xpYQwdwFfN6jBrr8KJoUQ9UYDD9hwCGH/LYbe+W5Sxfaz4WJ5Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273938; c=relaxed/simple;
	bh=pmjDadqDvoeZbq+6SenP88xHqdoVFFfX0v+fvuTPQuQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcVRAI3Pg2FyPj+VygrUqsftO4cEwEhzs5/0M2fvrPy+c3V7+xeYSawmUXsNf7v8YG8KvAMQg1Vs6GaW3U7nqLtC+DsY4CyxupCUfx/d07Mk5U10LKbftlEXHCi6paoyhMzI60a9LIncWLHwNVgkRzBb4rXPzeQpwIuyUOsj7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F8+ZOIGg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf4d756135so133222966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741273933; x=1741878733; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3WXfhZCiqVgcV7ok5vlycj7VwBsplyGEx/STby8IVdo=;
        b=F8+ZOIGgQGKYCzdRlOHiYrAdHmhO/QPl8TMLQxh070cQpF/nKVpL06kJ4vHCvZza83
         ab1EEZg3W2UEeQ64fhvqCWWGVHDRCoM8tClfqJ4GhXh1Inq4P9sQ+guHhbOB6sJqGFxb
         iqwjXXVIXljj0fjhq3nUE7mK9I5Kf3vIb1j+mDh8YGEJP9M2j1/g/r30+YNeW47Pf5mX
         sSryUMTsj+gOGA7oT1cvDvymAbNLyMUJwe4Ei7rT6ACiA01krfdp8omZh569q3T763Oj
         yIBSC4cSW0/cF4opWj5EJZ+n6kb2RsMbBi7trZYi0VoPj9oBHFYADwRgE8DtVkbaHV7u
         HVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741273933; x=1741878733;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WXfhZCiqVgcV7ok5vlycj7VwBsplyGEx/STby8IVdo=;
        b=VkXCTp1to2Sz/cQG51fk4xA0yuBfrIPYmsagcsfDYcfQsr992sSL1Y5qIZlbzK0s2E
         uSNG2xiMG2SdoPQpY4jmbxNtxgz+sdPfVpzlDasdpaz47bdwuBxBKCkEr8C/Sli0FXdL
         17Ou6+gl7R+O31vx+erTY4OfZdGED0HE/wtcMbjNwfSpHGXoANBMXg4NtCFiDlp9S6X5
         qoFVx5XkV6fPWevtpjHF3Y27uD6BifV03ee4N24zGs9Wvg9fiN/dlgT/URerEi/n4SZl
         sVPMqOLmCermaZYc678fXqIPirV/+ThtieabXFEAbOfOdjmJiVTkPdQLylwh6jwcgCz4
         D+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWico9EiCqXVFouCJeUwk+lNSY1AATnP/8GPT+8Pj/Y3smkwa+B8WFHzDpPPzkf34uwGXyvQlOPqzwsPno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5e1gptMU2cEGZ8/lICzzJYHEsG0ysMNXwwQGmRXe0iuZ0ak0
	D2irzrSAS2x7/ZAgX5CxGIjhtLephaiNSw3jq00WzccI/4yTHcUxkpXTQaLN6lk=
X-Gm-Gg: ASbGncuJApm7idI+3yvJrIntoX8nxoG9z8kNaAupI7YjDQ1eRw83Hp/apYgkftkEdkr
	I7U+cJxMTCtWRtTe9JUDhctQver9Q8br4vRQVvLWcNiTh5F9bZaoiuIZNm9NGx216xhkSc8mP4r
	r6oxaA9Hlpwv0Hie/klteHp7IYuA9Ip6XPkm5CKkSYrGroK/n/RnIIslxQaIdOrziofciieGvu9
	LhvwptoJm/8uzzsl2aGHhbC8RE4lFzr0VKBkonnIYAaky4P5qcmBwTwjWTj4HSQ+2Rl1l6Ncvit
	J8xeMlapqAMvFLXQh+OtT9WFquFVz09cGdDl67+5k6tKEDNP
X-Google-Smtp-Source: AGHT+IFDRd2HtWQGN+lgCyn+h+CpAHDpxE2ZJ3AjyT5NxJhCZf4locWiqN2iafEdYoLlz6zCbZ2aZw==
X-Received: by 2002:a17:907:3e13:b0:ac1:e00c:a566 with SMTP id a640c23a62f3a-ac20da97b7amr825015366b.45.1741273933241;
        Thu, 06 Mar 2025 07:12:13 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399d4802sm109953966b.175.2025.03.06.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:12:12 -0800 (PST)
Message-ID: <4f91fe1c5eed00e58a3587bceaef3e5e2a1124cf.camel@linaro.org>
Subject: Re: [PATCH v2 2/4] pinctrl: samsung: add dedicated SoC eint
 suspend/resume callbacks
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Krzysztof Kozlowski	
 <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar
	 <alim.akhtar@samsung.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, 	kernel-team@android.com,
 jaewon02.kim@samsung.com
Date: Thu, 06 Mar 2025 15:12:11 +0000
In-Reply-To: <f7c0101ff26ac0d4ef70a374ae31ee5d23b3c8fc.camel@linaro.org>
References: <20250301-pinctrl-fltcon-suspend-v2-0-a7eef9bb443b@linaro.org>
		 <20250301-pinctrl-fltcon-suspend-v2-2-a7eef9bb443b@linaro.org>
	 <f7c0101ff26ac0d4ef70a374ae31ee5d23b3c8fc.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-06 at 11:57 +0000, Andr=C3=A9 Draszik wrote:
> On Sat, 2025-03-01 at 11:43 +0000, Peter Griffin wrote:
> > [...]
> > =C2=A0
> > -static void exynos_pinctrl_resume_bank(
> > -				struct samsung_pinctrl_drv_data *drvdata,
> > -				struct samsung_pin_bank *bank)
> > +void exynos_pinctrl_resume(struct samsung_pin_bank *bank)
> > =C2=A0{
> > =C2=A0	struct exynos_eint_gpio_save *save =3D bank->soc_priv;
> > =C2=A0	void __iomem *regs =3D bank->eint_base;
> > =C2=A0
> > -	if (clk_enable(bank->drvdata->pclk)) {
> > -		dev_err(bank->gpio_chip.parent,
> > -			"unable to enable clock for restoring state\n");
> > -		return;
> > +	if (bank->eint_type =3D=3D EINT_TYPE_GPIO) {
> > +		pr_debug("%s:=C2=A0=C2=A0=C2=A0=C2=A0 con %#010x =3D> %#010x\n", ban=
k->name,
> > +			 readl(regs + EXYNOS_GPIO_ECON_OFFSET
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + bank->eint_offset), save->ei=
nt_con);
> > +		pr_debug("%s: fltcon0 %#010x =3D> %#010x\n", bank->name,
> > +			 readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + 2 * bank->eint_offset), save=
->eint_fltcon0);
> > +		pr_debug("%s: fltcon1 %#010x =3D> %#010x\n", bank->name,
> > +			 readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + 2 * bank->eint_offset + 4),
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 save->eint_fltcon1);

The indent on this last line is a bit off.

> > +		pr_debug("%s:=C2=A0=C2=A0=C2=A0 mask %#010x =3D> %#010x\n", bank->na=
me,
> > +			 readl(regs + bank->irq_chip->eint_mask
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + bank->eint_offset), save->ei=
nt_mask);
> > +
> > +		writel(save->eint_con, regs + EXYNOS_GPIO_ECON_OFFSET
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + bank->eint_offset);
> > +		writel(save->eint_fltcon0, regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + 2 * bank->eint_offset);
> > +		writel(save->eint_fltcon1, regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + 2 * bank->eint_offset + 4);
> > +		writel(save->eint_mask, regs + bank->irq_chip->eint_mask
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + bank->eint_offset);
> > =C2=A0	}
> > -
> > -	pr_debug("%s:=C2=A0=C2=A0=C2=A0=C2=A0 con %#010x =3D> %#010x\n", bank=
->name,
> > -			readl(regs + EXYNOS_GPIO_ECON_OFFSET
> > -			+ bank->eint_offset), save->eint_con);
> > -	pr_debug("%s: fltcon0 %#010x =3D> %#010x\n", bank->name,
> > -			readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > -			+ 2 * bank->eint_offset), save->eint_fltcon0);
> > -	pr_debug("%s: fltcon1 %#010x =3D> %#010x\n", bank->name,
> > -			readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > -			+ 2 * bank->eint_offset + 4), save->eint_fltcon1);
> > -	pr_debug("%s:=C2=A0=C2=A0=C2=A0 mask %#010x =3D> %#010x\n", bank->nam=
e,
> > -			readl(regs + bank->irq_chip->eint_mask
> > -			+ bank->eint_offset), save->eint_mask);
> > -
> > -	writel(save->eint_con, regs + EXYNOS_GPIO_ECON_OFFSET
> > -						+ bank->eint_offset);
> > -	writel(save->eint_fltcon0, regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > -						+ 2 * bank->eint_offset);
> > -	writel(save->eint_fltcon1, regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > -						+ 2 * bank->eint_offset + 4);
> > -	writel(save->eint_mask, regs + bank->irq_chip->eint_mask
> > -						+ bank->eint_offset);
> > -
> > -	clk_disable(bank->drvdata->pclk);
> > =C2=A0}
> > =C2=A0
> > -static void exynosauto_pinctrl_resume_bank(struct samsung_pinctrl_drv_=
data *drvdata,
> > -					=C2=A0=C2=A0 struct samsung_pin_bank *bank)
> > +void exynosautov920_pinctrl_resume(struct samsung_pin_bank *bank)
> > =C2=A0{
> > =C2=A0	struct exynos_eint_gpio_save *save =3D bank->soc_priv;
> > =C2=A0	void __iomem *regs =3D bank->eint_base;
> > =C2=A0
> > -	if (clk_enable(bank->drvdata->pclk)) {
> > -		dev_err(bank->gpio_chip.parent,
> > -			"unable to enable clock for restoring state\n");
> > -		return;
> > +	if (bank->eint_type =3D=3D EINT_TYPE_GPIO) {
> > +		/* exynosautov920 has eint_con_offset for all but one bank */
> > +		if (!bank->eint_con_offset)
> > +			exynos_pinctrl_resume(bank);
> > +
> > +		pr_debug("%s:=C2=A0=C2=A0=C2=A0=C2=A0 con %#010x =3D> %#010x\n", ban=
k->name,
> > +			 readl(regs + bank->pctl_offset + bank->eint_con_offset),
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 save->eint_con);

and here

Cheers,
Andre'


