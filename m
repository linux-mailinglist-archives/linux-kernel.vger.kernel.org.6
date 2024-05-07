Return-Path: <linux-kernel+bounces-171637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491F8BE6B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4CF1F23009
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7A41635B6;
	Tue,  7 May 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKs3ycyt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D61607B6;
	Tue,  7 May 2024 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093914; cv=none; b=R0ExgLCgqQbeiZns+1V8Ji8Dy0lYRfx9G4mqetWjdRGoOa00ti1/6sOgWoJExaAdL2CvMoYsW0CCuQScBrUCdZ7kgJcg2PsRuEE5ygA6q65OtTaNoQS4qFWqeZN697G19fMSry6EdatIUXo+BC19afiqPqnVwV3sUx9biNH/b4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093914; c=relaxed/simple;
	bh=zjVM27MGPo89aeUz0huUA8gWCc4b0ZQ79aYH3y205pY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y0UEgxnUfyRyO6vDKVgZCKrd0648i/LDdZ1G/9/0hjk29rpJVJXmx7d59fSRGk7yEHz2lwYLTiTCcs0R99sb4knr1VxFjxkvwoIqnb1ECEkDJs+elImmYkYuPHs2t6fmRBrkj4KSXzhXCHA1fUVO4GAq7RmpxqWG9DmL7fvDSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKs3ycyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999ECC4AF18;
	Tue,  7 May 2024 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715093914;
	bh=zjVM27MGPo89aeUz0huUA8gWCc4b0ZQ79aYH3y205pY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DKs3ycyty6e3BYxm2xxitfzuMjRhiy8eWuAjSeByGojGhK0MHXiYZgwYf4qCqWsGJ
	 dX9VKQ/H16X0gOwbmB6IKXNbiepod5E0g/1hRet9gWJzfpUgQFS318APfrNXwyJbH2
	 QOcNOoQUilPOSVpRwQjZZsYz1+K93UqdV8z6mtIk1t5M78EXviHp076qE+I0zNL8ya
	 NFlQNKUsARFMvdgLRrKaXW82N5PRwjZRumy0GteZSvjk3VI9Y3v+zRZGfjS8cGGb/A
	 G/Y/j2LsuHW+wvRhrreZ0SjSz4RE+ftn343FR7aqneZ8EQ6pdtaRDGxJdSYlHX+6cO
	 OHLaQzZUwlk/A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-v1-0-356cdd152067@baylibre.com>
References: <20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-v1-0-356cdd152067@baylibre.com>
Subject: Re: [PATCH 0/2] regulator: devm_regulator_get_enable_read_voltage
 fixes
Message-Id: <171509391236.1991000.16256518379440947855.b4-ty@kernel.org>
Date: Tue, 07 May 2024 23:58:32 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 06 May 2024 10:59:14 -0500, David Lechner wrote:
> I was going to send a v3 of [1] with these changes, but v2 was partially
> applied so here they are as additional patches.
> 
> [1] https://lore.kernel.org/all/20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com/
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: devres: fix devm_regulator_get_enable_read_voltage() return
      commit: 257b2335eebf51e318db1f3b2d023512da46fa66
[2/2] hwmon: (adc128d818) simplify final return in probe
      commit: 346fe0ce1fd780038ca9e5bcb65aad54bae7c4d9

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


