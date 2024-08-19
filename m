Return-Path: <linux-kernel+bounces-292575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA904957164
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE621C223F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A12517C9AC;
	Mon, 19 Aug 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEgHuXls"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57417ADEE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086969; cv=none; b=IzqsiTJM+3fjznUP19ADJziNcRrhBx52cTaxfJtukDzYjyMW3s38k8fP/jyu4NifrpeG/YyHUBBikD9yQDl5wHsRvJG5EU5RPm9yC0JlfIz9AapsFUAsFnNaBsYmytQNW+gv3UxyJekDaA1JLEIlrb8XC90FCAoubrDkXEl8Da0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086969; c=relaxed/simple;
	bh=RGK40pSJ+mTnHS9+OBK58y7DvTe2glyBYJ4BRXuqIwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmxp8tlOUIdMAGJKS5RNx0r2WFi29nTJomD2IQ6a98gmFaNUertEPn8OmR/KQOO4shTzs+hDCTc++tP8shImU9HaRvjibirxE+R2+sl8pAaOTm5nkJr6BGocOUdx6TNcugG8Pevq8CClxma1fdWxur4cT1/XjJxc4VioQrOvUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEgHuXls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22E0C4AF0F;
	Mon, 19 Aug 2024 17:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724086969;
	bh=RGK40pSJ+mTnHS9+OBK58y7DvTe2glyBYJ4BRXuqIwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEgHuXlsGs3Y2THjFX0UsWUvqz8RNz4i2l5/QsdilB0Cmf0LxdskL8oNJtm1f5Uh1
	 N2sIzHzwPiQ3w/MKKxwm6HX8dtVWXKew4clHBDvMMoNGWrn2jT5M3JdHjFlWTIfVca
	 lMEVApQxXHQwJ0IrJfsE3PmT3iLGGaHjj4RZh4ElapAktgDEdDcLUNqvgsPkRjU4K/
	 YEHRS75AN+9LOhQqGXpo7ZDEcMBRtkKMqySH+LbVMa39PGWR/UtcE4rlSPKiHxhFdY
	 QXV1JGzgtASdAwAYKZE1oWh1oNuC5LwqfhcH+GhMTiefco5fSJIE3zT7VA1fetC5an
	 rSp+Q2hu03o8Q==
From: Conor Dooley <conor@kernel.org>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	inochiama@outlook.com,
	guoren@kernel.org,
	emil.renner.berthing@canonical.com,
	apatel@ventanamicro.com,
	hal.feng@starfivetech.com,
	dfustini@baylibre.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	Chen Wang <unicornxw@gmail.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH] riscv: defconfig: sophgo: enable clks for sg2042
Date: Mon, 19 Aug 2024 18:02:37 +0100
Message-ID: <20240819-calibrate-playpen-964bfa720a3b@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805023320.1287061-1-unicornxw@gmail.com>
References: <20240805023320.1287061-1-unicornxw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=320; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=D2fSyEFOWYvuTTfY4ODEdjDu6s1u6kETK7bVHrUjoo4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmHq9Y4aew8sY2Rh/nHzd+dG6qdLFWnd+wRyf6q1Zm59 VjWzWXvO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRc5GMDIt/h+cWHE74xMck cOXGwo9fnjU/f1z8Plr99GPuV5pGyi4M/+wYjWadPG5yMVWwnI1tueyKsrnBn11OKla3Bb4+s2/ /fnYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 05 Aug 2024 10:33:20 +0800, Chen Wang wrote:
> Enable clk generators for sg2042 due to many peripherals rely on
> these clocks.
> 
> 

Applied to riscv-config-for-next, thanks!

[1/1] riscv: defconfig: sophgo: enable clks for sg2042
      https://git.kernel.org/conor/c/3ccedd259cc3

Thanks,
Conor.

