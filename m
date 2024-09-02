Return-Path: <linux-kernel+bounces-311644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA5A968B84
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971711F234E0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3D81A302E;
	Mon,  2 Sep 2024 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJzaS+5G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7981CB512
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293004; cv=none; b=ugYZ0NstGdt4L1H6GPWb1/VzjPTq5fczg64OZtEFmQwkB/QmkU1IXCjme67GTkPthYz7B44xypyL4IJEwtlzRSJrpeOkKML62enF8OuiMotF4veS9BNdTl3APedcqU5mZcBnsIcq1txNiVf24WrCE77DEFx+vLlcWIZ91Y3Hc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293004; c=relaxed/simple;
	bh=XP3HRphkotPwEO3wz123qDVW10XjbaPggduP/CSCYvk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kTTyyPm5REa40fD5BJcTehAswCYsfM8P3rbkkcRR6fSb3UWX2AgbFsUmJxB8dRzdN7FcWJLjvjoQCPqYuUVtEy0vKwDv3IilyqkojAyEixwFtac0kOQZlIbh0ZFDqug0zq+O+0x5WZrc2DyLCBFAOJKZ+DBn0IXQySP3rxM5n2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJzaS+5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06852C4CEC2;
	Mon,  2 Sep 2024 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725293004;
	bh=XP3HRphkotPwEO3wz123qDVW10XjbaPggduP/CSCYvk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=UJzaS+5GOfyps2WiB+3oPdLhpvvGJhaS+EbJegZ7GXYJuxHLlioGfacuP33XVZoRD
	 gKK110WqygrofiI6bWPt5YInqUP63spbbsXe7+bT5u/p7aGRuwfrYftWW6sjSHX+YY
	 PWsCghP/Idu83Wx2A9xKYwlSMq7FFtksr82ySHA6A7Wo7CZ23EOg8XTk9PmbvVhfvX
	 HBRQPQb2Zv7G+aRXaxcAkCQTwTdsgZ/XHc9zlc+WYjvH4nEcNmcsDMLFs3CRuUqi/i
	 xGny9ncwEX+u5+0SY835l2tw60V60tvN1vtE+EkeWgxSylNnxzRYaswXoouSrurNxl
	 KhHgWgPFMmFvw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20240901-regmap-test-fast-io-v1-1-aad83a871bcc@kernel.org>
References: <20240901-regmap-test-fast-io-v1-1-aad83a871bcc@kernel.org>
Subject: Re: [PATCH] regmap: kunit: Add coverage of spinlocked regmaps
Message-Id: <172529300371.119375.5933652709246901991.b4-ty@kernel.org>
Date: Mon, 02 Sep 2024 17:03:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Sun, 01 Sep 2024 12:06:14 +0100, Mark Brown wrote:
> By default regmap uses a mutex to protect the regmap but we also support
> other kinds of locking, including spinlocks, which can have an impact
> especially around allocations. Ensure that we are covering the spinlock
> case by running tests configured using fast I/O, this causes the core to
> use a spinlock instead of a mutex. Running every single test would be
> redundant but cover most of them.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: kunit: Add coverage of spinlocked regmaps
      commit: c7edb7ac8472a57e0c56a3a95796db3af98b2383

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


