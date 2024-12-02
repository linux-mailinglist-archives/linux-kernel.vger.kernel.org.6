Return-Path: <linux-kernel+bounces-428129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA729E0A83
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2304A282DE1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054CC1DD0DC;
	Mon,  2 Dec 2024 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxz/NeTU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC761DA62E;
	Mon,  2 Dec 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733162299; cv=none; b=k2VZtI7xFdxNovuS57OviK+Z3kijLIB1LMOmfpEOPBFkwjiyXLg/U5E2WSKE41xcBxaWm+pI2+hQlG5WIPShlQH7v87E+agy3lZJnIfv1LclIt8LAD4FowGg7SsQ1q6x+IEt+KRIpwShvdnh+Sse+QnM6Oi2sB1cMjYrs9XT/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733162299; c=relaxed/simple;
	bh=bJXHhv1125KrcH8q0sNs+ESdxa4r7njPfil1NuS7//A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=th6tIkLH1Pa+xn5GRPs+TPOalqx8zVNsCEffBfYlwIWGKvq4WYtyuXkJFo1QusDIEMfc4tGVuphH6eb0TXwbi9enJbfyQyX9whoXkX9d4hrdH0jqNAdlDHPQ0EEuE1Ffjh22I+9VBfUqAxNtgOomllIQ762Mqpf7hPyd0RdR8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxz/NeTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD91C4CED1;
	Mon,  2 Dec 2024 17:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733162299;
	bh=bJXHhv1125KrcH8q0sNs+ESdxa4r7njPfil1NuS7//A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dxz/NeTUoIAnlz4vAj6C9KKzvQtSbUU6WtoHAu8iLkZlmOnxVaXaFYG1rhiMeqzDz
	 rZDgv5XsmDpZZRowHBN1zLxUYkeddWh7TNZXK+PlceuAXTWSo7X1gOawVhIFOn1RKP
	 X1gVSeEK/YgT/+3I6O65NQcMq+vtnsEPiSEjN/sUbXgT+sRxK+lBHFt2mGsRwkxEdO
	 J6F8P+i4Kt7YpEKQsbdHAbcF2fT7ID+Lq2TrxINt5Aq9OaMC5AhQgGIaUQD90q3stV
	 Y4qu7OYXEOBr9Se06hMfLiLdyhQ0+/5m/Wkf4UCLiRsNdAjHLRssmh5PXDELgRl2DQ
	 Ea3QEzsPTnsIw==
From: Mark Brown <broonie@kernel.org>
To: frattaroli.nicolas@gmail.com, linux-rockchip@lists.infradead.org, 
 Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, heiko@sntech.de, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241118045605.48440-1-dheeraj.linuxdev@gmail.com>
References: <20241118045605.48440-1-dheeraj.linuxdev@gmail.com>
Subject: Re: [PATCHv2,sound-next] ASoC: rockchip: i2s-tdm: Fix a useless
 call issue
Message-Id: <173316229709.189181.1009410834028591581.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 17:58:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 18 Nov 2024 10:26:05 +0530, Dheeraj Reddy Jonnalagadda wrote:
> This commit fixes a useless call issue detected by Coverity
> (CID 1507978). The call to rockchip_i2s_ch_to_io is unnecessary as its
> return value is never checked or used. As a result, the function
> definition and call is removed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s-tdm: Fix a useless call issue
      commit: 42c7af046aaf35c42ef864cbd96df025c48ce50f

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


