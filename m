Return-Path: <linux-kernel+bounces-299243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277E895D1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3491C20401
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E115E185E7B;
	Fri, 23 Aug 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xsASl65Y"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C91891BA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427872; cv=none; b=G0aCzp8aKpQ8ILKcBWLzdY0BIBzQN95ag/K9tB8Em4ag4n0RyhC8kUNEObAguXik66T2xBVU+A9ViIA0bEzzb63bPgDUx3jss1O07om46QAEfBVw+6dLLEDkr10J2FAs5KYU82Wf0I7/tE4YPXXQxdnkB7SN1VuaDd0w1zVHUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427872; c=relaxed/simple;
	bh=rUKpTbjTMGO6d8DrZaKlv/gPDbWH6oSJzFoDGFB2HMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+GWjXQjLjqsa6+xrV2biODhbFE8FdjrgxSg58OZgQdCvncRMIG88cZ5ZJKgfJkK9XVazfvCi6MzoiS9umLkNCjw7uLvRSVwi9DOQjsEXlg9CwcfU+7hQFDbRUWBKKqCrQBai7XBdh3UvUlgk/6N9pMwLRmDQo1jK4c10/zzylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xsASl65Y; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334c4d6829so2806381e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724427869; x=1725032669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUKpTbjTMGO6d8DrZaKlv/gPDbWH6oSJzFoDGFB2HMI=;
        b=xsASl65YiaxZ1u4wcidXYbqB1nBXXGivXoslhNTd+IMod+/68aeNZhRcXLPN6iik/q
         X1pMlnCLi7PJYiGyUdKeawqSALQHyu/8+8inlOFknr62SHHp2J5LiMJsBtMmz2uzd3go
         6QWXKMcgPWpCpYt0XlcqDK2btWh49s/k7cDGT2Lt80nsLKZn6ftj4GXPsQPt/joxkc7M
         nMKVLobt2MXe7C9rg6BWyKWkU2VAg7uNtYNWmaEwbste0kKZt4uFk5alVCe26ELvaaHm
         lqidpXmpof/ydEv3ONSMSgT+a37gzQBvktA7vwufn3nGM8BoHCSS5ZFkc6CAz21q7exx
         LZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427869; x=1725032669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUKpTbjTMGO6d8DrZaKlv/gPDbWH6oSJzFoDGFB2HMI=;
        b=mgSB3MBW19bNWCnZFDPaGOob+Fm27PPR1RXsv/X81/BZFLLFhoRLc206b/hWOgPMp+
         YNLhSXrg0/ial8Eyb0FZqSgaNVQEGLsABEsZOIjhWoNNiV2YHrpiKIg0hZErMmz0Ar39
         PMWyxEEcROGWnLSEPNZpgdEFdK4sKtrZmiLEMoIc3zErFh4qheBiM8s0fkPpE7CwuakU
         OlPZR7wbo+r8p5Hub0f9rjT/9TgQzx7R6NbpGonl9P1unHXeNEto+VapYjcbveGNUSLK
         nwmk/duAHwT+dsPGMxug8o6zIbn2EAqtXZeOH5CE1pQpsj6sSofdmqejijMOrLHgn/HB
         dk5A==
X-Forwarded-Encrypted: i=1; AJvYcCUXHpF7bcSc/Yw1D+JOM1/C3Qlx9EVfr2hVqYVvUhHsTmb2GeJ3pdQf3UpBzzYgDOws6V4ep5stNdsv24U=@vger.kernel.org
X-Gm-Message-State: AOJu0YygqXDgy5yALVJziApp6aGuuh41S35eIkFqdpRmT0PzlstQ5NJ7
	w8tszsusj7t9YWsjsU2C2f+HJCAMDJAVOuDK7JRvt9T5p/hykm78v/kBqqGM1xJ6Ksx7fKHD7lY
	iIUuWt66VQgUc0D/E7JZJd3Gqf3OYzQ/3bke0pg==
X-Google-Smtp-Source: AGHT+IGLphY6wmw4p3puKJ7pV1BhETJaO8yEFBVUQMStXaSJMfBctlVKM+lBdvBVLSNIacxc9U5SyjAaRt7G1oWZN4M=
X-Received: by 2002:a05:6512:3191:b0:533:44d7:c055 with SMTP id
 2adb3069b0e04-5343876c109mr1889079e87.5.1724427868274; Fri, 23 Aug 2024
 08:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR20MB4953DC78BB0FE0C57EA94F91BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB4953DC78BB0FE0C57EA94F91BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 17:44:17 +0200
Message-ID: <CACRpkdbaDW2=R881G9C=r1iW4YNdYpRZ2kHaN63T7EX1A0xVrA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] riscv: sophgo: Add pinctrl support for CV1800
 series SoC
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Drew Fustini <dfustini@baylibre.com>, Haylen Chu <heylenay@outlook.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 2:34=E2=80=AFAM Inochi Amaoto <inochiama@outlook.com=
> wrote:

> Add basic pinctrl driver for Sophgo CV1800 series SoCs.
> This patch series aims to replace the previous patch from Jisheng [1].
> Since the pinctrl of cv1800 has nested mux and its pin definination
> is discrete, it is not suitable to use "pinctrl-single" to cover the
> pinctrl device.
>
> This patch require another patch [2] that provides standard attribute
> "input-schmitt-microvolt"
>
> Note: As current documentation is not enough to guess the pin
> configuration of Huashan Pi, only the pinctrl node is added.
>
> [1] https://lore.kernel.org/linux-riscv/20231113005702.2467-1-jszhang@ker=
nel.org/
> [2] https://lore.kernel.org/all/IA1PR20MB495346246245074234D337A6BBAC2@IA=
1PR20MB4953.namprd20.prod.outlook.com/
>
> Changed from v3:
> 1. binding: drop unnecessary type
> 2. binding: use right ref for pin node.
> 3. binding: remove mixed spaces and tabs.

This v4 looks good to me and has necessary ACKs.

It contains device tree patches which I am icky to merge but
I can merge the rest and give you an immutable branch in the
pinctrl tree that the ARM SoC maintainers can pull in to
merge the device trees, does this work for you?

Yours,
Linus Walleij

