Return-Path: <linux-kernel+bounces-271617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D529450D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F27B29269
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8B1BB687;
	Thu,  1 Aug 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VplTZmmM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040601B3F25
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530002; cv=none; b=eDERZovnWzAHAFvCyjeeSuls62j0Ci+5QFez4/gNJr3FBNUSwh+tjBO/naNtS6TwEou/+WDzxYYau15tlc4dp9AgB2AT9SWESJBC39fcvGppfJ15OVKHaci1x7CT5WfszZi+ZO2ddFYWGgYrKX6/Ky7QIXlesicxjeDA0Au/bfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530002; c=relaxed/simple;
	bh=rDcRQCzJZ2mCEZpGMXnDCcMMgmbroud4ghtR7h4PHpY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H1oGZnS16Zf1PEbWv4gMPBIdSSoB7wyEoWPq/kesMzu4yeK9Z8eJtxjkFuo0SoIfdvm7pv3a7R3O+CcttS3OuFB09Nuh8LArplLS/0P5DHZ2cYH0MRKUK56nOkVkgUnGAuGcWPgwYPW8tXUJ9FgI183tTxNsfcZ3+Md+0LL+RFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VplTZmmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF99C32786;
	Thu,  1 Aug 2024 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722530001;
	bh=rDcRQCzJZ2mCEZpGMXnDCcMMgmbroud4ghtR7h4PHpY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VplTZmmMXoqHcT0yDSxG2DfcLyqClz6aW6U2mQ/s9eEpcR4MKR5q31ej12Aj4t5sl
	 sifmdA5dpYiUjtKklRrhTSXg/XoXuyTv5Pp5Tf9/mc7TsFFRgcO8HoGdBjJthSZzD1
	 IyDH/i5XXUaBwiIie9FB++a2ejrP+wYseDBf/yjx/W5UKsSSijprp2wXinYD7EhqdO
	 4w2SIkVDe34OEiznAlx3leNG8i7JKd1zhQQg21XFguGKz3ImysdU6Ypk4sd9EyGaGw
	 lliID9itkgIRXgASjyr8dV6lDaejly7oOr59fDxNc+dnSTSAM+/VW7gNs//3o1NhWp
	 evRjuHGKSW95w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240731191312.1710417-24-robh@kernel.org>
References: <20240731191312.1710417-24-robh@kernel.org>
Subject: Re: [PATCH] regulator: Use of_property_read_bool()
Message-Id: <172253000014.113778.10106415856412035973.b4-ty@kernel.org>
Date: Thu, 01 Aug 2024 17:33:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 31 Jul 2024 13:13:02 -0600, Rob Herring (Arm) wrote:
> Use of_property_read_bool() to read boolean properties rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Use of_property_read_bool()
      commit: b03695d95213121719f05cbf6f3baa1ad3667e7f

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


