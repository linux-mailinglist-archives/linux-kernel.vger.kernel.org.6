Return-Path: <linux-kernel+bounces-447933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F639F38E1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E9318943CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE8206F0A;
	Mon, 16 Dec 2024 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBx6U0ow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001C203D4C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373542; cv=none; b=VTglNm4ZShuOloHacdx9cj/10972HyvetJKuM0QeAD2w+n1/oIY80L9aLh7q0mvwXYxVM7l6bWIxyKn/IOmPtmJWiMo1JEooBVLxhwTFbKUUpeB7akBZ6ELbxSOlvvcO3eCZI+j5TALbUGg/VdraVosQCh42fmdXr/2wAB6pb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373542; c=relaxed/simple;
	bh=XrIJuvltPS+n+C/8+c3LcJq/j1QDneYx4/NWiZkYYxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VI4AK/dc/Tgao5wPALpKEcZobeX+kWlcKF3i8nf+5qeLFcg8PvEKhfhmI+zdriZfJ7YQuP2gwYBL67lps5FH5wr70wNb1AoaAkSVVl4nmL8a5eVR45STYjZ7Ajo6yh73e363Oi6ehpwVTy+luMwP1EY8yhAMIJeCfevHV1sJgFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBx6U0ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3827FC4CED0;
	Mon, 16 Dec 2024 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734373541;
	bh=XrIJuvltPS+n+C/8+c3LcJq/j1QDneYx4/NWiZkYYxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QBx6U0owxeit/j20m7rwOu4OVsNa2U7qLOe6NOz9YbNwFQWD7uEqs19nC6MugKLFi
	 UCJ1m3mKzwe+EyWMycvq1RgezpYdOpAY1Y5YfpYSe+ztVLhUsxkDJqtRg3mvKcQmLi
	 B7D2omwgFKMgPSKnU9aqa66kReRzWYViuOdjySMJ60uBfRo8KyCV7XzVaZALEM9Rsi
	 wb0tCwCEEWHG1Z1m8qeacG0Kobr0hrihybTU7v8lHdjFBYslNZNu5DJYYgVU1iRyLP
	 FZ5I/0EBtKj0R0kus2EIg6oM+KTgHLtfLVUhzsMT+SQ11aKu3gAkpODDdnXgZRCntZ
	 crDuBmfRSkLeg==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241216121541.3455880-1-arnd@kernel.org>
References: <20241216121541.3455880-1-arnd@kernel.org>
Subject: Re: [PATCH] [v2] firmware: cs_dsp: avoid large local variables
Message-Id: <173437353994.179097.1773134991170792183.b4-ty@kernel.org>
Date: Mon, 16 Dec 2024 18:25:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 16 Dec 2024 13:15:35 +0100, Arnd Bergmann wrote:
> Having 1280 bytes of local variables on the stack exceeds the limit
> on 32-bit architectures:
> 
> drivers/firmware/cirrus/test/cs_dsp_test_bin.c: In function 'bin_patch_mixed_packed_unpacked_random':
> drivers/firmware/cirrus/test/cs_dsp_test_bin.c:2097:1: error: the frame size of 1784 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Use dynamic allocation for the largest two here.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: avoid large local variables
      commit: b0e4e2030b18b4e8a6820fc7c9da00e120c89338

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


