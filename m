Return-Path: <linux-kernel+bounces-232289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCE191A652
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7D5288A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DE815351A;
	Thu, 27 Jun 2024 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqbmgB9m"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB1514F138
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490239; cv=none; b=txBeE38r/WefiNelZ+fELZzCplo5qRiEARTnEewxxuNugw9Lfnw5AnZXcVRyWiEPtQu8NeCzVyFCeO6dLmco0iKOOkmEUYfd8N/7SJwcb5BbTi3FV5iLliMQUhqw/LXhWiYsVf98evmbez+KiUCvfLv7FZE2xAgIsTVw9Nednsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490239; c=relaxed/simple;
	bh=NkigWkA6VySFfvHgeE5oFW+QBC+cXkg9GyKrJbWRTzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRyzLNt2aw9HWZJIBk6ucZVnpiZlNqnFr+c7JbWCWR9RQzy0m4+hARU85JCLK4oy3Z5X0MF3y+Z3uT0jsdNxQvyQQgsrXxtbb4HBXmDwKbX8fBYLCs9MHNYjUUn/y6R5Z8GNBtvpiSFHjvpB/0i8ySrtFfRhaAg7tlZKm29U3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bqbmgB9m; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c21c5eb371so1184861eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719490237; x=1720095037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cE4Bab1XKSgATh7IHyFiARbi4eUyFalxuUlRbbSbrnQ=;
        b=bqbmgB9mpeGOWGv6XSkMtnZNCBoyYQFKDR2ohtG+PMSVhrmpK62yZ0XganCVFk/KUm
         jBJM1DFeYYMHyT73QPMn9XEnlmr9tohINW/++deI0Vf8L+fXN8PRc+RCubAkibiL62Ls
         mstzsgP/JxEUX36fillZzEJsb7nrdUthU6acz5ArYom6ibyiaTIj2SEmKYkPCPQggQwN
         WLYgab6CuHC+aG14Wg7uYcFU87znXyckk5BvYcx/shQ6azeAEfSVAc/kHrcT4j+Bh0/5
         ZJ4kZ4rZ0jqMElnsMb82FZTvOUFeYU3vYrQxkiaIzAxAihBNf5NjDK7rnV16FZWX2qd8
         qylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719490237; x=1720095037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cE4Bab1XKSgATh7IHyFiARbi4eUyFalxuUlRbbSbrnQ=;
        b=i1beHU7PFkytPQZS9RACrxrVyMUSO+Of96FNoQQUOHEy2/zHNXwXeuMrV5VuMBL7HG
         oYNc21/q9Ft66hWpOK139r5rRJO+S7o5kJL11FTrDdY9syY3m6Gfu9DEsvNxjNdqGcJi
         ra3iW38+qyRDpOssENWGjr3E6zwa3E5RLORGurkIklqXrs3qjnkdbuStM75BKDbqT9bA
         zPrHn+bzidJpY2spHObmPELIE6tE9H3fwxoVKrA1AytVym4hrC0QQUchuLjJeErgGqtm
         yYWBbqahICFP4veSnIDaWZZnXOo/zoaDI0wYJtROdMg0qesOTgCWangxdnGOXRJ/JC+E
         EZkg==
X-Forwarded-Encrypted: i=1; AJvYcCVPdQAQgvKEy5WuNDzuAIIWM5QwCOVjmvMAmCuN/GpnubOeqFN5M8L9sU0+4KcIuZBRg4pSdxzw/+yjK+F/NpqHmGS2+j1EjWLJP2Mn
X-Gm-Message-State: AOJu0Yy2XA6OxVlgZIUBXbfr6iuoQdFi2RHTS5vSwE95n4hnbbCoDXm2
	Xk8tT9ixzXXIpVKW2zsW907gZZj/4IL/6FpKQ8Bn27AO1GbzwquOQFuixfOhEPrC43UG/uBg+Av
	XRn19dJ/b3w9GDw2LwlzI0euB+52wXYttdCkfaQ==
X-Google-Smtp-Source: AGHT+IHAyaiJEmjGK1tayduKPakkTEDNumaseSBPgUWJsXu5w7UaamjrpjUQeIA3/oIdt38OMiLEdTZdpwGs2IfqBCk=
X-Received: by 2002:a05:6871:3a28:b0:259:8805:b634 with SMTP id
 586e51a60fabf-25d06eb6695mr14671549fac.49.1719490237191; Thu, 27 Jun 2024
 05:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626194300.302327-1-peter.griffin@linaro.org> <fd840123-31d5-4472-a755-ef6a47613e5c@kernel.org>
In-Reply-To: <fd840123-31d5-4472-a755-ef6a47613e5c@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 27 Jun 2024 13:10:26 +0100
Message-ID: <CADrjBPqLT7e_eV9=ykDXG7_p3j8yJTbQNAc_dXVVRDP7Vqbtag@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add syscon-reboot and syscon-poweroff support for
 gs101/Pixel 6
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
	mturquette@baylibre.com, sboyd@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 27 Jun 2024 at 11:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 26/06/2024 21:42, Peter Griffin wrote:
> > Hi Krzysztof,
> >
> > This series adds support for syscon-reboot and syscon-poweroff to gs101/Oriole.
> > It has been tested with reboot and poweroff commands respectively.
> >
> > Note the syscon-reboot/poweroff has *runtime* dependencies on the exynos-pmu
>
> How does the runtime dependency manifests? Something get broken if there
> are no dependencies? Or maybe reboot does not work, but probably it did
> not work before, either?

Without [1] but with this series applied you will get an Serror
interrupt and hang on poweroff, and reboot commands, as it will use a
mmio syscon to write the protected register.

[   74.680240][    T1] reboot: Restarting system
[   74.680322][    C0] SError Interrupt on CPU0, code
0x00000000be000011 -- SError
[   74.680329][    C0] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted
6.10.0-rc3-next-20240613-00009-g6ca503bd3c2b #476
[   74.680336][    C0] Hardware name: Oriole (DT)
[   74.680338][    C0] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
[   74.680345][    C0] pc : _raw_spin_unlock_irqrestore+0x10/0x44
[   74.680363][    C0] lr : regmap_unlock_spinlock+0x14/0x20
[   74.680373][    C0] sp : ffff80008009bb40
[   74.680375][    C0] x29: ffff80008009bb40 x28: ffff00da4587e158
x27: ffffa38d3bc74708
[   74.680386][    C0] x26: ffffa38d3d9c9ca8 x25: 0000000000000000
x24: 0000000000000000
[   74.680394][    C0] x23: 0000000000000000 x22: 0000000000000002
x21: 0000000000000002
[   74.680400][    C0] x20: 0000000000003a00 x19: 0000000000000000
x18: ffffffffffffffff
[   74.680407][    C0] x17: 0000000000000000 x16: ffffa38d3c6cf438
x15: ffff80008009b6a0
[   74.680414][    C0] x14: 0000000000000000 x13: ffff00dbb6980000
x12: 00000000000007d4
[   74.680421][    C0] x11: 000000000000029c x10: ffff00dbb6c40000 x9
: ffff00dbb6980000
[   74.680427][    C0] x8 : ffff80008009bc28 x7 : 0000000000000000 x6
: 0000000000000000
[   74.680434][    C0] x5 : ffffa38d3b83e074 x4 : 0000000000003a00 x3
: 0000000000000000
[   74.680440][    C0] x2 : ffffa38d3b831764 x1 : ffff00da40230000 x0
: 0000000100000001
[   74.680447][    C0] Kernel panic - not syncing: Asynchronous SError Interrupt

and

[   49.448590][    T1] reboot: Power down
[   49.448747][    C0] SError Interrupt on CPU0, code
0x00000000be000011 -- SError
[..]

Without the clk-gs101 critical clock change, poweroff command will
hang, when shutting down UFS.

Without the exynos-pmu support for !atomic registers, the reboot
command won't work when the DT is present as the register write to
SYSTEM_CONFIGURATION register will fail.

[  114.525217][    T1] reboot: Restarting system
[  114.525290][    T1] tensor_sec_reg_write(): SMC failed: -22
[  115.525434][    T1] Unable to restart system
[  116.025576][    T1] Reboot failed -- System halted

For poweroff, you are correct this has not been supported on Pixel 6
so far upstream.

However `echo b > /proc/sysrq-trigger ` has worked in previous kernel
releases (it would reset the system using Watchdog). With the
syscon-reboot DT present, but without [1] this will cause a Serror and
no longer restart the system which would be a regression.

Thanks,

Peter.

[1] https://lore.kernel.org/linux-arm-kernel/20240621115544.1655458-1-peter.griffin@linaro.org/

