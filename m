Return-Path: <linux-kernel+bounces-170389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3B58BD627
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AE4282CE4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF4515B10C;
	Mon,  6 May 2024 20:25:57 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3115B0ED
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027157; cv=none; b=bNDqo1Z0zQrN5MDl3zNR+ZLhY69R4Y33hk+VazVdAHBgopwP6AMeLjXpIYWDld4ipZ6Oj8hUdZFiVzelPcK68dOtYrehaTjxt5IMCwWhRKqLnEQ5gT0j4ksn5CVEYzjSG8eGwM2ZwTCCn4y6uWR/IysIyz6VAQEnJ4IsUn03aY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027157; c=relaxed/simple;
	bh=UMrrdZtYBqmbutalyxWOXF0ka0ZGZB96Gj13/saVpes=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJQh/5picdak7jTASletmAlksgC881zu9aQQohbzHJNdENzpmJb1dwkBs31d78/29WoG34Ar0HQqPdXlZ2tauXEGAlYC5C0ZoePUdKg0D59d4jo21k7CLE3TEexAfkvyH7lDY5iWZCb673iQa2s9rnqRPqh0YTEP/YJPm6QPj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id d5b513bd-0be6-11ef-abf4-005056bdd08f;
	Mon, 06 May 2024 23:25:53 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 6 May 2024 23:25:52 +0300
To: Alex Soo <yuklin.soo@starfivetech.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [RFC PATCH v3 0/7] Add Pinctrl driver for Starfive JH8100 SoC
Message-ID: <Zjk80NMmHdNTt-Wp@surfacebook.localdomain>
References: <20240503111436.113089-1-yuklin.soo@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503111436.113089-1-yuklin.soo@starfivetech.com>

Fri, May 03, 2024 at 07:14:29PM +0800, Alex Soo kirjoitti:
> Starfive JH8100 SoC consists of 4 pinctrl domains - sys_east,
> sys_west, sys_gmac, and aon. This patch series adds pinctrl
> drivers for these 4 pinctrl domains and this patch series is
> depending on the JH8100 base patch series in [1] and [2].
> The relevant dt-binding documentation for each pinctrl domain has
> been updated accordingly.

I commented one of pinctrl: prefixed patch, but it looks like the same comments
are applicable to all of them.

-- 
With Best Regards,
Andy Shevchenko



