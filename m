Return-Path: <linux-kernel+bounces-175313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7CB8C1E00
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6651C20B64
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E6316089A;
	Fri, 10 May 2024 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxRZxtpz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452641527A0;
	Fri, 10 May 2024 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322135; cv=none; b=BjkTz4OuXwsqSSDc90SHMYBi29k56pd/BHHs/9vqbYZsH0RUmBSu+Rt7uxAzweY7jNbF6NXMx4Q8+UVq+Ipzfg/tuP71KY5YELoI85dKprgUonv4BV+02S4IY4gJUCTNrEOVtGgWVZUq5xcuqYDLW/y1i6aOY2OqZn+V7PnEVw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322135; c=relaxed/simple;
	bh=pYP1o6t6GkrqxYlk6IDHhBvD/erXjH2DLF744Fd+CEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MaFXwm2ZElvJesbKQ7D7mAfm+TGSwAZ3XZ+kNJiygMPXW//hddwEpOrRcp4p6uLI+Bda7iQoyFWG8MYS31CNfywN3KEgNnf1lXRVY1Owlm5Sq9sTsTY7Edx2H4qRRxacWbK62SxhATXX9yLIsIArrrMRsX9yu54uKWXC/cBmRcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxRZxtpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DFDC2BD10;
	Fri, 10 May 2024 06:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715322134;
	bh=pYP1o6t6GkrqxYlk6IDHhBvD/erXjH2DLF744Fd+CEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XxRZxtpzXlCI/UG6cZI2rLMkDiE3eTb4KIa7GVfct3EeJt5f6cXBWEI6lrv0s7fNE
	 9tKTvycV4C+s2hYUAtAv2XZb5sXi1C0N/Ye1Y0aUatSGqKWdxqLoV7LEScS8KQ3j6m
	 Pqu0uUT5t5OaxgAdQXWly/uvvUdhAnhZ1iwZFpfhT2SahOpwoeoWD8tNZoVCsLqMx6
	 ZdtFd1PALkaV2SgRwYHvx8MFXVpzhwxoFZ+0SYhGj93TGQMAUfbVzAGpYRZD4zEaxl
	 KBVc55WeQD+G4mjzQYR5JpUouB3rX4G2QKTF+X1yfSyuVe0/+0WZzAollhpJMQKQv0
	 Ul8/2LgT06cHA==
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev
In-Reply-To: <20240507041343.272569-1-wens@kernel.org>
References: <20240507041343.272569-1-wens@kernel.org>
Subject: Re: [PATCH RESEND v5 0/2] regulator: sun20i: Add Allwinner D1 LDOs
 driver
Message-Id: <171532213103.2045034.7969122177682821335.b4-ty@kernel.org>
Date: Fri, 10 May 2024 07:22:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 07 May 2024 12:13:41 +0800, Chen-Yu Tsai wrote:
> This is a resend of the Allwinner D1 LDO driver series, separated by
> subsystem. This part contains just the regulator driver bits. The sunxi
> SRAM binding part will be sent out after the merge window due to a
> conflict in next.
> 
> Original cover letter:
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


