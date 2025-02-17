Return-Path: <linux-kernel+bounces-517736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBF1A384F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0203A1608
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074B21D593;
	Mon, 17 Feb 2025 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5tUf/ts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76621D584;
	Mon, 17 Feb 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799514; cv=none; b=s4GojyTWucgOMJDB9OyItJR3Z4TBgoN+WYIcMHqRAPmwiePWy6on1vMzta12pQxBUScSWVefRxIn9yYsHJYQxGc3R+ue+elbSPPfOo2Tlf8JfCbNZW9J0mhivGc7Y5dW44r6/Mn0VX1R2DyEgUkP1Hb8u+birlzeD2qTYA956g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799514; c=relaxed/simple;
	bh=dgia5lqwp+Q9JJiZbFUjvGxWy+2g/MW/YUvSse5OZCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M+PZ071YRFeQS98kEdedCS0MG5p4tbA4dLBFibYJsldAQgutYBGYfXZ7STMYII/O9kaTOvh4aaimMbKBIthFn7pQVSJB4Q7I58EzHgv99NW3GBGqytJ7uUkwllet18cNS39s02pRWdmAn7T1RbOyY6t7NkTE4d7l37fBn5V2Ss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5tUf/ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082C1C4CED1;
	Mon, 17 Feb 2025 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739799514;
	bh=dgia5lqwp+Q9JJiZbFUjvGxWy+2g/MW/YUvSse5OZCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a5tUf/tstvf5Tf1ZiRYiALbqzqOsxf5F2rXpIxhHJ7Vlcyik9+ZGYO1W7KHPA7Wcs
	 tF0crp8PdjULhYbtA/YgQ6fWl4usU0o5jpo6IiEZId1MXyhtq46eEdMhfSRa3gSdJY
	 5DF9NMMU/GS+WxnMwEXR24L/Q9xo9xQAQbulR9R/QrW16l0Wx06WI8pOr57ikpz4l3
	 vtSplS51HrwJRurJMfUguumqTKUtdokCtB+i6+v8Rr0zClnGLXKVVKc1emWnk4e/Ak
	 jVkQWSp2hA8N2FNGQU52+zsh4b2EZUkOtHU3fFlon/0DRnSKXTLjNenO3MCPLB/RUc
	 lwXMHrIrQqZlQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250210115804.53504-3-thorsten.blum@linux.dev>
References: <20250210115804.53504-3-thorsten.blum@linux.dev>
Subject: Re: [PATCH] ASoC: wm_hubs: Use str_enable_disable() in
 wm_hubs_update_class_w()
Message-Id: <173979951278.40079.5732041981741828710.b4-ty@kernel.org>
Date: Mon, 17 Feb 2025 13:38:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 10 Feb 2025 12:58:03 +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enable_disable() helper
> function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_hubs: Use str_enable_disable() in wm_hubs_update_class_w()
      commit: 9f25b6f2568d50c247a8e3b031a0a5caee8c17d2

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


