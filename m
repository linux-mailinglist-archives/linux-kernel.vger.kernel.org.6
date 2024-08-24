Return-Path: <linux-kernel+bounces-299992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A6095DD57
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 12:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A22B215CF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 10:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F1315688E;
	Sat, 24 Aug 2024 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfqVsmxL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250B28DB3;
	Sat, 24 Aug 2024 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724494408; cv=none; b=Dsy1AmYv+raSCWTCDHCWZ7pDVOxOlrkG0xIoNhk1K0ZBnFOUQw8GiovMty3GpHgr4jnyVtaG+g8YbjLhp89X7RdP8eD8nfY2iIhdBb7/CWjqtQ1QX4TmlF1CHsg8Bqlr8M0fkKubBodmLAl1aev/2Ldv1f+Y38dePwkVZlbi6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724494408; c=relaxed/simple;
	bh=EJUbwoQj1+sKr5nSRq40MUt8payr3CejPTrHebf5UWs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n4vifoCrLef1fhtuxf2fUzcb6rKBqp0IZFX6Re6dnSdsX5IaBGH6fV93V6xOFpkhnOt5db43+S6N2PH2xMUFEGXXOB5BzynrPNV706AQj0eXibM60tB7DhS0FPqMQxbzWgqkJfDEZ7j8u3uCzif+Dy4q28Qf8HkHBGbLBoF7dcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfqVsmxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAB6C32781;
	Sat, 24 Aug 2024 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724494408;
	bh=EJUbwoQj1+sKr5nSRq40MUt8payr3CejPTrHebf5UWs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=YfqVsmxL21XxsmVv7Y6UKGavJUmwKu0lPqZzEdZkhnsmi+d2Vqdh6p18PHdnoToyF
	 D0QW5H/AjrM5ScUnwz9RCdDaS1+5Vig5mG6Fc/bkZc5WJPSx04gv7WUsmaTy5F7g0P
	 0wrTRz3DVfMsQmQvxIGLRD/803hMZmbdOiJDdpVuodFYuw9FEGBp/mCLOddw6JOSEK
	 bSyR7c+kUyN4CIjFXXBaLN0VqAmdXR+wAPnjFpGysL5nnCINSME7YChSLzqHI1hUEV
	 y6WwB3ANemGVho+Z85lDtIRcjoj+0jd0OaNv4FBan/1vgErd/4gw+ZsM3kSfEKUkHK
	 yqy1Jjy4IESsw==
From: Mark Brown <broonie@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
In-Reply-To: <20240823-dapm-graph-v1-0-989a47308c4c@bootlin.com>
References: <20240823-dapm-graph-v1-0-989a47308c4c@bootlin.com>
Subject: Re: [PATCH RESEND 0/3] ASoC: dapm-graph: add component on/off and
 route names to graph
Message-Id: <172449440543.846858.4694040837255078540.b4-ty@kernel.org>
Date: Sat, 24 Aug 2024 11:13:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 23 Aug 2024 09:45:58 +0200, Luca Ceresoli wrote:
> This small series adds some improvements to dapm-graph in order to produce
> a more correct and informative graph.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dapm-graph: remove the "ROOT" cluster
      commit: 5a98c2e5399b125231ebb4594fee5fddfb7db9fd
[2/3] ASoC: dapm-graph: visualize component On/Off bias level
      commit: 64a1e3ddab1ebaa590101b0d7d7fa5d3144da1e8
[3/3] ASoC: dapm-graph: show path name for non-static routes
      commit: a14b278a47dd4b263799214c5ae0da6506ed7692

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


