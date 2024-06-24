Return-Path: <linux-kernel+bounces-227691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9111991558E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2F0284A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322A919F485;
	Mon, 24 Jun 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8TTt8NB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC219EEC4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250831; cv=none; b=cpeUQpMS2XfLEcbdIs7pgIuxkNLJN/sgIaRrUG5mr4aFFPSAFKpUAJrAd6GnO+z3soiNqdQDQu8/7H9QQq+PUeEO1LhTccxYH2XvXe5pOcvD7MywgfES88Zi/8LrgqGQ1zDhjEAoS/6eoDWtb2hiUiT9MWISLoX4UvJMpuDbrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250831; c=relaxed/simple;
	bh=UgjBZziCdN2Taf5eSsXXsJtqJ7kU4QpFWTH/FtVBLpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O8AtLJHInTVD0wFaNnEIgoqvtrAFGaEVenXFxoKadxW+sqhZnY5sMA6adSp/Gpxw9UwCtg/qniP06Q8pFkvAeFNA82Wj7kvFZLJpVLke1XvHrG6gkebQWrZdGb9Q4CRC4mGqOM5a5EcvRepDi90dDrbajhgHbB97ImC7P/zJ0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8TTt8NB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E1E6C4AF09;
	Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719250831;
	bh=UgjBZziCdN2Taf5eSsXXsJtqJ7kU4QpFWTH/FtVBLpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X8TTt8NB9+lbJ16LgMefXf5QzIdmNGecHO8hwaP+8t3elXmTKdtteoLgirIQfg18c
	 EzdiiZoDHp+jh6CvkhANt+NWw8UjjokUyl1/G4llWyGnTSt6H+xvI/pgWGWuXw7dqp
	 4yLum1Trx21XMUBzd8NP2hkpbFKJyu8Rw8kUe3bqqxSBkTZ+jTx1+PlIluE2XukFyp
	 krtFb64IFyu6Je63O5AkemsJ4kVFqOQ2nYjWCDPPDfOqvwcTExBqnmHVxRXUI8bjyj
	 vXSB5ADRN8entcQcFaCmVHVkVFf+1DeUiQfWWxQieGHabh1RRm+w31fEj+5DWjBI7f
	 iTHNetKJ+bDgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2A33C43616;
	Mon, 24 Jun 2024 17:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: enable atgc dynamically if conditions
 are met
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171925083092.4247.2292355325725216488.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jun 2024 17:40:30 +0000
References: <1717750830-15423-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1717750830-15423-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Hao_hao.Wang@unisoc.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 7 Jun 2024 17:00:30 +0800 you wrote:
> Now atgc can only be enabled when umounted->mounted device
> even related conditions have reached. If the device has not
> be umounted->mounted for a long time, atgc can not work.
> 
> So enable atgc dynamically when atgc_age_threshold is less than
> elapsed_time and ATGC mount option is on.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V2] f2fs: enable atgc dynamically if conditions are met
    https://git.kernel.org/jaegeuk/f2fs/c/6efc3a05e613

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



