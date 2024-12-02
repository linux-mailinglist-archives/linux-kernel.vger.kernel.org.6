Return-Path: <linux-kernel+bounces-427612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C79E0373
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9908165B9C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B9F2036E5;
	Mon,  2 Dec 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5Cz5vTz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F08202F8C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733146234; cv=none; b=MMx+Kc3KUL1VSOI6j5RsuKaHYMD1MltdrFbgwOjhqQwUpYwUExw3jcssBIklR4L1VaEQBNb453qbNT2x708Nt/B7EAyI0ToKUqb+y1zmD6xeBtKVPao0QemsJ7Kb1chmsqjiCt+1lxJT+TTHMwGQ8x0cCQI8HqetElt6j0fU9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733146234; c=relaxed/simple;
	bh=3vR5uHFvq4qDWCOyJoIpnnMrm6TL3f2lZVu3BzoBUrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sob7M33RLxpjP3E4hGkGAJeAusMrLbA5WXcKZiCUXotBb/kvifMlKHA4eoT0c/HqC4J+P8MONR/lmmuV9f9rFWUfQcOM55k2ODz0HN0q7MGKBOMNHWDwSd+LwDYTlHP76Zb9foeNJO0XrAEzy4/cocjWDdCjO2yaiLeYaBgWTek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5Cz5vTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130C2C4CED1;
	Mon,  2 Dec 2024 13:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733146234;
	bh=3vR5uHFvq4qDWCOyJoIpnnMrm6TL3f2lZVu3BzoBUrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Q5Cz5vTzO1YYtpBshA0UK+uEzBl4mmFbH8Ya0FSNxo8Bh0Hzbg5XRgOBx7WaTCQ2m
	 STaFU+mwJiNscb6Xw162smzS+6Ym7tp/jcJjZks5M2akoEWiaeJb6Rk6Y6xzg+/g68
	 8raP63ub4zbBRvprViZLRtuFtXBA8Q6Nhiykc3jLf+YRfc44gShBch7Ajx5eIJhn8f
	 +JE32JQ/hQ4CmxdHzhYS0wy6G79E1dOZnFeAcyuX3DRoJ1Q8D75MRr7P8hniTqlfEp
	 SZgfbarLw5Xvr+Qan0D1qJNKRhBrIRGJLxTwGLhlhfWvFAMLBNZRY9B3rV/g8B/Ug8
	 c91NVIprv+AXA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20241121123439.4180167-1-andriy.shevchenko@linux.intel.com>
References: <20241121123439.4180167-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] regmap: cache: rbtree: use krealloc_array() to
 replace krealloc()
Message-Id: <173314623280.54131.8956355770929647705.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 13:30:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 21 Nov 2024 14:34:39 +0200, Andy Shevchenko wrote:
> Use krealloc_array() to replace krealloc() with multiplication.
> krealloc_array() has multiply overflow check, which will be safer.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: cache: rbtree: use krealloc_array() to replace krealloc()
      commit: b95cacd8d708bce5839db2767d425e20ae548fd8

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


