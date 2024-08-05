Return-Path: <linux-kernel+bounces-275456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B753948603
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD001C21E69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E441016FF27;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZAomYw5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43014EC7D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=hNxc86doQmdi2/8OgW/v+pKnukyj3CHQjM2LVpMT7KRtONA4dakqVumqShXA4oH4Z2/zeqmf4YIXl7s2sv9HxD8ui73VkolSkWYHr1stqiytpTBETreUZPb1HwRz3ugqkSWG9ApYR+2DdsIDF3ZFHhvw9R69qx2lKDYbIUbktuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=Wh51ZHgQcyh0zd1MDxB5eTQ+FzwRqW7yMqfoRE3VMbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ImTzuNgzM1Ney1GB1ZTZ8g//3YhgSzPi0tPUjiUF8op92IfQktwUcEys1rWqCMTPVrvtZmZlW498HE03v374y2IcNziZdGwI2+69l87illx5c6WPVEETikomvpDCue8g7yyLXV1UCHv+YJ6THaJ97R/aVy49Z6HGlywYnXZasyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZAomYw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD84AC4AF11;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900651;
	bh=Wh51ZHgQcyh0zd1MDxB5eTQ+FzwRqW7yMqfoRE3VMbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CZAomYw5RPntrjFHWbtiFkfi3lM6eZ0tIoasIlqI3TLzWzel+O15SmXRmsS6cChFm
	 0gT/M6cmKYRfjOdfYWxN9amf1siP93iJvdY5h/DsIdT3+5oH9WKJrE3FHo1QnjOB89
	 yzBzOrzTRP2oFqjVzhLor79Ay01jI67L67KuVNPzsYrVUwJ8/ECe5NBUcFWwrgSWls
	 NpTPYnMOwkT9XFAdrg848FnOibkgpIhgNYrzzKxhKEVjgWWF0/sQFbJZKa6wgZei1P
	 t6n8xvXv/2ZJtWnUHtpxfEchf7K6yNgBH0r8sL0sdwN8lnO8Uc4FZ4LYTPSKccIrXM
	 H1Wf18PTad1rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6BF0D20ABC;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: fix to use per-inode maxbytes and
 cleanup
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065181.2803.9692794676706839195.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:51 +0000
References: <1721975246-32345-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1721975246-32345-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Hao_hao.Wang@unisoc.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 26 Jul 2024 14:27:26 +0800 you wrote:
> This is a supplement to commit 6d1451bf7f84 ("f2fs: fix to use per-inode maxbytes")
> for some missed cases, also cleanup redundant code in f2fs_llseek.
> 
> Cc: Chengguang Xu <cgxu519@mykernel.net>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> v2: use Macro F2FS_BLK_TO_BYTES
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V2] f2fs: fix to use per-inode maxbytes and cleanup
    https://git.kernel.org/jaegeuk/f2fs/c/a6c12809975b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



