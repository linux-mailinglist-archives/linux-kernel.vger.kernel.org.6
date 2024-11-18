Return-Path: <linux-kernel+bounces-412503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C689D09D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC003282381
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31965149C54;
	Mon, 18 Nov 2024 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF/5EPrK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8DE54652
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912621; cv=none; b=rs7kFuKJ45xL3loDqq1XBxWtKdp/AnHZ3HGNGgpd/V+d0mUuriDsxbXvA4DgBsu24xjXsgKljRawennNDUSiXhDOKRZKWO898fWBmOY9EZ+r6R+NMBJgQWw/acgododfTX9hulxUrARiqI5YpwZOwX1E1d/6CaWYdpjTpne6C3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912621; c=relaxed/simple;
	bh=IVwXcCSE2hcVKxdz54VNN72fzQvGiz/2g22lE5lSgIs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HB/AY6lJOJQ6s+mQyB1An1UzxE6t5elN9lxehD1g1xbFF1ufjl+/ME02n5G8apIWGVLSHki0I5EzZFMa2IsqN8TCOOMKrIcS+JLhLcOngN1EulKcA3fX4qKZaFwu2wLL8QSGdQreTRfZHpwOOf3dJb9k1pdpbfXiPUmlTOrgGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF/5EPrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D52C4CECF;
	Mon, 18 Nov 2024 06:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731912620;
	bh=IVwXcCSE2hcVKxdz54VNN72fzQvGiz/2g22lE5lSgIs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PF/5EPrKeWQpOcWFSFFbABVKWF9k3ksPB/CSkzjBzp20QjwNyWID88E1OProgMntx
	 s+uOwdUD3Wd7WG1fZzFUvz0yHlZX/d6I+K35ldJMUWAC5/4knLNx7To9yL4yeSYl7e
	 JfCDq3GEr33D0Txi5EZW8S6ZazzEoKSdNguj5wlK3hNWM94V7EvthiWVkZt5Z3toVj
	 y1jhX1cyVNUysQxOEA8y5O4e4jfG8u7QKKE4KftCF3RNWw0HGvxGde8jzhJRwis6Cr
	 WYlPBqX1aDnV8yWie7bVDJGVDN3wLTSsLHVI3dbZtdJrYuWM6N4PhxCjfI0Eea2Ilh
	 +fw5222iDpvhA==
Message-ID: <c1e90e9a-3b93-4caa-b28b-83a3380c8865@kernel.org>
Date: Mon, 18 Nov 2024 14:50:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Song Feng <songfeng@oppo.com>,
 Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: Re: [PATCH 1/2] f2fs: fix changing cursegs if recovery fails on zoned
 device
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20241111085058.4136077-1-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241111085058.4136077-1-shengyong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/11 16:50, Sheng Yong wrote:
> Fsync data recovery attempts to check and fix write pointer consistency
> of cursegs and all other zones. If the write pointers of cursegs are
> unaligned, cursegs are changed to new sections.
> 
> If recovery fails, zone write pointers are still checked and fixed,
> but the latest checkpoint cannot be written back. Additionally, retry-
> mount skips recovery and rolls back to reuse the old cursegs whose
> zones are already finished. This can lead to unaligned write later.
> 
> This patch addresses the issue by leaving writer pointers untouched if
> recovery fails. When retry-mount is performed, cursegs and other zones
> are checked and fixed after skipping recovery.
> 
> Signed-off-by: Song Feng <songfeng@oppo.com>
> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> ---
>   fs/f2fs/recovery.c |  2 +-
>   fs/f2fs/super.c    | 11 ++++++++---
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index e4d81b8705d1..324f948247ae 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -899,7 +899,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>   	 * and the f2fs is not read only, check and fix zoned block devices'
>   	 * write pointer consistency.
>   	 */
> -	if (f2fs_sb_has_blkzoned(sbi) && !f2fs_readonly(sbi->sb)) {
> +	if (!err && f2fs_sb_has_blkzoned(sbi) && !f2fs_readonly(sbi->sb)) {
>   		int err2 = f2fs_fix_curseg_write_pointer(sbi);
>   
>   		if (!err2)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 87ab5696bd48..42224c71ae20 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4738,13 +4738,18 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   reset_checkpoint:
>   	/*
>   	 * If the f2fs is not readonly and fsync data recovery succeeds,
> -	 * check zoned block devices' write pointer consistency.
> +	 * write pointer consistency of cursegs and other zones are already
> +	 * checked and fixed during recovery. However, if recovery fails,
> +	 * write pointers are left untouched, and retry-mount should check
> +	 * them here.
>   	 */
> -	if (f2fs_sb_has_blkzoned(sbi) && !f2fs_readonly(sb)) {
> +	if (skip_recovery && f2fs_sb_has_blkzoned(sbi) && !f2fs_readonly(sb)) {
>   		int err2;
>   
>   		f2fs_notice(sbi, "Checking entire write pointers");
> -		err2 = f2fs_check_write_pointer(sbi);
> +		err2 = f2fs_fix_curseg_write_pointer(sbi);
> +		if (!err2)
> +			err2 = f2fs_check_write_pointer(sbi);
>   		if (err2)
>   			err = err2;

What about wrapping above logic into f2fs_fix_and_check_write_pointer() and reuse in
f2fs_fill_super() and f2fs_recover_fsync_data()?

int f2fs_fix_and_check_write_pointer()
{
	int err;

	if (!f2fs_sb_has_blkzoned(sbi) || f2fs_readonly(sbi->sb))
		return 0;

	err = f2fs_fix_curseg_write_pointer(sbi);
	if (!err)
		err = f2fs_check_write_pointer(sbi);

	return err;
}

Thanks,

>   	}


