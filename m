Return-Path: <linux-kernel+bounces-557874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C7A5DEF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E517ACDCE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553CD24E002;
	Wed, 12 Mar 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ6JJ8ih"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF6724635E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789656; cv=none; b=IXpoG4zozk5LP/j5NECVAeuxrrjVgqKfstrgtPg85ylQK2ZE+bWO3VAfI8BUkN0o87vIovFpaDHqptJKPvUaPKqFZLVj/mImQJywoRmdBbE1uf2A/75lLUWW10QgbapvPDkEZMjIOmwLZ4ZL+5BR6djsi4nacf72xfPY9d4xL1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789656; c=relaxed/simple;
	bh=vDwFwAtBZOVv/LiDgNGup/VLBOobWxXV6QVTB8kVnNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD1vKs+budCErkkuQ5A/eH9B+tYmHoejNSndLN2dUYCjQzGLhZyMhy5BTI5V7eRkN6dQGUQcbRSekD7DfAXvzNKHDJPLIiHgE+hzjAD7pe9fjsxLm93nqsVjH/LaaVdbeBsqLOOzZm7XVCB1DMY1ltaU+A7omLoCc67K0TUjZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ6JJ8ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBF5C4CEDD;
	Wed, 12 Mar 2025 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741789656;
	bh=vDwFwAtBZOVv/LiDgNGup/VLBOobWxXV6QVTB8kVnNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQ6JJ8ih0IRaf49JNes3gyJbaHP43wrBhyc2ze6AYpSUd8kOVX6Kk8MO1ABtIeKjr
	 vPN9AekTQzOz3YQo6saoJeldSivUFWy2ihGCaaVWsqwEgDhG2KOwZL5GoU25GgCZBX
	 Rdy3qzgR7HlEkh9bV5uo4MVuXoVQVgEKJOnP+QeZtNeWpQSCaP2pOHGrdcYMemMhgZ
	 wpRzop5dH+xkGwBCtOio9LipaM6nK80coOnwqWgnTuAl+aeYnm7x68XgMOf/Un8KGi
	 Diuw0+rIi21I+RmVcJoOClRV+dasutb7AvjG/4CmDmzVK4DEiwwvwSH09pNOV30QqN
	 2CPcOdBlHLfqA==
Date: Wed, 12 Mar 2025 14:27:34 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chunhai Guo <guochunhai@vivo.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: fix missing discard candidates in fstrim
Message-ID: <Z9GZ1kg6VVMFpomb@google.com>
References: <20250312102005.2893698-1-guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312102005.2893698-1-guochunhai@vivo.com>

On 03/12, Chunhai Guo wrote:
> fstrim may miss candidates that need to be discarded, as shown in the
> examples below.
> 
> The root cause is that when cpc->reason is set with CP_DISCARD,
> add_discard_addrs() expects that ckpt_valid_map and cur_valid_map have
> been synced by seg_info_to_raw_sit() [1], and it tries to find the
> candidates based on ckpt_valid_map and discard_map. However,
> seg_info_to_raw_sit() does not actually run before
> f2fs_exist_trim_candidates(), resulting in the failure.

I think we need to fix the above logic.

> 
> The code logic can be simplified for all cases by finding all the
> discard blocks based only on discard_map. This might result in more
> discard blocks being sent for the segment during the first checkpoint
> after mounting, which were originally expected to be sent only in
> fstrim. Regardless, these discard blocks should eventually be sent, and
> the simplified code makes sense in this context.
> 
> root# cp testfile /f2fs_mountpoint
> 
> root# f2fs_io fiemap 0 1 /f2fs_mountpoint/testfile
> Fiemap: offset = 0 len = 1
>         logical addr.    physical addr.   length           flags
> 0       0000000000000000 0000000406a00000 000000003d800000 00001000
> 
> root# rm /f2fs_mountpoint/testfile
> 
> root# fstrim -v -o 0x406a00000 -l 1024M /f2fs_mountpoint -- no candidate is found
> /f2fs_mountpoint: 0 B (0 bytes) trimmed
> 
> Relevant code process of the root cause:
> f2fs_trim_fs()
>     f2fs_write_checkpoint()
>         ...
>         if (cpc->reason & CP_DISCARD) {
>                 if (!f2fs_exist_trim_candidates(sbi, cpc)) {
>                     unblock_operations(sbi);
>                     goto out; // No candidates are found here, and it exits.
>                 }
>             ...
>         }
> 
> [1] Please refer to commit d7bc2484b8d4 ("f2fs: fix small discards not
> to issue redundantly") for the relationship between
> seg_info_to_raw_sit() and add_discard_addrs().
> 
> Fixes: 25290fa5591d ("f2fs: return fs_trim if there is no candidate")
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
> v2->v3: Add f2fs_bug_on() to make sure it never issues discard to valid data's block address.
> v1->v2: Find all the discard blocks based only on discard_map in add_discard_addrs().
> v1: https://lore.kernel.org/linux-f2fs-devel/20250102101310.580277-1-guochunhai@vivo.com/
> ---
>  fs/f2fs/segment.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 86e547f008f9..c8ad8e3bfebb 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2075,7 +2075,6 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>  	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
>  	struct seg_entry *se = get_seg_entry(sbi, cpc->trim_start);
>  	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
> -	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
>  	unsigned long *discard_map = (unsigned long *)se->discard_map;
>  	unsigned long *dmap = SIT_I(sbi)->tmp_map;
>  	unsigned int start = 0, end = -1;
> @@ -2097,9 +2096,10 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>  	}
>  
>  	/* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
> -	for (i = 0; i < entries; i++)
> -		dmap[i] = force ? ~ckpt_map[i] & ~discard_map[i] :
> -				(cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
> +	for (i = 0; i < entries; i++) {
> +		dmap[i] = ~discard_map[i];
> +		f2fs_bug_on(sbi, (cur_map[i] ^ discard_map[i]) & cur_map[i]);
> +	}
>  
>  	while (force || SM_I(sbi)->dcc_info->nr_discards <=
>  				SM_I(sbi)->dcc_info->max_discards) {
> -- 
> 2.34.1

