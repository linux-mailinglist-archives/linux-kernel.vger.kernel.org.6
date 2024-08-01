Return-Path: <linux-kernel+bounces-271533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53174944FA6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B581F2436C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529041B3755;
	Thu,  1 Aug 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6ZUY1rX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA1C1B32DD;
	Thu,  1 Aug 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527373; cv=none; b=ild0iQV4YzCGZVMYkfPGEr1S62T45v2qOFhmSp22Vf0xIamiAADamZ+in9zQzxBrX/ByPxvU7/22G6yOqXSaZ4mwLm/uy2L6gJIn9Nhx0rldPmBGmLl98IT2SBItt8LgpJBs4hJnwwhXHN3zZqkLxtIdq4UBhYeQCB7ZurPIjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527373; c=relaxed/simple;
	bh=LNYO1qvEsmGHxLOb064EW+izbYTWcGTn/01qCf8lOlk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VPIEpI84T4+72B0taXmknm1Ink403Znv+jf/siBWl/fP08LFz7a4gXTfmgvboqK5h+u+GBrGNiIqbznNPgWxPmdakDXC0pzayYLtAjAnKOB1aEb/5jgcPcIjoIDU9GDzUBpt7tvMk433qX2XYktKecroHxudetQqa1pMgizLChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6ZUY1rX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411C1C32786;
	Thu,  1 Aug 2024 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722527373;
	bh=LNYO1qvEsmGHxLOb064EW+izbYTWcGTn/01qCf8lOlk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B6ZUY1rX0xRp9U/WsQrwUGHeCFzpHiKb+ZyGQxg+yz30ZBNCgUSgs1HS2hgqg/bMf
	 iTb+JOYZuXeXwbo8uu1ZcqlAXLhsZuDlbYa9VfIzNNqayb+m5KKbTLZGe0tfSn8pFD
	 tDvD/D+609AMYzIwQofmkaTxxt8/AQi3Za0VgK3/KsLImMl8LaVlYusa0oxYdXYXTo
	 jP3ucVVQC83vYvZlWSkNSahqhm7GRWrbwBKI6x8uXLcC5P+ZHNRbOrVw/6AKk7d5NN
	 +fEXAxypN40JkrsbeJeHeVqANit9VbL7TjmCvJ8GX1VZ2ScdDtlKFM8IZ/r9VL2Ayp
	 dGNwjEwpEYCHw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240731191312.1710417-20-robh@kernel.org>
References: <20240731191312.1710417-20-robh@kernel.org>
Subject: Re: [PATCH] ASoC: Use of_property_read_bool()
Message-Id: <172252737199.96807.15689573616506213528.b4-ty@kernel.org>
Date: Thu, 01 Aug 2024 16:49:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 31 Jul 2024 13:12:58 -0600, Rob Herring (Arm) wrote:
> Use of_property_read_bool() to read boolean properties rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Use of_property_read_bool()
      commit: 69dd15a8ef0ae494179fd15023aa8172188db6b7

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


