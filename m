Return-Path: <linux-kernel+bounces-563899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DC5A64A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9D63B75E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB3E2397B0;
	Mon, 17 Mar 2025 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slY+/LBE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B9233726;
	Mon, 17 Mar 2025 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207660; cv=none; b=p0x9IRTGdlGdX5iKX7wikUb5gVQoO2hPGpdcoCUuntIPdK5nmjbnJb+/bGwuWg7+r188TyHxxRVWyuq0nqHZWggzUKZEywDbcydJ7G59OQn9HdFf48p+29IZSb1wSeF6cYe+Ugk9MbkAIo+N9/vhBI/1WxyZxmskYFFnKKu8+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207660; c=relaxed/simple;
	bh=b+oXYgcOTObu47gsSeSfCRAFLAwzfFZHt/P1DAOsXKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kIBk3+BvMNbtV0huMEj3dQXh11SKZAhbKv5FW2xDhD9wzDIJowqlNfOYLakabuNm8cdiCxpe440nQbmDGY6Xx6gW/7umPDKT48bI9CvqYaY3cCWjw1te18G19c8xS3Ku6YNy7+NGtqlF6dYSE9o5w6rUj3oCTTzP3pnSHHcUwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slY+/LBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE707C4CEEF;
	Mon, 17 Mar 2025 10:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742207659;
	bh=b+oXYgcOTObu47gsSeSfCRAFLAwzfFZHt/P1DAOsXKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=slY+/LBEbQd/CD3A6vxTqvEQFA4Ey/FrdQg6vySQUk0Q2eI80IdI00hSJhtJqGS/J
	 +E77KNdVOmTXcUz+QDYr5itQ3u4N1lBcvLspvje+di5RyHB92wAnoCEPifmmMqvFES
	 sPk2oyA1JiDUQKsqqo1xlgV8NEahtuLGK4rj7acY2ps/OcwQMhz5vqm4kbxQeQBF7J
	 zYMc/YQrHGLQlZDOtBO7440q0epEdz8adUdW0YprbWQroKVpKZuuzBQ7rkHDHsu1Iy
	 L6qU8KLW+8gOcoL10c1b6BqXUbe8LExbV3RE6IZQCkWBynqFmJZs2KDheBw9CnAXSd
	 gjJUJE6eWFpIw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250314-pf9453-v5-0-ab0cf1f871b0@nxp.com>
References: <20250314-pf9453-v5-0-ab0cf1f871b0@nxp.com>
Subject: Re: [PATCH v5 0/2] regulator: add new PMIC PF9453 support
Message-Id: <174220765742.94847.4554703106567375246.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 10:34:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 14 Mar 2025 11:23:45 -0400, Frank Li wrote:
> Add binding doc and driver.
> 
> DTS part wait for
> https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: pca9450: Add nxp,pf9453 compatible string
      commit: 276c2fe14632a393c1b4d418e4fc2d9d656e1c30
[2/2] regulator: pf9453: add PMIC PF9453 support
      commit: 0959b6706325bf147f253841eea312e27a3bf013

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


