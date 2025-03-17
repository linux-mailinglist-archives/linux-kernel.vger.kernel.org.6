Return-Path: <linux-kernel+bounces-563840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DFFA64983
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EB71896ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A5211185;
	Mon, 17 Mar 2025 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQQd7VAp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA723370D;
	Mon, 17 Mar 2025 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206656; cv=none; b=dtOgVJDirD5nJETJ+oPMs0IYMOwebMfwyoeju9ysp3CMPwtYmfYeTVIgHsvRsd9gfmhalWlKTE/B3n0o1+vH2FKtMUh3aPzm9RWuT8FaaXIpGwgGkqk0yilCHfZELVbnJo58tla4SDtfI3hAJd1rDgcNaXwD8UWKsWfS5ZJNg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206656; c=relaxed/simple;
	bh=0h+XlZja1L0Hzx3E+PGSZyubLgYa+1MEZ5jOyeF2nFY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O+JXWB9OQIz7Zvs7vFswQHRxsB8up4BWxNP/XTd3+Q43uH5A22uGbrhtiqeJ8qbhkXvbco0tHZ+YD2Ej0mQzLhJlqsDsdkV1d5eY755gTcdcFC3zGnEhe0Xsdx9BJoCXnLb232FbCS/sqTr8yxBm5uZDDHgHA8TejzE4Cyz+088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQQd7VAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABBDC4CEE3;
	Mon, 17 Mar 2025 10:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742206656;
	bh=0h+XlZja1L0Hzx3E+PGSZyubLgYa+1MEZ5jOyeF2nFY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=SQQd7VAp97n+EP2wnT7EhjnjSQYMqPggqRuKwocLOXd4I5bP+xFBTTUFaPGOfE5eF
	 YwYoZrchZ/RrDX/Gxs5SvEqk8W0kzi0kaetDdptZ2bOrqdfqGl6gLcKl4BBgftL2F6
	 KjuBRH4H7ApRz69XnWSmeU7boPakb18YeLqtRQHjJF4M2m4mdjLOFfBVfXzNRB43b4
	 Cyupa7TPcaUOErZG4fU1KboYM28OAba2Dew+dunNgzt7SUI0dTsvegWtRGXg2+9x45
	 kQXyuse2Je3cDFQGLPJxgdI55b5Q3jKZfNxdprMDc5MDQgwgeacAqOXwh0A2RaUvIN
	 wkOFHAJThJiwg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 amergnat@baylibre.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Chen Ni <nichen@iscas.ac.cn>
In-Reply-To: <20250312032600.1235158-1-nichen@iscas.ac.cn>
References: <20250312032600.1235158-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: mt8365: remove unnecessary NULL check before
 clk_disable_unprepare()
Message-Id: <174220665367.86423.10873134642092088398.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 10:17:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 12 Mar 2025 11:26:00 +0800, Chen Ni wrote:
> clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
> Remove unneeded NULL check for clk here.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mt8365: remove unnecessary NULL check before clk_disable_unprepare()
      commit: f37ab219a3336ef787ce4babd20510f060f6f48d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


