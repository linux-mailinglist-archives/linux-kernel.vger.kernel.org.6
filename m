Return-Path: <linux-kernel+bounces-409924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB279C936F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6945F1F2150C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFAC1AC8B9;
	Thu, 14 Nov 2024 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZvkxbXq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689D21AC88A;
	Thu, 14 Nov 2024 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617413; cv=none; b=JuffaIS43twRfNotl4u0k+yA5/OwBgSBnMrjQFp5eS7Tl2azjyQ10c+6FQ0DMtLaJJMJnJI+GJp4+zwQu/6xwOEJUKz3rtGd6N8ldx0sMWVx7YR4bQwnxtPmp6l4ruGbPmWNR86RMdyB+eiPslGwmTeqQ7RI+cp2wjiXsDPc/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617413; c=relaxed/simple;
	bh=A5XgBWIZdUdUtDB4kkyFj4T2ryKyI/10WgcggqqaaF0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ax8i/FiBNGXumNFWPMsHZYGPZ1BSLkSHcsrYLpRUrdrQETrCi1GUQb8GxtKGO4cZi2Nkrrsf1GKyRLcuCW1kCBMR0EYBg2T6dDPYAfdmYao5N/iBavDY4qc6+hVEpwwq6CyCCMQEFX68DQg5GhbRgM2Tb/OIZ+katzxDm5FID/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZvkxbXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E927AC4CECD;
	Thu, 14 Nov 2024 20:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731617413;
	bh=A5XgBWIZdUdUtDB4kkyFj4T2ryKyI/10WgcggqqaaF0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mZvkxbXqHD/kpGPPy9aB47JBRg8LzC7dWteM4XYQG8lmtGpfExwJHNJmtrk0nDBQJ
	 zW0lfBpBz7spRsZvCoEo6ZwsJ6cw/ScD0DVPW0Iziury86tWaXrFIvIgTctdzIWviK
	 nVxFcORjX9pjGrDSXSUreOuPVPEEAXGQUH0RU0cUO3HnbMx+YxKTHUbQFCxDewzirN
	 Wu2XxQJp44VXpO8IKiBlS+A3stY7N9JybIgsS1D6o5P4dPWkZjfllMIGNJMiYzi9g1
	 qa5wtFAP+vnxSkNyBnB20K2wcOt2DxymkpwZJZ97u9CU+y/r8IUvDKsIvQ1jQHdeng
	 IKpFKXer7/hFQ==
Message-ID: <41ef04f7ae003aad19c534839ca902ee.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240910044024.120009-4-sergio.paracuellos@gmail.com>
References: <20240910044024.120009-1-sergio.paracuellos@gmail.com> <20240910044024.120009-4-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH 3/3] clk: ralink: mtmips: add mmc related clocks for SoCs MT7620, MT7628 and MT7688
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, tsbogend@alpha.franken.de, yangshiji66@outlook.com, linux-kernel@vger.kernel.org
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>, linux-clk@vger.kernel.org
Date: Thu, 14 Nov 2024 12:50:10 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Sergio Paracuellos (2024-09-09 21:40:24)
> Original architecture clock code from where this driver was derived did n=
ot
> include nothing related to mmc clocks. OpenWRT people started to use mtk-=
sd
> upstream driver recently and they were forced to use a dts 'fixed-clock'
> node with 48 MHz clock:
> - https://github.com/openwrt/openwrt/pull/15896
> The proper thing to do to avoid that is to add the mmc related clocks to =
the
> driver to avoid a dts with fixed clocks nodes. The minimal documentation =
in
> the mt7620 programming guide says that there is a BBP_PLL clock of 480 MHz
> derived from the 40 MHz XTAL and from there a clock divider by ten produc=
es
> the desired SDHC clock of 48 MHz for the mmc. Hence add a fixed clock 'bb=
ppll'
> and factor clock 'sdhc' ten divider child to properly set the 'mmc' perip=
heral
> clock with the desired 48 Mhz rate.
>=20
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---

Applied to clk-next

