Return-Path: <linux-kernel+bounces-286210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1999E95180C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1671C2112F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AEA19F461;
	Wed, 14 Aug 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzUw+7mT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB750269
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629013; cv=none; b=Ka1gxdbXqJC5zGIr0ju/RFy0n7wfPovfkVqgNX7EK8SgVTXC1FSkggLUz4QNnO/FAyOqnWpb0L7fcqjj1r4K+jBm4sFAD7I5G29z4PGutdpSd5tKE2lUWBod/zHGZ+33A9sLIu6uWud4jbW0IsPMqjvrbCwLhvf6Qd2EoLOrUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629013; c=relaxed/simple;
	bh=301oXL9Be4WKrU7++f6Fb1I0bax0v9/4TZOUrpwc8EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0UGn1G/7IdVaKuPrgVaoS9+cbe5WUIENJLlv8SQX1chU8D/v4up+j8A3nR1ggLas5yBgszjW+DVr1iDueg7wYAzGq/u1oNx7Dk3NqwuwrbFRy5Ir+w3l7l69J7HjKkppe5zTYDLFJ0Tvm1YpU3rCLOe1DpIM/yYUnk4nfhpcdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzUw+7mT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67578C4AF0D;
	Wed, 14 Aug 2024 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723629012;
	bh=301oXL9Be4WKrU7++f6Fb1I0bax0v9/4TZOUrpwc8EQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UzUw+7mTmb669Okkkwlh2k+AJ6DGA7yTXI2MzkMEdR+po0KDC6asCBgzLuACXYC70
	 YQ5I2rI2pNeY7FpSJ5HkVt0QWwZ1HlUmqStfJuLfo2u25XlDcNRULPWMyPafGQDSoL
	 AusP6SpSMxEgoCkSn8+Uy7zQJoCxIcC5Y5uV5nD/Jg+WOD7xcPkgls9sTT9o+GE/d6
	 QICdIYodf3+R0zdIYA5w8DpI7it8PWa1WpNRhnMLQTquRWAecKxyBnhKOSNVR1mGXf
	 xfb7cSoIjUUg1M0BC7Jq94T028APt0kDUr7xJaCBr+1eTcQCpaZqRXFqQ78gI4bPpB
	 PVBb7iFbJGqdw==
Message-ID: <7860b050-3948-4e23-b40f-a3df522477cd@kernel.org>
Date: Wed, 14 Aug 2024 17:50:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: avoid unused block when dio write in LFS mode
To: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Seokhwan Kim <sukka.kim@samsung.com>,
 Dongjin Kim <dongjin_.kim@samsung.com>,
 Yonggil Song <yonggil.song@samsung.com>,
 Jaeyoon Choi <j_yoon.choi@samsung.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Nayeon Kim <nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
References: <CGME20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b@epcms2p7>
 <20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b@epcms2p7>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240801074715epcms2p788934486cd0e8090f67ed0d7cffbc91b@epcms2p7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/1 15:47, Daejun Park wrote:
> This patch addresses the problem that when using LFS mode, unused blocks
> may occur in f2fs_map_blocks() during block allocation for dio writes.
> 
> If a new section is allocated during block allocation, it will not be
> included in the map struct by map_is_mergeable() if the LBA of the

I didn't get it, why below condition in map_is_mergeable() can not catch this
case? Can you please explain more?

	if (map->m_pblk != NEW_ADDR && blkaddr == (map->m_pblk + ofs))
		return true;

Thanks,

> allocated block is not contiguous. However, the block already allocated
> in this process will remain unused due to the LFS mode.
> 
> This patch avoids the possibility of unused blocks by escaping
> f2fs_map_blocks() when allocating the last block in a section.
> 
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>   fs/f2fs/data.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index b6dcb3bcaef7..b27a3f448f32 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1711,6 +1711,19 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>   		dn.ofs_in_node = end_offset;
>   	}
>   
> +	if (flag == F2FS_GET_BLOCK_DIO && f2fs_lfs_mode(sbi)) {
> +		int segno = GET_SEGNO(sbi, blkaddr);
> +		bool last_seg, last_blk;
> +
> +		last_seg = !((segno + 1) % SEGS_PER_SEC(sbi));
> +		last_blk = (f2fs_usable_blks_in_seg(sbi, segno) - 1) ==
> +				GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
> +
> +		/* LBA of the next block to be allocated may not be contiguous. */
> +		if (last_seg && last_blk)
> +			goto sync_out;
> +	}
> +
>   	if (pgofs >= end)
>   		goto sync_out;
>   	else if (dn.ofs_in_node < end_offset)


