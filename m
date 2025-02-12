Return-Path: <linux-kernel+bounces-511480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E15A32B90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36541664DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6140B212B05;
	Wed, 12 Feb 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="czNW84DX"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF981D516D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377697; cv=none; b=QGcHGZ0B6HGdoG7Txd+X4aRsQMarSxbTiCLdRgtGwUTCKqC3fq89YyCuE9ibswURGnHyJu0xMJRrvvjd7fhUKlQDajjaiUXxm1Rq1eB6dx5pZ8q2MUdhCQSEtj+USoTRbKW76WiCHU8sagJ/ykaLUZVTqAXyoNc3TMXsnzcMVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377697; c=relaxed/simple;
	bh=TZuDBz/MQSCI0W6Y1MIlb4k+WX79YX+OdPUXe7FESaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2Q2w5Sh//xXV0BQHN1Wgq0qGcRWCjxqzOP6zLsdux5XzkwemjMxFANpUGn8OkKbwb3xjUwz4HoI2IlYqTmTNM570QgJnUxgCLYb+XoL2nn/zTbM23AT1Kpa25WUTMnm+JrnNbbhrXc2L7xnZzKTLmgl4HU5EFLGy+EMcATs+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=czNW84DX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5450d56199cso1162893e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739377694; x=1739982494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZuDBz/MQSCI0W6Y1MIlb4k+WX79YX+OdPUXe7FESaI=;
        b=czNW84DX6cY+yVs/pwpa1BrTEzcOVrtnwMtkfLqT+0qsCcUg53SJR+X4RjRB6p+wDg
         onjT1c+4nRlSWkoxeAx4iEB0Env7rUYhnYyA5gSOpb4CnfsfphgcWzgkjv9XXXBY4fho
         od83Kj6b4y3U4oxRw6xM1pasbDjRoMzHIVCHSMxhOo1PMTtE77N36dUt9emmXrVMnsBw
         1l7Tkk1NWXTaRdDmoP3MLzD5dczqBXY2NWKClgiBFaAywX+NHrZ/7Fj3SPBCvyhwaASO
         pprfmmTx9ULDkJiK5CecYEphtVj1+1bb97tRtZeLhjWbtPCW/ZTIsDVa0at7gBUqpq9C
         Calw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739377694; x=1739982494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZuDBz/MQSCI0W6Y1MIlb4k+WX79YX+OdPUXe7FESaI=;
        b=LsASC6GZ39zPiyZAEgiZkjInwedoNy0S7zrXMHsJ12sjoc4FKpstBF8liW6ePwx5ad
         ySUHmuNiSDYSvWgb233LZAWmSLuTf2BfOSmXAEw/t62WED7jmrcHxytYgp8qOIIp1qD/
         bWT9ch2NpqjZJVniaSea21eoJ+lEf0fUMCGtQiHxb5GdYIscfP6BYVsj/Lioar42C42W
         PZgkO3vnVNMX9JIu5MG4O0iYNug1/ePTeKp26k0sGUPVrWDTWJi3Ds1RfKL5vCqvK0mo
         a3p93XZbbHPWrWvzgO/E9N4V19k+ph/cCjDhIdSR0NdgOQaulgj03axMUQo3k0j5gc8y
         yIWg==
X-Forwarded-Encrypted: i=1; AJvYcCVZSVFc9UZR1P5ckx4a0BrqgOw2fciYNGtB/QdFsO6Gr5VwBrogZWmQko9OfZil0i+07DkzlB9y1qUJLdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2D9gYLSsQ5PMn4mGGV9VdvLi37NUI3I5D2xf8KanZEVSn/jS2
	GGuToh0mzRqc1205yAkaIy2n5Ldls+xmz6dUnPjXfKMqLDaxdce2txgZm2LcyCRNfHXfPNtdNO6
	1HbZMwOiPIM7T8Q2HWz47P44D1txeTySN7qWSRw==
X-Gm-Gg: ASbGncukTUdEA8BY20t/r7o/K6M2A9oa97kjANE7k4mx4ZvgZ9VTW3ko6+dAGZkwpBo
	sD3BrnJoS4AkMSTRqcfFWfY/KCwq3WKmtEJvwq8IIT49sA7lU/6s05gbXcwclW44CEa9FLaVavG
	9Y+5d06Np357XfTB9amkMDPcApj4DK
X-Google-Smtp-Source: AGHT+IHxOU7el76O6ARJgH/qSyoLSVZhpVM8aMA7Z5L0zSG1UJuAQdeZ/CLEIaRjM80ZHRoBtF9ivf8u/8H5ppM7Ojg=
X-Received: by 2002:ac2:4886:0:b0:545:16a8:6a5d with SMTP id
 2adb3069b0e04-54516a86b7amr1230558e87.2.1739377693855; Wed, 12 Feb 2025
 08:28:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-kernel-upstreaming-add_gpio_support-v1-0-080e724a21f3@blaize.com>
 <20250212-kernel-upstreaming-add_gpio_support-v1-5-080e724a21f3@blaize.com>
 <9442a87b-ab61-40e3-bbf0-caae87c5731a@kernel.org> <259dd121-8c49-44f7-b8f6-e0b68ab88304@blaize.com>
In-Reply-To: <259dd121-8c49-44f7-b8f6-e0b68ab88304@blaize.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Feb 2025 17:28:03 +0100
X-Gm-Features: AWEUYZkIVdRopbQJY-FCVehpC4ahYO-92VDY2yMNzSqT804kqps9s9wQ30KQZw8
Message-ID: <CAMRc=MehUWAsBO6YWvwOsexu0yj6S5-g_ydS8tdX12iA0KER=g@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: defconfig: Add VeriSilicon GPIO driver
To: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	James Cowgill <james.cowgill@blaize.com>, Matt Redfearn <matthew.redfearn@blaize.com>, 
	Neil Jones <neil.jones@blaize.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 5:20=E2=80=AFPM Nikolaos Pasaloukos
<nikolaos.pasaloukos@blaize.com> wrote:
>
> On 12/02/2025 15:25, Krzysztof Kozlowski wrote:
>
> > On 12/02/2025 14:46, Nikolaos Pasaloukos wrote:
> >> Add support for VeriSilicon GPIO controller.
> > You enable not add support, but still the main question is: Why? Which
> > devices needs it? Why this cannot be a module?
>
> Hi Krzysztof,
>
> Thank you for your fast review and apologies for the typo. I forgot to
> mention on the commit message but I have mentioned in the cover letter
> that the driver is needed for the Blaize BLZP1600 CB2 board which is
> already supported on v6.14. I will fix the commit message on V2.
>
> This driver enables support (controls) for multiple peripherals on
> the board, like Ethernet for NFS boot, SD and eMMC to load modules from
> these media. Without this driver build in the kernel, it will be hard to
> mount a filesystem and load modules.
>

That's alright but typically you'd want to have something like:

default y if ARCH_BLAIZE

in the driver's Kconfig entry.

Bart

