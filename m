Return-Path: <linux-kernel+bounces-545132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B79A4E972
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDC4422CF3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7466E27810B;
	Tue,  4 Mar 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpqrps70"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43012780FF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108214; cv=none; b=HltVVyo5tGwPCUo/23yJ5rvDu4NzB5YJprarjAx36jM9uA4ZcA1uQyZBvBKGpYwRJts1WVcqnsOcjqoqBP8Dn0pHKRvI95vWYi4u3oofT/x7cvaubDye5/aoAI6U8Nfumz/HhpB0YdN3W0lrvd5dloVUe05UMDVzHfpvDDSQSw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108214; c=relaxed/simple;
	bh=Jvj0r6ocwpbb8Xn0h34e4Fs/vyBMhR9edCgsHUHR8/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D/octEhICYvCnd+sK1N5bp17KT0vc/GHE6QjgbOxzpVtDFLvprjDl3OFfSTBO4R4o7v7nQPshofB5Kk0QO94/cFW5GLjK1W9qN6bZZznbEwReqDQFTTvZsq4XegAHepTRpfEe8iahmKiKduB3flOn85h+30W2bGqO76rFAjLY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hpqrps70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E58C4CEE5;
	Tue,  4 Mar 2025 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741108214;
	bh=Jvj0r6ocwpbb8Xn0h34e4Fs/vyBMhR9edCgsHUHR8/o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hpqrps7080EncjT1pVgnXdf3wCRbxyTCbPh+OKddo9l91mEjuQOVyxPcvAm0tjcwM
	 mT4JWvLqXSdxvWzIQ5f4bOaLDAMw6/25GIooNItjg1wFys4VT8+kfm+ND2zHKACL6p
	 BV0FLnn20U2tM4NjrIpvibRgDS0EkW2nO1vskO4a8B0y4PrdfvFi3VLMetZmIOlP4w
	 xY/B6cR6dccM3vbp9Bg3kVyhg9gGbKVDUOly1bhVgbF3Oe6uD4L646t1LCyj3NRybg
	 AvAM5BkX+ihHddfqE9hgeVKbw8Eahn53tibYOV/1AKhfTVyB6VCtlgQDjmcNISjV59
	 EmK860bRWbwJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D13380AA7F;
	Tue,  4 Mar 2025 17:10:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix potential deadloop in
 prepare_compress_overwrite()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174110824699.224349.2815838938637655716.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 17:10:46 +0000
References: <20250303032329.1309786-1-chao@kernel.org>
In-Reply-To: <20250303032329.1309786-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, jprusakowski@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  3 Mar 2025 11:23:29 +0800 you wrote:
> Jan Prusakowski reported a kernel hang issue as below:
> 
> When running xfstests on linux-next kernel (6.14.0-rc3, 6.12) I
> encountered a problem in generic/475 test where fsstress process
> gets blocked in __f2fs_write_data_pages() and the test hangs.
> The options I used are:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix potential deadloop in prepare_compress_overwrite()
    https://git.kernel.org/jaegeuk/f2fs/c/3147ee567dd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



