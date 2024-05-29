Return-Path: <linux-kernel+bounces-193991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A172D8D3523
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415591F24CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B891D167DB1;
	Wed, 29 May 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCqJWREu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C25815B12B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716980907; cv=none; b=PnXHfPRRRURm9em9gXZT+fVYqDVs7q5J9FvnGxWxxhpYAOc3NCk48F8yYM+ayzJUx+qUFZoitR5l/jwX/Pifqxj+m7EBrMA1ZRrCSNrueBsxJpr7W/4J59rwlnJkEGkaSplC5BBL25Y8apTZ6cnOrQwu2DhV/izLkDJzs1tatas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716980907; c=relaxed/simple;
	bh=uiYtrFr96kq2dxAzZmD+LOdI7e8ZIwVlk77Hc8g15bI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BZD9HjZAcmLKVB5cOp4BowJqfqVfCx8Er9BUnCNpOLpQSLX5q698avIiB8RaXSO37TeuEH+zHYgda/F1bDYlVPwbRy9ZoSbOrofRG9Ou6/KRT+9eMt25FrP2jzhAZQEaosR9PbUW2Bu01pA2gJkkVHuU8tsLlcqUyCPaOa26Uzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCqJWREu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894F4C2BD10;
	Wed, 29 May 2024 11:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716980906;
	bh=uiYtrFr96kq2dxAzZmD+LOdI7e8ZIwVlk77Hc8g15bI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cCqJWREu6mcSzKKL3On0ihOB9pmUlGmKE7XJIDd/9QkXh7VIYrEHRL5U3Ymc5VASJ
	 6F6U72UtpdqTYgLdO+LUYzXjM4guWOJwtrLJwpfI7guza2eBmJwRkSOgToloIwzZvk
	 VBu0fSq71tYlSYB+tBC1g+oc7cDKUFJsC8lFscw18NUpmPf+PpHcY0fBMH1FZaCpPd
	 zNum2E3kjKSSwu3SNAB8THyLrnJyxA4N8ab46slqIPuboIHKYcGOdhTIla7a0BQXu/
	 XErddzht/rJJk+pCo0p4FRypzEVzD2luaqX4yOnQNwFtbbdyB014cl/mYE0l/pSnRt
	 NRUhAZFdAbjIA==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jim Wylder <jwylder@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
In-Reply-To: <20240523211437.2839942-1-jwylder@google.com>
References: <20240523211437.2839942-1-jwylder@google.com>
Subject: Re: [PATCH v2] regmap-i2c: Subtract reg size from max_write
Message-Id: <171698090528.44074.267144327016649933.b4-ty@kernel.org>
Date: Wed, 29 May 2024 12:08:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-2ee9f

On Thu, 23 May 2024 16:14:36 -0500, Jim Wylder wrote:
> Currently, when an adapter defines a max_write_len quirk,
> the data will be chunked into data sizes equal to the
> max_write_len quirk value.  But the payload will be increased by
> the size of the register address before transmission.  The
> resulting value always ends up larger than the limit set
> by the quirk.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap-i2c: Subtract reg size from max_write
      commit: 611b7eb19d0a305d4de00280e4a71a1b15c507fc

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


