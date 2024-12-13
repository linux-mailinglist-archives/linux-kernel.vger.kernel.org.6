Return-Path: <linux-kernel+bounces-445349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115769F14E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57A2165674
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662391E766F;
	Fri, 13 Dec 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXBH/ey6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03931E8854;
	Fri, 13 Dec 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114422; cv=none; b=KLB0jZs8juJFIwGm8noth6o3TGXMTdBrlNow30vDDs43PdbNmWSoygxKiPrM9BssJocFP6/3WSZ0sZd277jfiZnf9oMIRbtkSiOzLyWRxcGeQ5l6tW5m3pWkU/7jSK3VAS8/axEogRDCSHpbxKUwvs9yCt+D9HRldDqFdwWAuq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114422; c=relaxed/simple;
	bh=7AAUZKyfh+KLhyvfagEsdYx8zOxg/y4yOyh46bXqvKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dtMGm9QBlOn+lTX0eJOWiWs0qba/uQK5TukPZbcFT+RmfaWI5bfofhbY/qZNnLU9xQHEEm8ctlUzP8NHwNUVrdsHeCyQbKH8EJGrgYKhTKf4CJoK6oGU6yIoCcQ52NZtmeFlhqAZ1KbwhdVRiBiD2d1585k3LRzFb6xHeXE+Yy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXBH/ey6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7494AC4CED0;
	Fri, 13 Dec 2024 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734114422;
	bh=7AAUZKyfh+KLhyvfagEsdYx8zOxg/y4yOyh46bXqvKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dXBH/ey6GFQy2ykbdjWUb1XVXJmvbb35Vxf9SYxxi3Sv3UYlbLixugmaLtHMsyHdF
	 b7Db8y88prTS1ccQFkHf2+P+7wErcOeaZR3IrDk5oJyFuQ1ClbRXn/+a43srOGFsFA
	 fGr6wYNDQ+JDtx7MVL+CW4ocekHu+87TZCdAnHD5G+FAlHtzoKjWTM74u/8dlq764W
	 yXC3myW/IJP3KsxWd8B4noMQFnB3Kp+kqYEWzwUOQoVpeBN9RZTLbnwEvGU65KJbZl
	 6q4gWybb/HwlYZM5jmHhXsZVWBSmYbvTSvhtribbcU1eXrXvpmJ4BQlvgkLnA8dNCH
	 dct7nL1k9jMIg==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org
In-Reply-To: <20241212143725.1381013-1-rf@opensource.cirrus.com>
References: <20241212143725.1381013-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 00/12] firmware: cirrus: Add KUnit tests for cs_dsp
Message-Id: <173411442121.280424.13197221049139843918.b4-ty@kernel.org>
Date: Fri, 13 Dec 2024 18:27:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 12 Dec 2024 14:37:13 +0000, Richard Fitzgerald wrote:
> This series adds KUnit tests for the cs_dsp module.
> 
> Most of the functionality in cs_dsp is for downloading firmware to
> DSP memory and interacting with "control" words defined in that
> memory. This doesn't require any emulation of running firmware,
> because it is only reading and writing registers. So the testing can
> be done using a dummy regmap. The way this is used to perform testing
> is described in more detail in the commit message for each test.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/12] firmware: cs_dsp: Add mock regmap for KUnit testing
        commit: d54a3fc6bf3db0db0e16cfdf7f48a8bbb803f6b0
[02/12] firmware: cs_dsp: Add mock DSP memory map for KUnit testing
        commit: 41e78c0f44f97c958afcda3f82b23f4f4a05b968
[03/12] firmware: cs_dsp: Add mock wmfw file generator for KUnit testing
        commit: 5cf1b7b471803f7cc654a29ee16cb085ad69c097
[04/12] firmware: cs_dsp: Add mock bin file generator for KUnit testing
        commit: 7c052c6615297ff32032105130cd5f02059f7ae4
[05/12] firmware: cs_dsp: Add KUnit testing of bin file download
        commit: dd0b6b1f29b92202d03a6d2dd7d65ecead27941a
[06/12] firmware: cs_dsp: Add KUnit testing of wmfw download
        commit: a2b2f2c1cd2a8b21c23bd1ec33131d2266c7568a
[07/12] firmware: cs_dsp: Add KUnit testing of control parsing
        commit: 83baecd92e7c2a44ac963fab8fd4476c71e19ddd
[08/12] firmware: cs_dsp: Add KUnit testing of control cache
        commit: 9b33a4fc500cedc1adc9c0ee01e30ffd50e5887a
[09/12] firmware: cs_dsp: Add KUnit testing of control read/write
        commit: fe54fd5474f746f07f2b587f2f5e3311bf611970
[10/12] firmware: cs_dsp: Add KUnit testing of bin error cases
        commit: cd8c058499b65e8605cd3c387bb1f76e2954870e
[11/12] firmware: cs_dsp: Add KUnit testing of wmfw error cases
        commit: feb5fb0615f321ab514f4fbbab777f3591f7e4b5
[12/12] firmware: cs_dsp: Add KUnit testing of client callbacks
        commit: 75a4a6ef615e2f4e9458051641f185498273ce02

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


