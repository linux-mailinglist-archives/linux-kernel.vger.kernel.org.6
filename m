Return-Path: <linux-kernel+bounces-347235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8C598CFCB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3641C2258B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A4D1991BF;
	Wed,  2 Oct 2024 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SEWDuUzW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69D198837;
	Wed,  2 Oct 2024 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727860090; cv=none; b=hiW8oBo0J8BbObpnasB8mYXzFwoMnVrXiFhJ+e3tHwdqWXiynjY4ikvkz+CibU3Prn0buX86Ud75zdtrxd6pgh29um9P3jcU7b9jtgocawFQXLbDDrW2ZT31e2LWegNOyzeeCWFTDGjAiylCHAYXyDdh42xavrb/tTNST7HG7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727860090; c=relaxed/simple;
	bh=xDp1JK58nUfRoZvz+p7cWfD1b2oACtv8V73s3B0gqUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cfaAQAZv0iUVfhoFINK+7qElwaM5R9S2pr4tzto3BQu3xDerfEOmFNpGhRzYeNcmy4mvrAa5zpQnAMgtXiJAcdjusyljxNF7APFQHuyK15gC57i/qlgJIhbyDyJcq783fud7W+djFsqBYqMgMLL4w48AbeqTOCFhVBkgXbjqBr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SEWDuUzW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727860086;
	bh=xDp1JK58nUfRoZvz+p7cWfD1b2oACtv8V73s3B0gqUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SEWDuUzW+7Htmb1dgddN/5562jZUFZCNCMiQ/DuI3FvRdVgPfNMOiMC5EqzvuBcRT
	 aePwaJlzmowAZ2YHWDjat4qODZu56GzpfKqe12YCSnxJsgfP0Zvm+CvgX/4TB/RgdW
	 Ki9dNrly2103hLaZNAhqDP8ZNg2FGfrtunT9NwHf1HC6uJ7FqzQRR5tJ3kvLoWJdhM
	 J+zjDFiDACloN62wxDGDHDv/JZoMivxZoKUn77WNzXiLTCNUksBkCUp9gqWb01Dqpy
	 3mYI1AKhwmpCbWjxCXK2rLWVYfmzPG2dcTx+NebRME+vQc8bxFxuhw9S5YZxr6qp0l
	 YN9VOyTtIqbog==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3FC9E17E1131;
	Wed,  2 Oct 2024 11:08:06 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Roger Lu <roger.lu@mediatek.com>, 
 Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <884f0a5d-e6d3-47dc-8a9e-201bb86b271f@web.de>
References: <884f0a5d-e6d3-47dc-8a9e-201bb86b271f@web.de>
Subject: Re: [PATCH] soc: mediatek: mtk-svs: Call of_node_put(np) only once
 in svs_get_subsys_device()
Message-Id: <172786008620.33539.9448473097115032514.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:08:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 24 Sep 2024 20:08:15 +0200, Markus Elfring wrote:
> An of_node_put(np) call was immediately used after a pointer check
> for a of_find_device_by_node() call in this function implementation.
> Thus call such a function only once instead directly before the check.
> 
> This issue was transformed by using the Coccinelle software.
> 
> 
> [...]

Applied to v6.12-next/soc, thanks!

[1/1] soc: mediatek: mtk-svs: Call of_node_put(np) only once in svs_get_subsys_device()
      https://git.kernel.org/mediatek/c/1ee71494

Cheers,
Angelo



