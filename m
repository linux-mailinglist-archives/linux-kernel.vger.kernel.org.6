Return-Path: <linux-kernel+bounces-267104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC105940C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7342E286447
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2356F19409A;
	Tue, 30 Jul 2024 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jyD9Wwo9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D31922C1;
	Tue, 30 Jul 2024 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329859; cv=none; b=DppodypLRRzL06VRIvB9SjfZPRqfA2KKsTj1BttCbMJrbMZ0WtvThWW9DRr9R+wBtsPdp6slNymtht/8BcTI2Q0txkOLMcmdaXWLI37YArrbMNJC7ThOiIky5VYIlQAk3yTHhnAV3c7ifDX40Pu6BsbDOaIQvCVpopbc/QkHVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329859; c=relaxed/simple;
	bh=9Eq45pApsAjGd9ob3SvORkeALA6iNVKRtX/3ghNH1tk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n5WZb2zdkvPBDu3oCYO2d38AfPBiMFS5Bf8ti6Gvqnrxvy2Z0vc5x+DRsRWg4Lg1Rokjv5JXffJ+quE+7eCehZzoXnHjizZACZUgapIDV2msNjGW7FsJlyAsHp5UJafaWqB0mv1mrueBj+f2Tp7ThGdi7TFp62egSL9GVhjal24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jyD9Wwo9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722329855;
	bh=9Eq45pApsAjGd9ob3SvORkeALA6iNVKRtX/3ghNH1tk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jyD9Wwo9AighdQk8GfBbN4SfFtXssLFmEYHBCYT6rPnOlOFDWgnkBAEBtx9eMn/dc
	 KYKqJ1qgZG7Kn+hY7PwxOQHiJSpsDrOFRQjRJKNejOTowEH81QhCCCWU8nz30Rub+l
	 5MEtiWx3WPq2zxZUuVwyBy1EtoBvFpT0bOLZ7GQ+JCpndfklVpBtiebpq6/kK0YlcF
	 +jZSliscbVVDRG9s4wudWZPsqzu0YV75Nt8f/UoAlEuwYc+skgrVqH5XqpsWMbMRnB
	 13MN9SrXfJSHiK536N+yy1kclgoeK/nYkIZszc/Fvu2DbMzdQ3zV3zcgMuMa6a8e5E
	 +HLcL6ti7qtxg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D4C0E3780BC9;
	Tue, 30 Jul 2024 08:57:34 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com, fchiby@baylibre.com, fparent@baylibre.com, 
 s.hauer@pengutronix.de, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <cover.1720331018.git.christophe.jaillet@wanadoo.fr>
References: <cover.1720331018.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 0/3] soc: mediatek: pwrap: Constify some data and
 other improvements
Message-Id: <172232985478.56643.13436869801664543083.b4-ty@collabora.com>
Date: Tue, 30 Jul 2024 10:57:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sun, 07 Jul 2024 07:47:19 +0200, Christophe JAILLET wrote:
> This series is motivated by patch 1. The 2 other patches are some
> additionnal goodies spotted while looking at the code.
> 
> Patch 1 constifies struct pmic_wrapper_type to move some data to a
> read-only section, in order to increase safety.
> 
> Patch 2 does the same for some int arrays. This helps move about 7 ko of
> data to a read-only section. Not that bad!
> 
> [...]

Applied to v6.11-next/soc, thanks!

[1/3] soc: mediatek: pwrap: Constify struct pmic_wrapper_type
      commit: ded525f8ac5db53286b0eabb679ecf7edb974eaa
[2/3] soc: mediatek: pwrap: Constify some struct int[]
      commit: 10c1ea1eaf4d107c323321e92237ba67848de291
[3/3] soc: mediatek: pwrap: Use devm_clk_bulk_get_all_enable()
      commit: 1c28c9452d521bf21dc5d2c50a47c2e43002728d

Cheers,
Angelo



