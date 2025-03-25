Return-Path: <linux-kernel+bounces-576155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3C0A70BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED00172DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6C4266B62;
	Tue, 25 Mar 2025 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAJDdt+s"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544611E1E05
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935797; cv=none; b=r9nBLLRuPfLSo6+GHTLN4fEDFPJX7UKa6C/qFx56PJYKDZVU7P5D3EnOwQNzJIHzyy84FxeGSQlFOuhhnIsOc9G5poKzKsALCIspvNSn73MLerquMS2+MiH2zgfyBTLjkMSwJIzG6ezFqirBigb996fdN853fIWuuKZDBsYNViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935797; c=relaxed/simple;
	bh=aSGZCgSZyiCMLm45nefLbWbreHawZ4HrRM/1I0jgflI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RE3Suaf2i0+kLr7GnvYMgQEvw3asIrbKcw2NN6t+gPdN46HtRc1+n1rMAu2ef1f/x5jzBGCTo4CWRWZHK4yvv7UclSBc0T1PcKT1DmB4Q+k9PuVswovq9qy2iW91kdr/Z1HHZPnvmfiNPJJSmpeYJxc7W+j+IpigEnrFr6LXp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AAJDdt+s; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5497590ffbbso6653492e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742935792; x=1743540592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSGZCgSZyiCMLm45nefLbWbreHawZ4HrRM/1I0jgflI=;
        b=AAJDdt+sXp4FdLqbKqwWtcEA1l8IEToRLd2MRSBSujtcJiTSFyk5GZ+dX1iuBCGUL3
         cFJAUJ0qg4TmQ1Jt067OtI/JAL90eXjeapQrNJQyHfOyYoPa9U/b4ESy+YHUefK1atgp
         n6vpOWmCTE70yvkSr8umlCdl5bVoVtx6aLfNvD9HFN8NQsCL2+aHjAxygQj4wmJOyY+y
         e0L6IyXVXl5cp9mr8oiPG+1D42ByGT/SzI4GbNqXKr2+ZWDvms4b5tbYT1boKtM2vzBW
         W+7R2YC57yzQ/mqskZBQDQSgi8LcBXs8rJ2nIOOjaykg5B+rsg4kIEZipD/F00l6kuQv
         /ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935792; x=1743540592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSGZCgSZyiCMLm45nefLbWbreHawZ4HrRM/1I0jgflI=;
        b=avHpqMtEkgO9e03YWIjX7u/IN/QxU+RZxJ++lWzxPZtErMIZiFfo3E5xzLijS8Zqn2
         3jix0N+3nNJNKVxd8zc50UBaLTMufXiGJWzf9MPQvJIOuMbRViSeczmRPvlIu5K1vjPL
         CAkgLQOX3H4iPMqg91D10llrsATpuGvRYRN52XTk8aR5YFc1e4Xh6SslJqR6SJbElWqu
         AJHO4UunQp8VWkzU/oA5opDjD46a2vb3ai7elan3NwMiLxCMYX3AWt9UGeydxnSBqfjT
         idOVq3at177gsIoaiMGATu9xQEIiWb7/gjt3LmbpylaTdVrzI9GgXGZtZWvnN0lbqBur
         Wfig==
X-Forwarded-Encrypted: i=1; AJvYcCXzWInaGnN1yTvccnefJigZ8Anbn5geYz+oxQnlCyxDhjB34iY/gs0KPf2zYUNySEB6kVQjjJMA4nuBFyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgcupHVClrFRjBSV1Pj/5tsjMI9Eq89QCNvbARM4CN0/VKARF6
	DB3KJl3l5nXuP3jSBc/oJUkvsGeb6hX071GQnHF8nnIwlexHUDutjTB2loDfPqwe+7vLtKfS1i+
	FMWPRxKiP5xGMJUrUzuZtE4k4aK33D3zi91MI3A==
X-Gm-Gg: ASbGncuPdT4f01Ijyd38m5d3+L4/W0H/THtEcAX1jff4HlYf4qZ8S7Vzud6rRIvZ4Ou
	SlG4z8xCF7/XJJs+YsDlfBLsOFErHPGL+UrznxMrZk19K5aVpYdOKfkzsIswfbOKJsLKTnqna+e
	0lrLPWO9Rg4ibPfqCJ5+YjX8U=
X-Google-Smtp-Source: AGHT+IEF7yyIMMixqctwMg+s9HwHl4A28PDbdusJ+Jzb/Ti0VnewpkU2St5hBerQF3oHbdQtAZyOW4J2NRWiTUU6A4k=
X-Received: by 2002:a05:6512:ea8:b0:549:b0f3:439b with SMTP id
 2adb3069b0e04-54ad6494351mr7341343e87.16.1742935792230; Tue, 25 Mar 2025
 13:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325141311.758787-1-emil.renner.berthing@canonical.com> <20250325141311.758787-2-emil.renner.berthing@canonical.com>
In-Reply-To: <20250325141311.758787-2-emil.renner.berthing@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Mar 2025 21:49:41 +0100
X-Gm-Features: AQ5f1Jr_QmG228mTrT4635Lxbqc8kIEzoAGcZXgVlRpA7Hs97jG_kwma8QcfMxU
Message-ID: <CACRpkdaJPXbc_83PdhjFDbmqcrV61k2NgtPjyA7gQnoBGRPgcA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] dt-bindings: pinctrl: Add eswin,eic7700-pinctrl binding
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>, 
	Pritesh Patel <pritesh.patel@einfochips.com>, Min Lin <linmin@eswincomputing.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 3:13=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:

> Add device tree binding for the pin controller on the ESWIN EIC7700
> RISC-V SoC.
>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

This looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

