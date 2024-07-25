Return-Path: <linux-kernel+bounces-261689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142FB93BADD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5351C21803
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 02:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B006A10A1A;
	Thu, 25 Jul 2024 02:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw02RJTB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31281103
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721874819; cv=none; b=FxVFdaa+rT2KRGQqkMzYINE73WD0vi7mBLL6X8bR1dOeA/K87W8v+FvCTo6COWVoW2/EBsKWxBNAXA2XvUnFHR7hlT1G8+GH4lnO8KjH1rH/edUi0iGK5FcC+Kkm5QyLrRHIWe4+Y34NOZN2vBGyYlUHyeSm58QywOp4cgIJKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721874819; c=relaxed/simple;
	bh=PQZIjRQ14ZLGYfnw6irHlNSMgZOp804K/+R3aCKG91M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmbBZbUeN314LStEmaAMdgnOSZ2JuYHM/fCFdRjBv2HmvAh20GXkYDtOwuC3rngThuWlROqwsy7Rf5Dc4PvB+HT+L4b0fAKYhtdB7LOQn7fAunm4J9uhc5XsF+TLc9KlcpgopO220NKTB+MrBN9BmaWCaEo6xZcz2SRHw41ZNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw02RJTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74A2C32781;
	Thu, 25 Jul 2024 02:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721874818;
	bh=PQZIjRQ14ZLGYfnw6irHlNSMgZOp804K/+R3aCKG91M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bw02RJTB1L5JdARw+1KG3yyHB6nOpMb1iCWPr53eyzYLdVmTdACpILMnL8tyIqzZX
	 FP5NEdGDsJGHPrOIeoZhU3+E8NUS0GUWqg+sHz9W1tEq4KCa0TPuLz0M0/RdgP5RpU
	 MFMBzFCGgPnLxpB8iWyXxMqCA5lYb9devCg7rxysIoVWPSwtJXQ1JVGmCK6Gwf8kMX
	 xE5GTXRp6gMnFpAL9bgZDrLVdjlkkdlgKyudZUvCPda35uxnCMjFvoF0CF5dXUA8+j
	 e/1ed9L0esr1/tsA4gKXw8cPjzMfaLsvFg5aC6BqkOR0A8QgJ6EvbSA+86LGER0MgQ
	 AEs4YMFeLRToA==
Message-ID: <fd64e14e-7a77-4fe4-9569-f7342c68953b@kernel.org>
Date: Thu, 25 Jul 2024 10:33:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dump.f2fs: add checkpoint version to dump_nat
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Wu Bo <wubo.oduw@gmail.com>
References: <20240724103543.2666271-1-bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240724103543.2666271-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/24 18:35, Wu Bo wrote:
> The cp_ver of node footer is useful when analyzing data corruption
> issues.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>   fsck/dump.c | 33 ++++++++++++++++++---------------
>   1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/fsck/dump.c b/fsck/dump.c
> index 8d5613e..ca38101 100644
> --- a/fsck/dump.c
> +++ b/fsck/dump.c
> @@ -21,7 +21,7 @@
>   #endif
>   #include <locale.h>
>   
> -#define BUF_SZ	80
> +#define BUF_SZ	256

128 is fine?

>   
>   /* current extent info */
>   struct extent_info dump_extent;
> @@ -38,6 +38,7 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
>   {
>   	struct f2fs_nat_block *nat_block;
>   	struct f2fs_node *node_block;
> +	struct node_footer *footer;
>   	nid_t nid;
>   	pgoff_t block_addr;
>   	char buf[BUF_SZ];
> @@ -47,6 +48,7 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
>   	ASSERT(nat_block);
>   	node_block = (struct f2fs_node *)calloc(F2FS_BLKSIZE, 1);
>   	ASSERT(node_block);
> +	footer = F2FS_NODE_FOOTER(node_block);
>   
>   	fd = open("dump_nat", O_CREAT|O_WRONLY|O_TRUNC, 0666);
>   	ASSERT(fd >= 0);
> @@ -54,6 +56,7 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
>   	for (nid = start_nat; nid < end_nat; nid++) {
>   		struct f2fs_nat_entry raw_nat;
>   		struct node_info ni;
> +		int len;
>   		if(nid == 0 || nid == F2FS_NODE_INO(sbi) ||
>   					nid == F2FS_META_INO(sbi))
>   			continue;
> @@ -66,15 +69,15 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
>   			ret = dev_read_block(node_block, ni.blk_addr);
>   			ASSERT(ret >= 0);
>   			if (ni.blk_addr != 0x0) {
> -				memset(buf, 0, BUF_SZ);
> -				snprintf(buf, BUF_SZ,
> +				len = snprintf(buf, BUF_SZ,
>   					"nid:%5u\tino:%5u\toffset:%5u"
> -					"\tblkaddr:%10u\tpack:%d\n",
> +					"\tblkaddr:%10u\tpack:%d"
> +					"\tcp_ver:0x%08x\n",
>   					ni.nid, ni.ino,
> -					le32_to_cpu(F2FS_NODE_FOOTER(node_block)->flag) >>
> -						OFFSET_BIT_SHIFT,
> -					ni.blk_addr, pack);
> -				ret = write(fd, buf, strlen(buf));
> +					le32_to_cpu(footer->flag) >> OFFSET_BIT_SHIFT,
> +					ni.blk_addr, pack,
> +					(uint32_t)le64_to_cpu(footer->cp_ver));

(uint64_t)le64_to_cpu(footer->cp_ver) ?

> +				ret = write(fd, buf, len);
>   				ASSERT(ret >= 0);
>   			}
>   		} else {
> @@ -87,15 +90,15 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
>   
>   			ret = dev_read_block(node_block, ni.blk_addr);
>   			ASSERT(ret >= 0);
> -			memset(buf, 0, BUF_SZ);
> -			snprintf(buf, BUF_SZ,
> +			len = snprintf(buf, BUF_SZ,
>   				"nid:%5u\tino:%5u\toffset:%5u"
> -				"\tblkaddr:%10u\tpack:%d\n",
> +				"\tblkaddr:%10u\tpack:%d"
> +				"\tcp_ver:0x%08x\n",
>   				ni.nid, ni.ino,
> -				le32_to_cpu(F2FS_NODE_FOOTER(node_block)->flag) >>
> -					OFFSET_BIT_SHIFT,
> -				ni.blk_addr, pack);
> -			ret = write(fd, buf, strlen(buf));
> +				le32_to_cpu(footer->flag) >> OFFSET_BIT_SHIFT,
> +				ni.blk_addr, pack,
> +				(uint32_t)le64_to_cpu(footer->cp_ver));

Ditto,

Thanks,

> +			ret = write(fd, buf, len);
>   			ASSERT(ret >= 0);
>   		}
>   	}

