Return-Path: <linux-kernel+bounces-427574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111B29E0381
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA27B25E9E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7361FF5F4;
	Mon,  2 Dec 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imVFJVIu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888B1FECAA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145038; cv=none; b=ZXrhMEkat2u0TRSY7CHqiu5jPw5iMNIZPVmunWSyP2ohyPicC9RogY9XTIeVfD+dHcGvAgCMJK5R6r57MFEXf05RHKCRjUQvHqg8RMw8bR3pOZxPbuSdaSOtdRG4Vmk/6vjzyV/6JaZeuBFa/Z7EeU9jm9PB77BIkJAhbNh3Sg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145038; c=relaxed/simple;
	bh=ark5Wyj+tOpqnMGUuHvLu5//hjR7kZCy2hmeUpras2k=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eKFM9h8MTEbKDtA6EPetXVegRHtYda5YV5nlmbHuZpPB5jLASRwsGjfvMRTDO6acpH1TWPgUp6ytUcVcr1EMBv9TAESupeU/O1gaZBeXKjqv3py/pQnhwePj/XzzkHCTBAVsPXW06DjqSKiDFrpQvyZPq2Xq4Go4Gy15dO5BPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imVFJVIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EEFC4CED1;
	Mon,  2 Dec 2024 13:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733145037;
	bh=ark5Wyj+tOpqnMGUuHvLu5//hjR7kZCy2hmeUpras2k=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=imVFJVIuqY8rlFLnbjhfITHpaCbNYWhNYGa7BQI6fotUKd0NF+SI70WiflZ0a5zpA
	 h1G81f2VYwHcmNlF0O4vZYJjXu+QjuEF6+apBRitjhc29OCRjjpAe06oAS/zl/2f/0
	 xKUrH4oaP4iaNLVHugghlJwScAPxfWs9eNBmCtrJqddiL5jv0Pkxw3ib911U1/TaxS
	 V0zReOuhquyeoQLvilvXLEJ75oMrpNaJYhgP+7v488Lhhef3lysxdwcW912cwtHFQo
	 0ML0qD8EwhXqKLzlGVtrG6ejU1/YaksttovvvB0BD8xJy7tnUGW/9iavet0/twNnt2
	 6OMjchQvoeE9Q==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20241127-regmap-test-high-addr-v1-1-74a48a9e0dc5@kernel.org>
References: <20241127-regmap-test-high-addr-v1-1-74a48a9e0dc5@kernel.org>
Subject: Re: [PATCH] regmap: Use correct format specifier for logging range
 errors
Message-Id: <173314503692.36876.15783400406678358793.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 13:10:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 27 Nov 2024 13:35:06 +0000, Mark Brown wrote:
> The register addresses are unsigned ints so we should use %u not %d to
> log them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Use correct format specifier for logging range errors
      commit: 3f1aa0c533d9dd8a835caf9a6824449c463ee7e2

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


