Return-Path: <linux-kernel+bounces-194683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DA48D3FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224F1283DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316421C8FB8;
	Wed, 29 May 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF2THXyF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6CA16F29E;
	Wed, 29 May 2024 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717016012; cv=none; b=pIHaEe514cO8W6/8cCOUvzW9HWeHnmifWQ2FbyeiRMlsTAeM78e5zOtR4Dh7LA0E/OsTb7qVKGU+IS+9Unp44wm26alkobmWC3OZq1Jbaz7rwciPLzNTAJWL5ZVlYBwiUn5swZTMfdte++LCo/EyLpLIUgEXpOAMfjYxSkQZAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717016012; c=relaxed/simple;
	bh=JSXXu4JpE/7VNAkn8ScfasSuOVWoKy4YeGw3atPcUQ4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=VeUv84vUUsyknC22FGbzUhkGzKPlN6TbB7t1Y5iY1FWm7yrYZb/eSVOBMXyQBLgigyy7z2JrbIhchJFSIU+w2kctMyIDZ70609S3SxlYXkl7IIBcKcqtrPH/VPLZdiaHjvnWsPiE9vn3IazDJC8O29pViog7kDwe103ic8flfyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF2THXyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC39AC113CC;
	Wed, 29 May 2024 20:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717016012;
	bh=JSXXu4JpE/7VNAkn8ScfasSuOVWoKy4YeGw3atPcUQ4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=QF2THXyFYPfs9hzEyvzTQSP1sgf7zsaon8ypZGmgCMAUn1hhK7qNlafnngZqEJES3
	 FgR+dPqb/Jw9RHDPWGjNcXTveERP/uX403wHibUIvKcu8aC02yVCfpg9L/yNC4Hq3v
	 MPODVCPDr91yTbNSeaKY7z2qPG9ogTY0symVJmKrKQ/xrQYle99CTR1yLTMjxKIVWi
	 VB3rFtGeQ5JDv9cB/aKfbKLX0rOmYfa0Jj2+T2eoyV01KoW5bE9sD0KzL87uLP0Iz3
	 PTwvJdGkDkjIASyTPQk6kmpJWv+t1OdFtHPCnfRXippGKQI1BFGyQWb+OxkaSaNdKD
	 UOEtd3gj+Xxig==
Message-ID: <a8754e9c4c01d808f3774bc0dd71e3f6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240528001432.1200403-1-samuel.holland@sifive.com>
References: <20240528001432.1200403-1-samuel.holland@sifive.com>
Subject: Re: [PATCH] clk: sifive: Do not register clkdevs for PRCI clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: Samuel Holland <samuel.holland@sifive.com>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@armlinux.org.uk>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Dinh Nguyen <dinguyen@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Russell King (Oracle) <rmk+kernel@armlinux.org.uk>, Yang Li <yang.lee@linux.alibaba.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
To: Samuel Holland <samuel.holland@sifive.com>
Date: Wed, 29 May 2024 13:53:29 -0700
User-Agent: alot/0.10

Quoting Samuel Holland (2024-05-27 17:14:12)
> These clkdevs were unnecessary, because systems using this driver always
> look up clocks using the devicetree. And as Russell King points out[1],
> since the provided device name was truncated, lookups via clkdev would
> never match.
>=20
> Recently, commit 8d532528ff6a ("clkdev: report over-sized strings when
> creating clkdev entries") caused clkdev registration to fail due to the
> truncation, and this now prevents the driver from probing. Fix the
> driver by removing the clkdev registration.
>=20
> Link: https://lore.kernel.org/linux-clk/ZkfYqj+OcAxd9O2t@shell.armlinux.o=
rg.uk/ [1]
> Fixes: 30b8e27e3b58 ("clk: sifive: add a driver for the SiFive FU540 PRCI=
 IP block")
> Fixes: 8d532528ff6a ("clkdev: report over-sized strings when creating clk=
dev entries")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/linux-clk/7eda7621-0dde-4153-89e4-172e4c0=
95d01@roeck-us.net/
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---

Applied to clk-fixes

