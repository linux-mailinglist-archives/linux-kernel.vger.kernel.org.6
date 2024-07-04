Return-Path: <linux-kernel+bounces-241539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F92927C5A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8BB28482E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1919D3BBE1;
	Thu,  4 Jul 2024 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj/sDUNT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41E29428
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114856; cv=none; b=hsYh/FtZ+VggPKPeSquTMcXWm3uxUIaQvJWHEYXUwjHlG1fc/cPte1fGEufQ5TSKbQh6R8Bz8JtXRzxMmaflZ+ArG5NLPcg5CNzuetK1YasEwPevPTtLgvPmuO4UHD5oCeF+NntxIeUyeStX/eFbFEzty93HNua4rYLeh89FXhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114856; c=relaxed/simple;
	bh=AZVCVtzXgu3SguLD0qkz/t/YJ3VfflMJ9hh3F4VHkkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A00JKvfVBL8f2gTdGhCPvzN3DTkUJmvM2bi/zlfhjjbxLeufqq/KPmtnElTP/pCe/rPX/ICjt/BTLVVEQVrdaJWGMfUDoD/NtyFy3uLtKXjxJ5up8TouyXtlpxaZ308nqHtkfnTmZ9q+9JpTNyWSDLtQektMoSQ5hl+2adqdbao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj/sDUNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A332C3277B;
	Thu,  4 Jul 2024 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720114855;
	bh=AZVCVtzXgu3SguLD0qkz/t/YJ3VfflMJ9hh3F4VHkkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gj/sDUNTsiqudX819V3D7fzCcQq6GFZeGHkdxwNN/+IYva3NtVxymYeIuMWGxpAgq
	 2uSkEK73vA+ysoZxio3tMR9XhPeTVlLg3DBS04ejRssG/G04aiifIo9E+ur6Z7vt5t
	 Wh0IZJWe2dYQsSdoyzbpQ9LCV5LdFqoykQVtzGcglNge0XlCFVaQLLS6mufk7jHqj8
	 8JpzxpbS4gkwWreK3QVoxTS4WzG59MQf+b2Qwgme1j3KjNa5PdFyosPaZI1uLnoJ8u
	 RvvD/nZpZEjwXW6x1gnot7e9aiMs5AnnTCIPTOA1Cenety6pS0vWNQT1jVS9JXK6Ur
	 a2vwh/28SmaaA==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz, 
 pierre-louis.bossart@linux.intel.com, 13916275206@139.com, 
 zhourui@huaqin.com, alsa-devel@alsa-project.org, i-salazar@ti.com, 
 linux-kernel@vger.kernel.org, j-chadha@ti.com, liam.r.girdwood@intel.com, 
 jaden-yue@ti.com, yung-chuan.liao@linux.intel.com, dipa@ti.com, 
 yuhsuan@google.com, henry.lo@ti.com, tiwai@suse.de, baojun.xu@ti.com, 
 soyer@irl.hu, Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com, 
 cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com, 
 savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com, jesse-ji@ti.com, 
 darren.ye@mediatek.com
In-Reply-To: <20240704094939.1824-1-shenghao-ding@ti.com>
References: <20240704094939.1824-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoc: tas2781: Set "Speaker Force Firmware Load" as
 the common kcontrol for both tas27871 and tas2563
Message-Id: <172011485009.96119.17388266064091597967.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 18:40:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 04 Jul 2024 17:49:37 +0800, Shenghao Ding wrote:
> Set "Speaker Force Firmware Load" as the common kcontrol
> for both tas27871 and tas2563 and move it into newly-created
> tasdevice_snd_controls, and keep the digital gain and analog
> gain in tas2781_snd_controls.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2781: Set "Speaker Force Firmware Load" as the common kcontrol for both tas27871 and tas2563
      commit: cabf0b0cff07bc8d6e80ab6a8f8a127a2708147b

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


