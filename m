Return-Path: <linux-kernel+bounces-559955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A2EA5FB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD203188D14A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1742D269CE5;
	Thu, 13 Mar 2025 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX1bZiBp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694D269B1C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883002; cv=none; b=SyOoe4JcWJOgzQRd7kZO37Mv+Nerc4AebAtwV0fKnHN8tmjd6I9tEfs1sD4K8qBkEAQIcW9+Wv5t/y9gA7mQ757mlhdmwvaQz4p12GN5vUnBqT48J6jWUBKAQiEqX52wiEZjBAJ5koFnIQH+ZK41cj3vzpM16UC1Vx4p2e7/U+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883002; c=relaxed/simple;
	bh=/5QGkHSFyJa5DA2sSvtJkXhuwRiWIIlBOYTheGh7mm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=amtDgNNnkYZCki3FIjKbGj7fnmU47DbULiPIz/B8eaIOzqvcx+UgOKveSpuAC3nweqhWKbJbfSb0N01RzkZ06zwxJ4pMRaCAqD4vS4lHiOHsphrNz3xH8gC3V264IeZs+PLwb3usHclRAA4dOAse6br2tntYqMqkUBSYQ6MqHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nX1bZiBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A10C4CEDD;
	Thu, 13 Mar 2025 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741883002;
	bh=/5QGkHSFyJa5DA2sSvtJkXhuwRiWIIlBOYTheGh7mm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nX1bZiBp5EFxmqJdMoijkzOJ50sU1yiMLc7ckCRqZwlQs7KGOS3qytNnMl7Bl9DJc
	 4w1UW3+8sicFBleItKVqoMKe8TF2bUo0djsSx3LZRc2R+aOEJzFNNQvHNIWSLYyeOC
	 Gu/Ur2vk6texVDYPuWunyXMna0OKuWZvIhD879CGt5d39JojKlvyqF8HucrpkC5yfp
	 lakmzpRv90ogOOtWZhSrc11PDAVlkoKH/HSQYnnUATH3RKmWvHsTkBrm3PeOEha1uQ
	 DCR+I4FEDB9ImDaP2kv8qnFZnbNDBO2nHLmPpZmEi16yv7f4iHzZN/mtROW3JZMQz6
	 0WqbvLs2hkiEQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Christian Eggers <ceggers@arri.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250313103051.32430-1-ceggers@arri.de>
References: <20250313103051.32430-1-ceggers@arri.de>
Subject: Re: (subset) [PATCH v3 0/2] regulator: fix race with probing of
 dummy regulator
Message-Id: <174188300085.450690.13914957191633099426.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 16:23:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 13 Mar 2025 11:27:37 +0100, Christian Eggers wrote:
> These two patches are already in linux-next. I made a minor adjustment
> proposed by Doug. Can they still be updated?
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[2/2] regulator: check that dummy regulator has been probed before using it
      commit: 2c7a50bec4958f1d1c84d19cde518d0e96a676fd

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


