Return-Path: <linux-kernel+bounces-449896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414149F5786
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F1116D98C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BEA1F9413;
	Tue, 17 Dec 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJUdjVEZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF751F8EEF;
	Tue, 17 Dec 2024 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466698; cv=none; b=VU0T6vX1aZR1IiSbZmZ8TpRM/tCxz0mL0n5b10QAmIkUZT1NqQWL9BuWUwWy+IDemW15cR6vT6UB1MH/bxwc4/MYjjb++tgRT6ibjJihvDI2FLj7WyR1VECIbJa9TCXDDJdOCUlqPGN/aaDz80WRXUK2+xvdR7IIBjiVp6JMxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466698; c=relaxed/simple;
	bh=WqBSFi5dlx+V6nrhrCvfQCAjauoEpLpIzfVp6evH3Lo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=I+/MiJFrkcgp6dzBDPhy+gcLR/rfQ73nQNrlsiu89an0FNj4+r8ztH1y5mfgzydPBS7T+1W2EZWhpw4IQh+tW5i4kNHd1hbVhQHpV5Bg6C4K8qiSuFagxOE7CqY2wtTbamH0DGVYlRozyW6pB6kTMrTq9q2XVyL1mcVIKDDlsLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJUdjVEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95226C4CED3;
	Tue, 17 Dec 2024 20:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734466697;
	bh=WqBSFi5dlx+V6nrhrCvfQCAjauoEpLpIzfVp6evH3Lo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=JJUdjVEZSODD/Z9pjznX0/NkViuND7fcMywxRNmQVxycfudHSkkA8t7H3cHfNWtMW
	 YaKymrcWgh1HemVkyggV5Jp5Rh2JjzCBsGizhD6+TMB65OfOP929u56DaOKS6W5TBp
	 CNK5nWYNX/YpwkTpGs+DK92mr1AttJHUygOwXr2as2/lCKTleYhYouNpsxozgb/G6f
	 vs8dZjZnsHTFbIXs7Ezsg+hSJjhRXsyCxEcy2NXWQV+B/Cp34C5PgpKq3ThA5l69WC
	 2enxud4S5hdqSkIJAX/bth/Wm5yVKmgoEF6oFJGMD1AKB52cjIfA0rKVFrnotvN0eq
	 8CNjp572Xyqmw==
Message-ID: <2c0e701d9fcf69090daf8c4087c87d2a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241210083029.92620-1-bigunclemax@gmail.com>
References: <20241210083029.92620-1-bigunclemax@gmail.com>
Subject: Re: [PATCH v2] clk: thead: Fix TH1520 emmc and shdci clock rate
From: Stephen Boyd <sboyd@kernel.org>
Cc: bigunclemax@gmail.com, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Michael Turquette <mturquette@baylibre.com>, Yangtao Li <frank.li@vivo.com>, Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: bigunclemax@gmail.com
Date: Tue, 17 Dec 2024 12:18:15 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting bigunclemax@gmail.com (2024-12-10 00:30:27)
> From: Maksim Kiselev <bigunclemax@gmail.com>
>=20
> In accordance with LicheePi 4A BSP the clock that comes to emmc/sdhci
> is 198Mhz which is got through frequency division of source clock
> VIDEO PLL by 4 [1].
>=20
> But now the AP_SUBSYS driver sets the CLK EMMC SDIO to the same
> frequency as the VIDEO PLL, equal to 792 MHz. This causes emmc/sdhci
> to work 4 times slower.
>=20
> Let's fix this issue by adding fixed factor clock that divides
> VIDEO PLL by 4 for emmc/sdhci.
>=20
> Link: https://github.com/revyos/thead-kernel/blob/7563179071a314f41cdcdbf=
d8cf6e101e73707f3/drivers/clk/thead/clk-light-fm.c#L454
>=20
> Fixes: ae81b69fd2b1 ("clk: thead: Add support for T-Head TH1520 AP_SUBSYS=
 clocks")
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---

Applied to clk-fixes

