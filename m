Return-Path: <linux-kernel+bounces-427575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0719E04E7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC50AB4215D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13DA200B90;
	Mon,  2 Dec 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUVn2MdH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4401FF7A5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145039; cv=none; b=fVCauCG7GSNzCYv5Qc3iHmYelc7Qb5ShrYZtLa7Bk4ETv1IHXhAI4jns2rpZ1f1gdO6zb4nYffxd+xC28emoqKUAgMAqB/F2MBW5o4oENtWyk1Bjk02w1qKFPGqM+L9TwgN7qo8no99MxpeWfK8z7V2YUHqFO0t4/1VQ0xhE7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145039; c=relaxed/simple;
	bh=bh2KLIV2TvMOuYUUQ22PBed/Kg36wyth0awY1lKe/Aw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mEhuxcdHLBC4fyeseEjt4z6Mt3ZDnjEA6a1JORxweFI8PrGUW1rFdlMfEqX5CsrKnGOzmsl6eY0o8Rz88tfgOVQf6Rh0Uf/idxyT67CPJL8FHEHFypR60R7zPKeUs3CxNCisYG7ZZoSSpYNT2UxjAcmQVM7vVnwSYl42GrdVRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUVn2MdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318F9C4CED9;
	Mon,  2 Dec 2024 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733145039;
	bh=bh2KLIV2TvMOuYUUQ22PBed/Kg36wyth0awY1lKe/Aw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QUVn2MdH9j15mXESmv0zOTKVVUJAv4MkZSUShXx6jzhmgXRgBymQTr7ic/v8SZAzS
	 hgtn3RJNY1QxI8FS6uCVJ0PRsBiRVUekiUcnfCUElMWQ++OAQG1jWy5Ap8nLIS5iyI
	 fDm8hurgjaNcTqApcVwgw/MfCi146t/+tVzGoK0vg60/2Q94J4/lGoVnWLmiI9abPe
	 zPd8ZABD/gRgdLfa4C/yDJ4ZNpuq2gtojUx8XHTOoXXOh+dUP2A7CO433lJ56GP/S8
	 x8SHb0RbMdx/zlOgcpZCKUfG6r0M4TaSBPTS5Ob2NBbIssp2BXUB85wU5720rtL559
	 KIji5bqzkytDg==
From: Mark Brown <broonie@kernel.org>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20241127212233.330983-1-demonsingur@gmail.com>
References: <20241127212233.330983-1-demonsingur@gmail.com>
Subject: Re: [PATCH v2] regmap: detach regmap from dev on regmap_exit
Message-Id: <173314503793.36876.1286359742372249859.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 13:10:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 27 Nov 2024 23:22:31 +0200, Cosmin Tanislav wrote:
> At the end of __regmap_init(), if dev is not NULL, regmap_attach_dev()
> is called, which adds a devres reference to the regmap, to be able to
> retrieve a dev's regmap by name using dev_get_regmap().
> 
> When calling regmap_exit, the opposite does not happen, and the
> reference is kept until the dev is detached.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: detach regmap from dev on regmap_exit
      commit: 3061e170381af96d1e66799d34264e6414d428a7

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


