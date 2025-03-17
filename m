Return-Path: <linux-kernel+bounces-563842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36EA64987
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE6C3B1695
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418F0237709;
	Mon, 17 Mar 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2tJQGzU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3C32376F2;
	Mon, 17 Mar 2025 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206660; cv=none; b=ueGKsljJoKAixoO/ys+7ABlLE2G1meWha6N2rYusA70ZsMnqxfPbScDsPRWbh52e5ABQ/Aq8sXKquXNPAy5QYUzjpxfCLXN/4760f504DT9RIt7vPif0XLhdvvR3Dd+/O/+S9OUDvfigLUbI9Cn1Uk6d2ReUyltCe0XaZL0pyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206660; c=relaxed/simple;
	bh=bwKQ0YQztMRDheI94HLUvTz9S/mfYmX/R7XfNzR5Kug=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o4eIYuEwt4E45kmNPA1i2z54yls1qVdKZqFQyf9o6TdgMZqKaaf+OoK16t37PYXLLQ9Yn6SXFp7yWgKZ6bH8u+Lx5I7A0F56XlYATL/AOG/Ipv0o5PYOinDFZcWT7QcPeX00XQ5ldZagiSsxWz8M6HTa4KcWW8blXIv4/I2QWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2tJQGzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E022C4CEF1;
	Mon, 17 Mar 2025 10:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742206660;
	bh=bwKQ0YQztMRDheI94HLUvTz9S/mfYmX/R7XfNzR5Kug=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J2tJQGzUlheR+UrMDyjykw+Jn0j4dQX8815/7rxigWDyS9LzBrYokTrIq1flUVRv3
	 Hwdg9f75QG9whKNq/+T2VD9Tsgh/pDDuIbjCJAqzy7UUhw7vCLCaDBSOFaVZ9XVmyn
	 xbtSpbX8fkssIZXrZ9MolSMMZpgxeJ1vbXznB4ZLVoWUrnZ2h9Ov++9zd2n89ZQg3Z
	 Yno02gNJMF/QX8n3xU4TltjT63shMcAV5F5BpCqHnJk4nVN6I6XdqDdxopjyhF/Pea
	 1zwmNAfNYCr3fAgM20Y652FeiEgMyXgEGfcS3SOYazi1RbbDxFtRV2FVc+n/XxqjWJ
	 AmuUgncn2Qxhg==
From: Mark Brown <broonie@kernel.org>
To: shenghao-ding@ti.com, kevin-lu@ti.com, baojun.xu@ti.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Chen Ni <nichen@iscas.ac.cn>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250312034337.1235378-1-nichen@iscas.ac.cn>
References: <20250312034337.1235378-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: tlv320adc3xxx: remove unnecessary NULL check
 before clk_disable_unprepare()
Message-Id: <174220665808.86423.9971467637338719920.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 10:17:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 12 Mar 2025 11:43:37 +0800, Chen Ni wrote:
> clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
> Remove unneeded NULL check for adc3xxx->mclk here.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adc3xxx: remove unnecessary NULL check before clk_disable_unprepare()
      commit: 9aa499f28ef8aeda82556dd204bc42dc96e2f1e4

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


