Return-Path: <linux-kernel+bounces-439604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7D69EB19C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C2A16C9AF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC61AA1C0;
	Tue, 10 Dec 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bG07bQA1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F181A9B47;
	Tue, 10 Dec 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835754; cv=none; b=OOjKeQ6r1PKHJ6V6xb+KZPXepMX4CtlLWjiLZBuC+Tw9Kj2wOk28Mgkfttex3XXsnGo5J3GbVHvysGc6xsBf7AcisrCVk22I1QrqFGQS+cLPX/A5MuxrpVg03O025+6gs61f7NKm5IWle7GwH8aEs9HXwzgGNrfAzYOhStUTEZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835754; c=relaxed/simple;
	bh=F2vH4626vYgw40Ceayp20jPvVMqJsIKsnESbzuZjRQM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PXZSbQJ9t0bQUtZDayvqw7zgZzcPMj1/jPfjj2n6GtTrXnYH7hbrgqVqVWCZ1jvb8TGFhlgAVhIbYyC5Q04BZ9DPG9TYLYDrC7Ps+PW8LrvHTMdlkSRxBvzuFlXeNUbrAoRq5Ujt40lXjuOwhAQDt7F/VfpNj8n8omcin0q5jY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bG07bQA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7782CC4CED6;
	Tue, 10 Dec 2024 13:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835754;
	bh=F2vH4626vYgw40Ceayp20jPvVMqJsIKsnESbzuZjRQM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bG07bQA1J51c70OfLhPReyDwunegtHW/31Ge1MGXfkrhXFeiZouEHzoajnjpA45op
	 L0pvcFrMEFbTfUVvIRRu4pKJMDrWyiX8cixq9P0G2OdjqnYRSiOn+hEbLR7t5NA9zn
	 ZAjalYrSV1voRnFKk8RGun1IBGcbm87Pmbvwljs2UVnLAsadTkmS1MVFT37C28czh9
	 0rrijlF/dBc9Txj/kfqyRv1DOhB60HnkLn+jrtJC3z/VG8MzheVG7qgfu5ll4iR3No
	 mOWxDcEgim0nimzOnM6dPHVeocIY1dzXDPCLzBMBXqiGZbWru6Xq3CSGDeERdonP3w
	 D7qgzYDzMvxsg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
References: <20241205-pca9450-v1-0-aab448b74e78@nxp.com>
Subject: Re: (subset) [PATCH 0/5] regulator: pca9450: collect some
 improvement patches
Message-Id: <173383575122.36957.4079934608520923537.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:02:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 05 Dec 2024 11:51:08 -0500, Frank Li wrote:
> Add pca9452 support
> Use dev_err_probe() to simple code
> add pca9452 support in imx93-14x14 dts
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/5] regulator: pca9450: add enable_value for all bucks
      commit: 229773f90b1f886e8fd542f98b495c66e43be5ba
[2/5] regulator: pca9450: Use dev_err_probe() to simplify code
      commit: 0f5c601098bd3c9cdfea3e01aacdd9d0c4010ea7
[3/5] regulator: dt-bindings: pca9450: Add pca9452 support
      commit: 17b531c162e5dbdce9a184ccd1c730ae3f31576b
[4/5] regulator: pca9450: Add PMIC pca9452 support
      commit: 017b76fb8e5b6066f6791e7ad2387deb2c9c9a14

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


