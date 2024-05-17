Return-Path: <linux-kernel+bounces-182657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BFC8C8DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1571F23BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC9313DDD7;
	Fri, 17 May 2024 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDKe0KDw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B31A2C20
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715982579; cv=none; b=KnT4BU3bCuS+4Qqco8bSOVEScWgth2z4IlWPcHVvrzLO8ocez6JfGaw/eHmpgl3wMPXpxeYVaF+HXNB3oorn1CC56WRlZ7cDVAKKeLub2sHbGD/rzXKpOhr1qDTVhccOvfnl8vj0HSME/OrieYxLx3jd5KHZqT+PNAwQOS7u1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715982579; c=relaxed/simple;
	bh=Zbrn0MKa/PYHcbzGTQ3ppveIQ4yglB1gLeX55SKgPfY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A7JprMAdMSU0D1Q7qKQR3aymyRqbnYXh2yGcWau9NQtDnuAnlhXwu9U/i3Vf+ADPoNOzQ59qbGBPW4UP23MkVRK0W1l/R2I1sjA3nyPxmTN4GTG2MvhhguQiubGM05+imdZs98dhfTEvfpWSV6pARDgRJN5TdFdKzjt+QbinGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDKe0KDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130ABC2BD10;
	Fri, 17 May 2024 21:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715982578;
	bh=Zbrn0MKa/PYHcbzGTQ3ppveIQ4yglB1gLeX55SKgPfY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mDKe0KDw0F5Q/p4AAySAcPD56hq9wgTDzSo4h1heCW1t+ypTFmVQk7kgrEZV/rKd7
	 YQ1vAwr4WjlJ9hHa6xMYC/RcNWXSryHxxrM/OtXTgqUBxnd6TwgXUtWYrLcolXi4ij
	 p5sr+Olit45ANRuFqy45aFklQDqOuQg6W+oQIhbIY8cS3cyHB0uBI2O0V0bukyqYEj
	 /vgi/Fg6+xBxEhaUKHZbT6Y6hHU9InAyP+O9zY5JcTEJnzbidSYs24VOpN5IlHJEgD
	 NO9D1HrXsXQpfTMVFSFWvkeaGklmfo5kkqP9Mt3KcCxTFkxfasMfx9DCeb5nG5Bwok
	 3l7LVbTDN6Utw==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux@roeck-us.net, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20240517144703.1200995-1-rf@opensource.cirrus.com>
References: <20240517144703.1200995-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: kunit: Fix array overflow in stride() test
Message-Id: <171598257778.92588.12559383850942329483.b4-ty@kernel.org>
Date: Fri, 17 May 2024 22:49:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-f3d47

On Fri, 17 May 2024 15:47:03 +0100, Richard Fitzgerald wrote:
> Force the max_register of the test regmap to be one register longer
> than the number of test registers, to prevent an array overflow in
> the test loop.
> 
> The test defines num_reg_defaults = 6. With 6 registers and
> stride == 2 the valid register addresses would be 0, 2, 4, 6, 8, 10.
> However the loop checks attempting to access the odd address, so on
> the final register it accesses address 11, and it writes entry [11]
> of the read/written arrays.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: kunit: Fix array overflow in stride() test
      commit: 7ba822189e6060a8a2833b721d430f833bf0db43

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


