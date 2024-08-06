Return-Path: <linux-kernel+bounces-276734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7DB9497B2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39EB1F244B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766F87E110;
	Tue,  6 Aug 2024 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg71MR8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504876035;
	Tue,  6 Aug 2024 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969871; cv=none; b=B8BjcKEWbmNpkP0iDOPUp0TA36n8h905utHFVdeezaOrugPfz1QWtlTwVAohElFqZjxHP+7zZDGUleUyubOrC0c51XbsBPZeyOMMyYl6EF47j4y34DRsQ8J0g6WNyccGZjHZfzunsBDVdzpxnggb7UoO3ci2YyIJ0jlxjNtgqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969871; c=relaxed/simple;
	bh=6jxvk6q4X3fsFfH3j2Y1KkDUo3CAllzioPD8AKzLmuU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HAYyJMIzxjz709IP1Cjf4cIwRQNbAdgjlXsHiNPdzXuqrac61Sb3TJ0fdtXJcrlNTKCryd5SdDo4LeZJ43hjOEPhUEhARxg+Vap5iEdVj4j2gFsxBPoZaHJ6C/wHP2xxkvL4Kz1XE6fkm3b1Y8ySOBXJmo4NpdL3T0b3Wtbpow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg71MR8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C9DC4AF0C;
	Tue,  6 Aug 2024 18:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722969870;
	bh=6jxvk6q4X3fsFfH3j2Y1KkDUo3CAllzioPD8AKzLmuU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dg71MR8Wh+30wmZ7fsrDPLaCggnXaQNLUB5R0dY9WlTGNn0VmccOt1Dqb7MMnhk3r
	 UIWR5PIb+BHFa5unHl8FVKLmQFqk4CF5G3r8T8Hbxgd4mIGXkUtKO7n3JxTFsW84I4
	 0r+qYA0TdX5t/8X2cK0zW+A94bgdL0P5W2AESPHaNGwudO/7um5ah4ZBtnhOoKyn4Q
	 oLXEwjPAFvxZpWFpZcKfWLU9QyrGdo7O6JRHjziLNsnE0G7r7pmkpLgdwQB/Nz8JZQ
	 T1DRtPXZx8p8fBMeQGBSE6lGIJBsKDKz5GeVwj8Xi+y+Y8sBDNlzQ1jCSUSDhSZB/k
	 ctx5id6JltH7w==
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240805102721.30102-1-simont@opensource.cirrus.com>
References: <20240805102721.30102-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] ASoC: Extend wm_adsp so cs35l56 can suppress
 controls
Message-Id: <172296986941.432413.5644373888144309517.b4-ty@kernel.org>
Date: Tue, 06 Aug 2024 19:44:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 05 Aug 2024 10:27:19 +0000, Simon Trimmer wrote:
> This pair of patches extend wm_adsp to add a callback that can be used
> to control whether ALSA controls are added and then tweak cs35l56 to use
> it to suppress controls made from firmware coefficients.
> 
> Simon Trimmer (2):
>   ASoC: wm_adsp: Add control_add callback and export
>     wm_adsp_control_add()
>   ASoC: cs35l56: Stop creating ALSA controls for firmware coefficients
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: wm_adsp: Add control_add callback and export wm_adsp_control_add()
      commit: 45b4acab4cac79503663f0a4be9eb3752db04d4b
[2/2] ASoC: cs35l56: Stop creating ALSA controls for firmware coefficients
      commit: 2c3640b82213cf2beb7c1cc3cfce2ecf5349b0de

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


