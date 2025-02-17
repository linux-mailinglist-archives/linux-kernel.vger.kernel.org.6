Return-Path: <linux-kernel+bounces-517733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB6AA384E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A73B0F87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504C521CA0F;
	Mon, 17 Feb 2025 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUn6I2CV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21321A44E;
	Mon, 17 Feb 2025 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799505; cv=none; b=QJ9zUcUqn3kGf9umE/LnCU/l6sCd9W9G04kmKZJIHhqsmNJz0F77y6ikv85njDKdYM04jzWduv6H3OdvP0lwsKVx13M9+kSt+d5254KawdRYq1BvoBLJejMdm9gcGdAUKEEfEbSFfTjNCnxgPWIxHvcBOvuTLScQxSH45hk7FU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799505; c=relaxed/simple;
	bh=7UVLZYO1jC9r+aq/aAikU6zNFC32kIkAJxpVjI0hht8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QDdvjADYBugxcNzBvPDSmr/dRzfwahNJyfoLCGhPZNnEZ7WB2tvreVQXsEO/f1gaTF2tFJsvGNK5qDctxyrg1F9Afn8q/z6CzwLBe+ulS51fzgNYhN8osZFzki7VyWaWWlRGtCI3QrOscxBGr2n8fh7qKT2dq2Im9l9Rct+x/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUn6I2CV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0322BC4CED1;
	Mon, 17 Feb 2025 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739799505;
	bh=7UVLZYO1jC9r+aq/aAikU6zNFC32kIkAJxpVjI0hht8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BUn6I2CVRvkGw28MzkLgGh1TCoKYB+lYFY8DhBgUjDNQgTe0yXIFe03J8KxToiNnC
	 fz3AaNM347Z5NcE19PsXMMnlIzzeFtDpOOpnlc7K2z1Halq1TF4TU32k+fwv/1Ai69
	 CP4aAvU+o6qFzZXlDZ4A4o2di9J+bAn+578j0e5/OSKrSqjGnpAnFElPES7kUocQ4Z
	 QqoSZPxYvnpiamd0nerJub03r5lJqWbzONL32NiOfw1UwWWncSfT+63+E3RtwvsYdd
	 EHjwZBWPBCOufOq3eFJqBCFsWNX5WQakpCNN3C7s1acL/7RVVaXyXc6gtxwB21XjWP
	 W35S1pcBF/72w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.orG>
In-Reply-To: <20250208-asoc-volume-limit-v1-1-b98fcf4cdbad@kernel.org>
References: <20250208-asoc-volume-limit-v1-1-b98fcf4cdbad@kernel.org>
Subject: Re: [PATCH] ASoC: ops: Enforce platform maximum on initial value
Message-Id: <173979950372.40079.2365634213946678394.b4-ty@kernel.org>
Date: Mon, 17 Feb 2025 13:38:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sat, 08 Feb 2025 00:57:22 +0000, broonie@kernel.org wrote:
> Lower the volume if it is violating the platform maximum at its initial
> value (i.e. at the time of the 'snd_soc_limit_volume' call).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ops: Enforce platform maximum on initial value
      commit: 783db6851c1821d8b983ffb12b99c279ff64f2ee

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


