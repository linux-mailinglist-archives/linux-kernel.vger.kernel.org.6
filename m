Return-Path: <linux-kernel+bounces-331130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EB997A8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7277B1C273C2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7974A16B75B;
	Mon, 16 Sep 2024 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/M6sjY1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8F4D8CC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522240; cv=none; b=SaRdodavMEtyl2MKkyMhwLFUl2W0J4LEhzKhJSasdHhtes1P5B9P3EixKHEl+VUlBYpg53L1e8mZVpNwZ7FWYadKh0FPLPOi96/Z5H3NZt682Vrzv20qFix+CaZF4rOMqAyHyda45p9/KFIRW8lcbEFSNe2py+RKVG/CmHs/TH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522240; c=relaxed/simple;
	bh=3NTGL5Cin2LOXypSVr1CXsAKRF3Z9wMPuJj538dnpCc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FgoUFSo503kQqaK1su4ARNAmCweXmjiYQ66Ac08DTEkBYwD8PU4BHgu0L0I+9XMz/JAqX2Mhpew8eQQkgfkVuaXEq2lk4qME6ojEtrJ3qsH7Hw30AAL+Ly4TSgORy/yQUvze1VhZOm1Uf+F5WVNbBNbERjHR/3H9gJjVlJu6ynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/M6sjY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CE7C4CEC4;
	Mon, 16 Sep 2024 21:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726522240;
	bh=3NTGL5Cin2LOXypSVr1CXsAKRF3Z9wMPuJj538dnpCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D/M6sjY1jAkPWst5/YqvqJwSg1grIKHAkQeFCo26GQN5pFtYqu/83QpJcea42Rnno
	 SR7IhpIPz5N/rjNkv7xls+GmU3b8hogs7iSDbD7OO4e9T9SEJvBllvwxca3OTrZ9Z8
	 YFQaEKtZMalJc6LR5gdJ0JBUxyo36ACB/nVtSYPp1ADNmgKL03PpInihfoI6Lf6ctK
	 ZafwtpF3r2qy4J1uiUPkbYPT81ReETqliaCJSICJbpJtSYP91RteszDWmnBpH8QeCm
	 1D5PxAncF1nZ7izjZwuFJVx5t6Cvtni6sPyugrkDtrdrl84yiXd80QffH73fZgJCJV
	 JPol7If1CbdBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F933806644;
	Mon, 16 Sep 2024 21:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid unused block when dio write in
 LFS mode
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172652224174.3820990.5790897572991749927.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:41 +0000
References: <20240905052433epcms2p1dac78dff43776cc158bac5ae9d118160@epcms2p1>
In-Reply-To: <20240905052433epcms2p1dac78dff43776cc158bac5ae9d118160@epcms2p1>
To: Daejun Park <daejun7.park@samsung.com>
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 nayeoni.kim@samsung.com, siu.jung@samsung.com, sukka.kim@samsung.com,
 dongjin_.kim@samsung.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 05 Sep 2024 14:24:33 +0900 you wrote:
> This patch addresses the problem that when using LFS mode, unused blocks
> may occur in f2fs_map_blocks() during block allocation for dio writes.
> 
> If a new section is allocated during block allocation, it will not be
> included in the map struct by map_is_mergeable() if the LBA of the
> allocated block is not contiguous. However, the block already allocated
> in this process will remain unused due to the LFS mode.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: avoid unused block when dio write in LFS mode
    https://git.kernel.org/jaegeuk/f2fs/c/0638a3197c19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



