Return-Path: <linux-kernel+bounces-421845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F329D90DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68460B26A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3898D2940D;
	Tue, 26 Nov 2024 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jz2xoc22"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF64962C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732593211; cv=none; b=jACU+oHQCCnN6SsoBeB7pAPxLX4Ee78h4Mt4E9UHWd939d5+4eX5vPtkANg7CEdbiSZmB5KqkU1Tf3xfaxqAK+p7akU21AcozL/+D/rGPgIoFznExQkHAZfJcQnY7kcFOF6QkbnnR6yxIwefL9svpj4Z+ca90/GibJGABsvOKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732593211; c=relaxed/simple;
	bh=FrUsNULivxcVoqmFzn2PjE2p47NGik4sHvTM4nqcV1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rf974DcOVaJFZUctcNlkZwZIC4QOxwTkbck6UY3i02wisS54p/+WeiYdQS81Q7SGrU5Pv1cbL0n0v5B5d7UV7rOhP1z7oFrrIPkMCdcME643mly6Ntw4a2ptaSSMPWiCiH1kOUGgRFr8e22gHCZukF+USKI0HSz/XoZYOVwk9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jz2xoc22; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53de101525eso1925158e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732593208; x=1733198008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36c/HAD52p/Ko65f314flr6IbH5n/HZuzOyyN6pe2Uo=;
        b=Jz2xoc22YF4/zMwlfHn0EJHeTlxSFycqNcSb5KjH4JSmgIQippND05LZGbkhAXrkY6
         Nw9D994wMELA83XgL7ajMkLDsiceYpMvopPR6Th9A3R1r+mQ+MyATrFU67SPHr5US6Pp
         jeh2vQKzEVZ6T8Ycvbis3aiU6svtDuurDhjFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732593208; x=1733198008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36c/HAD52p/Ko65f314flr6IbH5n/HZuzOyyN6pe2Uo=;
        b=AMjW7AA6zjkgSffGyQFHLgw7KI8HTJHuKos6SRzWUONzMcqe9EcTi2I1RVH9R77Q4E
         ysPPzEsPivODwf954VftIhUx3E8CMVxJ4ycDux/HhCnvOJtfLP2ZOgdSmMwvNjQn4tey
         rVzssBYjOdhCbfCrBwDoqKETOA904HOr4WwgLXCOu7FC88o61QdiHlWQhLGF08zFAzkV
         ia2wOhwWt7nHtCVOaccMlYCq4MuZE+KOg1i2AuMKtg+beFzr4p98BGC9Gl94jTEtd9WZ
         3QmPjbke6KgZZ8Dz4HmofDOsIC+mKyH6vHY3c4LmO19pZmphDbvjFFtr/0skvDWKqafg
         8Vfg==
X-Forwarded-Encrypted: i=1; AJvYcCXY4uCPK+AHch04cz5lxqZOxnP0lRkEEs4YPEtOJP2B2MCKAKN/F5OXZvlwc4Q7LJ/qYzUGxrI4Q7Z/Ze4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iKAlcpyflBjAgKZyLqHWVnT6t6o45YbGo3YL5aX+ZlGd9Ayo
	Wd3pItp5Ya2mbDxHoZd9StfmZyZcEz/MiHdnl8noRLGu6Dn9K/I+nRt3EGJ3BE4rX9sQWln7V51
	2WsoGq/RHcetLkjkRqQVDgVqLrhqQSLvDb0jU
X-Gm-Gg: ASbGncvS6cBG9BIoevR52osePfBBCH/fdU+Zpn1Zx9iCpP3ftFyM7X6ltHg1uuYHFa0
	gL8Mk6lSV2E8+FqeyIjh0SyUrzvD3Bo91okhUT1PtbUvVri5TRoKbZQ476EU=
X-Google-Smtp-Source: AGHT+IHlTCF6xqqXC9D5Ru5D7akZvI7lG8VNYgnh/Aq2hlV7URcGaHr1iOvC5Yx6DB77+Nk2LpYBhWPz/8xUj8dgOgw=
X-Received: by 2002:a05:6512:32ca:b0:539:f922:bd3a with SMTP id
 2adb3069b0e04-53de88505bcmr528168e87.25.1732593207946; Mon, 25 Nov 2024
 19:53:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125113151.107812-1-krzysztof.kozlowski@linaro.org> <CAL_JsqL6e28pZ9G55Ab6SJO_xNK1R7D-xReC8girvP9VMUk=2Q@mail.gmail.com>
In-Reply-To: <CAL_JsqL6e28pZ9G55Ab6SJO_xNK1R7D-xReC8girvP9VMUk=2Q@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 26 Nov 2024 11:53:16 +0800
Message-ID: <CAGXv+5HKCQUNuaeJLdR2O8-VBjpu8ydOcoP0AKP3-__RmrCxRw@mail.gmail.com>
Subject: Re: [PATCH] of: Add Google Juniper to excluded default cells list
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 11:46=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Mon, Nov 25, 2024 at 5:32=E2=80=AFAM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > Google Juniper platforms have a very old bootloader which populates
> > /firmware node without proper address/size-cells leading to warnings:
> >
> >   Missing '#address-cells' in /firmware
> >   WARNING: CPU: 0 PID: 1 at drivers/of/base.c:106 of_bus_n_addr_cells+0=
x90/0xf0
> >   Modules linked in:
> >   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0 #1 933ab9971f=
f4d5dc58cb378a96f64c7f72e3454d
> >   Hardware name: Google juniper sku16 board (DT)
> >   ...
> >   Missing '#size-cells' in /firmware
> >   WARNING: CPU: 0 PID: 1 at drivers/of/base.c:133 of_bus_n_size_cells+0=
x90/0xf0
> >   Modules linked in:
> >   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.1=
2.0 #1 933ab9971ff4d5dc58cb378a96f64c7f72e3454d
> >   Tainted: [W]=3DWARN
> >   Hardware name: Google juniper sku16 board (DT)
> >
> > The platform won't receive updated bootloader/firmware so add it to
> > excluded platform list to silence the warning.

Unfortunately this isn't the only platform affected. AFAIK basically any
ARM-based Chromebook out there has the same issue.

> I'm interested to know what needs these in /firmware. /firmware is
> supposed to be for things without an MMIO interface. An alternative
> solution is to add the properties. That doesn't require
> CONFIG_OF_DYNAMIC and is often the approach powerpc uses.

The regs point to a memory region that contains bits left by coreboot,
the coreboot table and the CBMEM region. The latter encompasses the
former, and also includes things such as the coreboot boot log.
These are covered by the binding firmware/coreboot.txt and supported
by drivers under drivers/firmware/google/.

> I'm also wondering if ranges is also missing?

It has an empty "ranges" property. I dug through our repository, and it
looks like the code was added [1] back in the ARMv7 days for the Nyan
(Tegra K1) series of Chromebooks. The code was never updated to use
64-bit addresses.


ChenYu

[1] https://crrev.com/c/203693

