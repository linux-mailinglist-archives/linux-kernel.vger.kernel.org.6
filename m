Return-Path: <linux-kernel+bounces-226910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C291A914597
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A931C226BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D61A12F5A6;
	Mon, 24 Jun 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="MzkgpNdA"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D112E1D4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219565; cv=none; b=NpG9IEEE1fhabIejbyStmFWuMG3xypit6AX+dLfHU5jTtwns4Aif3ZRFu42xphHJ0icopc0mpx+BfmbsIHrhZAleOC6pYLMoYAkMlURDk8RXG2FJJYgqGgbAw7jRWMkYtiMHeNeTVtQOk+GaslRNJ+5Vs3O5coOhnLCXKG5Uv8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219565; c=relaxed/simple;
	bh=hdsmDqmNgGZQgfRkYZ6dfoEvN0ahnTXGnc7hhzCQrmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9VPaHodaOp9chrPwp8Pq9vA10HsnQNSCvsunGWBin1STaviZtQP3Y9Stq7OP1J/QSQcIa3LTkSlxUQfBLEb21elqnHc7gQ8gj+o0YxIB5PveNegD/XZvjasGKl3ZsCP8c0qj9r+++qfacuAXY/F6tmZWd6kDrIhd9XhpBIPtPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=MzkgpNdA; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7955e1bf5f8so263680985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719219563; x=1719824363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdsmDqmNgGZQgfRkYZ6dfoEvN0ahnTXGnc7hhzCQrmg=;
        b=MzkgpNdA+GFVqSzcGBdQV5+67hLPJQv//dxUXjRiCZwxk0Pbb6cUCEqgy4VTTNiygg
         HGPX4tQv3bEkRG4s0S7lzRevYKJJqlsUjgFUQ2kXYqGa3nS5FxwDcKzyO2P5IP7QiFyh
         hAxtVFyl4A11u3NhIa++NuzEn86CRqcT9K1Fbofl6/XvmFKQPityb2U0NEOr3pqr1Nay
         bbeRukitLOAAgtaHOMtkJahG1QwhzuzBY4FtUUqiv2yfhBr03ojzwz/GB1i7gzAdxtIN
         Xng3ZSw3PsyDedFYdaWwYsn1ASWr/KLdTRIxDOytqaOxM8K8rLBdvIE3YJuQVWWhVj2P
         dp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219563; x=1719824363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdsmDqmNgGZQgfRkYZ6dfoEvN0ahnTXGnc7hhzCQrmg=;
        b=RKIeJZHQ7xHNo0fjTzu0y+yPbCCPk+40pk1m1kDajvv74vYn+hneyXke/xHBaeKKKi
         OyVnd+GIhu4QBezseA6bxDiLlVXyQgMl9+9RtoNh8gub3aTTZXGBVTe4+kzf2m/y527O
         i75Dyqs/Xe/aS+ZauCz+EYSFdycUDZxI2Nt5SAHGxjk+R0kMfcjTXPYymfsGPqHH43N+
         ykgRuID8GM4D0NFEEeIvaFol8+Q5OrSKrIC5CnJpioSqqGd42INRN7diysNEMpzi1a8o
         HPMCPduhBrmc4mPRp81aXXqyxKIEMinTgDhVMxQf4lEvlGUWnbjR+7HRhoyQzt8Lerzp
         242g==
X-Forwarded-Encrypted: i=1; AJvYcCUMNnM+5ZEtyj3IvVhQNxOPFkW5IC8vFbOYgCNyxyDbFdd00myulDf7F3hwOsZ5bC+IbzZ+CbgZr+9Ox8M3crCoe2qfy/qIyj5Swy45
X-Gm-Message-State: AOJu0Yxfv3vVdEO3QSw1e8Pki9GSIZIkPwth5uO4wI72lEdTsLFnbBst
	vv661OzVWHozXqQTFx8NCw5uPjzf1UJqeiKnNtvBq+Pq56pVD4VCYLYNmAC4nl+MujQkSQ8XHZP
	T9tlszWfYiocd3ObTkqtL0qdWwsA6mK2Pe77DQQ==
X-Google-Smtp-Source: AGHT+IHJdukmHTX31XZGqN8Ya5O7xqbZeOSn9ad1olNhKCpFsHEHdPHP6m4H5tAF93YKuWVFl5Mnqdf3Ba8kIeeVBLc=
X-Received: by 2002:a05:6214:4a45:b0:6b4:ff32:8287 with SMTP id
 6a1803df08f44-6b5409be0b9mr37950676d6.22.1719219562855; Mon, 24 Jun 2024
 01:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
 <20240620175657.358273-7-piotr.wojtaszczyk@timesys.com> <ZnkGcwd8M1QFfmxl@matsya>
In-Reply-To: <ZnkGcwd8M1QFfmxl@matsya>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Mon, 24 Jun 2024 10:59:11 +0200
Message-ID: <CAG+cZ06R5P1g+1Pk3gbQ6Yod0mBM41dFTgvnBWg61HZFUtmx-w@mail.gmail.com>
Subject: Re: [Patch v4 06/10] dmaengine: Add dma router for pl08x in LPC32XX SoC
To: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "J.M.B. Downing" <jonathan.downing@nautel.com>, 
	Vladimir Zapolskiy <vz@mleia.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Yangtao Li <frank.li@vivo.com>, Arnd Bergmann <arnd@arndb.de>, Li Zetao <lizetao1@huawei.com>, 
	Chancel Liu <chancel.liu@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mtd@lists.infradead.org, Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 7:39=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wrote=
:
> Any reason why dmaengine parts cant be sent separately, why are they
> clubbed together, I dont see any obvious dependencies...

The I2S driver depends on the dmaengine parts

> On 20-06-24, 19:56, Piotr Wojtaszczyk wrote:
> > LPC32XX connects few of its peripherals to pl08x DMA thru a multiplexer=
,
> > this driver allows to route a signal request line thru the multiplexer =
for
> > given peripheral.
>
> What is the difference b/w this and lpc18xx driver, why not reuse that
> one?

The lpc18xx used the same dma peripheral (pl08x) but the request signal
multiplexer around pl08x is completely different - there are no common part=
s.

--=20
Piotr Wojtaszczyk
Timesys

