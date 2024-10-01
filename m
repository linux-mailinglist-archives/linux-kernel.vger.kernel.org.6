Return-Path: <linux-kernel+bounces-346449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F798C4DB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CB9B24BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601121CCED5;
	Tue,  1 Oct 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1xTd1ib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13A51CCEC7;
	Tue,  1 Oct 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805195; cv=none; b=RsgMsQE9xYW/qo61/bErAkIiNNhE+JCl2p1Gd/c4obgWlO0BuVm90eP73bKiLqFFTik5rCJsscwzU5lssqgi94dMGGy/OGIIih3Kfr1ewFVZ+5kB7hen/cSCB4GtN21WkrtF5K7p2zuusJcy4BScNrhmvoo4//UJclpwg9iprJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805195; c=relaxed/simple;
	bh=HajVRT1qJkY83lZWNDbgpsphq9/WKmRFlBgKT+gdSxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ctq5eEnZSeEVWymjKEayZ/c09H4/GpusvB62du3lUdideEr4NLsptoBIIzUuWeQ54yBU7z67y8tTQfw5CAwuutMPACJQCQgm+bmprzLVnmB7x5EdArrPC6CADqqW5NjqlPapCWiaUbMVoFDtwrNaCba+GWkhFfmTjCGdVT7W2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1xTd1ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAC9C4CECD;
	Tue,  1 Oct 2024 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727805195;
	bh=HajVRT1qJkY83lZWNDbgpsphq9/WKmRFlBgKT+gdSxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o1xTd1ibw2UDEd4hQFTVfuCvVovARuC4r77wPuw1OmOWcB/k3ChWsOdEUtjcaJBTJ
	 okcRT6GSJJtpde86xpTFLfpYzLCrhJ1NR+w34vov+y57UtFLMBs3j/LlRX9t/ijg1E
	 m1EM8wxkk5qyhhkfwQsxZeJeUxxcRBU30IzCcZWpt5RUtPgi2MxhjZ/CPLE/haCnlw
	 7pNXLI4jN/WCeejBZVv50OCVtyq7DX+kb/q6HOc8S2Z3g9KRCeHU9lP8I7sv/Vma5i
	 8sCqFkG2Klr705kCoFE/uPIGKf+3yuN0FBk5seqpT+TQrTuU+emx9vSLxipbTyHwNu
	 PmJCtc+hvRNMw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com, 
 venkataprasad.potturu@amd.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240924061821.1127054-1-Vijendar.Mukunda@amd.com>
References: <20240924061821.1127054-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH V2 0/9] ASoC: amd: acp: refactor acp version
 differentiation logic
Message-Id: <172780519249.2298697.15015301099797029707.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 18:53:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 24 Sep 2024 11:48:12 +0530, Vijendar Mukunda wrote:
> Currently different logics being used in the code for acp version
> differentiation. This patch series refactors the code to use acp pci
> revision id for handling acp version specific code.
> 
> Changes since v1:
> 	- Add patch to update mach_params subsystem_rev field in
> 	  machine select logic.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: amd: acp: simplify platform conditional checks code
      commit: 839a8b18dbd2e2345a261169fb68d950a1071862
[2/9] ASoC: amd: acp: use acp_rev for platform specific conditional checks
      commit: fca471b5d094dabd65f6d8777096e9ed1df1bef7
[3/9] ASoC: amd: acp: use acp pci revision id for platform differntiation
      commit: 5dbf8a19fe5d5a4c764ba88d171b06704354296a
[4/9] ASoC: amd: acp: store acp pci rev id in platform driver private structure
      commit: 40412a298c77eaa4a22a1aa7030bcc0b2e02c618
[5/9] ASoC: amd: acp: pass acp pci revision id as platform data
      commit: 0eae2c96b49d85b31ab635b9dc6f09b09d3c54de
[6/9] ASoC: amd: acp: update mach_params subsystem_rev field
      commit: 0a374a2dd0afa7ba431fab2749197374cf95fb67
[7/9] ASoC: amd: acp: remove unused variable from acp_card_drvdata structure
      commit: 2e609185e174a9ffd462ab125085ddfcbe9e2f4d
[8/9] ASoC: amd: acp: replace adata->platform conditional check
      commit: b33d93990e3774a24575517c6fcc2167036672d1
[9/9] ASoC: amd: acp: remove unused variable from acp platform driver
      commit: 9864c8af89eb14a2e5334f8e24bb82086182e894

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


