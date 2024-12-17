Return-Path: <linux-kernel+bounces-449523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB449F503E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F7916C7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B01F8F15;
	Tue, 17 Dec 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM+zN6hq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A661F8F08;
	Tue, 17 Dec 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450527; cv=none; b=bBCf4Kag//4qXYqvGBM3fkkdo8FsYptMmNw3h1YzQs3KDauscYVftAw9g/J1LumXJR5oEvn1kGNShUX28hxTWK+i+8wlWlsNkDzCmtdotR3TCJEBjl55vlqcTZ8koRgG99SMxQ7/aAMqj8sVkosm+tU4CMg/DLAoXG+dx7DrbEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450527; c=relaxed/simple;
	bh=xe4kc/ab86y3O3ItawHjqjvPES2DG1Z2yX0TbrmkQXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ihxRqJ3kONywv4wW05+nC8t91T8apv9ZCanY4Zv8ayjL9hk7j80bLuWQZIef6trtxUxiDIttGQPNlym+UKlYNblOu3p2V/4M57AkqqKC4Yg9P1LMR2Mfpla5mq8gtHg8NJ4EViOTNf9QSJchaRZgGT8dZpeT+YU0t9QrTT6DPbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM+zN6hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9F8C4CEE2;
	Tue, 17 Dec 2024 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734450527;
	bh=xe4kc/ab86y3O3ItawHjqjvPES2DG1Z2yX0TbrmkQXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dM+zN6hq4LXomgTbE5qFAZDjoZtqkv4U5kFrsl3AiQzerWMICmRh0WRJyxiOyRSpw
	 9sig4+XBrNQT+JIj1V9FN/30OsdsXJmHikK8LTrCeXDkRdOO+aRCYK3ldDfd5RXHC4
	 wvxlVv8DF7VOUmIiwY9S0OA4RvPkSXJkF6KBq7bQsVF6tG3Ks/Nfh2HA3eimA5nY4Q
	 YYnEGp6GMhwF3yiNOAgY12r561wSe5GNigpBwlnLpiRTNZ2vVPVwmXlg9XZIjIFaNy
	 eBmC3gX44QhV1glbSkmljjJkYMScKYTA7T1bll0eyeH+XyORlwhEfC92XUxQ2giDu7
	 1v72nvRhMW5nA==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org
In-Reply-To: <20241217113127.186736-1-rf@opensource.cirrus.com>
References: <20241217113127.186736-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cs_dsp: Avoid using a u32 as a __be32 in
 cs_dsp_mock_mem_maps.c
Message-Id: <173445052624.96598.7883079686576433166.b4-ty@kernel.org>
Date: Tue, 17 Dec 2024 15:48:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 17 Dec 2024 11:31:27 +0000, Richard Fitzgerald wrote:
> In cs_dsp_mock_xm_header_drop_from_regmap_cache() for the ADSP2 case read
> the big-endian firmware word into a dedicated __be32 variable instead of
> using the same u32 for both the big-endian and cpu-endian value.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cs_dsp: Avoid using a u32 as a __be32 in cs_dsp_mock_mem_maps.c
      commit: a5bd108d4a57d6c00372041c83e633a26fb450de

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


