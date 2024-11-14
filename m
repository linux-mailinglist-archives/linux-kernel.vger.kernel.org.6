Return-Path: <linux-kernel+bounces-409927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BE19C9379
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44B0B26EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D61AC44D;
	Thu, 14 Nov 2024 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDbQGtm0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9112905;
	Thu, 14 Nov 2024 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617513; cv=none; b=rWWXS8DOjEGibM9tBe+m57B4RWoVXoikRmyziqf80nR+3RAGhwBbRUUQqUuxtFeTY+cozgHP83NFoUxrfAm3SpuA13Fc17w9JAtXGm2hrBnCry3aPKWniJpsi01l6i9zOKM4ZRACdCSLhBJilJVxmhsSuJOh/KNCfuzW2UzkBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617513; c=relaxed/simple;
	bh=hkKa0UC9NnJxDCNd5n0CnVfMEOJpPjjfOMw26wn6Vhw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=b7Jnyq6Wab6PqMolZ/lw+o4rlmfIxRVwQyv1/JLgkgrXIEVy4tvsiOtb6qDL5HSnX6R3Ton8iEiC8UCpguxoS1DI3BvTgX8p06uYv94tfRQF5/4DAPaMtN5Zxg5bYtXZ9Hng3p/zR+j72848OrcTfMF7B8hrDk1twD1KApQA0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDbQGtm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2D5C4CECD;
	Thu, 14 Nov 2024 20:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731617513;
	bh=hkKa0UC9NnJxDCNd5n0CnVfMEOJpPjjfOMw26wn6Vhw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BDbQGtm0WeAvVnAzLRV1Ix+gPEb5jGN7UcnFuLOTK/bTYCxRTehoH08ARVilP9jb3
	 ueOk7RtrmEcSd2zHCbFty/RfiGwC0+gsMsF6RykmSqLaniKWDsELecF3MuQUpgmdcJ
	 DOnWSokngHLLHbYHjqWqlK2qi/0mv9Wip2q5BC7jz0vyGis9l1ofE6/uDSDKf5HNI8
	 Uc7CSJhlihBuFpPkpOgvUbY64h+5d4KmE2dQPmm9xdb1H7J3g+RhQ8EJcsUyM1kHHX
	 Zk3uQ8bXLJayhLNGQwB2kkpqlNRQpIGdmLAxRe+7BsPEdqzcGkA678KTarXvA9MnTU
	 /aeDfKdaKFULw==
Message-ID: <6c4bdf9e5a09aa8c2c49c69a6ccdac99.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <89ad840e7a484eaf4727470824acfe0fdc60fcef.1729871146.git.christophe.jaillet@wanadoo.fr>
References: <89ad840e7a484eaf4727470824acfe0fdc60fcef.1729871146.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: mediatek: mt6735-apmixedsys: Fix an error handling path in clk_mt6735_apmixed_probe()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Yassine Oudjana <y.oudjana@protonmail.com>
Date: Thu, 14 Nov 2024 12:51:51 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Christophe JAILLET (2024-10-25 08:46:08)
> If an error occurs after a successful mtk_alloc_clk_data(),
> mtk_free_clk_data() should be called, as already done in the .remove()
> function.
>=20
> Switch to mtk_devm_alloc_clk_data() in order to fix the memory leak in the
> probe function, and simplify the remove function.
>=20
> Fixes: 43c04ed79189 ("clk: mediatek: Add drivers for MediaTek MT6735 main=
 clock and reset drivers")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next

