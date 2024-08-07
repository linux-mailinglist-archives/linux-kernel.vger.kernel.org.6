Return-Path: <linux-kernel+bounces-278302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A49594AE79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52D31F21793
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A404813B295;
	Wed,  7 Aug 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngG8zCyR"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772E13774B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049774; cv=none; b=HPYs46o5qQjD8ba7lKXe2aUkX17b50ql8XDy8XRDjsZcQK0mTMo7BjY9DYYKSOQI7PkIB8RzZftGLAY3X81WLQ/9r4bnUO+UIybV0MYhvG1Pe47gkjQNzvmsoyfSSNJBDOO/xMUMROSHZ04RonYg6TXade27mDmOzP65NWc0dlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049774; c=relaxed/simple;
	bh=QZymBs+eKZ3wGkqZLs62iD/WC+luTl2cLwV7VzziwP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REnmlnHt0+zC27mkXhSj83N2IlgwzoGTCLdvID/osdB+YhGnWduW8VWcAMp0jbtuGZWZPEnHIAhk8oTfUETEncFhGKREZcLIFSjE/CTMUJ3Qxo44JPxsz27e7PhWnnYgTDIuIXQwySFZKgFExCbLQaPUA/l3xOwVWY72FNUF8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ngG8zCyR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-530e2548dfdso23387e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723049770; x=1723654570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZymBs+eKZ3wGkqZLs62iD/WC+luTl2cLwV7VzziwP8=;
        b=ngG8zCyROV5X2cXsvYhDdWn/Q+z4U8V4ogdScI348PYskAw7UYP26mTHOuoU0/nUAg
         Quyba+e4SeFSoN4woDGtiYRIQMIGOgVADFkIk3F6SxBr2mGGjguQJu1xOa8VfngouCeG
         mdDP3Ym+2UsnrRct0tkDgRhXEeiYSl1Ng01bzQYi2Q4eVGGw//Zjh6Nzkc4DBtIn8g20
         /XeHg99p42Jnmpwmofj3ws6QqGn9LTNXcCohM4tGhBM8o90MCny6XjpqBRNFVYKKJ5nK
         xLHmKY0O5D+Ob64vZUL3edyVULbpivy1jO5FOhRURhJFuBeMwjtwVnM/58Qi1n4kfnIj
         07yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723049770; x=1723654570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZymBs+eKZ3wGkqZLs62iD/WC+luTl2cLwV7VzziwP8=;
        b=f3DkTEI/hCkbMFP7uM6Mp2BVby1Ij9km5To+icflaokdCxDzIC4R4h0v0RP6qAzKmZ
         nK+e7SqisGDiUgzccy4WQQK/gK0MmAZOc4NSozaG2Mdremko7Dot/5Ohow1a+kzRAoJV
         ZAnge0Vr0cXJdPi1vwLZ1vjT7kMNHid1fIkggHNahneo93NqSaKlhj/37coqqVfvRgyu
         xRZrDHdQzzC35V6kiq3Z7tZPVNWAyLH8n1pGVTQ9EMtGZZ42pA45hPPZuAAYCbOogb2Q
         fFGPoXsDo9TDlLIIvzbmW4WhC8GeavOVEZGzaDSKgH6jPFB8WCSef8Y9lpSygCVq8EUc
         8Yjw==
X-Forwarded-Encrypted: i=1; AJvYcCVVtU7OVFFFQAamCRK/mUU4cloF7aUU4s6pEc8OUiCqMV19F5mtmjTnx2ed2nUmzR+KZHGvIAfeDZPZEM/wMQU/y/H4Dz8A1L/F8ma7
X-Gm-Message-State: AOJu0Ywcd515XNseNxrQUvWhQDV/QgKZoJ8yqDRl0AQViF3er52gKthc
	5AMqawTim0arNA9oShX+PsI2pe5K3AhsHjoi9NFSRdqcKNdw9kBE9xJkvhyFQwnYLEmGNtwD0ez
	V6GwCE8qwQd8oJe1/qA14gmHzJdrkoXro9rDRJQMzKJHTvNNT
X-Google-Smtp-Source: AGHT+IF9pFh79hDfWpFT5gb/WrtkGcdEBNFXxPxoVpwAm5XZb1BzyG10CU2vBHyWrPgMN/JUxH+J7VLto5fpWiF3CS4=
X-Received: by 2002:a05:6512:1045:b0:52f:cc06:c483 with SMTP id
 2adb3069b0e04-530bb396ca8mr13337439e87.24.1723049770240; Wed, 07 Aug 2024
 09:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-supervise-drown-d5d3b303e7fd@wendy> <20240723-underage-wheat-7dd65c2158e7@wendy>
 <CACRpkdbRE695f-+do1HYpOZ6e4qxgUBWJzEPO2hTCuZ3xxYHQg@mail.gmail.com> <20240806-breeze-crazily-84d4e4af8f4e@spud>
In-Reply-To: <20240806-breeze-crazily-84d4e4af8f4e@spud>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Aug 2024 18:55:58 +0200
Message-ID: <CACRpkdbMxuhe2HQZ-Av1R7JW94rS0FosPO-utYNsFO8avR3TbQ@mail.gmail.com>
Subject: Re: [RFC v7 4/6] gpio: mpfs: add polarfire soc gpio support
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, Lewis Hanly <lewis.hanly@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 7:18=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
> On Mon, Aug 05, 2024 at 10:04:53AM +0200, Linus Walleij wrote:

> > Is it possible to use augmented generic MMIO, i.e just override these
> > two functions that
> > need special handling?
>
> I'll look into it - as I mentioned under the --- line, I really didn't
> touch most of the driver and there's comments from Lewis' submission
> that still apply.

Thanks Conor, thanks for taking this over, too many patch sets fall
on the floor. I'm mostly fine merging it like this and then improving
it in-tree as well, I'm not as insistent on things being perfect before
merging as long as they are maintained.

Yours,
Linus Walleij

