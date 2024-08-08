Return-Path: <linux-kernel+bounces-280119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDE294C60A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859F71F267D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E17E1;
	Thu,  8 Aug 2024 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahluw+tY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792615920B;
	Thu,  8 Aug 2024 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150577; cv=none; b=gnaTgAFJXcYKlWCnM4Ay7f6TkSWleQt18SOdCZLnT3S+aSyVhKF6w+HJ4hUu9WWNvtflYOpaAksPtMeDdKWmOnmxoycoR3BMt4cewLP6SdBuhdK83XY5c2KKnMSVfu5YTQhX0d4YTV17QfimRtL813fSuKzAXjZsA+qUueElKe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150577; c=relaxed/simple;
	bh=gQskhYCKBZdV2vBrToJVCxHeRpxoUra58siSeAn2qU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tOOpc/99wHFqU7dZ08c39q007yckJeLG8K7H5SAUxQw6Pc352N8/y6lJPg6Glqoiol8gBEW86+toDz0U9Y3GJzEf6bL5P56Gq7+GRkLE4JXx25QKp04jUlN/Oz4VC8W2iumwH1o9SBuZQ8qunqnnq4uoFYn6EGly9DutKe3GTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahluw+tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736B7C32782;
	Thu,  8 Aug 2024 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723150576;
	bh=gQskhYCKBZdV2vBrToJVCxHeRpxoUra58siSeAn2qU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ahluw+tYv3l2devjutWVZeKXGZcIuB5VgXGMlqLxCix9bk5cDGID7DpAQro0YMafp
	 JQ7qJ8HLoW6eSzBGN+KqW7TfTemdkgHpzP0WStcpoBARGvwzUPYx92UcdV1cv5NPIj
	 ptK6YvYvEzfRW0M1hUhKvZtCnuzscZc1jlZNXLHkmNpK9oNZIja3kW7YhDAffyuXhc
	 0mQZjzX1xecJkWnCf5+k6jRUwKjxYlEGUTnd5oMq9EGCKO5ICPp0veE2a9lK4sW/2u
	 T7u0hiTAMAUEmDVlCjO6iLOTkIIotLrrsu0NLnLq+j3q/ywv9VJOGbNTSjJr7H+PQo
	 G6ZOdvao1yKXA==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240807142715.47077-1-simont@opensource.cirrus.com>
References: <20240807142715.47077-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Use regmap_read_bypassed() to wake the
 device
Message-Id: <172315057505.475406.7320183180625957298.b4-ty@kernel.org>
Date: Thu, 08 Aug 2024 21:56:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 07 Aug 2024 14:27:15 +0000, Simon Trimmer wrote:
> Now that regmap_read_bypassed() has been added to the kernel it is
> preferable to wake the device with a read rather than a write as the
> utility function can be called at a time before the device has been
> identified.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Use regmap_read_bypassed() to wake the device
      commit: 7063a710830a09b01734be7f4ffd23f0ef72a57e

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


