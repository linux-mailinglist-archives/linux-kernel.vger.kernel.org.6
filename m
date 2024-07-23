Return-Path: <linux-kernel+bounces-260104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B810D93A31A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0FF1C22C56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F864155A34;
	Tue, 23 Jul 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wNLoBGfA"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA515573F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745890; cv=none; b=AAi1zfwwOPfwob1wi/Fu2oVCBIr4NQ9Y7alc8/uuCUj6bkqqDONTDRdnlHYFmCxSJL4skwXyLw89zlMDnlkisDUggpOceLt5KMzMILRYymSnTmcR0uIE2LGjzCQJz0OYDhWt+rbmBh7r7lz2CNd++hItniZ5k6cfb+EuXOmlKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745890; c=relaxed/simple;
	bh=/DhszLUQm78wMoJ8KfR7NpJ/TCjeTVmSlYGYshTQDR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PR1yLszPYqpXWuuaJ3stXRh9JaKaCn7imC3WLh2CbuouVbbCNCR2gafATZ0XpfjdemuJbCxYar4ciwHdZmaeCPd/FYII2hTmwE9stpqzHTh92y7SdTttvbKcalpIGbBqUGJfjDT6ZVVxbvVxxqB22aok2UL2VE7Gdus4N4KU/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wNLoBGfA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6678a45eaa3so53953357b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721745888; x=1722350688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DhszLUQm78wMoJ8KfR7NpJ/TCjeTVmSlYGYshTQDR4=;
        b=wNLoBGfADIe/jSTAwATqYvqBwNRF6FQQAzIXRfgsRxSE2HG+soZGkdnHP89cNSsVpk
         y7mnNCGneMpwQmwDfANAu6ZwnHf+rdBUpb0/wRwae66U/xyvu1yf3J1/ahTziaYHrPOt
         Kzy4bjq/bOyrGHr/n5HxAmh85T32b04M/J4+sPbeYEMALCEoO2Xgg9alk3Pzm6+4/YHk
         LBJo58HtdvYGL7n6Im/jAfTuUC5wYWdTJVDc8N+k5EhUsYqoM3jmlR0LqeDrH8kU1CL0
         AQ7qdUa3WWkT+LwUprQR80lFn1arsuaBHqHeE7q/gUmPJi9U0SkOz9QELTIkEWa4PTqA
         AEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745888; x=1722350688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DhszLUQm78wMoJ8KfR7NpJ/TCjeTVmSlYGYshTQDR4=;
        b=G2PFpd+gvNylRCHz4o+N1Kgcjm27leUAOh1TMdlI6Enlj9y1rh45gHchc2ouFgfkyp
         JJdKTFek+mNxsDP33So5yxX013NwzoGfQ5N3vhd8eVmMEuug0qaFVz8PfNynDyP/pbPI
         wZdpzrQIMF8l7eyCOg3wT0HxtCk8DLKUQCxWfJ+CLs3w4iTtuQP2Eda9R9nNga1FIP9n
         6Bw0LqlIhILMXGOATbaEWeoxcVTEdYhXObHhN737QhLYM5aXxPJTWe64PMpUmKclAaXp
         Spq96dHiUShZIo3/GYVTrFGwI7CGg0gDgFofvc/JYdg409PyLl1EqbIPoLLfO1CF746K
         d91w==
X-Forwarded-Encrypted: i=1; AJvYcCU8HXrlsDieCiVcZSFeYLDsuBBsc1U/w1HRJeC/BDGvfN6xfMIdUWtX4CyUyWL+lr2okEeJ0JdAiCBe4lyVXOQ0DNoONBszdL0quZNV
X-Gm-Message-State: AOJu0Yw0rlBA9saWsu3GlwWi39ZP+p+i/f4bVSnyDeOXM8l9xLjijl40
	WhE3AUCxPmDDoHSMWPeFuhtwcEneeZjQYQGNoi9X8OVf7IWgKUEy7lk5DOa8I+RtfGDdceVwBsE
	Ugd8Nm1dG38zChxObeGDfTPRvZ9LvqycpVnJJEw5vX68oefwv
X-Google-Smtp-Source: AGHT+IFGjfjFX/FJh03F1MKKrGFIVaAs0XDkGFgTDf72tmLxkemD7JLVTcN+JvnaLeLNBvOdMegKN1zpNtKOUb737uw=
X-Received: by 2002:a05:690c:10c:b0:627:d23a:4505 with SMTP id
 00721157ae682-66ad8309fcfmr141173287b3.3.1721745888405; Tue, 23 Jul 2024
 07:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240723141654eucas1p2deadd470e2ceda1601042dad4acfc17e@eucas1p2.samsung.com>
 <CAPLW+4m0xG5yHOT_ucGdrOhLZvjhga8caqHQZmVH6HHKUnBgkw@mail.gmail.com> <20240723141638.374742-1-m.majewski2@samsung.com>
In-Reply-To: <20240723141638.374742-1-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jul 2024 09:44:37 -0500
Message-ID: <CAPLW+4nYfVytXnpDs02QQGms59dL+=pAv7NMNPK6Ymsemmi_cw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add initial Exynos 850 support to the thermal driver
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 9:16=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> Hi :)
>
> > Thank you for the contribution! Did you by chance test it on any
> > hardware, perhaps on E850-96 board? Just noticed there are no dts
> > changes in this series (or as separate patches). If no -- I'll be glad
> > to assist you on that, if you can share dts definitions for E850-96
> > and the testing instructions with me.
>
> I did test it on our copy of E850-96. I used this for testing:
>

Good to know, thanks for the detailed info, Mateusz! Just wanted to be
sure it was tested properly and my help is not needed. Btw, I'm
curious what is the reason for implementing TMU? Do you have some use
cases where it's needed?

