Return-Path: <linux-kernel+bounces-345850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D298BBDF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E86284576
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CBD1C2308;
	Tue,  1 Oct 2024 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYT6RwR6"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61219DF53
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784815; cv=none; b=LYC6ZRb1vu3WLOCdvLknaU6LgDfJXLNcMk/xcfnYF4zttgN/9I3Wl1BFSq1MxKiDI9tb5BXUr3RVlwDQ/HkVFu4JrwonpotStwSgvD+rfLmL7zNT4dtz1OZaLlogRyqbs1Qj451FNl71THysTQynMdbqDLC9ilX8r7+Xezthoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784815; c=relaxed/simple;
	bh=GSmtCX/NXBnxPD6tdxViAr4FvJpalMjvGZn0b4FY+V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ygmwc9YHbw+bMHaD47I5mFBymI9G4unblIDIcN0p3xs3YrK1xwABXP5kGET26OXGkwkyOzitaaRWMakUjIzBT+Xsdnn1yf87I3pB5HzBrhmWlbKh8kBJNpCEvux/Lx+/wZm+22TDRq5YrDAwEJhCJJw/PeCtwEex7Q1OFTfVwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYT6RwR6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5398e33155fso3383836e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 05:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727784811; x=1728389611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSmtCX/NXBnxPD6tdxViAr4FvJpalMjvGZn0b4FY+V4=;
        b=RYT6RwR6dr4iKtNAWSyi5sMu6LhtjN64USsF72jVnb4aAbixj/pZNMPIwLy+6v63on
         Fi54Qmug0gUVx4RC+CWpyPSsPcoGtaARRj8ma00BqLICQPs5blpiyN03NgKKEMiK5Qza
         fVycwZ7nIPYMbnFSqDF4CKrPmcSB75WI9bRo5dEih2P5nGMoF/wVZCkj4lHAGF6UpBC4
         sHcNn9X5lcoRiM7Wor1NkjcNDE58a4EifgkWSnmqGh3lv11Ss9Eh0+NtJqJE3btMlvJQ
         ny/fDNsjzzZjhAohNZQ1PFql3zrYzXlfHKfypsmx1KVaUcpo4GrCRXwZ1N5JQcgcnKkK
         B2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727784811; x=1728389611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSmtCX/NXBnxPD6tdxViAr4FvJpalMjvGZn0b4FY+V4=;
        b=r5DTA8xN/dLuyV3wG5dkxXgmQQSliCOhjcAPNLdmJx1kDU4pIdJfcFcQPlIKCi9dHR
         WLZbubo9G5fouaA6V5nlvMHwGEqW71Zo2QH6Dil2DOql8q59uJBnbzxxDwg7hXyqpWGr
         Qy21HheqIyWPE50x65rG+7Knkxwn93rqChynI4uaQdbdf8EFb4Pwevsqc1ctbNRdOQHd
         NcbvHEuVWLLExfilwA6wuaY9qhwgVh0i9OhAjPl1o7U3M15QBWPUOIEZ8W9YLEOHAh9e
         gdqxGGtyO/cwI2IqU1gVktkuNkTxvUCg1R3c2sze4+/SlXF5VilKh1+IuJCb3sVF7D1F
         Iz8g==
X-Forwarded-Encrypted: i=1; AJvYcCV9GjSAsgOIGbI6zoUcosInXa/YsMaWJ8ulq17ko/2WsXolmm/HrPlahX61xhIhnBGNwHwmzv/g29vTxuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp0TqkTgSR2Ha5O+/RYOiwM1LBd+zJAKP3Hm2e/syVckf81G3G
	Alj6maFOw6VrD+Y6w7qDdNMVxJW7ZKdPwOqpZ1ac/72L9JB0SxJ2ZiT7r/tsIrFbTGDsO2r2u7T
	NAwT31EDuIJjvJl/4nKVdYskIFT2Ac5BTxotCyw==
X-Google-Smtp-Source: AGHT+IEX5c6pNgEkIZ+KSeqJcmc88FrIwMBPRJFBiIDtvkFGTTvq4JIs8I5dD3c76xnQBRBnqXQWDaKFo+LINH3spi4=
X-Received: by 2002:a05:6512:334e:b0:539:8d46:4746 with SMTP id
 2adb3069b0e04-5398d4647aemr3244329e87.60.1727784810881; Tue, 01 Oct 2024
 05:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com>
In-Reply-To: <20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 14:13:20 +0200
Message-ID: <CACRpkdavPAv2sPRREQhx_A7EtOj6Ld_n+NcO+vH0QCnfVedXKw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] pinctrl: Add T-Head TH1520 SoC pin controllers
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, linux-riscv@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 9:51=E2=80=AFPM Drew Fustini <dfustini@tenstorrent.=
com> wrote:

> This adds a pin control driver created by Emil for the T-Head TH1520
> RISC-V SoC used on the Lichee Pi 4A and BeagleV Ahead boards and updates
> the device trees to make use of it.

Thanks Drew, v3 looks good. I've merged it to an immutable branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/lo=
g/?h=3Dib-thead-th1520

Then I merged that into my "devel" branch for v6.13.

You can merge the DTS/DTSI files through the SoC tree, FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I think I'll make a stab at using guarded mutexes etc and see what
you think about it!

Yours,
Linus Walleij

