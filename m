Return-Path: <linux-kernel+bounces-369585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713659A1F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2092F286144
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780D91D95BE;
	Thu, 17 Oct 2024 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKNLR4e/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6561199E92
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158876; cv=none; b=qtVbOUzamKnOAYBAd7k55lrqUIIuUnnTpSIeuIGOvJSUdw0pjWlaFdsW0eePBEmDwqRzMo/4A2YGZHQP7EhJ7tbi2iuLlIk5eMQx2Xfx58LuihezndzrdobI9Bg5tA0q3hvditovBNw6wbrA+rKNXUWgBTi0d05IcfP4Q4Fm7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158876; c=relaxed/simple;
	bh=CbWD0YTmgOCj8bDmWVAY5RoLXCa/dTfp/GhXgw7q7LA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U37Py7xRFXaFGkUkwzSrnspkKcFuWrgBNTQva6h5S4hYzARKmC80hlfPQg7NEGHn9fsC19UP+Al6zVKzjtGzyI30Bsu/JAvuv6KSJamlZEZDHrFeWW2Bb1joZHa2gcKA1AFq9EpcZvoY8RZSBnou9LJBxNV3IOh7Itjr9rWfby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKNLR4e/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E2DC4CEC3;
	Thu, 17 Oct 2024 09:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729158876;
	bh=CbWD0YTmgOCj8bDmWVAY5RoLXCa/dTfp/GhXgw7q7LA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SKNLR4e/PFr8aXXZpvI0dF9g7CdYU27JbgNbuWqf/IOqDeHWftHTpNMN9CkSS60r8
	 mLQMdVVqQrrWE4cmCeliO59E64r/kt+VW6tZ80/dMwz4NhEvEY8grw34YmwNFRoxFU
	 SMINof5a2+OByouiEzPlmq7CXFElqq24KwJQ6B+FQxpByxp+cy532Ls3A7TcrCkal1
	 OSxC3xxxMZaz4xIkWANArwY6Gu6r4bpaO8pqYSqV3omQaGxPjOIQp9CGDNrzgSHFD7
	 YCdS7KoNVKfM/QewzV0Ijbs+WkD0ZHF4zl4oJYkKfn+aZCVZxc7a3uiu24/VBu9ePV
	 80nF9P7HvX3NA==
Message-ID: <bdd890de-4794-4133-bca1-9c7e067e6e5c@kernel.org>
Date: Thu, 17 Oct 2024 17:54:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: modify f2fs_is_checkpoint_ready logic to allow more
 data to be written with the CP disable
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20241009102745.1390935-1-hanqi@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241009102745.1390935-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/9 18:27, Qi Han wrote:
> When the free segment is used up during CP disable, many write or
> ioctl operations will get ENOSPC error codes, even if there are
> still many blocks available. We can reproduce it in the following
> steps:
> 
> dd if=/dev/zero of=f2fs.img bs=1M count=55
> mkfs.f2fs -f f2fs.img
> mount f2fs.img f2fs_dir -o checkpoint=disable:10%
> cd f2fs_dir
> dd if=/dev/zero of=bigfile bs=1M count=50
> sync
> rm bigfile
> i=1; while [[ $i -lt 10000000 ]]; do (file_name=./file$i; dd \
> if=/dev/random of=$file_name bs=1M count=0); i=$((i+1)); done
> stat -f ./
> 
> In f2fs_need_SSR() function, it is allowed to use SSR to allocate
> blocks when CP is disabled, so in f2fs_is_checkpoint_ready function,
> can we judge the number of invalid blocks when free segment is not
> enough, and return ENOSPC only if the number of invalid blocks is
> also not enough?

Can you please try below patch?

 From 38b7c97dcc55ba83de4220c3dc54c2eb66148dd5 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Thu, 17 Oct 2024 17:07:05 +0800
Subject: [PATCH] f2fs: revalidate empty segment when checkpoint is disabled

If checkpoint is off, let's set segment as free once all newly
written datas were removed.

Signed-off-by: Chao Yu <chao@kernel.org>
---
  fs/f2fs/segment.c | 13 ++++++++++++-
  1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f8d6e601e084..9bad13d70afb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -853,6 +853,17 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
  	valid_blocks = get_valid_blocks(sbi, segno, false);
  	ckpt_valid_blocks = get_ckpt_valid_blocks(sbi, segno, false);

+	/*
+	 * If checkpoint is off, let's set segment as free once all newly
+	 * written datas were removed.
+	 */
+	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
+		valid_blocks == 0 && ckpt_valid_blocks == 0) {
+		__remove_dirty_segment(sbi, segno, DIRTY);
+		__set_test_and_free(sbi, segno, false);
+		goto out_lock;
+	}
+
  	if (valid_blocks == 0 && (!is_sbi_flag_set(sbi, SBI_CP_DISABLED) ||
  		ckpt_valid_blocks == usable_blocks)) {
  		__locate_dirty_segment(sbi, segno, PRE);
@@ -863,7 +874,7 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
  		/* Recovery routine with SSR needs this */
  		__remove_dirty_segment(sbi, segno, DIRTY);
  	}
-
+out_lock:
  	mutex_unlock(&dirty_i->seglist_lock);
  }

-- 
2.40.1

> 
> Signed-off-by: Qi Han <hanqi@vivo.com>
> ---
>   fs/f2fs/segment.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 71adb4a43bec..9bf0cf3a6a31 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -637,12 +637,33 @@ static inline bool has_enough_free_secs(struct f2fs_sb_info *sbi,
>   	return !has_not_enough_free_secs(sbi, freed, needed);
>   }
>   
> +static inline bool has_enough_available_blocks(struct f2fs_sb_info *sbi)
> +{
> +	unsigned int total_free_blocks = sbi->user_block_count -
> +					valid_user_blocks(sbi) -
> +					sbi->current_reserved_blocks;
> +
> +	if (total_free_blocks <= sbi->unusable_block_count)
> +		total_free_blocks = 0;
> +	else
> +		total_free_blocks -= sbi->unusable_block_count;
> +
> +	if (total_free_blocks > F2FS_OPTION(sbi).root_reserved_blocks)
> +		total_free_blocks -= F2FS_OPTION(sbi).root_reserved_blocks;
> +	else
> +		total_free_blocks = 0;
> +
> +	return (total_free_blocks > 0) ? true : false;
> +}
> +
>   static inline bool f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
>   {
>   	if (likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>   		return true;
>   	if (likely(has_enough_free_secs(sbi, 0, 0)))
>   		return true;
> +	if (likely(has_enough_available_blocks(sbi)))
> +		return true;
>   	return false;
>   }
>   


