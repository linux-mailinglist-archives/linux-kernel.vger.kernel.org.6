Return-Path: <linux-kernel+bounces-175314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808D48C1E02
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0478B21219
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69130161925;
	Fri, 10 May 2024 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsnZBe5r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3FB15E7EE;
	Fri, 10 May 2024 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322138; cv=none; b=hp4PUjExP0W6AtmWIDbU8ENsoKx4MPsqiiq0gHhCQfNd8DqNaXrpiuUBd7OyKyFFIIXPZEs9o/45JYIuhnUWqh/Ay+y2csga2bW9m+C48p3zj7Q82mXyj1SxjNZie3H7XQI73WEF2sB9Yk0NlvL7pMcJyEHc2DLXZnlPyVEx27M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322138; c=relaxed/simple;
	bh=MhaHON/bO8GCljs7kRnbCNrN0owSi5O/47qliYJBJis=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oseEXYoRuZqXYvu3NclkbEY41+zZAVX2wSPqOqJuDgglqD9dCPZY5oYdgKlypm/JjfHfs0Gnl/ruA23vyx489yO63N1xfIa/bBIGjNtfi1irFCHrww2CQlubjmktW8fdRpN5QWYQ6nbn95W0t53Gwfb7fIoI2Ct5JANQMgnF0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsnZBe5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A91C113CC;
	Fri, 10 May 2024 06:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715322138;
	bh=MhaHON/bO8GCljs7kRnbCNrN0owSi5O/47qliYJBJis=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EsnZBe5r8yPcBe/lhGEy0Y572yxp/XVeiZPBV07PlAqCIeo3CJt+8ovGdg0+x0C7J
	 L3A2zwqOdCn5A3aUHTzcjME9G97mPuEdc55K17PB+Hl4ZwGHo7RfDM8SSZai5RzleA
	 ve4VeAnpJaMjuzUGrQOaJVjVb3AZDCHegS3W36xiflt9NM9PQJkiwFnMtX6+d0mX2A
	 0KlDZ0Z+f3kcJqDceqhw+3y5FvinYkxoCfmrCQc0+lYUyIVTJfoi9LtdpCtLwWkWJQ
	 eeHc+Zixm7tvvm6QPm5K8AK8+ToQHWpG5/jjy2qMesLX76lIN0q4pZofWisJX8eu3N
	 eBZd6MKeH4EtQ==
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev
In-Reply-To: <20240509153107.438220-1-wens@kernel.org>
References: <20240509153107.438220-1-wens@kernel.org>
Subject: Re: [PATCH v6 0/2] regulator: sun20i: Add Allwinner D1 LDOs driver
Message-Id: <171532213496.2045034.2645456500780291742.b4-ty@kernel.org>
Date: Fri, 10 May 2024 07:22:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 09 May 2024 23:31:05 +0800, Chen-Yu Tsai wrote:
> This is v6 of the Allwinner D1 LDO driver series, separated by subsystem.
> I've picked up this work from Samuel.  This part contains just the
> regulator driver bits. The sunxi SRAM binding part will be sent out after
> the merge window due to a conflict in next.
> 
> Unlike what the original cover letter mentioned, it is perfectly OK to
> merge this part separately. The SRAM driver changes were already merged
> some time ago, and the SRAM bindings depend on the regulator bindings,
> not the other way around.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: Add Allwinner D1 system LDOs
      commit: 622bab1884847fcf3f9bfdf1d534fac3a5fe859f
[2/2] regulator: sun20i: Add Allwinner D1 LDOs driver
      commit: 4e70b26c873dfff317039458a6ea66314bbdce99

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


