Return-Path: <linux-kernel+bounces-346717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8202198C7D2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B0A1F21BE0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8548A199FCE;
	Tue,  1 Oct 2024 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="JMzEvdTk"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ABB19B5B1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819910; cv=none; b=IlslzXok9JzWNvr9Dc52TAvlQWso34o7PmGzZkR42XCJxqNHOUn5WFzvMBqOs/HAeDWQJNWCe0hUlQliu7O1s1YHnxiGhM42JkqefJY8SzHTI91r3ubkg6FozoBK2Jl0ZUMzLdj0Xyr1mW7/x0UiwNjH1AJZZxhkKmT5C5CuAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819910; c=relaxed/simple;
	bh=90cj3MZQ2bSTZsUCDSDy7qQ6PfIFyQv5SQPEYusdK10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HctYPs4I4336IOo7nHgrSMe/ZgBy3jRYs7P08iN3ws0OWMio0eut8LNnkM8x6Rh6ZSj//1jPG2WD5Z+ow+1tVEBj1+OrDJkiaNQ50a/UfUq8STTj4Yuc8OZUEBeVAz7IiPao/ovN414fB69leAd5u12/vJMcXHBIrsWi46IbIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=JMzEvdTk; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a340f9dd8aso32860535ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1727819908; x=1728424708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ypgub8lGo9uIxhP/Ts+gM6FIKRMUkTQXJvJ7axKC0No=;
        b=JMzEvdTkiuOL6G6w2L0fd5fv+tB4gpLE9wv4xaqcPWTRSe2ZvJ6y6SvKbQTyfsh+Z/
         ClpVxY2oKl7rx103MA//Y/LrTKwaey8VNOLZ7orVTwk090FR+Iscdbfv9E8KcUnj5YD1
         tXdKvc4Rft1yaqoY8R6+uTjwKniGYefF3d/W7wXNgvzjpRmv3ZUwhgCWxGFWMqS3nyip
         8QCjTu+vi6H8zjYn+lilaJy6293cgOY2ecaZvvBSIeNd5wrOTQdp7H50/HQ1b32w8UT+
         e/R0cyKrmclnFfa7ziTfRUSEO7S7qaKsolXbYU/PpvLdP5wNy2sDemGQbypnumJThH3c
         g4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727819908; x=1728424708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ypgub8lGo9uIxhP/Ts+gM6FIKRMUkTQXJvJ7axKC0No=;
        b=CB27/y5tkxEAUNy4SJHGADA6wy05hZSFOJbp2Zy+ffcaUoQQemJfS9fFoCAIxYZxv6
         SUpiqsXHgrazwkPXN3gO/sIKyt/oFQX9iJtCstHf05AQ984iMs+jsS1ig5srUccnyLEt
         o2MuAYZxOxDMa7tcuVc2dxWSxaPhSFQ1uItToZmMvHOshLLx0r6I4pVgFaa965+bRt7C
         X9S5K/ay80XOjsNW1tCTJ3amCVuq5ZJD9rsexGlg93nTgKGeykgpQtgxPnDsRfpQw0UN
         X1WR0QiwSlpgepDp4Jr3XxLtxbzqDMpsT6CIw1jIsnRDQ7EdR0zisqDZsi9ZkBo1RDL9
         aVyA==
X-Forwarded-Encrypted: i=1; AJvYcCVjQYhbsWLhTgFUj4JcSTwdX2POPyESXnkDnbuty+PkBQvt4tcmkObnKeEeAwTIlC5MKsPOPa349NrisCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqgL18FZXARjBMa+Rn63ibHdGfgn8nUnk36fmK1tBCT8fmznD
	kGmM2RQAxksaXUO3reV6vay3UHlbXQPjDOa1iiiLGtMMd7IsB/y7V7zP5Gs82A0keexEptpfgbC
	yRsx+ousaoWsuCLlsy/8Mn18DXVA/8dj1ZL6h
X-Google-Smtp-Source: AGHT+IG8Mbwj1HalbNL61KqJPzFf+za9Ivu70OdRA7nBBfmVxjXJSGKtMf6v6sdYVH+UJ6WqSeqKg1y+vZZ3u8imlbI=
X-Received: by 2002:a05:6e02:1c87:b0:3a0:a4ac:ee36 with SMTP id
 e9e14a558f8ab-3a365918466mr10985925ab.5.1727819908246; Tue, 01 Oct 2024
 14:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-test-v1-0-458fa57c8ccf@analog.com> <20240912-test-v1-9-458fa57c8ccf@analog.com>
 <CACRpkdZb6AhxB7XEtOsxV5_oa=c1h2+ZApLFsTS_MQs-cjLmsg@mail.gmail.com>
In-Reply-To: <CACRpkdZb6AhxB7XEtOsxV5_oa=c1h2+ZApLFsTS_MQs-cjLmsg@mail.gmail.com>
From: Greg Malysa <greg.malysa@timesys.com>
Date: Tue, 1 Oct 2024 17:57:16 -0400
Message-ID: <CAAjXUapu1DBqnk24ng0izU7opn67YxiwpGpFtqrBmqNgyCxRVA@mail.gmail.com>
Subject: Re: [PATCH 09/21] gpio: add driver for ADI ADSP-SC5xx platform
To: Linus Walleij <linus.walleij@linaro.org>
Cc: arturs.artamonovs@analog.com, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Utsav Agarwal <Utsav.Agarwal@analog.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Thomas Gleixner <tglx@linutronix.de>, 
	Andi Shyti <andi.shyti@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, adsp-linux@analog.com, 
	Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Thanks for the review.

> > +       __adsp_gpio_writew(port, BIT(offset), ADSP_PORT_REG_INEN_SET);
>
> Interrupt enable in the direction function? No thanks, poke the
> interrupt registers in your irqchip if you make one (you currently
> do not) in this case I'd say just disable all interrupts in probe()
> using something like writew(base + ADSP_PORT_REG_INEN_SET, 0xffff)
> and be done with it.
>

This will come up next time too so I wanted to mention that INEN here
means "input enable." The PORT design has two registers for
controlling pin direction, one to enable/disable output drivers (DIR)
and one to enable input drivers (INEN) to be able to read the pin
state from the gpio data register. If I recall the bare metal
reference code toggled both but we can review if setting INEN for all
pins and leaving it is acceptable as well to simplify things.

Thanks,
Greg

-- 
Greg Malysa
Timesys Corporation

