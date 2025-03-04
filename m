Return-Path: <linux-kernel+bounces-545134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3134EA4EAE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53AE8C2960
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1527CCE3;
	Tue,  4 Mar 2025 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw1zIxZt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E51278163
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108217; cv=none; b=Ih0jvHe8lJ0GlN+XO+Qf+f6PLDbiAzi+q2erAaNp+5cgusxyCisFeCACSvV9hwy5WkNRDQXEBv9MOK/p4ZdxTeRtmJ7NbBaIdtuoEWY/ZQ/uRl7YRMXsV/OT53i0107R3C6q7EO9Ml53z4MeTdxj0mfBjlnVRgzTPHVk0R5M/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108217; c=relaxed/simple;
	bh=KNixpme328BkPpO3f08aDQkLgSB0GOMOGQFqOcWIDAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T+/i+PkEVMnco4xOSFsuqrhy5wcn6fGJPgAOPaM2mW2XGLFp6h9W7j8J422ux8bhpPNz7TskqgDMoJPFRjVwTFiKNmbXt2dpv/nVwIfCvuZLecEAsmG7lITjPg90TsQJskrwN5VE6Gn6u4L+bKsjv5J5nvxFZz3Bg7VGdqGjoCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qw1zIxZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D226BC4CEE5;
	Tue,  4 Mar 2025 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741108216;
	bh=KNixpme328BkPpO3f08aDQkLgSB0GOMOGQFqOcWIDAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qw1zIxZtOEJMdtXazA3ZGdqTbyXyiMi2doEL0xxrV8a5Dod4a7HNmfGBdxphketD6
	 aJUlfnXd1YIqUrdpvhVWBFGDMXxfPcL2Rl/UaXDCtNnw5nRg+To1ub5oShlCvGs52+
	 fL3yIrH78/XE9cl3UGiETYicfYLSyBiLHEg37+wkwT1OLpbhME47ZCYyzL5PsuHbMI
	 Zthu+cW/+Bbk6mqrGCLuIWaoEhU6AK3pFZYbQjOb/iQLyMWUzBnlJKuTHby+O5aZN1
	 1meL8OU51g7ewMpZAxVom9lvFflFGco6iaDxgQRXs7DfBtYMB9o6+TJ5g6Cn1MfBIH
	 4kwnujfb25d4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD91380AA7F;
	Tue,  4 Mar 2025 17:10:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to call f2fs_recover_quota_end()
 correctly
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174110824973.224349.3484276359744907676.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 17:10:49 +0000
References: <20250303032500.1310215-1-chao@kernel.org>
In-Reply-To: <20250303032500.1310215-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  3 Mar 2025 11:25:00 +0800 you wrote:
> f2fs_recover_quota_begin() and f2fs_recover_quota_end() should be called
> in pair, there is some cases we may skip calling f2fs_recover_quota_end(),
> fix it.
> 
> Fixes: e1bb7d3d9cbf ("f2fs: fix to recover quota data correctly")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to call f2fs_recover_quota_end() correctly
    https://git.kernel.org/jaegeuk/f2fs/c/d8f5b91d77a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



