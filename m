Return-Path: <linux-kernel+bounces-372162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777359A452C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13192284303
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB2220494D;
	Fri, 18 Oct 2024 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ejwc/pXf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C6204943;
	Fri, 18 Oct 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273423; cv=none; b=heb8TiJqp0AYBOfyjBIuP49rqx4vNrGLzRpHKDpfFJU18Z6WWwFyTOEjwwsj6XzvWx/sqevYUus8lYDB/BPSE6RIsthX55vQOCanShAK4tC0n5EIlcb8b5s+QmqVOvE8A+dpRZ4YquQjQtGACVK2BqGeVLdF47a+hT8LmmlIaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273423; c=relaxed/simple;
	bh=Z/fw3T8T2wwNYXHyhWtDi8F6gPGQBu10YlXppC24soc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ieUcQWXkzH1V2ZwGtUhIY+E4k5l6FIZgGclByo/jAlMZlDTMGwZvDaG4vpRRHxuBQBlJWYJTmFbwqXK2viJeRtlbK0JxbUt5I3vpAS3ugQEkC9a5ni67VffkylKyGAmC5VQezvkOxMrtnB9MKe3DARFe69ae61kVSbn6j/lZhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ejwc/pXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C88C4CED1;
	Fri, 18 Oct 2024 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273422;
	bh=Z/fw3T8T2wwNYXHyhWtDi8F6gPGQBu10YlXppC24soc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ejwc/pXfoSjZaHsG/0rbHfjnjjYE83JRbSuAbppuu9nFklXSnv1FKoL8BtOffTL1t
	 WWWwdObeZMji2CRB8l24u5N+Ryw2FZhK16g4UkbWLlZaFhQR/U6pjnBQL1ij0aZfRm
	 RUv+CVGATFikofnZKWhRbq/hNaX0okyUWLczLRGWLyyRki9A3moPlolqmlDpxELYym
	 IShMxZ5FYW+cAjikorEePF1czIQuSnZTzn5bYLJAiv6xOv2hFoKZgh2WYh6t3KtNTw
	 a7/QZLgrY65SIhssXm4sRKfKwscby9PFuv57g6mYaLjFHKJUOcPfRdfzJ3183Osus2
	 oN6VeT5Tj4F9w==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ilya Dudikov <ilyadud25@gmail.com>
Cc: Ilya Dudikov <ilyadud@mail.ru>, perex@perex.cz, lgirdwood@gmail.com, 
 mario.limonciello@amd.com
In-Reply-To: <20241016034038.13481-1-ilyadud25@gmail.com>
References: <20241016034038.13481-1-ilyadud25@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Fix non-functional mic on ASUS E1404FA
Message-Id: <172927342087.163659.14790159976387403830.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 18:43:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 16 Oct 2024 10:40:37 +0700, Ilya Dudikov wrote:
> ASUS Vivobook E1404FA needs a quirks-table entry for the internal microphone to function properly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Fix non-functional mic on ASUS E1404FA
      commit: b0867999e3282378a0b26a7ad200233044d31eca

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


