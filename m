Return-Path: <linux-kernel+bounces-536400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4A2A47F24
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E89F18918F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3EA23099F;
	Thu, 27 Feb 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f0QoHOnX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B122F38E;
	Thu, 27 Feb 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662702; cv=none; b=UfmbDMWNSYlk8B1Da6J2uIko/LT4baSymKUaPIhUFeVMekkuMHPqENvBFc4G85pvbAYRgdh2JUn/NvMaqh3uKHLyNC5llDoAK/PgbuV/L+H+DK56MVnyQehsrjLeUSjIuJWc+LG5ulbNAtox0CH5kmw25d5P/foW1rsRAr9w9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662702; c=relaxed/simple;
	bh=AJjwwKgwMjC0SHvP8uGYEB65jk8pzela6cd/RTnaqyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcrANAppk+6XIgYamA7Pw9coyq6RXiLARj/iRht5AErw9CMkOVjUNGcZZ7YtSYWjld2x6OropzxTt+uXUzQiI/iBA7ca2QKhY2i+Jj92yw5+hgrM1z+2MSU0bMEbnrCymrFzWsZ9wC2ichVCiO/t9RVYI4X4rcpnniQ94Dm8kw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f0QoHOnX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740662693;
	bh=AJjwwKgwMjC0SHvP8uGYEB65jk8pzela6cd/RTnaqyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0QoHOnX0vfIw3O2gfZkLHAuREA7zqlhfAXRUqRTnz3tMmR/P6bX01jtVhZhiSNsb
	 KTMNTR1tfU2FzIvyQqXfXlCtiViHA2xQpirTrCZasgyrGvdKZe5VP1H7H5QZcOx4HJ
	 qj4S4fh5MzByO2uVP/AZyX0b/VihXBMYEfYMfhMmGi/oSFuTszR36M2WAYkjGeWBHO
	 xddc5dHCgX1E2TaUKfH3JVOLFbsBUXNmMNbgIlNXkSpCEKvs64nGWwgq0QvrUI0Uh5
	 sXITq27v9U+ngQ2VQ4Ry3NHafY+G5CHE39/9I3E0ijvX33261CBk7246U5tf21hAWv
	 lpAppYbIn3Ijw==
Received: from notapiano (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2E41517E0880;
	Thu, 27 Feb 2025 14:24:48 +0100 (CET)
Date: Thu, 27 Feb 2025 10:24:46 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	parkeryang <Parker.Yang@mediatek.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: mt8188: avoid uninitialized variable use
Message-ID: <34a4f185-f4a8-4055-bfe6-68be9a3a7a89@notapiano>
References: <20250227131939.1040168-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227131939.1040168-1-arnd@kernel.org>

On Thu, Feb 27, 2025 at 02:19:01PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'msk' variable has no initialization:
> 
> sound/soc/mediatek/mt8188/mt8188-dai-dmic.c:311:4: error: variable 'msk' is uninitialized when used here [-Werror,-Wuninitialized]
>   311 |                         msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(i);
>       |                         ^~~
> 
> Set it to zero before the loop.
> 
> Fixes: c1e42ec04197 ("ASoC: mediatek: mt8188: Add support for DMIC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Sorry about the delay, I was about to send this myself.

Thanks,
Nícolas

