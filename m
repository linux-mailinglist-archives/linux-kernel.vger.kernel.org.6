Return-Path: <linux-kernel+bounces-447468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75489F32E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488CA1889936
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1D91EEE0;
	Mon, 16 Dec 2024 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m17/HW5I"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3845E2066D7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358534; cv=none; b=uofWr01m7HCjihhsRNmpq3Grihe25SBJM7M0HmumOzRL7ZLASfP81VDoOColXQkS2l3QmzROFHynxDWdiDHojAK3hGsrikHmRQAWdjT+Txemzwcq/EbIeyCvX+1RH2lj7tktAjt6dFtHV7QtZ3LZ41cvo6I+QaEasdiiYY2o2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358534; c=relaxed/simple;
	bh=sTO6XsUM1EpoRAEqG+118QEinm0VU7febgtSY5QZvgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msPtNkZHziylaYe/ozy2NaX6aPQKRHSRumtJu2fl+x4B13aXVkZ11cS48A/MDTH9o9Z/atQ50q0H00bq501u3fjzZmsqq2XbR/HV/53WIjbP/4NynAPbm/Ym4yiQvgkkqKTvno6tql24Ku01B62NICMNObGdFZDmi2BH89tvFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m17/HW5I; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54024aa9febso4152224e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734358530; x=1734963330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTO6XsUM1EpoRAEqG+118QEinm0VU7febgtSY5QZvgg=;
        b=m17/HW5IwrPEQZeBbryXELBTFih7Ga9IOKlDsoYGbyOiSwXbXVaqWz5exJYTrni2Xk
         umEvcaqQ1s66AnQFQdaLb0Qodv2+BGtJr6nnXwPl9T9RudE3PqfuKCvCSSEfr/WVezyB
         CCNYa7+OPtwYuKXg3Bbi+cUFghVUdPgTGACrOoTHow8JmRc2kM5D+mYE2pKpEPMhWrRy
         Y+7plP6et/zmWy8340E1pd6N8uPh7L6EZYTeG6sJOPBqqQ9VdChEmXw1pLxI9AEVtGcl
         P0a/MplRVZqPjXgm701/6wR7U4tD4zbpc4ecrs6gi9rj+yYU6b1fpyEGyuISAJ8/tq7x
         suDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358530; x=1734963330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTO6XsUM1EpoRAEqG+118QEinm0VU7febgtSY5QZvgg=;
        b=RVVgrxpPwlBqPfoH3NKif2nQID/Kfg9LTK37o7Q9C4UK03I5+T2ZhnVGq7aUlA7NU7
         a4gjZDkbPJAhzhvbKe5nHbjCoeCcyNkCFqBAakBkfQXCDz8H5PDN+fQQHr0GEmsMB9Br
         twwXWt16KXYOgAoYG3YuZxiZRRrGd5Nk6lkdE7h3U4YE02wtm3HxmHL4bZjqcOJ8i3Bb
         tq3BuS/c0vY7Pvu+8283GY0MY3hnleAuzS8OgfrCOtjWeeT1AG5akF4/dqKMwq+qhZ55
         2CCfe0oEQ3FzitYZKdXoBreWDLsL4JZ4yfB4R7+KIXzJ+WK85l3EN6dl71RaSy+eYA++
         pr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5G7z71CBIC+sJyx8wYb2INoV7VesJMuEzGHI+Z2r59iuaxu62poE4aMOSXoXGzy01U2jdYpwp862Z1jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3JIM1ybtXbnOxTjg0ZYwaZqtdh02Cg0ND2obUlaT4+NQ7H/gK
	cCs+Gfm4fprgqm1WpQiwYkdGYOPr0DPYAcIHTLvkuyfkHhHh234vie6SKf950yICH3TsxcDimPI
	u80Aq4EbMZaUKtyTedRtsaw5wLcs/DeKNt5tQRA==
X-Gm-Gg: ASbGncvZDnXBJip/hcgNm+cWDBvCtP59T8dsQ4fIn17TZF8OKPIrja4IQV//suYwoGs
	/74mk7fBSThMqdn0gg1kuVVFzQ1XrxN8LLtVh
X-Google-Smtp-Source: AGHT+IFSDin9hEAGn8eapDBqSokmqU+717wu2Ivl65JkmX77qI/TxAECHXYsu5Why+LBdm1Fd6dvz/dzpSuP0U1zgxo=
X-Received: by 2002:a05:6512:39d4:b0:540:2549:b6ca with SMTP id
 2adb3069b0e04-54099b71afamr3494300e87.55.1734358530311; Mon, 16 Dec 2024
 06:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215-msm8917-v9-0-bacaa26f3eef@mainlining.org> <20241215-msm8917-v9-2-bacaa26f3eef@mainlining.org>
In-Reply-To: <20241215-msm8917-v9-2-bacaa26f3eef@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 16 Dec 2024 15:15:19 +0100
Message-ID: <CACRpkdbNKqOmsO=Bownp9HNs=tZfiR5rO95G50oJTo_jnusoAQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] dt-bindings: pinctrl: qcom: Add MSM8917 pinctrl
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 12:15=E2=80=AFPM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> Add device tree bindings documentation for Qualcomm MSM8917
> pinctrl driver.
>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij

