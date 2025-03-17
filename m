Return-Path: <linux-kernel+bounces-563302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C6A63CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE823A96E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA255207E0D;
	Mon, 17 Mar 2025 03:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKsdNyHo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3686B14F9D9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742181551; cv=none; b=YpF6goxbhKHj/0fAXRK1sz+va7AImQmtxhzvBV/tDq7Tzu4nkv8VwjXtMrVYQoev9yklXwG/BNW17cEyRdTPqqk9+T2+CrrSA6BdKc+wR/wl80yLcmITVNBx5WfaYXCk0KL0P1WI+PD1EHEbYzsSRkR7CZ03gpQ6hRwBy4Z/FY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742181551; c=relaxed/simple;
	bh=L0PJqC1PTugn//RGlYwlepsaqcqfuN2HtfJiHb56oCY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wwza7fr6s2of32EhWbU3qSEEecA3k4s4w9KZZO8j/BGlbACpeXhVJ41jtJPXMQCJaI9RK3SewFIPRioCbF6MO0cem3di95+V7OvEheFN8pgj8au06456/sac9IpCG0CuhWnC1klXQAfdwRqlf/enCxkLtC9cGQygQbMenZz8ID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKsdNyHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B83BC4CEDD;
	Mon, 17 Mar 2025 03:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742181550;
	bh=L0PJqC1PTugn//RGlYwlepsaqcqfuN2HtfJiHb56oCY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YKsdNyHoTbLlziSdq7r15mjUuCHat9pwbBycRj32chjsn88NnG0g64cO+h5Q272BH
	 GZ5TUjN/OX3b+go5RQFqTanGJgK6xufWk+SJtIidHCzs5C6lv7xOXwcMorFuDfKQ0a
	 cZr9sAOOXdnzZWi7hyML30zzD8j0/gyHoDKL1/OwaVaFTTk9hCUiiYo0pl6r7haffl
	 VnQWIl7KkfLMBrpYl2Ot20oITQXdSSFiYT+yeVLMJpLyY+3iWyioSlIb5Waj4g8ZIA
	 i8282XgHJ6qHlZeCMI8v0DeK/yJGaY37U3eW6XF82Eu/Pwx2GqRYqMUYRvRNfDG9u+
	 +64Fqb7mR2wVw==
Message-ID: <a6137820-5dde-4b81-a330-ad0ff42bc607@kernel.org>
Date: Mon, 17 Mar 2025 11:19:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, sj1557.seo@samsung.com, s_min.jeong@samsung.com
Subject: Re: [PATCH] f2fs: fix to avoid atomicity corruption of atomic file
To: Yeongjin Gil <youngjin.gil@samsung.com>, jaegeuk@kernel.org,
 daehojeong@google.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <CGME20250314120658epcas1p2d3ec037c294d4c907ce7fa2fe1c3aa27@epcas1p2.samsung.com>
 <20250314120651.443184-1-youngjin.gil@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250314120651.443184-1-youngjin.gil@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 20:06, Yeongjin Gil wrote:
> In the case of the following call stack for an atomic file,
> FI_DIRTY_INODE is set, but FI_ATOMIC_DIRTIED is not subsequently set.
> 
> f2fs_file_write_iter
>   f2fs_map_blocks
>     f2fs_reserve_new_blocks
>       inc_valid_block_count
>         __mark_inode_dirty(dquot)
>           f2fs_dirty_inode
> 
> If FI_ATOMIC_DIRTIED is not set, atomic file can encounter corruption
> due to a mismatch between old file size and new data.
> 
> To resolve this issue, I changed to set FI_ATOMIC_DIRTIED when
> FI_DIRTY_INODE is set. This ensures that FI_DIRTY_INODE, which was
> previously cleared by the Writeback thread during the commit atomic, is
> set and i_size is updated.

I guess we need to add a regression testcase to cover this issue.

> 
> Fixes: fccaa81de87e ("f2fs: prevent atomic file from being dirtied before commit")
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

