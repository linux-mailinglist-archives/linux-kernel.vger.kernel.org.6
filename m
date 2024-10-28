Return-Path: <linux-kernel+bounces-385510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8B9B380F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA7F1F221C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDF51DF75C;
	Mon, 28 Oct 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR4H32rx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8B1FF7BC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137238; cv=none; b=r2NK8S0b5dToO9IqZC1nOXQ3vm4Ttrw/E/RvhVh2w57zdfVuorD+BLE9GkVppIg19T3DmRCUmFr8QOJbKPh6bCWQLwzxlubxnXT+gcMYVhlMAZVT/haOf/A/005AGnQRgsCXKHuHToJmOSvNA5yDm0bKetnZ4aR941C8jKVzXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137238; c=relaxed/simple;
	bh=IYZJMW0PqsDnvR/T7OuWRv3s0dXr/XWCPZbw4RXqxRo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HAgUEkYFJy/W9z4aTSbYnEaLlxF8GyqnFp9K5tEOIaN3HwMA9XAdUYTKAtwXJLlGF4oIqdhxZjdRlfs/j8HUh5SJHOE2xjUATaYW9P6Z8sCcSixoge6uQrMJgp+U41tHbmF5errW2a2KQt+lrYYfWYLe5dQpdVgoEsbe3m1M00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR4H32rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EA7C4CEC3;
	Mon, 28 Oct 2024 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137237;
	bh=IYZJMW0PqsDnvR/T7OuWRv3s0dXr/XWCPZbw4RXqxRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XR4H32rxcjEjPoPeuFQAvvMMz5gyTuYrAgu/ik9SYyH22+ofCDhC69O2OQwcJkOoN
	 wnEn0d6fDFDwfnj+lsIIvP5z/iQ06/buiCAT+ZH52Hrvm+n2D1ttVIO/3lKsjHRscf
	 JinZ/qtlxP6Ii4DhTJkm3w+jf3hTFfmB4fZEjfprq8wgSUbMt4LbT0NYZsFvWo6Qt+
	 ji8SVfigolnnwRXNG/GnQNxLV8er7jITBDGnYGtvzHgRdmE5ORv3iKU2QT0EnSK9dl
	 reR+1IbPauMODCuGOIIAA9UdYo0Em3ye9BZG1RsqaIkhslP/262gvJG6v0LV76tdBR
	 o0G57wPjbTDdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C6D380AC1C;
	Mon, 28 Oct 2024 17:40:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: fix inconsistent update of
 i_blocks in release_compress_blocks and reserve_compress_blocks
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173013724524.126843.7666285909402123945.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:45 +0000
References: <20240929080011.3802327-1-hanqi@vivo.com>
In-Reply-To: <20240929080011.3802327-1-hanqi@vivo.com>
To: Qi Han <hanqi@vivo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 29 Sep 2024 02:00:10 -0600 you wrote:
> After release a file and subsequently reserve it, the FSCK flag is set
> when the file is deleted, as shown in the following backtrace:
> 
> F2FS-fs (dm-48): Inconsistent i_blocks, ino:401231, iblocks:1448, sectors:1472
> fs_rec_info_write_type+0x58/0x274
> f2fs_rec_info_write+0x1c/0x2c
> set_sbi_flag+0x74/0x98
> dec_valid_block_count+0x150/0x190
> f2fs_truncate_data_blocks_range+0x2d4/0x3cc
> f2fs_do_truncate_blocks+0x2fc/0x5f0
> f2fs_truncate_blocks+0x68/0x100
> f2fs_truncate+0x80/0x128
> f2fs_evict_inode+0x1a4/0x794
> evict+0xd4/0x280
> iput+0x238/0x284
> do_unlinkat+0x1ac/0x298
> __arm64_sys_unlinkat+0x48/0x68
> invoke_syscall+0x58/0x11c
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks
    https://git.kernel.org/jaegeuk/f2fs/c/26413ce18e85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



